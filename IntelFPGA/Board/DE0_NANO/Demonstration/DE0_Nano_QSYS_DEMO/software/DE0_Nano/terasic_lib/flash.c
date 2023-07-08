// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------

#include "terasic_includes.h"
#include "flash.h"


#ifdef DEBUG_FLASH
    #define FLASH_DEBUG(x)    DEBUG(x)  
#else
    #define FLASH_DEBUG(x)
#endif

typedef struct{
    alt_flash_fd* fd_flash;
    flash_region *regions_flash;
    int number_of_regions_flash;
}FLASH_INFO;



bool Flash_InfoDump(char *pFlashName){
    bool bSuccess = FALSE;
    flash_region *regions, *nextreg;
    alt_flash_fd* fd;
    int number_of_regions;
    int ret_code;
    /* Set write_data to all 0xa */
    FLASH_DEBUG(("Flash_InfoDump\r\n"));
    fd = alt_flash_open_dev(pFlashName);
    if (fd){
        ret_code = alt_get_flash_info(fd,&regions,&number_of_regions);
        if (ret_code == 0){
            int i;
            bSuccess = TRUE;
            nextreg = regions;
            FLASH_DEBUG(("number_of_regsion:%d\r\n", number_of_regions));
            for(i=0;i<number_of_regions;i++){
                FLASH_DEBUG(("regsion[%d]\r\n", i));
                FLASH_DEBUG(("  offset:%d\r\n", nextreg->offset));
                FLASH_DEBUG(("  region_size:%d\r\n", nextreg->region_size));
                FLASH_DEBUG(("  number_of_blocks:%d\r\n", nextreg->number_of_blocks));
                FLASH_DEBUG(("  block_size;:%d\r\n", nextreg->block_size));
                nextreg++;
            }                
        }else{
            FLASH_DEBUG(("alt_get_flash_info error, ret_code:%d fail\r\n", ret_code));
        }
        alt_flash_close_dev(fd);
    }else{
        FLASH_DEBUG(("alt_flash_open_dev fail\r\n"));
    }
    
    if (!bSuccess)        
        FLASH_DEBUG(("Flash_InfoDump fail\r\n"));

    return bSuccess;
    
}



FLASH_HANDLE Flash_Open(char *pFlashName){
    int error_code;
    bool bSuccess = FALSE;
    FLASH_INFO *pFlash=NULL;
    
    pFlash = (FLASH_INFO *)malloc(sizeof(FLASH_INFO));
    pFlash->fd_flash = alt_flash_open_dev(pFlashName);
    if (pFlash->fd_flash){
        error_code = alt_get_flash_info(pFlash->fd_flash,&pFlash->regions_flash,&pFlash->number_of_regions_flash);
        if (error_code == 0){
            bSuccess = TRUE;
        }            
    }
    
    if (!bSuccess){
        free(pFlash);
        pFlash= NULL;
    }        
    return pFlash;
            
}

bool Flash_Close(FLASH_HANDLE Handle){
    FLASH_INFO *pFlash = (FLASH_INFO *)Handle;
    if (pFlash->fd_flash){
        alt_flash_close_dev(pFlash->fd_flash);
    }
    free(Handle);
    return TRUE;
}

bool Flash_GetBlockInfo(FLASH_HANDLE Handle, alt_u16 block_index, alt_32 *poffset, alt_32 *psize){
    FLASH_INFO *pFlash = (FLASH_INFO *)Handle;
    alt_u32 offset=0, length;        
    int r, i, block_count=0;
    flash_region *nextreg = pFlash->regions_flash;
    bool bFind = FALSE;
    
    if (!pFlash->fd_flash)
        return FALSE;
    
    
    for(r=0;r<pFlash->number_of_regions_flash && !bFind;r++){
        for(i=0;i<nextreg->number_of_blocks;i++){
            if (block_count == block_index){
                bFind = TRUE;
                length = nextreg->block_size;
            }else{
                offset += nextreg->block_size;
                block_count++;
            }
        }
        nextreg++;
    }    
    if (bFind){
        *poffset = offset;
        *psize = length;
    }
    
    return bFind;
    
}

bool Flash_Read(FLASH_HANDLE Handle, alt_u32 offset, alt_u8 *szBuf, alt_u32 size){
    FLASH_INFO *pFlash = (FLASH_INFO *)Handle;
    int error_code;
    if (!pFlash->fd_flash)
        return FALSE;
    error_code = alt_read_flash(pFlash->fd_flash, offset, szBuf, size);
    if (error_code == 0)
        return TRUE;
    return FALSE;                    
    
}

