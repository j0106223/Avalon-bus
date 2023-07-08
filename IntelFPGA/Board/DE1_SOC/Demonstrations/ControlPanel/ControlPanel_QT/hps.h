#ifndef HPS_H
#define HPS_H

#include <stdint.h>


class HPS
{
public:
    HPS();
    ~HPS();

    bool LedSet(bool bOn);
    bool IsButtonPressed();
    bool GsensorQuery(int16_t *X, int16_t *Y, int16_t *Z);

protected:
    // pio
    int m_file_mem;
    void *m_virtual_base;


    bool PioInit();

    // gsensor
    int m_file_gsensor;
    int GsensorInit();

};

#endif // HPS_H
