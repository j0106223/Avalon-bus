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
// Major Functions:   Via USB:
//                    1. Write LCD 1602,7SEG 
//                    2. light on or off the LEDs
//                    3. the status of Switchs and Buttons
//                    4. hot-plug
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Dee Zeng          :| 10/22/2012:| Initial Revision
// --------------------------------------------------------------------

#include "terasic_includes.h"
#include "usb_device.h"
#include "pcd_asm.h"
#include "usb_device_control.h"
#include "LCD.h"

 /*
  * Docs reference  :   cy3663_cd_rom 
  *                 :  BIOS User¡¯s Manual
  * 
  * demo reference  :  WINCE ver 1.1 drivers for peripheral mode 
  *                        http://www.cypress.com/?rID=14386    
  * 
  *  you can download this from cypress web site and search for other reference
  */
   
#ifdef DEBUG_MAIN
    #define DEBUG_OUT(format, arg...) printf(format, ## arg)
#else
    #define DEBUG_OUT(format, arg...) 
#endif   
   
extern DEVICE_STATUS device_status;

int main(void)
{ 
    DEBUG_OUT("========= DE2-115 CY7C67200 USB Device Demo [2011/07/05]=========\n");
    DEBUG_OUT("=                                                               =\n");
    DEBUG_OUT("=  This program demo a simply transfer between PC and DE2-115.  =\n");
    DEBUG_OUT("=                                                               =\n");
    DEBUG_OUT("=================================================================\n");
 

     /*******************************************************************************
      * dc_download has download code into 67200 chip's ram 
      * And then call the COMM_JUMP2CODE lcp command to let 67200 run this image
      * 
      * pcd_asm.h is generate from pcd_asm.asm (folder :pcd_asm)
      * we can edit the pcd_asm.asm and generate a new code to realize our functions
      * // please move the folder to a new location if you want to generate your code 
      * // otherwise there will be some error or bug when you use makep.bat 
      * 
      * you can see pcd_asm.asm to know the detail process 
      */ 
      if(dc_download((char*)pcd_asm,/*max_try*/10)==ERROR){ //fail to init
        DEBUG_OUT("-DEVICE Init - Failed to download into 67200 Chip.\n") ;
        return FALSE;
       }
      usleep(100000);
          while(1)
        {
             /****************************************
              *  mainly check the SIE2 message
              *  and then process it according to the message
              *************************************/
              dcProcessEvent();
            
             /****************************************
              *  when the status of switch or button have changed
              *  send a packet to pc to indicate the change
              *************************************/
             check_button_sw_status();
        }
          
 
   return 0;
}



