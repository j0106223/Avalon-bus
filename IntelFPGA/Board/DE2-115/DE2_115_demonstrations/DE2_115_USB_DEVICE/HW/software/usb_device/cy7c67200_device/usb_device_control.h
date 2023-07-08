#ifndef USB_DEVICE_CONTROL_H_
#define USB_DEVICE_CONTROL_H_

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
// Author: Dee Zeng        


typedef enum{
    LED_DISPLAY = 0x01,
    LCD_DISPLAY = 0x02, 
    SEG7_8_DISPLAY = 0x03
}IN_TRANSFER_TPYE;

typedef struct _led_packet
{     
      alt_u16 ledg; //ledg0-8  =9
      alt_u32 ledr; //ledr0-17 =18
}LED_PACKET;

#define LEDG_FLAG       0x01FF
#define LEDR_FLAG       0x0003FFFF

typedef struct _lcd_packet
{
  char Text1[16];
  char Text2[16];
}LCD_PACKET;

typedef struct _seg7_8_packet
{
  alt_u32 seg7_8_value; 
}SEG7_8_PACKET;



typedef struct _out_packet{
     alt_u8 button;
     alt_u32 sw;
}OUT_PACKET;  

#define BUTTON_FLAG 0x0F
#define SW_FLAG     0x0003FFFF


void dcProcessEvent(void);

//void dc_handle_mailbox(DEVICE_INFO * pdc);

void sie2_msg_handler(unsigned short message);

void check_button_sw_status(void);

#endif /*USB_DEVICE_CONTROL_H_*/
