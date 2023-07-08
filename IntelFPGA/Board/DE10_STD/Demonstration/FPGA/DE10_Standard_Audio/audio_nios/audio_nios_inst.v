	audio_nios u0 (
		.altpll_audio_locked_export         (<connected-to-altpll_audio_locked_export>),         //         altpll_audio_locked.export
		.audio_conduit_end_XCK              (<connected-to-audio_conduit_end_XCK>),              //           audio_conduit_end.XCK
		.audio_conduit_end_ADCDAT           (<connected-to-audio_conduit_end_ADCDAT>),           //                            .ADCDAT
		.audio_conduit_end_ADCLRC           (<connected-to-audio_conduit_end_ADCLRC>),           //                            .ADCLRC
		.audio_conduit_end_DACDAT           (<connected-to-audio_conduit_end_DACDAT>),           //                            .DACDAT
		.audio_conduit_end_DACLRC           (<connected-to-audio_conduit_end_DACLRC>),           //                            .DACLRC
		.audio_conduit_end_BCLK             (<connected-to-audio_conduit_end_BCLK>),             //                            .BCLK
		.clk_clk                            (<connected-to-clk_clk>),                            //                         clk.clk
		.i2c_scl_external_connection_export (<connected-to-i2c_scl_external_connection_export>), // i2c_scl_external_connection.export
		.i2c_sda_external_connection_export (<connected-to-i2c_sda_external_connection_export>), // i2c_sda_external_connection.export
		.key_external_connection_export     (<connected-to-key_external_connection_export>),     //     key_external_connection.export
		.pio_0_external_connection_export   (<connected-to-pio_0_external_connection_export>),   //   pio_0_external_connection.export
		.pll_locked_export                  (<connected-to-pll_locked_export>),                  //                  pll_locked.export
		.pll_sdam_clk                       (<connected-to-pll_sdam_clk>),                       //                    pll_sdam.clk
		.reset_reset_n                      (<connected-to-reset_reset_n>),                      //                       reset.reset_n
		.sdram_wire_addr                    (<connected-to-sdram_wire_addr>),                    //                  sdram_wire.addr
		.sdram_wire_ba                      (<connected-to-sdram_wire_ba>),                      //                            .ba
		.sdram_wire_cas_n                   (<connected-to-sdram_wire_cas_n>),                   //                            .cas_n
		.sdram_wire_cke                     (<connected-to-sdram_wire_cke>),                     //                            .cke
		.sdram_wire_cs_n                    (<connected-to-sdram_wire_cs_n>),                    //                            .cs_n
		.sdram_wire_dq                      (<connected-to-sdram_wire_dq>),                      //                            .dq
		.sdram_wire_dqm                     (<connected-to-sdram_wire_dqm>),                     //                            .dqm
		.sdram_wire_ras_n                   (<connected-to-sdram_wire_ras_n>),                   //                            .ras_n
		.sdram_wire_we_n                    (<connected-to-sdram_wire_we_n>),                    //                            .we_n
		.seg7_conduit_end_export            (<connected-to-seg7_conduit_end_export>),            //            seg7_conduit_end.export
		.sw_external_connection_export      (<connected-to-sw_external_connection_export>)       //      sw_external_connection.export
	);

