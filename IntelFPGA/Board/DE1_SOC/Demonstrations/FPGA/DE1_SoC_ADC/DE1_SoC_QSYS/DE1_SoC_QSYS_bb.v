
module DE1_SoC_QSYS (
	clk_clk,
	reset_reset_n,
	adc_ltc2308_conduit_end_CONVST,
	adc_ltc2308_conduit_end_SCK,
	adc_ltc2308_conduit_end_SDI,
	adc_ltc2308_conduit_end_SDO,
	sw_external_connection_export,
	pll_sys_locked_export,
	pll_sys_outclk2_clk);	

	input		clk_clk;
	input		reset_reset_n;
	output		adc_ltc2308_conduit_end_CONVST;
	output		adc_ltc2308_conduit_end_SCK;
	output		adc_ltc2308_conduit_end_SDI;
	input		adc_ltc2308_conduit_end_SDO;
	input	[9:0]	sw_external_connection_export;
	output		pll_sys_locked_export;
	output		pll_sys_outclk2_clk;
endmodule
