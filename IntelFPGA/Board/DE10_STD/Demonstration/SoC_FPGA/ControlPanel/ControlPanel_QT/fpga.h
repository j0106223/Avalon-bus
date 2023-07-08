#ifndef FPGA_H
#define FPGA_H

#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>


class FPGA
{
public:
    FPGA();
    ~FPGA();

    typedef enum{
        TONE_C=0,
        TONE_D,
        TONE_E,
        TONE_F,
        TONE_G,
        TONE_A,
        TONE_B
    }TONE_ID;

    bool LedSet(int mask);
    bool HexSet(int index, int value);
    bool KeyRead(uint32_t *mask);
    bool SwitchRead(uint32_t *mask);
    bool VideoEnable(bool bEnable);
    bool VideoMove(int x, int y);
    bool IsVideoEnabled();
    bool IrDataRead(uint32_t *scan_code);
    bool IrIsDataReady(void);
    bool PlayTone(TONE_ID ToneID, uint32_t dur_ms=200 /* 0.2 second */);



protected:
    bool m_bInitSuccess;
    int m_file_mem;
    bool m_bIsVideoEnabled;

    uint8_t *m_led_base;
    uint8_t *m_hex_base;
    uint8_t *m_key_base;
    uint8_t *m_sw_base;
    uint8_t *m_ir_rx_base;
    uint8_t *m_adc_spi_base;
    uint8_t *m_vip_cvi_base;
    uint8_t *m_vip_mix_base;
    uint8_t *m_audio_base;

    bool Init();

};

#endif // FPGA_H
