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

    bool LedSet(int mask);
    bool HexSet(int index, int value);
    bool KeyRead(uint32_t *mask);
    bool SwitchRead(uint32_t *mask);
    bool VideoEnable(bool bEnable);
    bool VideoMove(int x, int y);
    bool IsVideoEnabled();
    bool IrDataRead(uint32_t *scan_code);
    bool IrIsDataReady(void);


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
    uint8_t *m_vip_cti_base;
    uint8_t *m_vip_mix_base;

    bool Init();

};

#endif // FPGA_H