bool Flash_Write(FLASH_HANDLE Handle, alt_u32 offset, alt_u8 *szData, alt_u32 size){
    FLASH_INFO *pFlash = (FLASH_INFO *)Handle;
    bool bSuccess = TRUE;
    int error_code;
    
    if (!pFlash->fd_flash)
        return FALSE;
    //FLASH_DEBUG(("Flash_Write, offset=%d, size=%d\r\n", offset, size));
#if 0
    error_code = alt_write_flash(fd_flash, offset, szData, size); // note. !!!! it will erase flash block content before write data
    if (error_code == 0){
        bSuccess = TRUE;
    }else{
        FLASH_DEBUG(("alt_write_flash fail, error_code=%d\r\n", error_code));
    }    
#else
    int block_offset, block_size, write_count, this_write_size, r, i;//, first_offset;        
    flash_region *nextreg = pFlash->regions_flash;

    
    block_offset = 0;
    write_count = 0;
    for(r=0;r<pFlash->number_of_regions_flash && bSuccess;r++){
        for(i=0;i<nextreg->number_of_blocks && bSuccess;i++){
            block_size = nextreg->block_size;
//            FLASH_DEBUG(("block_offset=%d, block_size=%d\r\n", block_offset, block_size));
//            if ((offset >= block_offset) && ((offset+size) <= (block_offset + block_size))){
            if (((offset+write_count) >= block_offset) && (write_count < size)){
                // write
                this_write_size = size - write_count;
                if (write_count == 0){
                    // first block
                    if (this_write_size > (block_offset + block_size - offset))
                        this_write_size = block_offset + block_size - offset;
                }else{
                    // block aligement
                    if (this_write_size > block_size)
                        this_write_size = block_size;
                }        
                error_code = alt_write_flash_block(pFlash->fd_flash, block_offset, offset+write_count, szData+write_count, this_write_size);
                //FLASH_DEBUG(("alt_write_flash_block, block_offset:%d, offset:%d, len:%d, this block_size:%d\r\n", block_offset, offset+write_count, this_write_size, block_size));
                if (error_code != 0){
                    bSuccess = FALSE;
                    FLASH_DEBUG(("alt_write_flash_block fail, error_code=%d\r\n", error_code));
                }    
                write_count += this_write_size;
            }
            block_offset += block_size;
        }
        nextreg++;
    }      
#endif      
        
/*        
    error_code = alt_write_flash(fd_flash, offset, szData, size); // it will erase flash block content before write data
//    error_code = alt_write_flash_block(fd_flash, offset, offset+size, szData, size); // it will preserve flash content
    if (error_code == 0)
        return TRUE;
*/        
    return bSuccess;                    
}

bool Flash_Erase(FLASH_HANDLE Handle, alt_u16 block_index){
    FLASH_INFO *pFlash = (FLASH_INFO *)Handle;
    if (!pFlash->fd_flash)
        return FALSE;
    alt_u32 offset;
    alt_u32 length;        
    int error_code;
    bool bSuccess = FALSE;

    
    if (Flash_GetBlockInfo(Handle, block_index, &offset, &length)){
        error_code = alt_erase_flash_block(pFlash->fd_flash, offset, length);
        //DEBUG_FLASH("Erase block[%d], offset=%Xh, lenght=%Xh", block_no, offset, length);
        if (error_code == 0)
            bSuccess = TRUE;
    }        
    
    return bSuccess;    
}

alt_u16 Flash_GetBlockCount(FLASH_HANDLE Handle){
    FLASH_INFO *pFlash = (FLASH_INFO *)Handle;    
    alt_u16 no=0;
    flash_region *nextreg = pFlash->regions_flash;
    int r;
    for(r=0;r<pFlash->number_of_regions_flash;r++){
        no += nextreg->number_of_blocks;
        nextreg++;
    }
    return no;
}


alt_u32 Flash_Size(char *pFlashName){
    alt_u32 FlashSize = 0;
    flash_region *regions, *nextreg;
    alt_flash_fd* fd;
    int number_of_regions;
    int ret_code, i;
    /* Set write_data to all 0xa */
    fd = alt_flash_open_dev(pFlashName);
    if (fd){
        ret_code = alt_get_flash_info(fd,&regions,&number_of_regions);
        if (ret_code == 0 && number_of_regions >= 1){
            nextreg = regions;
            for(i=0;i<number_of_regions;i++){
                FlashSize += nextreg->region_size;
                nextreg++;
            }
        }
        alt_flash_close_dev(fd);
    }
    return FlashSize;
}    



