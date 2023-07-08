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

#include "my_includes.h"
#include "I2C.h"
#include "AUDIO.h"
#include "AUDIO_REG.h"


#ifdef DEBUG_AUDIO
    #define AUDIO_DEBUG(x)    DEBUG(x)
#else
    #define AUDIO_DEBUG(x)
#endif

/////////////////////////////////////////////////////////////////////////
///////////// Internal function prototype & const definition ////////////
/////////////////////////////////////////////////////////////////////////
bool aduio_RegWrite(alt_u8 reg_index, alt_u16 data16);
static alt_u16  reg_file[10+10];



/////////////////////////////////////////////////////////////////////////
///////////// External function body ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

bool AUDIO_Init(void){
   bool bSuccess = TRUE;
    AUDIO_DEBUG(("[AUDIO] AUDIO_Init...\r\n"));

    if (bSuccess)
        bSuccess = aduio_RegWrite(15, 0x0000);  // reset
        
    if (bSuccess)
        bSuccess = aduio_RegWrite(9, 0x0000);  // inactive interface         
       
    //usleep(20*1000);    
    if (bSuccess)
        bSuccess = aduio_RegWrite(0, 0x0017);  // Left Line In: set left line in volume
        
    if (bSuccess)
        bSuccess = aduio_RegWrite(1, 0x0017);  // Right Line In: set right line in volume
        
    if (bSuccess)
        bSuccess = aduio_RegWrite(2, 0x005B);  // Left Headphone Out: set left line out volume
        
    if (bSuccess)
        bSuccess = aduio_RegWrite(3, 0x005B);  // Right Headphone Out: set right line out volume
        
    if (bSuccess)      
        bSuccess = aduio_RegWrite(4, 0x0015);  // Analogue Audio Path Control: set mic as input and boost it, and enable dac         
                
    if (bSuccess)
        bSuccess = aduio_RegWrite(5, 0x0000);  // Digital Audio Path Control: disable soft mute         

    if (bSuccess)
        bSuccess = aduio_RegWrite(6, 0);  // power down control: power on all         

    if (bSuccess)
        bSuccess = aduio_RegWrite(7, 0x0042);  // I2S, iwl=16-bits, Enable Master Mode         
//        bSuccess = aduio_RegWrite(7, 0x0041);  // MSB-First, left justified, iwl=16-bits, Enable Master Mode         

    if (bSuccess)
        bSuccess = aduio_RegWrite(8, 0x0002);  // Normal, Base OVer-Sampleing Rate 384 fs (BOSR=1)         


    if (bSuccess)
        bSuccess = aduio_RegWrite(9, 0x0001);  // active interface
        
        
         
    AUDIO_DEBUG(("[AUDIO] AUDIO_Init %s\r\n", bSuccess?"success":"fail"));        
    
    return bSuccess;        
         
}

bool AUDIO_InterfaceActive(bool bActive){
    bool bSuccess;
    bSuccess = aduio_RegWrite(9, bActive?0x0001:0x0000); 
    return bSuccess;
}

bool AUDIO_MicBoost(bool bBoost){
    bool bSuccess;
    alt_u16 control;
    control = reg_file[4];
    if (bBoost)
        control |= 0x0001;
    else        
        control &= 0xFFFE;
    bSuccess = aduio_RegWrite(4, control);  // Left Line In: set left line in volume
    return bSuccess;
}

bool AUDIO_AdcEnableHighPassFilter(bool bEnable){
    bool bSuccess;
    alt_u16 control;
    control = reg_file[5];
    if (bEnable)
        control &= 0xFFFE;
    else        
        control |= 0x0001;
    bSuccess = aduio_RegWrite(5, control);  // Left Line In: set left line in volume
    return bSuccess;    
}



bool AUDIO_DacDeemphasisControl(alt_u8 deemphasis_type){
    bool bSuccess;
    alt_u16 control;
    control = reg_file[5];
    control &= 0xFFF9;
    switch(deemphasis_type){
        case DEEMPHASIS_48K: control |= ((0x03) << 1); break;
        case DEEMPHASIS_44K1: control |= ((0x02) << 1); break;
        case DEEMPHASIS_32K: control |= ((0x01) << 1); break;
    }
    bSuccess = aduio_RegWrite(5, control);  // Left Line In: set left line in volume
    return bSuccess;       
}

