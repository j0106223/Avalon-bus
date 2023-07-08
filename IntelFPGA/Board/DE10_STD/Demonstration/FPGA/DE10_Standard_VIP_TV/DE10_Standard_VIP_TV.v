// ============================================================================
// Copyright (c) 2016 by Terasic Technologies Inc.
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
//Date:  Thu Nov  3 15:01:20 2016
// ============================================================================

`default_nettype none

//`define ENABLE_HSMC
//`define ENABLE_HPS

module DE10_Standard_VIP_TV(

      ///////// CLOCK /////////
      input              CLOCK2_50,
      input              CLOCK3_50,
      input              CLOCK4_50,
      input              CLOCK_50,

      ///////// KEY /////////
      input    [ 3: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LED /////////
      output   [ 9: 0]   LEDR,

      ///////// Seg7 /////////
      output   [ 6: 0]   HEX0,
      output   [ 6: 0]   HEX1,
      output   [ 6: 0]   HEX2,
      output   [ 6: 0]   HEX3,
      output   [ 6: 0]   HEX4,
      output   [ 6: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// Video-In /////////
      input              TD_CLK27,
      input              TD_HS,
      input              TD_VS,
      input    [ 7: 0]   TD_DATA,
      output             TD_RESET_N,

      ///////// VGA /////////
      output             VGA_CLK,
      output             VGA_HS,
      output             VGA_VS,
      output   [ 7: 0]   VGA_R,
      output   [ 7: 0]   VGA_G,
      output   [ 7: 0]   VGA_B,
      output             VGA_BLANK_N,
      output             VGA_SYNC_N,

      ///////// Audio /////////
      inout              AUD_BCLK,
      output             AUD_XCK,
      inout              AUD_ADCLRCK,
      input              AUD_ADCDAT,
      inout              AUD_DACLRCK,
      output             AUD_DACDAT,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// ADC /////////
      output             ADC_SCLK,
      input              ADC_DOUT,
      output             ADC_DIN,
      output             ADC_CONVST,

      ///////// I2C for Audio and Video-In /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      inout    [35: 0]   GPIO,

`ifdef ENABLE_HSMC
      ///////// HSMC /////////
      input              HSMC_CLKIN_P1,
      input              HSMC_CLKIN_N1,
      input              HSMC_CLKIN_P2,
      input              HSMC_CLKIN_N2,
      output             HSMC_CLKOUT_P1,
      output             HSMC_CLKOUT_N1,
      output             HSMC_CLKOUT_P2,
      output             HSMC_CLKOUT_N2,
      inout    [16: 0]   HSMC_TX_D_P,
      inout    [16: 0]   HSMC_TX_D_N,
      inout    [16: 0]   HSMC_RX_D_P,
      inout    [16: 0]   HSMC_RX_D_N,
      input              HSMC_CLKIN0,
      output             HSMC_CLKOUT0,
      inout    [ 3: 0]   HSMC_D,
      output             HSMC_SCL,
      inout              HSMC_SDA,
`endif /*ENABLE_HSMC*/

`ifdef ENABLE_HPS
      ///////// HPS /////////
      inout              HPS_CONV_USB_N,
      output   [14: 0]   HPS_DDR3_ADDR,
      output   [ 2: 0]   HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output   [ 3: 0]   HPS_DDR3_DM,
      inout    [31: 0]   HPS_DDR3_DQ,
      inout    [ 3: 0]   HPS_DDR3_DQS_N,
      inout    [ 3: 0]   HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input    [ 3: 0]   HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output   [ 3: 0]   HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout    [ 3: 0]   HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LCM_BK,
      inout              HPS_LCM_D_C,
      inout              HPS_LCM_RST_N,
      input              HPS_LCM_SPIM_CLK,
      output             HPS_LCM_SPIM_MOSI,
	  input 			 HPS_LCM_SPIM_MISO,
      output             HPS_LCM_SPIM_SS,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      inout              HPS_RESET_N,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout    [ 3: 0]   HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      output             HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout    [ 7: 0]   HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/


      ///////// IR /////////
      output             IRDA_TXD,
      input              IRDA_RXD
);




//=======================================================
//  REG/WIRE declarations
//=======================================================

wire   locked;

// vga
wire       vga_clk;
wire       vga_hs;
wire       vga_vs;
wire [7:0] vga_r;
wire [7:0] vga_g;
wire [7:0] vga_b;


//	For Audio CODEC
wire		AUD_CTRL_CLK;	//	For Audio Controller

	
		
// vga on board
assign {VGA_R, VGA_G, VGA_B} = {vga_r,vga_g,vga_b};
assign VGA_BLANK_N = 1'b1;
assign VGA_SYNC_N = 1'b0;
assign VGA_HS = ~vga_hs;
assign VGA_VS = ~vga_vs;
assign VGA_CLK = vga_clk;

//=======================================================
//  Structural coding
//=======================================================


DE10_Standard_VIP_Qsys u0(

		/*input  wire        */    .clk_clk(CLOCK_50),     
		/*input  wire        */    .reset_reset_n(1'b1), 

   //clocks
		/*output wire  */    .clk_sdram_clk(DRAM_CLK), 
		/*output wire  */    .clk_vga_clk(vga_clk), 
		/*output wire  */    .clk_aud_clk(AUD_CTRL_CLK), 


	//TV in
      /*input  wire        */    .alt_vip_cl_cvi_0_clocked_video_vid_clk(TD_CLK27),            
		/*input  wire [7:0]  */    .alt_vip_cl_cvi_0_clocked_video_vid_data(TD_DATA),           
		/*input  wire        */    .alt_vip_cl_cvi_0_clocked_video_vid_de(1'b1),             
		/*input  wire        */    .alt_vip_cl_cvi_0_clocked_video_vid_datavalid(1'b1),      
		/*input  wire        */    .alt_vip_cl_cvi_0_clocked_video_vid_locked(1'b1),         
		/*input  wire        */    .alt_vip_cl_cvi_0_clocked_video_vid_f(),              
		/*input  wire        */    .alt_vip_cl_cvi_0_clocked_video_vid_v_sync(),         
		/*input  wire        */    .alt_vip_cl_cvi_0_clocked_video_vid_h_sync(),         
		/*input  wire [7:0]  */    .alt_vip_cl_cvi_0_clocked_video_vid_color_encoding(), 
		/*input  wire [7:0]  */    .alt_vip_cl_cvi_0_clocked_video_vid_bit_width(),      
		/*output wire        */    .alt_vip_cl_cvi_0_clocked_video_sof(),                
		/*output wire        */    .alt_vip_cl_cvi_0_clocked_video_sof_locked(),         
		/*output wire        */    .alt_vip_cl_cvi_0_clocked_video_refclk_div(),         
		/*output wire        */    .alt_vip_cl_cvi_0_clocked_video_clipping(),           
		/*output wire        */    .alt_vip_cl_cvi_0_clocked_video_padding(),            
		/*output wire        */    .alt_vip_cl_cvi_0_clocked_video_overflow(),        

	// sdram buffer
		/*output wire [12:0] */    .sdram_wire_addr(DRAM_ADDR),                                 
		/*output wire [1:0]  */    .sdram_wire_ba(DRAM_BA),                                   
		/*output wire        */    .sdram_wire_cas_n(DRAM_CAS_N),                                
		/*output wire        */    .sdram_wire_cke(DRAM_CKE),                                  
		/*output wire        */    .sdram_wire_cs_n(DRAM_CS_N),                                 
		/*inout  wire [15:0] */    .sdram_wire_dq(DRAM_DQ),                                   
		/*output wire [1:0]  */    .sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),                                  
		/*output wire        */    .sdram_wire_ras_n(DRAM_RAS_N),                                
		/*output wire        */    .sdram_wire_we_n(DRAM_WE_N),    
		
	//vga out
    // cvo 
		/*input  wire        */    .alt_vip_itc_0_clocked_video_vid_clk(vga_clk),               
		/*output wire [23:0] */    .alt_vip_itc_0_clocked_video_vid_data({vga_r,vga_g,vga_b}),              
		/*output wire        */    .alt_vip_itc_0_clocked_video_underflow(),             
		/*output wire        */    .alt_vip_itc_0_clocked_video_vid_datavalid(),         
		/*output wire        */    .alt_vip_itc_0_clocked_video_vid_v_sync(vga_vs),            
		/*output wire        */    .alt_vip_itc_0_clocked_video_vid_h_sync(vga_hs),            
		/*output wire        */    .alt_vip_itc_0_clocked_video_vid_f(),                 
		/*output wire        */    .alt_vip_itc_0_clocked_video_vid_h(),                 
		/*output wire        */    .alt_vip_itc_0_clocked_video_vid_v()                

	);



	
//	Turn On TV Decoder
assign	TD_RESET_N	=	1'b1;

assign	AUD_XCK	=	AUD_CTRL_CLK;
assign	AUD_ADCLRCK	=	AUD_DACLRCK;

AUDIO_DAC 	u12	(	//	Audio Side
					.oAUD_BCK(AUD_BCLK),
					.oAUD_DATA(AUD_DACDAT),
					.oAUD_LRCK(AUD_DACLRCK),
					//	Control Signals
					.iSrc_Select(2'b01),
			      .iCLK_18_4(AUD_CTRL_CLK),
					.iRST_N(KEY[0])	);

//	Audio CODEC and video decoder setting
I2C_AV_Config 	u1	(	//	Host Side
						.iCLK(CLOCK_50),
						.iRST_N(KEY[0]),
						//	I2C Side
						.I2C_SCLK(FPGA_I2C_SCLK),
						.I2C_SDAT(FPGA_I2C_SDAT)	);	

		
heart_beat  heart_TD_CLK27 (.CLK  (TD_CLK27), .CLK_FREQ (27_000_000), .CK_1HZ (LEDR[9]) ) ;


endmodule
