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

/*
 * Function:
 *      Audio record and Play
 * 
 * Human Machine Interface:
 *      KEY3: Record Start/Stop (Auto Stop when buffer is full)
 *      KEY2: Play Start/Stop (Audo Stop when no data to play)
 *      SEG7: Display the duration of recording/playing
 *      LED:  Display the singal strength.
 *      SW0:  Audio Source Selection: DOWN-->MIC, UP-->LINE-IN
 *      SW1:  MIC Boost Control when audio source is MIC. DOWN-->BOOST OFF UP-->BOSST ON
 *      SW2:  Zero-Cross detect for Playing: DOWN-->OFF, UP-->ON
 *      SW5/SW4/SW3: Sample Rate Control: 
 *                    DOWN/DOWN/DOWN-->96K 
 *                    DOWN/DOWN/UP->48K,
 *                    DOWN/UP/DOWN->44.1K, 
 *                    DOWN/UP/UP->32K,
 *                    UP/DOWN/DOWN->8K
 * 
 * CONFIGURATION:
 *      SDRAM: used to store record audio signal
 *      on-chip memory: used to store Nios II program
 * 
 * Revision:
 *      V1.0, 11/21/2007, init by Richard.
 *      V1.01 21/5 /2010  
 * 
 * Compatibility:
 *      Quartus 13.0
 *      DE1_SoC Board
 */

#include "my_includes.h"
#include "AUDIO.h"
#include "LED.h"
#include "SEG7.h"
#include <math.h>


#ifdef DEBUG_APP
    #define APP_DEBUG(x)    DEBUG(x)
#else
    #define APP_DEBUG(x)
#endif


///////////////////////////////////////////////////////////////////////////////
//////////// Internal function prototype & data structure /////////////////////
///////////////////////////////////////////////////////////////////////////////
//================= internal function prototype & data structure definit =====
#define RECORD_BUTTON   0x08
#define PLAY_BUTTON     0x04
#define PLAYRING_BUTTON 0x02
#define RECORD_BLOCK_SIZE   250    // ADC FIFO: 512 byte
#define PLAY_BLOCK_SIZE     250    // DAC FIFO: 512 byte
#define MAX_TRY_CNT         1024
#define LINEOUT_DEFUALT_VOL 0x79  // 0 dB
#define USE_SDRAM_FOR_DATA

#ifndef USE_SDRAM_FOR_DATA
    #define BUF_SAMPLE_NUM     (96000*5)  // 5 second @ 96K
#endif 


typedef enum{
    MIC_RECORD,
    LINEIN_RECORD,
    LINEOUT_PLAY
}AUDIO_FUNC;

void button_monitor_isr(void* context, alt_u32 id);
bool button_monitor_start(volatile alt_u32 *pPressedMask);
bool init_audio(AUDIO_FUNC audio_func);
void display_time_elapsed(alt_u32 sample_num);

// ui config
bool ui_is_mic_boost(void);
bool ui_is_mic_record(void);
bool ui_is_dac_zero_cross(void);
int  ui_get_sample_rate(void);

// gloal variable
int record_sample_rate;

///////////////////////////////////////////////////////////////////////////////
//////////// Internal function implement(body) ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
bool ui_is_mic_record(void){
    bool bMicRecord;
    bMicRecord = (IORD(SW_BASE, 0) & 0x01)?FALSE:TRUE;
    return bMicRecord;    
}

bool ui_is_mic_boost(void){
    bool bMicBoost;
    bMicBoost = (IORD(SW_BASE, 0) & (0x01 << 1))?TRUE:FALSE;
    return bMicBoost;    
}

bool ui_is_dac_zero_cross(void){
    bool bZeroCross;
    bZeroCross = (IORD(SW_BASE, 0) & (0x01 << 2))?TRUE:FALSE;
    return bZeroCross;      
}

