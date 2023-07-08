#include "terasic_includes.h"
#include "adc_spi_read.h"

#define START_FLAG  0x8000
#define DONE_FLAG   0x8000

alt_u16 ADC_Read(alt_u8 NextChannel){
    alt_u16 Data16, DigitalValue = 0;
    bool bDone = FALSE;
    const int nMaxWait = 1000;
    int nWaitCnt = 0;
    
    // start
    Data16 = NextChannel;
    IOWR(ADC_SPI_READ_BASE, 0, Data16);
    Data16 |= START_FLAG;
    IOWR(ADC_SPI_READ_BASE, 0, Data16);
    usleep(10000); // wait 10ms
    
    // wait done
    while(!bDone && nWaitCnt++ <= nMaxWait){
        Data16 = IORD(ADC_SPI_READ_BASE,0);
        bDone = (Data16 & DONE_FLAG)?TRUE:FALSE;
    }
    
    if (bDone)
        DigitalValue = Data16 & 0xFFF; // 12 bits
    
    // stop
    IOWR(ADC_SPI_READ_BASE, 0, 0);
    
    return DigitalValue;
}