bool AUDIO_DacEnableZeroCross(bool bEnable){
    bool bSuccess;
    alt_u16 control_l, control_r;
    alt_u16 mask;
    control_l = reg_file[2];
    control_r = reg_file[3];
    mask = 0x01 << 7;
    if (bEnable){
        control_l |= mask;
        control_r |= mask;
    }else{        
        control_l &= ~mask;
        control_r &= ~mask;
    }        
    bSuccess = aduio_RegWrite(2, control_l);  // Left Line In: set left line in volume
    if (bSuccess)
        bSuccess = aduio_RegWrite(3, control_r);  // Left Line In: set left line in volume
    return bSuccess;      
}

bool AUDIO_DacEnableSoftMute(bool bEnable){
    bool bSuccess;
    alt_u16 control;
    alt_u16 mask;
    control = reg_file[5];
    mask = 0x01 << 3;
    if (bEnable)
        control |= mask;
    else        
        control &= ~mask;
    bSuccess = aduio_RegWrite(5, control);  // Left Line In: set left line in volume
    return bSuccess;      
}

bool AUDIO_MicMute(bool bMute){
    bool bSuccess;
    alt_u16 control;
    alt_u16 mask;
    control = reg_file[4];
    mask = 0x01 << 1;
    if (bMute)
        control |= mask;
    else        
        control &= ~mask;
    bSuccess = aduio_RegWrite(4, control);  // Left Line In: set left line in volume
    return bSuccess;        
}

bool AUDIO_LineInMute(bool bMute){
    bool bSuccess;
    alt_u16 control_l, control_r;
    alt_u16 mask;
    control_l = reg_file[0];
    control_r = reg_file[1];
    mask = 0x01 << 7;
    if (bMute){
        control_l |= mask;
        control_r |= mask;
    }else{        
        control_l &= ~mask;
        control_r &= ~mask;
    }        
    bSuccess = aduio_RegWrite(0, control_l);  // Left Line In: set left line in volume
    if (bSuccess)
        bSuccess = aduio_RegWrite(1, control_r);  // Left Line In: set left line in volume
    return bSuccess;        
}



bool AUDIO_SetInputSource(alt_u8 InputSource){
    bool bSuccess;
    alt_u16 control;
    alt_u16 mask;
    control = reg_file[4];
    mask = 0x01 << 2;
    if (InputSource == SOURCE_MIC)
        control |= mask;
    else        
        control &= ~mask;
    bSuccess = aduio_RegWrite(4, control);  // Left Line In: set left line in volume
    return bSuccess;       
}

// See datasheet page 39
bool AUDIO_SetSampleRate(alt_u8 SampleRate){
    bool bSuccess;
    alt_u16 control;
    control = 0;

    switch(SampleRate){
         // MCLK = 18.432
        case RATE_ADC48K_DAC48K: control = (0x0) << 2; break;
        case RATE_ADC48K_DAC8K: control = (0x1) << 2; break;
        case RATE_ADC8K_DAC48K: control = (0x2) << 2; break;
        case RATE_ADC8K_DAC8K: control = (0x3) << 2; break;
        case RATE_ADC32K_DAC32K: control = (0x6) << 2; break;
        case RATE_ADC96K_DAC96K: control = (0x7) << 2; break;
        case RATE_ADC44K1_DAC44K1: control = (0x8) << 2; break;
        // MCLK = 11.2896
      //  case RATE_ADC44K1_DAC8K: control = (0x9) << 2; break;
      //  case RATE_ADC8K_DAC44K1: control = (0xA) << 2; break;
    }
    control |= 0x02; // BOSR=1 (384fs = 384*48k = 18.432M)
        
    bSuccess = aduio_RegWrite(8, control);  // Left Line In: set left line in volume
    return bSuccess;      
}





