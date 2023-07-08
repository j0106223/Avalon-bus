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


#include "terasic_includes.h"
#include "video_control.h"
#include "mem_verify.h"
 
int main()
{

#if 0
	bool bPass;
	bPass = TMEM_Verify(SDRAM_BASE, SDRAM_SPAN, 0x01, TRUE);
	printf("sdram test:%s\r\n", bPass?"PASS":"NG");
	return 0;

#else

	if (!VIDEO_Enable(TRUE))
		printf("failed to enabled video decoder!\r\n");
	else
		printf("video decoder is enabled successfully!\r\n");


	printf("init MIX, layer 1 is disableD\r\n");
	MIX_Init();

	//MIX_LayerEnable(1, FALSE);

	return 0;


#endif

}
