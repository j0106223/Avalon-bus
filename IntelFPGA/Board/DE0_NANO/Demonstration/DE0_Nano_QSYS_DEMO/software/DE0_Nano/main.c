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

#include "terasic_includes.h"
#include "accelerometer_adxl345_spi.h"
#include "flash.h"
#include "adc_spi_read.h"
#include "I2C.h"

typedef void (* MY_TEST_FUNC)(void);

void DEMO_ACCELEROMETER(void);
void DEMO_ADC(void);
void DEMO_EEPROM(void);
void DEMO_EPCS(void);

typedef enum{
    T_EERPOM,
    T_EPCS,
    T_GSENSOR,
    T_ADC,
}LOCAL_TEST_ITEM;

typedef struct{
    LOCAL_TEST_ITEM TestId; 
    char szName[64];
    MY_TEST_FUNC Func;
}TEST_ITEM_INFO;

static TEST_ITEM_INFO szTestList[] = {
    {T_GSENSOR, "ACCELEROMETER", DEMO_ACCELEROMETER},
    {T_ADC, "ADC", DEMO_ADC},
    {T_EERPOM, "EEPROM", DEMO_EEPROM},
    {T_EPCS, "EPCS", DEMO_EPCS},
};


bool bKeyPressed = FALSE;

#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
void KEY_ISR(void* context){

        bKeyPressed = TRUE;

        // clear interrupt flag
        IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE,0);

}

#else
void KEY_ISR(void* context, alt_u32 id){
    if (id == KEY_IRQ){
        bKeyPressed = TRUE;

        // clear interrupt flag
        IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE,0);
    }
}
#endif

//void KEY_ISR(void* context, alt_u32 id){
//    if (id == KEY_IRQ){
//        bKeyPressed = TRUE;
        
        // clear interrupt flag
//        IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE,0);
//    }
//}

void EnableKeyInterrupt(void){
    int error;
    
    // enable interrupt, 2-keybutton
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(KEY_BASE,0x03);
    
    // clear capture flag
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE,0);
    //

    bKeyPressed = FALSE;
    // register interrupt isr    
    error = alt_irq_register (KEY_IRQ, 0, KEY_ISR);
    if (error)
        printf("Failed to register interrut\r\n");
    
}




void ShowMenu(void){
    int i,num;
    printf("---------------------------------\r\n");
    printf("- Selection function:\r\n");
    num = sizeof(szTestList)/sizeof(szTestList[0]);
    for(i=0;i<num;i++){
        printf("- [%d]%s\r\n", i, szTestList[i].szName);
    }    
    printf("---------------------------------\r\n");
}



int main(void)
{

    int sel;
    int nNum;
    
    
    nNum = sizeof(szTestList)/sizeof(szTestList[0]);
    printf("DE-Nano Demo\r\n");
    
    // enble key interrupt
    EnableKeyInterrupt();  
    
    while(1){
        ShowMenu();
        printf("Select:");
        scanf("%d", &sel);
        if (sel >= 0 && sel < nNum){
            bKeyPressed = FALSE;
            printf("Demo %s\r\n",szTestList[sel].szName); 
            szTestList[sel].Func();
        }else{
            printf("Invalid Selection\r\n");
        }
        sel++;

    }

    return 0;
    
       
}


void DEMO_ACCELEROMETER(void){
    bool bSuccess;
    alt_16 szXYZ[3];
    alt_u8 id;
    const int mg_per_digi = 4;

    // release i2c pio pin 
    //IOWR_ALTERA_AVALON_PIO_DIRECTION(I2C_SCL_BASE, ALTERA_AVALON_PIO_DIRECTION_OUTPUT);    
    //IOWR_ALTERA_AVALON_PIO_DIRECTION(I2C_SDA_BASE, ALTERA_AVALON_PIO_DIRECTION_INPUT);
    IOWR(SELECT_I2C_CLK_BASE, 0, 0x00);
    
    // configure accelerometer as +-2g and start measure
    bSuccess = ADXL345_SPI_Init(GSENSOR_SPI_BASE);
    if (bSuccess){
        // dump chip id
        bSuccess = ADXL345_SPI_IdRead(GSENSOR_SPI_BASE, &id);
        if (bSuccess)
            printf("id=%02Xh\r\n", id);
    }        
    
    if (bSuccess)
        printf("Monitor Accerometer Value. Press KEY0 or KEY1 to terminal the monitor process.\r\n");
    
    while(bSuccess && !bKeyPressed){
        if (ADXL345_SPI_IsDataReady(GSENSOR_SPI_BASE)){
            bSuccess = ADXL345_SPI_XYZ_Read(GSENSOR_SPI_BASE, szXYZ);
            if (bSuccess){
                printf("X=%d mg, Y=%d mg, Z=%d mg\r\n", szXYZ[0]*mg_per_digi, szXYZ[1]*mg_per_digi, szXYZ[2]*mg_per_digi);
                // show raw data, 
                //printf("X=%04x, Y=%04x, Z=%04x\r\n", (alt_u16)szXYZ[0], (alt_u16)szXYZ[1],(alt_u16)szXYZ[2]);
                usleep(1000*1000);
            }
        }
    }
    
    if (!bSuccess)
        printf("Failed to access accelerometer\r\n");
    
}

void DEMO_ADC(void){
    int ch = 0, next_ch=0;
    alt_u16 data16;
    
    printf("Monitor ADC Value. Press KEY0 or KEY1 to terminal the monitor process.\r\n");
    ADC_Read(next_ch);
    while(!bKeyPressed){
        next_ch++;
        if (next_ch >= 8)
            next_ch = 0;        
        data16 = ADC_Read(next_ch); // 12-bits resolution
        printf("CH%d=%.2f V\r\n", ch, (float)data16 * 3.3 / 4095.0);
        ch = next_ch;
        
    }        
}

void DEMO_EEPROM(void){
    alt_u8 szBuf[16];
    int i,Num;
    const alt_u8 DeviceAddr = 0xA0;
    const alt_u8 ControlAddr = 00;
    
    // set clock as output
    //IOWR_ALTERA_AVALON_PIO_DIRECTION(I2C_SCL_BASE, ALTERA_AVALON_PIO_DIRECTION_OUTPUT);
    IOWR(SELECT_I2C_CLK_BASE, 0, 0x01);
    
    if (I2C_MultipleRead(I2C_SCL_BASE, I2C_SDA_BASE, DeviceAddr, ControlAddr, szBuf, sizeof(szBuf))){
        Num = sizeof(szBuf)/sizeof(szBuf[0]); 
        for(i=0;i<Num;i++){
            printf("Addr[%02d] = %02xh\r\n", i, szBuf[i]);
        }
    }else{
        printf("Failed to access EEPROM\r\n");
    }

    
}

void DEMO_EPCS(void){
    alt_u32 MemSize;
    MemSize = Flash_Size(EPCS_NAME);
    printf("EPCS Size:%d Bytes (%d MB)\r\n", (int)MemSize, (int)MemSize/1024/1024);
    
}

