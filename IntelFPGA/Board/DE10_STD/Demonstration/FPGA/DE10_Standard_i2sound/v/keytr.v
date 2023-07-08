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
// Major Functions:KEY triggle
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author             :| Mod. Date :| Changes Made:
//   V1.0 :| Allen Wang         :| 03/25/10  :| Initial Revision
// ============================================================================



//`define  OUT_BIT  9

module keytr(
	key0,
	rst_n,
	clock,
	
	ON,				
	KEY0_EDGE,
	counter	
	);

//=======================================================
//  PORT declarations
//=======================================================			 
input			key0;
input			rst_n;
input			clock;

output			ON;
output			KEY0_EDGE;
output	[9:0]	counter;

reg     [9:0]  counter;
//reg              KEYON;
//wire ON=((counter[`OUT_BIT]==1) && (key==0))?0:1; 
/*/=============================================================================
// Structural coding
//=============================================================================
always @(negedge ON or posedge clock) 
	begin
		if (!ON)
			begin
				counter=0;
			end 
		else if (counter[`OUT_BIT]==0)
				begin
					counter=counter+1;
				end	
	end

always @(posedge clock) 
	begin
		if  ((counter>=1) && (counter <5))
			begin
				KEYON=0;
			end
		else begin	
				KEYON=1;
			 end
	end*/

///debounce starts

reg		[3:0]	flag_temp;
reg				flag;
reg		[15:0]	delay;
reg				D1;
reg 			D2;
wire			falling_edge;


//falling edge detect,
always@(negedge clock)
begin
  if (flag)
  begin 
     flag_temp<={key0, flag_temp[3:1]};
  end 
end
assign falling_edge = (flag_temp==4'b0011) ? 1'b1 : 1'b0;


////////////
always@(posedge clock,negedge rst_n)
begin
  if (!rst_n)
     flag <= 1'b1;
  else if (delay == 15'd4096)////modify the value here for a better debounce effect when using a high clock frequency;
     flag <= 1'b1;
  else if (falling_edge)
     flag <= 1'b0;
end



//
always@(posedge clock)
begin
  if (!key0)
     delay <= delay+1;
  else
     delay <= 15'd0;
end



///debounce over!
/////////////////////////////////////////
///////////?????
always@(negedge clock)
begin
  D1 <= flag;
  D2 <= D1;
end
assign KEY0_EDGE = (D1 | !D2);

endmodule	
	
