#include <QDebug>
#include "hps.h"
#include "ADLX345.h"
#include <stdint.h>

//#include <sys/types.h>
#include <sys/ioctl.h>
#include <linux/i2c-dev.h>
#include <fcntl.h>


#include <unistd.h>
#include <sys/mman.h>
//#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"


#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

#define USER_IO_DIR     (0x01000000)
#define BIT_LED         (0x01000000)
#define BUTTON_MASK     (0x02000000)

HPS::HPS()
{
    m_file_gsensor = GsensorInit();
    PioInit();
}

HPS::~HPS()
{
    //----- release pio resource
        // clean up our memory mapping and exit
    munmap( m_virtual_base, HW_REGS_SPAN );
    close( m_file_mem );
}



bool HPS::LedSet(bool bOn){
    if (m_file_mem == -1){
        qDebug() << "Led Set Failed.\r\n";
        return false;
    }

    if (!bOn){ //
        alt_clrbits_word((void *) ( (char *)m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) )) , BIT_LED );
    }else{
        alt_setbits_word((void *) ( (char *)m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), BIT_LED );
    }

    return true;

}

bool HPS::IsButtonPressed(){
    bool bIsPressed;
    uint32_t scan_input;

    scan_input = ~alt_read_word( (void *) ((char *)m_virtual_base + ( ( uint32_t )(  ALT_GPIO1_EXT_PORTA_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ) );
    scan_input = scan_input; // key is active low ?

    bIsPressed = (scan_input & BUTTON_MASK)?true:false;

    //qDebug() << "button scan code:" << scan_input;

    return bIsPressed;
}


bool HPS::PioInit(){
    m_file_mem = open( "/dev/mem", ( O_RDWR | O_SYNC ) );
    if (m_file_mem != -1){
        m_virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, m_file_mem, HW_REGS_BASE );

        // configure LED as output pin
        alt_setbits_word((void *) ( (char *)m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DDR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), USER_IO_DIR );
    }else{
        qDebug() << "PioInit failed.\r\n";
        return false;
    }

    return true;

}

int HPS::GsensorInit(){
    int file;
    // gsensor i2c driver
    file = open("/dev/i2c-0", O_RDWR);
    if (file >= 0){
        if (ioctl(file, I2C_SLAVE, 0b01010011) < 0){
          //  fclose(file_gsensor);
            file = -1;
        }else{
            ADXL345_Init(file);
        }
    }
    return file;
}

bool HPS::GsensorQuery(int16_t *X, int16_t *Y, int16_t *Z){
    bool bSuccess = false;
    uint16_t szXYZ[3];
    const int mg_per_digi = 4;

    if (m_file_gsensor >=0 && ADXL345_IsDataReady(m_file_gsensor)){
        bSuccess = ADXL345_XYZ_Read(m_file_gsensor, szXYZ);
        if (bSuccess){
            *X = (int16_t)szXYZ[0]*mg_per_digi;
            *Y = (int16_t)szXYZ[1]*mg_per_digi;
            *Z = (int16_t)szXYZ[2]*mg_per_digi;
        }
    }


    return bSuccess;

}
