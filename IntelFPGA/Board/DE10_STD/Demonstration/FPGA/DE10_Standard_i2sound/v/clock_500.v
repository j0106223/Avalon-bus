// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altrea Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL or Verilog source code is intended as a design reference
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
// Major Functions: I2C output data
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author             :| Mod. Date :| Changes Made:
//   V1.0 :| Allen Wang         :| 03/24/10  :| Initial Revision
//   V3.0 :| Young       		  :| 01/05/13  :| version 12.1
// ============================================================================
`define rom_size 6'd8

module CLOCK_500(
	CLOCK,
	rst_n,
	END,
	KEY0_EDGE,
	
	DATA,
	GO,
	level_vol,				  
	CLOCK_500,				  
	CLOCK_2
	);
//=======================================================
//  PORT declarations
//=======================================================                
input  		 	CLOCK;
input 		 	rst_n;
input 		 	END;
input 		 	KEY0_EDGE;

output 	[23:0]	DATA;
output 			GO;
output	[3:0] 	level_vol;
output		    CLOCK_500;
output 			CLOCK_2;


reg  	[10:0]	COUNTER_500;
reg  	[15:0]	ROM[`rom_size:0];
reg  	[15:0]	DATA_A;
reg  	[5:0]	address;




wire  CLOCK_500 = COUNTER_500[9];
wire  CLOCK_2 	= COUNTER_500[1];

wire [23:0]DATA = {8'h34, DATA_A};		//slave address + sub_address + register_data
wire  GO = ((address <= `rom_size) && (END == 1)) ? COUNTER_500[10] : 1;
//=============================================================================
// Structural coding
//=============================================================================

always @(posedge CLOCK ) 
begin
	COUNTER_500=COUNTER_500+1;
end


always @(negedge KEY0_EDGE or posedge END) 
begin
	if (!KEY0_EDGE)
	begin
		address=0;
	end
	else if (address <= `rom_size)
	begin
		address=address+1;
	end
end

reg		[4:0]	vol;
wire	[6:0]	volume;

always @(negedge KEY0_EDGE or negedge rst_n) 
begin
	if(!rst_n)
		vol = 5'd31;
	else if(vol == 5'd4)
		vol = 5'd31;
	else if(!KEY0_EDGE)
		vol = vol - 3;
end

//the volume level, level 0 to level 9,
//the higher the level, the greater the sound
assign level_vol = (vol - 4) / 3;
assign volume = vol + 96;


always @(posedge END) 
begin
	ROM[0] = 16'h0c00;	    			 	//power down
	ROM[1] = 16'h0ec2;	   		    	 	//master
	ROM[2] = 16'h0838;	    			 	//sound select
	
	ROM[3] = 16'h1000;						//mclk
	
	ROM[4] = 16'h0017;						//
	ROM[5] = 16'h0217;					 	//
	ROM[6] = {8'h04,1'b0,volume[6:0]};		//left channel headphone output volume
	ROM[7] = {8'h06,1'b0,volume[6:0]};		//right channel headphone output volume
	
	//ROM[4]= 16'h1e00;		             	//reset	
	ROM[`rom_size] = 16'h1201;           	//active
	DATA_A = ROM[address];
end


endmodule
