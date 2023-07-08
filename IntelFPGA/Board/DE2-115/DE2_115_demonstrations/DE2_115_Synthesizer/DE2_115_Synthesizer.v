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
						 												

module DE2_115_Synthesizer(
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
output		        		LCD_BLON;
inout		     [7:0]		LCD_DATA;
output		        		LCD_EN;
output		        		LCD_ON;
output		        		LCD_RS;
output		        		LCD_RW;

//////////// RS232 //////////
input		        		UART_CTS;
output		          		UART_RTS;
input		          		UART_RXD;
output		        		UART_TXD;

//////////// PS2 //////////
inout		          		PS2_CLK;
inout		          		PS2_DAT;
inout		          		PS2_CLK2;
inout		          		PS2_DAT2;

//////////// SDCARD //////////
output		        		SD_CLK;
inout		          		SD_CMD;
inout		     [3:0]		SD_DAT;
input		          		SD_WP_N;

//////////// VGA //////////
output		  [7:0]		VGA_B;
output		        		VGA_BLANK_N;
output		        		VGA_CLK;
output		  [7:0]		VGA_G;
output	         		VGA_HS;
output	     [7:0]		VGA_R;
output	         		VGA_SYNC_N;
output		        		VGA_VS;

//////////// Audio //////////
input		          		AUD_ADCDAT;
inout		          		AUD_ADCLRCK;
inout		          		AUD_BCLK;
output		        		AUD_DACDAT;
inout		          		AUD_DACLRCK;
output		        		AUD_XCK;

//////////// I2C for EEPROM //////////
output		        		EEP_I2C_SCLK;
inout		          		EEP_I2C_SDAT;

//////////// I2C for Audio and Tv-Decode //////////
output		        		I2C_SCLK;
inout		          		I2C_SDAT;

//////////// Ethernet 0 //////////
output		        		ENET0_GTX_CLK;
input		          		ENET0_INT_N;
output		        		ENET0_MDC;
inout		          		ENET0_MDIO;
output		        		ENET0_RST_N;
input		          		ENET0_RX_CLK;
input		          		ENET0_RX_COL;
input		          		ENET0_RX_CRS;
input		     [3:0]		ENET0_RX_DATA;
input		          		ENET0_RX_DV;
input		          		ENET0_RX_ER;
input		          		ENET0_TX_CLK;
output		  [3:0]		ENET0_TX_DATA;
output		        		ENET0_TX_EN;
output		        		ENET0_TX_ER;
input		          		ENET0_LINK100;

//////////// Ethernet 1 //////////
output		        		ENET1_GTX_CLK;
input		          		ENET1_INT_N;
output		        		ENET1_MDC;
input		          		ENET1_MDIO;
output		        		ENET1_RST_N;
input		          		ENET1_RX_CLK;
input		          		ENET1_RX_COL;
input		          		ENET1_RX_CRS;
input		     [3:0]		ENET1_RX_DATA;
input		          		ENET1_RX_DV;
input		          		ENET1_RX_ER;
input		          		ENET1_TX_CLK;
output		  [3:0]		ENET1_TX_DATA;
output		        		ENET1_TX_EN;
output		        		ENET1_TX_ER;
input		          		ENET1_LINK100;

//////////// TV Decoder 1 //////////
input		          		TD_CLK27;
input		     [7:0]		TD_DATA;
input		          		TD_HS;
output		        		TD_RESET_N;
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
output		 [12:0]		DRAM_ADDR;
output		 [1:0]		DRAM_BA;
output		       		DRAM_CAS_N;
output		        		DRAM_CKE;
output		        		DRAM_CLK;
output		        		DRAM_CS_N;
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
//output		       		HSMC_CLKOUT_N1;
//output		          	HSMC_CLKOUT_N2;
output		        		HSMC_CLKOUT_P1;
output		        		HSMC_CLKOUT_P2;
output		        		HSMC_CLKOUT0;
inout		    [3:0]		HSMC_D;
//input		 [16:0]		HSMC_RX_D_N;
input		    [16:0]		HSMC_RX_D_P;
//output		 [16:0]	   HSMC_TX_D_N;
output		 [16:0]		HSMC_TX_D_P;

//////// EXTEND IO //////////
inout		    [6:0]		EX_IO;


wire			            I2C_END;
wire					      AUD_CTRL_CLK;
reg			 [31:0]		VGA_CLKo;
wire   						keyboard_sysclk;
wire   						demo_clock ; 
wire		    [7:0]		demo_code1;
wire 			 [7:0]		scan_code;
wire 			   			get_gate;
wire 				   		key1_on;
wire 					   	key2_on;
wire 			 [7:0]		key1_code;
wire 			 [7:0]		key2_code;
wire   						VGA_R1,VGA_G1,VGA_B1;
wire   						VGA_R2,VGA_G2,VGA_B2;

//=============================================================================
// Structural coding
//=============================================================================
	
assign PS2_DAT2 = 1'b1;	
assign PS2_CLK2 = 1'b1;
	
//  TV DECODER ENABLE 
	
assign TD_RESET_N =1'b1;

	
//  7-SEG 
			
	SEG7_LUT_8 	u0	(
						  HEX0,
						  HEX1,
						  HEX2,
						  HEX3,
						  HEX4,
						  HEX5,
						  HEX6,
						  HEX7,
						  31'h00001112 
						 );

//  I2C

	I2C_AV_Config 		u7	(	//	Host Side
								 .iCLK		( CLOCK_50),
								 .iRST_N		( KEY[0] ),
								 .o_I2C_END	( I2C_END ),
								   //	I2C Side
								 .I2C_SCLK	( I2C_SCLK ),
								 .I2C_SDAT	( I2C_SDAT )	
								);


//	AUDIO SOUND

	assign	AUD_ADCLRCK	=	AUD_DACLRCK;
	assign	AUD_XCK	   =	AUD_CTRL_CLK;			

//  AUDIO PLL

	VGA_Audio_PLL 	u1	(	
							 .areset ( ~I2C_END ),
							 .inclk0 ( TD_CLK27 ),
							 .c1		( AUD_CTRL_CLK )	
							);

// Music Synthesizer Block //

// TIME & CLOCK Generater //

	assign keyboard_sysclk = VGA_CLKo[12];
	assign demo_clock      = VGA_CLKo[18]; 
	assign VGA_CLK         = VGA_CLKo[0];

	always @( posedge CLOCK_50 )
		begin
			VGA_CLKo <= VGA_CLKo + 1;
		end

// DEMO SOUND //

// DEMO Sound (CH1) //



	demo_sound1	dd1(
						 .clock   ( demo_clock ),
						 .key_code( demo_code1 ),
					    .k_tr    ( KEY[1] & KEY[0] )
					   );

// DEMO Sound (CH2) //

	wire [7:0]demo_code2;

	demo_sound2	dd2(
						 .clock   ( demo_clock ),
						 .key_code( demo_code2 ),
						 .k_tr    ( KEY[1] & KEY[0] )
						);

// KeyBoard Scan //

	ps2_keyboard keyboard( 						  
								 .iCLK_50  ( CLOCK_50),  		  //clock source;
							    .ps2_dat  ( PS2_DAT ),		  //ps2bus data  		
								 .ps2_clk  ( PS2_CLK ),		  //ps2bus clk      	
								 .sys_clk  ( keyboard_sysclk ),  //system clock		
								 .reset    ( KEY[3] ), 		  //system reset		
								 .reset1   ( KEY[2] ),			  //keyboard reset	
								 .scandata ( scan_code ),		  //scan code    		
								 .key1_on  ( key1_on ),		  //key1 triger
								 .key2_on  ( key2_on ),		  //key2 triger
								 .key1_code( key1_code ),		  //key1 code
								 .key2_code( key2_code ) 		  //key2 code
								);
	
////////////Sound Select/////////////	

	wire [15:0]	sound1;
	wire [15:0]	sound2;
	wire [15:0]	sound3;
	wire [15:0]	sound4;
	wire 			sound_off1;
	wire 			sound_off2;
	wire 			sound_off3;
	wire 			sound_off4;

	wire [7:0]sound_code1 = ( !SW[9] )? demo_code1 : key1_code ; //SW[9]=0 is DEMO SOUND,otherwise key

	wire [7:0]sound_code2 = ( !SW[9] )? demo_code2 : key2_code ; //SW[9]=0 is DEMO SOUND,otherwise key

	wire [7:0]sound_code3 = 8'hf0;

	wire [7:0]sound_code4 = 8'hf0;

// Staff Display & Sound Output //
	
	assign VGA_R=( VGA_R1 )? 10'h3f0 : 0 ;
	
	assign VGA_G=( VGA_G1 )? 10'h3f0 : 0 ;
	
	assign VGA_B=( VGA_B1 )? 10'h3f0 : 0 ;

	staff st1(
		
			  // VGA output //
		
			 .VGA_CLK   		( VGA_CLK ),   
			 .vga_h_sync		( VGA_HS ), 
			 .vga_v_sync		( VGA_VS ), 
			 .vga_sync  		( VGA_SYNC_N ),	
			 .inDisplayArea	    ( VGA_BLANK_N ),
			 .vga_R				( VGA_R1 ), 
			 .vga_G				( VGA_G1 ), 
			 .vga_B				( VGA_B1 ),
		
			 // Key code-in //
		
			 .scan_code1		( sound_code1 ),
			 .scan_code2		( sound_code2 ),
			 .scan_code3      ( sound_code3 ), // OFF
			 .scan_code4		( sound_code4 ), // OFF
		
			 //Sound Output to Audio Generater//
		
			 .sound1				( sound1 ),
			 .sound2				( sound2 ),
			 .sound3				( sound3 ), // OFF
			 .sound4				( sound4 ), // OFF
		
			 .sound_off1		( sound_off1 ),
			 .sound_off2		( sound_off2 ),
			 .sound_off3		( sound_off3 ), //OFF
			 .sound_off4		( sound_off4 )	 //OFF	
	        );

///////LED Display////////

	assign LEDR[9:6] = { sound_off4,sound_off3,sound_off2,sound_off1 };

	assign LEDG[7:0] = scan_code;
						
// 2CH Audio Sound output -- Audio Generater //

	adio_codec ad1	(	
	        
					// AUDIO CODEC //
		
					.oAUD_BCK 	( AUD_BCLK ),
					.oAUD_DATA	( AUD_DACDAT ),
					.oAUD_LRCK	( AUD_DACLRCK ),																
					.iCLK_18_4	( AUD_CTRL_CLK ),
			
					// KEY //
		
					.iRST_N	  	( KEY[0] ),							
					.iSrc_Select( 2'b00 ),

					// Sound Control //

					.key1_on		( ~SW[1] & sound_off1 ),//CH1 ON / OFF		
					.key2_on		( ~SW[2] & sound_off2 ),//CH2 ON / OFF
					.key3_on		( 1'b0 ),			    	// OFF
					.key4_on		( 1'b0 ), 					// OFF							
					.sound1		( sound1 ),					// CH1 Freq
					.sound2		( sound2 ),					// CH2 Freq
					.sound3		( sound3 ),					// OFF,CH3 Freq
					.sound4		( sound4 ),					// OFF,CH4 Freq							
					.instru		( SW[0] )  					// Instruction Select
					);


//	LCD 

	assign	LCD_ON		=	1'b1;
	
	assign	LCD_BLON	=	1'b1;	
	
	LCD_TEST 			u5	(	
	
							//	Host Side
							
							.iCLK  	 ( CLOCK_50 ),
							.iRST_N	 ( KEY[0] & I2C_END ),
							
							//	LCD Side
							
							.LCD_DATA ( LCD_DATA ),
							.LCD_RW   ( LCD_RW ),
							.LCD_EN	 ( LCD_EN ),
							.LCD_RS   ( LCD_RS )	
							);

// TEST DeBUG

DeBUG_TEST 		u6	(
						 .iCLK(CLOCK2_50),
						 .iRST_N(KEY[0]),
						 .isound_off1(sound_off1),
						 .isound_off2(sound_off2)
					 );

endmodule
