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

#include ".\terasic_lib\terasic_includes.h"
#include ".\terasic_lib\LED.h"
#include ".\terasic_fat\FatFileSystem.h"
#include ".\terasic_fat\FatInternal.h"
#include ".\terasic_lib\WaveLib.h"
#include ".\terasic_lib\I2C.h"
#include ".\terasic_lib\AUDIO.h"
#include ".\terasic_sdcard\sd_lib.h"




#ifdef DEBUG_APP
    #define APP_DEBUG(x)    DEBUG(x)
#else
    #define APP_DEBUG(x)
#endif

#define DEMO_PRINTF printf

//===== display config =====

#define LCD_DISPLAY
#define SEG7_DISPLAY
#define DISPLAY_WAVE_POWER
#define SUPPORT_PLAY_MODE
#define xENABLE_DEBOUNCE

#ifdef LCD_DISPLAY
    #include ".\terasic_lib\LED.h"
#endif

#ifdef SEG7_DISPLAY
    #include ".\terasic_lib\SEG7.h"
#endif

//===== constance definition =====
#define MAX_VOL 8
#define AUTO_NEXT_SONG
#define HW_MAX_VOL     127
#define HW_MIN_VOL     47
#define HW_DEFAULT_VOL  120

//===== structure definition =====

// return number of wave file
#define MAX_FILE_NUM    128
#define FILENAME_LEN    32

typedef struct{
    int nFileNum;
    char szFilename[MAX_FILE_NUM][FILENAME_LEN];
}WAVE_PLAY_LIST;


static WAVE_PLAY_LIST gWavePlayList;
#define WAVE_BUF_SIZE  512  // do not chagne this constant (FIFO: 4*128 byte)
typedef struct{
    FAT_FILE_HANDLE hFile;
    alt_u8          szBuf[WAVE_BUF_SIZE];  // one sector size of sd-card
    alt_u32         uWavePlayIndex;
    alt_u32         uWaveReadPos;
    alt_u32         uWavePlayPos;
    alt_u32         uWaveMaxPlayPos;
    char szFilename[FILENAME_LEN];
    alt_u8          nVolume;
    bool            bRepeatMode;
}PLAYWAVE_CONTEXT;

static PLAYWAVE_CONTEXT gWavePlay;// = {{0},{0}, HW_DEFAULT_VOL, {0}, 0, 0, 0};
static FAT_HANDLE hFat;
static int nMute_Volume = 0;

//===== function prototype =====
void welcome_display(void);
void update_status(void);
void wait_sdcard_insert(void);
int build_wave_play_list(FAT_HANDLE hFat);
void handle_key(bool *pNexSongPressed);
void handle_IrDA(bool * pNexSongPressed,alt_u32 id);
void IRDA_init();
bool waveplay_start(char *pFilename);
bool waveplay_execute(bool *bEOF);
void DisplayTime(alt_u32 TimeElapsed);
void lcd_open(void);
void lcd_display(char *pText);
void led_display(alt_u32 mask);
void led_display_count(alt_u8 count);
bool Fat_Test(FAT_HANDLE hFat, char *pDumpFile);

static bool bLastSwitch = FALSE; //TRUE: handle_IrDA
static bool bNextSwitch = FALSE; //TRUE: handle_IrDA
static bool bMuteSwitch = FALSE;
static bool bPlaySwitch = TRUE;

/////////////////////////////////////////////////////////////////
/////////// Display config & function ///////////////////////////
/////////////////////////////////////////////////////////////////



void welcome_display(void){
    int i;
    lcd_display(("\rWelcome Demo\nCDCARD-AUDIO\n"));
    for(i=0;i<5;i++){
        LED_AllOn();
        usleep(50*1000);
        LED_AllOff();
        usleep(50*1000);
    }        
}

void demo_introduce(void){
    DEMO_PRINTF("===== Welcome to SD-CARD Demo Program =====\r\n");
    DEMO_PRINTF("Supported File System: FAT16,FAT32, English Short File Name,English Long File Name\r\n");
    DEMO_PRINTF("Played Wave Files: Wave files on root directory.\r\n");
    DEMO_PRINTF("Supported Media File: Uncompressed WAV File, Sample-Rate 96K/48K/44.1K/32K/8K, Stereo, 16-bits Sample.\r\n");
    DEMO_PRINTF("KEY4: Next Song\r\n");
#ifdef SUPPORT_PLAY_MODE    
    DEMO_PRINTF("SW0 ON: Enable Repeat Mode\n");
#endif    
    DEMO_PRINTF("KEY3: Volume Up\r\n");
    DEMO_PRINTF("KEY2: Volume Down\r\n");
    DEMO_PRINTF("Current Voluem:%d(%d-%d)\r\n\r\n", HW_DEFAULT_VOL, HW_MIN_VOL, HW_MAX_VOL);    
}

