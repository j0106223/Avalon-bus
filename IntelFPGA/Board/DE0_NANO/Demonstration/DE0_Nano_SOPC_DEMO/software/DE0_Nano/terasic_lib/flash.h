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

#ifndef FLASH_H_
#define FLASH_H_




typedef void *FLASH_HANDLE;    


bool Flash_InfoDump(char *pFlashName);

FLASH_HANDLE Flash_Open(char *pFlashName);
bool Flash_Close(FLASH_HANDLE Handle);
bool Flash_GetBlockInfo(FLASH_HANDLE Handle, alt_u16 block_index, alt_32 *poffset, alt_32 *psize);  // zero base index
bool Flash_Read(FLASH_HANDLE Handle, alt_u32 offset, alt_u8 *szBuf, alt_u32 size);
bool Flash_Write(FLASH_HANDLE Handle, alt_u32 offset, alt_u8 *szData, alt_u32 size);
bool Flash_Erase(FLASH_HANDLE Handle, alt_u16 block_index); // zero base index
alt_u16 Flash_GetBlockCount(FLASH_HANDLE Handle);
alt_u32 Flash_Size(char *pFlashName);

// bQuick=TRUE: just check first and last block 
bool FLASH_Verify(char *pFlashName, alt_u8 InitValue, bool bShowMessage, bool bQuickVerify);


#endif /*FLASH_H_*/

