// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
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
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "hwlib.h"
#include "lcd_graphic.h"

//#include "font.h"


LCD_GRAPHIC::LCD_GRAPHIC(void){

    m_Canvas.Width = 128;
    m_Canvas.Height = 64;
    m_Canvas.BitPerPixel = 1;
    m_Canvas.FrameSize = 128*64/8;
    m_Canvas.pFrame = new uint8_t[m_Canvas.FrameSize];
    memset(m_Canvas.pFrame, 0x00, m_Canvas.FrameSize);
    
}    

LCD_GRAPHIC::~LCD_GRAPHIC(void){
    if (m_Canvas.pFrame)
        delete []m_Canvas.pFrame;
}  


//////////////////////////////////////////////
// lowest level API
void LCD_GRAPHIC::Pixel(int X, int Y, int Color){
    int nLine;
    uint8_t *pFrame, Mask;
    
    if (m_Canvas.BitPerPixel == 1){

    	nLine = Y >> 3; //Y/8;
    	Mask = 0x01 << (Y % 8);
    	pFrame = m_Canvas.pFrame + m_Canvas.Width*nLine + X;
    	if (Color == 0x00)
      	  *pFrame &= ~Mask;
    	else
      	  *pFrame |= Mask;
   }
}


////////////////////////////////////////////////
// high-level API for developer


// !!!! noe. this fucntion is LCD hardware depentdent
void LCD_GRAPHIC::Refresh(void){
	if (IsConnected())
		LCD_FrameCopy(m_Canvas.pFrame);
	else
		printf("[LCD_GRAPHIC::Refresh]: LCD is not conntected!\r\n");
}




void LCD_GRAPHIC::Line(int X1, int Y1, int X2, int Y2, int Color){
    int X_Start, X_End;
    int Y_Start, Y_End;
    int x,y, acc=0, inc, x_delta, y_delta;

    if (X1 == X2){
        if (Y1 <= Y2){
            Y_Start = Y1;
            Y_End = Y2;
        }else{
            Y_Start = Y2;
            Y_End = Y1;
        }
        for(y=Y_Start;y<Y_End;y++)
            Pixel(X1, y, Color);
    }else if (Y1 == Y2){
        if (X1 <= X2){
            X_Start = X1;
            X_End = X2;
        }else{
            X_Start = X2;
            X_End = X1;
        }
        for(x=X_Start;x<X_End;x++){
            Pixel(x, Y1, Color);
        }
    }else if (abs(X1-X2) >= abs(Y1-Y2)){
        if (X1 <= X2){
            X_Start = X1;
            Y_Start = Y1;
            X_End = X2;
            Y_End = Y2;
        }else{
            X_Start = X2;
            Y_Start = Y2;
            X_End = X1;
            Y_End = Y1;
        }

        x_delta = X_End - X_Start;
        y_delta = Y_End - Y_Start;
        inc = (y_delta >= 0)?1:-1;
        y_delta = abs(y_delta);
        acc = x_delta/2;
        y = Y_Start;

        for(x=X_Start;x<X_End;x++){
            Pixel(x, y, Color);
            acc +=  y_delta;
            if (acc >= x_delta){
                y += inc;
                acc -= x_delta;
            }
        }
    }else{
        if (Y1 <= Y2){
            X_Start = X1;
            Y_Start = Y1;
            X_End = X2;
            Y_End = Y2;
        }else{
            X_Start = X2;
            Y_Start = Y2;
            X_End = X1;
            Y_End = Y1;
        }

            y_delta = Y_End - Y_Start;
            x_delta = X_End - X_Start;
            inc = (x_delta >= 0)?1:-1;
            x_delta = abs(x_delta);
            acc = y_delta/2;
            x = X_Start;

            for(y=Y_Start;y<Y_End;y++){
                Pixel(x, y, Color);
                acc +=  x_delta;
                if (acc >= y_delta){
                    x += inc;
                    acc -= y_delta;
                }
            }

    }


}