int ui_get_sample_rate(void){
    int sample_rate = 96000;
    alt_u32 mask;
    mask = IORD(SW_BASE, 0);
    mask = (mask >> 3) & 0x07;
    if (mask == 1)
        sample_rate = 48000;
    else if (mask == 2)
        sample_rate = 44100;
    else if (mask == 3)
        sample_rate = 32000;
    else if (mask == 4)
        sample_rate = 8000;
    return sample_rate;      
} 

void button_monitor_isr(void* context, alt_u32 id){
    volatile alt_u32* pPressedMask = (volatile alt_u32*)context;
    *pPressedMask |= IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE) & 0x0F;  // 4-button 
    
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE,0); 
}

bool button_monitor_start(volatile alt_u32 *pPressedMask){
    bool bSuccess = TRUE;
    // enable interrupt
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(KEY_BASE, 0x0F); // 4-button
    
    // Reset the edge catpure register
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE,0); 
    
    // register IRQ
    if (bSuccess && (alt_irq_register(KEY_IRQ, (void *)pPressedMask, button_monitor_isr) != 0)){
        printf("[SW-MONITOR]register button IRQ fail\r\n");
        bSuccess = FALSE;
    }
    
    return bSuccess;        
}




bool init_audio(AUDIO_FUNC audio_func){
    bool bSuccess = TRUE;
    AUDIO_InterfaceActive(FALSE);
    //
    if (audio_func == MIC_RECORD){
        bool bMicBoost;
        bMicBoost = ui_is_mic_boost();
        AUDIO_SetInputSource(SOURCE_MIC);
        AUDIO_DacEnableSoftMute(TRUE);
        AUDIO_AdcEnableHighPassFilter(FALSE);
        AUDIO_MicBoost(bMicBoost);   
        AUDIO_MicMute(FALSE);
        AUDIO_LineInMute(TRUE);
    }else if (audio_func == LINEIN_RECORD){
        AUDIO_SetInputSource(SOURCE_LINEIN);
        AUDIO_DacEnableSoftMute(TRUE);
        AUDIO_AdcEnableHighPassFilter(FALSE);
        AUDIO_MicMute(TRUE);
        AUDIO_LineInMute(FALSE);
        AUDIO_SetLineInVol(0x17, 0x17);  // max 0x1F, min:0; 0x17: 0dB (assume max input is 2.0v rms)
    }else if (audio_func == LINEOUT_PLAY){
        AUDIO_DacEnableSoftMute(TRUE);
        AUDIO_MicBoost(FALSE);   
        AUDIO_MicMute(TRUE);
        AUDIO_LineInMute(FALSE);
        AUDIO_DacEnableSoftMute(FALSE);
        //AUDIO_DacDeemphasisControl(DEEMPHASIS_48K);
        AUDIO_DacEnableZeroCross(ui_is_dac_zero_cross());
        AUDIO_SetLineOutVol(LINEOUT_DEFUALT_VOL, LINEOUT_DEFUALT_VOL); // max 7F, min: 30, 0x79: 0 db
        AUDIO_DacEnableSoftMute(FALSE);
    }
    
    if (record_sample_rate == 8000)
        AUDIO_SetSampleRate(RATE_ADC8K_DAC8K);
    else if (record_sample_rate == 32000)
        AUDIO_SetSampleRate(RATE_ADC32K_DAC32K);
    else if (record_sample_rate == 48000)
        AUDIO_SetSampleRate(RATE_ADC48K_DAC48K);
    else if (record_sample_rate == 44100)
        AUDIO_SetSampleRate(RATE_ADC44K1_DAC44K1);
    else    
        AUDIO_SetSampleRate(RATE_ADC96K_DAC96K);
    //
    AUDIO_InterfaceActive(TRUE);
    
    return bSuccess;             
}


void display_time_elapsed(alt_u32 sample_num){
    // assume sample rate is 48K
    alt_u32 time;
    time = sample_num * 100 / record_sample_rate;
    SEG7_Decimal(time, 0x04);
}

