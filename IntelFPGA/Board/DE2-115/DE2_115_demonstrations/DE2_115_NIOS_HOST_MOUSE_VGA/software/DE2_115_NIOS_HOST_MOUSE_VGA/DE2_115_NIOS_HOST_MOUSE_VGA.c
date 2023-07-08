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
// Last Compile Tools: NIOS II 9.1 SP2(Build 350)
/* Revision 2.0
 * 
 * 
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <io.h>
#include <fcntl.h>

#include "system.h"
#include "alt_types.h"
#include <unistd.h>  // usleep 
#include "sys/alt_irq.h"

#include "cy7c67200.h"
#include "lcp_cmd.h"
#include "lcp_data.h"
#include "LCD.h"
#include "VGA.h"
#include "SEG7.h"

/* -----------------------------------------------------------------------
 * HPI implementation
 *
 * The c67x00 chip also support control via SPI or HSS serial
 * interfaces.  However, this driver assumes that register access can
 * be performed from IRQ context.  While this is a safe assuption with
 * the HPI interface, it is not true for the serial interfaces.
 */

/* HPI registers */
#define HPI_DATA    0
#define HPI_MAILBOX 1
#define HPI_ADDR    2
#define HPI_STATUS  3
//------------------------------ function declaration ----------------------------//
//-------------USB operation -----------
/*****************************************************************************/
/**
*
* This function writes data to the internal registers of the Cypress
* CY7C67200 USB controller.
*
* @param    Address is the address of the register.
* @param    Data is the data to be written to the register.
*
* @return   None
*
* @note     None
*
******************************************************************************/
void UsbWrite(alt_u16 Address, alt_u16 Data);

/*****************************************************************************/
/**
*
* This function reads data from the internal registers of the Cypress
* CY7C67200 USB controller.
*
* @param    Address is the address of the register.
*
* @return   The data read from the specified address
*
* @note     None
*
******************************************************************************/
alt_u16 UsbRead(alt_u16 Address);

/*****************************************************************************/
/**
*
* This function does a software reset of the Cypress CY7C67200 USB controller.
*
* @param    UsbBaseAddress is the starting location of the USB internal memory
*           to which this bin file data is written.
*
* @return   None
*
* @note     None
*
******************************************************************************/
void UsbSoftReset();
//--------------------------------------
int maxmin(int no, int max, int min)
{
 if(no>max) {no=max;}
 if(no<min) {no=min;}

 return(no);
}
//--------------------------------------
//----------clear screen----------------
void Vga_clear_screen(base)
{
    alt_u16 x_col,y_col;
    for(y_col=0;y_col<VGA_HEIGHT;y_col++)
      {
        for(x_col=0;x_col<VGA_WIDTH;x_col++)
        {
            Vga_Clr_Pixel(base,x_col,y_col);
        }
      }
}

