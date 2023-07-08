// --------------------------------------------------------------------
// Copyright (c) 2011 by Terasic Technologies Inc. 
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
//
// Major Functions:  USB device process code
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Dee Zeng          :| 07/05/2011:| Initial Revision
// --------------------------------------------------------------------
#include "./../terasic_includes.h"
#include "usb_device.h"
#include "usb_hal.h"
#include "67200_cmd_data.h"
#include "67200.h"
#include "usb_device_control.h"
#include "./../LCD.h"
#include "sys/alt_alarm.h" // time tick function (alt_nticks(), alt_ticks_per_second())

extern DEVICE_STATUS device_status;

OUT_PACKET old_button_sw_status;

#ifdef DEBUG_USBDEV_CTL
    #define DEBUG_OUT(format, arg...) { {printf("[USBDC]");printf(format, ## arg);}}
    #define DEBUG_ERR(format, arg...) {{printf("[USBDC_ERR]");printf(format, ## arg);}}
#else
    #define DEBUG_OUT(format, arg...) 
    #define DEBUG_ERR(format, arg...)
#endif   

/** internal functions **/
static void ep2_isr(void);

/*
 *  FUNCTION: dcProcessEvent
 *
 *  PARAMETERS:   void
 * 
 *  DESCRIPTION:
 *    This function read the SIE2 MSG and hanlder it
 *
 *  RETURNS:  void
 */
void dcProcessEvent(void){
      /*******************************************************
       *  The interrupt (HPI_INT) flow
       *  1 : interrupt occured
       *  2 : read the  HPI interrupt status register
       *  3 : handle it according it 
       *  3.1 :  MBX_OUT_FLG   it indicates there is mailbox msg
       *        so read mailbox and handle it 
       *  3.2 :  SIE2MSG     it indicates there is SIE2 msg
       *      so read SIE2 msg register and handle it
       *  3.x   others  
       */
       
        // a loop checker is enough in this demo
                    alt_u16 message;
                    // See which endpoint is interrupting
                    hpi_read_reg(HPI_SIE2_MSG_ADR,(alt_u16 *)&message);
                    
                    if(message)  hpi_write_reg(HPI_SIE2_MSG_ADR, 0);  //clear the sie mailbox
                    
                    //handle which necessary
                    message &= (SUSB_EP1_MSG | SUSB_EP2_MSG | SUSB_RST_MSG | SUSB_CFG_MSG | SUSB_CLASS_MSG | SUSB_SUS_MSG);
                  
                    if(message) 
                    {
                        sie2_msg_handler( message); //loop while msg = 0
                    }

}
                    





/*
 *  FUNCTION: sie2_msg_handler
 *
 *  PARAMETERS:   message
 * 
 *  DESCRIPTION:
 *    This function  handle the SIE2 message
 *
 *  RETURNS:  void
 */
void sie2_msg_handler(unsigned short message)
{
  alt_u32 Timeout;
	  while(message) {
       
            if(message & SUSB_RST_MSG)
             {
              DEBUG_OUT("[sie2 msg]:SUSB_RST_MSG\n");


       	         Timeout = alt_nticks() + alt_ticks_per_second()/3;
                 while((hpi_command(COMM_RESET)!= SUCCESS)&&  alt_nticks()<Timeout){
           	        usleep(1000)  ;
                 }
                 if(alt_nticks()>Timeout){
           	          DEBUG_OUT("device COMM_RESET failed\n");
                 }else{
           	          DEBUG_OUT("device COMM_RESET success !!\n");
                 }
             }
             if(message & SUSB_SOF_MSG)
             {
              DEBUG_OUT("[sie2 msg]:SUSB_SOF_MSG\n");
              // do something
             }
             
            if(message & SUSB_CFG_MSG)
               {
               DEBUG_OUT("[sie2 msg]:SUSB_CFG_MSG\n");
               
               dc_init_struct();
             
               //Lcd show default words
               LCD_Test();
               
               //SEG7_8 show default values
               IOWR(SEG7_DISPLAY_BASE,0,0); 
               
               //LED  all turn off
               IOWR(LED_GREEN_BASE,0,0);
               IOWR(LED_RED_BASE, 0 ,0);
               
               old_button_sw_status.button = IORD(BUTTON_PIO_BASE,0)&BUTTON_FLAG;
               old_button_sw_status.sw  =  IORD(SWITCH_PIO_BASE,0)&SW_FLAG;
                              
               usb_enable_receive_data(2,EP2_RECEIVE_BUF_ADDRESS,EP2_DATA_DEFAULT_LEN);

               usb_send_data(1,EP1_SEND_BUF_ADDRESS,(char *)&old_button_sw_status,sizeof(OUT_PACKET)); // send switch and button status to pc
              }

         if(message & SUSB_SUS_MSG)
           {
            DEBUG_OUT("[sie2 msg]:SUSB_SUS_MSG\n");
            // do something
           }
       
       
           if(message & SUSB_EP0_MSG)
            {
              DEBUG_OUT("[sie2 msg]:ep0 msg\n");
              /* ignore ep0 */
            }
           if(message & SUSB_EP1_MSG)
            {
              DEBUG_OUT("[sie2 msg]: ep1 msg: data had been received by host\n");
              device_status.bEP1InTransfer = FALSE ;
            }
           if(message & SUSB_EP2_MSG)
            {
              DEBUG_OUT("[sie2 msg]:ep2 msg: receiving host data \n");
              device_status.bEP2InTransfer = FALSE ;
              ep2_isr();
              usb_enable_receive_data(2,EP2_RECEIVE_BUF_ADDRESS,EP2_DATA_DEFAULT_LEN);
            }
              if(message & SUSB_EP3_MSG)
            {
              DEBUG_OUT("[sie2 msg]:ep3 msg\n");
              // do something
            }
               if(message & SUSB_EP4_MSG)
            {
              DEBUG_OUT("[sie2 msg]:ep4 msg\n");
              // do something
            }
           if(message & SUSB_EP5_MSG)
            {
              DEBUG_OUT("[sie2 msg]:ep5 msg\n");
              // do something
            }
              if(message & SUSB_EP6_MSG)
            {
              DEBUG_OUT("[sie2 msg]:ep6 msg\n");
              // do something
            }
            if(message & SUSB_EP7_MSG)
            {
              DEBUG_OUT("[sie2 msg]:ep7 msg\n");
              // do something
            }

              hpi_read_reg(HPI_SIE2_MSG_ADR,(alt_u16 *)&message);
              
              if(message)  hpi_write_reg(HPI_SIE2_MSG_ADR, 0);
              
              message &= (SUSB_EP1_MSG | SUSB_EP2_MSG | SUSB_RST_MSG | SUSB_CFG_MSG | SUSB_CLASS_MSG | SUSB_SUS_MSG);
       }
}


