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
    bool KeyRead(uint32_t *mask);
    bool SwitchRead(uint32_t *mask);


protected:
    bool m_bInitSuccess;
    int m_file_mem;

    uint8_t *m_led_base;
    uint8_t *m_key_base;
    uint8_t *m_sw_base;

    bool Init();

};

#endif // FPGA_H