void update_status(void){
#ifdef LCD_DISPLAY    
    char szText[64];       
    sprintf(szText, "\r%s\nVol:%d(%d-%d)%C\n", gWavePlay.szFilename, gWavePlay.nVolume, 
        HW_MIN_VOL, HW_MAX_VOL, gWavePlay.bRepeatMode?'R':'S');
    lcd_display((szText));
#endif    
}

void DisplayTime(alt_u32 TimeElapsed){
#ifdef SEG7_DISPLAY
    alt_u32 msx10;
    msx10 = TimeElapsed*100/alt_ticks_per_second();
    SEG7_Decimal(msx10, 0x01 << 2);
#endif
    
    
    
    
}

void lcd_open(void){
#ifdef LCD_DISPLAY
    LCD_Open();
#endif  
}

void lcd_display(char *pText){
#ifdef LCD_DISPLAY     
    LCD_Clear();  
    LCD_TextOut(pText);
#endif    
}

void led_display(alt_u32 mask){
#ifdef LCD_DISPLAY       
    LED_Display(mask);
#endif    
}

void led_display_count(alt_u8 count){
#ifdef DISPLAY_WAVE_POWER   
    LED_LightCount(count);
#endif    
}


/////////////////////////////////////////////////////////////////
/////////// Routing for detect SD-CARD //////////////////////////
/////////////////////////////////////////////////////////////////

void wait_sdcard_insert(void){
    bool bFirstTime2Detect = TRUE;
    alt_u8 led_mask = 0x02;
    LED_AllOff();
    //led = IORD_ALTERA_AVALON_PIO_DATA(LED_RED_SPAN); // low-active
    while(!SDLIB_Init()){
        if (bFirstTime2Detect){
            DEMO_PRINTF("Please insert SD card.\r\n");
            lcd_display(("\rPlease insert\nSD card.\n"));
            bFirstTime2Detect = FALSE;
        }    
        led_display((led_mask));
        usleep(100*1000);
        led_mask ^= 0x02;
    } // while
    led_display((0x02));
    DEMO_PRINTF("Find SD card\r\n");    
    
}

/////////////////////////////////////////////////////////////////
/////////// Routing for building wave-file play list ////////////
/////////////////////////////////////////////////////////////////

bool is_supporrted_sample_rate(int sample_rate){
    bool bSupport = FALSE;
    switch(sample_rate){
        case 96000:
        case 48000:
        case 44100:
        case 32000:
        case 8000:
            bSupport = TRUE;
            break;
    }
    return bSupport;
}