//----------------------------------------------------------------------------------------//
//
//                                Main function
//
//----------------------------------------------------------------------------------------//
int main(void)
{
    alt_u16 intStat;
    alt_u16 usb_ctl_val;
    static alt_u16 ctl_reg = 0;
    static alt_u16 no_device = 0;
    alt_u16 fs_device = 0;
    int button_value;
    alt_u16 px = 320;
    alt_u16 py = 240; 
    signed char  dx = 0;
    signed char  dy = 0; 
    alt_u8  pbutton = 0;
    alt_u8 toggle=0;
    alt_u8 data_size;
    
    //VGA display initial
    
    VGA_Ctrl_Reg vga_ctrl_set;

    vga_ctrl_set.VGA_Ctrl_Flags.RED_ON    = 1;
    vga_ctrl_set.VGA_Ctrl_Flags.GREEN_ON  = 1;
    vga_ctrl_set.VGA_Ctrl_Flags.BLUE_ON   = 1;
    vga_ctrl_set.VGA_Ctrl_Flags.CURSOR_ON = 1;

    Vga_Write_Ctrl(VPG_BASE, vga_ctrl_set.Value);
    Vga_clear_screen(VPG_BASE); //clear the screen
    Set_Pixel_On_Color(512,512,512);
    Set_Pixel_Off_Color(0,0,0);
    Set_Cursor_Color(0,1023,0);
    LCD_Test();
    
    //----------------------------------------SIE1 initial---------------------------------------------------//
USB_HOT_PLUG:
    UsbSoftReset();
    UsbWrite (HPI_SIE1_MSG_ADR, 0);
    UsbWrite (HOST1_STAT_REG, 0xFFFF);
              
    /* Set HUSB_pEOT time */
    UsbWrite(HUSB_pEOT, 600); // adjust the according to your USB device speed
     
    usb_ctl_val = SOFEOP1_TO_CPU_EN | RESUME1_TO_HPI_EN;// | SOFEOP1_TO_HPI_EN;
    UsbWrite(HPI_IRQ_ROUTING_REG, usb_ctl_val);
    
    intStat = A_CHG_IRQ_EN | SOF_EOP_IRQ_EN ;
    UsbWrite(HOST1_IRQ_EN_REG, intStat); 

    UsbWrite(COMM_R0,0x0000);//reset time 
    UsbWrite(COMM_R1,0x0000);  //port number
    UsbWrite(COMM_R2,0x0000);  //r1
    UsbWrite(COMM_R3,0x0000);  //r1
    UsbWrite(COMM_R4,0x0000);  //r1
    UsbWrite(COMM_R5,0x0000);  //r1
    UsbWrite(COMM_R6,0x0000);  //r1
    UsbWrite(COMM_R7,0x0000);  //r1
    UsbWrite(COMM_R8,0x0000);  //r1
    UsbWrite(COMM_R9,0x0000);  //r1
    UsbWrite(COMM_R10,0x0000);  //r1
    UsbWrite(COMM_R11,0x0000);  //r1
    UsbWrite(COMM_R12,0x0000);  //r1
    UsbWrite(COMM_R13,0x0000);  //r1    
    UsbWrite(COMM_INT_NUM,HUSB_SIE1_INIT_INT); //HUSB_SIE1_INIT_INT
    IOWR(CY7C67200_BASE,HPI_MAILBOX,0xCE01);
     
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & 0xFFFF) )  //read sie1 msg register
    {
    }
    while (IORD(CY7C67200_BASE,HPI_MAILBOX) != COMM_ACK) 
    {
        printf("[ERROR]:routine mailbox data is %x\n",IORD(CY7C67200_BASE,HPI_MAILBOX));
        goto USB_HOT_PLUG;
    }
    
  
    //usleep(30*1000);    
    UsbWrite(COMM_INT_NUM,HUSB_RESET_INT); //husb reset
    UsbWrite(COMM_R0,0x003c);//reset time 
    UsbWrite(COMM_R1,0x0000);  //port number
    UsbWrite(COMM_R2,0x0000);  //r1
    UsbWrite(COMM_R3,0x0000);  //r1
    UsbWrite(COMM_R4,0x0000);  //r1
    UsbWrite(COMM_R5,0x0000);  //r1
    UsbWrite(COMM_R6,0x0000);  //r1
    UsbWrite(COMM_R7,0x0000);  //r1
    UsbWrite(COMM_R8,0x0000);  //r1
    UsbWrite(COMM_R9,0x0000);  //r1
    UsbWrite(COMM_R10,0x0000);  //r1
    UsbWrite(COMM_R11,0x0000);  //r1
    UsbWrite(COMM_R12,0x0000);  //r1
    UsbWrite(COMM_R13,0x0000);  //r1    

    IOWR(CY7C67200_BASE,HPI_MAILBOX,0xCE01);
  
    while (IORD(CY7C67200_BASE,HPI_MAILBOX) != COMM_ACK) 
    {
        printf("[ERROR]:routine mailbox data is %x\n",IORD(CY7C67200_BASE,HPI_MAILBOX));
        goto USB_HOT_PLUG;
    }

    //usleep(30*1000);    
    ctl_reg = USB1_CTL_REG;
    no_device = (A_DP_STAT | A_DM_STAT);
    fs_device = A_DP_STAT;
    
    usb_ctl_val = UsbRead(ctl_reg);
   
    if (!(usb_ctl_val & no_device))
    {
      printf("\n[INFO]: no device is present in SIE1!\n");
      printf("[INFO]: please insert a USB mouse in SIE1!\n");
      while (!(usb_ctl_val & no_device))
      {
       
         usb_ctl_val = UsbRead(ctl_reg);
         if(usb_ctl_val & no_device)
           goto USB_HOT_PLUG;
       
         usleep(2000);
      }
    }
    else
    {
        /* check for low speed or full speed by reading D+ and D- lines */    
        if (usb_ctl_val & fs_device)
        {
            printf("[INFO]: full speed device\n");
            
        }
        else
        {
            printf("[INFO]: low speed device\n");            
            
        }
    }
    

    //printf("[SIE1 INIT]:USB 1 Control Register reg is %x\n",UsbRead(0xC08A));
    
    //------------------------------------------------------set address -----------------------------------------------------------------
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x00D0);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0500);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//device address   
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x0090);//device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    
   
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
        //the starting address
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
           IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
           IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
           IOWR(CY7C67200_BASE,HPI_DATA,0x00D0);
           IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
           IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
           IOWR(CY7C67200_BASE,HPI_DATA,0x0514); 
    
           //td content 4 bytes
           IOWR(CY7C67200_BASE,HPI_DATA,0x0500);
           IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//device address   
           IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
           IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
           //IN 
           IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
           IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
           IOWR(CY7C67200_BASE,HPI_DATA,0x0090);//device address
           IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
           IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
           IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
        
           UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr 
           usleep(10*1000);
    }
    
    //UsbRead(0x01B8);
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
       //goto USB_HOT_PLUG;
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 3 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 3 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
           
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
           
           goto USB_HOT_PLUG;
    }    
       
    printf("------------[ENUM PROCESS]:set address pass!---------------\n");
    
    
    //-------------------------------get device descriptor-1 -----------------------------------//
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0100);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);
    
    //data phase IN
    IOWR(CY7C67200_BASE,HPI_DATA,0x052C); //
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);
    
