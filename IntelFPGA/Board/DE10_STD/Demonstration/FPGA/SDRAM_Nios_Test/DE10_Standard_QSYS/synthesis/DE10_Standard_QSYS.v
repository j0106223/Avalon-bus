// DE10_Standard_QSYS.v

// Generated using ACDS version 16.1 196

`timescale 1 ps / 1 ps
module DE10_Standard_QSYS (
		input  wire        clk_clk,                        //                     clk.clk
		output wire        clk_sdram_clk,                  //               clk_sdram.clk
		input  wire [3:0]  key_external_connection_export, // key_external_connection.export
		output wire        pll_locked_export,              //              pll_locked.export
		input  wire        reset_reset_n,                  //                   reset.reset_n
		output wire [12:0] sdram_wire_addr,                //              sdram_wire.addr
		output wire [1:0]  sdram_wire_ba,                  //                        .ba
		output wire        sdram_wire_cas_n,               //                        .cas_n
		output wire        sdram_wire_cke,                 //                        .cke
		output wire        sdram_wire_cs_n,                //                        .cs_n
		inout  wire [15:0] sdram_wire_dq,                  //                        .dq
		output wire [1:0]  sdram_wire_dqm,                 //                        .dqm
		output wire        sdram_wire_ras_n,               //                        .ras_n
		output wire        sdram_wire_we_n                 //                        .we_n
	);

	wire         pll_outclk0_clk;                                            // pll:outclk_0 -> [irq_mapper:clk, jtag_uart:clk, key:clk, mm_interconnect_0:pll_outclk0_clk, nios2_gen2_0:clk, onchip_memory2:clk, rst_controller:clk, rst_controller_001:clk, sdram:clk, sysid_qsys:clock, timer:clk]
	wire  [31:0] nios2_gen2_0_data_master_readdata;                          // mm_interconnect_0:nios2_gen2_0_data_master_readdata -> nios2_gen2_0:d_readdata
	wire         nios2_gen2_0_data_master_waitrequest;                       // mm_interconnect_0:nios2_gen2_0_data_master_waitrequest -> nios2_gen2_0:d_waitrequest
	wire         nios2_gen2_0_data_master_debugaccess;                       // nios2_gen2_0:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:nios2_gen2_0_data_master_debugaccess
	wire  [26:0] nios2_gen2_0_data_master_address;                           // nios2_gen2_0:d_address -> mm_interconnect_0:nios2_gen2_0_data_master_address
	wire   [3:0] nios2_gen2_0_data_master_byteenable;                        // nios2_gen2_0:d_byteenable -> mm_interconnect_0:nios2_gen2_0_data_master_byteenable
	wire         nios2_gen2_0_data_master_read;                              // nios2_gen2_0:d_read -> mm_interconnect_0:nios2_gen2_0_data_master_read
	wire         nios2_gen2_0_data_master_readdatavalid;                     // mm_interconnect_0:nios2_gen2_0_data_master_readdatavalid -> nios2_gen2_0:d_readdatavalid
	wire         nios2_gen2_0_data_master_write;                             // nios2_gen2_0:d_write -> mm_interconnect_0:nios2_gen2_0_data_master_write
	wire  [31:0] nios2_gen2_0_data_master_writedata;                         // nios2_gen2_0:d_writedata -> mm_interconnect_0:nios2_gen2_0_data_master_writedata
	wire  [31:0] nios2_gen2_0_instruction_master_readdata;                   // mm_interconnect_0:nios2_gen2_0_instruction_master_readdata -> nios2_gen2_0:i_readdata
	wire         nios2_gen2_0_instruction_master_waitrequest;                // mm_interconnect_0:nios2_gen2_0_instruction_master_waitrequest -> nios2_gen2_0:i_waitrequest
	wire  [26:0] nios2_gen2_0_instruction_master_address;                    // nios2_gen2_0:i_address -> mm_interconnect_0:nios2_gen2_0_instruction_master_address
	wire         nios2_gen2_0_instruction_master_read;                       // nios2_gen2_0:i_read -> mm_interconnect_0:nios2_gen2_0_instruction_master_read
	wire         nios2_gen2_0_instruction_master_readdatavalid;              // mm_interconnect_0:nios2_gen2_0_instruction_master_readdatavalid -> nios2_gen2_0:i_readdatavalid
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect;   // mm_interconnect_0:jtag_uart_avalon_jtag_slave_chipselect -> jtag_uart:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata;     // jtag_uart:av_readdata -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest;  // jtag_uart:av_waitrequest -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_address;      // mm_interconnect_0:jtag_uart_avalon_jtag_slave_address -> jtag_uart:av_address
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_read;         // mm_interconnect_0:jtag_uart_avalon_jtag_slave_read -> jtag_uart:av_read_n
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_write;        // mm_interconnect_0:jtag_uart_avalon_jtag_slave_write -> jtag_uart:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata;    // mm_interconnect_0:jtag_uart_avalon_jtag_slave_writedata -> jtag_uart:av_writedata
	wire  [31:0] mm_interconnect_0_sysid_qsys_control_slave_readdata;        // sysid_qsys:readdata -> mm_interconnect_0:sysid_qsys_control_slave_readdata
	wire   [0:0] mm_interconnect_0_sysid_qsys_control_slave_address;         // mm_interconnect_0:sysid_qsys_control_slave_address -> sysid_qsys:address
	wire  [31:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata;    // nios2_gen2_0:debug_mem_slave_readdata -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_readdata
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest; // nios2_gen2_0:debug_mem_slave_waitrequest -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess; // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_debugaccess -> nios2_gen2_0:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address;     // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_address -> nios2_gen2_0:debug_mem_slave_address
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read;        // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_read -> nios2_gen2_0:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable;  // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_byteenable -> nios2_gen2_0:debug_mem_slave_byteenable
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write;       // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_write -> nios2_gen2_0:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata;   // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_writedata -> nios2_gen2_0:debug_mem_slave_writedata
	wire         mm_interconnect_0_onchip_memory2_s1_chipselect;             // mm_interconnect_0:onchip_memory2_s1_chipselect -> onchip_memory2:chipselect
	wire  [31:0] mm_interconnect_0_onchip_memory2_s1_readdata;               // onchip_memory2:readdata -> mm_interconnect_0:onchip_memory2_s1_readdata
	wire  [14:0] mm_interconnect_0_onchip_memory2_s1_address;                // mm_interconnect_0:onchip_memory2_s1_address -> onchip_memory2:address
	wire   [3:0] mm_interconnect_0_onchip_memory2_s1_byteenable;             // mm_interconnect_0:onchip_memory2_s1_byteenable -> onchip_memory2:byteenable
	wire         mm_interconnect_0_onchip_memory2_s1_write;                  // mm_interconnect_0:onchip_memory2_s1_write -> onchip_memory2:write
	wire  [31:0] mm_interconnect_0_onchip_memory2_s1_writedata;              // mm_interconnect_0:onchip_memory2_s1_writedata -> onchip_memory2:writedata
	wire         mm_interconnect_0_onchip_memory2_s1_clken;                  // mm_interconnect_0:onchip_memory2_s1_clken -> onchip_memory2:clken
	wire         mm_interconnect_0_timer_s1_chipselect;                      // mm_interconnect_0:timer_s1_chipselect -> timer:chipselect
	wire  [15:0] mm_interconnect_0_timer_s1_readdata;                        // timer:readdata -> mm_interconnect_0:timer_s1_readdata
	wire   [2:0] mm_interconnect_0_timer_s1_address;                         // mm_interconnect_0:timer_s1_address -> timer:address
	wire         mm_interconnect_0_timer_s1_write;                           // mm_interconnect_0:timer_s1_write -> timer:write_n
	wire  [15:0] mm_interconnect_0_timer_s1_writedata;                       // mm_interconnect_0:timer_s1_writedata -> timer:writedata
	wire         mm_interconnect_0_sdram_s1_chipselect;                      // mm_interconnect_0:sdram_s1_chipselect -> sdram:az_cs
	wire  [15:0] mm_interconnect_0_sdram_s1_readdata;                        // sdram:za_data -> mm_interconnect_0:sdram_s1_readdata
	wire         mm_interconnect_0_sdram_s1_waitrequest;                     // sdram:za_waitrequest -> mm_interconnect_0:sdram_s1_waitrequest
	wire  [24:0] mm_interconnect_0_sdram_s1_address;                         // mm_interconnect_0:sdram_s1_address -> sdram:az_addr
	wire         mm_interconnect_0_sdram_s1_read;                            // mm_interconnect_0:sdram_s1_read -> sdram:az_rd_n
	wire   [1:0] mm_interconnect_0_sdram_s1_byteenable;                      // mm_interconnect_0:sdram_s1_byteenable -> sdram:az_be_n
	wire         mm_interconnect_0_sdram_s1_readdatavalid;                   // sdram:za_valid -> mm_interconnect_0:sdram_s1_readdatavalid
	wire         mm_interconnect_0_sdram_s1_write;                           // mm_interconnect_0:sdram_s1_write -> sdram:az_wr_n
	wire  [15:0] mm_interconnect_0_sdram_s1_writedata;                       // mm_interconnect_0:sdram_s1_writedata -> sdram:az_data
	wire         mm_interconnect_0_key_s1_chipselect;                        // mm_interconnect_0:key_s1_chipselect -> key:chipselect
	wire  [31:0] mm_interconnect_0_key_s1_readdata;                          // key:readdata -> mm_interconnect_0:key_s1_readdata
	wire   [1:0] mm_interconnect_0_key_s1_address;                           // mm_interconnect_0:key_s1_address -> key:address
	wire         mm_interconnect_0_key_s1_write;                             // mm_interconnect_0:key_s1_write -> key:write_n
	wire  [31:0] mm_interconnect_0_key_s1_writedata;                         // mm_interconnect_0:key_s1_writedata -> key:writedata
	wire         irq_mapper_receiver0_irq;                                   // jtag_uart:av_irq -> irq_mapper:receiver0_irq
	wire         irq_mapper_receiver1_irq;                                   // timer:irq -> irq_mapper:receiver1_irq
	wire         irq_mapper_receiver2_irq;                                   // key:irq -> irq_mapper:receiver2_irq
	wire  [31:0] nios2_gen2_0_irq_irq;                                       // irq_mapper:sender_irq -> nios2_gen2_0:irq
	wire         rst_controller_reset_out_reset;                             // rst_controller:reset_out -> [jtag_uart:rst_n, key:reset_n, mm_interconnect_0:jtag_uart_reset_reset_bridge_in_reset_reset, onchip_memory2:reset, rst_translator:in_reset, sdram:reset_n, sysid_qsys:reset_n, timer:reset_n]
	wire         rst_controller_reset_out_reset_req;                         // rst_controller:reset_req -> [onchip_memory2:reset_req, rst_translator:reset_req_in]
	wire         rst_controller_001_reset_out_reset;                         // rst_controller_001:reset_out -> [irq_mapper:reset, mm_interconnect_0:nios2_gen2_0_reset_reset_bridge_in_reset_reset, nios2_gen2_0:reset_n]
	wire         rst_controller_001_reset_out_reset_req;                     // rst_controller_001:reset_req -> [nios2_gen2_0:reset_req, rst_translator_001:reset_req_in]
	wire         nios2_gen2_0_debug_reset_request_reset;                     // nios2_gen2_0:debug_reset_request -> rst_controller_001:reset_in1

	DE10_Standard_QSYS_jtag_uart jtag_uart (
		.clk            (pll_outclk0_clk),                                           //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                           //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver0_irq)                                   //               irq.irq
	);

	DE10_Standard_QSYS_key key (
		.clk        (pll_outclk0_clk),                     //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),     //               reset.reset_n
		.address    (mm_interconnect_0_key_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_key_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_key_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_key_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_key_s1_readdata),   //                    .readdata
		.in_port    (key_external_connection_export),      // external_connection.export
		.irq        (irq_mapper_receiver2_irq)             //                 irq.irq
	);

	DE10_Standard_QSYS_nios2_gen2_0 nios2_gen2_0 (
		.clk                                 (pll_outclk0_clk),                                            //                       clk.clk
		.reset_n                             (~rst_controller_001_reset_out_reset),                        //                     reset.reset_n
		.reset_req                           (rst_controller_001_reset_out_reset_req),                     //                          .reset_req
		.d_address                           (nios2_gen2_0_data_master_address),                           //               data_master.address
		.d_byteenable                        (nios2_gen2_0_data_master_byteenable),                        //                          .byteenable
		.d_read                              (nios2_gen2_0_data_master_read),                              //                          .read
		.d_readdata                          (nios2_gen2_0_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (nios2_gen2_0_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (nios2_gen2_0_data_master_write),                             //                          .write
		.d_writedata                         (nios2_gen2_0_data_master_writedata),                         //                          .writedata
		.d_readdatavalid                     (nios2_gen2_0_data_master_readdatavalid),                     //                          .readdatavalid
		.debug_mem_slave_debugaccess_to_roms (nios2_gen2_0_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (nios2_gen2_0_instruction_master_address),                    //        instruction_master.address
		.i_read                              (nios2_gen2_0_instruction_master_read),                       //                          .read
		.i_readdata                          (nios2_gen2_0_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (nios2_gen2_0_instruction_master_waitrequest),                //                          .waitrequest
		.i_readdatavalid                     (nios2_gen2_0_instruction_master_readdatavalid),              //                          .readdatavalid
		.irq                                 (nios2_gen2_0_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (nios2_gen2_0_debug_reset_request_reset),                     //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                            // custom_instruction_master.readra
	);

	DE10_Standard_QSYS_onchip_memory2 onchip_memory2 (
		.clk        (pll_outclk0_clk),                                //   clk1.clk
		.address    (mm_interconnect_0_onchip_memory2_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_memory2_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_memory2_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_memory2_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_memory2_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_memory2_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_memory2_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),                 // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),             //       .reset_req
		.freeze     (1'b0)                                            // (terminated)
	);

	DE10_Standard_QSYS_pll pll (
		.refclk   (clk_clk),           //  refclk.clk
		.rst      (~reset_reset_n),    //   reset.reset
		.outclk_0 (pll_outclk0_clk),   // outclk0.clk
		.outclk_1 (clk_sdram_clk),     // outclk1.clk
		.locked   (pll_locked_export)  //  locked.export
	);

	DE10_Standard_QSYS_sdram sdram (
		.clk            (pll_outclk0_clk),                          //   clk.clk
		.reset_n        (~rst_controller_reset_out_reset),          // reset.reset_n
		.az_addr        (mm_interconnect_0_sdram_s1_address),       //    s1.address
		.az_be_n        (~mm_interconnect_0_sdram_s1_byteenable),   //      .byteenable_n
		.az_cs          (mm_interconnect_0_sdram_s1_chipselect),    //      .chipselect
		.az_data        (mm_interconnect_0_sdram_s1_writedata),     //      .writedata
		.az_rd_n        (~mm_interconnect_0_sdram_s1_read),         //      .read_n
		.az_wr_n        (~mm_interconnect_0_sdram_s1_write),        //      .write_n
		.za_data        (mm_interconnect_0_sdram_s1_readdata),      //      .readdata
		.za_valid       (mm_interconnect_0_sdram_s1_readdatavalid), //      .readdatavalid
		.za_waitrequest (mm_interconnect_0_sdram_s1_waitrequest),   //      .waitrequest
		.zs_addr        (sdram_wire_addr),                          //  wire.export
		.zs_ba          (sdram_wire_ba),                            //      .export
		.zs_cas_n       (sdram_wire_cas_n),                         //      .export
		.zs_cke         (sdram_wire_cke),                           //      .export
		.zs_cs_n        (sdram_wire_cs_n),                          //      .export
		.zs_dq          (sdram_wire_dq),                            //      .export
		.zs_dqm         (sdram_wire_dqm),                           //      .export
		.zs_ras_n       (sdram_wire_ras_n),                         //      .export
		.zs_we_n        (sdram_wire_we_n)                           //      .export
	);

	DE10_Standard_QSYS_sysid_qsys sysid_qsys (
		.clock    (pll_outclk0_clk),                                     //           clk.clk
		.reset_n  (~rst_controller_reset_out_reset),                     //         reset.reset_n
		.readdata (mm_interconnect_0_sysid_qsys_control_slave_readdata), // control_slave.readdata
		.address  (mm_interconnect_0_sysid_qsys_control_slave_address)   //              .address
	);

	DE10_Standard_QSYS_timer timer (
		.clk        (pll_outclk0_clk),                       //   clk.clk
		.reset_n    (~rst_controller_reset_out_reset),       // reset.reset_n
		.address    (mm_interconnect_0_timer_s1_address),    //    s1.address
		.writedata  (mm_interconnect_0_timer_s1_writedata),  //      .writedata
		.readdata   (mm_interconnect_0_timer_s1_readdata),   //      .readdata
		.chipselect (mm_interconnect_0_timer_s1_chipselect), //      .chipselect
		.write_n    (~mm_interconnect_0_timer_s1_write),     //      .write_n
		.irq        (irq_mapper_receiver1_irq)               //   irq.irq
	);

	DE10_Standard_QSYS_mm_interconnect_0 mm_interconnect_0 (
		.pll_outclk0_clk                                (pll_outclk0_clk),                                            //                              pll_outclk0.clk
		.jtag_uart_reset_reset_bridge_in_reset_reset    (rst_controller_reset_out_reset),                             //    jtag_uart_reset_reset_bridge_in_reset.reset
		.nios2_gen2_0_reset_reset_bridge_in_reset_reset (rst_controller_001_reset_out_reset),                         // nios2_gen2_0_reset_reset_bridge_in_reset.reset
		.nios2_gen2_0_data_master_address               (nios2_gen2_0_data_master_address),                           //                 nios2_gen2_0_data_master.address
		.nios2_gen2_0_data_master_waitrequest           (nios2_gen2_0_data_master_waitrequest),                       //                                         .waitrequest
		.nios2_gen2_0_data_master_byteenable            (nios2_gen2_0_data_master_byteenable),                        //                                         .byteenable
		.nios2_gen2_0_data_master_read                  (nios2_gen2_0_data_master_read),                              //                                         .read
		.nios2_gen2_0_data_master_readdata              (nios2_gen2_0_data_master_readdata),                          //                                         .readdata
		.nios2_gen2_0_data_master_readdatavalid         (nios2_gen2_0_data_master_readdatavalid),                     //                                         .readdatavalid
		.nios2_gen2_0_data_master_write                 (nios2_gen2_0_data_master_write),                             //                                         .write
		.nios2_gen2_0_data_master_writedata             (nios2_gen2_0_data_master_writedata),                         //                                         .writedata
		.nios2_gen2_0_data_master_debugaccess           (nios2_gen2_0_data_master_debugaccess),                       //                                         .debugaccess
		.nios2_gen2_0_instruction_master_address        (nios2_gen2_0_instruction_master_address),                    //          nios2_gen2_0_instruction_master.address
		.nios2_gen2_0_instruction_master_waitrequest    (nios2_gen2_0_instruction_master_waitrequest),                //                                         .waitrequest
		.nios2_gen2_0_instruction_master_read           (nios2_gen2_0_instruction_master_read),                       //                                         .read
		.nios2_gen2_0_instruction_master_readdata       (nios2_gen2_0_instruction_master_readdata),                   //                                         .readdata
		.nios2_gen2_0_instruction_master_readdatavalid  (nios2_gen2_0_instruction_master_readdatavalid),              //                                         .readdatavalid
		.jtag_uart_avalon_jtag_slave_address            (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),      //              jtag_uart_avalon_jtag_slave.address
		.jtag_uart_avalon_jtag_slave_write              (mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),        //                                         .write
		.jtag_uart_avalon_jtag_slave_read               (mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),         //                                         .read
		.jtag_uart_avalon_jtag_slave_readdata           (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),     //                                         .readdata
		.jtag_uart_avalon_jtag_slave_writedata          (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),    //                                         .writedata
		.jtag_uart_avalon_jtag_slave_waitrequest        (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest),  //                                         .waitrequest
		.jtag_uart_avalon_jtag_slave_chipselect         (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),   //                                         .chipselect
		.key_s1_address                                 (mm_interconnect_0_key_s1_address),                           //                                   key_s1.address
		.key_s1_write                                   (mm_interconnect_0_key_s1_write),                             //                                         .write
		.key_s1_readdata                                (mm_interconnect_0_key_s1_readdata),                          //                                         .readdata
		.key_s1_writedata                               (mm_interconnect_0_key_s1_writedata),                         //                                         .writedata
		.key_s1_chipselect                              (mm_interconnect_0_key_s1_chipselect),                        //                                         .chipselect
		.nios2_gen2_0_debug_mem_slave_address           (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address),     //             nios2_gen2_0_debug_mem_slave.address
		.nios2_gen2_0_debug_mem_slave_write             (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write),       //                                         .write
		.nios2_gen2_0_debug_mem_slave_read              (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read),        //                                         .read
		.nios2_gen2_0_debug_mem_slave_readdata          (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata),    //                                         .readdata
		.nios2_gen2_0_debug_mem_slave_writedata         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata),   //                                         .writedata
		.nios2_gen2_0_debug_mem_slave_byteenable        (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable),  //                                         .byteenable
		.nios2_gen2_0_debug_mem_slave_waitrequest       (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest), //                                         .waitrequest
		.nios2_gen2_0_debug_mem_slave_debugaccess       (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess), //                                         .debugaccess
		.onchip_memory2_s1_address                      (mm_interconnect_0_onchip_memory2_s1_address),                //                        onchip_memory2_s1.address
		.onchip_memory2_s1_write                        (mm_interconnect_0_onchip_memory2_s1_write),                  //                                         .write
		.onchip_memory2_s1_readdata                     (mm_interconnect_0_onchip_memory2_s1_readdata),               //                                         .readdata
		.onchip_memory2_s1_writedata                    (mm_interconnect_0_onchip_memory2_s1_writedata),              //                                         .writedata
		.onchip_memory2_s1_byteenable                   (mm_interconnect_0_onchip_memory2_s1_byteenable),             //                                         .byteenable
		.onchip_memory2_s1_chipselect                   (mm_interconnect_0_onchip_memory2_s1_chipselect),             //                                         .chipselect
		.onchip_memory2_s1_clken                        (mm_interconnect_0_onchip_memory2_s1_clken),                  //                                         .clken
		.sdram_s1_address                               (mm_interconnect_0_sdram_s1_address),                         //                                 sdram_s1.address
		.sdram_s1_write                                 (mm_interconnect_0_sdram_s1_write),                           //                                         .write
		.sdram_s1_read                                  (mm_interconnect_0_sdram_s1_read),                            //                                         .read
		.sdram_s1_readdata                              (mm_interconnect_0_sdram_s1_readdata),                        //                                         .readdata
		.sdram_s1_writedata                             (mm_interconnect_0_sdram_s1_writedata),                       //                                         .writedata
		.sdram_s1_byteenable                            (mm_interconnect_0_sdram_s1_byteenable),                      //                                         .byteenable
		.sdram_s1_readdatavalid                         (mm_interconnect_0_sdram_s1_readdatavalid),                   //                                         .readdatavalid
		.sdram_s1_waitrequest                           (mm_interconnect_0_sdram_s1_waitrequest),                     //                                         .waitrequest
		.sdram_s1_chipselect                            (mm_interconnect_0_sdram_s1_chipselect),                      //                                         .chipselect
		.sysid_qsys_control_slave_address               (mm_interconnect_0_sysid_qsys_control_slave_address),         //                 sysid_qsys_control_slave.address
		.sysid_qsys_control_slave_readdata              (mm_interconnect_0_sysid_qsys_control_slave_readdata),        //                                         .readdata
		.timer_s1_address                               (mm_interconnect_0_timer_s1_address),                         //                                 timer_s1.address
		.timer_s1_write                                 (mm_interconnect_0_timer_s1_write),                           //                                         .write
		.timer_s1_readdata                              (mm_interconnect_0_timer_s1_readdata),                        //                                         .readdata
		.timer_s1_writedata                             (mm_interconnect_0_timer_s1_writedata),                       //                                         .writedata
		.timer_s1_chipselect                            (mm_interconnect_0_timer_s1_chipselect)                       //                                         .chipselect
	);

	DE10_Standard_QSYS_irq_mapper irq_mapper (
		.clk           (pll_outclk0_clk),                    //       clk.clk
		.reset         (rst_controller_001_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),           // receiver0.irq
		.receiver1_irq (irq_mapper_receiver1_irq),           // receiver1.irq
		.receiver2_irq (irq_mapper_receiver2_irq),           // receiver2.irq
		.sender_irq    (nios2_gen2_0_irq_irq)                //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (pll_outclk0_clk),                    //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (2),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller_001 (
		.reset_in0      (~reset_reset_n),                         // reset_in0.reset
		.reset_in1      (nios2_gen2_0_debug_reset_request_reset), // reset_in1.reset
		.clk            (pll_outclk0_clk),                        //       clk.clk
		.reset_out      (rst_controller_001_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_001_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                                   // (terminated)
		.reset_req_in1  (1'b0),                                   // (terminated)
		.reset_in2      (1'b0),                                   // (terminated)
		.reset_req_in2  (1'b0),                                   // (terminated)
		.reset_in3      (1'b0),                                   // (terminated)
		.reset_req_in3  (1'b0),                                   // (terminated)
		.reset_in4      (1'b0),                                   // (terminated)
		.reset_req_in4  (1'b0),                                   // (terminated)
		.reset_in5      (1'b0),                                   // (terminated)
		.reset_req_in5  (1'b0),                                   // (terminated)
		.reset_in6      (1'b0),                                   // (terminated)
		.reset_req_in6  (1'b0),                                   // (terminated)
		.reset_in7      (1'b0),                                   // (terminated)
		.reset_req_in7  (1'b0),                                   // (terminated)
		.reset_in8      (1'b0),                                   // (terminated)
		.reset_req_in8  (1'b0),                                   // (terminated)
		.reset_in9      (1'b0),                                   // (terminated)
		.reset_req_in9  (1'b0),                                   // (terminated)
		.reset_in10     (1'b0),                                   // (terminated)
		.reset_req_in10 (1'b0),                                   // (terminated)
		.reset_in11     (1'b0),                                   // (terminated)
		.reset_req_in11 (1'b0),                                   // (terminated)
		.reset_in12     (1'b0),                                   // (terminated)
		.reset_req_in12 (1'b0),                                   // (terminated)
		.reset_in13     (1'b0),                                   // (terminated)
		.reset_req_in13 (1'b0),                                   // (terminated)
		.reset_in14     (1'b0),                                   // (terminated)
		.reset_req_in14 (1'b0),                                   // (terminated)
		.reset_in15     (1'b0),                                   // (terminated)
		.reset_req_in15 (1'b0)                                    // (terminated)
	);

endmodule
