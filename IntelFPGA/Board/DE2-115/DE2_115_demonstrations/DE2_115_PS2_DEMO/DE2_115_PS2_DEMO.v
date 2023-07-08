// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
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
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2_115_Default
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author              :| Mod. Date :| Changes Made:
//   V1.1 :| HdHuang             :| 05/12/10  :| Initial Revision
//   V2.0 :| Eko       				:| 05/23/12  :| version 11.1
// ============================================================================

module DE2_115_PS2_DEMO(

	//////// CLOCK //////////
	CLOCK_50,
   CLOCK2_50,
   CLOCK3_50,
	ENETCLK_25,

	//////// Sma //////////
	SMA_CLKIN,
	SMA_CLKOUT,

	//////// LED //////////
	LEDG,
	LEDR,

	//////// KEY //////////
	KEY,

	//////// SW //////////
	SW,

	//////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,

	//////// LCD //////////
	LCD_BLON,
	LCD_DATA,
	LCD_EN,
	LCD_ON,
	LCD_RS,
	LCD_RW,

	//////// RS232 //////////
	UART_CTS,
	UART_RTS,
	UART_RXD,
	UART_TXD,

	//////// PS2 //////////
	PS2_CLK,
	PS2_DAT,
	PS2_CLK2,
	PS2_DAT2,

	//////// SDCARD //////////
	SD_CLK,
	SD_CMD,
	SD_DAT,
	SD_WP_N,

	//////// VGA //////////
	VGA_B,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS,

	//////// Audio //////////
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,

	//////// I2C for EEPROM //////////
	EEP_I2C_SCLK,
	EEP_I2C_SDAT,

	//////// I2C for Audio and Tv-Decode //////////
	I2C_SCLK,
	I2C_SDAT,

	//////// Ethernet 0 //////////
	ENET0_GTX_CLK,
	ENET0_INT_N,
	ENET0_MDC,
	ENET0_MDIO,
	ENET0_RST_N,
	ENET0_RX_CLK,
	ENET0_RX_COL,
	ENET0_RX_CRS,
	ENET0_RX_DATA,
	ENET0_RX_DV,
	ENET0_RX_ER,
	ENET0_TX_CLK,
	ENET0_TX_DATA,
	ENET0_TX_EN,
	ENET0_TX_ER,
	ENET0_LINK100,

	//////// Ethernet 1 //////////
	ENET1_GTX_CLK,
	ENET1_INT_N,
	ENET1_MDC,
	ENET1_MDIO,
	ENET1_RST_N,
	ENET1_RX_CLK,
	ENET1_RX_COL,
	ENET1_RX_CRS,
	ENET1_RX_DATA,
	ENET1_RX_DV,
	ENET1_RX_ER,
	ENET1_TX_CLK,
	ENET1_TX_DATA,
	ENET1_TX_EN,
	ENET1_TX_ER,
	ENET1_LINK100,

	//////// TV Decoder //////////
	TD_CLK27,
	TD_DATA,
	TD_HS,
	TD_RESET_N,
	TD_VS,

    /////// USB OTG controller
   OTG_DATA,
   OTG_ADDR,
   OTG_CS_N,
   OTG_WR_N,
   OTG_RD_N,
   OTG_INT,
   OTG_RST_N,
	//////// IR Receiver //////////
	IRDA_RXD,

	//////// SDRAM //////////
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_DQM,
	DRAM_RAS_N,
	DRAM_WE_N,

	//////// SRAM //////////
	SRAM_ADDR,
	SRAM_CE_N,
	SRAM_DQ,
	SRAM_LB_N,
	SRAM_OE_N,
	SRAM_UB_N,
	SRAM_WE_N,

	//////// Flash //////////
	FL_ADDR,
	FL_CE_N,
	FL_DQ,
	FL_OE_N,
	FL_RST_N,
	FL_RY,
	FL_WE_N,
	FL_WP_N,

	//////// GPIO //////////
	GPIO,

	//////// HSMC (LVDS) //////////
//	HSMC_CLKIN_N1,
//	HSMC_CLKIN_N2,
	HSMC_CLKIN_P1,
	HSMC_CLKIN_P2,
	HSMC_CLKIN0,
//	HSMC_CLKOUT_N1,
//	HSMC_CLKOUT_N2,
	HSMC_CLKOUT_P1,
	HSMC_CLKOUT_P2,
	HSMC_CLKOUT0,
	HSMC_D,
//	HSMC_RX_D_N,
	HSMC_RX_D_P,
//	HSMC_TX_D_N,
	HSMC_TX_D_P,
    //////// EXTEND IO //////////
   EX_IO	
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input		          		CLOCK_50;
input		          		CLOCK2_50;
input		          		CLOCK3_50;
input		          		ENETCLK_25;

//////////// Sma //////////
input		          		SMA_CLKIN;
output		          	SMA_CLKOUT;

//////////// LED //////////
output		  [8:0]		LEDG;
output		  [17:0]		LEDR;

//////////// KEY //////////
input		     [3:0]		KEY;

//////////// SW //////////
input		     [17:0]		SW;

//////////// SEG7 //////////
output		  [6:0]		HEX0;
output		  [6:0]		HEX1;
output		  [6:0]		HEX2;
output		  [6:0]		HEX3;
output		  [6:0]		HEX4;
output		  [6:0]		HEX5;
output		  [6:0]		HEX6;
output		  [6:0]		HEX7;

//////////// LCD //////////
output		          	LCD_BLON;
inout		     [7:0]		LCD_DATA;
output		          	LCD_EN;
output		          	LCD_ON;
output		          	LCD_RS;
output		          	LCD_RW;

//////////// RS232 //////////
input		          	UART_CTS;
output		          		UART_RTS;
input		          		UART_RXD;
output		          	UART_TXD;

//////////// PS2 //////////
inout		          		PS2_CLK;
inout		          		PS2_DAT;
inout		          		PS2_CLK2;
inout		          		PS2_DAT2;

//////////// SDCARD //////////
output		          	SD_CLK;
inout		          		SD_CMD;
inout		     [3:0]		SD_DAT;
input		          		SD_WP_N;

//////////// VGA //////////
output		  [7:0]		VGA_B;
output		          	VGA_BLANK_N;
output		          	VGA_CLK;
output		  [7:0]		VGA_G;
output		          	VGA_HS;
output		  [7:0]		VGA_R;
output		          	VGA_SYNC_N;
output		          	VGA_VS;

//////////// Audio //////////
input		          		AUD_ADCDAT;
inout		          		AUD_ADCLRCK;
inout		          		AUD_BCLK;
output		          	AUD_DACDAT;
inout		          		AUD_DACLRCK;
output		          	AUD_XCK;

//////////// I2C for EEPROM //////////
output		          	EEP_I2C_SCLK;
inout		          		EEP_I2C_SDAT;

//////////// I2C for Audio and Tv-Decode //////////
output		          	I2C_SCLK;
inout		          		I2C_SDAT;

//////////// Ethernet 0 //////////
output		          	ENET0_GTX_CLK;
input		          		ENET0_INT_N;
output		          	ENET0_MDC;
input		          		ENET0_MDIO;
output		          	ENET0_RST_N;
input		          		ENET0_RX_CLK;
input		          		ENET0_RX_COL;
input		          		ENET0_RX_CRS;
input		     [3:0]		ENET0_RX_DATA;
input		          		ENET0_RX_DV;
input		          		ENET0_RX_ER;
input		          		ENET0_TX_CLK;
output		  [3:0]		ENET0_TX_DATA;
output		          	ENET0_TX_EN;
output		          	ENET0_TX_ER;
input		          		ENET0_LINK100;

//////////// Ethernet 1 //////////
output		          	ENET1_GTX_CLK;
input		          		ENET1_INT_N;
output		          	ENET1_MDC;
input		          		ENET1_MDIO;
output		          	ENET1_RST_N;
input		          		ENET1_RX_CLK;
input		          		ENET1_RX_COL;
input		          		ENET1_RX_CRS;
input		     [3:0]		ENET1_RX_DATA;
input		          		ENET1_RX_DV;
input		          		ENET1_RX_ER;
input		          		ENET1_TX_CLK;
output		  [3:0]		ENET1_TX_DATA;
output		          	ENET1_TX_EN;
output		          	ENET1_TX_ER;
input		          		ENET1_LINK100;

//////////// TV Decoder 1 //////////
input		          		TD_CLK27;
input		     [7:0]		TD_DATA;
input		          		TD_HS;
output		          	TD_RESET_N;
input		          		TD_VS;


//////////// USB OTG controller //////////
inout        [15:0]     OTG_DATA;
output       [1:0]      OTG_ADDR;
output                  OTG_CS_N;
output                  OTG_WR_N;
output                  OTG_RD_N;
input                   OTG_INT;
output                  OTG_RST_N;

//////////// IR Receiver //////////
input		          		IRDA_RXD;

//////////// SDRAM //////////
output		 [12:0]		DRAM_ADDR;
output		 [1:0]		DRAM_BA;
output		          	DRAM_CAS_N;
output		          	DRAM_CKE;
output		          	DRAM_CLK;
output		          	DRAM_CS_N;
inout		    [31:0]		DRAM_DQ;
output		 [3:0]		DRAM_DQM;
output		          	DRAM_RAS_N;
output		          	DRAM_WE_N;

//////////// SRAM //////////
output		 [19:0]		SRAM_ADDR;
output		          	SRAM_CE_N;
inout		    [15:0]		SRAM_DQ;
output		          	SRAM_LB_N;
output		          	SRAM_OE_N;
output		          	SRAM_UB_N;
output		          	SRAM_WE_N;

//////////// Flash //////////
output		[22:0]		FL_ADDR;
output		          	FL_CE_N;
inout		   [7:0]			FL_DQ;
output		          	FL_OE_N;
output		          	FL_RST_N;
input		          		FL_RY;
output		          	FL_WE_N;
output		          	FL_WP_N;

//////////// GPIO //////////
inout		   [35:0]		GPIO;

//////////// HSMC (LVDS) //////////

//input		          	HSMC_CLKIN_N1;
//input		          	HSMC_CLKIN_N2;
input		          		HSMC_CLKIN_P1;
input		          		HSMC_CLKIN_P2;
input		          		HSMC_CLKIN0;
//output		          	HSMC_CLKOUT_N1;
//output		          	HSMC_CLKOUT_N2;
output		          	HSMC_CLKOUT_P1;
output		          	HSMC_CLKOUT_P2;
output		          	HSMC_CLKOUT0;
inout		    [3:0]		HSMC_D;
//input		 [16:0]		HSMC_RX_D_N;
input		    [16:0]		HSMC_RX_D_P;
//output		 [16:0]		HSMC_TX_D_N;
output		 [16:0]		HSMC_TX_D_P;

//////// EXTEND IO //////////
inout		    [6:0]		EX_IO;



//=======================================================
//  REG/WIRE declarations
//=======================================================



wire HEX0P;
wire HEX1P;
wire HEX2P;
wire HEX3P;
wire HEX4P;
wire HEX5P;
wire HEX6P;
wire HEX7P;


//=======================================================
//  Structural coding
//=======================================================

// Flash Config
//assign	FL_RST_N = reset_n;
assign	FL_WP_N = 1'b1;
//	FL_RY,

///////////////////////////////////////////
// LCD config
assign LCD_BLON = 0; // not supported
assign LCD_ON = 1'b1; // alwasy on

/*wire io_dir;
wire action;
assign io_dir = KEY[3] & action;
*/
///////////////////////////////////////////
// GPIO
//assign GPIO[17:0] = (io_dir)?GPIO[35:18]:18'hz;
//assign GPIO[35:18] = (io_dir)?GPIO[17:0]:18'hz;

///////////////////////////////////////////
// HSMC
//assign HSMC_D[1:0] = (io_dir)?HSMC_D[3:2]:2'hz;
//assign HSMC_D[3:2] = (io_dir)?HSMC_D[1:0]:2'hz;

assign HSMC_TX_D_P = HSMC_RX_D_P;
//assign HSMC_TX_D_N = HSMC_RX_D_N;

//assign HSMC_CLKOUT_N1 = HSMC_CLKIN_N1;
//assign HSMC_CLKOUT_N2 = HSMC_CLKIN_N2;
assign HSMC_CLKOUT_P1 = HSMC_CLKIN_P1;
assign HSMC_CLKOUT_P2 = HSMC_CLKIN_P2;
assign HSMC_CLKOUT0 = HSMC_CLKIN0;

///////////////////////////////////////////
// VGA
assign VGA_BLANK_N = 1'b1;
assign VGA_SYNC_N = 1'b1;


///////////////////////////////////////////
// NET
assign ENET0_GTX_CLK = ENET0_INT_N;
//assign ENET0_GTX_CLK = ENET0_MDIO;
assign ENET0_MDC = ENET0_RX_COL;
assign ENET0_RST_N = ENET0_RX_CRS;
//assign ENET0_RX_CLK = ENET0_RX_DV;
assign ENET0_TX_DATA = ENET0_RX_DATA;
assign ENET0_TX_EN = ENET0_RX_ER;
assign ENET0_TX_ER = ENET0_TX_CLK;

assign ENET1_GTX_CLK = ENET1_INT_N;
//assign ENET1_GTX_CLK = ENET1_MDIO;
assign ENET1_MDC = ENET1_RX_COL;
assign ENET1_RST_N = ENET1_RX_CRS;
//assign ENET1_RX_CLK = ENET1_RX_DV;
assign ENET1_TX_DATA = ENET1_RX_DATA;
assign ENET1_TX_EN = ENET1_RX_ER;
assign ENET1_TX_ER = ENET1_TX_CLK;

//assign ?? = {ENET0_MDIO, ENET0_RX_CLK, ENET0_RX_DV};
//assign ?? = {ENET1_MDIO, ENET1_RX_CLK, ENET1_RX_DV};

///////////////////////////////////////////
// TV
assign TD_RESET_N = TD_VS;
assign action = FL_RY & TD_HS & TD_CLK27 & (TD_DATA == 8'hff);

///////////////////////////////////////////
//ps2
//////////////////////////////////////
///intantiation
 ps2 U1(.iSTART(KEY[0]),  //press the button for transmitting instrucions to device;
           .iRST_n(KEY[1]),  //global reset signal;
           .iCLK_50(CLOCK_50),  //clock source;
           .PS2_CLK(PS2_CLK), //ps2_clock signal inout;
           .PS2_DAT(PS2_DAT), //ps2_data  signal inout;
           .oLEFBUT(LEDG[0]),  //left button press display;
           .oRIGBUT(LEDG[1]),  //right button press display;
           .oMIDBUT(LEDG[2]),  //middle button press display;
           .oX_MOV1(HEX0),  //lower SEG of mouse displacement display for X axis.
           .oX_MOV2(HEX1),  //higher SEG of mouse displacement display for X axis.
           .oY_MOV1(HEX2),  //lower SEG of mouse displacement display for Y axis.
           .oY_MOV2(HEX3)); //higher SEG of mouse displacement display for Y axis.

endmodule