int build_wave_play_list(FAT_HANDLE hFat){
    int count = 0;
    FAT_BROWSE_HANDLE hFileBrowse;
    //FAT_DIRECTORY Directory;
    FILE_CONTEXT FileContext;
    FAT_FILE_HANDLE hFile;
    alt_u8 szHeader[128];
    char szWaveFilename[MAX_FILENAME_LENGTH];
    int sample_rate;
    bool bFlag = FALSE;
    int nPos = 0;
    int length=0;
    //
    gWavePlayList.nFileNum = 0;
    if (!Fat_FileBrowseBegin(hFat,&hFileBrowse)){
        DEMO_PRINTF("browse file fail.\n");
        return 0;
    } 
    
    //
    while (Fat_FileBrowseNext(&hFileBrowse,&FileContext)){
        if (FileContext.bLongFilename){
                nPos = 0;
                alt_u16 *pData16;
                alt_u8 *pData8;
                pData16 = (alt_u16 *)FileContext.szName;
                pData8 = FileContext.szName;
                while(*pData16){
                    if (*pData8 && *pData8 != ' ')
                        szWaveFilename[nPos++] = *pData8;
                    pData8++;
                    if (*pData8 && *pData8 != ' ')
                        szWaveFilename[nPos++] = *pData8;
                    pData8++;                    
                    //    
                    pData16++;
                }
                szWaveFilename[nPos] = 0;
                //printf("\n--Music Name:%s --\n",szWaveFilename);
            }else{
                strcpy(szWaveFilename,FileContext.szName);
                //printf("\n--Music Name:%s --\n",FileContext.szName);
            }       
            
            length= strlen(szWaveFilename);   
            if(length >= 4){
               if((szWaveFilename[length-1] =='V' || szWaveFilename[length-1] =='v')
                &&(szWaveFilename[length-2] == 'A' || szWaveFilename[length-2] =='a')
                &&(szWaveFilename[length-3] == 'W' || szWaveFilename[length-3] == 'w')
                &&(szWaveFilename[length-4] == '.')){
                   bFlag = TRUE;
                } 
            }
       
        if (bFlag){
            // parsing wave format
            hFile = Fat_FileOpen(hFat,szWaveFilename);
            if (!hFile){
                  DEMO_PRINTF("wave file open fail.\n");
                  continue;
            }
            DEMO_PRINTF("Read OK.\n");
            
            //memset(szHeader,0,sizeof(szHeader));
                    
            if (!Fat_FileRead(hFile, szHeader, sizeof(szHeader))){
                  DEMO_PRINTF("wave file read fail.\n");
                  continue;
            }
            Fat_FileClose(hFile);
                
                        // check wave format
            sample_rate =  Wave_GetSampleRate(szHeader, sizeof(szHeader));           
            if (WAVE_IsWaveFile(szHeader, sizeof(szHeader)) &&
                is_supporrted_sample_rate(sample_rate) &&
                Wave_GetChannelNum(szHeader, sizeof(szHeader))==2 &&
                Wave_GetSampleBitNum(szHeader, sizeof(szHeader))==16){
                    strcpy(gWavePlayList.szFilename[count],szWaveFilename);
                    count++;
            }
        }
    } // while  
    gWavePlayList.nFileNum = count;
    
    //Fat_FileBrowseEnd(&hFileBrowse);   
    
    return count;
}




/////////////////////////////////////////////////////////////////
//// Function for wave playing /////////////////////////////////
/////////////////////////////////////////////////////////////////



void waveplay_stop(void);

bool waveplay_start(char *pFilename){
    bool bSuccess;
    int nSize;
    //waveplay_stop();
    
  //  strcpyn(gWavePlay.szFilename, pFilename, FILENAME_LEN-1);
    strcpy(gWavePlay.szFilename, pFilename);
    gWavePlay.hFile = Fat_FileOpen(hFat, pFilename);
    if (!gWavePlay.hFile)
        DEMO_PRINTF("wave file open fail.\n");
    
    //gWavePlay.szBuf = Fat_FileSize(gWavePlay.hFile);
    nSize = Fat_FileSize(gWavePlay.hFile);

    if (gWavePlay.hFile){                    
        bSuccess = Fat_FileRead(gWavePlay.hFile, gWavePlay.szBuf, WAVE_BUF_SIZE);
        if (!bSuccess)
            DEMO_PRINTF("wave file read fail.\n");
    }            
                
                        // check wave format
    if (bSuccess){      
            int sample_rate =  Wave_GetSampleRate(gWavePlay.szBuf, WAVE_BUF_SIZE);                 
            if (WAVE_IsWaveFile(gWavePlay.szBuf, WAVE_BUF_SIZE) &&
                is_supporrted_sample_rate(sample_rate) &&
                Wave_GetChannelNum(gWavePlay.szBuf, WAVE_BUF_SIZE)==2 &&
                Wave_GetSampleBitNum(gWavePlay.szBuf, WAVE_BUF_SIZE)==16){
                    
                gWavePlay.uWavePlayPos = Wave_GetWaveOffset(gWavePlay.szBuf, WAVE_BUF_SIZE);
                gWavePlay.uWaveMaxPlayPos = gWavePlay.uWavePlayPos + Wave_GetDataByteSize(gWavePlay.szBuf, WAVE_BUF_SIZE);
                gWavePlay.uWaveReadPos = WAVE_BUF_SIZE;

                // setup sample rate
                AUDIO_InterfaceActive(FALSE);
                if (sample_rate == 96000)
                    AUDIO_SetSampleRate(RATE_ADC96K_DAC96K);
                else if (sample_rate == 48000)
                    AUDIO_SetSampleRate(RATE_ADC48K_DAC48K);
                else if (sample_rate == 44100)                    
                    AUDIO_SetSampleRate(RATE_ADC44K1_DAC44K1);
                else if (sample_rate == 32000)                    
                    AUDIO_SetSampleRate(RATE_ADC32K_DAC32K);
                else if (sample_rate == 8000)                    
                    AUDIO_SetSampleRate(RATE_ADC8K_DAC8K);
                else    
                    DEMO_PRINTF("unsupported sample rate=%d\n", sample_rate);
                AUDIO_FifoClear();
                AUDIO_InterfaceActive(TRUE);
                
                  
                DEMO_PRINTF("sample rate=%d\n", sample_rate);    
            }else{
                bSuccess = FALSE;
            }    
    }            

    if (!bSuccess)
        waveplay_stop();    
    
    return bSuccess;
}

