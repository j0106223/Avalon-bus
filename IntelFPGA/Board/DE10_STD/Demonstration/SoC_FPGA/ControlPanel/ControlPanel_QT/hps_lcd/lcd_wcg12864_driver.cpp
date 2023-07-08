
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdint.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "socal/alt_spim.h"
#include "socal/alt_rstmgr.h"
#include "lcd_wcg12864_driver.h"

#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

#define HPS_LCM_D_C_BIT_GPIObit41_GPIOreg1	    	( 0x00001000 )
#define HPS_LCM_RESETn_BIT_GPIObit44_GPIOreg1   	( 0x00008000 )
#define HPS_LCM_BACKLIHGT_BIT_GPIObit37_GPIOreg1	( 0x00000100 )


LCD_WCG12864::LCD_WCG12864():
    m_bPreIsData(0xFF){

    m_fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) );
    if (m_fd == -1){
        printf("Error: failed to open memory map driver!\r\n");
        return;
    }

        m_virtual_base = (uint32_t) mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, m_fd, HW_REGS_BASE );

        // set the direction of the HPS GPIO1 bits attached to LCD RESETn to output & output high
        alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DDR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_RESETn_BIT_GPIObit44_GPIOreg1 );
        alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_RESETn_BIT_GPIObit44_GPIOreg1 );

        // set the direction of the HPS GPIO1 bits attached to LCD Backlight to output & output zero to turn off backlight
        alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DDR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_BACKLIHGT_BIT_GPIObit37_GPIOreg1 );
        alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_BACKLIHGT_BIT_GPIObit37_GPIOreg1 );

        // set LCD-A0 pin as output pin & output zero
        alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DDR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_D_C_BIT_GPIObit41_GPIOreg1 );
        alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_D_C_BIT_GPIObit41_GPIOreg1 );


}

LCD_WCG12864::~LCD_WCG12864(){
    TERASIC_SPI::Disconnect();
    close(m_fd);
}

void LCD_WCG12864::Hardware_Reset(){

    // set the value of the HPS GPIO1 bits attached to LCD RESETn to zero
    alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_RESETn_BIT_GPIObit44_GPIOreg1 );
    usleep( 1000000 / 16 );
    // set the value of the HPS GPIO1 bits attached to LCD RESETn to one
    alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_RESETn_BIT_GPIObit44_GPIOreg1 );
    usleep( 1000000 / 16 );
}

void LCD_WCG12864::Backlight(bool bOn){
    if (bOn)
        alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_BACKLIHGT_BIT_GPIObit37_GPIOreg1 );
    else
        alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_BACKLIHGT_BIT_GPIObit37_GPIOreg1 );

}

void LCD_WCG12864::Hardware_DC_Set(bool bIsData){
    // D_C = "H": Data
    // D_C = "L": CMD

    if (bIsData) // A0 = "H": Data
        alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_D_C_BIT_GPIObit41_GPIOreg1 );
    else
        alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_LCM_D_C_BIT_GPIObit41_GPIOreg1 );
}

//write data or control byte
bool LCD_WCG12864::LCDHW_Write8(uint8_t bIsData, uint8_t Data){
	bool bSuccess;
    //static uint8_t bPreIsData=0xFF;

    // set A0
    if (m_bPreIsData != bIsData){
        // Note. cannot change D_C until all tx dara(or command) are sent. i.e. fifo is empty
        //  while(!SPIM_IsTxEmpty()); // wait if buffer is not empty

        Hardware_DC_Set(bIsData);
        m_bPreIsData = bIsData;
    }else{
        // wait buffer is not full
        //  while(SPIM_IsTxFull()); // wait if buffer is full
    }

    bSuccess = TERASIC_SPI::Write8(Data);
    	
    return bSuccess;
}

bool LCD_WCG12864::Init(void){
		bool bSuccess; 
		
		UnInit();
		
    Hardware_Reset();
    Backlight(false);		
		
		bSuccess = Connect();
		if (!bSuccess)
				return bSuccess;

  //  Display_Reset();


    // (3) ADC select: Normal display (ADC command D0 = “L”)
   // Display_SetADC(true); // normal


    // Common output state selection (~normal)
    SetOuputStatusSelect(false); // invert to match mechanisum

    // (6) LCD Bias (true:default)
  //  Display_SetBias(true);//

    // (4 ?) Power control register (D2, D1, D0) = (follower, regulator, booster) = (1, 1, 1)
    SetPowerControl(0x07);

    // Setting the build-in resistance radio
   // Display_SetResistorRatio(4);

    // Electronic volume control (adjust brightnesss: 0x01~0x3F, 0x20:disable)
    //  Display_SetElectricVolume(0x20);
    //Display_SetOsc(true);

    // delay
    //usleep(5u);

    // (9) set display start line: at first line
    SetStartLine(0);


    // (11) Page address register set at page 0
    SetPageAddr(0);
    // (10) Column address counter set at address 0
    SetColAddr(0);

    // Display on
    Display(true);
    
    return bSuccess;
}