bool AUDIO_SetLineInVol(alt_u16 l_vol, alt_u16 r_vol){
    bool bSuccess;
    alt_u16 control;
    
    // left
    control = reg_file[0];
    control &= 0xFFE0;
    control += l_vol & 0x1F;
    bSuccess = aduio_RegWrite(0, control);
    
    if (bSuccess){
        // right
        control = reg_file[1];
        control &= 0xFFE0;
        control += r_vol & 0x1F;
        bSuccess = aduio_RegWrite(1, control);        
    }
    
    AUDIO_DEBUG(("[AUDIO] set Line-In vol(%d,%d) %s\r\n", l_vol, r_vol, bSuccess?"success":"fail"));        
    return bSuccess;
}

bool AUDIO_SetLineOutVol(alt_u16 l_vol, alt_u16 r_vol){
    bool bSuccess;
    alt_u16 control;

 
    // left
    control = reg_file[2];
    control &= 0xFF80;
    control += l_vol & 0x7F;
    bSuccess = aduio_RegWrite(2, control);
    
    if (bSuccess){
        // right
        control = reg_file[3];
        control &= 0xFF80;
        control += r_vol & 0x7F;
        bSuccess = aduio_RegWrite(3, control);        
    }    
    
    AUDIO_DEBUG(("[AUDIO] set Line-Out vol(%d,%d) %s\r\n", l_vol, r_vol, bSuccess?"success":"fail"));
    
    return bSuccess;
}


bool AUDIO_EnableByPass(bool bEnable){
    bool bSuccess;
    alt_u16 control;
    alt_u16 mask;
    control = reg_file[4];
    mask = 0x01 << 3;
    if (bEnable)
        control |= mask;
    else        
        control &= ~mask;
    bSuccess = aduio_RegWrite(4, control); 
    return bSuccess;  	
}

bool AUDIO_EnableSiteTone(bool bEnable){
    bool bSuccess;
    alt_u16 control;
    alt_u16 mask;
    control = reg_file[4];
    mask = 0x01 << 5;
    if (bEnable)
        control |= mask;
    else        
        control &= ~mask;
    bSuccess = aduio_RegWrite(4, control); 
    return bSuccess;        
}

/////////////////////////////////////////////////////////////////////////
///////////// Interla function body ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

bool aduio_RegWrite(alt_u8 reg_index, alt_u16 data16){
    bool bSuccess;
    alt_u8 data, control;
    if (reg_index <= 10)
        reg_file[reg_index] = data16;
    data = data16 & 0xFF;
    control = (reg_index << 1) & 0xFE;
    control |= ((data16 >> 8) & 0x01);
    AUDIO_DEBUG(("[AUDIO] set audio reg[%02d] = %04Xh\r\n", reg_index, data16));
    bSuccess = I2C_Write(I2C_SCL_BASE, I2C_SDA_BASE, I2C_AUDIO_ADDR, control, data);
    if (!bSuccess) 
        AUDIO_DEBUG(("[AUDIO] write reg fail!!!!\r\n"));
    usleep(50*1000);  // wait audio chip read        
    return bSuccess;        
}


/////////////////////////////////////////////////////////////////////////
///////////// Audio Play & Recor ////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// check whether the dac-fifo is full.
bool AUDIO_DacFifoNotFull(void){
    bool bReady;
    bReady = AUDIO_DAC_FULL()?FALSE:TRUE;
    return bReady;
}

// call AUDIO_PlayIsReady to make sure the fifo is not full before call this function 
void AUDIO_DacFifoSetData(short ch_left, short ch_right){
    AUDIO_DAC_WRITE_L(ch_left);
    AUDIO_DAC_WRITE_R(ch_right);
}

// wheck whether there is data available in adc-fifo
bool AUDIO_AdcFifoNotEmpty(void){
    bool bReady;
    bReady = AUDIO_ADC_EMPTY()?FALSE:TRUE;
    return bReady;
}


// make sure the data is available before call this fucntion
void AUDIO_AdcFifoGetData(short *pch_left, short *pch_right){
    *pch_left = AUDIO_ADC_READ_L();
    *pch_right = AUDIO_ADC_READ_R();
    
}

void AUDIO_FifoClear(void){
    AUDIO_FIFO_CLEAR();
}
