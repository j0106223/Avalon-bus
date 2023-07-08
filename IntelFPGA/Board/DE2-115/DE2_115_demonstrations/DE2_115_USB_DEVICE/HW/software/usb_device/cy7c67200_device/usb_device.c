
#include "usb_device.h"
#include "usb_hal.h"
#include "67200.h"
#include "67200_cmd_data.h"

/** local definitions **/
#ifdef DEBUG_USBDEV
    #define DEBUG_OUT(format, arg...) {printf("[USBD]");printf(format, ## arg);}
    #define DEBUG_ERR(format, arg...) {printf("[USBD_ERR]");printf(format, ## arg);}
#else
    #define DEBUG_OUT(format, arg...) 
    #define DEBUG_ERR(format, arg...)
#endif   

/** local variable **/

DEVICE_STATUS device_status;


void dc_init_struct(void)
{
    device_status.hpi_status = 0; 
    device_status.bEP1InTransfer = FALSE;
    device_status.bEP2InTransfer = FALSE;
    device_status.EP1_Transfer_Timeout = 0;
    device_status.bEP1_Transfer_Judge = FALSE;
}

void dc_clear_bug(void)
{
            DEBUG_OUT("Clear up the interrupt\r\n");
            alt_u16 intStat;
            hpi_read_mbx();
            hpi_read_status();

            // Had to add the write due to a bug in BIOS where they overwrite
            // the mailbox after initialization with garbage.  The read clears
            // any pending interrupts.
             hpi_read_reg (HPI_SIE1_MSG_ADR, &intStat);
             hpi_write_reg (HPI_SIE1_MSG_ADR, 0);
            hpi_read_reg (HPI_SIE2_MSG_ADR, &intStat);
            hpi_write_reg (HPI_SIE2_MSG_ADR, 0);

            hpi_write_reg (HOST1_STAT_REG, 0xFFFF);
            hpi_write_reg (HOST2_STAT_REG, 0xFFFF);   
}


/*
 *  FUNCTION: dc_download
 *
 *  PARAMETERS:
 *    download_data        
 *
 *  DESCRIPTION:
 *    This function downloads code to the ASIC.
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
int dc_download(char * download_data,int max_try)
{
    DEBUG_OUT("+ dc_download ---- \n");
    int try_i=0;
    int response = ERROR;
    unsigned short address;
    unsigned short download_length;   

    while((try_i<max_try)&&(response == ERROR)){

       /* Download asm code array to ASIC RAM  */
       if (download_data != NULL) {
           dc_clear_bug();

          /* Org address */
          address = get_ushort(download_data, 0xe);

          download_length = get_ushort(download_data, 0xb) - 2;

          DEBUG_OUT("dc_download: address=0x%x, download_length=0x%x\r\n", address, download_length);

          if ((response = dc_download_code(address, download_length,
                              &download_data[16] )) == ERROR) 
           {
             DEBUG_ERR("dc_download: download error,  try_count=%d\r\n",try_i);
           }else{
               goto _Finished_Download;
           }
    
         } else {
            DEBUG_OUT("dc_download:Null Code--Nothing had being download to the ASIC Ram!!");
            response = ERROR;
      }
       try_i++;
       usleep(10000);
    }
_Finished_Download:
    DEBUG_OUT("- dc_download ---- \n");
return response;


}

/*
 *  FUNCTION: dc_download_code
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *    byte_length     - Length of data to download (write)
 *    data            - Data to download pointer
 *
 *  DESCRIPTION:
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */

int dc_download_code(unsigned short chip_addr,
                      int byte_length,
                      char * data)
{
    int response = ERROR;

    if (byte_length > 0) {

        response = hpi_write_memory(chip_addr, data,byte_length);
        char *cmpdata;
        cmpdata = malloc(byte_length);
        hpi_read_memory(chip_addr,cmpdata,byte_length);
        int  i;
        bool data_checker = TRUE;
        for(i=0;i<byte_length; i++)
        {
         if(*(data+i) != *(cmpdata+i)) {
            //DEBUG_OUT("err[%d]: wrdata:0x%02X,rddata :0x%02X\n",i,(char)*(data+i),(char)*(cmpdata+i));
           // DEBUG_OUT("err[%d],",i);
            data_checker =  FALSE ;
            response     =  ERROR;
            }
        }

       free(cmpdata);

       if( data_checker == FALSE )
       {
        DEBUG_ERR("Data Checker ERROR! \n");
       }

       if ( response == SUCCESS) {
           
             //COMM_JUMP2CODE flag,it will be cleared when mailbox Ack
              hpi_write_reg(COMM_CODE_ADDR, chip_addr);

              response = hpi_command(COMM_JUMP2CODE);
          }
    }
    return response;
}

