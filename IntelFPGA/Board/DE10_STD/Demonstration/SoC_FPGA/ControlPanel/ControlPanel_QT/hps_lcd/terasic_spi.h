#ifndef TERASIC_SPI_H
#define TERASIC_SPI_H

#include <stdint.h>
#include <linux/spi/spidev.h>



class TERASIC_SPI
{
public:
    TERASIC_SPI(void);
    ~TERASIC_SPI(void);

    bool Connect();
    bool Disconnect(void);
    bool IsConnected(void);

private:
    int m_fd;
    uint32_t m_virtual_base;	
    bool m_bIsConnected;
	
protected:	
    
    bool Write8(uint8_t Data8);


};

#endif // TERASIC_SPI_H
