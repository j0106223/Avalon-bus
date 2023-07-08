#ifndef HPS_AUDIO_H
#define HPS_AUDIO_H



class HPS_AUDIO
{
public:
    typedef enum{
        TONE_C=0,
        TONE_D,
        TONE_E,
        TONE_F,
        TONE_G,
        TONE_A,
        TONE_B,
        TONE_NUM
    }TONE_ID;

    HPS_AUDIO();

    static bool PlayTone(TONE_ID ToneID, uint32_t dur_ms=200 /* 0.2 second */);
    static bool PlayTone(float fToneFrequencyHz, uint32_t dur_ms);




protected:

};

#endif // HPS_AUDIO_H