/*
 *  FUNCTION: ep2_isr
 *
 *  PARAMETERS:   void
 * 
 *  DESCRIPTION:
 *    This function  handle the endpoint 2 packet
 *
 *  RETURNS:  void
 */
 void ep2_isr(void)
 {
    /*****************************************************************
     * endpoint 2 OUT(host to device ) data form
     *     1 word type    |   data packet
     * ---------------------------------------
     *      LED_DISPLAY   +   LED_PACKET
     *      LCD_DISPLAY   +   LCD_PACKET
     *    SEG7_8_DISPLAY  +   SEG7_8_PACKET
     * -----------------------------------------
     *****************************************************************/

   alt_u16 Rx_type; 
   
   Rx_type = hpi_read_word(EP2_RECEIVE_BUF_ADDRESS); // read the first word, we defined as type
   
    switch( Rx_type )    {
        
        case LED_DISPLAY:
         {     DEBUG_OUT(" Recevie led packet!\n");
             LED_PACKET led_packet;
          
          hpi_read_memory(EP2_RECEIVE_BUF_ADDRESS+2,(char *)&led_packet,sizeof(LED_PACKET));
          
          // change the led status
          IOWR(LED_GREEN_BASE,0,led_packet.ledg&LEDG_FLAG);
          
          IOWR(LED_RED_BASE, 0 , led_packet.ledr&LEDR_FLAG);
         
         break;}
         
          case LCD_DISPLAY:
         { 
            DEBUG_OUT(" Recevie lcd packet!\n");
            LCD_PACKET lcd_packet;
          
          hpi_read_memory(EP2_RECEIVE_BUF_ADDRESS+2,(char *)&lcd_packet,sizeof(LCD_PACKET));
          
          // change the lcd status
               LCD_Line1();
              //  Show Text to LCD
              LCD_Show_Text(lcd_packet.Text1);
              //  Change Line2
              LCD_Line2();
              //  Show Text to LCD
              LCD_Show_Text(lcd_packet.Text2);
          break;}
          
          case SEG7_8_DISPLAY:
              {
                 DEBUG_OUT(" Recevie seg7_8 packet!\n");
                 SEG7_8_PACKET seg7_8_packet;
                 
                 hpi_read_memory(EP2_RECEIVE_BUF_ADDRESS+2,(char *)&seg7_8_packet,sizeof(SEG7_8_PACKET));
                
                 // seg7_8 display
                 IOWR(SEG7_DISPLAY_BASE,0,seg7_8_packet.seg7_8_value&0xFFFFFFFF); 
          
                break;
              }
          
         default :
         {  DEBUG_OUT("Unknow Rx transfer type[0x%02X] !\n",Rx_type);
          break;
          }
      }
 
 }


 
void check_button_sw_status(void)
{
    OUT_PACKET button_sw_status;

   button_sw_status.button = IORD(BUTTON_PIO_BASE,0)&BUTTON_FLAG;
   button_sw_status.sw  =  IORD(SWITCH_PIO_BASE,0)&SW_FLAG;
   
   if( (old_button_sw_status.button != button_sw_status.button)
		   || (old_button_sw_status.sw != button_sw_status.sw)
		   )
   {


	   if(device_status.bEP1InTransfer == FALSE) {

    	old_button_sw_status.button = button_sw_status.button;
        old_button_sw_status.sw = button_sw_status.sw ;
        usb_send_data(1,EP1_SEND_BUF_ADDRESS,(char *)&button_sw_status,sizeof(OUT_PACKET)); // send switch and button status to pc

        device_status.EP1_Transfer_Timeout  = alt_nticks() + alt_ticks_per_second()*1; // 2s TimeOut if host do not responds
        device_status.bEP1_Transfer_Judge   = TRUE;

        DEBUG_OUT(" Switch or Button Status changed !!\n           [SW] 0x%05X,   [Button] 0x%02X\n",(unsigned int)(old_button_sw_status.sw&SW_FLAG),old_button_sw_status.button&BUTTON_FLAG);
        usleep(50000);

	   }
 }


   if(alt_nticks()>device_status.EP1_Transfer_Timeout &&  device_status.bEP1_Transfer_Judge == TRUE && device_status.bEP1InTransfer == TRUE){
	   device_status.bEP1InTransfer = FALSE;
	   device_status.bEP1_Transfer_Judge = FALSE;
       DEBUG_OUT("Host PC not responds ,TimeOut!!\n");

   }

 }
                           