void show_power(short sample){
    static alt_u32 sum = 0;
    static alt_u16   cnt = 0;
    alt_u16 power = 0;
    sum += (sample >= 0)?sample:-sample;
    cnt++;
    if (cnt == 32){
        power = sum >> 13;
        LED_LightCount(power); 
        sum = 0;
        cnt = 0;
    }
}


bool init(void){
    bool bSuccess = TRUE;
    
    SEG7_Clear();


    SEG7_Decimal(0x00000000, 0x00);

    // prepare    
    if (!AUDIO_Init()){

        printf("Audio Init Error\r\n");
        bSuccess = FALSE;
    }
    
        
    return bSuccess;
}

void dump_record_data(alt_u32 *pData, alt_u32 len){
    short sample_l, sample_r, sample_max = 0;
    alt_u32 data;
    int i;
    //return ;
    for(i=0;i<len;i++){
        data = *pData++;
        sample_l = (short)((data >> 16) & 0xFFFF); 
        sample_r = (short)(data & 0xFFFF);
        //printf("[%d]%d/%d\n", i, sample_l, sample_r);
        if (sample_l > 0 && sample_max <  sample_l)
            sample_max = sample_l;
        if (sample_l < 0 && sample_max <  -sample_l)
            sample_max = -sample_l;
        if (sample_r > 0 && sample_max <  sample_r)
            sample_max = sample_r;
        if (sample_r < 0 && sample_max <  -sample_r)
            sample_max = -sample_r;
    }
    printf("max=%d\n", sample_max);
}


const char szMenu[][128] = {
    "======== Terasic Audio Demo [08/30/2013]==========\n",
    "operation guide:\n",
    "  KEY3: Record Start/Stop (Auto Stop when buffer is full)\n",
    "  KEY2: Play Start/Stop (Audo Stop when no data to play)\n",
    "  SW0:  Audio Source Selection. DOWN-->MIC, UP-->LINE-IN\n",
    "  SW1:  MIC Boost Control. DOWN-->BOOST OFF UP-->BOSST ON\n",
    "  SW2:  Zero-Cross detect for Playing: DOWN-->OFF, UP-->ON\n",
    "  SW5/SW4/SW3: Sample Rate Control.\n",
    "               DOWN/DOWN/DOWN-->96K\n",
    "               DOWN/DOWN/UP---->48K\n",
    "               DOWN/UP/DOWN---->44.1K\n",
    "               DOWN/UP/UP------>32K\n",
    "               UP/DOWN/DOWN---->8K\n",
    "  Status Information:\n",    
    "  LED:  Display audio singal strength.\n",
    "  SEG7: Display time elapsed for playing/recording.\n"
    "\n\n"
};

void show_menu(void){
    int i;
    for(i=0;i<sizeof(szMenu)/sizeof(szMenu[0]);i++)
        printf(szMenu[i]);
}

