#ifndef AUDIO_H_
#define AUDIO_H_



typedef enum{
    SOURCE_MIC = 0,
    SOURCE_LINEIN
}INPUT_SOURCE;

typedef enum{
        // MCLK = 18.324 (BOSR==1)
    RATE_ADC48K_DAC48K,
    RATE_ADC48K_DAC8K,
    RATE_ADC8K_DAC48K,
    RATE_ADC8K_DAC8K,
    RATE_ADC32K_DAC32K,
    RATE_ADC96K_DAC96K,
    RATE_ADC44K1_DAC44K1
        // MCLK = 11.2896
    //RATE_ADC44K1_DAC44K1,
    //RATE_ADC44K1_DAC8K,
    //RATE_ADC8K_DAC44K1
}AUDIO_SAMPLE_RATE;

typedef enum{
    DEEMPHASIS_NONE,
    DEEMPHASIS_48K,
    DEEMPHASIS_44K1,
    DEEMPHASIS_32K
}DEEMPHASIS_TYPE;

bool AUDIO_Init(void);

// config 
bool AUDIO_MicBoost(bool bBoost);
bool AUDIO_SetLineInVol(alt_u16 l_vol, alt_u16 r_vol);
bool AUDIO_SetLineOutVol(alt_u16 l_vol, alt_u16 r_vol);
bool AUDIO_AdcEnableHighPassFilter(bool bEnable);
bool AUDIO_LineInMute(bool bMute);
bool AUDIO_MicMute(bool bMute);
bool AUDIO_SetInputSource(alt_u8 InputSource);
bool AUDIO_SetSampleRate(alt_u8 SampleRate);
bool AUDIO_DacDeemphasisControl(alt_u8 deemphasis_type);
bool AUDIO_DacEnableSoftMute(bool bEnable);
bool AUDIO_DacEnableZeroCross(bool bEnable);
bool AUDIO_Reset(void);
bool AUDIO_InterfaceActive(bool bActive);
bool AUDIO_EnableByPass(bool bEnable);
bool AUDIO_EnableSiteTone(bool bEnable);

// play & record
bool AUDIO_DacFifoNotFull(void);
void AUDIO_DacFifoSetData(short ch_left, short ch_right);
bool AUDIO_AdcFifoNotEmpty(void);
void AUDIO_AdcFifoGetData(short *pch_left, short *pch_right);
void AUDIO_FifoClear(void);







#endif /*AUDIO_H_*/
