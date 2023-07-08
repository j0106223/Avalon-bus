// --------------------------------------------------------------------
// Copyright (c) 2011 by Terasic Technologies Inc. 
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
//                     E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/   
//                     email: support@terasic.com
//
// --------------------------------------------------------------------



module DE0_Nano(

	//////////// CLOCK //////////
	CLOCK_50,

	//////////// LED //////////
	LED,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SDRAM //////////
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
	
	//////////// ECPS //////////
	EPCS_ASDO,
	EPCS_DATA0,
	EPCS_DCLK,
	EPCS_NCSO,

	//////////// Accelerometer and EEPROM //////////
	G_SENSOR_CS_N,
	G_SENSOR_INT,
	I2C_SCLK,
	I2C_SDAT,

	//////////// ADC //////////
	ADC_CS_N,
	ADC_SADDR,
	ADC_SCLK,
	ADC_SDAT,

	//////////// 2x13 GPIO Header //////////
	GPIO_2,
	GPIO_2_IN,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO_0,
	GPIO_0_IN,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	GPIO_1,
	GPIO_1_IN 
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;

//////////// LED //////////
output		     [7:0]		LED;

//////////// KEY //////////
input 		     [1:0]		KEY;

//////////// SW //////////
input 		     [3:0]		SW;

//////////// SDRAM //////////
output		    [12:0]		DRAM_ADDR;
output		     [1:0]		DRAM_BA;
output		          		DRAM_CAS_N;
output		          		DRAM_CKE;
output		          		DRAM_CLK;
output		          		DRAM_CS_N;
inout 		    [15:0]		DRAM_DQ;
output		     [1:0]		DRAM_DQM;
output		          		DRAM_RAS_N;
output		          		DRAM_WE_N;

//////////// EPCS //////////
output		          		EPCS_ASDO;
input 		          		EPCS_DATA0;
output		          		EPCS_DCLK;
output		          		EPCS_NCSO;

//////////// Accelerometer and EEPROM //////////
output		          		G_SENSOR_CS_N;
input 		          		G_SENSOR_INT;
output							I2C_SCLK;
inout 		          		I2C_SDAT;

//////////// ADC //////////
output		          		ADC_CS_N;
output		          		ADC_SADDR;
output		          		ADC_SCLK;
input 		          		ADC_SDAT;

//////////// 2x13 GPIO Header //////////
inout 		    [12:0]		GPIO_2;
input 		     [2:0]		GPIO_2_IN;

//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
inout 		    [33:0]		GPIO_0;
input 		     [1:0]		GPIO_0_IN;

//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
inout 		    [33:0]		GPIO_1;
input 		     [1:0]		GPIO_1_IN;


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire reset_n;
wire select_i2c_clk;
wire i2c_clk;
wire spi_clk;



//=======================================================
//  Structural coding
//=======================================================

assign reset_n = 1'b1;

DE0_Nano_SOPC DE0_Nano_SOPC_inst(
                      // 1) global signals:
                       .altpll_io(),
                       .altpll_sdram(DRAM_CLK),
                       .altpll_sys(),
                       .clk_50(CLOCK_50),
                       .reset_n(reset_n),
							  
                      // the_select_i2c_clk
                       .out_port_from_the_select_i2c_clk(select_i2c_clk),							  

							  
                      // the_adc_spi_read
                       .SPI_CLK_from_the_adc_spi_read(ADC_SCLK),
                       .SPI_CS_n_from_the_adc_spi_read(ADC_CS_N),
                       .SPI_IN_to_the_adc_spi_read(ADC_SDAT),
                       .SPI_OUT_from_the_adc_spi_read(ADC_SADDR),
							  
							  
                      // the_altpll_0
                       .locked_from_the_altpll_0(),
                       .phasedone_from_the_altpll_0(),

                      // the_epcs
                       .data0_to_the_epcs(EPCS_DATA0), 
                       .dclk_from_the_epcs(EPCS_DCLK), 
                       .sce_from_the_epcs(EPCS_NCSO), 
                       .sdo_from_the_epcs(EPCS_ASDO), 

							  
                      // the_gsensor_spi
                       .SPI_CS_n_from_the_gsensor_spi(G_SENSOR_CS_N),
                       .SPI_SCLK_from_the_gsensor_spi(spi_clk),
                       .SPI_SDIO_to_and_from_the_gsensor_spi(I2C_SDAT),							  
						  

                      // the_g_sensor_int
                       .in_port_to_the_g_sensor_int(G_SENSOR_INT),

                      // the_i2c_scl
                       .out_port_from_the_i2c_scl(i2c_clk),

                      // the_i2c_sda
                       .bidir_port_to_and_from_the_i2c_sda(I2C_SDAT),

                      // the_key
                       .in_port_to_the_key(KEY),

                      // the_led
                       .out_port_from_the_led(LED),

                      // the_sdram
                       .zs_addr_from_the_sdram(DRAM_ADDR),
                       .zs_ba_from_the_sdram(DRAM_BA),
                       .zs_cas_n_from_the_sdram(DRAM_CAS_N),
                       .zs_cke_from_the_sdram(DRAM_CKE),
                       .zs_cs_n_from_the_sdram(DRAM_CS_N),
                       .zs_dq_to_and_from_the_sdram(DRAM_DQ),
                       .zs_dqm_from_the_sdram(DRAM_DQM),
                       .zs_ras_n_from_the_sdram(DRAM_RAS_N),
                       .zs_we_n_from_the_sdram(DRAM_WE_N),

                      // the_sw
                       .in_port_to_the_sw(SW)
                    );

						  
assign I2C_SCLK = (select_i2c_clk)?i2c_clk:spi_clk;

endmodule