int main()
{
    typedef enum{
        ST_STANDY,
        ST_RECODING,
        ST_PLAYING
    }STATE;
    STATE state = ST_STANDY;
    volatile alt_u32 button_mask=0;
    bool bRecordPressed, bPlayPressed, bError = FALSE;
    alt_u32 *pBuf, *pPlaying, *pRecording, RecordLen, PlayLen, data, try_cnt, buf_sample_size;
    alt_u16 ch_right, ch_left;

    
    printf("\nHello World\n");

    show_menu();    
    if (!init())
        return 0;
        
    
#ifdef USE_SDRAM_FOR_DATA
    pBuf = (alt_u32 *)SDRAM_BASE;
    buf_sample_size = SDRAM_SPAN/sizeof(alt_u32);
#else    
    // alloc memory to stroe PCM data 
    buf_sample_size = BUF_SAMPLE_NUM;
    pBuf = malloc(buf_sample_size * sizeof(alt_u32));
    if (!pBuf){
        LCD_TextOut("malloc fail\n\n");
        printf("malloc fail\r\n");
        return 0;
    }
#endif    
    button_monitor_start(&button_mask);  // button IRQ
    printf("ready\n");
    
    
    // test
    record_sample_rate = ui_get_sample_rate(); 
    RecordLen = buf_sample_size;
    //
    
    // infinite loop
    while(1){
        // 
        bRecordPressed = (button_mask & RECORD_BUTTON)?TRUE:FALSE;
        bPlayPressed = (button_mask & PLAY_BUTTON)?TRUE:FALSE;
        if (bPlayPressed || bRecordPressed) 
            button_mask = 0;
        if (state == ST_STANDY){
            if (bRecordPressed){
                bool bMicRecord;
                record_sample_rate = ui_get_sample_rate();
                bMicRecord = ui_is_mic_record();
                AUDIO_FifoClear();
                init_audio(bMicRecord?MIC_RECORD:LINEIN_RECORD);
                AUDIO_FifoClear();
                state = ST_RECODING;
                if (bMicRecord){
                    bool bMicBoost = ui_is_mic_boost();
                    printf("MIC %srecording (sample rate = %d)...\r\n", bMicBoost?"Boost ":"", record_sample_rate);

                }else{
                    printf("LINE-IN recording (sample rate = %d)...\r\n", record_sample_rate);


                }                    
                pRecording = pBuf;
                RecordLen = 0;
            }else if (bPlayPressed){
                if (RecordLen == 0){
                    printf("Please record before play audio\r\n");

                }else{
                    bool bZeroCross = ui_is_dac_zero_cross();
                    AUDIO_FifoClear();
                    init_audio(LINEOUT_PLAY);
                    state = ST_PLAYING;
                    printf("playing (sample rate = %d)...\r\n", record_sample_rate);


                    pPlaying = pBuf;
                    PlayLen = 0;
                }  
            }
            bError = FALSE;
        }else if (state == ST_RECODING){
            if (bRecordPressed || (RecordLen >= buf_sample_size) || bError){
                // stop record
                printf("record %d samples\n", (int)RecordLen);


                state = ST_STANDY;
                LED_AllOff();
                dump_record_data(pBuf, RecordLen);
                
            }else{
                // continue recoding
                int i = 0;
                while ((i < RECORD_BLOCK_SIZE) && (RecordLen < buf_sample_size)){
                    try_cnt = 0;
                    while (!AUDIO_AdcFifoNotEmpty() && try_cnt < MAX_TRY_CNT){ // wait while empty
                        try_cnt++;    
                    }    
                    if (try_cnt >= MAX_TRY_CNT){
                        bError = TRUE;
                        break;
                    }    
                    AUDIO_AdcFifoGetData(&ch_left, &ch_right);
                    data = (ch_left << 16) | ch_right;
                    *pRecording++ = data;
                    RecordLen++;
                    i++;
                    show_power(data & 0xFFFF);
                }  // while
                display_time_elapsed(RecordLen);    
            }     
        }else if (state == ST_PLAYING){
            if (bPlayPressed || (PlayLen >= RecordLen) || bError){
                // stop playing
                printf("Play Stop %s\r\n", bError?"(Error)":"");

                state = ST_STANDY;
                LED_AllOff();
            }else{
                // continue playing
                int i = 0;
                while ((i < PLAY_BLOCK_SIZE) && (PlayLen < RecordLen)){
                    try_cnt = 0;                
                    while (!AUDIO_DacFifoNotFull() && try_cnt < MAX_TRY_CNT){  // wait while full
                        try_cnt++;
                    }    
                    if (try_cnt >= MAX_TRY_CNT){
                        bError = TRUE;
                        break;
                    }    
                    data = *pPlaying++;
                   
                    //data = 0;
                    ch_left = data >> 16;
                    ch_right = data & 0xFFFF;
                    AUDIO_DacFifoSetData(ch_left, ch_right);  
                    i++;
                    PlayLen++;
                    show_power(data & 0xFFFF);
                    //printf("[%d] %d/%d\n", PlayLen, (short)((data >> 16) & 0xFFFF), (short)(data & 0xFFFF));
                }
                display_time_elapsed(PlayLen);     
            }
        }        
    }
    
}
    
