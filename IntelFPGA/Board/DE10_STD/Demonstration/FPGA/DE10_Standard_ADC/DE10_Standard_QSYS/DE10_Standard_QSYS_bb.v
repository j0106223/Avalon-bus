
module DE10_Standard_QSYS (
	adc_ltc2308_conduit_end_CONVST,
	adc_ltc2308_conduit_end_SCK,
	adc_ltc2308_conduit_end_SDI,
	adc_ltc2308_conduit_end_SDO,
	clk_clk,
	pll_sys_locked_export,
	pll_sys_outclk2_clk,
	reset_reset_n,
	sw_external_connection_export);	

	output		adc_ltc2308_conduit_end_CONVST;
	output		adc_ltc2308_conduit_end_SCK;
	output		adc_ltc2308_conduit_end_SDI;
	input		adc_ltc2308_conduit_end_SDO;
	input		clk_clk;
	output		pll_sys_locked_export;
	output		pll_sys_outclk2_clk;
	input		reset_reset_n;
	input	[9:0]	sw_external_connection_export;
endmodule
