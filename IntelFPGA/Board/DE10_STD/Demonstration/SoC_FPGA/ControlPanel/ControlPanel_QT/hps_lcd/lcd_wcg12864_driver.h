
#ifndef _LCD_WCG12864_H_
#define _LCD_WCG12864_H_

#include "terasic_spi.h"



class LCD_WCG12864 : public TERASIC_SPI
{
public:
    LCD_WCG12864();
    ~LCD_WCG12864();
    
    // high level
    bool Init(void);
    void UnInit(void);
    bool Fill(uint8_t Pattern=0x00);

    // backlight & reset
    void Backlight(bool bOn);

    
protected:
	

    	
    // register control
    void SetStartAddr(uint8_t x, uint8_t y);
    void Display(bool bOn);
		void SetStartLine(uint8_t StartLine);
		void SetPageAddr(uint8_t PageAddr);
		void SetColAddr(uint8_t ColAddr);
		void WriteData(uint8_t Data);
		void WriteMultiData(uint8_t * Data, uint16_t num);

		void SetADC(bool bNormal);
		void SetReverse(bool bNormal);
    void EntireOn(bool bEntireOn);
		void SetBias(bool bDefault);
		void ReadModifyWrite_Start(void);
		void ReadModifyWrite_End(void);
		void Reset(void);
		void SetOsc(bool bDefault);
		void SetPowerControl(uint8_t PowerMask);
		void SetResistorRatio(uint8_t Value);
		void SetOuputResistorRatio(uint8_t Value);
    void SetElectricVolume(uint8_t Value);
		void SetOuputStatusSelect(bool bNormal);
		


protected:
    int m_fd;
    //void *m_virtual_base;
    uint32_t m_virtual_base;
		uint8_t m_bPreIsData=0xFF;
		
    bool LCDHW_Write8(uint8_t bIsData, uint8_t Data); // write data or control byte
    
    void Hardware_DC_Set(bool bIsData);
    void Hardware_Reset();
  //  void LCD_Clear(void);
    void LCD_FrameCopy(uint8_t *Data);
		


};

#endif //_LCD_WCG12864_H_
