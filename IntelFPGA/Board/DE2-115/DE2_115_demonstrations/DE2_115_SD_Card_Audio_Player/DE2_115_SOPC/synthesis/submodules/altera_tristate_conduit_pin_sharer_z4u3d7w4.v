// altera_tristate_conduit_pin_sharer_z4u3d7w4.v

// This file was auto-generated from altera_tristate_conduit_pin_sharer_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using SOPC Builder version 10.1sp1 197 at 2011.03.16.15:48:46

module altera_tristate_conduit_pin_sharer_z4u3d7w4 (
		input  wire        clk_clk,                               //   clk.clk
		input  wire        reset_reset,                           // reset.reset
		output wire        tcm_request,                           //   tcm.request
		input  wire        tcm_grant,                             //      .grant
		input  wire [7:0]  tcm_tri_state_bridge_flash_data_in,    //      .tri_state_bridge_flash_data_in
		output wire        tcm_write_n_to_the_cfi_flash_out,      //      .write_n_to_the_cfi_flash_out
		output wire        tcm_select_n_to_the_cfi_flash_out,     //      .select_n_to_the_cfi_flash_out
		output wire        tcm_tri_state_bridge_flash_data_outen, //      .tri_state_bridge_flash_data_outen
		output wire [7:0]  tcm_tri_state_bridge_flash_data_out,   //      .tri_state_bridge_flash_data_out
		output wire        tcm_read_n_to_the_cfi_flash_out,       //      .read_n_to_the_cfi_flash_out
		output wire [22:0] tcm_address_to_the_cfi_flash_out,      //      .address_to_the_cfi_flash_out
		input  wire        tcs0_request,                          //  tcs0.request
		output wire        tcs0_grant,                            //      .grant
		input  wire        tcs0_data_outen,                       //      .data_outen
		output wire [7:0]  tcs0_data_in,                          //      .data_in
		input  wire [22:0] tcs0_address_out,                      //      .address_out
		input  wire        tcs0_read_n_out,                       //      .read_n_out
		input  wire        tcs0_write_n_out,                      //      .write_n_out
		input  wire [7:0]  tcs0_data_out,                         //      .data_out
		input  wire        tcs0_chipselect_n_out                  //      .chipselect_n_out
	);

	wire    arbiter_grant_data;        // arbiter:next_grant -> pin_sharer:next_grant
	wire    arbiter_grant_ready;       // pin_sharer:ack -> arbiter:ack
	wire    pin_sharer_tcs0_arb_valid; // pin_sharer:arb_tcs0_request -> arbiter:sink0_valid

	altera_tristate_conduit_pin_sharer_core_d367wjsk pin_sharer (
		.clk                                          (clk_clk),                               //      clk.clk
		.reset                                        (reset_reset),                           //    reset.reset
		.tcs0_request                                 (tcs0_request),                          //     tcs0.request
		.tcs0_grant                                   (tcs0_grant),                            //         .grant
		.i_av_tri_s1_cfi_flash_0_tcm_data_outen       (tcs0_data_outen),                       //         .data_outen
		.i_av_tri_s1_cfi_flash_0_tcm_data_in          (tcs0_data_in),                          //         .data_in
		.i_av_tri_s1_cfi_flash_0_tcm_address_out      (tcs0_address_out),                      //         .address_out
		.i_av_tri_s1_cfi_flash_0_tcm_read_n_out       (tcs0_read_n_out),                       //         .read_n_out
		.i_av_tri_s1_cfi_flash_0_tcm_write_n_out      (tcs0_write_n_out),                      //         .write_n_out
		.i_av_tri_s1_cfi_flash_0_tcm_data_out         (tcs0_data_out),                         //         .data_out
		.i_av_tri_s1_cfi_flash_0_tcm_chipselect_n_out (tcs0_chipselect_n_out),                 //         .chipselect_n_out
		.ack                                          (arbiter_grant_ready),                   //    grant.ready
		.next_grant                                   (arbiter_grant_data),                    //         .data
		.arb_tcs0_request                             (pin_sharer_tcs0_arb_valid),             // tcs0_arb.valid
		.request                                      (tcm_request),                           //      tcm.request
		.grant                                        (tcm_grant),                             //         .grant
		.tri_state_bridge_flash_data_in               (tcm_tri_state_bridge_flash_data_in),    //         .tri_state_bridge_flash_data_in
		.write_n_to_the_cfi_flash_out                 (tcm_write_n_to_the_cfi_flash_out),      //         .write_n_to_the_cfi_flash_out
		.select_n_to_the_cfi_flash_out                (tcm_select_n_to_the_cfi_flash_out),     //         .select_n_to_the_cfi_flash_out
		.tri_state_bridge_flash_data_outen            (tcm_tri_state_bridge_flash_data_outen), //         .tri_state_bridge_flash_data_outen
		.tri_state_bridge_flash_data_out              (tcm_tri_state_bridge_flash_data_out),   //         .tri_state_bridge_flash_data_out
		.read_n_to_the_cfi_flash_out                  (tcm_read_n_to_the_cfi_flash_out),       //         .read_n_to_the_cfi_flash_out
		.address_to_the_cfi_flash_out                 (tcm_address_to_the_cfi_flash_out)       //         .address_to_the_cfi_flash_out
	);

	altera_merlin_std_arbitrator_nwds6k7f arbiter (
		.clk                 (clk_clk),                   //       clk.clk
		.reset               (reset_reset),               // clk_reset.reset
		.ack                 (arbiter_grant_ready),       //     grant.ready
		.next_grant          (arbiter_grant_data),        //          .data
		.sink0_valid         (pin_sharer_tcs0_arb_valid), //     sink0.valid
		.sink0_channel       (1'b0),                      // (terminated)
		.sink0_data          (8'b00000000),               // (terminated)
		.sink0_startofpacket (1'b0),                      // (terminated)
		.sink0_endofpacket   (1'b0)                       // (terminated)
	);

endmodule
