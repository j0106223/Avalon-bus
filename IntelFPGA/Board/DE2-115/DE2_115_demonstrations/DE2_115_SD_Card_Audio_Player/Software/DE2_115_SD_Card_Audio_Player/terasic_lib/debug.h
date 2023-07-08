#ifndef DEBUG_H_
#define DEBUG_H_



int myprintf(char *format, ...);
int myprintf_hexarray(unsigned char *pHex, int len);
int myprintf_dwordarray(unsigned int *pArray, int nElementCount);




//============== debug config ===================
#define DEBUG_ENABLED   // major control (turn off all of debug message)
#define xENABLE_UART_DEBUG


#define DEBUG_APP
#define DEBUG_ENET          
#define DEBUG_I2C
#define DEBUG_AUDIO
#define xDEBUG_FLASH
#define xDEBUG_SDCARD
#define DEBUG_FAT           
#define DEBUG_USB_ISR
#define xDEBUG_USB_PORT
#define xDEBUG_USB_PTD
#define xDEBUG_USB_HAL4D13
#define xDEBUG_USB_REG
#define xDEBUG_USB_LB     // USB LOOPBACK TEST
#define xDEBUG_USB_MOUSE
#define xDEBUG_PS2
#define DEBUG_USB_DEVICE
#define DEBUG_USB_BUF
#define DEBUG_JTAG

// debug macro
#ifdef DEBUG_ENABLED
    #define DEBUG(x)               {myprintf x;}  // standard in/out, specifed in project (it could be uart, jtag, or lcd)
    #define DEBUG_HEX_ARRAY(x)     {myprintf_hexarray x;}
    #define DEBUG_DWORD_ARRAY(x)   {myprintf_dwordarray x;}
#else
    #define DEBUG(x)              
    #define DEBUG_HEX_ARRAY(x)    
    #define DEBUG_DWORD_ARRAY(x)  
#endif

#endif /*DEBUG_H_*/