void LCD_WCG12864::UnInit(void){
		Disconnect();
}

void LCD_WCG12864::SetStartAddr(uint8_t x, uint8_t y){
    SetPageAddr(y/8);
    SetColAddr(x);

}

bool LCD_WCG12864::Fill(uint8_t Pattern){
    int Page, i;

    if (!IsConnected())
        return false;

    for(Page=0;Page<8;Page++){
        SetPageAddr(Page);
        SetColAddr(0);
        for(i=0;i<132;i++){
            WriteData(Pattern);
        }
    }
    return true;
}

void LCD_WCG12864::LCD_FrameCopy(uint8_t *Data){
    int Page;

    uint8_t *pPageData = Data;
    for(Page=0;Page<8;Page++){
        SetStartAddr(0, Page*8);
        WriteMultiData(pPageData, 128);
        pPageData += 128;
    }
}



void LCD_WCG12864::Display(bool bOn){
    LCDHW_Write8(0,bOn?0xAF:0xAE);
}

// Specifies line address (refer to Figure 6) to determine the initial display line
// When this command changes the line address, smooth scrolling or a page change takes place
void LCD_WCG12864::SetStartLine(uint8_t StartLine){
    LCDHW_Write8(0,0x40 | (StartLine & 0x3F));
}


void LCD_WCG12864::SetPageAddr(uint8_t PageAddr){
    LCDHW_Write8(0,0xB0 | (PageAddr & 0x0F));
}


void LCD_WCG12864::SetColAddr(uint8_t ColAddr){
    LCDHW_Write8(0,0x00 | (ColAddr & 0x0F)); // low 4 bits
    LCDHW_Write8(0,0x10 | ((ColAddr >> 4) & 0x0F)); // high 4-bits


}


void LCD_WCG12864::WriteData(uint8_t Data){
    LCDHW_Write8(1, Data);
}

void LCD_WCG12864::WriteMultiData(uint8_t * Data, uint16_t num){
    int i;
    for(i=0;i<num;i++)
        LCDHW_Write8(1, *(Data+i));
}


void LCD_WCG12864::SetADC(bool bNormal){
    LCDHW_Write8(0, bNormal?0xA0:0xA1);
}

void LCD_WCG12864::SetReverse(bool bNormal){
    LCDHW_Write8(0, bNormal?0xA6:0xA7);
}

void LCD_WCG12864::EntireOn(bool bEntireOn){
    LCDHW_Write8(0, bEntireOn?0xA5:0xA4);
}

void LCD_WCG12864::SetBias(bool bDefault){
    LCDHW_Write8(0, bDefault?0xA2:0xA3);
}

// Once Read-Modify-Write is issued, column address is not incremental by Read Display Data command
// but incremental by Write Display Data command only.
// It continues until End command is issued.
void LCD_WCG12864::ReadModifyWrite_Start(void){
    LCDHW_Write8(0, 0xE0);
}

void LCD_WCG12864::ReadModifyWrite_End(void){
    LCDHW_Write8(0, 0xEE);
}

void LCD_WCG12864::Reset(void){
    LCDHW_Write8(0, 0xE2);
}


void LCD_WCG12864::SetOsc(bool bDefault){
    LCDHW_Write8(0, bDefault?0xE4:0xE5);
}

void LCD_WCG12864::SetPowerControl(uint8_t PowerMask){
    LCDHW_Write8(0, 0x28 | (PowerMask & 0x7));
}

void LCD_WCG12864::SetResistorRatio(uint8_t Value){
    LCDHW_Write8(0, 0x20 | (Value & 0x7));
}


void LCD_WCG12864::SetElectricVolume(uint8_t Value){
    // write two bytes
    LCDHW_Write8(0, 0x81);
    LCDHW_Write8(0, Value & 0x3F);
}

void LCD_WCG12864::SetOuputStatusSelect(bool bNormal){
    LCDHW_Write8(0, bNormal?0xC0:0xC8);
}