void LCD_GRAPHIC::Rect(int X1, int Y1, int X2, int Y2, int Color){
    Line(X1, Y1, X2, Y1, Color);
    Line(X2, Y1, X2, Y2, Color);
    Line(X2, Y2, X1, Y2, Color);
    Line(X1, Y2, X1, Y1, Color);
}

void LCD_GRAPHIC::Circle(int x0, int y0, int Radius, int Color){
  int x = Radius, y = 0;
  int radiusError = 1-x;
 
  while(x >= y)
  {
   Pixel(x + x0, y + y0, Color);
   Pixel(y + x0, x + y0, Color);
   Pixel(-x + x0, y + y0, Color);
   Pixel(-y + x0, x + y0, Color);
   Pixel(-x + x0, -y + y0, Color);
   Pixel(-y + x0, -x + y0, Color);
   Pixel(x + x0, -y + y0, Color);
   Pixel(y + x0, -x + y0, Color);
 
    y++;
        if(radiusError<0)
                radiusError+=2*y+1;
        else
        {
                x--;
                radiusError+=2*(y-x)+1;
        }
  }
}


void LCD_GRAPHIC::Clear(int nValue){
    int y,x;
    for(y=0;y<m_Canvas.Height;y++){
        for(x=0;x<m_Canvas.Width;x++){
            Pixel(x, y, nValue);
        }
    }

}


int LCD_GRAPHIC::FrameWidth(void){
    return m_Canvas.Width;
}

int LCD_GRAPHIC::FrameHeight(void){
    return m_Canvas.Height;
}

void LCD_GRAPHIC::Demo(void){
  //  Backlight(true);
    Clear(COLOR_WHITE);
    Rect(0,0,FrameWidth()-1, FrameHeight()-1, COLOR_BLACK);
    Line(0,0,20,20, COLOR_BLACK);
    Line(20,20,FrameWidth()-1, 0, COLOR_BLACK);
    Circle(10, FrameHeight()-11, 8, COLOR_BLACK);
    Circle(FrameWidth()-11, FrameHeight()-11, 8, COLOR_BLACK);
    PrintString(15,25,"Hello, World!", COLOR_BLACK, &font_16x16);
    Refresh();

}

void LCD_GRAPHIC::Demo_Checkerboard(int nSize){
    int x, y;
    for(y=0;y<FrameHeight();y++){
        for(x=0;x<FrameWidth();x++){
            if (((x)%(2*nSize) < nSize) ^ ((y)%(2*nSize) < nSize))
                Pixel(x,y,COLOR_WHITE);
            else
                Pixel(x,y,COLOR_BLACK);
        }
    }
    Refresh();

}


#ifdef SUPPORT_LCD_FONT
////////////////////////////////////////////////
/// FONT API ///////////////////////////////////
////////////////////////////////////////////////

void LCD_GRAPHIC::PrintChar(int X0, int Y0, const char Text, int Color, FONT_TABLE *font_table){
    unsigned char *pFont;
    uint8_t Mask;
    int x, y, p;

    for(y=0;y<2;y++){
        Mask = 0x01;
        for(p=0;p<8;p++){
            pFont = font_table->pBitmap[(unsigned char)Text][y];
        	
//            pFont = font_table[y];
//            pFont = (unsigned char *)&(font_table[Text][y][0]);
//            pFont = &(font_courier_new_16x16[(unsigned char)Text][y][0]);
            for(x=0;x<16;x++){
                if (Mask & *pFont)
                    Pixel(X0+x, Y0+y*8+p, Color);
                pFont++;
            }
            Mask <<= 1;
        }
    }

}

void LCD_GRAPHIC::PrintString(int X0, int Y0, const char* pText, int Color, FONT_TABLE *font_table){

    int nLen, i;

    nLen = strlen(pText);

    for(i=0;i<nLen;i++){
        PrintChar(X0+i*font_table->FontWidth, Y0, *(pText+i), Color, font_table);
    }

}


#endif //SUPPORT_LCD_FONT
