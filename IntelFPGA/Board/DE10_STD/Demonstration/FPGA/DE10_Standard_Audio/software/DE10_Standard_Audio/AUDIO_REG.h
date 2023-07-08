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

#ifndef AUDIO_HAL_H_
#define AUDIO_HAL_H_


#define AUDIO_DAC_LFIFO_PORT     0
#define AUDIO_DAC_RFIFO_PORT     1
#define AUDIO_ADC_LFIFO_PORT     2
#define AUDIO_ADC_RFIFO_PORT     3
#define AUDIO_CMD_PORT           4
#define AUDIO_STATUS_PORT        5

#define MASK_STATUS_DAC_FULL    0x01
#define MASK_STATUS_ADC_EMPTY   0x02

#define IOWR_AUDIO(index, data16)    IOWR(AUDIO_BASE, index, data16)
#define IORD_AUDIO(index)            IORD(AUDIO_BASE, index)

#define AUDIO_DAC_FULL()          ((IORD_AUDIO(AUDIO_STATUS_PORT) & MASK_STATUS_DAC_FULL)?TRUE:FALSE)     
#define AUDIO_DAC_WRITE_L(data16) IOWR_AUDIO(AUDIO_DAC_LFIFO_PORT, data16)     
#define AUDIO_DAC_WRITE_R(data16) IOWR_AUDIO(AUDIO_DAC_RFIFO_PORT, data16)
#define AUDIO_ADC_EMPTY()         ((IORD_AUDIO(AUDIO_STATUS_PORT) & MASK_STATUS_ADC_EMPTY)?TRUE:FALSE)     
#define AUDIO_ADC_READ_L()        IORD_AUDIO(AUDIO_ADC_LFIFO_PORT)
#define AUDIO_ADC_READ_R()        IORD_AUDIO(AUDIO_ADC_RFIFO_PORT)
#define AUDIO_ADC_READ()          ((((IORD_AUDIO(AUDIO_ADC_LFIFO_PORT) << 16) & 0xFFFF0000) | (IORD_AUDIO(AUDIO_ADC_RFIFO_PORT) & 0xFFFF)))
#define AUDIO_FIFO_CLEAR()        IOWR_AUDIO(AUDIO_CMD_PORT, 0x01)


#endif /*AUDIO_HAL_H_*/
