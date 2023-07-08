	DE1_SoC_QSYS u0 (
		.clk_clk                        (<connected-to-clk_clk>),                        //                     clk.clk
		.reset_reset_n                  (<connected-to-reset_reset_n>),                  //                   reset.reset_n
		.key_external_connection_export (<connected-to-key_external_connection_export>), // key_external_connection.export
		.clk_sdram_clk                  (<connected-to-clk_sdram_clk>),                  //               clk_sdram.clk
		.pll_locked_export              (<connected-to-pll_locked_export>),              //              pll_locked.export
		.sdram_wire_addr                (<connected-to-sdram_wire_addr>),                //              sdram_wire.addr
		.sdram_wire_ba                  (<connected-to-sdram_wire_ba>),                  //                        .ba
		.sdram_wire_cas_n               (<connected-to-sdram_wire_cas_n>),               //                        .cas_n
		.sdram_wire_cke                 (<connected-to-sdram_wire_cke>),                 //                        .cke
		.sdram_wire_cs_n                (<connected-to-sdram_wire_cs_n>),                //                        .cs_n
		.sdram_wire_dq                  (<connected-to-sdram_wire_dq>),                  //                        .dq
		.sdram_wire_dqm                 (<connected-to-sdram_wire_dqm>),                 //                        .dqm
		.sdram_wire_ras_n               (<connected-to-sdram_wire_ras_n>),               //                        .ras_n
		.sdram_wire_we_n                (<connected-to-sdram_wire_we_n>)                 //                        .we_n
	);

