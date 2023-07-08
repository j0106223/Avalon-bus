#ifndef _INC_LCD_GRAPHIC_H_
#define _INC_LCD_GRAPHIC_H_

#include "lcd_wcg12864_driver.h"

#define SUPPORT_LCD_FONT

#ifdef SUPPORT_LCD_FONT
		#include "font.h"
#endif		


#define LCD_WHITE   0x00
#define LCD_BLACK   0xFF

class LCD_GRAPHIC : public LCD_WCG12864
{
public:
    enum{
        COLOR_WHITE = 0,
        COLOR_BLACK = 1
    };

    LCD_GRAPHIC();
    ~LCD_GRAPHIC();

    void Clear(int Color=COLOR_WHITE);
    void Line(int X1, int Y1, int X2, int Y2, int Color);
    void Pixel(int X, int Y, int Color);
    void Rect(int X1, int Y1, int X2, int Y2, int Color);
    void Circle(int x0, int y0, int Radius, int Color);
    void Refresh(void); // update to hardware
    int FrameWidth(void);
    int FrameHeight(void);

        // demo
    void Demo(void);
    void Demo_Checkerboard(int nSize);
		
		#ifdef SUPPORT_LCD_FONT

		void PrintChar(int X0, int Y0, const char Text, int Color, FONT_TABLE *font_table);
		void PrintString(int X0, int Y0, const char *pText, int Color, FONT_TABLE *font_table);

		#endif //SUPPORT_LCD_FONT		

protected:

     //   LCD_WCG12864 m_LcdDriver_WCG12864;

    
	typedef struct{
      int Width;
    	int Height;
    	int BitPerPixel;
    	int FrameSize;
    	uint8_t *pFrame;
	}LCD_CANVAS;   
	
	LCD_CANVAS m_Canvas; 


};






#endif

