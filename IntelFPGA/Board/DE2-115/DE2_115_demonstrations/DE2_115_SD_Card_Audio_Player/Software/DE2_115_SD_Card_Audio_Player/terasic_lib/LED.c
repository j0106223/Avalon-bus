// --------------------------------------------------------------------
// Copyright (c) 2010 by Terasic Technologies Inc. 
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
#include "LED.h"

#define LED_INIT_MASK   (0x01 << 24)


void LED_AllOn(void){
    LED_Display(0xFFFFFFFF);       
}

void LED_AllOff(void){
    LED_Display(0x00);       
}

void LED_Display(alt_u32 Mask){ // 1: light, 0:unlight
    alt_u32 ThisMask;
    ThisMask = Mask;//~(Mask & 0x7FFFFFF);
    IOWR_ALTERA_AVALON_PIO_DATA(LEDG_BASE, ThisMask);  //0:ligh, 1:unlight
    IOWR_ALTERA_AVALON_PIO_DATA(LEDR_BASE, ThisMask >> 9);  //0:ligh, 1:unlight
    
}

void LED_LightCount(alt_u8 LightCount){ // 1: light, 0:unlight
    alt_u32 Mask = 0;
    int i;
    for(i=0;i<LightCount;i++){
        Mask <<= 1;
        Mask |= 0x01;
    }
    IOWR_ALTERA_AVALON_PIO_DATA(LEDG_BASE, Mask);  //0:ligh, 1:unlight
    IOWR_ALTERA_AVALON_PIO_DATA(LEDR_BASE, Mask >> 8);  //0:ligh, 1:unlight
    
}


