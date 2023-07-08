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
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	myfirst_niosii
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author              :| Mod. Date   :| Changes Made:
//   V1.0 :| Yaqun-chang         :| 02/16/2011  :| Initial Revision
// --------------------------------------------------------------------
module myfirst_niosii
(
    CLOCK_50,
    LED
);
input          CLOCK_50;
output [7:0]   LED;
DE0_NANO_QSYS DE0_NANO_QSYS_inst
    (
      .clk_50                    (CLOCK_50),
      .out_port_from_the_pio_led  (LED),
      .reset_n                    (1'b1)
    );
        
endmodule
