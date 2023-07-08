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
//                     web: http://www.terasic.cn/
//                     email: support@terasic.cn
//
// --------------------------------------------------------------------
//
// Major Functions:	SEG HEX decoder
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Peli Li           :| 03/05/2010:| Initial Revision
//   V1.1 :| Allen Wang        :| 06/06/2010:| Change IRDA with IR
// --------------------------------------------------------------------

module SEG_HEX
	(
		////////////////////	4 Binary bits Input	 	////////////////////	 
		iDIG,							
		////////////////////	HEX 7-SEG Output	 	////////////////////	 
		oHEX_D		
	);

////////////////////////	Binary bis Input	 ////////////////////////
input	  [3:0]   iDIG;				
////////////////////	HEX 7-SEG Output	 	////////////////////	 
output	  [6:0]	  oHEX_D;   


//=======================================================
//  REG/WIRE declarations
//=======================================================

reg	  [6:0]	  oHEX_D;	

//=======================================================
//  Structural coding
//=======================================================
always @(iDIG) 
        begin
			case(iDIG)
			4'h0: oHEX_D <= 7'b1000000; //0  
			4'h1: oHEX_D <= 7'b1111001; //1
			4'h2: oHEX_D <= 7'b0100100; //2
			4'h3: oHEX_D <= 7'b0110000; //3
			4'h4: oHEX_D <= 7'b0011001; //4
			4'h5: oHEX_D <= 7'b0010010; //5
			4'h6: oHEX_D <= 7'b0000010; //6
			4'h7: oHEX_D <= 7'b1111000; //7
			4'h8: oHEX_D <= 7'b0000000; //8
			4'h9: oHEX_D <= 7'b0011000; //9
			4'ha: oHEX_D <= 7'b0001000; //a
			4'hb: oHEX_D <= 7'b0000011; //b
			4'hc: oHEX_D <= 7'b1000110; //c
			4'hd: oHEX_D <= 7'b0100001; //d
			4'he: oHEX_D <= 7'b0000110; //e
			4'hf: oHEX_D <= 7'b0001110; //f
	     default: oHEX_D <= 7'b1000000; //0
			endcase
		end

endmodule