bool waveplay_execute(bool *bEOF){
    bool bSuccess = TRUE;
    bool bDataReady = FALSE;
   
    
    // end of play data !
    if (gWavePlay.uWavePlayPos >= gWavePlay.uWaveMaxPlayPos){
        *bEOF = TRUE;
        return TRUE;
    }
    
    //
    *bEOF = FALSE;
    while (!bDataReady && bSuccess){
        if (gWavePlay.uWavePlayPos < gWavePlay.uWaveReadPos){
            bDataReady = TRUE;
            //DEBUG_PRINTF("it is not neccessary to read data from sd-card\r\n");
        }else{
            int read_size = WAVE_BUF_SIZE;
            if (read_size > (gWavePlay.uWaveMaxPlayPos - gWavePlay.uWavePlayPos))
                read_size = gWavePlay.uWaveMaxPlayPos - gWavePlay.uWavePlayPos;
            bSuccess = Fat_FileRead(gWavePlay.hFile, gWavePlay.szBuf, read_size);
            if (bSuccess)
                gWavePlay.uWaveReadPos += read_size;
            else    
                DEMO_PRINTF("[APP]sdcard read fail, read_pos:%ld, read_size:%d, max_play_pos:%ld !\r\n", gWavePlay.uWaveReadPos, read_size, gWavePlay.uWaveMaxPlayPos);
        }    
    } // while
    
    //
    if (bDataReady && bSuccess){
#ifdef DISPLAY_WAVE_POWER
        alt_u32 power_sum = 0, power;
#endif        
        int play_size; 
        short *pSample = (short *)(gWavePlay.szBuf + gWavePlay.uWavePlayPos%WAVE_BUF_SIZE);
        int i = 0;
        play_size = gWavePlay.uWaveReadPos - gWavePlay.uWavePlayPos;
        play_size = play_size/4*4;
        while(i < play_size){
            if(AUDIO_DacFifoNotFull()){ // if audio ready (not full)
                short ch_right, ch_left;
                ch_left = *pSample++;
                ch_right = *pSample++;
                
#ifdef DISPLAY_WAVE_POWER  // indicate power by avg 64 sample
                power = abs(ch_left) + abs(ch_right);
                power_sum += power;     
                if ((i & 0x01F) == 0 && i != 0){
                    power = power_sum >> (6+7);  // 6: divide 64,  7: power scale
                    led_display_count(power); 
                    power_sum = 0;
                }                        
#endif                

                AUDIO_DacFifoSetData(ch_left, ch_right); // play wave
                i+=4;
            }
        } // while
        gWavePlay.uWavePlayPos += play_size;
                    
    } //
    
    return bSuccess;
}

void waveplay_stop(void){
    /*if (gWavePlay.hFile.IsOpened){
        Fat_FileClose(&gWavePlay.hFile);
    }*/
}