// bQuick=TRUE: just check first and last block 
bool FLASH_Verify(char *pFlashName, alt_u8 InitValue, bool bShowMessage, bool bQuickVerify){
    bool bPass = TRUE;
    int i, k, BlockNum;
    FLASH_HANDLE hFlash;
    alt_u32 Offset, Size;
    alt_u8 *pBuf, Cnt;
    const int nBufSize = 8*1024; // 16K
    int nWriteSizeSum, nWriteSize;
    int nReadSizeSum, nReadSize;
    
    hFlash = Flash_Open(pFlashName);
    if (!hFlash){
        if (bShowMessage)
            printf("Failed to open flash.\r\n");
        return FALSE;
    }        
        
        
    BlockNum = Flash_GetBlockCount(hFlash);
    
    //===== alloc buffer
    pBuf = (alt_u8 *)malloc(nBufSize);
    if (!pBuf){
        if (bShowMessage)
            printf("[Error] Failed to alloc memory.\r\n");
        return FALSE;
    }        
    
    
    //===== erase
    for(i=0;i<BlockNum && bPass;i++){
        if (bQuickVerify && (i !=0 )&& (i != (BlockNum-1)))
            continue;
        bPass = Flash_Erase(hFlash, i);
        if (bShowMessage){
            if (!bPass)
                printf("[Error] Failed to erase flash block %d/%d\r\n.\r\n", i, BlockNum);
            else
                printf("Erase Block %d/%d\r\n", i, BlockNum);
        }            
    }        
    
    //===== write
    if (bPass){
        Cnt = InitValue;
        for(i=0;i<BlockNum && bPass;i++){
            if (bQuickVerify && (i !=0 )&& (i != (BlockNum-1)))
                continue;
            
            bPass = Flash_GetBlockInfo(hFlash, i, &Offset, &Size);
            if (!bPass)
                continue;
                
            if (bShowMessage)            
                printf("Write Block[%d/%d], size=%d\r\n", i, BlockNum, (int)Size);
            nWriteSizeSum = 0;
            while(nWriteSizeSum < Size && bPass){
                // cal write size
                nWriteSize = nBufSize;
                if (nWriteSize > (Size - nWriteSizeSum))
                    nWriteSize = Size - nWriteSizeSum;
                // fill data
                for(k=0;k<nWriteSize;k++){
                    *(pBuf+k) = Cnt++;
                }                     
                // write data block
                bPass = Flash_Write(hFlash, Offset+nWriteSizeSum, pBuf, nWriteSize);
                if (bShowMessage && !bPass)            
                    printf("[Error] Write Block[%d/%d] NG\r\n", i, BlockNum);
                //
                usleep(20*1000);
                //
                nWriteSizeSum += nWriteSize;
            }
        }
    }
  
    if (bPass){
        if (bShowMessage)      
            printf("alt_dcache_flush_all\r\n");
        alt_dcache_flush_all();
    }        
      
    //===== read & verify
    if (bPass){
        Cnt = InitValue;
        for(i=0;i<BlockNum && bPass;i++){
            if (bQuickVerify && (i !=0 )&& (i != (BlockNum-1)))
                continue;
            
            bPass = Flash_GetBlockInfo(hFlash, i, &Offset, &Size);
            if (!bPass){
                if (bShowMessage)      
                    printf("[Error] Flash_GetBlockInfo at block %d\r\n", i);
                continue;
            }    
            if (bShowMessage)            
                printf("Read Block[%d/%d], size=%d\r\n", i, BlockNum, (int)Size);
            nReadSizeSum = 0;
            while(nReadSizeSum < Size && bPass){
                // cal write size
                nReadSize = nBufSize;
                if (nReadSize > (Size - nReadSizeSum))
                    nReadSize = Size - nReadSizeSum;
                    
                // read data block
                bPass = Flash_Read(hFlash, Offset+nReadSizeSum, pBuf, nReadSize);
                if (!bPass){
                    if (bShowMessage)      
                        printf("[Error] Flash_Read fail at block-offset %d-%d\r\n", i, (int)Offset+nReadSizeSum);
                }else{
                    // verify
                    // verify data
                    for(k=0;k<nReadSize && bPass;k++){
                        if (*(pBuf+k) != Cnt){
                            if (bShowMessage)      
                                printf("[Error] Verify fail, block:%d, index:%d, read=%Xh, expected=%Xh\r\n", i, nReadSizeSum+k, *(pBuf+k), Cnt);
                            bPass = FALSE;
                        }else{    
                            Cnt++;
                        }
                    }                     
                }                        
                //
                nReadSizeSum += nReadSize;
            }
        }  
    }
    
    if (pBuf)
        free(pBuf);
    
    if (hFlash)
        Flash_Close(hFlash);
    
    //
    return bPass;
}