//    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    
   //usleep(10*1000);
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0100);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);
    
    //data phase IN
    IOWR(CY7C67200_BASE,HPI_DATA,0x052C); //
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);
    
//    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    usleep(10*1000);
    }
    
    //UsbRead(0x01B8);
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 4 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 4 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
           
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
       
    printf("---------------[ENUM PROCESS]:get device descriptor-1 pass!-----------------\n");
    
    
    //--------------------------------get device descriptor-1---------------------------------------------//
    //get device descriptor
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0100);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0012);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x054c); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //data phase IN-3
    IOWR(CY7C67200_BASE,HPI_DATA,0x0554); //c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //538
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//2
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    
    //usleep(100*1000);
    //if no message
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
        //resend the get device descriptor
        //get device descriptor

    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0100);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0012);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x054c); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //data phase IN-3
    IOWR(CY7C67200_BASE,HPI_DATA,0x0554); //c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //538
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//2
    
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    usleep(10*1000);
    }
    
    //UsbRead(0x01B8);
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 4 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 4 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
                   
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
            
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
       
    printf("------------[ENUM PROCESS]:get device descriptor-2 pass!--------------\n");

//    IOWR(CY7C67200_BASE,HPI_ADDR,0x0554); //the start address
//    printf("\n[ENUM PROCESS]:TD rec data8 is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    //-----------------------------------get configuration descriptor -1 ----------------------------------//
    //usleep(1000);
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0200);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0009);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x054c); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    
   //usleep(10*1000);
   //if no message
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
        //resend the get device descriptor
        //get device descriptor

    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0200);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0009);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x054c); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    usleep(10*1000);
    }
    
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 5 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 5 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
                   
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
            
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
    printf("------------[ENUM PROCESS]:get configuration descriptor-1 pass------------\n");
    
    //-----------------------------------get configuration descriptor-2------------------------------------//
    //get device descriptor
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0200);//e //config 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x00FF);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x055c); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0564); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //data phase IN-3
    IOWR(CY7C67200_BASE,HPI_DATA,0x056c); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6
    
    //data phase IN-4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0574); //538
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544);//2
    
    //data phase IN-5
    IOWR(CY7C67200_BASE,HPI_DATA,0x057c); //544
    IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a //data1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0550);//e
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //550
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    
   usleep(100*1000);
   //if no message
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0200);//e //config 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x00FF);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x055c); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0564); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //data phase IN-3
    IOWR(CY7C67200_BASE,HPI_DATA,0x056c); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6
    
    //data phase IN-4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0574); //538
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544);//2
    
    //data phase IN-5
    IOWR(CY7C67200_BASE,HPI_DATA,0x057c); //544
    IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a //data1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0550);//e
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //550
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a
          
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    usleep(10*1000);
    }
    //UsbRead(0x01B8);
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 6 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 6 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
                   
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
            
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
       
       
    printf("-----------[ENUM PROCESS]:get configuration descriptor-2 pass!------------\n");
    

    IOWR(CY7C67200_BASE,HPI_ADDR,0x056c); //the start address

    if(  ( IORD(CY7C67200_BASE,HPI_DATA) & 0x0ff)  ==0x02)
    {
         printf("\n[INFO]:check TD rec data7 \n[INFO]:Mouse Detected!!!\n\n");
    }
    else
    {
        printf("\n[INFO]:Mouse Not Detected!!! \n\n");
    }
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x057a); //the start address   
      
    data_size = (IORD(CY7C67200_BASE,HPI_DATA)>>8)&0x0ff; 
    printf("[ENUM PROCESS]:data packet size is %d\n",data_size);
    
    //------------------------------------set configuration -----------------------------------------//
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //port address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0900);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//device address   
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    //in packet
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041); //data 1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    //usleep(10*1000);
   
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
        IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
        IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
        IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
        IOWR(CY7C67200_BASE,HPI_DATA,0x02D0);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
        //td content 4 bytes
        IOWR(CY7C67200_BASE,HPI_DATA,0x0900);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//device address   
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
        //in packet
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
        IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//device address
        IOWR(CY7C67200_BASE,HPI_DATA,0x0041); //data 1
        IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
        
        UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
        usleep(10*1000);
    }
    
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 7 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 7 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
           
        
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
    
    printf("------------[ENUM PROCESS]:set configuration pass!-------------------\n");
    
    //----------------------------------------------classe request out ------------------------------------------//
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //port address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0A21);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//device address   
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
    //in packet
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number /data length
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041); //data 1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    //usleep(10*1000);
   
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
        IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
        IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
        IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
        IOWR(CY7C67200_BASE,HPI_DATA,0x02D0);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
        //td content 4 bytes
        IOWR(CY7C67200_BASE,HPI_DATA,0x0A21);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//device address   
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
        //in packet
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
        IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//device address
        IOWR(CY7C67200_BASE,HPI_DATA,0x0041); //data 1
        IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
        IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
        
        UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
        usleep(10*1000);
    }
    
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE1 MSG]:SIE 1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 8 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 8 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
           
        
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
    
    
    printf("------------[ENUM PROCESS]:classe request out pass!-------------------\n");
    
    //----------------------------------get descriptor(class 0x21) request out --------------------------------//
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //port address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0681);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x2100);//e //config 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x007B);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
        
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    //usleep(10*1000);
   
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //port address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0681);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x2100);//e //config 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x007B);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
        
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6
        
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    usleep(10*1000);
    }
    
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE MSG]:SIE 1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]:step 8 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]:step 8 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
           
        
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
    
    
    
    printf("------------[ENUM PROCESS]:get descriptor (class 0x21) pass!-------------------\n");
    
    //-------------------------------get descriptor (class 0x22)-------------------------------------------//
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0681);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x2200);//e //config 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x007B);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0580); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0588); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //data phase IN-3
    IOWR(CY7C67200_BASE,HPI_DATA,0x0590); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6
    
    //data phase IN-4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0598); //538
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544);//2
    
    //data phase IN-5
    IOWR(CY7C67200_BASE,HPI_DATA,0x05a0); //544
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a //data1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0550);//e
    
    //data phase IN-6
    IOWR(CY7C67200_BASE,HPI_DATA,0x05a8); //550
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x055c);//a
    
    //data phase IN-7
    IOWR(CY7C67200_BASE,HPI_DATA,0x05b0); //c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//560
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2 //data1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0568);//6
    
    //data phase IN-8
    IOWR(CY7C67200_BASE,HPI_DATA,0x05b8); //8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0003);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//570
    IOWR(CY7C67200_BASE,HPI_DATA,0x0574);//2
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //574
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
     
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    
   //usleep(100*1000);
   //if no message
    while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
    {
    //the starting address
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
    IOWR(CY7C67200_BASE,HPI_DATA,0x050C); 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
    IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
    IOWR(CY7C67200_BASE,HPI_DATA,0x0514);
    
    //td content 4 bytes
    IOWR(CY7C67200_BASE,HPI_DATA,0x0681);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x2200);//e //config 
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
    IOWR(CY7C67200_BASE,HPI_DATA,0x007B);//2
    
    //data phase IN-1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0580); //514
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e
    
    //data phase IN-2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0588); //520
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a
    
    //data phase IN-3
    IOWR(CY7C67200_BASE,HPI_DATA,0x0590); //52c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6
    
    //data phase IN-4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0598); //538
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
    IOWR(CY7C67200_BASE,HPI_DATA,0x0544);//2
    
    //data phase IN-5
    IOWR(CY7C67200_BASE,HPI_DATA,0x05a0); //544
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a //data1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0550);//e
    
    //data phase IN-6
    IOWR(CY7C67200_BASE,HPI_DATA,0x05a8); //550
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x055c);//a
    
    //data phase IN-7
    IOWR(CY7C67200_BASE,HPI_DATA,0x05b0); //c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//560
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2 //data1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
    IOWR(CY7C67200_BASE,HPI_DATA,0x0568);//6
    
    //data phase IN-8
    IOWR(CY7C67200_BASE,HPI_DATA,0x05b8); //8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0003);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data1
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//570
    IOWR(CY7C67200_BASE,HPI_DATA,0x0574);//2
    
    //status phase
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //574
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6
    IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//8
    IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
    IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
    IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
          
    UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
    usleep(10*1000);
    }
    
    usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
    UsbWrite(HPI_SIE1_MSG_ADR, 0);
    while (usb_ctl_val != 0x1000)  //read sie1 msg register
    {
       if(usb_ctl_val == 0x000)
       {
       }
       else
       {
        printf("[SIE1 MSG]: SIE 1 msg reg is %x\n",usb_ctl_val);
       }
       usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
       UsbWrite(HPI_SIE1_MSG_ADR, 0);
      
    }

    IOWR(CY7C67200_BASE,HPI_ADDR,0x0506);
    printf("[ENUM PROCESS]: step 9 TD Status Byte is %x\n",IORD(CY7C67200_BASE,HPI_DATA));
    
    IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
    usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);
    printf("[ENUM PROCESS]: step 9 TD Control Byte is %x\n",usb_ctl_val);
    while (usb_ctl_val != 0x03) 
    {
       IORD(CY7C67200_BASE,HPI_STATUS);
       if(UsbRead(HPI_SIE1_MSG_ADR) == 0x1000)
       {
           UsbWrite(HPI_SIE1_MSG_ADR, 0);
                   
           while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
           {
            
           }
        }
           //usleep(1000);
           IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
           usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA); 
    }    
       
    printf("---------------[ENUM PROCESS]:get descriptor (class 0x22) pass!----------------\n");
    

    
    //-----------------------------------get mouse x y button value------------------------------------------------//
    usleep(10000);
    while(1)
    {
      toggle++;
      IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
      //data phase IN-1
      IOWR(CY7C67200_BASE,HPI_DATA,0x051c); //500
      if(data_size ==8)
      {
          IOWR(CY7C67200_BASE,HPI_DATA,0x0006);//2 data length
      }
      else
      {
          IOWR(CY7C67200_BASE,HPI_DATA,0x000f & data_size);//2 data length
      }
      IOWR(CY7C67200_BASE,HPI_DATA,0x0291);//4 //endpoint 1
      if(toggle%2)
      {
          IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data 1
      }
      else
      {
          IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//6 //data 1
      }
      IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
      IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a
      UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
      //usleep(10*1000);    
      while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
      {
          IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address       
          //data phase IN-1
          IOWR(CY7C67200_BASE,HPI_DATA,0x051c); //500
          if(data_size ==8)
          {
             IOWR(CY7C67200_BASE,HPI_DATA,0x0006);//2 data length
          }
          else
          {
             IOWR(CY7C67200_BASE,HPI_DATA,0x000f & data_size);//2 data length
          }
          IOWR(CY7C67200_BASE,HPI_DATA,0x0291);//4 //endpoint 1
          if(toggle%2)
          {
            IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data 1
          }
          else
          {
            IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//6 //data 1
          }
          IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
          IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a
          UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
          usleep(10*1000);
      }//end while
      usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
      UsbWrite(HPI_SIE1_MSG_ADR, 0);
      while (usb_ctl_val != 0x1000)  //read sie1 msg register
      {
         if(usb_ctl_val == 0x000)
         {}
         else
         {
            printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
         }
         usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
         UsbWrite(HPI_SIE1_MSG_ADR, 0);
      }
      IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
      usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);

      if (usb_ctl_val != 0x03) 
      {
         pbutton = 0;
         dx = 0;
         dy = 0;
         button_value = 0;
      }
    
      else
     {
        if(data_size != 8 )  
        {
          IOWR(CY7C67200_BASE,HPI_ADDR,0x051c); //the start address  
          button_value = IORD(CY7C67200_BASE,HPI_DATA);
          if((button_value & 0x00ff) ==0x0001)
          {
           //printf("left button\n");
            pbutton = 1;
          }
          else
          if((button_value& 0x00ff) ==0x0002)
          {
           //printf("right button\n");
           pbutton = 2;    
          }
          else
          {
           pbutton = 0;
          }
          if((signed char)((button_value>>8)&0x00ff) != 0)
          {
       
             if((signed char)((button_value>>8)&0x00ff )==dx)
             {
                dx = 0;
             }
              else
             {
                dx = (signed char)((button_value>>8)&0x00ff);
             }
       
          }
       
       button_value = IORD(CY7C67200_BASE,HPI_DATA);
    
       if(button_value&0xff)
       {
          //printf("dy value is %d\n",button_value&0xff);
          if((signed char)(button_value&0x00ff) == dy)
          {
             dy = 0;
          }
          else
          {
             dy = (signed char)(button_value&0xff);
          }
        
        }
      }
      else //>8
      {
        IOWR(CY7C67200_BASE,HPI_ADDR,0x051c); //the start address  
        button_value = IORD(CY7C67200_BASE,HPI_DATA);
         if(((button_value>>8) & 0x00ff) ==0x0001)
        {
           //printf("left button\n");
           pbutton = 1;
        }
        else
        if(((button_value>>8) & 0x00ff) ==0x0002)
        {
           //printf("right button\n");
           pbutton = 2;    
        }
        else
        {
           pbutton = 0;
        }
        button_value = IORD(CY7C67200_BASE,HPI_DATA);
        if((signed char)((button_value>>8)&0x00ff) != 0)
        {
           if((signed char)((button_value>>8)&0x00ff )==dy)
           {
              dy = 0;
           }
           else
           {
              dy = (signed char)((button_value>>8)&0x00ff);
           }
       
        }
       
       if(button_value&0x0ff)
       {
          //printf("dy value is %d\n",button_value&0xff);
          if((signed char)(button_value&0x00ff) == dx)
          {
             dx = 0;
          }
          else
          {
             dx = (signed char)(button_value&0xff);
          }
        
        }
      }
        
    }    
     
    px = px + dx;
    py = py + dy;
    
    px=maxmin(px,639,0);
    py=maxmin(py,479,0);
    
    SEG7_Hex((px<<16)+py,0);
    IOWR(LEDR_BASE,0,px);
    IOWR(LEDG_BASE,0,py);

    Set_Cursor_XY(px,py);
    if(pbutton==1)
    Vga_Set_Pixel(VPG_BASE,px,py);
    else if(pbutton==2)
    Vga_Clr_Pixel(VPG_BASE,px,py);
    
    printf("\n[MOUSE XY]:%d, %d", px, py);
    usleep(5*1000);
    //USB hot plug routine
    usb_ctl_val = UsbRead(ctl_reg);
    usleep(5*1000);
    usb_ctl_val = UsbRead(ctl_reg);
    usleep(5*1000);
    usb_ctl_val = UsbRead(ctl_reg);
    usleep(5*1000);
    usb_ctl_val = UsbRead(ctl_reg);
    usleep(5*1000);
    usb_ctl_val = UsbRead(ctl_reg);
    usleep(5*1000);
    usb_ctl_val = UsbRead(ctl_reg);
    usleep(5*1000);

    if(!(usb_ctl_val & no_device))
    {
       printf("\n[INFO]: the mouse has been removed!!! \n");
       printf("[INFO]: please insert again!!! \n");
    };
    usleep(5000);
    usb_ctl_val = UsbRead(ctl_reg);
    while (!(usb_ctl_val & no_device))
    {
       
       usb_ctl_val = UsbRead(ctl_reg);
       usleep(5*1000);
       usb_ctl_val = UsbRead(ctl_reg);
       usleep(5*1000);
       usb_ctl_val = UsbRead(ctl_reg);
       usleep(5*1000);

       if(usb_ctl_val & no_device)
         goto USB_HOT_PLUG;
       
       usleep(200);

    }
    
    }//end while
    
    return 0;
}

