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

module DE2_115_IR
	(
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

//===========================================================================
// PARAMETER declarations
//===========================================================================


//===========================================================================
// PORT declarations
//===========================================================================
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
inout		          		ENET0_MDIO;
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
inout		          		ENET1_MDIO;
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
inout         [15:0]    OTG_DATA;
output        [1:0]     OTG_ADDR;
output                  OTG_CS_N;
output                  OTG_WR_N;
output                  OTG_RD_N;
input                   OTG_INT;
output                  OTG_RST_N;

//////////// IR Receiver //////////
input		          		IRDA_RXD;

//////////// SDRAM //////////
output		  [12:0]		DRAM_ADDR;
output		  [1:0]		DRAM_BA;
output		          	DRAM_CAS_N;
output		          	DRAM_CKE;
output		          	DRAM_CLK;
output		          	DRAM_CS_N;
inout		     [31:0]		DRAM_DQ;
output		  [3:0]		DRAM_DQM;
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
output		 [22:0]		FL_ADDR;
output		          	FL_CE_N;
inout		    [7:0]		FL_DQ;
output		          	FL_OE_N;
output		          	FL_RST_N;
input		          		FL_RY;
output		          	FL_WE_N;
output		          	FL_WP_N;

//////////// GPIO //////////
inout		    [35:0]		GPIO;

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
inout		     [3:0]		HSMC_D;
//input		  [16:0]		HSMC_RX_D_N;
input		     [16:0]		HSMC_RX_D_P;
//output	     [16:0]		HSMC_TX_D_N;
output		  [16:0]		HSMC_TX_D_P;

//////// EXTEND IO //////////
inout		     [6:0]		EX_IO;
///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================

wire    data_ready;        //IR data_ready flag
//reg   data_read;         //read 
wire    [31:0] hex_data;   //seg data input
wire    clk50;             //pll 50M output for irda

//=============================================================================
// Structural coding
//=============================================================================

//	All inout port turn to tri-state 
assign	SD_DAT		=	4'b1zzz;  //Set SD Card to SD Mode
assign	AUD_ADCLRCK	=	AUD_DACLRCK;
assign	GPIO	=	36'hzzzzzzzzz;
assign	HSMC_D   	=	4'hz;
assign	EX_IO   	=	7'bzz;

//////////wait for data_ready///////////////
//always @( data_ready)
//	begin
//		if(data_ready)
//			data_read <= 1;
//		else
//		    data_read <= 0;
//	end
 
pll1 u0(
		.inclk0(CLOCK_50),
		//irda clock 50M 
		.c0(clk50),          
		.c1());

IR_RECEIVE u1(
					///clk 50MHz////
					.iCLK(clk50), 
					//reset          
					.iRST_n(KEY[0]),        
					//IRDA code input
					.iIRDA(IRDA_RXD), 
					//read command      
					//.iREAD(data_read),
					//data ready      					
					.oDATA_READY(data_ready),
					//decoded data 32bit
					.oDATA(hex_data)        
					);
					
//the key code is display on HEX0 ~ HEX3
//the custom code is display on HEX4 ~ HEX7
SEG_HEX u2( //display the HEX on HEX0                               
			.iDIG(hex_data[31:28]),         
			.oHEX_D(HEX0)
		  );  
SEG_HEX u3( //display the HEX on HEX1                                
           .iDIG(hex_data[27:24]),
           .oHEX_D(HEX1)
           );
SEG_HEX u4(//display the HEX on HEX2                                
           .iDIG(hex_data[23:20]),
           .oHEX_D(HEX2)
           );
SEG_HEX u5(//display the HEX on HEX3                                 
           .iDIG(hex_data[19:16]),
           .oHEX_D(HEX3)
           );
SEG_HEX u6(//display the HEX on HEX4                                 
           .iDIG(hex_data[15:12]),
           .oHEX_D(HEX4)
           );
SEG_HEX u7(//display the HEX on HEX5                                 
           .iDIG(hex_data[11:8]) , 
           .oHEX_D(HEX5)
           );
SEG_HEX u8(//display the HEX on HEX6                                 
           .iDIG(hex_data[7:4]) ,
           .oHEX_D(HEX6)
           );
SEG_HEX u9(//display the HEX on HEX7                                 
           .iDIG(hex_data[3:0]) ,
           .oHEX_D(HEX7)
           );           

endmodule