int hpi_command( unsigned short cmd)
{ 
	alt_u32 Timeout;
    alt_u16 IntStat;
    
    IntStat= hpi_read_status();  // clear interrupt status register
    
    device_status.hpi_status |= IntStat; //record into hpi_status
    
    hpi_write_mbx(cmd);
       
       IntStat= hpi_read_status();      
          device_status.hpi_status |= IntStat;   //record into hpi_status

      Timeout = alt_nticks() + alt_ticks_per_second();
      while(((IntStat& MBX_OUT_FLG) == 0)&&(alt_nticks() < Timeout))
      {
          IntStat= hpi_read_status();      
          device_status.hpi_status |= IntStat;   //record into hpi_status
       }

        return (( hpi_read_mbx() == COMM_ACK) ? SUCCESS : ERROR );
}
//int hpi_command( unsigned short cmd )
//{
//    hpi_read_status();  // clear interrupt status register
//
//    hpi_write_mbx(cmd);
//
//        while( (hpi_read_status() & MBX_OUT_FLG) == 0 );
//
//        return ( (hpi_read_mbx() == COMM_ACK) ? SUCCESS : ERROR );
//}
//


//
///*
// *  FUNCTION: lcp_command
// *
// *  PARAMETERS:
// *    pdc            data structure pointer
// *
// *  DESCRIPTION:
// *     send lcp command
// *
// *  RETURNS: 
// *    SUCCESS         - Success
// *    ERROR           - Failure
// */
//int lcp_command(DEVICE_INFO * pdc)
//{
//    int response = SUCCESS;
//
//    DEBUG_OUT("lcd_start_lcp enter\r\n");
//    /* Handle command */
//    switch (pdc->lcp_command) {
//        case COMM_RESET:
//            /* Send CMD */
//            hpi_write_mbx(COMM_RESET);
//            break;
//
//        case COMM_JUMP2CODE:
//            /* Set Jump Address */
//            hpi_write_reg(COMM_CODE_ADDR, pdc->arg[0]);
//
//            /* Send CMD */
//            hpi_write_mbx(COMM_JUMP2CODE);
//            break;
//
//        case COMM_CALL_CODE:
//            /* Set Call Address */
//            hpi_write_reg(COMM_CODE_ADDR, pdc->arg[0]);
//
//            /* Send CMD */
//            hpi_write_mbx(COMM_CALL_CODE);
//            break;
//
//        case COMM_WRITE_CTRL_REG:
//            /* Set Control Reg Address */
//            hpi_write_reg(COMM_CTRL_REG_ADDR, pdc->arg[0]);
//
//            /* Set Value */
//            hpi_write_reg(COMM_CTRL_REG_DATA, pdc->arg[1]);
//
//            /* Set flag */
//            hpi_write_reg(COMM_CTRL_REG_LOGIC, pdc->arg[2]);
//
//            /* Send CMD */
//            hpi_write_mbx(COMM_WRITE_CTRL_REG);
//            break;
//
//        case COMM_READ_CTRL_REG:
//            /* Set Control Reg Address */
//            hpi_write_reg(COMM_CTRL_REG_ADDR, pdc->arg[0]);
//
//            /* Send CMD */
//            hpi_write_mbx(COMM_READ_CTRL_REG);
//            break;
//
//        case COMM_EXEC_INT:
//            /* Set Int Number */
//            hpi_write_reg(COMM_INT_NUM, pdc->arg[0]);
//
//            /* Set Register values */
//            hpi_write_reg(COMM_R0, pdc->arg[1]);
//            hpi_write_reg(COMM_R1, pdc->arg[2]);
//            hpi_write_reg(COMM_R2, pdc->arg[3]);
//            hpi_write_reg(COMM_R3, pdc->arg[4]);
//            hpi_write_reg(COMM_R4, pdc->arg[5]);
//            hpi_write_reg(COMM_R5, pdc->arg[6]);
//            hpi_write_reg(COMM_R6, pdc->arg[7]);
//            hpi_write_reg(COMM_R7, pdc->arg[8]);
//            hpi_write_reg(COMM_R8, pdc->arg[9]);
//            hpi_write_reg(COMM_R9, pdc->arg[10]);
//            hpi_write_reg(COMM_R10, pdc->arg[11]);
//            hpi_write_reg(COMM_R11, pdc->arg[12]);
//            hpi_write_reg(COMM_R12, pdc->arg[13]);
//            hpi_write_reg(COMM_R13, pdc->arg[14]);
//    
//            /* Send CMD */
//            hpi_write_mbx(COMM_EXEC_INT);
//            break;
//
//        case COMM_READ_XMEM:
//            /* Send CMD */
//            hpi_write_mbx(COMM_READ_XMEM);
//            break;
//
//        case COMM_WRITE_XMEM:
//            /* Send CMD */
//            hpi_write_mbx(COMM_WRITE_XMEM);
//            break;
//        case COMM_READ_MEM:
//        case COMM_WRITE_MEM:
//            /* NOP for HPI */
//            break;
//        
//        default:
//            /* Indicate error */
//            response = ERROR;
//          DEBUG_OUT("lcp_command: error unknown LCP command 0x%4X\n",pdc->lcp_command);
//          break;
//    }
//
//    return(response);
//}
//