/////////////////////////////////////////////////////////////////
/////////// Routing for button handle ///////////////////////////
/////////////////////////////////////////////////////////////////
// return true if next-song 
void handle_key(bool *pNexSongPressed){
    static bool bFirsTime2SetupVol = TRUE;
    alt_u8 button;
    bool bNextSong, bVolUp, bVolDown;
    int nHwVol;


#ifdef SUPPORT_PLAY_MODE
    bool bRepeat;
    bRepeat = (IORD_ALTERA_AVALON_PIO_DATA(SW_BASE) & 0x01)?TRUE:FALSE;
    if (bRepeat ^ gWavePlay.bRepeatMode){
        gWavePlay.bRepeatMode = bRepeat;
        update_status();
    }                    
#endif        
        

    *pNexSongPressed = FALSE;
#ifdef ENABLE_DEBOUNCE
    static alt_u32 next_active_time = 0;
    if (alt_nticks() < next_active_time ){
        return;
    }
    next_active_time = alt_nticks();
#endif   
    
    button = IORD_ALTERA_AVALON_PIO_DATA(KEY_BASE);
    button = IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE);
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE, 0); // clear flag 
    bNextSong = (button & 0x08)?TRUE:FALSE;
    bVolUp = (button & 0x04)?TRUE:FALSE;
    bVolDown = (button & 0x02)?TRUE:FALSE;
    
    
    
    // adjust volument    
    if ((bVolUp || bVolDown || bFirsTime2SetupVol) && !bMuteSwitch){
        nHwVol = gWavePlay.nVolume;    
        if (bFirsTime2SetupVol){
            bFirsTime2SetupVol = FALSE;
            DEMO_PRINTF("current volume %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }else if (bVolUp){
            if (nHwVol < HW_MAX_VOL) 
                nHwVol++;
            DEMO_PRINTF("volume up %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }else{
            if (nHwVol > HW_MIN_VOL)
                nHwVol--;
            DEMO_PRINTF("volume down %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }                    
        AUDIO_SetLineOutVol(nHwVol, nHwVol); 
        gWavePlay.nVolume = nHwVol;
        update_status();
    }
 
    
    if (bNextSong){
        *pNexSongPressed = TRUE;
        DEMO_PRINTF("Play Next Song\r\n");
    }        
#ifdef ENABLE_DEBOUNCE        
    if (bNextSong || bVolUp || bVolDown){
        next_active_time +=  alt_ticks_per_second()/5;  // debounce
    }        
#endif    
    
}

/////////////////////////////////////////////////////////////////
/////////// Routing for IrDA handle /////////////////////////////
/////////////////////////////////////////////////////////////////

//IRDA  initial
void IRDA_init()
{
    alt_irq_register(TERASIC_IRDA_0_IRQ,0,handle_IrDA);            //irda irq register
    alt_irq_enable_all(TERASIC_IRDA_0_IRQ);
    IOWR(TERASIC_IRDA_0_BASE,0,0);
}

// return true if next-song
void handle_IrDA(bool * p,alt_u32 id){
    static bool bFirsTime2SetupVol = TRUE;
    alt_u32 button;
    bool bLastSong,bNextSong, bVolUp, bVolDown,bMute,bPlay;
    int nHwVol;


#ifdef SUPPORT_PLAY_MODE
    bool bRepeat;
    bRepeat = (IORD_ALTERA_AVALON_PIO_DATA(SW_BASE) & 0x01)?TRUE:FALSE;
    if (bRepeat ^ gWavePlay.bRepeatMode){
        gWavePlay.bRepeatMode = bRepeat;
        update_status();
    }                    
#endif        
        
#ifdef ENABLE_DEBOUNCE
    static alt_u32 next_active_time = 0;
    if (alt_nticks() < next_active_time ){
        return;
    }
    next_active_time = alt_nticks();
#endif   
   
    button = IORD(TERASIC_IRDA_0_BASE,0);
    button <<= 8;
    button >>= 24;
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(TERASIC_IRDA_0_BASE, 0); // clear flag 
    
    IOWR(TERASIC_IRDA_0_BASE,0,0);
    bLastSong = (button == 0x1a) ? TRUE : FALSE;
    bNextSong = (button == 0x1e) ? TRUE : FALSE;
    bVolUp    = (button == 0x1b) ? TRUE : FALSE;
    bVolDown  = (button == 0x1f) ? TRUE : FALSE;
    bMute     = (button == 0x0c) ? TRUE : FALSE;
    bPlay     = (button == 0x16) ? TRUE : FALSE;
   
    
    // adjust volument    
    if ((bVolUp || bVolDown || bFirsTime2SetupVol) && !bMuteSwitch){
        nHwVol = gWavePlay.nVolume;    
        if (bFirsTime2SetupVol){
            bFirsTime2SetupVol = FALSE;
            DEMO_PRINTF("current volume %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }else if (bVolUp){
            if (nHwVol < HW_MAX_VOL) 
                nHwVol++;
            DEMO_PRINTF("volume up %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }else{
            if (nHwVol > HW_MIN_VOL)
                nHwVol--;
            DEMO_PRINTF("volume down %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }                    
        AUDIO_SetLineOutVol(nHwVol, nHwVol); 
        gWavePlay.nVolume = nHwVol;
        update_status();
    }
 
    if (bLastSong){
        bLastSwitch = TRUE ;
        DEMO_PRINTF("Play Last Song\r\n");
    } 
    if (bNextSong){
        bNextSwitch = TRUE ;
        DEMO_PRINTF("Play Next Song\r\n");
    }       
    
    if(bMute){
        nHwVol = gWavePlay.nVolume;
        if(nHwVol != 47){
            nMute_Volume = nHwVol;
            nHwVol = 47;
            DEMO_PRINTF("Open Mute...\r\n");
            
            bMuteSwitch = TRUE;
        }else{
            nHwVol = nMute_Volume;
            DEMO_PRINTF("Shut Mute...\r\n");
            
            bMuteSwitch = FALSE;
        }
        AUDIO_SetLineOutVol(nHwVol, nHwVol);
        gWavePlay.nVolume = nHwVol;
        update_status();
        
    } 
    if(bPlay){
        bPlaySwitch = !bPlaySwitch;
        if(bPlaySwitch)
           printf("Play Continue...\r\n");
        else
           printf("Play Pause...\r\n");
        AUDIO_InterfaceActive(bPlaySwitch);
    }
#ifdef ENABLE_DEBOUNCE        
    if (bLastSong || bNextSong || bVolUp || bVolDown){
        next_active_time +=  alt_ticks_per_second()/5;  // debounce
    }        
#endif    
    
}

bool Fat_Test(FAT_HANDLE hFat, char *pDumpFile){
    bool bSuccess;
    int nCount = 0;
    FAT_BROWSE_HANDLE hBrowse;
    FILE_CONTEXT FileContext;
    
    bSuccess = Fat_FileBrowseBegin(hFat, &hBrowse);
    if (bSuccess){
        while(Fat_FileBrowseNext(&hBrowse, &FileContext)){
            if (FileContext.bLongFilename){
                alt_u16 *pData16;
                alt_u8 *pData8;
                pData16 = (alt_u16 *)FileContext.szName;
                pData8 = FileContext.szName;
                printf("[%d]", nCount);
                while(*pData16){
                    if (*pData8)
                        printf("%c", *pData8);
                    pData8++;
                    if (*pData8)
                        printf("%c", *pData8);
                    pData8++;                    
                    //    
                    pData16++;
                }
                printf("\n");
            }else{
                printf("---[%d]%s\n", nCount, FileContext.szName);
            }                
            nCount++;
        }    
    }
    if (bSuccess && pDumpFile && strlen(pDumpFile)){
        FAT_FILE_HANDLE hFile;
        hFile =  Fat_FileOpen(hFat, pDumpFile);
        if (hFile){
            char szRead[256];
            int nReadSize, nFileSize, nTotalReadSize=0;
            nFileSize = Fat_FileSize(hFile);
            if (nReadSize > sizeof(szRead))
                nReadSize = sizeof(szRead);
            printf("%s dump:\n", pDumpFile);
            while(bSuccess && nTotalReadSize < nFileSize){
                nReadSize = sizeof(szRead);
                if (nReadSize > (nFileSize - nTotalReadSize))
                    nReadSize = (nFileSize - nTotalReadSize);
                //    
                if (Fat_FileRead(hFile, szRead, nReadSize)){
                    int i;
                    for(i=0;i<nReadSize;i++){
                        printf("%c", szRead[i]);
                    }
                    nTotalReadSize += nReadSize;
                }else{
                    bSuccess = FALSE;
                    printf("\nFaied to read the file \"%s\"\n", pDumpFile);
                }     
            } // while
            if (bSuccess)
                printf("\n");
            Fat_FileClose(hFile);
        }else{            
            bSuccess = FALSE;
            printf("Cannot find the file \"%s\"\n", pDumpFile);
        }            
    }
    
    return bSuccess;
}

int main()
{
    int nPlayIndex;
    alt_u32 cnt, uSongStartTime, uTimeElapsed;
    alt_8 led_mask = 0x03;
    alt_u8 szWaveFile[FILENAME_LEN];
    IRDA_init();
    lcd_open();
    welcome_display();
    demo_introduce();
    if (!AUDIO_Init()){
        DEMO_PRINTF("Audio Init fail!\n");
        lcd_display(("Audio Init fail!\n\n"));
        return 0;
    }
    
    //AUDIO_EnableByPass(TRUE);
    //AUDIO_EnableSiteTone(TRUE);

    
    memset(&gWavePlay, 0, sizeof(gWavePlay));
    gWavePlay.nVolume = HW_DEFAULT_VOL;
    AUDIO_SetLineOutVol(gWavePlay.nVolume, gWavePlay.nVolume); 
  
    while(1){
        
        // check SD card
        wait_sdcard_insert();
    
        // Mount SD-CARD
        hFat = Fat_Mount(FAT_SD_CARD, 0);
        if (!hFat){
            DEMO_PRINTF("SD card mount fail.\n");
            lcd_display(("SD card mount fail.\n\n"));
            return 0;
        }  
        else{
           if (build_wave_play_list(hFat) == 0){
            DEMO_PRINTF("There is no wave file in the root directory of SD card.\n");
            lcd_display(("No Wave Files.\n\n"));
            return 0;
            }
        }
        
   
        bool bSdacrdReady = TRUE;
        nPlayIndex = 0;
        while(bSdacrdReady){
            // find a wave file
            bool bPlayDone = FALSE;
            strcpy(szWaveFile, gWavePlayList.szFilename[nPlayIndex]);
            DEMO_PRINTF("Play Song:%s\r\n", szWaveFile);
            if (!waveplay_start(szWaveFile)){
                DEMO_PRINTF("waveplay_start error\r\n");
                lcd_display("Play Error.\n\n");
                bSdacrdReady = FALSE;
            }                
            update_status();
            cnt = 0;
            uSongStartTime = alt_nticks();
            while(!bPlayDone && bSdacrdReady){
                bool bLastSongPressed  = FALSE;
                bool bNextSongPressed  = FALSE;
                bool bEndOfFile = FALSE;
                if ((cnt++ & 0x1F) == 0){
                    led_display(led_mask);
                    led_mask ^= 0x01;
                }                    
                // play wave file
                if (!waveplay_execute(&bEndOfFile)){
                    DEMO_PRINTF("waveplay_execute error\r\n");
                    lcd_display("Play Error.\n\n");
                    bSdacrdReady = FALSE;
                }    
                
                // handle key event   
                handle_key(&bNextSongPressed);
                if(bLastSwitch){
                    bLastSongPressed = TRUE;
                    bNextSongPressed = FALSE;
                }
                 if(bNextSwitch){
                    bLastSongPressed = FALSE;
                    bNextSongPressed = TRUE;
                }
                if (bSdacrdReady && (bEndOfFile || bLastSongPressed || bNextSongPressed)){
                    bool bNextSong = FALSE;
                    bool bLastSong = FALSE;
                    
                    if(bLastSongPressed) bLastSong = TRUE;
                    if(bNextSongPressed || bEndOfFile) bNextSong = TRUE;
                    // check whether in REPEAT mode
                    if (!bLastSongPressed && !bNextSongPressed && gWavePlay.bRepeatMode){
                        bNextSong = FALSE;  // in repeat mode
                        bLastSong = FALSE;
                    }
                    if (bNextSong){  // index update for next song
                        nPlayIndex++;
                        if (nPlayIndex >= gWavePlayList.nFileNum)
                            nPlayIndex = 0;
                    }   
                    if (bLastSong){  // index update for last song
                        nPlayIndex--;
                        if (nPlayIndex < 0)
                            nPlayIndex = gWavePlayList.nFileNum-1;
                    }                           
                    bPlayDone = TRUE;                        
                } 
                bLastSwitch = FALSE;
                bNextSwitch = FALSE;
                
                uTimeElapsed = alt_nticks() - uSongStartTime;    
                DisplayTime(uTimeElapsed);    
            }  // while(!bPlayNextSong && bSdacrdReady)
            waveplay_stop();    
        }  // while(bSdacrdReady)
  } // while (1)

  return 0;
}