//-------------USB operation sub function-----------
/*****************************************************************************/
/**
*
* This function writes data to the internal registers of the Cypress
* CY7C67200 USB controller.
*
* @param    Address is the address of the register.
* @param    Data is the data to be written to the register.
*
* @return   None
*
* @note     None
*
******************************************************************************/
void UsbWrite(alt_u16 Address, alt_u16 Data)
{
    //XIo_Out16(USB_ADDRESS, Address);
    IOWR(CY7C67200_BASE,HPI_ADDR,Address);
    //usleep(10);
    
    //XIo_Out16(USB_DATA, Data);
    IOWR(CY7C67200_BASE,HPI_DATA,Data); 
}

/*****************************************************************************/
/**
*
* This function reads data from the internal registers of the Cypress
* CY7C67200 USB controller.
*
* @param    Address is the address of the register.
*
* @return   The data read from the specified address
*
* @note     None
*
******************************************************************************/
alt_u16 UsbRead(alt_u16 Address)
{
    //XIo_Out16(HPI_ADDR, Address);
    IOWR(CY7C67200_BASE,HPI_ADDR,Address);
    //usleep(20);
    return IORD(CY7C67200_BASE,HPI_DATA);
}


/*****************************************************************************/
/**
*
* This function does a software reset of the Cypress CY7C67200 USB controller.
*
* @param    UsbBaseAddress is the starting location of the USB internal memory
*           to which this bin file data is written.
*
* @return   None
*
* @note     None
*
******************************************************************************/
void UsbSoftReset()
{
    //XIo_Out16(USB_MAILBOX, COMM_RESET);
    IOWR(CY7C67200_BASE,HPI_MAILBOX,COMM_RESET); //COMM_JUMP2CODE
    usleep(100000);
    printf("[USB INIT]:reset finished!\n");

    usleep(500000);
    printf("[USB INIT]:Clear up the interrupt\r\n");
    IORD(CY7C67200_BASE,HPI_MAILBOX);
    IORD(CY7C67200_BASE,HPI_STATUS);

    // Had to add the write due to a bug in BIOS where they overwrite
    // the mailbox after initialization with garbage.  The read clears
    // any pending interrupts.
    UsbRead (HPI_SIE1_MSG_ADR);
    UsbWrite (HPI_SIE1_MSG_ADR, 0);
    UsbRead (HPI_SIE2_MSG_ADR);
    UsbWrite (HPI_SIE2_MSG_ADR, 0);

    UsbWrite (HOST1_STAT_REG, 0xFFFF);
    UsbWrite (HOST2_STAT_REG, 0xFFFF);
}