int usb_send_data(
                  unsigned short endpoint,
                  unsigned short send_buffer_location,
                  unsigned char * data,  // 
                  int byte_length
                  )

{
    int response = ERROR;
    if(endpoint == 1) {
  
       if(device_status.bEP1InTransfer == FALSE) {     
         
//           device_status.bEP1InTransfer = TRUE; 
       //you can set bEP1InTransfer TRUE when you want to make sure this transaction to finish
       //then you also need to do something when  you need to send data while endpoint is in transfer (list to send ??)
       
              TRANSFER_FRAME frame;
    
              frame.wNextLink = 0;
              frame.wAddress = send_buffer_location;
              frame.wLength  = byte_length; 
              frame.wCallBack = 0;
    
              /* write the data to the RAM buffer */
              hpi_write_memory(send_buffer_location,(char *)data,byte_length);
    
              /* Write control structure to the RAM buffer */
              hpi_write_memory(EP1_TRANSFER_STRUCT_ADDRESS,(char*)&frame,sizeof(TRANSFER_FRAME));
           
             //execute SUSB2_SEND_INT
                hpi_write_reg(COMM_INT_NUM,SUSB2_SEND_INT);
    
                /* Set Register values */
                hpi_write_reg(COMM_R0, 0);
                hpi_write_reg(COMM_R1, endpoint&0x000f);
                hpi_write_reg(COMM_R8, EP1_TRANSFER_STRUCT_ADDRESS);
          
                response = hpi_command(COMM_EXEC_INT);
            
              if(response == SUCCESS){ DEBUG_OUT("send success!\n");
              device_status.bEP1InTransfer = TRUE;
              }
              else   { DEBUG_OUT("send failed!\n");}
              
         }else {
          // Add some code to queue the send progress
       //  DEBUG_OUT("usb_send_data: ep1 is in transaction ,waiting for finish!\n");
         }
    }
    else{
     // Do something here for other endpoint 
    // DEBUG_OUT("usb_send_data: endpoint %d. Nothing had beeing done!\n",endpoint);
    }
   return response ;
}


/*
 *  FUNCTION: usb_receive_data
 *
 *  PARAMETERS:   
 *
 *  DESCRIPTION:
 *    enable enpoint to receive data
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */

int usb_enable_receive_data(
                  unsigned short endpoint,
                  unsigned short receive_buffer_location,
                  int byte_length
                  )

{
    int response = ERROR;
        if(endpoint == 2) {
  
       if(device_status.bEP2InTransfer == FALSE) {   
        
//            device_status.bEP2InTransfer = TRUE;
      
            TRANSFER_FRAME frame;
            
            frame.wNextLink = 0;
            frame.wAddress = receive_buffer_location;
            frame.wLength  = byte_length;
            frame.wCallBack = 0;
            
           
            /* Write control structure to the RAM buffer */
            hpi_write_memory(EP2_TRANSFER_STRUCT_ADDRESS,(char*)&frame,sizeof(TRANSFER_FRAME));
                   
                 //execute SUSB2_SEND_INT
                hpi_write_reg(COMM_INT_NUM,SUSB2_RECEIVE_INT);
    
                /* Set Register values */
                hpi_write_reg(COMM_R0, 0);
                hpi_write_reg(COMM_R1, endpoint&0x000f);
                hpi_write_reg(COMM_R8, EP2_TRANSFER_STRUCT_ADDRESS);
          
                response = hpi_command(COMM_EXEC_INT);
                if(response == SUCCESS) {DEBUG_OUT("receive enable success!\n");}
                else  { DEBUG_OUT("Receive enable failed!\n");}
       }else{
         DEBUG_OUT("usb_receive_data: ep2 is enabled!\n");
         }
    }
    else{
     // Do something here for other endpoint 
     DEBUG_OUT("usb_receive_data: endpoint %d. Nothing had being done!\n",endpoint);
    }  
       

   return response ;
}


