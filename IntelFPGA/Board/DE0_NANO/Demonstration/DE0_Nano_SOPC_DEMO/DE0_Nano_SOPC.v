//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2011 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_clock_0_in_arbitrator (
                                             // inputs:
                                              DE0_Nano_SOPC_clock_0_in_endofpacket,
                                              DE0_Nano_SOPC_clock_0_in_readdata,
                                              DE0_Nano_SOPC_clock_0_in_waitrequest,
                                              clk,
                                              cpu_data_master_address_to_slave,
                                              cpu_data_master_byteenable,
                                              cpu_data_master_latency_counter,
                                              cpu_data_master_read,
                                              cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                                              cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                                              cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                              cpu_data_master_write,
                                              cpu_data_master_writedata,
                                              reset_n,

                                             // outputs:
                                              DE0_Nano_SOPC_clock_0_in_address,
                                              DE0_Nano_SOPC_clock_0_in_byteenable,
                                              DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa,
                                              DE0_Nano_SOPC_clock_0_in_nativeaddress,
                                              DE0_Nano_SOPC_clock_0_in_read,
                                              DE0_Nano_SOPC_clock_0_in_readdata_from_sa,
                                              DE0_Nano_SOPC_clock_0_in_reset_n,
                                              DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa,
                                              DE0_Nano_SOPC_clock_0_in_write,
                                              DE0_Nano_SOPC_clock_0_in_writedata,
                                              cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in,
                                              cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in,
                                              cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in,
                                              cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in,
                                              d1_DE0_Nano_SOPC_clock_0_in_end_xfer
                                           )
;

  output  [  3: 0] DE0_Nano_SOPC_clock_0_in_address;
  output  [  3: 0] DE0_Nano_SOPC_clock_0_in_byteenable;
  output           DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa;
  output  [  1: 0] DE0_Nano_SOPC_clock_0_in_nativeaddress;
  output           DE0_Nano_SOPC_clock_0_in_read;
  output  [ 31: 0] DE0_Nano_SOPC_clock_0_in_readdata_from_sa;
  output           DE0_Nano_SOPC_clock_0_in_reset_n;
  output           DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa;
  output           DE0_Nano_SOPC_clock_0_in_write;
  output  [ 31: 0] DE0_Nano_SOPC_clock_0_in_writedata;
  output           cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in;
  output           cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in;
  output           cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in;
  output           cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in;
  output           d1_DE0_Nano_SOPC_clock_0_in_end_xfer;
  input            DE0_Nano_SOPC_clock_0_in_endofpacket;
  input   [ 31: 0] DE0_Nano_SOPC_clock_0_in_readdata;
  input            DE0_Nano_SOPC_clock_0_in_waitrequest;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  3: 0] DE0_Nano_SOPC_clock_0_in_address;
  wire             DE0_Nano_SOPC_clock_0_in_allgrants;
  wire             DE0_Nano_SOPC_clock_0_in_allow_new_arb_cycle;
  wire             DE0_Nano_SOPC_clock_0_in_any_bursting_master_saved_grant;
  wire             DE0_Nano_SOPC_clock_0_in_any_continuerequest;
  wire             DE0_Nano_SOPC_clock_0_in_arb_counter_enable;
  reg     [  1: 0] DE0_Nano_SOPC_clock_0_in_arb_share_counter;
  wire    [  1: 0] DE0_Nano_SOPC_clock_0_in_arb_share_counter_next_value;
  wire    [  1: 0] DE0_Nano_SOPC_clock_0_in_arb_share_set_values;
  wire             DE0_Nano_SOPC_clock_0_in_beginbursttransfer_internal;
  wire             DE0_Nano_SOPC_clock_0_in_begins_xfer;
  wire    [  3: 0] DE0_Nano_SOPC_clock_0_in_byteenable;
  wire             DE0_Nano_SOPC_clock_0_in_end_xfer;
  wire             DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa;
  wire             DE0_Nano_SOPC_clock_0_in_firsttransfer;
  wire             DE0_Nano_SOPC_clock_0_in_grant_vector;
  wire             DE0_Nano_SOPC_clock_0_in_in_a_read_cycle;
  wire             DE0_Nano_SOPC_clock_0_in_in_a_write_cycle;
  wire             DE0_Nano_SOPC_clock_0_in_master_qreq_vector;
  wire    [  1: 0] DE0_Nano_SOPC_clock_0_in_nativeaddress;
  wire             DE0_Nano_SOPC_clock_0_in_non_bursting_master_requests;
  wire             DE0_Nano_SOPC_clock_0_in_read;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_in_readdata_from_sa;
  reg              DE0_Nano_SOPC_clock_0_in_reg_firsttransfer;
  wire             DE0_Nano_SOPC_clock_0_in_reset_n;
  reg              DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable;
  wire             DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable2;
  wire             DE0_Nano_SOPC_clock_0_in_unreg_firsttransfer;
  wire             DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa;
  wire             DE0_Nano_SOPC_clock_0_in_waits_for_read;
  wire             DE0_Nano_SOPC_clock_0_in_waits_for_write;
  wire             DE0_Nano_SOPC_clock_0_in_write;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_in_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_saved_grant_DE0_Nano_SOPC_clock_0_in;
  reg              d1_DE0_Nano_SOPC_clock_0_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_0_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             wait_for_DE0_Nano_SOPC_clock_0_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~DE0_Nano_SOPC_clock_0_in_end_xfer;
    end


  assign DE0_Nano_SOPC_clock_0_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in));
  //assign DE0_Nano_SOPC_clock_0_in_readdata_from_sa = DE0_Nano_SOPC_clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_readdata_from_sa = DE0_Nano_SOPC_clock_0_in_readdata;

  assign cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h6001000) & (cpu_data_master_read | cpu_data_master_write);
  //assign DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa = DE0_Nano_SOPC_clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa = DE0_Nano_SOPC_clock_0_in_waitrequest;

  //DE0_Nano_SOPC_clock_0_in_arb_share_counter set values, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_arb_share_set_values = 1;

  //DE0_Nano_SOPC_clock_0_in_non_bursting_master_requests mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_non_bursting_master_requests = cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in;

  //DE0_Nano_SOPC_clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_any_bursting_master_saved_grant = 0;

  //DE0_Nano_SOPC_clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_arb_share_counter_next_value = DE0_Nano_SOPC_clock_0_in_firsttransfer ? (DE0_Nano_SOPC_clock_0_in_arb_share_set_values - 1) : |DE0_Nano_SOPC_clock_0_in_arb_share_counter ? (DE0_Nano_SOPC_clock_0_in_arb_share_counter - 1) : 0;

  //DE0_Nano_SOPC_clock_0_in_allgrants all slave grants, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_allgrants = |DE0_Nano_SOPC_clock_0_in_grant_vector;

  //DE0_Nano_SOPC_clock_0_in_end_xfer assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_end_xfer = ~(DE0_Nano_SOPC_clock_0_in_waits_for_read | DE0_Nano_SOPC_clock_0_in_waits_for_write);

  //end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_0_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_0_in = DE0_Nano_SOPC_clock_0_in_end_xfer & (~DE0_Nano_SOPC_clock_0_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //DE0_Nano_SOPC_clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_arb_counter_enable = (end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_0_in & DE0_Nano_SOPC_clock_0_in_allgrants) | (end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_0_in & ~DE0_Nano_SOPC_clock_0_in_non_bursting_master_requests);

  //DE0_Nano_SOPC_clock_0_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_in_arb_share_counter <= 0;
      else if (DE0_Nano_SOPC_clock_0_in_arb_counter_enable)
          DE0_Nano_SOPC_clock_0_in_arb_share_counter <= DE0_Nano_SOPC_clock_0_in_arb_share_counter_next_value;
    end


  //DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable <= 0;
      else if ((|DE0_Nano_SOPC_clock_0_in_master_qreq_vector & end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_0_in) | (end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_0_in & ~DE0_Nano_SOPC_clock_0_in_non_bursting_master_requests))
          DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable <= |DE0_Nano_SOPC_clock_0_in_arb_share_counter_next_value;
    end


  //cpu/data_master DE0_Nano_SOPC_clock_0/in arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable & cpu_data_master_continuerequest;

  //DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable2 = |DE0_Nano_SOPC_clock_0_in_arb_share_counter_next_value;

  //cpu/data_master DE0_Nano_SOPC_clock_0/in arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //DE0_Nano_SOPC_clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in = cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register) | (|cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in, which is an e_mux
  assign cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in = cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in & cpu_data_master_read & ~DE0_Nano_SOPC_clock_0_in_waits_for_read;

  //DE0_Nano_SOPC_clock_0_in_writedata mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_writedata = cpu_data_master_writedata;

  //assign DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa = DE0_Nano_SOPC_clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa = DE0_Nano_SOPC_clock_0_in_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in = cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in;

  //cpu/data_master saved-grant DE0_Nano_SOPC_clock_0/in, which is an e_assign
  assign cpu_data_master_saved_grant_DE0_Nano_SOPC_clock_0_in = cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in;

  //allow new arb cycle for DE0_Nano_SOPC_clock_0/in, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign DE0_Nano_SOPC_clock_0_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign DE0_Nano_SOPC_clock_0_in_master_qreq_vector = 1;

  //DE0_Nano_SOPC_clock_0_in_reset_n assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_reset_n = reset_n;

  //DE0_Nano_SOPC_clock_0_in_firsttransfer first transaction, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_firsttransfer = DE0_Nano_SOPC_clock_0_in_begins_xfer ? DE0_Nano_SOPC_clock_0_in_unreg_firsttransfer : DE0_Nano_SOPC_clock_0_in_reg_firsttransfer;

  //DE0_Nano_SOPC_clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_unreg_firsttransfer = ~(DE0_Nano_SOPC_clock_0_in_slavearbiterlockenable & DE0_Nano_SOPC_clock_0_in_any_continuerequest);

  //DE0_Nano_SOPC_clock_0_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_in_reg_firsttransfer <= 1'b1;
      else if (DE0_Nano_SOPC_clock_0_in_begins_xfer)
          DE0_Nano_SOPC_clock_0_in_reg_firsttransfer <= DE0_Nano_SOPC_clock_0_in_unreg_firsttransfer;
    end


  //DE0_Nano_SOPC_clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_beginbursttransfer_internal = DE0_Nano_SOPC_clock_0_in_begins_xfer;

  //DE0_Nano_SOPC_clock_0_in_read assignment, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_read = cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in & cpu_data_master_read;

  //DE0_Nano_SOPC_clock_0_in_write assignment, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_write = cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in & cpu_data_master_write;

  //DE0_Nano_SOPC_clock_0_in_address mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_address = cpu_data_master_address_to_slave;

  //slaveid DE0_Nano_SOPC_clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_nativeaddress = cpu_data_master_address_to_slave >> 2;

  //d1_DE0_Nano_SOPC_clock_0_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_DE0_Nano_SOPC_clock_0_in_end_xfer <= 1;
      else 
        d1_DE0_Nano_SOPC_clock_0_in_end_xfer <= DE0_Nano_SOPC_clock_0_in_end_xfer;
    end


  //DE0_Nano_SOPC_clock_0_in_waits_for_read in a cycle, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_waits_for_read = DE0_Nano_SOPC_clock_0_in_in_a_read_cycle & DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa;

  //DE0_Nano_SOPC_clock_0_in_in_a_read_cycle assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_in_a_read_cycle = cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = DE0_Nano_SOPC_clock_0_in_in_a_read_cycle;

  //DE0_Nano_SOPC_clock_0_in_waits_for_write in a cycle, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_waits_for_write = DE0_Nano_SOPC_clock_0_in_in_a_write_cycle & DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa;

  //DE0_Nano_SOPC_clock_0_in_in_a_write_cycle assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_in_in_a_write_cycle = cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = DE0_Nano_SOPC_clock_0_in_in_a_write_cycle;

  assign wait_for_DE0_Nano_SOPC_clock_0_in_counter = 0;
  //DE0_Nano_SOPC_clock_0_in_byteenable byte enable port mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_in_byteenable = (cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //DE0_Nano_SOPC_clock_0/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_clock_0_out_arbitrator (
                                              // inputs:
                                               DE0_Nano_SOPC_clock_0_out_address,
                                               DE0_Nano_SOPC_clock_0_out_byteenable,
                                               DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave,
                                               DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave,
                                               DE0_Nano_SOPC_clock_0_out_read,
                                               DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave,
                                               DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave,
                                               DE0_Nano_SOPC_clock_0_out_write,
                                               DE0_Nano_SOPC_clock_0_out_writedata,
                                               altpll_sys_pll_slave_readdata_from_sa,
                                               clk,
                                               d1_altpll_sys_pll_slave_end_xfer,
                                               reset_n,

                                              // outputs:
                                               DE0_Nano_SOPC_clock_0_out_address_to_slave,
                                               DE0_Nano_SOPC_clock_0_out_readdata,
                                               DE0_Nano_SOPC_clock_0_out_reset_n,
                                               DE0_Nano_SOPC_clock_0_out_waitrequest
                                            )
;

  output  [  3: 0] DE0_Nano_SOPC_clock_0_out_address_to_slave;
  output  [ 31: 0] DE0_Nano_SOPC_clock_0_out_readdata;
  output           DE0_Nano_SOPC_clock_0_out_reset_n;
  output           DE0_Nano_SOPC_clock_0_out_waitrequest;
  input   [  3: 0] DE0_Nano_SOPC_clock_0_out_address;
  input   [  3: 0] DE0_Nano_SOPC_clock_0_out_byteenable;
  input            DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave;
  input            DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave;
  input            DE0_Nano_SOPC_clock_0_out_read;
  input            DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave;
  input            DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave;
  input            DE0_Nano_SOPC_clock_0_out_write;
  input   [ 31: 0] DE0_Nano_SOPC_clock_0_out_writedata;
  input   [ 31: 0] altpll_sys_pll_slave_readdata_from_sa;
  input            clk;
  input            d1_altpll_sys_pll_slave_end_xfer;
  input            reset_n;

  reg     [  3: 0] DE0_Nano_SOPC_clock_0_out_address_last_time;
  wire    [  3: 0] DE0_Nano_SOPC_clock_0_out_address_to_slave;
  reg     [  3: 0] DE0_Nano_SOPC_clock_0_out_byteenable_last_time;
  reg              DE0_Nano_SOPC_clock_0_out_read_last_time;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_out_readdata;
  wire             DE0_Nano_SOPC_clock_0_out_reset_n;
  wire             DE0_Nano_SOPC_clock_0_out_run;
  wire             DE0_Nano_SOPC_clock_0_out_waitrequest;
  reg              DE0_Nano_SOPC_clock_0_out_write_last_time;
  reg     [ 31: 0] DE0_Nano_SOPC_clock_0_out_writedata_last_time;
  reg              active_and_waiting_last_time;
  wire             r_0;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & ((~DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave | ~(DE0_Nano_SOPC_clock_0_out_read | DE0_Nano_SOPC_clock_0_out_write) | (1 & (DE0_Nano_SOPC_clock_0_out_read | DE0_Nano_SOPC_clock_0_out_write)))) & ((~DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave | ~(DE0_Nano_SOPC_clock_0_out_read | DE0_Nano_SOPC_clock_0_out_write) | (1 & (DE0_Nano_SOPC_clock_0_out_read | DE0_Nano_SOPC_clock_0_out_write))));

  //cascaded wait assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_out_run = r_0;

  //optimize select-logic by passing only those address bits which matter.
  assign DE0_Nano_SOPC_clock_0_out_address_to_slave = DE0_Nano_SOPC_clock_0_out_address;

  //DE0_Nano_SOPC_clock_0/out readdata mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_0_out_readdata = altpll_sys_pll_slave_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_out_waitrequest = ~DE0_Nano_SOPC_clock_0_out_run;

  //DE0_Nano_SOPC_clock_0_out_reset_n assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //DE0_Nano_SOPC_clock_0_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_out_address_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_0_out_address_last_time <= DE0_Nano_SOPC_clock_0_out_address;
    end


  //DE0_Nano_SOPC_clock_0/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= DE0_Nano_SOPC_clock_0_out_waitrequest & (DE0_Nano_SOPC_clock_0_out_read | DE0_Nano_SOPC_clock_0_out_write);
    end


  //DE0_Nano_SOPC_clock_0_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_0_out_address != DE0_Nano_SOPC_clock_0_out_address_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_0_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_0_out_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_out_byteenable_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_0_out_byteenable_last_time <= DE0_Nano_SOPC_clock_0_out_byteenable;
    end


  //DE0_Nano_SOPC_clock_0_out_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_0_out_byteenable != DE0_Nano_SOPC_clock_0_out_byteenable_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_0_out_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_0_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_out_read_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_0_out_read_last_time <= DE0_Nano_SOPC_clock_0_out_read;
    end


  //DE0_Nano_SOPC_clock_0_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_0_out_read != DE0_Nano_SOPC_clock_0_out_read_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_0_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_0_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_out_write_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_0_out_write_last_time <= DE0_Nano_SOPC_clock_0_out_write;
    end


  //DE0_Nano_SOPC_clock_0_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_0_out_write != DE0_Nano_SOPC_clock_0_out_write_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_0_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_0_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_0_out_writedata_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_0_out_writedata_last_time <= DE0_Nano_SOPC_clock_0_out_writedata;
    end


  //DE0_Nano_SOPC_clock_0_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_0_out_writedata != DE0_Nano_SOPC_clock_0_out_writedata_last_time) & DE0_Nano_SOPC_clock_0_out_write)
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_0_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_clock_1_in_arbitrator (
                                             // inputs:
                                              DE0_Nano_SOPC_clock_1_in_endofpacket,
                                              DE0_Nano_SOPC_clock_1_in_readdata,
                                              DE0_Nano_SOPC_clock_1_in_waitrequest,
                                              clk,
                                              cpu_data_master_address_to_slave,
                                              cpu_data_master_byteenable,
                                              cpu_data_master_latency_counter,
                                              cpu_data_master_read,
                                              cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                                              cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                                              cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                              cpu_data_master_write,
                                              cpu_data_master_writedata,
                                              reset_n,

                                             // outputs:
                                              DE0_Nano_SOPC_clock_1_in_address,
                                              DE0_Nano_SOPC_clock_1_in_byteenable,
                                              DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa,
                                              DE0_Nano_SOPC_clock_1_in_nativeaddress,
                                              DE0_Nano_SOPC_clock_1_in_read,
                                              DE0_Nano_SOPC_clock_1_in_readdata_from_sa,
                                              DE0_Nano_SOPC_clock_1_in_reset_n,
                                              DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa,
                                              DE0_Nano_SOPC_clock_1_in_write,
                                              DE0_Nano_SOPC_clock_1_in_writedata,
                                              cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in,
                                              cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in,
                                              cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in,
                                              cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in,
                                              d1_DE0_Nano_SOPC_clock_1_in_end_xfer
                                           )
;

  output           DE0_Nano_SOPC_clock_1_in_address;
  output  [  1: 0] DE0_Nano_SOPC_clock_1_in_byteenable;
  output           DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa;
  output           DE0_Nano_SOPC_clock_1_in_nativeaddress;
  output           DE0_Nano_SOPC_clock_1_in_read;
  output  [ 15: 0] DE0_Nano_SOPC_clock_1_in_readdata_from_sa;
  output           DE0_Nano_SOPC_clock_1_in_reset_n;
  output           DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa;
  output           DE0_Nano_SOPC_clock_1_in_write;
  output  [ 15: 0] DE0_Nano_SOPC_clock_1_in_writedata;
  output           cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in;
  output           cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in;
  output           cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in;
  output           cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in;
  output           d1_DE0_Nano_SOPC_clock_1_in_end_xfer;
  input            DE0_Nano_SOPC_clock_1_in_endofpacket;
  input   [ 15: 0] DE0_Nano_SOPC_clock_1_in_readdata;
  input            DE0_Nano_SOPC_clock_1_in_waitrequest;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             DE0_Nano_SOPC_clock_1_in_address;
  wire             DE0_Nano_SOPC_clock_1_in_allgrants;
  wire             DE0_Nano_SOPC_clock_1_in_allow_new_arb_cycle;
  wire             DE0_Nano_SOPC_clock_1_in_any_bursting_master_saved_grant;
  wire             DE0_Nano_SOPC_clock_1_in_any_continuerequest;
  wire             DE0_Nano_SOPC_clock_1_in_arb_counter_enable;
  reg     [  1: 0] DE0_Nano_SOPC_clock_1_in_arb_share_counter;
  wire    [  1: 0] DE0_Nano_SOPC_clock_1_in_arb_share_counter_next_value;
  wire    [  1: 0] DE0_Nano_SOPC_clock_1_in_arb_share_set_values;
  wire             DE0_Nano_SOPC_clock_1_in_beginbursttransfer_internal;
  wire             DE0_Nano_SOPC_clock_1_in_begins_xfer;
  wire    [  1: 0] DE0_Nano_SOPC_clock_1_in_byteenable;
  wire             DE0_Nano_SOPC_clock_1_in_end_xfer;
  wire             DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa;
  wire             DE0_Nano_SOPC_clock_1_in_firsttransfer;
  wire             DE0_Nano_SOPC_clock_1_in_grant_vector;
  wire             DE0_Nano_SOPC_clock_1_in_in_a_read_cycle;
  wire             DE0_Nano_SOPC_clock_1_in_in_a_write_cycle;
  wire             DE0_Nano_SOPC_clock_1_in_master_qreq_vector;
  wire             DE0_Nano_SOPC_clock_1_in_nativeaddress;
  wire             DE0_Nano_SOPC_clock_1_in_non_bursting_master_requests;
  wire             DE0_Nano_SOPC_clock_1_in_read;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_in_readdata_from_sa;
  reg              DE0_Nano_SOPC_clock_1_in_reg_firsttransfer;
  wire             DE0_Nano_SOPC_clock_1_in_reset_n;
  reg              DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable;
  wire             DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable2;
  wire             DE0_Nano_SOPC_clock_1_in_unreg_firsttransfer;
  wire             DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa;
  wire             DE0_Nano_SOPC_clock_1_in_waits_for_read;
  wire             DE0_Nano_SOPC_clock_1_in_waits_for_write;
  wire             DE0_Nano_SOPC_clock_1_in_write;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_in_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_saved_grant_DE0_Nano_SOPC_clock_1_in;
  reg              d1_DE0_Nano_SOPC_clock_1_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_1_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_DE0_Nano_SOPC_clock_1_in_from_cpu_data_master;
  wire             wait_for_DE0_Nano_SOPC_clock_1_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~DE0_Nano_SOPC_clock_1_in_end_xfer;
    end


  assign DE0_Nano_SOPC_clock_1_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in));
  //assign DE0_Nano_SOPC_clock_1_in_readdata_from_sa = DE0_Nano_SOPC_clock_1_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_readdata_from_sa = DE0_Nano_SOPC_clock_1_in_readdata;

  assign cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in = ({cpu_data_master_address_to_slave[26 : 2] , 2'b0} == 27'h6001018) & (cpu_data_master_read | cpu_data_master_write);
  //assign DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa = DE0_Nano_SOPC_clock_1_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa = DE0_Nano_SOPC_clock_1_in_waitrequest;

  //DE0_Nano_SOPC_clock_1_in_arb_share_counter set values, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_arb_share_set_values = 1;

  //DE0_Nano_SOPC_clock_1_in_non_bursting_master_requests mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_non_bursting_master_requests = cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in;

  //DE0_Nano_SOPC_clock_1_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_any_bursting_master_saved_grant = 0;

  //DE0_Nano_SOPC_clock_1_in_arb_share_counter_next_value assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_arb_share_counter_next_value = DE0_Nano_SOPC_clock_1_in_firsttransfer ? (DE0_Nano_SOPC_clock_1_in_arb_share_set_values - 1) : |DE0_Nano_SOPC_clock_1_in_arb_share_counter ? (DE0_Nano_SOPC_clock_1_in_arb_share_counter - 1) : 0;

  //DE0_Nano_SOPC_clock_1_in_allgrants all slave grants, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_allgrants = |DE0_Nano_SOPC_clock_1_in_grant_vector;

  //DE0_Nano_SOPC_clock_1_in_end_xfer assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_end_xfer = ~(DE0_Nano_SOPC_clock_1_in_waits_for_read | DE0_Nano_SOPC_clock_1_in_waits_for_write);

  //end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_1_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_1_in = DE0_Nano_SOPC_clock_1_in_end_xfer & (~DE0_Nano_SOPC_clock_1_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //DE0_Nano_SOPC_clock_1_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_arb_counter_enable = (end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_1_in & DE0_Nano_SOPC_clock_1_in_allgrants) | (end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_1_in & ~DE0_Nano_SOPC_clock_1_in_non_bursting_master_requests);

  //DE0_Nano_SOPC_clock_1_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_in_arb_share_counter <= 0;
      else if (DE0_Nano_SOPC_clock_1_in_arb_counter_enable)
          DE0_Nano_SOPC_clock_1_in_arb_share_counter <= DE0_Nano_SOPC_clock_1_in_arb_share_counter_next_value;
    end


  //DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable <= 0;
      else if ((|DE0_Nano_SOPC_clock_1_in_master_qreq_vector & end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_1_in) | (end_xfer_arb_share_counter_term_DE0_Nano_SOPC_clock_1_in & ~DE0_Nano_SOPC_clock_1_in_non_bursting_master_requests))
          DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable <= |DE0_Nano_SOPC_clock_1_in_arb_share_counter_next_value;
    end


  //cpu/data_master DE0_Nano_SOPC_clock_1/in arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable & cpu_data_master_continuerequest;

  //DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable2 = |DE0_Nano_SOPC_clock_1_in_arb_share_counter_next_value;

  //cpu/data_master DE0_Nano_SOPC_clock_1/in arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //DE0_Nano_SOPC_clock_1_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in = cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register) | (|cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in, which is an e_mux
  assign cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in = cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in & cpu_data_master_read & ~DE0_Nano_SOPC_clock_1_in_waits_for_read;

  //DE0_Nano_SOPC_clock_1_in_writedata mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_writedata = cpu_data_master_writedata;

  //assign DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa = DE0_Nano_SOPC_clock_1_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa = DE0_Nano_SOPC_clock_1_in_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in = cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in;

  //cpu/data_master saved-grant DE0_Nano_SOPC_clock_1/in, which is an e_assign
  assign cpu_data_master_saved_grant_DE0_Nano_SOPC_clock_1_in = cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in;

  //allow new arb cycle for DE0_Nano_SOPC_clock_1/in, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign DE0_Nano_SOPC_clock_1_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign DE0_Nano_SOPC_clock_1_in_master_qreq_vector = 1;

  //DE0_Nano_SOPC_clock_1_in_reset_n assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_reset_n = reset_n;

  //DE0_Nano_SOPC_clock_1_in_firsttransfer first transaction, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_firsttransfer = DE0_Nano_SOPC_clock_1_in_begins_xfer ? DE0_Nano_SOPC_clock_1_in_unreg_firsttransfer : DE0_Nano_SOPC_clock_1_in_reg_firsttransfer;

  //DE0_Nano_SOPC_clock_1_in_unreg_firsttransfer first transaction, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_unreg_firsttransfer = ~(DE0_Nano_SOPC_clock_1_in_slavearbiterlockenable & DE0_Nano_SOPC_clock_1_in_any_continuerequest);

  //DE0_Nano_SOPC_clock_1_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_in_reg_firsttransfer <= 1'b1;
      else if (DE0_Nano_SOPC_clock_1_in_begins_xfer)
          DE0_Nano_SOPC_clock_1_in_reg_firsttransfer <= DE0_Nano_SOPC_clock_1_in_unreg_firsttransfer;
    end


  //DE0_Nano_SOPC_clock_1_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_beginbursttransfer_internal = DE0_Nano_SOPC_clock_1_in_begins_xfer;

  //DE0_Nano_SOPC_clock_1_in_read assignment, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_read = cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in & cpu_data_master_read;

  //DE0_Nano_SOPC_clock_1_in_write assignment, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_write = cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in & cpu_data_master_write;

  assign shifted_address_to_DE0_Nano_SOPC_clock_1_in_from_cpu_data_master = cpu_data_master_address_to_slave;
  //DE0_Nano_SOPC_clock_1_in_address mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_address = shifted_address_to_DE0_Nano_SOPC_clock_1_in_from_cpu_data_master >> 2;

  //slaveid DE0_Nano_SOPC_clock_1_in_nativeaddress nativeaddress mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_nativeaddress = cpu_data_master_address_to_slave >> 2;

  //d1_DE0_Nano_SOPC_clock_1_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_DE0_Nano_SOPC_clock_1_in_end_xfer <= 1;
      else 
        d1_DE0_Nano_SOPC_clock_1_in_end_xfer <= DE0_Nano_SOPC_clock_1_in_end_xfer;
    end


  //DE0_Nano_SOPC_clock_1_in_waits_for_read in a cycle, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_waits_for_read = DE0_Nano_SOPC_clock_1_in_in_a_read_cycle & DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa;

  //DE0_Nano_SOPC_clock_1_in_in_a_read_cycle assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_in_a_read_cycle = cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = DE0_Nano_SOPC_clock_1_in_in_a_read_cycle;

  //DE0_Nano_SOPC_clock_1_in_waits_for_write in a cycle, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_waits_for_write = DE0_Nano_SOPC_clock_1_in_in_a_write_cycle & DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa;

  //DE0_Nano_SOPC_clock_1_in_in_a_write_cycle assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_in_in_a_write_cycle = cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = DE0_Nano_SOPC_clock_1_in_in_a_write_cycle;

  assign wait_for_DE0_Nano_SOPC_clock_1_in_counter = 0;
  //DE0_Nano_SOPC_clock_1_in_byteenable byte enable port mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_in_byteenable = (cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //DE0_Nano_SOPC_clock_1/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_clock_1_out_arbitrator (
                                              // inputs:
                                               DE0_Nano_SOPC_clock_1_out_address,
                                               DE0_Nano_SOPC_clock_1_out_byteenable,
                                               DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave,
                                               DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave,
                                               DE0_Nano_SOPC_clock_1_out_read,
                                               DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave,
                                               DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave,
                                               DE0_Nano_SOPC_clock_1_out_write,
                                               DE0_Nano_SOPC_clock_1_out_writedata,
                                               adc_spi_read_slave_readdata_from_sa,
                                               clk,
                                               d1_adc_spi_read_slave_end_xfer,
                                               reset_n,

                                              // outputs:
                                               DE0_Nano_SOPC_clock_1_out_address_to_slave,
                                               DE0_Nano_SOPC_clock_1_out_readdata,
                                               DE0_Nano_SOPC_clock_1_out_reset_n,
                                               DE0_Nano_SOPC_clock_1_out_waitrequest
                                            )
;

  output           DE0_Nano_SOPC_clock_1_out_address_to_slave;
  output  [ 15: 0] DE0_Nano_SOPC_clock_1_out_readdata;
  output           DE0_Nano_SOPC_clock_1_out_reset_n;
  output           DE0_Nano_SOPC_clock_1_out_waitrequest;
  input            DE0_Nano_SOPC_clock_1_out_address;
  input   [  1: 0] DE0_Nano_SOPC_clock_1_out_byteenable;
  input            DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave;
  input            DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave;
  input            DE0_Nano_SOPC_clock_1_out_read;
  input            DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave;
  input            DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave;
  input            DE0_Nano_SOPC_clock_1_out_write;
  input   [ 15: 0] DE0_Nano_SOPC_clock_1_out_writedata;
  input   [ 15: 0] adc_spi_read_slave_readdata_from_sa;
  input            clk;
  input            d1_adc_spi_read_slave_end_xfer;
  input            reset_n;

  reg              DE0_Nano_SOPC_clock_1_out_address_last_time;
  wire             DE0_Nano_SOPC_clock_1_out_address_to_slave;
  reg     [  1: 0] DE0_Nano_SOPC_clock_1_out_byteenable_last_time;
  reg              DE0_Nano_SOPC_clock_1_out_read_last_time;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_out_readdata;
  wire             DE0_Nano_SOPC_clock_1_out_reset_n;
  wire             DE0_Nano_SOPC_clock_1_out_run;
  wire             DE0_Nano_SOPC_clock_1_out_waitrequest;
  reg              DE0_Nano_SOPC_clock_1_out_write_last_time;
  reg     [ 15: 0] DE0_Nano_SOPC_clock_1_out_writedata_last_time;
  reg              active_and_waiting_last_time;
  wire             r_0;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & ((~DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave | ~DE0_Nano_SOPC_clock_1_out_read | (1 & ~d1_adc_spi_read_slave_end_xfer & DE0_Nano_SOPC_clock_1_out_read))) & ((~DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave | ~DE0_Nano_SOPC_clock_1_out_write | (1 & DE0_Nano_SOPC_clock_1_out_write)));

  //cascaded wait assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_out_run = r_0;

  //optimize select-logic by passing only those address bits which matter.
  assign DE0_Nano_SOPC_clock_1_out_address_to_slave = DE0_Nano_SOPC_clock_1_out_address;

  //DE0_Nano_SOPC_clock_1/out readdata mux, which is an e_mux
  assign DE0_Nano_SOPC_clock_1_out_readdata = adc_spi_read_slave_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_out_waitrequest = ~DE0_Nano_SOPC_clock_1_out_run;

  //DE0_Nano_SOPC_clock_1_out_reset_n assignment, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //DE0_Nano_SOPC_clock_1_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_out_address_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_1_out_address_last_time <= DE0_Nano_SOPC_clock_1_out_address;
    end


  //DE0_Nano_SOPC_clock_1/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= DE0_Nano_SOPC_clock_1_out_waitrequest & (DE0_Nano_SOPC_clock_1_out_read | DE0_Nano_SOPC_clock_1_out_write);
    end


  //DE0_Nano_SOPC_clock_1_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_1_out_address != DE0_Nano_SOPC_clock_1_out_address_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_1_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_1_out_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_out_byteenable_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_1_out_byteenable_last_time <= DE0_Nano_SOPC_clock_1_out_byteenable;
    end


  //DE0_Nano_SOPC_clock_1_out_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_1_out_byteenable != DE0_Nano_SOPC_clock_1_out_byteenable_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_1_out_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_1_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_out_read_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_1_out_read_last_time <= DE0_Nano_SOPC_clock_1_out_read;
    end


  //DE0_Nano_SOPC_clock_1_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_1_out_read != DE0_Nano_SOPC_clock_1_out_read_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_1_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_1_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_out_write_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_1_out_write_last_time <= DE0_Nano_SOPC_clock_1_out_write;
    end


  //DE0_Nano_SOPC_clock_1_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_1_out_write != DE0_Nano_SOPC_clock_1_out_write_last_time))
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_1_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //DE0_Nano_SOPC_clock_1_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DE0_Nano_SOPC_clock_1_out_writedata_last_time <= 0;
      else 
        DE0_Nano_SOPC_clock_1_out_writedata_last_time <= DE0_Nano_SOPC_clock_1_out_writedata;
    end


  //DE0_Nano_SOPC_clock_1_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (DE0_Nano_SOPC_clock_1_out_writedata != DE0_Nano_SOPC_clock_1_out_writedata_last_time) & DE0_Nano_SOPC_clock_1_out_write)
        begin
          $write("%0d ns: DE0_Nano_SOPC_clock_1_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module adc_spi_read_slave_arbitrator (
                                       // inputs:
                                        DE0_Nano_SOPC_clock_1_out_address_to_slave,
                                        DE0_Nano_SOPC_clock_1_out_read,
                                        DE0_Nano_SOPC_clock_1_out_write,
                                        DE0_Nano_SOPC_clock_1_out_writedata,
                                        adc_spi_read_slave_readdata,
                                        clk,
                                        reset_n,

                                       // outputs:
                                        DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave,
                                        DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave,
                                        DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave,
                                        DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave,
                                        adc_spi_read_slave_chipselect,
                                        adc_spi_read_slave_read,
                                        adc_spi_read_slave_readdata_from_sa,
                                        adc_spi_read_slave_reset_n,
                                        adc_spi_read_slave_write,
                                        adc_spi_read_slave_writedata,
                                        d1_adc_spi_read_slave_end_xfer
                                     )
;

  output           DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave;
  output           DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave;
  output           DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave;
  output           DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave;
  output           adc_spi_read_slave_chipselect;
  output           adc_spi_read_slave_read;
  output  [ 15: 0] adc_spi_read_slave_readdata_from_sa;
  output           adc_spi_read_slave_reset_n;
  output           adc_spi_read_slave_write;
  output  [ 15: 0] adc_spi_read_slave_writedata;
  output           d1_adc_spi_read_slave_end_xfer;
  input            DE0_Nano_SOPC_clock_1_out_address_to_slave;
  input            DE0_Nano_SOPC_clock_1_out_read;
  input            DE0_Nano_SOPC_clock_1_out_write;
  input   [ 15: 0] DE0_Nano_SOPC_clock_1_out_writedata;
  input   [ 15: 0] adc_spi_read_slave_readdata;
  input            clk;
  input            reset_n;

  wire             DE0_Nano_SOPC_clock_1_out_arbiterlock;
  wire             DE0_Nano_SOPC_clock_1_out_arbiterlock2;
  wire             DE0_Nano_SOPC_clock_1_out_continuerequest;
  wire             DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave;
  wire             DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave;
  wire             DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave;
  wire             DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave;
  wire             DE0_Nano_SOPC_clock_1_out_saved_grant_adc_spi_read_slave;
  wire             adc_spi_read_slave_allgrants;
  wire             adc_spi_read_slave_allow_new_arb_cycle;
  wire             adc_spi_read_slave_any_bursting_master_saved_grant;
  wire             adc_spi_read_slave_any_continuerequest;
  wire             adc_spi_read_slave_arb_counter_enable;
  reg              adc_spi_read_slave_arb_share_counter;
  wire             adc_spi_read_slave_arb_share_counter_next_value;
  wire             adc_spi_read_slave_arb_share_set_values;
  wire             adc_spi_read_slave_beginbursttransfer_internal;
  wire             adc_spi_read_slave_begins_xfer;
  wire             adc_spi_read_slave_chipselect;
  wire             adc_spi_read_slave_end_xfer;
  wire             adc_spi_read_slave_firsttransfer;
  wire             adc_spi_read_slave_grant_vector;
  wire             adc_spi_read_slave_in_a_read_cycle;
  wire             adc_spi_read_slave_in_a_write_cycle;
  wire             adc_spi_read_slave_master_qreq_vector;
  wire             adc_spi_read_slave_non_bursting_master_requests;
  wire             adc_spi_read_slave_read;
  wire    [ 15: 0] adc_spi_read_slave_readdata_from_sa;
  reg              adc_spi_read_slave_reg_firsttransfer;
  wire             adc_spi_read_slave_reset_n;
  reg              adc_spi_read_slave_slavearbiterlockenable;
  wire             adc_spi_read_slave_slavearbiterlockenable2;
  wire             adc_spi_read_slave_unreg_firsttransfer;
  wire             adc_spi_read_slave_waits_for_read;
  wire             adc_spi_read_slave_waits_for_write;
  wire             adc_spi_read_slave_write;
  wire    [ 15: 0] adc_spi_read_slave_writedata;
  reg              d1_adc_spi_read_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_adc_spi_read_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             wait_for_adc_spi_read_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~adc_spi_read_slave_end_xfer;
    end


  assign adc_spi_read_slave_begins_xfer = ~d1_reasons_to_wait & ((DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave));
  //assign adc_spi_read_slave_readdata_from_sa = adc_spi_read_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign adc_spi_read_slave_readdata_from_sa = adc_spi_read_slave_readdata;

  assign DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave = (1) & (DE0_Nano_SOPC_clock_1_out_read | DE0_Nano_SOPC_clock_1_out_write);
  //adc_spi_read_slave_arb_share_counter set values, which is an e_mux
  assign adc_spi_read_slave_arb_share_set_values = 1;

  //adc_spi_read_slave_non_bursting_master_requests mux, which is an e_mux
  assign adc_spi_read_slave_non_bursting_master_requests = DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave;

  //adc_spi_read_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign adc_spi_read_slave_any_bursting_master_saved_grant = 0;

  //adc_spi_read_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign adc_spi_read_slave_arb_share_counter_next_value = adc_spi_read_slave_firsttransfer ? (adc_spi_read_slave_arb_share_set_values - 1) : |adc_spi_read_slave_arb_share_counter ? (adc_spi_read_slave_arb_share_counter - 1) : 0;

  //adc_spi_read_slave_allgrants all slave grants, which is an e_mux
  assign adc_spi_read_slave_allgrants = |adc_spi_read_slave_grant_vector;

  //adc_spi_read_slave_end_xfer assignment, which is an e_assign
  assign adc_spi_read_slave_end_xfer = ~(adc_spi_read_slave_waits_for_read | adc_spi_read_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_adc_spi_read_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_adc_spi_read_slave = adc_spi_read_slave_end_xfer & (~adc_spi_read_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //adc_spi_read_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign adc_spi_read_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_adc_spi_read_slave & adc_spi_read_slave_allgrants) | (end_xfer_arb_share_counter_term_adc_spi_read_slave & ~adc_spi_read_slave_non_bursting_master_requests);

  //adc_spi_read_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          adc_spi_read_slave_arb_share_counter <= 0;
      else if (adc_spi_read_slave_arb_counter_enable)
          adc_spi_read_slave_arb_share_counter <= adc_spi_read_slave_arb_share_counter_next_value;
    end


  //adc_spi_read_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          adc_spi_read_slave_slavearbiterlockenable <= 0;
      else if ((|adc_spi_read_slave_master_qreq_vector & end_xfer_arb_share_counter_term_adc_spi_read_slave) | (end_xfer_arb_share_counter_term_adc_spi_read_slave & ~adc_spi_read_slave_non_bursting_master_requests))
          adc_spi_read_slave_slavearbiterlockenable <= |adc_spi_read_slave_arb_share_counter_next_value;
    end


  //DE0_Nano_SOPC_clock_1/out adc_spi_read/slave arbiterlock, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_out_arbiterlock = adc_spi_read_slave_slavearbiterlockenable & DE0_Nano_SOPC_clock_1_out_continuerequest;

  //adc_spi_read_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign adc_spi_read_slave_slavearbiterlockenable2 = |adc_spi_read_slave_arb_share_counter_next_value;

  //DE0_Nano_SOPC_clock_1/out adc_spi_read/slave arbiterlock2, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_out_arbiterlock2 = adc_spi_read_slave_slavearbiterlockenable2 & DE0_Nano_SOPC_clock_1_out_continuerequest;

  //adc_spi_read_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign adc_spi_read_slave_any_continuerequest = 1;

  //DE0_Nano_SOPC_clock_1_out_continuerequest continued request, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_out_continuerequest = 1;

  assign DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave = DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave;
  //adc_spi_read_slave_writedata mux, which is an e_mux
  assign adc_spi_read_slave_writedata = DE0_Nano_SOPC_clock_1_out_writedata;

  //master is always granted when requested
  assign DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave = DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave;

  //DE0_Nano_SOPC_clock_1/out saved-grant adc_spi_read/slave, which is an e_assign
  assign DE0_Nano_SOPC_clock_1_out_saved_grant_adc_spi_read_slave = DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave;

  //allow new arb cycle for adc_spi_read/slave, which is an e_assign
  assign adc_spi_read_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign adc_spi_read_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign adc_spi_read_slave_master_qreq_vector = 1;

  //adc_spi_read_slave_reset_n assignment, which is an e_assign
  assign adc_spi_read_slave_reset_n = reset_n;

  assign adc_spi_read_slave_chipselect = DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave;
  //adc_spi_read_slave_firsttransfer first transaction, which is an e_assign
  assign adc_spi_read_slave_firsttransfer = adc_spi_read_slave_begins_xfer ? adc_spi_read_slave_unreg_firsttransfer : adc_spi_read_slave_reg_firsttransfer;

  //adc_spi_read_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign adc_spi_read_slave_unreg_firsttransfer = ~(adc_spi_read_slave_slavearbiterlockenable & adc_spi_read_slave_any_continuerequest);

  //adc_spi_read_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          adc_spi_read_slave_reg_firsttransfer <= 1'b1;
      else if (adc_spi_read_slave_begins_xfer)
          adc_spi_read_slave_reg_firsttransfer <= adc_spi_read_slave_unreg_firsttransfer;
    end


  //adc_spi_read_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign adc_spi_read_slave_beginbursttransfer_internal = adc_spi_read_slave_begins_xfer;

  //adc_spi_read_slave_read assignment, which is an e_mux
  assign adc_spi_read_slave_read = DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave & DE0_Nano_SOPC_clock_1_out_read;

  //adc_spi_read_slave_write assignment, which is an e_mux
  assign adc_spi_read_slave_write = DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave & DE0_Nano_SOPC_clock_1_out_write;

  //d1_adc_spi_read_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_adc_spi_read_slave_end_xfer <= 1;
      else 
        d1_adc_spi_read_slave_end_xfer <= adc_spi_read_slave_end_xfer;
    end


  //adc_spi_read_slave_waits_for_read in a cycle, which is an e_mux
  assign adc_spi_read_slave_waits_for_read = adc_spi_read_slave_in_a_read_cycle & adc_spi_read_slave_begins_xfer;

  //adc_spi_read_slave_in_a_read_cycle assignment, which is an e_assign
  assign adc_spi_read_slave_in_a_read_cycle = DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave & DE0_Nano_SOPC_clock_1_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = adc_spi_read_slave_in_a_read_cycle;

  //adc_spi_read_slave_waits_for_write in a cycle, which is an e_mux
  assign adc_spi_read_slave_waits_for_write = adc_spi_read_slave_in_a_write_cycle & 0;

  //adc_spi_read_slave_in_a_write_cycle assignment, which is an e_assign
  assign adc_spi_read_slave_in_a_write_cycle = DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave & DE0_Nano_SOPC_clock_1_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = adc_spi_read_slave_in_a_write_cycle;

  assign wait_for_adc_spi_read_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //adc_spi_read/slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module altpll_sys_pll_slave_arbitrator (
                                         // inputs:
                                          DE0_Nano_SOPC_clock_0_out_address_to_slave,
                                          DE0_Nano_SOPC_clock_0_out_read,
                                          DE0_Nano_SOPC_clock_0_out_write,
                                          DE0_Nano_SOPC_clock_0_out_writedata,
                                          altpll_sys_pll_slave_readdata,
                                          clk,
                                          reset_n,

                                         // outputs:
                                          DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave,
                                          DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave,
                                          DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave,
                                          DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave,
                                          altpll_sys_pll_slave_address,
                                          altpll_sys_pll_slave_read,
                                          altpll_sys_pll_slave_readdata_from_sa,
                                          altpll_sys_pll_slave_reset,
                                          altpll_sys_pll_slave_write,
                                          altpll_sys_pll_slave_writedata,
                                          d1_altpll_sys_pll_slave_end_xfer
                                       )
;

  output           DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave;
  output           DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave;
  output           DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave;
  output           DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave;
  output  [  1: 0] altpll_sys_pll_slave_address;
  output           altpll_sys_pll_slave_read;
  output  [ 31: 0] altpll_sys_pll_slave_readdata_from_sa;
  output           altpll_sys_pll_slave_reset;
  output           altpll_sys_pll_slave_write;
  output  [ 31: 0] altpll_sys_pll_slave_writedata;
  output           d1_altpll_sys_pll_slave_end_xfer;
  input   [  3: 0] DE0_Nano_SOPC_clock_0_out_address_to_slave;
  input            DE0_Nano_SOPC_clock_0_out_read;
  input            DE0_Nano_SOPC_clock_0_out_write;
  input   [ 31: 0] DE0_Nano_SOPC_clock_0_out_writedata;
  input   [ 31: 0] altpll_sys_pll_slave_readdata;
  input            clk;
  input            reset_n;

  wire             DE0_Nano_SOPC_clock_0_out_arbiterlock;
  wire             DE0_Nano_SOPC_clock_0_out_arbiterlock2;
  wire             DE0_Nano_SOPC_clock_0_out_continuerequest;
  wire             DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave;
  wire             DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave;
  wire             DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave;
  wire             DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave;
  wire             DE0_Nano_SOPC_clock_0_out_saved_grant_altpll_sys_pll_slave;
  wire    [  1: 0] altpll_sys_pll_slave_address;
  wire             altpll_sys_pll_slave_allgrants;
  wire             altpll_sys_pll_slave_allow_new_arb_cycle;
  wire             altpll_sys_pll_slave_any_bursting_master_saved_grant;
  wire             altpll_sys_pll_slave_any_continuerequest;
  wire             altpll_sys_pll_slave_arb_counter_enable;
  reg              altpll_sys_pll_slave_arb_share_counter;
  wire             altpll_sys_pll_slave_arb_share_counter_next_value;
  wire             altpll_sys_pll_slave_arb_share_set_values;
  wire             altpll_sys_pll_slave_beginbursttransfer_internal;
  wire             altpll_sys_pll_slave_begins_xfer;
  wire             altpll_sys_pll_slave_end_xfer;
  wire             altpll_sys_pll_slave_firsttransfer;
  wire             altpll_sys_pll_slave_grant_vector;
  wire             altpll_sys_pll_slave_in_a_read_cycle;
  wire             altpll_sys_pll_slave_in_a_write_cycle;
  wire             altpll_sys_pll_slave_master_qreq_vector;
  wire             altpll_sys_pll_slave_non_bursting_master_requests;
  wire             altpll_sys_pll_slave_read;
  wire    [ 31: 0] altpll_sys_pll_slave_readdata_from_sa;
  reg              altpll_sys_pll_slave_reg_firsttransfer;
  wire             altpll_sys_pll_slave_reset;
  reg              altpll_sys_pll_slave_slavearbiterlockenable;
  wire             altpll_sys_pll_slave_slavearbiterlockenable2;
  wire             altpll_sys_pll_slave_unreg_firsttransfer;
  wire             altpll_sys_pll_slave_waits_for_read;
  wire             altpll_sys_pll_slave_waits_for_write;
  wire             altpll_sys_pll_slave_write;
  wire    [ 31: 0] altpll_sys_pll_slave_writedata;
  reg              d1_altpll_sys_pll_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_altpll_sys_pll_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  3: 0] shifted_address_to_altpll_sys_pll_slave_from_DE0_Nano_SOPC_clock_0_out;
  wire             wait_for_altpll_sys_pll_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~altpll_sys_pll_slave_end_xfer;
    end


  assign altpll_sys_pll_slave_begins_xfer = ~d1_reasons_to_wait & ((DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave));
  //assign altpll_sys_pll_slave_readdata_from_sa = altpll_sys_pll_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign altpll_sys_pll_slave_readdata_from_sa = altpll_sys_pll_slave_readdata;

  assign DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave = (1) & (DE0_Nano_SOPC_clock_0_out_read | DE0_Nano_SOPC_clock_0_out_write);
  //altpll_sys_pll_slave_arb_share_counter set values, which is an e_mux
  assign altpll_sys_pll_slave_arb_share_set_values = 1;

  //altpll_sys_pll_slave_non_bursting_master_requests mux, which is an e_mux
  assign altpll_sys_pll_slave_non_bursting_master_requests = DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave;

  //altpll_sys_pll_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign altpll_sys_pll_slave_any_bursting_master_saved_grant = 0;

  //altpll_sys_pll_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign altpll_sys_pll_slave_arb_share_counter_next_value = altpll_sys_pll_slave_firsttransfer ? (altpll_sys_pll_slave_arb_share_set_values - 1) : |altpll_sys_pll_slave_arb_share_counter ? (altpll_sys_pll_slave_arb_share_counter - 1) : 0;

  //altpll_sys_pll_slave_allgrants all slave grants, which is an e_mux
  assign altpll_sys_pll_slave_allgrants = |altpll_sys_pll_slave_grant_vector;

  //altpll_sys_pll_slave_end_xfer assignment, which is an e_assign
  assign altpll_sys_pll_slave_end_xfer = ~(altpll_sys_pll_slave_waits_for_read | altpll_sys_pll_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_altpll_sys_pll_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_altpll_sys_pll_slave = altpll_sys_pll_slave_end_xfer & (~altpll_sys_pll_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //altpll_sys_pll_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign altpll_sys_pll_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_altpll_sys_pll_slave & altpll_sys_pll_slave_allgrants) | (end_xfer_arb_share_counter_term_altpll_sys_pll_slave & ~altpll_sys_pll_slave_non_bursting_master_requests);

  //altpll_sys_pll_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          altpll_sys_pll_slave_arb_share_counter <= 0;
      else if (altpll_sys_pll_slave_arb_counter_enable)
          altpll_sys_pll_slave_arb_share_counter <= altpll_sys_pll_slave_arb_share_counter_next_value;
    end


  //altpll_sys_pll_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          altpll_sys_pll_slave_slavearbiterlockenable <= 0;
      else if ((|altpll_sys_pll_slave_master_qreq_vector & end_xfer_arb_share_counter_term_altpll_sys_pll_slave) | (end_xfer_arb_share_counter_term_altpll_sys_pll_slave & ~altpll_sys_pll_slave_non_bursting_master_requests))
          altpll_sys_pll_slave_slavearbiterlockenable <= |altpll_sys_pll_slave_arb_share_counter_next_value;
    end


  //DE0_Nano_SOPC_clock_0/out altpll_sys/pll_slave arbiterlock, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_out_arbiterlock = altpll_sys_pll_slave_slavearbiterlockenable & DE0_Nano_SOPC_clock_0_out_continuerequest;

  //altpll_sys_pll_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign altpll_sys_pll_slave_slavearbiterlockenable2 = |altpll_sys_pll_slave_arb_share_counter_next_value;

  //DE0_Nano_SOPC_clock_0/out altpll_sys/pll_slave arbiterlock2, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_out_arbiterlock2 = altpll_sys_pll_slave_slavearbiterlockenable2 & DE0_Nano_SOPC_clock_0_out_continuerequest;

  //altpll_sys_pll_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign altpll_sys_pll_slave_any_continuerequest = 1;

  //DE0_Nano_SOPC_clock_0_out_continuerequest continued request, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_out_continuerequest = 1;

  assign DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave = DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave;
  //altpll_sys_pll_slave_writedata mux, which is an e_mux
  assign altpll_sys_pll_slave_writedata = DE0_Nano_SOPC_clock_0_out_writedata;

  //master is always granted when requested
  assign DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave = DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave;

  //DE0_Nano_SOPC_clock_0/out saved-grant altpll_sys/pll_slave, which is an e_assign
  assign DE0_Nano_SOPC_clock_0_out_saved_grant_altpll_sys_pll_slave = DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave;

  //allow new arb cycle for altpll_sys/pll_slave, which is an e_assign
  assign altpll_sys_pll_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign altpll_sys_pll_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign altpll_sys_pll_slave_master_qreq_vector = 1;

  //~altpll_sys_pll_slave_reset assignment, which is an e_assign
  assign altpll_sys_pll_slave_reset = ~reset_n;

  //altpll_sys_pll_slave_firsttransfer first transaction, which is an e_assign
  assign altpll_sys_pll_slave_firsttransfer = altpll_sys_pll_slave_begins_xfer ? altpll_sys_pll_slave_unreg_firsttransfer : altpll_sys_pll_slave_reg_firsttransfer;

  //altpll_sys_pll_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign altpll_sys_pll_slave_unreg_firsttransfer = ~(altpll_sys_pll_slave_slavearbiterlockenable & altpll_sys_pll_slave_any_continuerequest);

  //altpll_sys_pll_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          altpll_sys_pll_slave_reg_firsttransfer <= 1'b1;
      else if (altpll_sys_pll_slave_begins_xfer)
          altpll_sys_pll_slave_reg_firsttransfer <= altpll_sys_pll_slave_unreg_firsttransfer;
    end


  //altpll_sys_pll_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign altpll_sys_pll_slave_beginbursttransfer_internal = altpll_sys_pll_slave_begins_xfer;

  //altpll_sys_pll_slave_read assignment, which is an e_mux
  assign altpll_sys_pll_slave_read = DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave & DE0_Nano_SOPC_clock_0_out_read;

  //altpll_sys_pll_slave_write assignment, which is an e_mux
  assign altpll_sys_pll_slave_write = DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave & DE0_Nano_SOPC_clock_0_out_write;

  assign shifted_address_to_altpll_sys_pll_slave_from_DE0_Nano_SOPC_clock_0_out = DE0_Nano_SOPC_clock_0_out_address_to_slave;
  //altpll_sys_pll_slave_address mux, which is an e_mux
  assign altpll_sys_pll_slave_address = shifted_address_to_altpll_sys_pll_slave_from_DE0_Nano_SOPC_clock_0_out >> 2;

  //d1_altpll_sys_pll_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_altpll_sys_pll_slave_end_xfer <= 1;
      else 
        d1_altpll_sys_pll_slave_end_xfer <= altpll_sys_pll_slave_end_xfer;
    end


  //altpll_sys_pll_slave_waits_for_read in a cycle, which is an e_mux
  assign altpll_sys_pll_slave_waits_for_read = altpll_sys_pll_slave_in_a_read_cycle & 0;

  //altpll_sys_pll_slave_in_a_read_cycle assignment, which is an e_assign
  assign altpll_sys_pll_slave_in_a_read_cycle = DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave & DE0_Nano_SOPC_clock_0_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = altpll_sys_pll_slave_in_a_read_cycle;

  //altpll_sys_pll_slave_waits_for_write in a cycle, which is an e_mux
  assign altpll_sys_pll_slave_waits_for_write = altpll_sys_pll_slave_in_a_write_cycle & 0;

  //altpll_sys_pll_slave_in_a_write_cycle assignment, which is an e_assign
  assign altpll_sys_pll_slave_in_a_write_cycle = DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave & DE0_Nano_SOPC_clock_0_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = altpll_sys_pll_slave_in_a_write_cycle;

  assign wait_for_altpll_sys_pll_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //altpll_sys/pll_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_clock_crossing_io_s1_module (
                                                                     // inputs:
                                                                      clear_fifo,
                                                                      clk,
                                                                      data_in,
                                                                      read,
                                                                      reset_n,
                                                                      sync_reset,
                                                                      write,

                                                                     // outputs:
                                                                      data_out,
                                                                      empty,
                                                                      fifo_contains_ones_n,
                                                                      full
                                                                   )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_10;
  reg              full_11;
  reg              full_12;
  reg              full_13;
  reg              full_14;
  reg              full_15;
  reg              full_16;
  reg              full_17;
  reg              full_18;
  reg              full_19;
  reg              full_2;
  reg              full_20;
  reg              full_21;
  reg              full_22;
  reg              full_23;
  reg              full_24;
  reg              full_25;
  reg              full_26;
  reg              full_27;
  reg              full_28;
  reg              full_29;
  reg              full_3;
  reg              full_30;
  reg              full_31;
  wire             full_32;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  reg              full_7;
  reg              full_8;
  reg              full_9;
  reg     [  6: 0] how_many_ones;
  wire    [  6: 0] one_count_minus_one;
  wire    [  6: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p10_full_10;
  wire             p10_stage_10;
  wire             p11_full_11;
  wire             p11_stage_11;
  wire             p12_full_12;
  wire             p12_stage_12;
  wire             p13_full_13;
  wire             p13_stage_13;
  wire             p14_full_14;
  wire             p14_stage_14;
  wire             p15_full_15;
  wire             p15_stage_15;
  wire             p16_full_16;
  wire             p16_stage_16;
  wire             p17_full_17;
  wire             p17_stage_17;
  wire             p18_full_18;
  wire             p18_stage_18;
  wire             p19_full_19;
  wire             p19_stage_19;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p20_full_20;
  wire             p20_stage_20;
  wire             p21_full_21;
  wire             p21_stage_21;
  wire             p22_full_22;
  wire             p22_stage_22;
  wire             p23_full_23;
  wire             p23_stage_23;
  wire             p24_full_24;
  wire             p24_stage_24;
  wire             p25_full_25;
  wire             p25_stage_25;
  wire             p26_full_26;
  wire             p26_stage_26;
  wire             p27_full_27;
  wire             p27_stage_27;
  wire             p28_full_28;
  wire             p28_stage_28;
  wire             p29_full_29;
  wire             p29_stage_29;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p30_full_30;
  wire             p30_stage_30;
  wire             p31_full_31;
  wire             p31_stage_31;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  wire             p7_full_7;
  wire             p7_stage_7;
  wire             p8_full_8;
  wire             p8_stage_8;
  wire             p9_full_9;
  wire             p9_stage_9;
  reg              stage_0;
  reg              stage_1;
  reg              stage_10;
  reg              stage_11;
  reg              stage_12;
  reg              stage_13;
  reg              stage_14;
  reg              stage_15;
  reg              stage_16;
  reg              stage_17;
  reg              stage_18;
  reg              stage_19;
  reg              stage_2;
  reg              stage_20;
  reg              stage_21;
  reg              stage_22;
  reg              stage_23;
  reg              stage_24;
  reg              stage_25;
  reg              stage_26;
  reg              stage_27;
  reg              stage_28;
  reg              stage_29;
  reg              stage_3;
  reg              stage_30;
  reg              stage_31;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  reg              stage_7;
  reg              stage_8;
  reg              stage_9;
  wire    [  6: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_31;
  assign empty = !full_0;
  assign full_32 = 0;
  //data_31, which is an e_mux
  assign p31_stage_31 = ((full_32 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_31, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_31 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_31))
          if (sync_reset & full_31 & !((full_32 == 0) & read & write))
              stage_31 <= 0;
          else 
            stage_31 <= p31_stage_31;
    end


  //control_31, which is an e_mux
  assign p31_full_31 = ((read & !write) == 0)? full_30 :
    0;

  //control_reg_31, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_31 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_31 <= 0;
          else 
            full_31 <= p31_full_31;
    end


  //data_30, which is an e_mux
  assign p30_stage_30 = ((full_31 & ~clear_fifo) == 0)? data_in :
    stage_31;

  //data_reg_30, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_30 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_30))
          if (sync_reset & full_30 & !((full_31 == 0) & read & write))
              stage_30 <= 0;
          else 
            stage_30 <= p30_stage_30;
    end


  //control_30, which is an e_mux
  assign p30_full_30 = ((read & !write) == 0)? full_29 :
    full_31;

  //control_reg_30, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_30 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_30 <= 0;
          else 
            full_30 <= p30_full_30;
    end


  //data_29, which is an e_mux
  assign p29_stage_29 = ((full_30 & ~clear_fifo) == 0)? data_in :
    stage_30;

  //data_reg_29, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_29 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_29))
          if (sync_reset & full_29 & !((full_30 == 0) & read & write))
              stage_29 <= 0;
          else 
            stage_29 <= p29_stage_29;
    end


  //control_29, which is an e_mux
  assign p29_full_29 = ((read & !write) == 0)? full_28 :
    full_30;

  //control_reg_29, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_29 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_29 <= 0;
          else 
            full_29 <= p29_full_29;
    end


  //data_28, which is an e_mux
  assign p28_stage_28 = ((full_29 & ~clear_fifo) == 0)? data_in :
    stage_29;

  //data_reg_28, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_28 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_28))
          if (sync_reset & full_28 & !((full_29 == 0) & read & write))
              stage_28 <= 0;
          else 
            stage_28 <= p28_stage_28;
    end


  //control_28, which is an e_mux
  assign p28_full_28 = ((read & !write) == 0)? full_27 :
    full_29;

  //control_reg_28, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_28 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_28 <= 0;
          else 
            full_28 <= p28_full_28;
    end


  //data_27, which is an e_mux
  assign p27_stage_27 = ((full_28 & ~clear_fifo) == 0)? data_in :
    stage_28;

  //data_reg_27, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_27 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_27))
          if (sync_reset & full_27 & !((full_28 == 0) & read & write))
              stage_27 <= 0;
          else 
            stage_27 <= p27_stage_27;
    end


  //control_27, which is an e_mux
  assign p27_full_27 = ((read & !write) == 0)? full_26 :
    full_28;

  //control_reg_27, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_27 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_27 <= 0;
          else 
            full_27 <= p27_full_27;
    end


  //data_26, which is an e_mux
  assign p26_stage_26 = ((full_27 & ~clear_fifo) == 0)? data_in :
    stage_27;

  //data_reg_26, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_26 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_26))
          if (sync_reset & full_26 & !((full_27 == 0) & read & write))
              stage_26 <= 0;
          else 
            stage_26 <= p26_stage_26;
    end


  //control_26, which is an e_mux
  assign p26_full_26 = ((read & !write) == 0)? full_25 :
    full_27;

  //control_reg_26, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_26 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_26 <= 0;
          else 
            full_26 <= p26_full_26;
    end


  //data_25, which is an e_mux
  assign p25_stage_25 = ((full_26 & ~clear_fifo) == 0)? data_in :
    stage_26;

  //data_reg_25, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_25 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_25))
          if (sync_reset & full_25 & !((full_26 == 0) & read & write))
              stage_25 <= 0;
          else 
            stage_25 <= p25_stage_25;
    end


  //control_25, which is an e_mux
  assign p25_full_25 = ((read & !write) == 0)? full_24 :
    full_26;

  //control_reg_25, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_25 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_25 <= 0;
          else 
            full_25 <= p25_full_25;
    end


  //data_24, which is an e_mux
  assign p24_stage_24 = ((full_25 & ~clear_fifo) == 0)? data_in :
    stage_25;

  //data_reg_24, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_24 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_24))
          if (sync_reset & full_24 & !((full_25 == 0) & read & write))
              stage_24 <= 0;
          else 
            stage_24 <= p24_stage_24;
    end


  //control_24, which is an e_mux
  assign p24_full_24 = ((read & !write) == 0)? full_23 :
    full_25;

  //control_reg_24, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_24 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_24 <= 0;
          else 
            full_24 <= p24_full_24;
    end


  //data_23, which is an e_mux
  assign p23_stage_23 = ((full_24 & ~clear_fifo) == 0)? data_in :
    stage_24;

  //data_reg_23, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_23 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_23))
          if (sync_reset & full_23 & !((full_24 == 0) & read & write))
              stage_23 <= 0;
          else 
            stage_23 <= p23_stage_23;
    end


  //control_23, which is an e_mux
  assign p23_full_23 = ((read & !write) == 0)? full_22 :
    full_24;

  //control_reg_23, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_23 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_23 <= 0;
          else 
            full_23 <= p23_full_23;
    end


  //data_22, which is an e_mux
  assign p22_stage_22 = ((full_23 & ~clear_fifo) == 0)? data_in :
    stage_23;

  //data_reg_22, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_22 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_22))
          if (sync_reset & full_22 & !((full_23 == 0) & read & write))
              stage_22 <= 0;
          else 
            stage_22 <= p22_stage_22;
    end


  //control_22, which is an e_mux
  assign p22_full_22 = ((read & !write) == 0)? full_21 :
    full_23;

  //control_reg_22, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_22 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_22 <= 0;
          else 
            full_22 <= p22_full_22;
    end


  //data_21, which is an e_mux
  assign p21_stage_21 = ((full_22 & ~clear_fifo) == 0)? data_in :
    stage_22;

  //data_reg_21, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_21 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_21))
          if (sync_reset & full_21 & !((full_22 == 0) & read & write))
              stage_21 <= 0;
          else 
            stage_21 <= p21_stage_21;
    end


  //control_21, which is an e_mux
  assign p21_full_21 = ((read & !write) == 0)? full_20 :
    full_22;

  //control_reg_21, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_21 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_21 <= 0;
          else 
            full_21 <= p21_full_21;
    end


  //data_20, which is an e_mux
  assign p20_stage_20 = ((full_21 & ~clear_fifo) == 0)? data_in :
    stage_21;

  //data_reg_20, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_20 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_20))
          if (sync_reset & full_20 & !((full_21 == 0) & read & write))
              stage_20 <= 0;
          else 
            stage_20 <= p20_stage_20;
    end


  //control_20, which is an e_mux
  assign p20_full_20 = ((read & !write) == 0)? full_19 :
    full_21;

  //control_reg_20, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_20 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_20 <= 0;
          else 
            full_20 <= p20_full_20;
    end


  //data_19, which is an e_mux
  assign p19_stage_19 = ((full_20 & ~clear_fifo) == 0)? data_in :
    stage_20;

  //data_reg_19, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_19 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_19))
          if (sync_reset & full_19 & !((full_20 == 0) & read & write))
              stage_19 <= 0;
          else 
            stage_19 <= p19_stage_19;
    end


  //control_19, which is an e_mux
  assign p19_full_19 = ((read & !write) == 0)? full_18 :
    full_20;

  //control_reg_19, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_19 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_19 <= 0;
          else 
            full_19 <= p19_full_19;
    end


  //data_18, which is an e_mux
  assign p18_stage_18 = ((full_19 & ~clear_fifo) == 0)? data_in :
    stage_19;

  //data_reg_18, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_18 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_18))
          if (sync_reset & full_18 & !((full_19 == 0) & read & write))
              stage_18 <= 0;
          else 
            stage_18 <= p18_stage_18;
    end


  //control_18, which is an e_mux
  assign p18_full_18 = ((read & !write) == 0)? full_17 :
    full_19;

  //control_reg_18, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_18 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_18 <= 0;
          else 
            full_18 <= p18_full_18;
    end


  //data_17, which is an e_mux
  assign p17_stage_17 = ((full_18 & ~clear_fifo) == 0)? data_in :
    stage_18;

  //data_reg_17, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_17 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_17))
          if (sync_reset & full_17 & !((full_18 == 0) & read & write))
              stage_17 <= 0;
          else 
            stage_17 <= p17_stage_17;
    end


  //control_17, which is an e_mux
  assign p17_full_17 = ((read & !write) == 0)? full_16 :
    full_18;

  //control_reg_17, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_17 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_17 <= 0;
          else 
            full_17 <= p17_full_17;
    end


  //data_16, which is an e_mux
  assign p16_stage_16 = ((full_17 & ~clear_fifo) == 0)? data_in :
    stage_17;

  //data_reg_16, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_16 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_16))
          if (sync_reset & full_16 & !((full_17 == 0) & read & write))
              stage_16 <= 0;
          else 
            stage_16 <= p16_stage_16;
    end


  //control_16, which is an e_mux
  assign p16_full_16 = ((read & !write) == 0)? full_15 :
    full_17;

  //control_reg_16, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_16 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_16 <= 0;
          else 
            full_16 <= p16_full_16;
    end


  //data_15, which is an e_mux
  assign p15_stage_15 = ((full_16 & ~clear_fifo) == 0)? data_in :
    stage_16;

  //data_reg_15, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_15 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_15))
          if (sync_reset & full_15 & !((full_16 == 0) & read & write))
              stage_15 <= 0;
          else 
            stage_15 <= p15_stage_15;
    end


  //control_15, which is an e_mux
  assign p15_full_15 = ((read & !write) == 0)? full_14 :
    full_16;

  //control_reg_15, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_15 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_15 <= 0;
          else 
            full_15 <= p15_full_15;
    end


  //data_14, which is an e_mux
  assign p14_stage_14 = ((full_15 & ~clear_fifo) == 0)? data_in :
    stage_15;

  //data_reg_14, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_14 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_14))
          if (sync_reset & full_14 & !((full_15 == 0) & read & write))
              stage_14 <= 0;
          else 
            stage_14 <= p14_stage_14;
    end


  //control_14, which is an e_mux
  assign p14_full_14 = ((read & !write) == 0)? full_13 :
    full_15;

  //control_reg_14, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_14 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_14 <= 0;
          else 
            full_14 <= p14_full_14;
    end


  //data_13, which is an e_mux
  assign p13_stage_13 = ((full_14 & ~clear_fifo) == 0)? data_in :
    stage_14;

  //data_reg_13, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_13 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_13))
          if (sync_reset & full_13 & !((full_14 == 0) & read & write))
              stage_13 <= 0;
          else 
            stage_13 <= p13_stage_13;
    end


  //control_13, which is an e_mux
  assign p13_full_13 = ((read & !write) == 0)? full_12 :
    full_14;

  //control_reg_13, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_13 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_13 <= 0;
          else 
            full_13 <= p13_full_13;
    end


  //data_12, which is an e_mux
  assign p12_stage_12 = ((full_13 & ~clear_fifo) == 0)? data_in :
    stage_13;

  //data_reg_12, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_12 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_12))
          if (sync_reset & full_12 & !((full_13 == 0) & read & write))
              stage_12 <= 0;
          else 
            stage_12 <= p12_stage_12;
    end


  //control_12, which is an e_mux
  assign p12_full_12 = ((read & !write) == 0)? full_11 :
    full_13;

  //control_reg_12, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_12 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_12 <= 0;
          else 
            full_12 <= p12_full_12;
    end


  //data_11, which is an e_mux
  assign p11_stage_11 = ((full_12 & ~clear_fifo) == 0)? data_in :
    stage_12;

  //data_reg_11, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_11 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_11))
          if (sync_reset & full_11 & !((full_12 == 0) & read & write))
              stage_11 <= 0;
          else 
            stage_11 <= p11_stage_11;
    end


  //control_11, which is an e_mux
  assign p11_full_11 = ((read & !write) == 0)? full_10 :
    full_12;

  //control_reg_11, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_11 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_11 <= 0;
          else 
            full_11 <= p11_full_11;
    end


  //data_10, which is an e_mux
  assign p10_stage_10 = ((full_11 & ~clear_fifo) == 0)? data_in :
    stage_11;

  //data_reg_10, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_10 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_10))
          if (sync_reset & full_10 & !((full_11 == 0) & read & write))
              stage_10 <= 0;
          else 
            stage_10 <= p10_stage_10;
    end


  //control_10, which is an e_mux
  assign p10_full_10 = ((read & !write) == 0)? full_9 :
    full_11;

  //control_reg_10, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_10 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_10 <= 0;
          else 
            full_10 <= p10_full_10;
    end


  //data_9, which is an e_mux
  assign p9_stage_9 = ((full_10 & ~clear_fifo) == 0)? data_in :
    stage_10;

  //data_reg_9, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_9 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_9))
          if (sync_reset & full_9 & !((full_10 == 0) & read & write))
              stage_9 <= 0;
          else 
            stage_9 <= p9_stage_9;
    end


  //control_9, which is an e_mux
  assign p9_full_9 = ((read & !write) == 0)? full_8 :
    full_10;

  //control_reg_9, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_9 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_9 <= 0;
          else 
            full_9 <= p9_full_9;
    end


  //data_8, which is an e_mux
  assign p8_stage_8 = ((full_9 & ~clear_fifo) == 0)? data_in :
    stage_9;

  //data_reg_8, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_8 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_8))
          if (sync_reset & full_8 & !((full_9 == 0) & read & write))
              stage_8 <= 0;
          else 
            stage_8 <= p8_stage_8;
    end


  //control_8, which is an e_mux
  assign p8_full_8 = ((read & !write) == 0)? full_7 :
    full_9;

  //control_reg_8, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_8 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_8 <= 0;
          else 
            full_8 <= p8_full_8;
    end


  //data_7, which is an e_mux
  assign p7_stage_7 = ((full_8 & ~clear_fifo) == 0)? data_in :
    stage_8;

  //data_reg_7, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_7 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_7))
          if (sync_reset & full_7 & !((full_8 == 0) & read & write))
              stage_7 <= 0;
          else 
            stage_7 <= p7_stage_7;
    end


  //control_7, which is an e_mux
  assign p7_full_7 = ((read & !write) == 0)? full_6 :
    full_8;

  //control_reg_7, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_7 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_7 <= 0;
          else 
            full_7 <= p7_full_7;
    end


  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    stage_7;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    full_7;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_crossing_io_s1_arbitrator (
                                         // inputs:
                                          clk,
                                          clock_crossing_io_s1_endofpacket,
                                          clock_crossing_io_s1_readdata,
                                          clock_crossing_io_s1_readdatavalid,
                                          clock_crossing_io_s1_waitrequest,
                                          cpu_data_master_address_to_slave,
                                          cpu_data_master_byteenable,
                                          cpu_data_master_latency_counter,
                                          cpu_data_master_read,
                                          cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                                          cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                          cpu_data_master_write,
                                          cpu_data_master_writedata,
                                          reset_n,

                                         // outputs:
                                          clock_crossing_io_s1_address,
                                          clock_crossing_io_s1_byteenable,
                                          clock_crossing_io_s1_endofpacket_from_sa,
                                          clock_crossing_io_s1_nativeaddress,
                                          clock_crossing_io_s1_read,
                                          clock_crossing_io_s1_readdata_from_sa,
                                          clock_crossing_io_s1_reset_n,
                                          clock_crossing_io_s1_waitrequest_from_sa,
                                          clock_crossing_io_s1_write,
                                          clock_crossing_io_s1_writedata,
                                          cpu_data_master_granted_clock_crossing_io_s1,
                                          cpu_data_master_qualified_request_clock_crossing_io_s1,
                                          cpu_data_master_read_data_valid_clock_crossing_io_s1,
                                          cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                                          cpu_data_master_requests_clock_crossing_io_s1,
                                          d1_clock_crossing_io_s1_end_xfer
                                       )
;

  output  [  4: 0] clock_crossing_io_s1_address;
  output  [  3: 0] clock_crossing_io_s1_byteenable;
  output           clock_crossing_io_s1_endofpacket_from_sa;
  output  [  4: 0] clock_crossing_io_s1_nativeaddress;
  output           clock_crossing_io_s1_read;
  output  [ 31: 0] clock_crossing_io_s1_readdata_from_sa;
  output           clock_crossing_io_s1_reset_n;
  output           clock_crossing_io_s1_waitrequest_from_sa;
  output           clock_crossing_io_s1_write;
  output  [ 31: 0] clock_crossing_io_s1_writedata;
  output           cpu_data_master_granted_clock_crossing_io_s1;
  output           cpu_data_master_qualified_request_clock_crossing_io_s1;
  output           cpu_data_master_read_data_valid_clock_crossing_io_s1;
  output           cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  output           cpu_data_master_requests_clock_crossing_io_s1;
  output           d1_clock_crossing_io_s1_end_xfer;
  input            clk;
  input            clock_crossing_io_s1_endofpacket;
  input   [ 31: 0] clock_crossing_io_s1_readdata;
  input            clock_crossing_io_s1_readdatavalid;
  input            clock_crossing_io_s1_waitrequest;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  4: 0] clock_crossing_io_s1_address;
  wire             clock_crossing_io_s1_allgrants;
  wire             clock_crossing_io_s1_allow_new_arb_cycle;
  wire             clock_crossing_io_s1_any_bursting_master_saved_grant;
  wire             clock_crossing_io_s1_any_continuerequest;
  wire             clock_crossing_io_s1_arb_counter_enable;
  reg     [  1: 0] clock_crossing_io_s1_arb_share_counter;
  wire    [  1: 0] clock_crossing_io_s1_arb_share_counter_next_value;
  wire    [  1: 0] clock_crossing_io_s1_arb_share_set_values;
  wire             clock_crossing_io_s1_beginbursttransfer_internal;
  wire             clock_crossing_io_s1_begins_xfer;
  wire    [  3: 0] clock_crossing_io_s1_byteenable;
  wire             clock_crossing_io_s1_end_xfer;
  wire             clock_crossing_io_s1_endofpacket_from_sa;
  wire             clock_crossing_io_s1_firsttransfer;
  wire             clock_crossing_io_s1_grant_vector;
  wire             clock_crossing_io_s1_in_a_read_cycle;
  wire             clock_crossing_io_s1_in_a_write_cycle;
  wire             clock_crossing_io_s1_master_qreq_vector;
  wire             clock_crossing_io_s1_move_on_to_next_transaction;
  wire    [  4: 0] clock_crossing_io_s1_nativeaddress;
  wire             clock_crossing_io_s1_non_bursting_master_requests;
  wire             clock_crossing_io_s1_read;
  wire    [ 31: 0] clock_crossing_io_s1_readdata_from_sa;
  wire             clock_crossing_io_s1_readdatavalid_from_sa;
  reg              clock_crossing_io_s1_reg_firsttransfer;
  wire             clock_crossing_io_s1_reset_n;
  reg              clock_crossing_io_s1_slavearbiterlockenable;
  wire             clock_crossing_io_s1_slavearbiterlockenable2;
  wire             clock_crossing_io_s1_unreg_firsttransfer;
  wire             clock_crossing_io_s1_waitrequest_from_sa;
  wire             clock_crossing_io_s1_waits_for_read;
  wire             clock_crossing_io_s1_waits_for_write;
  wire             clock_crossing_io_s1_write;
  wire    [ 31: 0] clock_crossing_io_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_clock_crossing_io_s1;
  wire             cpu_data_master_qualified_request_clock_crossing_io_s1;
  wire             cpu_data_master_rdv_fifo_empty_clock_crossing_io_s1;
  wire             cpu_data_master_rdv_fifo_output_from_clock_crossing_io_s1;
  wire             cpu_data_master_read_data_valid_clock_crossing_io_s1;
  wire             cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  wire             cpu_data_master_requests_clock_crossing_io_s1;
  wire             cpu_data_master_saved_grant_clock_crossing_io_s1;
  reg              d1_clock_crossing_io_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_clock_crossing_io_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_clock_crossing_io_s1_from_cpu_data_master;
  wire             wait_for_clock_crossing_io_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~clock_crossing_io_s1_end_xfer;
    end


  assign clock_crossing_io_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_clock_crossing_io_s1));
  //assign clock_crossing_io_s1_readdatavalid_from_sa = clock_crossing_io_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io_s1_readdatavalid_from_sa = clock_crossing_io_s1_readdatavalid;

  //assign clock_crossing_io_s1_readdata_from_sa = clock_crossing_io_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io_s1_readdata_from_sa = clock_crossing_io_s1_readdata;

  assign cpu_data_master_requests_clock_crossing_io_s1 = ({cpu_data_master_address_to_slave[26 : 7] , 7'b0} == 27'h4000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign clock_crossing_io_s1_waitrequest_from_sa = clock_crossing_io_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io_s1_waitrequest_from_sa = clock_crossing_io_s1_waitrequest;

  //clock_crossing_io_s1_arb_share_counter set values, which is an e_mux
  assign clock_crossing_io_s1_arb_share_set_values = 1;

  //clock_crossing_io_s1_non_bursting_master_requests mux, which is an e_mux
  assign clock_crossing_io_s1_non_bursting_master_requests = cpu_data_master_requests_clock_crossing_io_s1;

  //clock_crossing_io_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign clock_crossing_io_s1_any_bursting_master_saved_grant = 0;

  //clock_crossing_io_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign clock_crossing_io_s1_arb_share_counter_next_value = clock_crossing_io_s1_firsttransfer ? (clock_crossing_io_s1_arb_share_set_values - 1) : |clock_crossing_io_s1_arb_share_counter ? (clock_crossing_io_s1_arb_share_counter - 1) : 0;

  //clock_crossing_io_s1_allgrants all slave grants, which is an e_mux
  assign clock_crossing_io_s1_allgrants = |clock_crossing_io_s1_grant_vector;

  //clock_crossing_io_s1_end_xfer assignment, which is an e_assign
  assign clock_crossing_io_s1_end_xfer = ~(clock_crossing_io_s1_waits_for_read | clock_crossing_io_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_clock_crossing_io_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_clock_crossing_io_s1 = clock_crossing_io_s1_end_xfer & (~clock_crossing_io_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //clock_crossing_io_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign clock_crossing_io_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_clock_crossing_io_s1 & clock_crossing_io_s1_allgrants) | (end_xfer_arb_share_counter_term_clock_crossing_io_s1 & ~clock_crossing_io_s1_non_bursting_master_requests);

  //clock_crossing_io_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_s1_arb_share_counter <= 0;
      else if (clock_crossing_io_s1_arb_counter_enable)
          clock_crossing_io_s1_arb_share_counter <= clock_crossing_io_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_s1_slavearbiterlockenable <= 0;
      else if ((|clock_crossing_io_s1_master_qreq_vector & end_xfer_arb_share_counter_term_clock_crossing_io_s1) | (end_xfer_arb_share_counter_term_clock_crossing_io_s1 & ~clock_crossing_io_s1_non_bursting_master_requests))
          clock_crossing_io_s1_slavearbiterlockenable <= |clock_crossing_io_s1_arb_share_counter_next_value;
    end


  //cpu/data_master clock_crossing_io/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = clock_crossing_io_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //clock_crossing_io_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign clock_crossing_io_s1_slavearbiterlockenable2 = |clock_crossing_io_s1_arb_share_counter_next_value;

  //cpu/data_master clock_crossing_io/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = clock_crossing_io_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //clock_crossing_io_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign clock_crossing_io_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_clock_crossing_io_s1 = cpu_data_master_requests_clock_crossing_io_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))));
  //unique name for clock_crossing_io_s1_move_on_to_next_transaction, which is an e_assign
  assign clock_crossing_io_s1_move_on_to_next_transaction = clock_crossing_io_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_clock_crossing_io_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_clock_crossing_io_s1_module rdv_fifo_for_cpu_data_master_to_clock_crossing_io_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_clock_crossing_io_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_clock_crossing_io_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_clock_crossing_io_s1),
      .full                 (),
      .read                 (clock_crossing_io_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~clock_crossing_io_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_clock_crossing_io_s1;
  //local readdatavalid cpu_data_master_read_data_valid_clock_crossing_io_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_clock_crossing_io_s1 = clock_crossing_io_s1_readdatavalid_from_sa;

  //clock_crossing_io_s1_writedata mux, which is an e_mux
  assign clock_crossing_io_s1_writedata = cpu_data_master_writedata;

  //assign clock_crossing_io_s1_endofpacket_from_sa = clock_crossing_io_s1_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io_s1_endofpacket_from_sa = clock_crossing_io_s1_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_clock_crossing_io_s1 = cpu_data_master_qualified_request_clock_crossing_io_s1;

  //cpu/data_master saved-grant clock_crossing_io/s1, which is an e_assign
  assign cpu_data_master_saved_grant_clock_crossing_io_s1 = cpu_data_master_requests_clock_crossing_io_s1;

  //allow new arb cycle for clock_crossing_io/s1, which is an e_assign
  assign clock_crossing_io_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign clock_crossing_io_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign clock_crossing_io_s1_master_qreq_vector = 1;

  //clock_crossing_io_s1_reset_n assignment, which is an e_assign
  assign clock_crossing_io_s1_reset_n = reset_n;

  //clock_crossing_io_s1_firsttransfer first transaction, which is an e_assign
  assign clock_crossing_io_s1_firsttransfer = clock_crossing_io_s1_begins_xfer ? clock_crossing_io_s1_unreg_firsttransfer : clock_crossing_io_s1_reg_firsttransfer;

  //clock_crossing_io_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign clock_crossing_io_s1_unreg_firsttransfer = ~(clock_crossing_io_s1_slavearbiterlockenable & clock_crossing_io_s1_any_continuerequest);

  //clock_crossing_io_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_s1_reg_firsttransfer <= 1'b1;
      else if (clock_crossing_io_s1_begins_xfer)
          clock_crossing_io_s1_reg_firsttransfer <= clock_crossing_io_s1_unreg_firsttransfer;
    end


  //clock_crossing_io_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign clock_crossing_io_s1_beginbursttransfer_internal = clock_crossing_io_s1_begins_xfer;

  //clock_crossing_io_s1_read assignment, which is an e_mux
  assign clock_crossing_io_s1_read = cpu_data_master_granted_clock_crossing_io_s1 & cpu_data_master_read;

  //clock_crossing_io_s1_write assignment, which is an e_mux
  assign clock_crossing_io_s1_write = cpu_data_master_granted_clock_crossing_io_s1 & cpu_data_master_write;

  assign shifted_address_to_clock_crossing_io_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //clock_crossing_io_s1_address mux, which is an e_mux
  assign clock_crossing_io_s1_address = shifted_address_to_clock_crossing_io_s1_from_cpu_data_master >> 2;

  //slaveid clock_crossing_io_s1_nativeaddress nativeaddress mux, which is an e_mux
  assign clock_crossing_io_s1_nativeaddress = cpu_data_master_address_to_slave >> 2;

  //d1_clock_crossing_io_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_clock_crossing_io_s1_end_xfer <= 1;
      else 
        d1_clock_crossing_io_s1_end_xfer <= clock_crossing_io_s1_end_xfer;
    end


  //clock_crossing_io_s1_waits_for_read in a cycle, which is an e_mux
  assign clock_crossing_io_s1_waits_for_read = clock_crossing_io_s1_in_a_read_cycle & clock_crossing_io_s1_waitrequest_from_sa;

  //clock_crossing_io_s1_in_a_read_cycle assignment, which is an e_assign
  assign clock_crossing_io_s1_in_a_read_cycle = cpu_data_master_granted_clock_crossing_io_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = clock_crossing_io_s1_in_a_read_cycle;

  //clock_crossing_io_s1_waits_for_write in a cycle, which is an e_mux
  assign clock_crossing_io_s1_waits_for_write = clock_crossing_io_s1_in_a_write_cycle & clock_crossing_io_s1_waitrequest_from_sa;

  //clock_crossing_io_s1_in_a_write_cycle assignment, which is an e_assign
  assign clock_crossing_io_s1_in_a_write_cycle = cpu_data_master_granted_clock_crossing_io_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = clock_crossing_io_s1_in_a_write_cycle;

  assign wait_for_clock_crossing_io_s1_counter = 0;
  //clock_crossing_io_s1_byteenable byte enable port mux, which is an e_mux
  assign clock_crossing_io_s1_byteenable = (cpu_data_master_granted_clock_crossing_io_s1)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_crossing_io/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_crossing_io_m1_arbitrator (
                                         // inputs:
                                          clk,
                                          clock_crossing_io_m1_address,
                                          clock_crossing_io_m1_byteenable,
                                          clock_crossing_io_m1_granted_g_sensor_int_s1,
                                          clock_crossing_io_m1_granted_key_s1,
                                          clock_crossing_io_m1_granted_led_s1,
                                          clock_crossing_io_m1_granted_select_i2c_clk_s1,
                                          clock_crossing_io_m1_granted_sw_s1,
                                          clock_crossing_io_m1_granted_sysid_control_slave,
                                          clock_crossing_io_m1_granted_timer_s1,
                                          clock_crossing_io_m1_qualified_request_g_sensor_int_s1,
                                          clock_crossing_io_m1_qualified_request_key_s1,
                                          clock_crossing_io_m1_qualified_request_led_s1,
                                          clock_crossing_io_m1_qualified_request_select_i2c_clk_s1,
                                          clock_crossing_io_m1_qualified_request_sw_s1,
                                          clock_crossing_io_m1_qualified_request_sysid_control_slave,
                                          clock_crossing_io_m1_qualified_request_timer_s1,
                                          clock_crossing_io_m1_read,
                                          clock_crossing_io_m1_read_data_valid_g_sensor_int_s1,
                                          clock_crossing_io_m1_read_data_valid_key_s1,
                                          clock_crossing_io_m1_read_data_valid_led_s1,
                                          clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1,
                                          clock_crossing_io_m1_read_data_valid_sw_s1,
                                          clock_crossing_io_m1_read_data_valid_sysid_control_slave,
                                          clock_crossing_io_m1_read_data_valid_timer_s1,
                                          clock_crossing_io_m1_requests_g_sensor_int_s1,
                                          clock_crossing_io_m1_requests_key_s1,
                                          clock_crossing_io_m1_requests_led_s1,
                                          clock_crossing_io_m1_requests_select_i2c_clk_s1,
                                          clock_crossing_io_m1_requests_sw_s1,
                                          clock_crossing_io_m1_requests_sysid_control_slave,
                                          clock_crossing_io_m1_requests_timer_s1,
                                          clock_crossing_io_m1_write,
                                          clock_crossing_io_m1_writedata,
                                          d1_g_sensor_int_s1_end_xfer,
                                          d1_key_s1_end_xfer,
                                          d1_led_s1_end_xfer,
                                          d1_select_i2c_clk_s1_end_xfer,
                                          d1_sw_s1_end_xfer,
                                          d1_sysid_control_slave_end_xfer,
                                          d1_timer_s1_end_xfer,
                                          g_sensor_int_s1_readdata_from_sa,
                                          key_s1_readdata_from_sa,
                                          led_s1_readdata_from_sa,
                                          reset_n,
                                          select_i2c_clk_s1_readdata_from_sa,
                                          sw_s1_readdata_from_sa,
                                          sysid_control_slave_readdata_from_sa,
                                          timer_s1_readdata_from_sa,

                                         // outputs:
                                          clock_crossing_io_m1_address_to_slave,
                                          clock_crossing_io_m1_latency_counter,
                                          clock_crossing_io_m1_readdata,
                                          clock_crossing_io_m1_readdatavalid,
                                          clock_crossing_io_m1_reset_n,
                                          clock_crossing_io_m1_waitrequest
                                       )
;

  output  [  6: 0] clock_crossing_io_m1_address_to_slave;
  output           clock_crossing_io_m1_latency_counter;
  output  [ 31: 0] clock_crossing_io_m1_readdata;
  output           clock_crossing_io_m1_readdatavalid;
  output           clock_crossing_io_m1_reset_n;
  output           clock_crossing_io_m1_waitrequest;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address;
  input   [  3: 0] clock_crossing_io_m1_byteenable;
  input            clock_crossing_io_m1_granted_g_sensor_int_s1;
  input            clock_crossing_io_m1_granted_key_s1;
  input            clock_crossing_io_m1_granted_led_s1;
  input            clock_crossing_io_m1_granted_select_i2c_clk_s1;
  input            clock_crossing_io_m1_granted_sw_s1;
  input            clock_crossing_io_m1_granted_sysid_control_slave;
  input            clock_crossing_io_m1_granted_timer_s1;
  input            clock_crossing_io_m1_qualified_request_g_sensor_int_s1;
  input            clock_crossing_io_m1_qualified_request_key_s1;
  input            clock_crossing_io_m1_qualified_request_led_s1;
  input            clock_crossing_io_m1_qualified_request_select_i2c_clk_s1;
  input            clock_crossing_io_m1_qualified_request_sw_s1;
  input            clock_crossing_io_m1_qualified_request_sysid_control_slave;
  input            clock_crossing_io_m1_qualified_request_timer_s1;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_read_data_valid_g_sensor_int_s1;
  input            clock_crossing_io_m1_read_data_valid_key_s1;
  input            clock_crossing_io_m1_read_data_valid_led_s1;
  input            clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1;
  input            clock_crossing_io_m1_read_data_valid_sw_s1;
  input            clock_crossing_io_m1_read_data_valid_sysid_control_slave;
  input            clock_crossing_io_m1_read_data_valid_timer_s1;
  input            clock_crossing_io_m1_requests_g_sensor_int_s1;
  input            clock_crossing_io_m1_requests_key_s1;
  input            clock_crossing_io_m1_requests_led_s1;
  input            clock_crossing_io_m1_requests_select_i2c_clk_s1;
  input            clock_crossing_io_m1_requests_sw_s1;
  input            clock_crossing_io_m1_requests_sysid_control_slave;
  input            clock_crossing_io_m1_requests_timer_s1;
  input            clock_crossing_io_m1_write;
  input   [ 31: 0] clock_crossing_io_m1_writedata;
  input            d1_g_sensor_int_s1_end_xfer;
  input            d1_key_s1_end_xfer;
  input            d1_led_s1_end_xfer;
  input            d1_select_i2c_clk_s1_end_xfer;
  input            d1_sw_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            d1_timer_s1_end_xfer;
  input            g_sensor_int_s1_readdata_from_sa;
  input   [  1: 0] key_s1_readdata_from_sa;
  input   [  7: 0] led_s1_readdata_from_sa;
  input            reset_n;
  input            select_i2c_clk_s1_readdata_from_sa;
  input   [  3: 0] sw_s1_readdata_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;
  input   [ 15: 0] timer_s1_readdata_from_sa;

  reg              active_and_waiting_last_time;
  reg     [  6: 0] clock_crossing_io_m1_address_last_time;
  wire    [  6: 0] clock_crossing_io_m1_address_to_slave;
  reg     [  3: 0] clock_crossing_io_m1_byteenable_last_time;
  wire             clock_crossing_io_m1_is_granted_some_slave;
  reg              clock_crossing_io_m1_latency_counter;
  reg              clock_crossing_io_m1_read_but_no_slave_selected;
  reg              clock_crossing_io_m1_read_last_time;
  wire    [ 31: 0] clock_crossing_io_m1_readdata;
  wire             clock_crossing_io_m1_readdatavalid;
  wire             clock_crossing_io_m1_reset_n;
  wire             clock_crossing_io_m1_run;
  wire             clock_crossing_io_m1_waitrequest;
  reg              clock_crossing_io_m1_write_last_time;
  reg     [ 31: 0] clock_crossing_io_m1_writedata_last_time;
  wire             latency_load_value;
  wire             p1_clock_crossing_io_m1_latency_counter;
  wire             pre_flush_clock_crossing_io_m1_readdatavalid;
  wire             r_1;
  wire             r_2;
  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (clock_crossing_io_m1_qualified_request_g_sensor_int_s1 | ~clock_crossing_io_m1_requests_g_sensor_int_s1) & ((~clock_crossing_io_m1_qualified_request_g_sensor_int_s1 | ~clock_crossing_io_m1_read | (1 & ~d1_g_sensor_int_s1_end_xfer & clock_crossing_io_m1_read))) & ((~clock_crossing_io_m1_qualified_request_g_sensor_int_s1 | ~clock_crossing_io_m1_write | (1 & clock_crossing_io_m1_write))) & 1 & (clock_crossing_io_m1_qualified_request_key_s1 | ~clock_crossing_io_m1_requests_key_s1) & ((~clock_crossing_io_m1_qualified_request_key_s1 | ~clock_crossing_io_m1_read | (1 & ~d1_key_s1_end_xfer & clock_crossing_io_m1_read))) & ((~clock_crossing_io_m1_qualified_request_key_s1 | ~clock_crossing_io_m1_write | (1 & clock_crossing_io_m1_write))) & 1 & (clock_crossing_io_m1_qualified_request_led_s1 | ~clock_crossing_io_m1_requests_led_s1) & ((~clock_crossing_io_m1_qualified_request_led_s1 | ~clock_crossing_io_m1_read | (1 & ~d1_led_s1_end_xfer & clock_crossing_io_m1_read))) & ((~clock_crossing_io_m1_qualified_request_led_s1 | ~clock_crossing_io_m1_write | (1 & clock_crossing_io_m1_write))) & 1 & (clock_crossing_io_m1_qualified_request_select_i2c_clk_s1 | ~clock_crossing_io_m1_requests_select_i2c_clk_s1) & ((~clock_crossing_io_m1_qualified_request_select_i2c_clk_s1 | ~clock_crossing_io_m1_read | (1 & ~d1_select_i2c_clk_s1_end_xfer & clock_crossing_io_m1_read))) & ((~clock_crossing_io_m1_qualified_request_select_i2c_clk_s1 | ~clock_crossing_io_m1_write | (1 & clock_crossing_io_m1_write))) & 1 & (clock_crossing_io_m1_qualified_request_sw_s1 | ~clock_crossing_io_m1_requests_sw_s1) & ((~clock_crossing_io_m1_qualified_request_sw_s1 | ~clock_crossing_io_m1_read | (1 & ~d1_sw_s1_end_xfer & clock_crossing_io_m1_read))) & ((~clock_crossing_io_m1_qualified_request_sw_s1 | ~clock_crossing_io_m1_write | (1 & clock_crossing_io_m1_write)));

  //cascaded wait assignment, which is an e_assign
  assign clock_crossing_io_m1_run = r_1 & r_2;

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (clock_crossing_io_m1_qualified_request_sysid_control_slave | ~clock_crossing_io_m1_requests_sysid_control_slave) & ((~clock_crossing_io_m1_qualified_request_sysid_control_slave | ~clock_crossing_io_m1_read | (1 & ~d1_sysid_control_slave_end_xfer & clock_crossing_io_m1_read))) & ((~clock_crossing_io_m1_qualified_request_sysid_control_slave | ~clock_crossing_io_m1_write | (1 & clock_crossing_io_m1_write))) & 1 & (clock_crossing_io_m1_qualified_request_timer_s1 | ~clock_crossing_io_m1_requests_timer_s1) & ((~clock_crossing_io_m1_qualified_request_timer_s1 | ~clock_crossing_io_m1_read | (1 & ~d1_timer_s1_end_xfer & clock_crossing_io_m1_read))) & ((~clock_crossing_io_m1_qualified_request_timer_s1 | ~clock_crossing_io_m1_write | (1 & clock_crossing_io_m1_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign clock_crossing_io_m1_address_to_slave = clock_crossing_io_m1_address[6 : 0];

  //clock_crossing_io_m1_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_m1_read_but_no_slave_selected <= 0;
      else 
        clock_crossing_io_m1_read_but_no_slave_selected <= clock_crossing_io_m1_read & clock_crossing_io_m1_run & ~clock_crossing_io_m1_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign clock_crossing_io_m1_is_granted_some_slave = clock_crossing_io_m1_granted_g_sensor_int_s1 |
    clock_crossing_io_m1_granted_key_s1 |
    clock_crossing_io_m1_granted_led_s1 |
    clock_crossing_io_m1_granted_select_i2c_clk_s1 |
    clock_crossing_io_m1_granted_sw_s1 |
    clock_crossing_io_m1_granted_sysid_control_slave |
    clock_crossing_io_m1_granted_timer_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_clock_crossing_io_m1_readdatavalid = 0;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign clock_crossing_io_m1_readdatavalid = clock_crossing_io_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io_m1_readdatavalid |
    clock_crossing_io_m1_read_data_valid_g_sensor_int_s1 |
    clock_crossing_io_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io_m1_readdatavalid |
    clock_crossing_io_m1_read_data_valid_key_s1 |
    clock_crossing_io_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io_m1_readdatavalid |
    clock_crossing_io_m1_read_data_valid_led_s1 |
    clock_crossing_io_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io_m1_readdatavalid |
    clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1 |
    clock_crossing_io_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io_m1_readdatavalid |
    clock_crossing_io_m1_read_data_valid_sw_s1 |
    clock_crossing_io_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io_m1_readdatavalid |
    clock_crossing_io_m1_read_data_valid_sysid_control_slave |
    clock_crossing_io_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io_m1_readdatavalid |
    clock_crossing_io_m1_read_data_valid_timer_s1;

  //clock_crossing_io/m1 readdata mux, which is an e_mux
  assign clock_crossing_io_m1_readdata = ({32 {~(clock_crossing_io_m1_qualified_request_g_sensor_int_s1 & clock_crossing_io_m1_read)}} | g_sensor_int_s1_readdata_from_sa) &
    ({32 {~(clock_crossing_io_m1_qualified_request_key_s1 & clock_crossing_io_m1_read)}} | key_s1_readdata_from_sa) &
    ({32 {~(clock_crossing_io_m1_qualified_request_led_s1 & clock_crossing_io_m1_read)}} | led_s1_readdata_from_sa) &
    ({32 {~(clock_crossing_io_m1_qualified_request_select_i2c_clk_s1 & clock_crossing_io_m1_read)}} | select_i2c_clk_s1_readdata_from_sa) &
    ({32 {~(clock_crossing_io_m1_qualified_request_sw_s1 & clock_crossing_io_m1_read)}} | sw_s1_readdata_from_sa) &
    ({32 {~(clock_crossing_io_m1_qualified_request_sysid_control_slave & clock_crossing_io_m1_read)}} | sysid_control_slave_readdata_from_sa) &
    ({32 {~(clock_crossing_io_m1_qualified_request_timer_s1 & clock_crossing_io_m1_read)}} | timer_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign clock_crossing_io_m1_waitrequest = ~clock_crossing_io_m1_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_m1_latency_counter <= 0;
      else 
        clock_crossing_io_m1_latency_counter <= p1_clock_crossing_io_m1_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_clock_crossing_io_m1_latency_counter = ((clock_crossing_io_m1_run & clock_crossing_io_m1_read))? latency_load_value :
    (clock_crossing_io_m1_latency_counter)? clock_crossing_io_m1_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //clock_crossing_io_m1_reset_n assignment, which is an e_assign
  assign clock_crossing_io_m1_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_crossing_io_m1_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_m1_address_last_time <= 0;
      else 
        clock_crossing_io_m1_address_last_time <= clock_crossing_io_m1_address;
    end


  //clock_crossing_io/m1 waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= clock_crossing_io_m1_waitrequest & (clock_crossing_io_m1_read | clock_crossing_io_m1_write);
    end


  //clock_crossing_io_m1_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io_m1_address != clock_crossing_io_m1_address_last_time))
        begin
          $write("%0d ns: clock_crossing_io_m1_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io_m1_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_m1_byteenable_last_time <= 0;
      else 
        clock_crossing_io_m1_byteenable_last_time <= clock_crossing_io_m1_byteenable;
    end


  //clock_crossing_io_m1_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io_m1_byteenable != clock_crossing_io_m1_byteenable_last_time))
        begin
          $write("%0d ns: clock_crossing_io_m1_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io_m1_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_m1_read_last_time <= 0;
      else 
        clock_crossing_io_m1_read_last_time <= clock_crossing_io_m1_read;
    end


  //clock_crossing_io_m1_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io_m1_read != clock_crossing_io_m1_read_last_time))
        begin
          $write("%0d ns: clock_crossing_io_m1_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io_m1_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_m1_write_last_time <= 0;
      else 
        clock_crossing_io_m1_write_last_time <= clock_crossing_io_m1_write;
    end


  //clock_crossing_io_m1_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io_m1_write != clock_crossing_io_m1_write_last_time))
        begin
          $write("%0d ns: clock_crossing_io_m1_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io_m1_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io_m1_writedata_last_time <= 0;
      else 
        clock_crossing_io_m1_writedata_last_time <= clock_crossing_io_m1_writedata;
    end


  //clock_crossing_io_m1_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io_m1_writedata != clock_crossing_io_m1_writedata_last_time) & clock_crossing_io_m1_write)
        begin
          $write("%0d ns: clock_crossing_io_m1_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_crossing_io_bridge_arbitrator 
;



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_clock_crossing_io2_s1_module (
                                                                      // inputs:
                                                                       clear_fifo,
                                                                       clk,
                                                                       data_in,
                                                                       read,
                                                                       reset_n,
                                                                       sync_reset,
                                                                       write,

                                                                      // outputs:
                                                                       data_out,
                                                                       empty,
                                                                       fifo_contains_ones_n,
                                                                       full
                                                                    )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_10;
  reg              full_11;
  reg              full_12;
  reg              full_13;
  reg              full_14;
  reg              full_15;
  reg              full_16;
  reg              full_17;
  reg              full_18;
  reg              full_19;
  reg              full_2;
  reg              full_20;
  reg              full_21;
  reg              full_22;
  reg              full_23;
  reg              full_24;
  reg              full_25;
  reg              full_26;
  reg              full_27;
  reg              full_28;
  reg              full_29;
  reg              full_3;
  reg              full_30;
  reg              full_31;
  reg              full_32;
  wire             full_33;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  reg              full_7;
  reg              full_8;
  reg              full_9;
  reg     [  6: 0] how_many_ones;
  wire    [  6: 0] one_count_minus_one;
  wire    [  6: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p10_full_10;
  wire             p10_stage_10;
  wire             p11_full_11;
  wire             p11_stage_11;
  wire             p12_full_12;
  wire             p12_stage_12;
  wire             p13_full_13;
  wire             p13_stage_13;
  wire             p14_full_14;
  wire             p14_stage_14;
  wire             p15_full_15;
  wire             p15_stage_15;
  wire             p16_full_16;
  wire             p16_stage_16;
  wire             p17_full_17;
  wire             p17_stage_17;
  wire             p18_full_18;
  wire             p18_stage_18;
  wire             p19_full_19;
  wire             p19_stage_19;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p20_full_20;
  wire             p20_stage_20;
  wire             p21_full_21;
  wire             p21_stage_21;
  wire             p22_full_22;
  wire             p22_stage_22;
  wire             p23_full_23;
  wire             p23_stage_23;
  wire             p24_full_24;
  wire             p24_stage_24;
  wire             p25_full_25;
  wire             p25_stage_25;
  wire             p26_full_26;
  wire             p26_stage_26;
  wire             p27_full_27;
  wire             p27_stage_27;
  wire             p28_full_28;
  wire             p28_stage_28;
  wire             p29_full_29;
  wire             p29_stage_29;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p30_full_30;
  wire             p30_stage_30;
  wire             p31_full_31;
  wire             p31_stage_31;
  wire             p32_full_32;
  wire             p32_stage_32;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  wire             p7_full_7;
  wire             p7_stage_7;
  wire             p8_full_8;
  wire             p8_stage_8;
  wire             p9_full_9;
  wire             p9_stage_9;
  reg              stage_0;
  reg              stage_1;
  reg              stage_10;
  reg              stage_11;
  reg              stage_12;
  reg              stage_13;
  reg              stage_14;
  reg              stage_15;
  reg              stage_16;
  reg              stage_17;
  reg              stage_18;
  reg              stage_19;
  reg              stage_2;
  reg              stage_20;
  reg              stage_21;
  reg              stage_22;
  reg              stage_23;
  reg              stage_24;
  reg              stage_25;
  reg              stage_26;
  reg              stage_27;
  reg              stage_28;
  reg              stage_29;
  reg              stage_3;
  reg              stage_30;
  reg              stage_31;
  reg              stage_32;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  reg              stage_7;
  reg              stage_8;
  reg              stage_9;
  wire    [  6: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_32;
  assign empty = !full_0;
  assign full_33 = 0;
  //data_32, which is an e_mux
  assign p32_stage_32 = ((full_33 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_32, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_32 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_32))
          if (sync_reset & full_32 & !((full_33 == 0) & read & write))
              stage_32 <= 0;
          else 
            stage_32 <= p32_stage_32;
    end


  //control_32, which is an e_mux
  assign p32_full_32 = ((read & !write) == 0)? full_31 :
    0;

  //control_reg_32, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_32 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_32 <= 0;
          else 
            full_32 <= p32_full_32;
    end


  //data_31, which is an e_mux
  assign p31_stage_31 = ((full_32 & ~clear_fifo) == 0)? data_in :
    stage_32;

  //data_reg_31, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_31 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_31))
          if (sync_reset & full_31 & !((full_32 == 0) & read & write))
              stage_31 <= 0;
          else 
            stage_31 <= p31_stage_31;
    end


  //control_31, which is an e_mux
  assign p31_full_31 = ((read & !write) == 0)? full_30 :
    full_32;

  //control_reg_31, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_31 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_31 <= 0;
          else 
            full_31 <= p31_full_31;
    end


  //data_30, which is an e_mux
  assign p30_stage_30 = ((full_31 & ~clear_fifo) == 0)? data_in :
    stage_31;

  //data_reg_30, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_30 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_30))
          if (sync_reset & full_30 & !((full_31 == 0) & read & write))
              stage_30 <= 0;
          else 
            stage_30 <= p30_stage_30;
    end


  //control_30, which is an e_mux
  assign p30_full_30 = ((read & !write) == 0)? full_29 :
    full_31;

  //control_reg_30, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_30 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_30 <= 0;
          else 
            full_30 <= p30_full_30;
    end


  //data_29, which is an e_mux
  assign p29_stage_29 = ((full_30 & ~clear_fifo) == 0)? data_in :
    stage_30;

  //data_reg_29, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_29 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_29))
          if (sync_reset & full_29 & !((full_30 == 0) & read & write))
              stage_29 <= 0;
          else 
            stage_29 <= p29_stage_29;
    end


  //control_29, which is an e_mux
  assign p29_full_29 = ((read & !write) == 0)? full_28 :
    full_30;

  //control_reg_29, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_29 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_29 <= 0;
          else 
            full_29 <= p29_full_29;
    end


  //data_28, which is an e_mux
  assign p28_stage_28 = ((full_29 & ~clear_fifo) == 0)? data_in :
    stage_29;

  //data_reg_28, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_28 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_28))
          if (sync_reset & full_28 & !((full_29 == 0) & read & write))
              stage_28 <= 0;
          else 
            stage_28 <= p28_stage_28;
    end


  //control_28, which is an e_mux
  assign p28_full_28 = ((read & !write) == 0)? full_27 :
    full_29;

  //control_reg_28, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_28 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_28 <= 0;
          else 
            full_28 <= p28_full_28;
    end


  //data_27, which is an e_mux
  assign p27_stage_27 = ((full_28 & ~clear_fifo) == 0)? data_in :
    stage_28;

  //data_reg_27, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_27 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_27))
          if (sync_reset & full_27 & !((full_28 == 0) & read & write))
              stage_27 <= 0;
          else 
            stage_27 <= p27_stage_27;
    end


  //control_27, which is an e_mux
  assign p27_full_27 = ((read & !write) == 0)? full_26 :
    full_28;

  //control_reg_27, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_27 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_27 <= 0;
          else 
            full_27 <= p27_full_27;
    end


  //data_26, which is an e_mux
  assign p26_stage_26 = ((full_27 & ~clear_fifo) == 0)? data_in :
    stage_27;

  //data_reg_26, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_26 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_26))
          if (sync_reset & full_26 & !((full_27 == 0) & read & write))
              stage_26 <= 0;
          else 
            stage_26 <= p26_stage_26;
    end


  //control_26, which is an e_mux
  assign p26_full_26 = ((read & !write) == 0)? full_25 :
    full_27;

  //control_reg_26, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_26 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_26 <= 0;
          else 
            full_26 <= p26_full_26;
    end


  //data_25, which is an e_mux
  assign p25_stage_25 = ((full_26 & ~clear_fifo) == 0)? data_in :
    stage_26;

  //data_reg_25, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_25 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_25))
          if (sync_reset & full_25 & !((full_26 == 0) & read & write))
              stage_25 <= 0;
          else 
            stage_25 <= p25_stage_25;
    end


  //control_25, which is an e_mux
  assign p25_full_25 = ((read & !write) == 0)? full_24 :
    full_26;

  //control_reg_25, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_25 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_25 <= 0;
          else 
            full_25 <= p25_full_25;
    end


  //data_24, which is an e_mux
  assign p24_stage_24 = ((full_25 & ~clear_fifo) == 0)? data_in :
    stage_25;

  //data_reg_24, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_24 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_24))
          if (sync_reset & full_24 & !((full_25 == 0) & read & write))
              stage_24 <= 0;
          else 
            stage_24 <= p24_stage_24;
    end


  //control_24, which is an e_mux
  assign p24_full_24 = ((read & !write) == 0)? full_23 :
    full_25;

  //control_reg_24, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_24 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_24 <= 0;
          else 
            full_24 <= p24_full_24;
    end


  //data_23, which is an e_mux
  assign p23_stage_23 = ((full_24 & ~clear_fifo) == 0)? data_in :
    stage_24;

  //data_reg_23, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_23 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_23))
          if (sync_reset & full_23 & !((full_24 == 0) & read & write))
              stage_23 <= 0;
          else 
            stage_23 <= p23_stage_23;
    end


  //control_23, which is an e_mux
  assign p23_full_23 = ((read & !write) == 0)? full_22 :
    full_24;

  //control_reg_23, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_23 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_23 <= 0;
          else 
            full_23 <= p23_full_23;
    end


  //data_22, which is an e_mux
  assign p22_stage_22 = ((full_23 & ~clear_fifo) == 0)? data_in :
    stage_23;

  //data_reg_22, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_22 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_22))
          if (sync_reset & full_22 & !((full_23 == 0) & read & write))
              stage_22 <= 0;
          else 
            stage_22 <= p22_stage_22;
    end


  //control_22, which is an e_mux
  assign p22_full_22 = ((read & !write) == 0)? full_21 :
    full_23;

  //control_reg_22, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_22 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_22 <= 0;
          else 
            full_22 <= p22_full_22;
    end


  //data_21, which is an e_mux
  assign p21_stage_21 = ((full_22 & ~clear_fifo) == 0)? data_in :
    stage_22;

  //data_reg_21, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_21 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_21))
          if (sync_reset & full_21 & !((full_22 == 0) & read & write))
              stage_21 <= 0;
          else 
            stage_21 <= p21_stage_21;
    end


  //control_21, which is an e_mux
  assign p21_full_21 = ((read & !write) == 0)? full_20 :
    full_22;

  //control_reg_21, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_21 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_21 <= 0;
          else 
            full_21 <= p21_full_21;
    end


  //data_20, which is an e_mux
  assign p20_stage_20 = ((full_21 & ~clear_fifo) == 0)? data_in :
    stage_21;

  //data_reg_20, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_20 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_20))
          if (sync_reset & full_20 & !((full_21 == 0) & read & write))
              stage_20 <= 0;
          else 
            stage_20 <= p20_stage_20;
    end


  //control_20, which is an e_mux
  assign p20_full_20 = ((read & !write) == 0)? full_19 :
    full_21;

  //control_reg_20, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_20 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_20 <= 0;
          else 
            full_20 <= p20_full_20;
    end


  //data_19, which is an e_mux
  assign p19_stage_19 = ((full_20 & ~clear_fifo) == 0)? data_in :
    stage_20;

  //data_reg_19, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_19 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_19))
          if (sync_reset & full_19 & !((full_20 == 0) & read & write))
              stage_19 <= 0;
          else 
            stage_19 <= p19_stage_19;
    end


  //control_19, which is an e_mux
  assign p19_full_19 = ((read & !write) == 0)? full_18 :
    full_20;

  //control_reg_19, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_19 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_19 <= 0;
          else 
            full_19 <= p19_full_19;
    end


  //data_18, which is an e_mux
  assign p18_stage_18 = ((full_19 & ~clear_fifo) == 0)? data_in :
    stage_19;

  //data_reg_18, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_18 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_18))
          if (sync_reset & full_18 & !((full_19 == 0) & read & write))
              stage_18 <= 0;
          else 
            stage_18 <= p18_stage_18;
    end


  //control_18, which is an e_mux
  assign p18_full_18 = ((read & !write) == 0)? full_17 :
    full_19;

  //control_reg_18, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_18 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_18 <= 0;
          else 
            full_18 <= p18_full_18;
    end


  //data_17, which is an e_mux
  assign p17_stage_17 = ((full_18 & ~clear_fifo) == 0)? data_in :
    stage_18;

  //data_reg_17, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_17 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_17))
          if (sync_reset & full_17 & !((full_18 == 0) & read & write))
              stage_17 <= 0;
          else 
            stage_17 <= p17_stage_17;
    end


  //control_17, which is an e_mux
  assign p17_full_17 = ((read & !write) == 0)? full_16 :
    full_18;

  //control_reg_17, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_17 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_17 <= 0;
          else 
            full_17 <= p17_full_17;
    end


  //data_16, which is an e_mux
  assign p16_stage_16 = ((full_17 & ~clear_fifo) == 0)? data_in :
    stage_17;

  //data_reg_16, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_16 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_16))
          if (sync_reset & full_16 & !((full_17 == 0) & read & write))
              stage_16 <= 0;
          else 
            stage_16 <= p16_stage_16;
    end


  //control_16, which is an e_mux
  assign p16_full_16 = ((read & !write) == 0)? full_15 :
    full_17;

  //control_reg_16, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_16 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_16 <= 0;
          else 
            full_16 <= p16_full_16;
    end


  //data_15, which is an e_mux
  assign p15_stage_15 = ((full_16 & ~clear_fifo) == 0)? data_in :
    stage_16;

  //data_reg_15, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_15 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_15))
          if (sync_reset & full_15 & !((full_16 == 0) & read & write))
              stage_15 <= 0;
          else 
            stage_15 <= p15_stage_15;
    end


  //control_15, which is an e_mux
  assign p15_full_15 = ((read & !write) == 0)? full_14 :
    full_16;

  //control_reg_15, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_15 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_15 <= 0;
          else 
            full_15 <= p15_full_15;
    end


  //data_14, which is an e_mux
  assign p14_stage_14 = ((full_15 & ~clear_fifo) == 0)? data_in :
    stage_15;

  //data_reg_14, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_14 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_14))
          if (sync_reset & full_14 & !((full_15 == 0) & read & write))
              stage_14 <= 0;
          else 
            stage_14 <= p14_stage_14;
    end


  //control_14, which is an e_mux
  assign p14_full_14 = ((read & !write) == 0)? full_13 :
    full_15;

  //control_reg_14, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_14 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_14 <= 0;
          else 
            full_14 <= p14_full_14;
    end


  //data_13, which is an e_mux
  assign p13_stage_13 = ((full_14 & ~clear_fifo) == 0)? data_in :
    stage_14;

  //data_reg_13, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_13 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_13))
          if (sync_reset & full_13 & !((full_14 == 0) & read & write))
              stage_13 <= 0;
          else 
            stage_13 <= p13_stage_13;
    end


  //control_13, which is an e_mux
  assign p13_full_13 = ((read & !write) == 0)? full_12 :
    full_14;

  //control_reg_13, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_13 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_13 <= 0;
          else 
            full_13 <= p13_full_13;
    end


  //data_12, which is an e_mux
  assign p12_stage_12 = ((full_13 & ~clear_fifo) == 0)? data_in :
    stage_13;

  //data_reg_12, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_12 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_12))
          if (sync_reset & full_12 & !((full_13 == 0) & read & write))
              stage_12 <= 0;
          else 
            stage_12 <= p12_stage_12;
    end


  //control_12, which is an e_mux
  assign p12_full_12 = ((read & !write) == 0)? full_11 :
    full_13;

  //control_reg_12, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_12 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_12 <= 0;
          else 
            full_12 <= p12_full_12;
    end


  //data_11, which is an e_mux
  assign p11_stage_11 = ((full_12 & ~clear_fifo) == 0)? data_in :
    stage_12;

  //data_reg_11, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_11 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_11))
          if (sync_reset & full_11 & !((full_12 == 0) & read & write))
              stage_11 <= 0;
          else 
            stage_11 <= p11_stage_11;
    end


  //control_11, which is an e_mux
  assign p11_full_11 = ((read & !write) == 0)? full_10 :
    full_12;

  //control_reg_11, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_11 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_11 <= 0;
          else 
            full_11 <= p11_full_11;
    end


  //data_10, which is an e_mux
  assign p10_stage_10 = ((full_11 & ~clear_fifo) == 0)? data_in :
    stage_11;

  //data_reg_10, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_10 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_10))
          if (sync_reset & full_10 & !((full_11 == 0) & read & write))
              stage_10 <= 0;
          else 
            stage_10 <= p10_stage_10;
    end


  //control_10, which is an e_mux
  assign p10_full_10 = ((read & !write) == 0)? full_9 :
    full_11;

  //control_reg_10, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_10 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_10 <= 0;
          else 
            full_10 <= p10_full_10;
    end


  //data_9, which is an e_mux
  assign p9_stage_9 = ((full_10 & ~clear_fifo) == 0)? data_in :
    stage_10;

  //data_reg_9, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_9 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_9))
          if (sync_reset & full_9 & !((full_10 == 0) & read & write))
              stage_9 <= 0;
          else 
            stage_9 <= p9_stage_9;
    end


  //control_9, which is an e_mux
  assign p9_full_9 = ((read & !write) == 0)? full_8 :
    full_10;

  //control_reg_9, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_9 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_9 <= 0;
          else 
            full_9 <= p9_full_9;
    end


  //data_8, which is an e_mux
  assign p8_stage_8 = ((full_9 & ~clear_fifo) == 0)? data_in :
    stage_9;

  //data_reg_8, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_8 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_8))
          if (sync_reset & full_8 & !((full_9 == 0) & read & write))
              stage_8 <= 0;
          else 
            stage_8 <= p8_stage_8;
    end


  //control_8, which is an e_mux
  assign p8_full_8 = ((read & !write) == 0)? full_7 :
    full_9;

  //control_reg_8, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_8 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_8 <= 0;
          else 
            full_8 <= p8_full_8;
    end


  //data_7, which is an e_mux
  assign p7_stage_7 = ((full_8 & ~clear_fifo) == 0)? data_in :
    stage_8;

  //data_reg_7, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_7 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_7))
          if (sync_reset & full_7 & !((full_8 == 0) & read & write))
              stage_7 <= 0;
          else 
            stage_7 <= p7_stage_7;
    end


  //control_7, which is an e_mux
  assign p7_full_7 = ((read & !write) == 0)? full_6 :
    full_8;

  //control_reg_7, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_7 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_7 <= 0;
          else 
            full_7 <= p7_full_7;
    end


  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    stage_7;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    full_7;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_crossing_io2_s1_arbitrator (
                                          // inputs:
                                           clk,
                                           clock_crossing_io2_s1_endofpacket,
                                           clock_crossing_io2_s1_readdata,
                                           clock_crossing_io2_s1_readdatavalid,
                                           clock_crossing_io2_s1_waitrequest,
                                           cpu_data_master_address_to_slave,
                                           cpu_data_master_byteenable,
                                           cpu_data_master_latency_counter,
                                           cpu_data_master_read,
                                           cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                                           cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                           cpu_data_master_write,
                                           cpu_data_master_writedata,
                                           reset_n,

                                          // outputs:
                                           clock_crossing_io2_s1_address,
                                           clock_crossing_io2_s1_byteenable,
                                           clock_crossing_io2_s1_endofpacket_from_sa,
                                           clock_crossing_io2_s1_nativeaddress,
                                           clock_crossing_io2_s1_read,
                                           clock_crossing_io2_s1_readdata_from_sa,
                                           clock_crossing_io2_s1_reset_n,
                                           clock_crossing_io2_s1_waitrequest_from_sa,
                                           clock_crossing_io2_s1_write,
                                           clock_crossing_io2_s1_writedata,
                                           cpu_data_master_granted_clock_crossing_io2_s1,
                                           cpu_data_master_qualified_request_clock_crossing_io2_s1,
                                           cpu_data_master_read_data_valid_clock_crossing_io2_s1,
                                           cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                                           cpu_data_master_requests_clock_crossing_io2_s1,
                                           d1_clock_crossing_io2_s1_end_xfer
                                        )
;

  output  [  9: 0] clock_crossing_io2_s1_address;
  output  [  3: 0] clock_crossing_io2_s1_byteenable;
  output           clock_crossing_io2_s1_endofpacket_from_sa;
  output  [  9: 0] clock_crossing_io2_s1_nativeaddress;
  output           clock_crossing_io2_s1_read;
  output  [ 31: 0] clock_crossing_io2_s1_readdata_from_sa;
  output           clock_crossing_io2_s1_reset_n;
  output           clock_crossing_io2_s1_waitrequest_from_sa;
  output           clock_crossing_io2_s1_write;
  output  [ 31: 0] clock_crossing_io2_s1_writedata;
  output           cpu_data_master_granted_clock_crossing_io2_s1;
  output           cpu_data_master_qualified_request_clock_crossing_io2_s1;
  output           cpu_data_master_read_data_valid_clock_crossing_io2_s1;
  output           cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  output           cpu_data_master_requests_clock_crossing_io2_s1;
  output           d1_clock_crossing_io2_s1_end_xfer;
  input            clk;
  input            clock_crossing_io2_s1_endofpacket;
  input   [ 31: 0] clock_crossing_io2_s1_readdata;
  input            clock_crossing_io2_s1_readdatavalid;
  input            clock_crossing_io2_s1_waitrequest;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  9: 0] clock_crossing_io2_s1_address;
  wire             clock_crossing_io2_s1_allgrants;
  wire             clock_crossing_io2_s1_allow_new_arb_cycle;
  wire             clock_crossing_io2_s1_any_bursting_master_saved_grant;
  wire             clock_crossing_io2_s1_any_continuerequest;
  wire             clock_crossing_io2_s1_arb_counter_enable;
  reg     [  1: 0] clock_crossing_io2_s1_arb_share_counter;
  wire    [  1: 0] clock_crossing_io2_s1_arb_share_counter_next_value;
  wire    [  1: 0] clock_crossing_io2_s1_arb_share_set_values;
  wire             clock_crossing_io2_s1_beginbursttransfer_internal;
  wire             clock_crossing_io2_s1_begins_xfer;
  wire    [  3: 0] clock_crossing_io2_s1_byteenable;
  wire             clock_crossing_io2_s1_end_xfer;
  wire             clock_crossing_io2_s1_endofpacket_from_sa;
  wire             clock_crossing_io2_s1_firsttransfer;
  wire             clock_crossing_io2_s1_grant_vector;
  wire             clock_crossing_io2_s1_in_a_read_cycle;
  wire             clock_crossing_io2_s1_in_a_write_cycle;
  wire             clock_crossing_io2_s1_master_qreq_vector;
  wire             clock_crossing_io2_s1_move_on_to_next_transaction;
  wire    [  9: 0] clock_crossing_io2_s1_nativeaddress;
  wire             clock_crossing_io2_s1_non_bursting_master_requests;
  wire             clock_crossing_io2_s1_read;
  wire    [ 31: 0] clock_crossing_io2_s1_readdata_from_sa;
  wire             clock_crossing_io2_s1_readdatavalid_from_sa;
  reg              clock_crossing_io2_s1_reg_firsttransfer;
  wire             clock_crossing_io2_s1_reset_n;
  reg              clock_crossing_io2_s1_slavearbiterlockenable;
  wire             clock_crossing_io2_s1_slavearbiterlockenable2;
  wire             clock_crossing_io2_s1_unreg_firsttransfer;
  wire             clock_crossing_io2_s1_waitrequest_from_sa;
  wire             clock_crossing_io2_s1_waits_for_read;
  wire             clock_crossing_io2_s1_waits_for_write;
  wire             clock_crossing_io2_s1_write;
  wire    [ 31: 0] clock_crossing_io2_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_clock_crossing_io2_s1;
  wire             cpu_data_master_qualified_request_clock_crossing_io2_s1;
  wire             cpu_data_master_rdv_fifo_empty_clock_crossing_io2_s1;
  wire             cpu_data_master_rdv_fifo_output_from_clock_crossing_io2_s1;
  wire             cpu_data_master_read_data_valid_clock_crossing_io2_s1;
  wire             cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  wire             cpu_data_master_requests_clock_crossing_io2_s1;
  wire             cpu_data_master_saved_grant_clock_crossing_io2_s1;
  reg              d1_clock_crossing_io2_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_clock_crossing_io2_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_clock_crossing_io2_s1_from_cpu_data_master;
  wire             wait_for_clock_crossing_io2_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~clock_crossing_io2_s1_end_xfer;
    end


  assign clock_crossing_io2_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_clock_crossing_io2_s1));
  //assign clock_crossing_io2_s1_readdatavalid_from_sa = clock_crossing_io2_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io2_s1_readdatavalid_from_sa = clock_crossing_io2_s1_readdatavalid;

  //assign clock_crossing_io2_s1_readdata_from_sa = clock_crossing_io2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io2_s1_readdata_from_sa = clock_crossing_io2_s1_readdata;

  assign cpu_data_master_requests_clock_crossing_io2_s1 = ({cpu_data_master_address_to_slave[26 : 12] , 12'b0} == 27'h5000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign clock_crossing_io2_s1_waitrequest_from_sa = clock_crossing_io2_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io2_s1_waitrequest_from_sa = clock_crossing_io2_s1_waitrequest;

  //clock_crossing_io2_s1_arb_share_counter set values, which is an e_mux
  assign clock_crossing_io2_s1_arb_share_set_values = 1;

  //clock_crossing_io2_s1_non_bursting_master_requests mux, which is an e_mux
  assign clock_crossing_io2_s1_non_bursting_master_requests = cpu_data_master_requests_clock_crossing_io2_s1;

  //clock_crossing_io2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign clock_crossing_io2_s1_any_bursting_master_saved_grant = 0;

  //clock_crossing_io2_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign clock_crossing_io2_s1_arb_share_counter_next_value = clock_crossing_io2_s1_firsttransfer ? (clock_crossing_io2_s1_arb_share_set_values - 1) : |clock_crossing_io2_s1_arb_share_counter ? (clock_crossing_io2_s1_arb_share_counter - 1) : 0;

  //clock_crossing_io2_s1_allgrants all slave grants, which is an e_mux
  assign clock_crossing_io2_s1_allgrants = |clock_crossing_io2_s1_grant_vector;

  //clock_crossing_io2_s1_end_xfer assignment, which is an e_assign
  assign clock_crossing_io2_s1_end_xfer = ~(clock_crossing_io2_s1_waits_for_read | clock_crossing_io2_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_clock_crossing_io2_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_clock_crossing_io2_s1 = clock_crossing_io2_s1_end_xfer & (~clock_crossing_io2_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //clock_crossing_io2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign clock_crossing_io2_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_clock_crossing_io2_s1 & clock_crossing_io2_s1_allgrants) | (end_xfer_arb_share_counter_term_clock_crossing_io2_s1 & ~clock_crossing_io2_s1_non_bursting_master_requests);

  //clock_crossing_io2_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_s1_arb_share_counter <= 0;
      else if (clock_crossing_io2_s1_arb_counter_enable)
          clock_crossing_io2_s1_arb_share_counter <= clock_crossing_io2_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_s1_slavearbiterlockenable <= 0;
      else if ((|clock_crossing_io2_s1_master_qreq_vector & end_xfer_arb_share_counter_term_clock_crossing_io2_s1) | (end_xfer_arb_share_counter_term_clock_crossing_io2_s1 & ~clock_crossing_io2_s1_non_bursting_master_requests))
          clock_crossing_io2_s1_slavearbiterlockenable <= |clock_crossing_io2_s1_arb_share_counter_next_value;
    end


  //cpu/data_master clock_crossing_io2/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = clock_crossing_io2_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //clock_crossing_io2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign clock_crossing_io2_s1_slavearbiterlockenable2 = |clock_crossing_io2_s1_arb_share_counter_next_value;

  //cpu/data_master clock_crossing_io2/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = clock_crossing_io2_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //clock_crossing_io2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign clock_crossing_io2_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_clock_crossing_io2_s1 = cpu_data_master_requests_clock_crossing_io2_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))));
  //unique name for clock_crossing_io2_s1_move_on_to_next_transaction, which is an e_assign
  assign clock_crossing_io2_s1_move_on_to_next_transaction = clock_crossing_io2_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_clock_crossing_io2_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_clock_crossing_io2_s1_module rdv_fifo_for_cpu_data_master_to_clock_crossing_io2_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_clock_crossing_io2_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_clock_crossing_io2_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_clock_crossing_io2_s1),
      .full                 (),
      .read                 (clock_crossing_io2_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~clock_crossing_io2_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_clock_crossing_io2_s1;
  //local readdatavalid cpu_data_master_read_data_valid_clock_crossing_io2_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_clock_crossing_io2_s1 = clock_crossing_io2_s1_readdatavalid_from_sa;

  //clock_crossing_io2_s1_writedata mux, which is an e_mux
  assign clock_crossing_io2_s1_writedata = cpu_data_master_writedata;

  //assign clock_crossing_io2_s1_endofpacket_from_sa = clock_crossing_io2_s1_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_crossing_io2_s1_endofpacket_from_sa = clock_crossing_io2_s1_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_clock_crossing_io2_s1 = cpu_data_master_qualified_request_clock_crossing_io2_s1;

  //cpu/data_master saved-grant clock_crossing_io2/s1, which is an e_assign
  assign cpu_data_master_saved_grant_clock_crossing_io2_s1 = cpu_data_master_requests_clock_crossing_io2_s1;

  //allow new arb cycle for clock_crossing_io2/s1, which is an e_assign
  assign clock_crossing_io2_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign clock_crossing_io2_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign clock_crossing_io2_s1_master_qreq_vector = 1;

  //clock_crossing_io2_s1_reset_n assignment, which is an e_assign
  assign clock_crossing_io2_s1_reset_n = reset_n;

  //clock_crossing_io2_s1_firsttransfer first transaction, which is an e_assign
  assign clock_crossing_io2_s1_firsttransfer = clock_crossing_io2_s1_begins_xfer ? clock_crossing_io2_s1_unreg_firsttransfer : clock_crossing_io2_s1_reg_firsttransfer;

  //clock_crossing_io2_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign clock_crossing_io2_s1_unreg_firsttransfer = ~(clock_crossing_io2_s1_slavearbiterlockenable & clock_crossing_io2_s1_any_continuerequest);

  //clock_crossing_io2_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_s1_reg_firsttransfer <= 1'b1;
      else if (clock_crossing_io2_s1_begins_xfer)
          clock_crossing_io2_s1_reg_firsttransfer <= clock_crossing_io2_s1_unreg_firsttransfer;
    end


  //clock_crossing_io2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign clock_crossing_io2_s1_beginbursttransfer_internal = clock_crossing_io2_s1_begins_xfer;

  //clock_crossing_io2_s1_read assignment, which is an e_mux
  assign clock_crossing_io2_s1_read = cpu_data_master_granted_clock_crossing_io2_s1 & cpu_data_master_read;

  //clock_crossing_io2_s1_write assignment, which is an e_mux
  assign clock_crossing_io2_s1_write = cpu_data_master_granted_clock_crossing_io2_s1 & cpu_data_master_write;

  assign shifted_address_to_clock_crossing_io2_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //clock_crossing_io2_s1_address mux, which is an e_mux
  assign clock_crossing_io2_s1_address = shifted_address_to_clock_crossing_io2_s1_from_cpu_data_master >> 2;

  //slaveid clock_crossing_io2_s1_nativeaddress nativeaddress mux, which is an e_mux
  assign clock_crossing_io2_s1_nativeaddress = cpu_data_master_address_to_slave >> 2;

  //d1_clock_crossing_io2_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_clock_crossing_io2_s1_end_xfer <= 1;
      else 
        d1_clock_crossing_io2_s1_end_xfer <= clock_crossing_io2_s1_end_xfer;
    end


  //clock_crossing_io2_s1_waits_for_read in a cycle, which is an e_mux
  assign clock_crossing_io2_s1_waits_for_read = clock_crossing_io2_s1_in_a_read_cycle & clock_crossing_io2_s1_waitrequest_from_sa;

  //clock_crossing_io2_s1_in_a_read_cycle assignment, which is an e_assign
  assign clock_crossing_io2_s1_in_a_read_cycle = cpu_data_master_granted_clock_crossing_io2_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = clock_crossing_io2_s1_in_a_read_cycle;

  //clock_crossing_io2_s1_waits_for_write in a cycle, which is an e_mux
  assign clock_crossing_io2_s1_waits_for_write = clock_crossing_io2_s1_in_a_write_cycle & clock_crossing_io2_s1_waitrequest_from_sa;

  //clock_crossing_io2_s1_in_a_write_cycle assignment, which is an e_assign
  assign clock_crossing_io2_s1_in_a_write_cycle = cpu_data_master_granted_clock_crossing_io2_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = clock_crossing_io2_s1_in_a_write_cycle;

  assign wait_for_clock_crossing_io2_s1_counter = 0;
  //clock_crossing_io2_s1_byteenable byte enable port mux, which is an e_mux
  assign clock_crossing_io2_s1_byteenable = (cpu_data_master_granted_clock_crossing_io2_s1)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_crossing_io2/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_crossing_io2_m1_arbitrator (
                                          // inputs:
                                           clk,
                                           clock_crossing_io2_m1_address,
                                           clock_crossing_io2_m1_byteenable,
                                           clock_crossing_io2_m1_granted_epcs_epcs_control_port,
                                           clock_crossing_io2_m1_granted_gsensor_spi_slave,
                                           clock_crossing_io2_m1_granted_i2c_scl_s1,
                                           clock_crossing_io2_m1_granted_i2c_sda_s1,
                                           clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port,
                                           clock_crossing_io2_m1_qualified_request_gsensor_spi_slave,
                                           clock_crossing_io2_m1_qualified_request_i2c_scl_s1,
                                           clock_crossing_io2_m1_qualified_request_i2c_sda_s1,
                                           clock_crossing_io2_m1_read,
                                           clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port,
                                           clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave,
                                           clock_crossing_io2_m1_read_data_valid_i2c_scl_s1,
                                           clock_crossing_io2_m1_read_data_valid_i2c_sda_s1,
                                           clock_crossing_io2_m1_requests_epcs_epcs_control_port,
                                           clock_crossing_io2_m1_requests_gsensor_spi_slave,
                                           clock_crossing_io2_m1_requests_i2c_scl_s1,
                                           clock_crossing_io2_m1_requests_i2c_sda_s1,
                                           clock_crossing_io2_m1_write,
                                           clock_crossing_io2_m1_writedata,
                                           d1_epcs_epcs_control_port_end_xfer,
                                           d1_gsensor_spi_slave_end_xfer,
                                           d1_i2c_scl_s1_end_xfer,
                                           d1_i2c_sda_s1_end_xfer,
                                           epcs_epcs_control_port_endofpacket_from_sa,
                                           epcs_epcs_control_port_readdata_from_sa,
                                           gsensor_spi_slave_readdata_from_sa,
                                           i2c_scl_s1_readdata_from_sa,
                                           i2c_sda_s1_readdata_from_sa,
                                           reset_n,

                                          // outputs:
                                           clock_crossing_io2_m1_address_to_slave,
                                           clock_crossing_io2_m1_endofpacket,
                                           clock_crossing_io2_m1_latency_counter,
                                           clock_crossing_io2_m1_readdata,
                                           clock_crossing_io2_m1_readdatavalid,
                                           clock_crossing_io2_m1_reset_n,
                                           clock_crossing_io2_m1_waitrequest
                                        )
;

  output  [ 11: 0] clock_crossing_io2_m1_address_to_slave;
  output           clock_crossing_io2_m1_endofpacket;
  output           clock_crossing_io2_m1_latency_counter;
  output  [ 31: 0] clock_crossing_io2_m1_readdata;
  output           clock_crossing_io2_m1_readdatavalid;
  output           clock_crossing_io2_m1_reset_n;
  output           clock_crossing_io2_m1_waitrequest;
  input            clk;
  input   [ 11: 0] clock_crossing_io2_m1_address;
  input   [  3: 0] clock_crossing_io2_m1_byteenable;
  input            clock_crossing_io2_m1_granted_epcs_epcs_control_port;
  input            clock_crossing_io2_m1_granted_gsensor_spi_slave;
  input            clock_crossing_io2_m1_granted_i2c_scl_s1;
  input            clock_crossing_io2_m1_granted_i2c_sda_s1;
  input            clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port;
  input            clock_crossing_io2_m1_qualified_request_gsensor_spi_slave;
  input            clock_crossing_io2_m1_qualified_request_i2c_scl_s1;
  input            clock_crossing_io2_m1_qualified_request_i2c_sda_s1;
  input            clock_crossing_io2_m1_read;
  input            clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port;
  input            clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave;
  input            clock_crossing_io2_m1_read_data_valid_i2c_scl_s1;
  input            clock_crossing_io2_m1_read_data_valid_i2c_sda_s1;
  input            clock_crossing_io2_m1_requests_epcs_epcs_control_port;
  input            clock_crossing_io2_m1_requests_gsensor_spi_slave;
  input            clock_crossing_io2_m1_requests_i2c_scl_s1;
  input            clock_crossing_io2_m1_requests_i2c_sda_s1;
  input            clock_crossing_io2_m1_write;
  input   [ 31: 0] clock_crossing_io2_m1_writedata;
  input            d1_epcs_epcs_control_port_end_xfer;
  input            d1_gsensor_spi_slave_end_xfer;
  input            d1_i2c_scl_s1_end_xfer;
  input            d1_i2c_sda_s1_end_xfer;
  input            epcs_epcs_control_port_endofpacket_from_sa;
  input   [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  input   [  7: 0] gsensor_spi_slave_readdata_from_sa;
  input            i2c_scl_s1_readdata_from_sa;
  input            i2c_sda_s1_readdata_from_sa;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [ 11: 0] clock_crossing_io2_m1_address_last_time;
  wire    [ 11: 0] clock_crossing_io2_m1_address_to_slave;
  reg     [  3: 0] clock_crossing_io2_m1_byteenable_last_time;
  wire             clock_crossing_io2_m1_endofpacket;
  wire             clock_crossing_io2_m1_is_granted_some_slave;
  reg              clock_crossing_io2_m1_latency_counter;
  reg              clock_crossing_io2_m1_read_but_no_slave_selected;
  reg              clock_crossing_io2_m1_read_last_time;
  wire    [ 31: 0] clock_crossing_io2_m1_readdata;
  wire             clock_crossing_io2_m1_readdatavalid;
  wire             clock_crossing_io2_m1_reset_n;
  wire             clock_crossing_io2_m1_run;
  wire             clock_crossing_io2_m1_waitrequest;
  reg              clock_crossing_io2_m1_write_last_time;
  reg     [ 31: 0] clock_crossing_io2_m1_writedata_last_time;
  wire             latency_load_value;
  wire             p1_clock_crossing_io2_m1_latency_counter;
  wire             pre_flush_clock_crossing_io2_m1_readdatavalid;
  wire             r_1;
  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port | ~clock_crossing_io2_m1_requests_epcs_epcs_control_port) & ((~clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port | ~(clock_crossing_io2_m1_read | clock_crossing_io2_m1_write) | (1 & ~d1_epcs_epcs_control_port_end_xfer & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write)))) & ((~clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port | ~(clock_crossing_io2_m1_read | clock_crossing_io2_m1_write) | (1 & ~d1_epcs_epcs_control_port_end_xfer & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write)))) & 1 & (clock_crossing_io2_m1_qualified_request_gsensor_spi_slave | ~clock_crossing_io2_m1_requests_gsensor_spi_slave) & ((~clock_crossing_io2_m1_qualified_request_gsensor_spi_slave | ~(clock_crossing_io2_m1_read | clock_crossing_io2_m1_write) | (1 & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write)))) & ((~clock_crossing_io2_m1_qualified_request_gsensor_spi_slave | ~(clock_crossing_io2_m1_read | clock_crossing_io2_m1_write) | (1 & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write)))) & 1 & (clock_crossing_io2_m1_qualified_request_i2c_scl_s1 | ~clock_crossing_io2_m1_requests_i2c_scl_s1) & ((~clock_crossing_io2_m1_qualified_request_i2c_scl_s1 | ~clock_crossing_io2_m1_read | (1 & ~d1_i2c_scl_s1_end_xfer & clock_crossing_io2_m1_read))) & ((~clock_crossing_io2_m1_qualified_request_i2c_scl_s1 | ~clock_crossing_io2_m1_write | (1 & clock_crossing_io2_m1_write))) & 1 & (clock_crossing_io2_m1_qualified_request_i2c_sda_s1 | ~clock_crossing_io2_m1_requests_i2c_sda_s1) & ((~clock_crossing_io2_m1_qualified_request_i2c_sda_s1 | ~clock_crossing_io2_m1_read | (1 & ~d1_i2c_sda_s1_end_xfer & clock_crossing_io2_m1_read))) & ((~clock_crossing_io2_m1_qualified_request_i2c_sda_s1 | ~clock_crossing_io2_m1_write | (1 & clock_crossing_io2_m1_write)));

  //cascaded wait assignment, which is an e_assign
  assign clock_crossing_io2_m1_run = r_1;

  //optimize select-logic by passing only those address bits which matter.
  assign clock_crossing_io2_m1_address_to_slave = clock_crossing_io2_m1_address[11 : 0];

  //clock_crossing_io2_m1_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_read_but_no_slave_selected <= 0;
      else 
        clock_crossing_io2_m1_read_but_no_slave_selected <= clock_crossing_io2_m1_read & clock_crossing_io2_m1_run & ~clock_crossing_io2_m1_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign clock_crossing_io2_m1_is_granted_some_slave = clock_crossing_io2_m1_granted_epcs_epcs_control_port |
    clock_crossing_io2_m1_granted_gsensor_spi_slave |
    clock_crossing_io2_m1_granted_i2c_scl_s1 |
    clock_crossing_io2_m1_granted_i2c_sda_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_clock_crossing_io2_m1_readdatavalid = clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign clock_crossing_io2_m1_readdatavalid = clock_crossing_io2_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io2_m1_readdatavalid |
    clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port |
    clock_crossing_io2_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io2_m1_readdatavalid |
    clock_crossing_io2_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io2_m1_readdatavalid |
    clock_crossing_io2_m1_read_data_valid_i2c_scl_s1 |
    clock_crossing_io2_m1_read_but_no_slave_selected |
    pre_flush_clock_crossing_io2_m1_readdatavalid |
    clock_crossing_io2_m1_read_data_valid_i2c_sda_s1;

  //clock_crossing_io2/m1 readdata mux, which is an e_mux
  assign clock_crossing_io2_m1_readdata = ({32 {~(clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port & clock_crossing_io2_m1_read)}} | epcs_epcs_control_port_readdata_from_sa) &
    ({32 {~clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave}} | gsensor_spi_slave_readdata_from_sa) &
    ({32 {~(clock_crossing_io2_m1_qualified_request_i2c_scl_s1 & clock_crossing_io2_m1_read)}} | i2c_scl_s1_readdata_from_sa) &
    ({32 {~(clock_crossing_io2_m1_qualified_request_i2c_sda_s1 & clock_crossing_io2_m1_read)}} | i2c_sda_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign clock_crossing_io2_m1_waitrequest = ~clock_crossing_io2_m1_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_latency_counter <= 0;
      else 
        clock_crossing_io2_m1_latency_counter <= p1_clock_crossing_io2_m1_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_clock_crossing_io2_m1_latency_counter = ((clock_crossing_io2_m1_run & clock_crossing_io2_m1_read))? latency_load_value :
    (clock_crossing_io2_m1_latency_counter)? clock_crossing_io2_m1_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = {1 {clock_crossing_io2_m1_requests_gsensor_spi_slave}} & 1;

  //clock_crossing_io2_m1_reset_n assignment, which is an e_assign
  assign clock_crossing_io2_m1_reset_n = reset_n;

  //mux clock_crossing_io2_m1_endofpacket, which is an e_mux
  assign clock_crossing_io2_m1_endofpacket = epcs_epcs_control_port_endofpacket_from_sa;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_crossing_io2_m1_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_address_last_time <= 0;
      else 
        clock_crossing_io2_m1_address_last_time <= clock_crossing_io2_m1_address;
    end


  //clock_crossing_io2/m1 waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= clock_crossing_io2_m1_waitrequest & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write);
    end


  //clock_crossing_io2_m1_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io2_m1_address != clock_crossing_io2_m1_address_last_time))
        begin
          $write("%0d ns: clock_crossing_io2_m1_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io2_m1_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_byteenable_last_time <= 0;
      else 
        clock_crossing_io2_m1_byteenable_last_time <= clock_crossing_io2_m1_byteenable;
    end


  //clock_crossing_io2_m1_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io2_m1_byteenable != clock_crossing_io2_m1_byteenable_last_time))
        begin
          $write("%0d ns: clock_crossing_io2_m1_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io2_m1_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_read_last_time <= 0;
      else 
        clock_crossing_io2_m1_read_last_time <= clock_crossing_io2_m1_read;
    end


  //clock_crossing_io2_m1_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io2_m1_read != clock_crossing_io2_m1_read_last_time))
        begin
          $write("%0d ns: clock_crossing_io2_m1_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io2_m1_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_write_last_time <= 0;
      else 
        clock_crossing_io2_m1_write_last_time <= clock_crossing_io2_m1_write;
    end


  //clock_crossing_io2_m1_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io2_m1_write != clock_crossing_io2_m1_write_last_time))
        begin
          $write("%0d ns: clock_crossing_io2_m1_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_crossing_io2_m1_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_writedata_last_time <= 0;
      else 
        clock_crossing_io2_m1_writedata_last_time <= clock_crossing_io2_m1_writedata;
    end


  //clock_crossing_io2_m1_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (clock_crossing_io2_m1_writedata != clock_crossing_io2_m1_writedata_last_time) & clock_crossing_io2_m1_write)
        begin
          $write("%0d ns: clock_crossing_io2_m1_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_crossing_io2_bridge_arbitrator 
;



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_jtag_debug_module_arbitrator (
                                          // inputs:
                                           clk,
                                           cpu_data_master_address_to_slave,
                                           cpu_data_master_byteenable,
                                           cpu_data_master_debugaccess,
                                           cpu_data_master_latency_counter,
                                           cpu_data_master_read,
                                           cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                                           cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                                           cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                           cpu_data_master_write,
                                           cpu_data_master_writedata,
                                           cpu_instruction_master_address_to_slave,
                                           cpu_instruction_master_latency_counter,
                                           cpu_instruction_master_read,
                                           cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                           cpu_jtag_debug_module_readdata,
                                           cpu_jtag_debug_module_resetrequest,
                                           reset_n,

                                          // outputs:
                                           cpu_data_master_granted_cpu_jtag_debug_module,
                                           cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_data_master_requests_cpu_jtag_debug_module,
                                           cpu_instruction_master_granted_cpu_jtag_debug_module,
                                           cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_instruction_master_requests_cpu_jtag_debug_module,
                                           cpu_jtag_debug_module_address,
                                           cpu_jtag_debug_module_begintransfer,
                                           cpu_jtag_debug_module_byteenable,
                                           cpu_jtag_debug_module_chipselect,
                                           cpu_jtag_debug_module_debugaccess,
                                           cpu_jtag_debug_module_readdata_from_sa,
                                           cpu_jtag_debug_module_reset_n,
                                           cpu_jtag_debug_module_resetrequest_from_sa,
                                           cpu_jtag_debug_module_write,
                                           cpu_jtag_debug_module_writedata,
                                           d1_cpu_jtag_debug_module_end_xfer
                                        )
;

  output           cpu_data_master_granted_cpu_jtag_debug_module;
  output           cpu_data_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_data_master_requests_cpu_jtag_debug_module;
  output           cpu_instruction_master_granted_cpu_jtag_debug_module;
  output           cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_instruction_master_requests_cpu_jtag_debug_module;
  output  [  8: 0] cpu_jtag_debug_module_address;
  output           cpu_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_jtag_debug_module_byteenable;
  output           cpu_jtag_debug_module_chipselect;
  output           cpu_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  output           cpu_jtag_debug_module_reset_n;
  output           cpu_jtag_debug_module_resetrequest_from_sa;
  output           cpu_jtag_debug_module_write;
  output  [ 31: 0] cpu_jtag_debug_module_writedata;
  output           d1_cpu_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_debugaccess;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input   [ 31: 0] cpu_jtag_debug_module_readdata;
  input            cpu_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_saved_grant_cpu_jtag_debug_module;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_saved_grant_cpu_jtag_debug_module;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_allgrants;
  wire             cpu_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_jtag_debug_module_arb_addend;
  wire             cpu_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_jtag_debug_module_arb_winner;
  wire             cpu_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_jtag_debug_module_begins_xfer;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_jtag_debug_module_debugaccess;
  wire             cpu_jtag_debug_module_end_xfer;
  wire             cpu_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_jtag_debug_module_grant_vector;
  wire             cpu_jtag_debug_module_in_a_read_cycle;
  wire             cpu_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_jtag_debug_module_master_qreq_vector;
  wire             cpu_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  reg              cpu_jtag_debug_module_reg_firsttransfer;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_jtag_debug_module_waits_for_read;
  wire             cpu_jtag_debug_module_waits_for_write;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  reg              d1_cpu_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
  reg              last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
  wire    [ 26: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master;
  wire             wait_for_cpu_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_jtag_debug_module_end_xfer;
    end


  assign cpu_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_cpu_jtag_debug_module | cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  //assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata;

  assign cpu_data_master_requests_cpu_jtag_debug_module = ({cpu_data_master_address_to_slave[26 : 11] , 11'b0} == 27'h6000800) & (cpu_data_master_read | cpu_data_master_write);
  //cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_jtag_debug_module_arb_share_set_values = 1;

  //cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_jtag_debug_module_non_bursting_master_requests = cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module |
    cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_jtag_debug_module_arb_share_counter_next_value = cpu_jtag_debug_module_firsttransfer ? (cpu_jtag_debug_module_arb_share_set_values - 1) : |cpu_jtag_debug_module_arb_share_counter ? (cpu_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_jtag_debug_module_allgrants = (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector);

  //cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_jtag_debug_module_end_xfer = ~(cpu_jtag_debug_module_waits_for_read | cpu_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_jtag_debug_module = cpu_jtag_debug_module_end_xfer & (~cpu_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & cpu_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests);

  //cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_jtag_debug_module_arb_counter_enable)
          cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests))
          cpu_jtag_debug_module_slavearbiterlockenable <= |cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_data_master_continuerequest;

  //cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_jtag_debug_module_slavearbiterlockenable2 = |cpu_jtag_debug_module_arb_share_counter_next_value;

  //cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= cpu_instruction_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_instruction_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module & cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_jtag_debug_module_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_cpu_jtag_debug_module = cpu_data_master_requests_cpu_jtag_debug_module & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register) | (|cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))) | cpu_instruction_master_arbiterlock);
  //local readdatavalid cpu_data_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_data_master_read_data_valid_cpu_jtag_debug_module = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //cpu_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_jtag_debug_module_writedata = cpu_data_master_writedata;

  assign cpu_instruction_master_requests_cpu_jtag_debug_module = (({cpu_instruction_master_address_to_slave[26 : 11] , 11'b0} == 27'h6000800) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= cpu_data_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_data_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module & cpu_data_master_requests_cpu_jtag_debug_module;

  assign cpu_instruction_master_qualified_request_cpu_jtag_debug_module = cpu_instruction_master_requests_cpu_jtag_debug_module & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (|cpu_instruction_master_read_data_valid_sdram_s1_shift_register))) | cpu_data_master_arbiterlock);
  //local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_instruction_master_read_data_valid_cpu_jtag_debug_module = cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[0] = cpu_instruction_master_qualified_request_cpu_jtag_debug_module;

  //cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[0];

  //cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[0] && cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[1] = cpu_data_master_qualified_request_cpu_jtag_debug_module;

  //cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[1];

  //cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[1] && cpu_data_master_requests_cpu_jtag_debug_module;

  //cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_double_vector = {cpu_jtag_debug_module_master_qreq_vector, cpu_jtag_debug_module_master_qreq_vector} & ({~cpu_jtag_debug_module_master_qreq_vector, ~cpu_jtag_debug_module_master_qreq_vector} + cpu_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_jtag_debug_module_arb_winner = (cpu_jtag_debug_module_allow_new_arb_cycle & | cpu_jtag_debug_module_grant_vector) ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_jtag_debug_module_allow_new_arb_cycle)
          cpu_jtag_debug_module_saved_chosen_master_vector <= |cpu_jtag_debug_module_grant_vector ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_jtag_debug_module_grant_vector = {(cpu_jtag_debug_module_chosen_master_double_vector[1] | cpu_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_jtag_debug_module_chosen_master_double_vector[0] | cpu_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_rot_left = (cpu_jtag_debug_module_arb_winner << 1) ? (cpu_jtag_debug_module_arb_winner << 1) : 1;

  //cpu/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_jtag_debug_module_grant_vector)
          cpu_jtag_debug_module_arb_addend <= cpu_jtag_debug_module_end_xfer? cpu_jtag_debug_module_chosen_master_rot_left : cpu_jtag_debug_module_grant_vector;
    end


  assign cpu_jtag_debug_module_begintransfer = cpu_jtag_debug_module_begins_xfer;
  //cpu_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_jtag_debug_module_reset_n = reset_n;

  //assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest;

  assign cpu_jtag_debug_module_chipselect = cpu_data_master_granted_cpu_jtag_debug_module | cpu_instruction_master_granted_cpu_jtag_debug_module;
  //cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_firsttransfer = cpu_jtag_debug_module_begins_xfer ? cpu_jtag_debug_module_unreg_firsttransfer : cpu_jtag_debug_module_reg_firsttransfer;

  //cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_unreg_firsttransfer = ~(cpu_jtag_debug_module_slavearbiterlockenable & cpu_jtag_debug_module_any_continuerequest);

  //cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_jtag_debug_module_begins_xfer)
          cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_jtag_debug_module_beginbursttransfer_internal = cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_jtag_debug_module_arbitration_holdoff_internal = cpu_jtag_debug_module_begins_xfer & cpu_jtag_debug_module_firsttransfer;

  //cpu_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_jtag_debug_module_write = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master = cpu_data_master_address_to_slave;
  //cpu_jtag_debug_module_address mux, which is an e_mux
  assign cpu_jtag_debug_module_address = (cpu_data_master_granted_cpu_jtag_debug_module)? (shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master >> 2) :
    (shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master >> 2);

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end


  //cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_read = cpu_jtag_debug_module_in_a_read_cycle & cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_read_cycle = (cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read) | (cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_jtag_debug_module_in_a_read_cycle;

  //cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_write = cpu_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_write_cycle = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_jtag_debug_module_counter = 0;
  //cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_jtag_debug_module_byteenable = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_jtag_debug_module_debugaccess = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_cpu_jtag_debug_module + cpu_instruction_master_granted_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_cpu_jtag_debug_module + cpu_instruction_master_saved_grant_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module epcs_epcs_control_port_irq_from_sa_clock_crossing_cpu_data_master_module (
                                                                                  // inputs:
                                                                                   clk,
                                                                                   data_in,
                                                                                   reset_n,

                                                                                  // outputs:
                                                                                   data_out
                                                                                )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module g_sensor_int_s1_irq_from_sa_clock_crossing_cpu_data_master_module (
                                                                           // inputs:
                                                                            clk,
                                                                            data_in,
                                                                            reset_n,

                                                                           // outputs:
                                                                            data_out
                                                                         )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module key_s1_irq_from_sa_clock_crossing_cpu_data_master_module (
                                                                  // inputs:
                                                                   clk,
                                                                   data_in,
                                                                   reset_n,

                                                                  // outputs:
                                                                   data_out
                                                                )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sw_s1_irq_from_sa_clock_crossing_cpu_data_master_module (
                                                                 // inputs:
                                                                  clk,
                                                                  data_in,
                                                                  reset_n,

                                                                 // outputs:
                                                                  data_out
                                                               )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_s1_irq_from_sa_clock_crossing_cpu_data_master_module (
                                                                    // inputs:
                                                                     clk,
                                                                     data_in,
                                                                     reset_n,

                                                                    // outputs:
                                                                     data_out
                                                                  )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_data_master_arbitrator (
                                    // inputs:
                                     DE0_Nano_SOPC_clock_0_in_readdata_from_sa,
                                     DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa,
                                     DE0_Nano_SOPC_clock_1_in_readdata_from_sa,
                                     DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa,
                                     altpll_sys,
                                     altpll_sys_reset_n,
                                     clk,
                                     clock_crossing_io2_s1_readdata_from_sa,
                                     clock_crossing_io2_s1_waitrequest_from_sa,
                                     clock_crossing_io_s1_readdata_from_sa,
                                     clock_crossing_io_s1_waitrequest_from_sa,
                                     cpu_data_master_address,
                                     cpu_data_master_byteenable,
                                     cpu_data_master_byteenable_sdram_s1,
                                     cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in,
                                     cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in,
                                     cpu_data_master_granted_clock_crossing_io2_s1,
                                     cpu_data_master_granted_clock_crossing_io_s1,
                                     cpu_data_master_granted_cpu_jtag_debug_module,
                                     cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_granted_sdram_s1,
                                     cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in,
                                     cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in,
                                     cpu_data_master_qualified_request_clock_crossing_io2_s1,
                                     cpu_data_master_qualified_request_clock_crossing_io_s1,
                                     cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                     cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_qualified_request_sdram_s1,
                                     cpu_data_master_read,
                                     cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in,
                                     cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in,
                                     cpu_data_master_read_data_valid_clock_crossing_io2_s1,
                                     cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                                     cpu_data_master_read_data_valid_clock_crossing_io_s1,
                                     cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                                     cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                     cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_read_data_valid_sdram_s1,
                                     cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                     cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in,
                                     cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in,
                                     cpu_data_master_requests_clock_crossing_io2_s1,
                                     cpu_data_master_requests_clock_crossing_io_s1,
                                     cpu_data_master_requests_cpu_jtag_debug_module,
                                     cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_requests_sdram_s1,
                                     cpu_data_master_write,
                                     cpu_data_master_writedata,
                                     cpu_jtag_debug_module_readdata_from_sa,
                                     d1_DE0_Nano_SOPC_clock_0_in_end_xfer,
                                     d1_DE0_Nano_SOPC_clock_1_in_end_xfer,
                                     d1_clock_crossing_io2_s1_end_xfer,
                                     d1_clock_crossing_io_s1_end_xfer,
                                     d1_cpu_jtag_debug_module_end_xfer,
                                     d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                     d1_sdram_s1_end_xfer,
                                     epcs_epcs_control_port_irq_from_sa,
                                     g_sensor_int_s1_irq_from_sa,
                                     jtag_uart_avalon_jtag_slave_irq_from_sa,
                                     jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                     jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                     key_s1_irq_from_sa,
                                     reset_n,
                                     sdram_s1_readdata_from_sa,
                                     sdram_s1_waitrequest_from_sa,
                                     sw_s1_irq_from_sa,
                                     timer_s1_irq_from_sa,

                                    // outputs:
                                     cpu_data_master_address_to_slave,
                                     cpu_data_master_dbs_address,
                                     cpu_data_master_dbs_write_16,
                                     cpu_data_master_irq,
                                     cpu_data_master_latency_counter,
                                     cpu_data_master_readdata,
                                     cpu_data_master_readdatavalid,
                                     cpu_data_master_waitrequest
                                  )
;

  output  [ 26: 0] cpu_data_master_address_to_slave;
  output  [  1: 0] cpu_data_master_dbs_address;
  output  [ 15: 0] cpu_data_master_dbs_write_16;
  output  [ 31: 0] cpu_data_master_irq;
  output           cpu_data_master_latency_counter;
  output  [ 31: 0] cpu_data_master_readdata;
  output           cpu_data_master_readdatavalid;
  output           cpu_data_master_waitrequest;
  input   [ 31: 0] DE0_Nano_SOPC_clock_0_in_readdata_from_sa;
  input            DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa;
  input   [ 15: 0] DE0_Nano_SOPC_clock_1_in_readdata_from_sa;
  input            DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa;
  input            altpll_sys;
  input            altpll_sys_reset_n;
  input            clk;
  input   [ 31: 0] clock_crossing_io2_s1_readdata_from_sa;
  input            clock_crossing_io2_s1_waitrequest_from_sa;
  input   [ 31: 0] clock_crossing_io_s1_readdata_from_sa;
  input            clock_crossing_io_s1_waitrequest_from_sa;
  input   [ 26: 0] cpu_data_master_address;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_byteenable_sdram_s1;
  input            cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in;
  input            cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in;
  input            cpu_data_master_granted_clock_crossing_io2_s1;
  input            cpu_data_master_granted_clock_crossing_io_s1;
  input            cpu_data_master_granted_cpu_jtag_debug_module;
  input            cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_granted_sdram_s1;
  input            cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in;
  input            cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in;
  input            cpu_data_master_qualified_request_clock_crossing_io2_s1;
  input            cpu_data_master_qualified_request_clock_crossing_io_s1;
  input            cpu_data_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_qualified_request_sdram_s1;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in;
  input            cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  input            cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_read_data_valid_sdram_s1;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in;
  input            cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in;
  input            cpu_data_master_requests_clock_crossing_io2_s1;
  input            cpu_data_master_requests_clock_crossing_io_s1;
  input            cpu_data_master_requests_cpu_jtag_debug_module;
  input            cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_requests_sdram_s1;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_DE0_Nano_SOPC_clock_0_in_end_xfer;
  input            d1_DE0_Nano_SOPC_clock_1_in_end_xfer;
  input            d1_clock_crossing_io2_s1_end_xfer;
  input            d1_clock_crossing_io_s1_end_xfer;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_jtag_uart_avalon_jtag_slave_end_xfer;
  input            d1_sdram_s1_end_xfer;
  input            epcs_epcs_control_port_irq_from_sa;
  input            g_sensor_int_s1_irq_from_sa;
  input            jtag_uart_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  input            key_s1_irq_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata_from_sa;
  input            sdram_s1_waitrequest_from_sa;
  input            sw_s1_irq_from_sa;
  input            timer_s1_irq_from_sa;

  reg              active_and_waiting_last_time;
  wire             altpll_sys_epcs_epcs_control_port_irq_from_sa;
  wire             altpll_sys_g_sensor_int_s1_irq_from_sa;
  wire             altpll_sys_key_s1_irq_from_sa;
  wire             altpll_sys_sw_s1_irq_from_sa;
  wire             altpll_sys_timer_s1_irq_from_sa;
  reg     [ 26: 0] cpu_data_master_address_last_time;
  wire    [ 26: 0] cpu_data_master_address_to_slave;
  reg     [  3: 0] cpu_data_master_byteenable_last_time;
  reg     [  1: 0] cpu_data_master_dbs_address;
  wire    [  1: 0] cpu_data_master_dbs_increment;
  reg     [  1: 0] cpu_data_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_data_master_dbs_rdv_counter_inc;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_data_master_irq;
  wire             cpu_data_master_is_granted_some_slave;
  reg              cpu_data_master_latency_counter;
  wire    [  1: 0] cpu_data_master_next_dbs_rdv_counter;
  reg              cpu_data_master_read_but_no_slave_selected;
  reg              cpu_data_master_read_last_time;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_readdatavalid;
  wire             cpu_data_master_run;
  wire             cpu_data_master_waitrequest;
  reg              cpu_data_master_write_last_time;
  reg     [ 31: 0] cpu_data_master_writedata_last_time;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_data_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_data_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in | ~cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in) & ((~cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in | ~cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in) & ((~cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_clock_crossing_io_s1 | ~cpu_data_master_requests_clock_crossing_io_s1) & ((~cpu_data_master_qualified_request_clock_crossing_io_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_crossing_io_s1_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_clock_crossing_io_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_crossing_io_s1_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_clock_crossing_io2_s1 | ~cpu_data_master_requests_clock_crossing_io2_s1) & ((~cpu_data_master_qualified_request_clock_crossing_io2_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_crossing_io2_s1_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_clock_crossing_io2_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_crossing_io2_s1_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_requests_cpu_jtag_debug_module) & (cpu_data_master_granted_cpu_jtag_debug_module | ~cpu_data_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_data_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_data_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~cpu_data_master_requests_jtag_uart_avalon_jtag_slave) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_sdram_s1 | (cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_sdram_s1) & (cpu_data_master_granted_sdram_s1 | ~cpu_data_master_qualified_request_sdram_s1) & ((~cpu_data_master_qualified_request_sdram_s1 | ~cpu_data_master_read | (1 & ~sdram_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sdram_s1 | ~cpu_data_master_write | (1 & ~sdram_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_data_master_address_to_slave = cpu_data_master_address[26 : 0];

  //cpu_data_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_but_no_slave_selected <= 0;
      else 
        cpu_data_master_read_but_no_slave_selected <= cpu_data_master_read & cpu_data_master_run & ~cpu_data_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_data_master_is_granted_some_slave = cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in |
    cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in |
    cpu_data_master_granted_clock_crossing_io_s1 |
    cpu_data_master_granted_clock_crossing_io2_s1 |
    cpu_data_master_granted_cpu_jtag_debug_module |
    cpu_data_master_granted_jtag_uart_avalon_jtag_slave |
    cpu_data_master_granted_sdram_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_data_master_readdatavalid = cpu_data_master_read_data_valid_clock_crossing_io_s1 |
    cpu_data_master_read_data_valid_clock_crossing_io2_s1 |
    (cpu_data_master_read_data_valid_sdram_s1 & dbs_rdv_counter_overflow);

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_data_master_readdatavalid = cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_cpu_jtag_debug_module |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid;

  //cpu/data_master readdata mux, which is an e_mux
  assign cpu_data_master_readdata = ({32 {~(cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in & cpu_data_master_read)}} | DE0_Nano_SOPC_clock_0_in_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in & cpu_data_master_read)}} | DE0_Nano_SOPC_clock_1_in_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_clock_crossing_io_s1}} | clock_crossing_io_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_clock_crossing_io2_s1}} | clock_crossing_io2_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_cpu_jtag_debug_module & cpu_data_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave & cpu_data_master_read)}} | jtag_uart_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_sdram_s1}} | {sdram_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_data_master_waitrequest = ~cpu_data_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_latency_counter <= 0;
      else 
        cpu_data_master_latency_counter <= p1_cpu_data_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_data_master_latency_counter = ((cpu_data_master_run & cpu_data_master_read))? latency_load_value :
    (cpu_data_master_latency_counter)? cpu_data_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //epcs_epcs_control_port_irq_from_sa from clk_50 to altpll_sys
  epcs_epcs_control_port_irq_from_sa_clock_crossing_cpu_data_master_module epcs_epcs_control_port_irq_from_sa_clock_crossing_cpu_data_master
    (
      .clk      (altpll_sys),
      .data_in  (epcs_epcs_control_port_irq_from_sa),
      .data_out (altpll_sys_epcs_epcs_control_port_irq_from_sa),
      .reset_n  (altpll_sys_reset_n)
    );

  //irq assign, which is an e_assign
  assign cpu_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    jtag_uart_avalon_jtag_slave_irq_from_sa,
    altpll_sys_epcs_epcs_control_port_irq_from_sa,
    altpll_sys_g_sensor_int_s1_irq_from_sa,
    altpll_sys_sw_s1_irq_from_sa,
    altpll_sys_key_s1_irq_from_sa,
    altpll_sys_timer_s1_irq_from_sa};

  //g_sensor_int_s1_irq_from_sa from altpll_io to altpll_sys
  g_sensor_int_s1_irq_from_sa_clock_crossing_cpu_data_master_module g_sensor_int_s1_irq_from_sa_clock_crossing_cpu_data_master
    (
      .clk      (altpll_sys),
      .data_in  (g_sensor_int_s1_irq_from_sa),
      .data_out (altpll_sys_g_sensor_int_s1_irq_from_sa),
      .reset_n  (altpll_sys_reset_n)
    );

  //key_s1_irq_from_sa from altpll_io to altpll_sys
  key_s1_irq_from_sa_clock_crossing_cpu_data_master_module key_s1_irq_from_sa_clock_crossing_cpu_data_master
    (
      .clk      (altpll_sys),
      .data_in  (key_s1_irq_from_sa),
      .data_out (altpll_sys_key_s1_irq_from_sa),
      .reset_n  (altpll_sys_reset_n)
    );

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~0) & cpu_data_master_requests_sdram_s1 & cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1)) |
    (cpu_data_master_granted_sdram_s1 & cpu_data_master_read & 1 & 1 & ~sdram_s1_waitrequest_from_sa) |
    (cpu_data_master_granted_sdram_s1 & cpu_data_master_write & 1 & 1 & ~sdram_s1_waitrequest_from_sa);

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = sdram_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_data_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_data_master_dbs_write_16 = (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    cpu_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_data_master_dbs_increment = (cpu_data_master_requests_sdram_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_data_master_dbs_address + cpu_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_data_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_data_master_next_dbs_rdv_counter = cpu_data_master_dbs_rdv_counter + cpu_data_master_dbs_rdv_counter_inc;

  //cpu_data_master_rdv_inc_mux, which is an e_mux
  assign cpu_data_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_data_master_read_data_valid_sdram_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_data_master_dbs_rdv_counter <= cpu_data_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_data_master_dbs_rdv_counter[1] & ~cpu_data_master_next_dbs_rdv_counter[1];

  //sw_s1_irq_from_sa from altpll_io to altpll_sys
  sw_s1_irq_from_sa_clock_crossing_cpu_data_master_module sw_s1_irq_from_sa_clock_crossing_cpu_data_master
    (
      .clk      (altpll_sys),
      .data_in  (sw_s1_irq_from_sa),
      .data_out (altpll_sys_sw_s1_irq_from_sa),
      .reset_n  (altpll_sys_reset_n)
    );

  //timer_s1_irq_from_sa from altpll_io to altpll_sys
  timer_s1_irq_from_sa_clock_crossing_cpu_data_master_module timer_s1_irq_from_sa_clock_crossing_cpu_data_master
    (
      .clk      (altpll_sys),
      .data_in  (timer_s1_irq_from_sa),
      .data_out (altpll_sys_timer_s1_irq_from_sa),
      .reset_n  (altpll_sys_reset_n)
    );


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_data_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_address_last_time <= 0;
      else 
        cpu_data_master_address_last_time <= cpu_data_master_address;
    end


  //cpu/data_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_data_master_waitrequest & (cpu_data_master_read | cpu_data_master_write);
    end


  //cpu_data_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_address != cpu_data_master_address_last_time))
        begin
          $write("%0d ns: cpu_data_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_byteenable_last_time <= 0;
      else 
        cpu_data_master_byteenable_last_time <= cpu_data_master_byteenable;
    end


  //cpu_data_master_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_byteenable != cpu_data_master_byteenable_last_time))
        begin
          $write("%0d ns: cpu_data_master_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_last_time <= 0;
      else 
        cpu_data_master_read_last_time <= cpu_data_master_read;
    end


  //cpu_data_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_read != cpu_data_master_read_last_time))
        begin
          $write("%0d ns: cpu_data_master_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_write_last_time <= 0;
      else 
        cpu_data_master_write_last_time <= cpu_data_master_write;
    end


  //cpu_data_master_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_write != cpu_data_master_write_last_time))
        begin
          $write("%0d ns: cpu_data_master_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_writedata_last_time <= 0;
      else 
        cpu_data_master_writedata_last_time <= cpu_data_master_writedata;
    end


  //cpu_data_master_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_writedata != cpu_data_master_writedata_last_time) & cpu_data_master_write)
        begin
          $write("%0d ns: cpu_data_master_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_instruction_master_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_instruction_master_address,
                                            cpu_instruction_master_granted_cpu_jtag_debug_module,
                                            cpu_instruction_master_granted_sdram_s1,
                                            cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                            cpu_instruction_master_qualified_request_sdram_s1,
                                            cpu_instruction_master_read,
                                            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                            cpu_instruction_master_read_data_valid_sdram_s1,
                                            cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                            cpu_instruction_master_requests_cpu_jtag_debug_module,
                                            cpu_instruction_master_requests_sdram_s1,
                                            cpu_jtag_debug_module_readdata_from_sa,
                                            d1_cpu_jtag_debug_module_end_xfer,
                                            d1_sdram_s1_end_xfer,
                                            reset_n,
                                            sdram_s1_readdata_from_sa,
                                            sdram_s1_waitrequest_from_sa,

                                           // outputs:
                                            cpu_instruction_master_address_to_slave,
                                            cpu_instruction_master_dbs_address,
                                            cpu_instruction_master_latency_counter,
                                            cpu_instruction_master_readdata,
                                            cpu_instruction_master_readdatavalid,
                                            cpu_instruction_master_waitrequest
                                         )
;

  output  [ 26: 0] cpu_instruction_master_address_to_slave;
  output  [  1: 0] cpu_instruction_master_dbs_address;
  output           cpu_instruction_master_latency_counter;
  output  [ 31: 0] cpu_instruction_master_readdata;
  output           cpu_instruction_master_readdatavalid;
  output           cpu_instruction_master_waitrequest;
  input            clk;
  input   [ 26: 0] cpu_instruction_master_address;
  input            cpu_instruction_master_granted_cpu_jtag_debug_module;
  input            cpu_instruction_master_granted_sdram_s1;
  input            cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_instruction_master_qualified_request_sdram_s1;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_instruction_master_read_data_valid_sdram_s1;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_instruction_master_requests_cpu_jtag_debug_module;
  input            cpu_instruction_master_requests_sdram_s1;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_sdram_s1_end_xfer;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata_from_sa;
  input            sdram_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 26: 0] cpu_instruction_master_address_last_time;
  wire    [ 26: 0] cpu_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_instruction_master_dbs_address;
  wire    [  1: 0] cpu_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_instruction_master_is_granted_some_slave;
  reg              cpu_instruction_master_latency_counter;
  wire    [  1: 0] cpu_instruction_master_next_dbs_rdv_counter;
  reg              cpu_instruction_master_read_but_no_slave_selected;
  reg              cpu_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_run;
  wire             cpu_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_instruction_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_requests_cpu_jtag_debug_module) & (cpu_instruction_master_granted_cpu_jtag_debug_module | ~cpu_instruction_master_qualified_request_cpu_jtag_debug_module);

  //cascaded wait assignment, which is an e_assign
  assign cpu_instruction_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = ((~cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_instruction_master_read))) & 1 & (cpu_instruction_master_qualified_request_sdram_s1 | ~cpu_instruction_master_requests_sdram_s1) & (cpu_instruction_master_granted_sdram_s1 | ~cpu_instruction_master_qualified_request_sdram_s1) & ((~cpu_instruction_master_qualified_request_sdram_s1 | ~cpu_instruction_master_read | (1 & ~sdram_s1_waitrequest_from_sa & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_instruction_master_address_to_slave = {cpu_instruction_master_address[26],
    1'b1,
    cpu_instruction_master_address[24 : 0]};

  //cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_instruction_master_read_but_no_slave_selected <= cpu_instruction_master_read & cpu_instruction_master_run & ~cpu_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_instruction_master_is_granted_some_slave = cpu_instruction_master_granted_cpu_jtag_debug_module |
    cpu_instruction_master_granted_sdram_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_instruction_master_readdatavalid = cpu_instruction_master_read_data_valid_sdram_s1 & dbs_rdv_counter_overflow;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_instruction_master_readdatavalid = cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_data_valid_cpu_jtag_debug_module |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid;

  //cpu/instruction_master readdata mux, which is an e_mux
  assign cpu_instruction_master_readdata = ({32 {~(cpu_instruction_master_qualified_request_cpu_jtag_debug_module & cpu_instruction_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_instruction_master_read_data_valid_sdram_s1}} | {sdram_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_instruction_master_waitrequest = ~cpu_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_latency_counter <= 0;
      else 
        cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_instruction_master_latency_counter = ((cpu_instruction_master_run & cpu_instruction_master_read))? latency_load_value :
    (cpu_instruction_master_latency_counter)? cpu_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = sdram_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_instruction_master_dbs_increment = (cpu_instruction_master_requests_sdram_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_instruction_master_dbs_address + cpu_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_instruction_master_next_dbs_rdv_counter = cpu_instruction_master_dbs_rdv_counter + cpu_instruction_master_dbs_rdv_counter_inc;

  //cpu_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_instruction_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_instruction_master_read_data_valid_sdram_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_instruction_master_dbs_rdv_counter <= cpu_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_instruction_master_dbs_rdv_counter[1] & ~cpu_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read & 1 & 1 & ~sdram_s1_waitrequest_from_sa;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_address_last_time <= 0;
      else 
        cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
    end


  //cpu/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_instruction_master_waitrequest & (cpu_instruction_master_read);
    end


  //cpu_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_address != cpu_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_last_time <= 0;
      else 
        cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
    end


  //cpu_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_read != cpu_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module epcs_epcs_control_port_arbitrator (
                                           // inputs:
                                            clk,
                                            clock_crossing_io2_m1_address_to_slave,
                                            clock_crossing_io2_m1_latency_counter,
                                            clock_crossing_io2_m1_read,
                                            clock_crossing_io2_m1_write,
                                            clock_crossing_io2_m1_writedata,
                                            epcs_epcs_control_port_dataavailable,
                                            epcs_epcs_control_port_endofpacket,
                                            epcs_epcs_control_port_irq,
                                            epcs_epcs_control_port_readdata,
                                            epcs_epcs_control_port_readyfordata,
                                            reset_n,

                                           // outputs:
                                            clock_crossing_io2_m1_granted_epcs_epcs_control_port,
                                            clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port,
                                            clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port,
                                            clock_crossing_io2_m1_requests_epcs_epcs_control_port,
                                            d1_epcs_epcs_control_port_end_xfer,
                                            epcs_epcs_control_port_address,
                                            epcs_epcs_control_port_chipselect,
                                            epcs_epcs_control_port_dataavailable_from_sa,
                                            epcs_epcs_control_port_endofpacket_from_sa,
                                            epcs_epcs_control_port_irq_from_sa,
                                            epcs_epcs_control_port_read_n,
                                            epcs_epcs_control_port_readdata_from_sa,
                                            epcs_epcs_control_port_readyfordata_from_sa,
                                            epcs_epcs_control_port_reset_n,
                                            epcs_epcs_control_port_write_n,
                                            epcs_epcs_control_port_writedata
                                         )
;

  output           clock_crossing_io2_m1_granted_epcs_epcs_control_port;
  output           clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port;
  output           clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port;
  output           clock_crossing_io2_m1_requests_epcs_epcs_control_port;
  output           d1_epcs_epcs_control_port_end_xfer;
  output  [  8: 0] epcs_epcs_control_port_address;
  output           epcs_epcs_control_port_chipselect;
  output           epcs_epcs_control_port_dataavailable_from_sa;
  output           epcs_epcs_control_port_endofpacket_from_sa;
  output           epcs_epcs_control_port_irq_from_sa;
  output           epcs_epcs_control_port_read_n;
  output  [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  output           epcs_epcs_control_port_readyfordata_from_sa;
  output           epcs_epcs_control_port_reset_n;
  output           epcs_epcs_control_port_write_n;
  output  [ 31: 0] epcs_epcs_control_port_writedata;
  input            clk;
  input   [ 11: 0] clock_crossing_io2_m1_address_to_slave;
  input            clock_crossing_io2_m1_latency_counter;
  input            clock_crossing_io2_m1_read;
  input            clock_crossing_io2_m1_write;
  input   [ 31: 0] clock_crossing_io2_m1_writedata;
  input            epcs_epcs_control_port_dataavailable;
  input            epcs_epcs_control_port_endofpacket;
  input            epcs_epcs_control_port_irq;
  input   [ 31: 0] epcs_epcs_control_port_readdata;
  input            epcs_epcs_control_port_readyfordata;
  input            reset_n;

  wire             clock_crossing_io2_m1_arbiterlock;
  wire             clock_crossing_io2_m1_arbiterlock2;
  wire             clock_crossing_io2_m1_continuerequest;
  wire             clock_crossing_io2_m1_granted_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_requests_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_saved_grant_epcs_epcs_control_port;
  reg              d1_epcs_epcs_control_port_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_epcs_epcs_control_port;
  wire    [  8: 0] epcs_epcs_control_port_address;
  wire             epcs_epcs_control_port_allgrants;
  wire             epcs_epcs_control_port_allow_new_arb_cycle;
  wire             epcs_epcs_control_port_any_bursting_master_saved_grant;
  wire             epcs_epcs_control_port_any_continuerequest;
  wire             epcs_epcs_control_port_arb_counter_enable;
  reg              epcs_epcs_control_port_arb_share_counter;
  wire             epcs_epcs_control_port_arb_share_counter_next_value;
  wire             epcs_epcs_control_port_arb_share_set_values;
  wire             epcs_epcs_control_port_beginbursttransfer_internal;
  wire             epcs_epcs_control_port_begins_xfer;
  wire             epcs_epcs_control_port_chipselect;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_end_xfer;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_firsttransfer;
  wire             epcs_epcs_control_port_grant_vector;
  wire             epcs_epcs_control_port_in_a_read_cycle;
  wire             epcs_epcs_control_port_in_a_write_cycle;
  wire             epcs_epcs_control_port_irq_from_sa;
  wire             epcs_epcs_control_port_master_qreq_vector;
  wire             epcs_epcs_control_port_non_bursting_master_requests;
  wire             epcs_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  reg              epcs_epcs_control_port_reg_firsttransfer;
  wire             epcs_epcs_control_port_reset_n;
  reg              epcs_epcs_control_port_slavearbiterlockenable;
  wire             epcs_epcs_control_port_slavearbiterlockenable2;
  wire             epcs_epcs_control_port_unreg_firsttransfer;
  wire             epcs_epcs_control_port_waits_for_read;
  wire             epcs_epcs_control_port_waits_for_write;
  wire             epcs_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_epcs_control_port_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 11: 0] shifted_address_to_epcs_epcs_control_port_from_clock_crossing_io2_m1;
  wire             wait_for_epcs_epcs_control_port_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~epcs_epcs_control_port_end_xfer;
    end


  assign epcs_epcs_control_port_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port));
  //assign epcs_epcs_control_port_readdata_from_sa = epcs_epcs_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_readdata_from_sa = epcs_epcs_control_port_readdata;

  assign clock_crossing_io2_m1_requests_epcs_epcs_control_port = ({clock_crossing_io2_m1_address_to_slave[11] , 11'b0} == 12'h0) & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write);
  //assign epcs_epcs_control_port_dataavailable_from_sa = epcs_epcs_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_dataavailable_from_sa = epcs_epcs_control_port_dataavailable;

  //assign epcs_epcs_control_port_readyfordata_from_sa = epcs_epcs_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_readyfordata_from_sa = epcs_epcs_control_port_readyfordata;

  //epcs_epcs_control_port_arb_share_counter set values, which is an e_mux
  assign epcs_epcs_control_port_arb_share_set_values = 1;

  //epcs_epcs_control_port_non_bursting_master_requests mux, which is an e_mux
  assign epcs_epcs_control_port_non_bursting_master_requests = clock_crossing_io2_m1_requests_epcs_epcs_control_port;

  //epcs_epcs_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  assign epcs_epcs_control_port_any_bursting_master_saved_grant = 0;

  //epcs_epcs_control_port_arb_share_counter_next_value assignment, which is an e_assign
  assign epcs_epcs_control_port_arb_share_counter_next_value = epcs_epcs_control_port_firsttransfer ? (epcs_epcs_control_port_arb_share_set_values - 1) : |epcs_epcs_control_port_arb_share_counter ? (epcs_epcs_control_port_arb_share_counter - 1) : 0;

  //epcs_epcs_control_port_allgrants all slave grants, which is an e_mux
  assign epcs_epcs_control_port_allgrants = |epcs_epcs_control_port_grant_vector;

  //epcs_epcs_control_port_end_xfer assignment, which is an e_assign
  assign epcs_epcs_control_port_end_xfer = ~(epcs_epcs_control_port_waits_for_read | epcs_epcs_control_port_waits_for_write);

  //end_xfer_arb_share_counter_term_epcs_epcs_control_port arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_epcs_epcs_control_port = epcs_epcs_control_port_end_xfer & (~epcs_epcs_control_port_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //epcs_epcs_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  assign epcs_epcs_control_port_arb_counter_enable = (end_xfer_arb_share_counter_term_epcs_epcs_control_port & epcs_epcs_control_port_allgrants) | (end_xfer_arb_share_counter_term_epcs_epcs_control_port & ~epcs_epcs_control_port_non_bursting_master_requests);

  //epcs_epcs_control_port_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_arb_share_counter <= 0;
      else if (epcs_epcs_control_port_arb_counter_enable)
          epcs_epcs_control_port_arb_share_counter <= epcs_epcs_control_port_arb_share_counter_next_value;
    end


  //epcs_epcs_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_slavearbiterlockenable <= 0;
      else if ((|epcs_epcs_control_port_master_qreq_vector & end_xfer_arb_share_counter_term_epcs_epcs_control_port) | (end_xfer_arb_share_counter_term_epcs_epcs_control_port & ~epcs_epcs_control_port_non_bursting_master_requests))
          epcs_epcs_control_port_slavearbiterlockenable <= |epcs_epcs_control_port_arb_share_counter_next_value;
    end


  //clock_crossing_io2/m1 epcs/epcs_control_port arbiterlock, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock = epcs_epcs_control_port_slavearbiterlockenable & clock_crossing_io2_m1_continuerequest;

  //epcs_epcs_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign epcs_epcs_control_port_slavearbiterlockenable2 = |epcs_epcs_control_port_arb_share_counter_next_value;

  //clock_crossing_io2/m1 epcs/epcs_control_port arbiterlock2, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock2 = epcs_epcs_control_port_slavearbiterlockenable2 & clock_crossing_io2_m1_continuerequest;

  //epcs_epcs_control_port_any_continuerequest at least one master continues requesting, which is an e_assign
  assign epcs_epcs_control_port_any_continuerequest = 1;

  //clock_crossing_io2_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io2_m1_continuerequest = 1;

  assign clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port = clock_crossing_io2_m1_requests_epcs_epcs_control_port & ~((clock_crossing_io2_m1_read & ((clock_crossing_io2_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port, which is an e_mux
  assign clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port = clock_crossing_io2_m1_granted_epcs_epcs_control_port & clock_crossing_io2_m1_read & ~epcs_epcs_control_port_waits_for_read;

  //epcs_epcs_control_port_writedata mux, which is an e_mux
  assign epcs_epcs_control_port_writedata = clock_crossing_io2_m1_writedata;

  //assign epcs_epcs_control_port_endofpacket_from_sa = epcs_epcs_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_endofpacket_from_sa = epcs_epcs_control_port_endofpacket;

  //master is always granted when requested
  assign clock_crossing_io2_m1_granted_epcs_epcs_control_port = clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port;

  //clock_crossing_io2/m1 saved-grant epcs/epcs_control_port, which is an e_assign
  assign clock_crossing_io2_m1_saved_grant_epcs_epcs_control_port = clock_crossing_io2_m1_requests_epcs_epcs_control_port;

  //allow new arb cycle for epcs/epcs_control_port, which is an e_assign
  assign epcs_epcs_control_port_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign epcs_epcs_control_port_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign epcs_epcs_control_port_master_qreq_vector = 1;

  //epcs_epcs_control_port_reset_n assignment, which is an e_assign
  assign epcs_epcs_control_port_reset_n = reset_n;

  assign epcs_epcs_control_port_chipselect = clock_crossing_io2_m1_granted_epcs_epcs_control_port;
  //epcs_epcs_control_port_firsttransfer first transaction, which is an e_assign
  assign epcs_epcs_control_port_firsttransfer = epcs_epcs_control_port_begins_xfer ? epcs_epcs_control_port_unreg_firsttransfer : epcs_epcs_control_port_reg_firsttransfer;

  //epcs_epcs_control_port_unreg_firsttransfer first transaction, which is an e_assign
  assign epcs_epcs_control_port_unreg_firsttransfer = ~(epcs_epcs_control_port_slavearbiterlockenable & epcs_epcs_control_port_any_continuerequest);

  //epcs_epcs_control_port_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_reg_firsttransfer <= 1'b1;
      else if (epcs_epcs_control_port_begins_xfer)
          epcs_epcs_control_port_reg_firsttransfer <= epcs_epcs_control_port_unreg_firsttransfer;
    end


  //epcs_epcs_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign epcs_epcs_control_port_beginbursttransfer_internal = epcs_epcs_control_port_begins_xfer;

  //~epcs_epcs_control_port_read_n assignment, which is an e_mux
  assign epcs_epcs_control_port_read_n = ~(clock_crossing_io2_m1_granted_epcs_epcs_control_port & clock_crossing_io2_m1_read);

  //~epcs_epcs_control_port_write_n assignment, which is an e_mux
  assign epcs_epcs_control_port_write_n = ~(clock_crossing_io2_m1_granted_epcs_epcs_control_port & clock_crossing_io2_m1_write);

  assign shifted_address_to_epcs_epcs_control_port_from_clock_crossing_io2_m1 = clock_crossing_io2_m1_address_to_slave;
  //epcs_epcs_control_port_address mux, which is an e_mux
  assign epcs_epcs_control_port_address = shifted_address_to_epcs_epcs_control_port_from_clock_crossing_io2_m1 >> 2;

  //d1_epcs_epcs_control_port_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_epcs_epcs_control_port_end_xfer <= 1;
      else 
        d1_epcs_epcs_control_port_end_xfer <= epcs_epcs_control_port_end_xfer;
    end


  //epcs_epcs_control_port_waits_for_read in a cycle, which is an e_mux
  assign epcs_epcs_control_port_waits_for_read = epcs_epcs_control_port_in_a_read_cycle & epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_in_a_read_cycle assignment, which is an e_assign
  assign epcs_epcs_control_port_in_a_read_cycle = clock_crossing_io2_m1_granted_epcs_epcs_control_port & clock_crossing_io2_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = epcs_epcs_control_port_in_a_read_cycle;

  //epcs_epcs_control_port_waits_for_write in a cycle, which is an e_mux
  assign epcs_epcs_control_port_waits_for_write = epcs_epcs_control_port_in_a_write_cycle & epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_in_a_write_cycle assignment, which is an e_assign
  assign epcs_epcs_control_port_in_a_write_cycle = clock_crossing_io2_m1_granted_epcs_epcs_control_port & clock_crossing_io2_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = epcs_epcs_control_port_in_a_write_cycle;

  assign wait_for_epcs_epcs_control_port_counter = 0;
  //assign epcs_epcs_control_port_irq_from_sa = epcs_epcs_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_irq_from_sa = epcs_epcs_control_port_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //epcs/epcs_control_port enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module g_sensor_int_s1_arbitrator (
                                    // inputs:
                                     clk,
                                     clock_crossing_io_m1_address_to_slave,
                                     clock_crossing_io_m1_latency_counter,
                                     clock_crossing_io_m1_nativeaddress,
                                     clock_crossing_io_m1_read,
                                     clock_crossing_io_m1_write,
                                     clock_crossing_io_m1_writedata,
                                     g_sensor_int_s1_irq,
                                     g_sensor_int_s1_readdata,
                                     reset_n,

                                    // outputs:
                                     clock_crossing_io_m1_granted_g_sensor_int_s1,
                                     clock_crossing_io_m1_qualified_request_g_sensor_int_s1,
                                     clock_crossing_io_m1_read_data_valid_g_sensor_int_s1,
                                     clock_crossing_io_m1_requests_g_sensor_int_s1,
                                     d1_g_sensor_int_s1_end_xfer,
                                     g_sensor_int_s1_address,
                                     g_sensor_int_s1_chipselect,
                                     g_sensor_int_s1_irq_from_sa,
                                     g_sensor_int_s1_readdata_from_sa,
                                     g_sensor_int_s1_reset_n,
                                     g_sensor_int_s1_write_n,
                                     g_sensor_int_s1_writedata
                                  )
;

  output           clock_crossing_io_m1_granted_g_sensor_int_s1;
  output           clock_crossing_io_m1_qualified_request_g_sensor_int_s1;
  output           clock_crossing_io_m1_read_data_valid_g_sensor_int_s1;
  output           clock_crossing_io_m1_requests_g_sensor_int_s1;
  output           d1_g_sensor_int_s1_end_xfer;
  output  [  1: 0] g_sensor_int_s1_address;
  output           g_sensor_int_s1_chipselect;
  output           g_sensor_int_s1_irq_from_sa;
  output           g_sensor_int_s1_readdata_from_sa;
  output           g_sensor_int_s1_reset_n;
  output           g_sensor_int_s1_write_n;
  output           g_sensor_int_s1_writedata;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address_to_slave;
  input            clock_crossing_io_m1_latency_counter;
  input   [  4: 0] clock_crossing_io_m1_nativeaddress;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_write;
  input   [ 31: 0] clock_crossing_io_m1_writedata;
  input            g_sensor_int_s1_irq;
  input            g_sensor_int_s1_readdata;
  input            reset_n;

  wire             clock_crossing_io_m1_arbiterlock;
  wire             clock_crossing_io_m1_arbiterlock2;
  wire             clock_crossing_io_m1_continuerequest;
  wire             clock_crossing_io_m1_granted_g_sensor_int_s1;
  wire             clock_crossing_io_m1_qualified_request_g_sensor_int_s1;
  wire             clock_crossing_io_m1_read_data_valid_g_sensor_int_s1;
  wire             clock_crossing_io_m1_requests_g_sensor_int_s1;
  wire             clock_crossing_io_m1_saved_grant_g_sensor_int_s1;
  reg              d1_g_sensor_int_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_g_sensor_int_s1;
  wire    [  1: 0] g_sensor_int_s1_address;
  wire             g_sensor_int_s1_allgrants;
  wire             g_sensor_int_s1_allow_new_arb_cycle;
  wire             g_sensor_int_s1_any_bursting_master_saved_grant;
  wire             g_sensor_int_s1_any_continuerequest;
  wire             g_sensor_int_s1_arb_counter_enable;
  reg              g_sensor_int_s1_arb_share_counter;
  wire             g_sensor_int_s1_arb_share_counter_next_value;
  wire             g_sensor_int_s1_arb_share_set_values;
  wire             g_sensor_int_s1_beginbursttransfer_internal;
  wire             g_sensor_int_s1_begins_xfer;
  wire             g_sensor_int_s1_chipselect;
  wire             g_sensor_int_s1_end_xfer;
  wire             g_sensor_int_s1_firsttransfer;
  wire             g_sensor_int_s1_grant_vector;
  wire             g_sensor_int_s1_in_a_read_cycle;
  wire             g_sensor_int_s1_in_a_write_cycle;
  wire             g_sensor_int_s1_irq_from_sa;
  wire             g_sensor_int_s1_master_qreq_vector;
  wire             g_sensor_int_s1_non_bursting_master_requests;
  wire             g_sensor_int_s1_readdata_from_sa;
  reg              g_sensor_int_s1_reg_firsttransfer;
  wire             g_sensor_int_s1_reset_n;
  reg              g_sensor_int_s1_slavearbiterlockenable;
  wire             g_sensor_int_s1_slavearbiterlockenable2;
  wire             g_sensor_int_s1_unreg_firsttransfer;
  wire             g_sensor_int_s1_waits_for_read;
  wire             g_sensor_int_s1_waits_for_write;
  wire             g_sensor_int_s1_write_n;
  wire             g_sensor_int_s1_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             wait_for_g_sensor_int_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~g_sensor_int_s1_end_xfer;
    end


  assign g_sensor_int_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io_m1_qualified_request_g_sensor_int_s1));
  //assign g_sensor_int_s1_readdata_from_sa = g_sensor_int_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign g_sensor_int_s1_readdata_from_sa = g_sensor_int_s1_readdata;

  assign clock_crossing_io_m1_requests_g_sensor_int_s1 = ({clock_crossing_io_m1_address_to_slave[6 : 4] , 4'b0} == 7'h50) & (clock_crossing_io_m1_read | clock_crossing_io_m1_write);
  //g_sensor_int_s1_arb_share_counter set values, which is an e_mux
  assign g_sensor_int_s1_arb_share_set_values = 1;

  //g_sensor_int_s1_non_bursting_master_requests mux, which is an e_mux
  assign g_sensor_int_s1_non_bursting_master_requests = clock_crossing_io_m1_requests_g_sensor_int_s1;

  //g_sensor_int_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign g_sensor_int_s1_any_bursting_master_saved_grant = 0;

  //g_sensor_int_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign g_sensor_int_s1_arb_share_counter_next_value = g_sensor_int_s1_firsttransfer ? (g_sensor_int_s1_arb_share_set_values - 1) : |g_sensor_int_s1_arb_share_counter ? (g_sensor_int_s1_arb_share_counter - 1) : 0;

  //g_sensor_int_s1_allgrants all slave grants, which is an e_mux
  assign g_sensor_int_s1_allgrants = |g_sensor_int_s1_grant_vector;

  //g_sensor_int_s1_end_xfer assignment, which is an e_assign
  assign g_sensor_int_s1_end_xfer = ~(g_sensor_int_s1_waits_for_read | g_sensor_int_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_g_sensor_int_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_g_sensor_int_s1 = g_sensor_int_s1_end_xfer & (~g_sensor_int_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //g_sensor_int_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign g_sensor_int_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_g_sensor_int_s1 & g_sensor_int_s1_allgrants) | (end_xfer_arb_share_counter_term_g_sensor_int_s1 & ~g_sensor_int_s1_non_bursting_master_requests);

  //g_sensor_int_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          g_sensor_int_s1_arb_share_counter <= 0;
      else if (g_sensor_int_s1_arb_counter_enable)
          g_sensor_int_s1_arb_share_counter <= g_sensor_int_s1_arb_share_counter_next_value;
    end


  //g_sensor_int_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          g_sensor_int_s1_slavearbiterlockenable <= 0;
      else if ((|g_sensor_int_s1_master_qreq_vector & end_xfer_arb_share_counter_term_g_sensor_int_s1) | (end_xfer_arb_share_counter_term_g_sensor_int_s1 & ~g_sensor_int_s1_non_bursting_master_requests))
          g_sensor_int_s1_slavearbiterlockenable <= |g_sensor_int_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io/m1 g_sensor_int/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock = g_sensor_int_s1_slavearbiterlockenable & clock_crossing_io_m1_continuerequest;

  //g_sensor_int_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign g_sensor_int_s1_slavearbiterlockenable2 = |g_sensor_int_s1_arb_share_counter_next_value;

  //clock_crossing_io/m1 g_sensor_int/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock2 = g_sensor_int_s1_slavearbiterlockenable2 & clock_crossing_io_m1_continuerequest;

  //g_sensor_int_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign g_sensor_int_s1_any_continuerequest = 1;

  //clock_crossing_io_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io_m1_continuerequest = 1;

  assign clock_crossing_io_m1_qualified_request_g_sensor_int_s1 = clock_crossing_io_m1_requests_g_sensor_int_s1 & ~((clock_crossing_io_m1_read & ((clock_crossing_io_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io_m1_read_data_valid_g_sensor_int_s1, which is an e_mux
  assign clock_crossing_io_m1_read_data_valid_g_sensor_int_s1 = clock_crossing_io_m1_granted_g_sensor_int_s1 & clock_crossing_io_m1_read & ~g_sensor_int_s1_waits_for_read;

  //g_sensor_int_s1_writedata mux, which is an e_mux
  assign g_sensor_int_s1_writedata = clock_crossing_io_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io_m1_granted_g_sensor_int_s1 = clock_crossing_io_m1_qualified_request_g_sensor_int_s1;

  //clock_crossing_io/m1 saved-grant g_sensor_int/s1, which is an e_assign
  assign clock_crossing_io_m1_saved_grant_g_sensor_int_s1 = clock_crossing_io_m1_requests_g_sensor_int_s1;

  //allow new arb cycle for g_sensor_int/s1, which is an e_assign
  assign g_sensor_int_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign g_sensor_int_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign g_sensor_int_s1_master_qreq_vector = 1;

  //g_sensor_int_s1_reset_n assignment, which is an e_assign
  assign g_sensor_int_s1_reset_n = reset_n;

  assign g_sensor_int_s1_chipselect = clock_crossing_io_m1_granted_g_sensor_int_s1;
  //g_sensor_int_s1_firsttransfer first transaction, which is an e_assign
  assign g_sensor_int_s1_firsttransfer = g_sensor_int_s1_begins_xfer ? g_sensor_int_s1_unreg_firsttransfer : g_sensor_int_s1_reg_firsttransfer;

  //g_sensor_int_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign g_sensor_int_s1_unreg_firsttransfer = ~(g_sensor_int_s1_slavearbiterlockenable & g_sensor_int_s1_any_continuerequest);

  //g_sensor_int_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          g_sensor_int_s1_reg_firsttransfer <= 1'b1;
      else if (g_sensor_int_s1_begins_xfer)
          g_sensor_int_s1_reg_firsttransfer <= g_sensor_int_s1_unreg_firsttransfer;
    end


  //g_sensor_int_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign g_sensor_int_s1_beginbursttransfer_internal = g_sensor_int_s1_begins_xfer;

  //~g_sensor_int_s1_write_n assignment, which is an e_mux
  assign g_sensor_int_s1_write_n = ~(clock_crossing_io_m1_granted_g_sensor_int_s1 & clock_crossing_io_m1_write);

  //g_sensor_int_s1_address mux, which is an e_mux
  assign g_sensor_int_s1_address = clock_crossing_io_m1_nativeaddress;

  //d1_g_sensor_int_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_g_sensor_int_s1_end_xfer <= 1;
      else 
        d1_g_sensor_int_s1_end_xfer <= g_sensor_int_s1_end_xfer;
    end


  //g_sensor_int_s1_waits_for_read in a cycle, which is an e_mux
  assign g_sensor_int_s1_waits_for_read = g_sensor_int_s1_in_a_read_cycle & g_sensor_int_s1_begins_xfer;

  //g_sensor_int_s1_in_a_read_cycle assignment, which is an e_assign
  assign g_sensor_int_s1_in_a_read_cycle = clock_crossing_io_m1_granted_g_sensor_int_s1 & clock_crossing_io_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = g_sensor_int_s1_in_a_read_cycle;

  //g_sensor_int_s1_waits_for_write in a cycle, which is an e_mux
  assign g_sensor_int_s1_waits_for_write = g_sensor_int_s1_in_a_write_cycle & 0;

  //g_sensor_int_s1_in_a_write_cycle assignment, which is an e_assign
  assign g_sensor_int_s1_in_a_write_cycle = clock_crossing_io_m1_granted_g_sensor_int_s1 & clock_crossing_io_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = g_sensor_int_s1_in_a_write_cycle;

  assign wait_for_g_sensor_int_s1_counter = 0;
  //assign g_sensor_int_s1_irq_from_sa = g_sensor_int_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign g_sensor_int_s1_irq_from_sa = g_sensor_int_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //g_sensor_int/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module gsensor_spi_slave_arbitrator (
                                      // inputs:
                                       clk,
                                       clock_crossing_io2_m1_address_to_slave,
                                       clock_crossing_io2_m1_byteenable,
                                       clock_crossing_io2_m1_latency_counter,
                                       clock_crossing_io2_m1_nativeaddress,
                                       clock_crossing_io2_m1_read,
                                       clock_crossing_io2_m1_write,
                                       clock_crossing_io2_m1_writedata,
                                       gsensor_spi_slave_readdata,
                                       reset_n,

                                      // outputs:
                                       clock_crossing_io2_m1_granted_gsensor_spi_slave,
                                       clock_crossing_io2_m1_qualified_request_gsensor_spi_slave,
                                       clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave,
                                       clock_crossing_io2_m1_requests_gsensor_spi_slave,
                                       d1_gsensor_spi_slave_end_xfer,
                                       gsensor_spi_slave_address,
                                       gsensor_spi_slave_chipselect,
                                       gsensor_spi_slave_read,
                                       gsensor_spi_slave_readdata_from_sa,
                                       gsensor_spi_slave_reset_n,
                                       gsensor_spi_slave_write,
                                       gsensor_spi_slave_writedata
                                    )
;

  output           clock_crossing_io2_m1_granted_gsensor_spi_slave;
  output           clock_crossing_io2_m1_qualified_request_gsensor_spi_slave;
  output           clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave;
  output           clock_crossing_io2_m1_requests_gsensor_spi_slave;
  output           d1_gsensor_spi_slave_end_xfer;
  output  [  3: 0] gsensor_spi_slave_address;
  output           gsensor_spi_slave_chipselect;
  output           gsensor_spi_slave_read;
  output  [  7: 0] gsensor_spi_slave_readdata_from_sa;
  output           gsensor_spi_slave_reset_n;
  output           gsensor_spi_slave_write;
  output  [  7: 0] gsensor_spi_slave_writedata;
  input            clk;
  input   [ 11: 0] clock_crossing_io2_m1_address_to_slave;
  input   [  3: 0] clock_crossing_io2_m1_byteenable;
  input            clock_crossing_io2_m1_latency_counter;
  input   [  9: 0] clock_crossing_io2_m1_nativeaddress;
  input            clock_crossing_io2_m1_read;
  input            clock_crossing_io2_m1_write;
  input   [ 31: 0] clock_crossing_io2_m1_writedata;
  input   [  7: 0] gsensor_spi_slave_readdata;
  input            reset_n;

  wire             clock_crossing_io2_m1_arbiterlock;
  wire             clock_crossing_io2_m1_arbiterlock2;
  wire             clock_crossing_io2_m1_continuerequest;
  wire             clock_crossing_io2_m1_granted_gsensor_spi_slave;
  wire             clock_crossing_io2_m1_qualified_request_gsensor_spi_slave;
  wire             clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave;
  reg              clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register;
  wire             clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register_in;
  wire             clock_crossing_io2_m1_requests_gsensor_spi_slave;
  wire             clock_crossing_io2_m1_saved_grant_gsensor_spi_slave;
  reg              d1_gsensor_spi_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_gsensor_spi_slave;
  wire    [  3: 0] gsensor_spi_slave_address;
  wire             gsensor_spi_slave_allgrants;
  wire             gsensor_spi_slave_allow_new_arb_cycle;
  wire             gsensor_spi_slave_any_bursting_master_saved_grant;
  wire             gsensor_spi_slave_any_continuerequest;
  wire             gsensor_spi_slave_arb_counter_enable;
  reg              gsensor_spi_slave_arb_share_counter;
  wire             gsensor_spi_slave_arb_share_counter_next_value;
  wire             gsensor_spi_slave_arb_share_set_values;
  wire             gsensor_spi_slave_beginbursttransfer_internal;
  wire             gsensor_spi_slave_begins_xfer;
  wire             gsensor_spi_slave_chipselect;
  wire             gsensor_spi_slave_end_xfer;
  wire             gsensor_spi_slave_firsttransfer;
  wire             gsensor_spi_slave_grant_vector;
  wire             gsensor_spi_slave_in_a_read_cycle;
  wire             gsensor_spi_slave_in_a_write_cycle;
  wire             gsensor_spi_slave_master_qreq_vector;
  wire             gsensor_spi_slave_non_bursting_master_requests;
  wire             gsensor_spi_slave_pretend_byte_enable;
  wire             gsensor_spi_slave_read;
  wire    [  7: 0] gsensor_spi_slave_readdata_from_sa;
  reg              gsensor_spi_slave_reg_firsttransfer;
  wire             gsensor_spi_slave_reset_n;
  reg              gsensor_spi_slave_slavearbiterlockenable;
  wire             gsensor_spi_slave_slavearbiterlockenable2;
  wire             gsensor_spi_slave_unreg_firsttransfer;
  wire             gsensor_spi_slave_waits_for_read;
  wire             gsensor_spi_slave_waits_for_write;
  wire             gsensor_spi_slave_write;
  wire    [  7: 0] gsensor_spi_slave_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             p1_clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register;
  wire             wait_for_gsensor_spi_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~gsensor_spi_slave_end_xfer;
    end


  assign gsensor_spi_slave_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io2_m1_qualified_request_gsensor_spi_slave));
  //assign gsensor_spi_slave_readdata_from_sa = gsensor_spi_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign gsensor_spi_slave_readdata_from_sa = gsensor_spi_slave_readdata;

  assign clock_crossing_io2_m1_requests_gsensor_spi_slave = ({clock_crossing_io2_m1_address_to_slave[11 : 6] , 6'b0} == 12'h800) & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write);
  //gsensor_spi_slave_arb_share_counter set values, which is an e_mux
  assign gsensor_spi_slave_arb_share_set_values = 1;

  //gsensor_spi_slave_non_bursting_master_requests mux, which is an e_mux
  assign gsensor_spi_slave_non_bursting_master_requests = clock_crossing_io2_m1_requests_gsensor_spi_slave;

  //gsensor_spi_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign gsensor_spi_slave_any_bursting_master_saved_grant = 0;

  //gsensor_spi_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign gsensor_spi_slave_arb_share_counter_next_value = gsensor_spi_slave_firsttransfer ? (gsensor_spi_slave_arb_share_set_values - 1) : |gsensor_spi_slave_arb_share_counter ? (gsensor_spi_slave_arb_share_counter - 1) : 0;

  //gsensor_spi_slave_allgrants all slave grants, which is an e_mux
  assign gsensor_spi_slave_allgrants = |gsensor_spi_slave_grant_vector;

  //gsensor_spi_slave_end_xfer assignment, which is an e_assign
  assign gsensor_spi_slave_end_xfer = ~(gsensor_spi_slave_waits_for_read | gsensor_spi_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_gsensor_spi_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_gsensor_spi_slave = gsensor_spi_slave_end_xfer & (~gsensor_spi_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //gsensor_spi_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign gsensor_spi_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_gsensor_spi_slave & gsensor_spi_slave_allgrants) | (end_xfer_arb_share_counter_term_gsensor_spi_slave & ~gsensor_spi_slave_non_bursting_master_requests);

  //gsensor_spi_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          gsensor_spi_slave_arb_share_counter <= 0;
      else if (gsensor_spi_slave_arb_counter_enable)
          gsensor_spi_slave_arb_share_counter <= gsensor_spi_slave_arb_share_counter_next_value;
    end


  //gsensor_spi_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          gsensor_spi_slave_slavearbiterlockenable <= 0;
      else if ((|gsensor_spi_slave_master_qreq_vector & end_xfer_arb_share_counter_term_gsensor_spi_slave) | (end_xfer_arb_share_counter_term_gsensor_spi_slave & ~gsensor_spi_slave_non_bursting_master_requests))
          gsensor_spi_slave_slavearbiterlockenable <= |gsensor_spi_slave_arb_share_counter_next_value;
    end


  //clock_crossing_io2/m1 gsensor_spi/slave arbiterlock, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock = gsensor_spi_slave_slavearbiterlockenable & clock_crossing_io2_m1_continuerequest;

  //gsensor_spi_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign gsensor_spi_slave_slavearbiterlockenable2 = |gsensor_spi_slave_arb_share_counter_next_value;

  //clock_crossing_io2/m1 gsensor_spi/slave arbiterlock2, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock2 = gsensor_spi_slave_slavearbiterlockenable2 & clock_crossing_io2_m1_continuerequest;

  //gsensor_spi_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign gsensor_spi_slave_any_continuerequest = 1;

  //clock_crossing_io2_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io2_m1_continuerequest = 1;

  assign clock_crossing_io2_m1_qualified_request_gsensor_spi_slave = clock_crossing_io2_m1_requests_gsensor_spi_slave & ~((clock_crossing_io2_m1_read & ((1 < clock_crossing_io2_m1_latency_counter))));
  //clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  assign clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register_in = clock_crossing_io2_m1_granted_gsensor_spi_slave & clock_crossing_io2_m1_read & ~gsensor_spi_slave_waits_for_read;

  //shift register p1 clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register = {clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register, clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register_in};

  //clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register <= 0;
      else 
        clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register <= p1_clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register;
    end


  //local readdatavalid clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave, which is an e_mux
  assign clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave = clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave_shift_register;

  //gsensor_spi_slave_writedata mux, which is an e_mux
  assign gsensor_spi_slave_writedata = clock_crossing_io2_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io2_m1_granted_gsensor_spi_slave = clock_crossing_io2_m1_qualified_request_gsensor_spi_slave;

  //clock_crossing_io2/m1 saved-grant gsensor_spi/slave, which is an e_assign
  assign clock_crossing_io2_m1_saved_grant_gsensor_spi_slave = clock_crossing_io2_m1_requests_gsensor_spi_slave;

  //allow new arb cycle for gsensor_spi/slave, which is an e_assign
  assign gsensor_spi_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign gsensor_spi_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign gsensor_spi_slave_master_qreq_vector = 1;

  //gsensor_spi_slave_reset_n assignment, which is an e_assign
  assign gsensor_spi_slave_reset_n = reset_n;

  assign gsensor_spi_slave_chipselect = clock_crossing_io2_m1_granted_gsensor_spi_slave;
  //gsensor_spi_slave_firsttransfer first transaction, which is an e_assign
  assign gsensor_spi_slave_firsttransfer = gsensor_spi_slave_begins_xfer ? gsensor_spi_slave_unreg_firsttransfer : gsensor_spi_slave_reg_firsttransfer;

  //gsensor_spi_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign gsensor_spi_slave_unreg_firsttransfer = ~(gsensor_spi_slave_slavearbiterlockenable & gsensor_spi_slave_any_continuerequest);

  //gsensor_spi_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          gsensor_spi_slave_reg_firsttransfer <= 1'b1;
      else if (gsensor_spi_slave_begins_xfer)
          gsensor_spi_slave_reg_firsttransfer <= gsensor_spi_slave_unreg_firsttransfer;
    end


  //gsensor_spi_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign gsensor_spi_slave_beginbursttransfer_internal = gsensor_spi_slave_begins_xfer;

  //gsensor_spi_slave_read assignment, which is an e_mux
  assign gsensor_spi_slave_read = clock_crossing_io2_m1_granted_gsensor_spi_slave & clock_crossing_io2_m1_read;

  //gsensor_spi_slave_write assignment, which is an e_mux
  assign gsensor_spi_slave_write = ((clock_crossing_io2_m1_granted_gsensor_spi_slave & clock_crossing_io2_m1_write)) & gsensor_spi_slave_pretend_byte_enable;

  //gsensor_spi_slave_address mux, which is an e_mux
  assign gsensor_spi_slave_address = clock_crossing_io2_m1_nativeaddress;

  //d1_gsensor_spi_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_gsensor_spi_slave_end_xfer <= 1;
      else 
        d1_gsensor_spi_slave_end_xfer <= gsensor_spi_slave_end_xfer;
    end


  //gsensor_spi_slave_waits_for_read in a cycle, which is an e_mux
  assign gsensor_spi_slave_waits_for_read = gsensor_spi_slave_in_a_read_cycle & 0;

  //gsensor_spi_slave_in_a_read_cycle assignment, which is an e_assign
  assign gsensor_spi_slave_in_a_read_cycle = clock_crossing_io2_m1_granted_gsensor_spi_slave & clock_crossing_io2_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = gsensor_spi_slave_in_a_read_cycle;

  //gsensor_spi_slave_waits_for_write in a cycle, which is an e_mux
  assign gsensor_spi_slave_waits_for_write = gsensor_spi_slave_in_a_write_cycle & 0;

  //gsensor_spi_slave_in_a_write_cycle assignment, which is an e_assign
  assign gsensor_spi_slave_in_a_write_cycle = clock_crossing_io2_m1_granted_gsensor_spi_slave & clock_crossing_io2_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = gsensor_spi_slave_in_a_write_cycle;

  assign wait_for_gsensor_spi_slave_counter = 0;
  //gsensor_spi_slave_pretend_byte_enable byte enable port mux, which is an e_mux
  assign gsensor_spi_slave_pretend_byte_enable = (clock_crossing_io2_m1_granted_gsensor_spi_slave)? clock_crossing_io2_m1_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //gsensor_spi/slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module i2c_scl_s1_arbitrator (
                               // inputs:
                                clk,
                                clock_crossing_io2_m1_address_to_slave,
                                clock_crossing_io2_m1_latency_counter,
                                clock_crossing_io2_m1_nativeaddress,
                                clock_crossing_io2_m1_read,
                                clock_crossing_io2_m1_write,
                                clock_crossing_io2_m1_writedata,
                                i2c_scl_s1_readdata,
                                reset_n,

                               // outputs:
                                clock_crossing_io2_m1_granted_i2c_scl_s1,
                                clock_crossing_io2_m1_qualified_request_i2c_scl_s1,
                                clock_crossing_io2_m1_read_data_valid_i2c_scl_s1,
                                clock_crossing_io2_m1_requests_i2c_scl_s1,
                                d1_i2c_scl_s1_end_xfer,
                                i2c_scl_s1_address,
                                i2c_scl_s1_chipselect,
                                i2c_scl_s1_readdata_from_sa,
                                i2c_scl_s1_reset_n,
                                i2c_scl_s1_write_n,
                                i2c_scl_s1_writedata
                             )
;

  output           clock_crossing_io2_m1_granted_i2c_scl_s1;
  output           clock_crossing_io2_m1_qualified_request_i2c_scl_s1;
  output           clock_crossing_io2_m1_read_data_valid_i2c_scl_s1;
  output           clock_crossing_io2_m1_requests_i2c_scl_s1;
  output           d1_i2c_scl_s1_end_xfer;
  output  [  1: 0] i2c_scl_s1_address;
  output           i2c_scl_s1_chipselect;
  output           i2c_scl_s1_readdata_from_sa;
  output           i2c_scl_s1_reset_n;
  output           i2c_scl_s1_write_n;
  output           i2c_scl_s1_writedata;
  input            clk;
  input   [ 11: 0] clock_crossing_io2_m1_address_to_slave;
  input            clock_crossing_io2_m1_latency_counter;
  input   [  9: 0] clock_crossing_io2_m1_nativeaddress;
  input            clock_crossing_io2_m1_read;
  input            clock_crossing_io2_m1_write;
  input   [ 31: 0] clock_crossing_io2_m1_writedata;
  input            i2c_scl_s1_readdata;
  input            reset_n;

  wire             clock_crossing_io2_m1_arbiterlock;
  wire             clock_crossing_io2_m1_arbiterlock2;
  wire             clock_crossing_io2_m1_continuerequest;
  wire             clock_crossing_io2_m1_granted_i2c_scl_s1;
  wire             clock_crossing_io2_m1_qualified_request_i2c_scl_s1;
  wire             clock_crossing_io2_m1_read_data_valid_i2c_scl_s1;
  wire             clock_crossing_io2_m1_requests_i2c_scl_s1;
  wire             clock_crossing_io2_m1_saved_grant_i2c_scl_s1;
  reg              d1_i2c_scl_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_i2c_scl_s1;
  wire    [  1: 0] i2c_scl_s1_address;
  wire             i2c_scl_s1_allgrants;
  wire             i2c_scl_s1_allow_new_arb_cycle;
  wire             i2c_scl_s1_any_bursting_master_saved_grant;
  wire             i2c_scl_s1_any_continuerequest;
  wire             i2c_scl_s1_arb_counter_enable;
  reg              i2c_scl_s1_arb_share_counter;
  wire             i2c_scl_s1_arb_share_counter_next_value;
  wire             i2c_scl_s1_arb_share_set_values;
  wire             i2c_scl_s1_beginbursttransfer_internal;
  wire             i2c_scl_s1_begins_xfer;
  wire             i2c_scl_s1_chipselect;
  wire             i2c_scl_s1_end_xfer;
  wire             i2c_scl_s1_firsttransfer;
  wire             i2c_scl_s1_grant_vector;
  wire             i2c_scl_s1_in_a_read_cycle;
  wire             i2c_scl_s1_in_a_write_cycle;
  wire             i2c_scl_s1_master_qreq_vector;
  wire             i2c_scl_s1_non_bursting_master_requests;
  wire             i2c_scl_s1_readdata_from_sa;
  reg              i2c_scl_s1_reg_firsttransfer;
  wire             i2c_scl_s1_reset_n;
  reg              i2c_scl_s1_slavearbiterlockenable;
  wire             i2c_scl_s1_slavearbiterlockenable2;
  wire             i2c_scl_s1_unreg_firsttransfer;
  wire             i2c_scl_s1_waits_for_read;
  wire             i2c_scl_s1_waits_for_write;
  wire             i2c_scl_s1_write_n;
  wire             i2c_scl_s1_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             wait_for_i2c_scl_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~i2c_scl_s1_end_xfer;
    end


  assign i2c_scl_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io2_m1_qualified_request_i2c_scl_s1));
  //assign i2c_scl_s1_readdata_from_sa = i2c_scl_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign i2c_scl_s1_readdata_from_sa = i2c_scl_s1_readdata;

  assign clock_crossing_io2_m1_requests_i2c_scl_s1 = ({clock_crossing_io2_m1_address_to_slave[11 : 4] , 4'b0} == 12'h850) & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write);
  //i2c_scl_s1_arb_share_counter set values, which is an e_mux
  assign i2c_scl_s1_arb_share_set_values = 1;

  //i2c_scl_s1_non_bursting_master_requests mux, which is an e_mux
  assign i2c_scl_s1_non_bursting_master_requests = clock_crossing_io2_m1_requests_i2c_scl_s1;

  //i2c_scl_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign i2c_scl_s1_any_bursting_master_saved_grant = 0;

  //i2c_scl_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign i2c_scl_s1_arb_share_counter_next_value = i2c_scl_s1_firsttransfer ? (i2c_scl_s1_arb_share_set_values - 1) : |i2c_scl_s1_arb_share_counter ? (i2c_scl_s1_arb_share_counter - 1) : 0;

  //i2c_scl_s1_allgrants all slave grants, which is an e_mux
  assign i2c_scl_s1_allgrants = |i2c_scl_s1_grant_vector;

  //i2c_scl_s1_end_xfer assignment, which is an e_assign
  assign i2c_scl_s1_end_xfer = ~(i2c_scl_s1_waits_for_read | i2c_scl_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_i2c_scl_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_i2c_scl_s1 = i2c_scl_s1_end_xfer & (~i2c_scl_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //i2c_scl_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign i2c_scl_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_i2c_scl_s1 & i2c_scl_s1_allgrants) | (end_xfer_arb_share_counter_term_i2c_scl_s1 & ~i2c_scl_s1_non_bursting_master_requests);

  //i2c_scl_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_scl_s1_arb_share_counter <= 0;
      else if (i2c_scl_s1_arb_counter_enable)
          i2c_scl_s1_arb_share_counter <= i2c_scl_s1_arb_share_counter_next_value;
    end


  //i2c_scl_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_scl_s1_slavearbiterlockenable <= 0;
      else if ((|i2c_scl_s1_master_qreq_vector & end_xfer_arb_share_counter_term_i2c_scl_s1) | (end_xfer_arb_share_counter_term_i2c_scl_s1 & ~i2c_scl_s1_non_bursting_master_requests))
          i2c_scl_s1_slavearbiterlockenable <= |i2c_scl_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io2/m1 i2c_scl/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock = i2c_scl_s1_slavearbiterlockenable & clock_crossing_io2_m1_continuerequest;

  //i2c_scl_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign i2c_scl_s1_slavearbiterlockenable2 = |i2c_scl_s1_arb_share_counter_next_value;

  //clock_crossing_io2/m1 i2c_scl/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock2 = i2c_scl_s1_slavearbiterlockenable2 & clock_crossing_io2_m1_continuerequest;

  //i2c_scl_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign i2c_scl_s1_any_continuerequest = 1;

  //clock_crossing_io2_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io2_m1_continuerequest = 1;

  assign clock_crossing_io2_m1_qualified_request_i2c_scl_s1 = clock_crossing_io2_m1_requests_i2c_scl_s1 & ~((clock_crossing_io2_m1_read & ((clock_crossing_io2_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io2_m1_read_data_valid_i2c_scl_s1, which is an e_mux
  assign clock_crossing_io2_m1_read_data_valid_i2c_scl_s1 = clock_crossing_io2_m1_granted_i2c_scl_s1 & clock_crossing_io2_m1_read & ~i2c_scl_s1_waits_for_read;

  //i2c_scl_s1_writedata mux, which is an e_mux
  assign i2c_scl_s1_writedata = clock_crossing_io2_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io2_m1_granted_i2c_scl_s1 = clock_crossing_io2_m1_qualified_request_i2c_scl_s1;

  //clock_crossing_io2/m1 saved-grant i2c_scl/s1, which is an e_assign
  assign clock_crossing_io2_m1_saved_grant_i2c_scl_s1 = clock_crossing_io2_m1_requests_i2c_scl_s1;

  //allow new arb cycle for i2c_scl/s1, which is an e_assign
  assign i2c_scl_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign i2c_scl_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign i2c_scl_s1_master_qreq_vector = 1;

  //i2c_scl_s1_reset_n assignment, which is an e_assign
  assign i2c_scl_s1_reset_n = reset_n;

  assign i2c_scl_s1_chipselect = clock_crossing_io2_m1_granted_i2c_scl_s1;
  //i2c_scl_s1_firsttransfer first transaction, which is an e_assign
  assign i2c_scl_s1_firsttransfer = i2c_scl_s1_begins_xfer ? i2c_scl_s1_unreg_firsttransfer : i2c_scl_s1_reg_firsttransfer;

  //i2c_scl_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign i2c_scl_s1_unreg_firsttransfer = ~(i2c_scl_s1_slavearbiterlockenable & i2c_scl_s1_any_continuerequest);

  //i2c_scl_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_scl_s1_reg_firsttransfer <= 1'b1;
      else if (i2c_scl_s1_begins_xfer)
          i2c_scl_s1_reg_firsttransfer <= i2c_scl_s1_unreg_firsttransfer;
    end


  //i2c_scl_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign i2c_scl_s1_beginbursttransfer_internal = i2c_scl_s1_begins_xfer;

  //~i2c_scl_s1_write_n assignment, which is an e_mux
  assign i2c_scl_s1_write_n = ~(clock_crossing_io2_m1_granted_i2c_scl_s1 & clock_crossing_io2_m1_write);

  //i2c_scl_s1_address mux, which is an e_mux
  assign i2c_scl_s1_address = clock_crossing_io2_m1_nativeaddress;

  //d1_i2c_scl_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_i2c_scl_s1_end_xfer <= 1;
      else 
        d1_i2c_scl_s1_end_xfer <= i2c_scl_s1_end_xfer;
    end


  //i2c_scl_s1_waits_for_read in a cycle, which is an e_mux
  assign i2c_scl_s1_waits_for_read = i2c_scl_s1_in_a_read_cycle & i2c_scl_s1_begins_xfer;

  //i2c_scl_s1_in_a_read_cycle assignment, which is an e_assign
  assign i2c_scl_s1_in_a_read_cycle = clock_crossing_io2_m1_granted_i2c_scl_s1 & clock_crossing_io2_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = i2c_scl_s1_in_a_read_cycle;

  //i2c_scl_s1_waits_for_write in a cycle, which is an e_mux
  assign i2c_scl_s1_waits_for_write = i2c_scl_s1_in_a_write_cycle & 0;

  //i2c_scl_s1_in_a_write_cycle assignment, which is an e_assign
  assign i2c_scl_s1_in_a_write_cycle = clock_crossing_io2_m1_granted_i2c_scl_s1 & clock_crossing_io2_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = i2c_scl_s1_in_a_write_cycle;

  assign wait_for_i2c_scl_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //i2c_scl/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module i2c_sda_s1_arbitrator (
                               // inputs:
                                clk,
                                clock_crossing_io2_m1_address_to_slave,
                                clock_crossing_io2_m1_latency_counter,
                                clock_crossing_io2_m1_nativeaddress,
                                clock_crossing_io2_m1_read,
                                clock_crossing_io2_m1_write,
                                clock_crossing_io2_m1_writedata,
                                i2c_sda_s1_readdata,
                                reset_n,

                               // outputs:
                                clock_crossing_io2_m1_granted_i2c_sda_s1,
                                clock_crossing_io2_m1_qualified_request_i2c_sda_s1,
                                clock_crossing_io2_m1_read_data_valid_i2c_sda_s1,
                                clock_crossing_io2_m1_requests_i2c_sda_s1,
                                d1_i2c_sda_s1_end_xfer,
                                i2c_sda_s1_address,
                                i2c_sda_s1_chipselect,
                                i2c_sda_s1_readdata_from_sa,
                                i2c_sda_s1_reset_n,
                                i2c_sda_s1_write_n,
                                i2c_sda_s1_writedata
                             )
;

  output           clock_crossing_io2_m1_granted_i2c_sda_s1;
  output           clock_crossing_io2_m1_qualified_request_i2c_sda_s1;
  output           clock_crossing_io2_m1_read_data_valid_i2c_sda_s1;
  output           clock_crossing_io2_m1_requests_i2c_sda_s1;
  output           d1_i2c_sda_s1_end_xfer;
  output  [  1: 0] i2c_sda_s1_address;
  output           i2c_sda_s1_chipselect;
  output           i2c_sda_s1_readdata_from_sa;
  output           i2c_sda_s1_reset_n;
  output           i2c_sda_s1_write_n;
  output           i2c_sda_s1_writedata;
  input            clk;
  input   [ 11: 0] clock_crossing_io2_m1_address_to_slave;
  input            clock_crossing_io2_m1_latency_counter;
  input   [  9: 0] clock_crossing_io2_m1_nativeaddress;
  input            clock_crossing_io2_m1_read;
  input            clock_crossing_io2_m1_write;
  input   [ 31: 0] clock_crossing_io2_m1_writedata;
  input            i2c_sda_s1_readdata;
  input            reset_n;

  wire             clock_crossing_io2_m1_arbiterlock;
  wire             clock_crossing_io2_m1_arbiterlock2;
  wire             clock_crossing_io2_m1_continuerequest;
  wire             clock_crossing_io2_m1_granted_i2c_sda_s1;
  wire             clock_crossing_io2_m1_qualified_request_i2c_sda_s1;
  wire             clock_crossing_io2_m1_read_data_valid_i2c_sda_s1;
  wire             clock_crossing_io2_m1_requests_i2c_sda_s1;
  wire             clock_crossing_io2_m1_saved_grant_i2c_sda_s1;
  reg              d1_i2c_sda_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_i2c_sda_s1;
  wire    [  1: 0] i2c_sda_s1_address;
  wire             i2c_sda_s1_allgrants;
  wire             i2c_sda_s1_allow_new_arb_cycle;
  wire             i2c_sda_s1_any_bursting_master_saved_grant;
  wire             i2c_sda_s1_any_continuerequest;
  wire             i2c_sda_s1_arb_counter_enable;
  reg              i2c_sda_s1_arb_share_counter;
  wire             i2c_sda_s1_arb_share_counter_next_value;
  wire             i2c_sda_s1_arb_share_set_values;
  wire             i2c_sda_s1_beginbursttransfer_internal;
  wire             i2c_sda_s1_begins_xfer;
  wire             i2c_sda_s1_chipselect;
  wire             i2c_sda_s1_end_xfer;
  wire             i2c_sda_s1_firsttransfer;
  wire             i2c_sda_s1_grant_vector;
  wire             i2c_sda_s1_in_a_read_cycle;
  wire             i2c_sda_s1_in_a_write_cycle;
  wire             i2c_sda_s1_master_qreq_vector;
  wire             i2c_sda_s1_non_bursting_master_requests;
  wire             i2c_sda_s1_readdata_from_sa;
  reg              i2c_sda_s1_reg_firsttransfer;
  wire             i2c_sda_s1_reset_n;
  reg              i2c_sda_s1_slavearbiterlockenable;
  wire             i2c_sda_s1_slavearbiterlockenable2;
  wire             i2c_sda_s1_unreg_firsttransfer;
  wire             i2c_sda_s1_waits_for_read;
  wire             i2c_sda_s1_waits_for_write;
  wire             i2c_sda_s1_write_n;
  wire             i2c_sda_s1_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             wait_for_i2c_sda_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~i2c_sda_s1_end_xfer;
    end


  assign i2c_sda_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io2_m1_qualified_request_i2c_sda_s1));
  //assign i2c_sda_s1_readdata_from_sa = i2c_sda_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign i2c_sda_s1_readdata_from_sa = i2c_sda_s1_readdata;

  assign clock_crossing_io2_m1_requests_i2c_sda_s1 = ({clock_crossing_io2_m1_address_to_slave[11 : 4] , 4'b0} == 12'h840) & (clock_crossing_io2_m1_read | clock_crossing_io2_m1_write);
  //i2c_sda_s1_arb_share_counter set values, which is an e_mux
  assign i2c_sda_s1_arb_share_set_values = 1;

  //i2c_sda_s1_non_bursting_master_requests mux, which is an e_mux
  assign i2c_sda_s1_non_bursting_master_requests = clock_crossing_io2_m1_requests_i2c_sda_s1;

  //i2c_sda_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign i2c_sda_s1_any_bursting_master_saved_grant = 0;

  //i2c_sda_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign i2c_sda_s1_arb_share_counter_next_value = i2c_sda_s1_firsttransfer ? (i2c_sda_s1_arb_share_set_values - 1) : |i2c_sda_s1_arb_share_counter ? (i2c_sda_s1_arb_share_counter - 1) : 0;

  //i2c_sda_s1_allgrants all slave grants, which is an e_mux
  assign i2c_sda_s1_allgrants = |i2c_sda_s1_grant_vector;

  //i2c_sda_s1_end_xfer assignment, which is an e_assign
  assign i2c_sda_s1_end_xfer = ~(i2c_sda_s1_waits_for_read | i2c_sda_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_i2c_sda_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_i2c_sda_s1 = i2c_sda_s1_end_xfer & (~i2c_sda_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //i2c_sda_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign i2c_sda_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_i2c_sda_s1 & i2c_sda_s1_allgrants) | (end_xfer_arb_share_counter_term_i2c_sda_s1 & ~i2c_sda_s1_non_bursting_master_requests);

  //i2c_sda_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sda_s1_arb_share_counter <= 0;
      else if (i2c_sda_s1_arb_counter_enable)
          i2c_sda_s1_arb_share_counter <= i2c_sda_s1_arb_share_counter_next_value;
    end


  //i2c_sda_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sda_s1_slavearbiterlockenable <= 0;
      else if ((|i2c_sda_s1_master_qreq_vector & end_xfer_arb_share_counter_term_i2c_sda_s1) | (end_xfer_arb_share_counter_term_i2c_sda_s1 & ~i2c_sda_s1_non_bursting_master_requests))
          i2c_sda_s1_slavearbiterlockenable <= |i2c_sda_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io2/m1 i2c_sda/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock = i2c_sda_s1_slavearbiterlockenable & clock_crossing_io2_m1_continuerequest;

  //i2c_sda_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign i2c_sda_s1_slavearbiterlockenable2 = |i2c_sda_s1_arb_share_counter_next_value;

  //clock_crossing_io2/m1 i2c_sda/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io2_m1_arbiterlock2 = i2c_sda_s1_slavearbiterlockenable2 & clock_crossing_io2_m1_continuerequest;

  //i2c_sda_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign i2c_sda_s1_any_continuerequest = 1;

  //clock_crossing_io2_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io2_m1_continuerequest = 1;

  assign clock_crossing_io2_m1_qualified_request_i2c_sda_s1 = clock_crossing_io2_m1_requests_i2c_sda_s1 & ~((clock_crossing_io2_m1_read & ((clock_crossing_io2_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io2_m1_read_data_valid_i2c_sda_s1, which is an e_mux
  assign clock_crossing_io2_m1_read_data_valid_i2c_sda_s1 = clock_crossing_io2_m1_granted_i2c_sda_s1 & clock_crossing_io2_m1_read & ~i2c_sda_s1_waits_for_read;

  //i2c_sda_s1_writedata mux, which is an e_mux
  assign i2c_sda_s1_writedata = clock_crossing_io2_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io2_m1_granted_i2c_sda_s1 = clock_crossing_io2_m1_qualified_request_i2c_sda_s1;

  //clock_crossing_io2/m1 saved-grant i2c_sda/s1, which is an e_assign
  assign clock_crossing_io2_m1_saved_grant_i2c_sda_s1 = clock_crossing_io2_m1_requests_i2c_sda_s1;

  //allow new arb cycle for i2c_sda/s1, which is an e_assign
  assign i2c_sda_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign i2c_sda_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign i2c_sda_s1_master_qreq_vector = 1;

  //i2c_sda_s1_reset_n assignment, which is an e_assign
  assign i2c_sda_s1_reset_n = reset_n;

  assign i2c_sda_s1_chipselect = clock_crossing_io2_m1_granted_i2c_sda_s1;
  //i2c_sda_s1_firsttransfer first transaction, which is an e_assign
  assign i2c_sda_s1_firsttransfer = i2c_sda_s1_begins_xfer ? i2c_sda_s1_unreg_firsttransfer : i2c_sda_s1_reg_firsttransfer;

  //i2c_sda_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign i2c_sda_s1_unreg_firsttransfer = ~(i2c_sda_s1_slavearbiterlockenable & i2c_sda_s1_any_continuerequest);

  //i2c_sda_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sda_s1_reg_firsttransfer <= 1'b1;
      else if (i2c_sda_s1_begins_xfer)
          i2c_sda_s1_reg_firsttransfer <= i2c_sda_s1_unreg_firsttransfer;
    end


  //i2c_sda_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign i2c_sda_s1_beginbursttransfer_internal = i2c_sda_s1_begins_xfer;

  //~i2c_sda_s1_write_n assignment, which is an e_mux
  assign i2c_sda_s1_write_n = ~(clock_crossing_io2_m1_granted_i2c_sda_s1 & clock_crossing_io2_m1_write);

  //i2c_sda_s1_address mux, which is an e_mux
  assign i2c_sda_s1_address = clock_crossing_io2_m1_nativeaddress;

  //d1_i2c_sda_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_i2c_sda_s1_end_xfer <= 1;
      else 
        d1_i2c_sda_s1_end_xfer <= i2c_sda_s1_end_xfer;
    end


  //i2c_sda_s1_waits_for_read in a cycle, which is an e_mux
  assign i2c_sda_s1_waits_for_read = i2c_sda_s1_in_a_read_cycle & i2c_sda_s1_begins_xfer;

  //i2c_sda_s1_in_a_read_cycle assignment, which is an e_assign
  assign i2c_sda_s1_in_a_read_cycle = clock_crossing_io2_m1_granted_i2c_sda_s1 & clock_crossing_io2_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = i2c_sda_s1_in_a_read_cycle;

  //i2c_sda_s1_waits_for_write in a cycle, which is an e_mux
  assign i2c_sda_s1_waits_for_write = i2c_sda_s1_in_a_write_cycle & 0;

  //i2c_sda_s1_in_a_write_cycle assignment, which is an e_assign
  assign i2c_sda_s1_in_a_write_cycle = clock_crossing_io2_m1_granted_i2c_sda_s1 & clock_crossing_io2_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = i2c_sda_s1_in_a_write_cycle;

  assign wait_for_i2c_sda_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //i2c_sda/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_avalon_jtag_slave_arbitrator (
                                                // inputs:
                                                 clk,
                                                 cpu_data_master_address_to_slave,
                                                 cpu_data_master_latency_counter,
                                                 cpu_data_master_read,
                                                 cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                                                 cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                                                 cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                                 cpu_data_master_write,
                                                 cpu_data_master_writedata,
                                                 jtag_uart_avalon_jtag_slave_dataavailable,
                                                 jtag_uart_avalon_jtag_slave_irq,
                                                 jtag_uart_avalon_jtag_slave_readdata,
                                                 jtag_uart_avalon_jtag_slave_readyfordata,
                                                 jtag_uart_avalon_jtag_slave_waitrequest,
                                                 reset_n,

                                                // outputs:
                                                 cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                                 d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                                 jtag_uart_avalon_jtag_slave_address,
                                                 jtag_uart_avalon_jtag_slave_chipselect,
                                                 jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
                                                 jtag_uart_avalon_jtag_slave_irq_from_sa,
                                                 jtag_uart_avalon_jtag_slave_read_n,
                                                 jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_reset_n,
                                                 jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                                 jtag_uart_avalon_jtag_slave_write_n,
                                                 jtag_uart_avalon_jtag_slave_writedata
                                              )
;

  output           cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  output           d1_jtag_uart_avalon_jtag_slave_end_xfer;
  output           jtag_uart_avalon_jtag_slave_address;
  output           jtag_uart_avalon_jtag_slave_chipselect;
  output           jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_avalon_jtag_slave_reset_n;
  output           jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            jtag_uart_avalon_jtag_slave_dataavailable;
  input            jtag_uart_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  input            jtag_uart_avalon_jtag_slave_readyfordata;
  input            jtag_uart_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave;
  reg              d1_jtag_uart_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_allgrants;
  wire             jtag_uart_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  reg              jtag_uart_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [ 26: 0] shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master;
  wire             wait_for_jtag_uart_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave));
  //assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata;

  assign cpu_data_master_requests_jtag_uart_avalon_jtag_slave = ({cpu_data_master_address_to_slave[26 : 3] , 3'b0} == 27'h6001010) & (cpu_data_master_read | cpu_data_master_write);
  //assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest;

  //jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_non_bursting_master_requests = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_avalon_jtag_slave_firsttransfer ? (jtag_uart_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_avalon_jtag_slave_arb_share_counter ? (jtag_uart_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_allgrants = |jtag_uart_avalon_jtag_slave_grant_vector;

  //jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_end_xfer = ~(jtag_uart_avalon_jtag_slave_waits_for_read | jtag_uart_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave = jtag_uart_avalon_jtag_slave_end_xfer & (~jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & jtag_uart_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = jtag_uart_avalon_jtag_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register) | (|cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read & ~jtag_uart_avalon_jtag_slave_waits_for_read;

  //jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_jtag_uart_avalon_jtag_slave = cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;

  //cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  assign cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_avalon_jtag_slave_chipselect = cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  //jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_firsttransfer = jtag_uart_avalon_jtag_slave_begins_xfer ? jtag_uart_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_avalon_jtag_slave_begins_xfer)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_read_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read);

  //~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_write_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write);

  assign shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_address = shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master >> 2;

  //d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_read = jtag_uart_avalon_jtag_slave_in_a_read_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_read_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_write = jtag_uart_avalon_jtag_slave_in_a_write_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_write_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module key_s1_arbitrator (
                           // inputs:
                            clk,
                            clock_crossing_io_m1_address_to_slave,
                            clock_crossing_io_m1_latency_counter,
                            clock_crossing_io_m1_nativeaddress,
                            clock_crossing_io_m1_read,
                            clock_crossing_io_m1_write,
                            clock_crossing_io_m1_writedata,
                            key_s1_irq,
                            key_s1_readdata,
                            reset_n,

                           // outputs:
                            clock_crossing_io_m1_granted_key_s1,
                            clock_crossing_io_m1_qualified_request_key_s1,
                            clock_crossing_io_m1_read_data_valid_key_s1,
                            clock_crossing_io_m1_requests_key_s1,
                            d1_key_s1_end_xfer,
                            key_s1_address,
                            key_s1_chipselect,
                            key_s1_irq_from_sa,
                            key_s1_readdata_from_sa,
                            key_s1_reset_n,
                            key_s1_write_n,
                            key_s1_writedata
                         )
;

  output           clock_crossing_io_m1_granted_key_s1;
  output           clock_crossing_io_m1_qualified_request_key_s1;
  output           clock_crossing_io_m1_read_data_valid_key_s1;
  output           clock_crossing_io_m1_requests_key_s1;
  output           d1_key_s1_end_xfer;
  output  [  1: 0] key_s1_address;
  output           key_s1_chipselect;
  output           key_s1_irq_from_sa;
  output  [  1: 0] key_s1_readdata_from_sa;
  output           key_s1_reset_n;
  output           key_s1_write_n;
  output  [  1: 0] key_s1_writedata;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address_to_slave;
  input            clock_crossing_io_m1_latency_counter;
  input   [  4: 0] clock_crossing_io_m1_nativeaddress;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_write;
  input   [ 31: 0] clock_crossing_io_m1_writedata;
  input            key_s1_irq;
  input   [  1: 0] key_s1_readdata;
  input            reset_n;

  wire             clock_crossing_io_m1_arbiterlock;
  wire             clock_crossing_io_m1_arbiterlock2;
  wire             clock_crossing_io_m1_continuerequest;
  wire             clock_crossing_io_m1_granted_key_s1;
  wire             clock_crossing_io_m1_qualified_request_key_s1;
  wire             clock_crossing_io_m1_read_data_valid_key_s1;
  wire             clock_crossing_io_m1_requests_key_s1;
  wire             clock_crossing_io_m1_saved_grant_key_s1;
  reg              d1_key_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_key_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] key_s1_address;
  wire             key_s1_allgrants;
  wire             key_s1_allow_new_arb_cycle;
  wire             key_s1_any_bursting_master_saved_grant;
  wire             key_s1_any_continuerequest;
  wire             key_s1_arb_counter_enable;
  reg              key_s1_arb_share_counter;
  wire             key_s1_arb_share_counter_next_value;
  wire             key_s1_arb_share_set_values;
  wire             key_s1_beginbursttransfer_internal;
  wire             key_s1_begins_xfer;
  wire             key_s1_chipselect;
  wire             key_s1_end_xfer;
  wire             key_s1_firsttransfer;
  wire             key_s1_grant_vector;
  wire             key_s1_in_a_read_cycle;
  wire             key_s1_in_a_write_cycle;
  wire             key_s1_irq_from_sa;
  wire             key_s1_master_qreq_vector;
  wire             key_s1_non_bursting_master_requests;
  wire    [  1: 0] key_s1_readdata_from_sa;
  reg              key_s1_reg_firsttransfer;
  wire             key_s1_reset_n;
  reg              key_s1_slavearbiterlockenable;
  wire             key_s1_slavearbiterlockenable2;
  wire             key_s1_unreg_firsttransfer;
  wire             key_s1_waits_for_read;
  wire             key_s1_waits_for_write;
  wire             key_s1_write_n;
  wire    [  1: 0] key_s1_writedata;
  wire             wait_for_key_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~key_s1_end_xfer;
    end


  assign key_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io_m1_qualified_request_key_s1));
  //assign key_s1_readdata_from_sa = key_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign key_s1_readdata_from_sa = key_s1_readdata;

  assign clock_crossing_io_m1_requests_key_s1 = ({clock_crossing_io_m1_address_to_slave[6 : 4] , 4'b0} == 7'h20) & (clock_crossing_io_m1_read | clock_crossing_io_m1_write);
  //key_s1_arb_share_counter set values, which is an e_mux
  assign key_s1_arb_share_set_values = 1;

  //key_s1_non_bursting_master_requests mux, which is an e_mux
  assign key_s1_non_bursting_master_requests = clock_crossing_io_m1_requests_key_s1;

  //key_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign key_s1_any_bursting_master_saved_grant = 0;

  //key_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign key_s1_arb_share_counter_next_value = key_s1_firsttransfer ? (key_s1_arb_share_set_values - 1) : |key_s1_arb_share_counter ? (key_s1_arb_share_counter - 1) : 0;

  //key_s1_allgrants all slave grants, which is an e_mux
  assign key_s1_allgrants = |key_s1_grant_vector;

  //key_s1_end_xfer assignment, which is an e_assign
  assign key_s1_end_xfer = ~(key_s1_waits_for_read | key_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_key_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_key_s1 = key_s1_end_xfer & (~key_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //key_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign key_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_key_s1 & key_s1_allgrants) | (end_xfer_arb_share_counter_term_key_s1 & ~key_s1_non_bursting_master_requests);

  //key_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          key_s1_arb_share_counter <= 0;
      else if (key_s1_arb_counter_enable)
          key_s1_arb_share_counter <= key_s1_arb_share_counter_next_value;
    end


  //key_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          key_s1_slavearbiterlockenable <= 0;
      else if ((|key_s1_master_qreq_vector & end_xfer_arb_share_counter_term_key_s1) | (end_xfer_arb_share_counter_term_key_s1 & ~key_s1_non_bursting_master_requests))
          key_s1_slavearbiterlockenable <= |key_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io/m1 key/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock = key_s1_slavearbiterlockenable & clock_crossing_io_m1_continuerequest;

  //key_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign key_s1_slavearbiterlockenable2 = |key_s1_arb_share_counter_next_value;

  //clock_crossing_io/m1 key/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock2 = key_s1_slavearbiterlockenable2 & clock_crossing_io_m1_continuerequest;

  //key_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign key_s1_any_continuerequest = 1;

  //clock_crossing_io_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io_m1_continuerequest = 1;

  assign clock_crossing_io_m1_qualified_request_key_s1 = clock_crossing_io_m1_requests_key_s1 & ~((clock_crossing_io_m1_read & ((clock_crossing_io_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io_m1_read_data_valid_key_s1, which is an e_mux
  assign clock_crossing_io_m1_read_data_valid_key_s1 = clock_crossing_io_m1_granted_key_s1 & clock_crossing_io_m1_read & ~key_s1_waits_for_read;

  //key_s1_writedata mux, which is an e_mux
  assign key_s1_writedata = clock_crossing_io_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io_m1_granted_key_s1 = clock_crossing_io_m1_qualified_request_key_s1;

  //clock_crossing_io/m1 saved-grant key/s1, which is an e_assign
  assign clock_crossing_io_m1_saved_grant_key_s1 = clock_crossing_io_m1_requests_key_s1;

  //allow new arb cycle for key/s1, which is an e_assign
  assign key_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign key_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign key_s1_master_qreq_vector = 1;

  //key_s1_reset_n assignment, which is an e_assign
  assign key_s1_reset_n = reset_n;

  assign key_s1_chipselect = clock_crossing_io_m1_granted_key_s1;
  //key_s1_firsttransfer first transaction, which is an e_assign
  assign key_s1_firsttransfer = key_s1_begins_xfer ? key_s1_unreg_firsttransfer : key_s1_reg_firsttransfer;

  //key_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign key_s1_unreg_firsttransfer = ~(key_s1_slavearbiterlockenable & key_s1_any_continuerequest);

  //key_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          key_s1_reg_firsttransfer <= 1'b1;
      else if (key_s1_begins_xfer)
          key_s1_reg_firsttransfer <= key_s1_unreg_firsttransfer;
    end


  //key_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign key_s1_beginbursttransfer_internal = key_s1_begins_xfer;

  //~key_s1_write_n assignment, which is an e_mux
  assign key_s1_write_n = ~(clock_crossing_io_m1_granted_key_s1 & clock_crossing_io_m1_write);

  //key_s1_address mux, which is an e_mux
  assign key_s1_address = clock_crossing_io_m1_nativeaddress;

  //d1_key_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_key_s1_end_xfer <= 1;
      else 
        d1_key_s1_end_xfer <= key_s1_end_xfer;
    end


  //key_s1_waits_for_read in a cycle, which is an e_mux
  assign key_s1_waits_for_read = key_s1_in_a_read_cycle & key_s1_begins_xfer;

  //key_s1_in_a_read_cycle assignment, which is an e_assign
  assign key_s1_in_a_read_cycle = clock_crossing_io_m1_granted_key_s1 & clock_crossing_io_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = key_s1_in_a_read_cycle;

  //key_s1_waits_for_write in a cycle, which is an e_mux
  assign key_s1_waits_for_write = key_s1_in_a_write_cycle & 0;

  //key_s1_in_a_write_cycle assignment, which is an e_assign
  assign key_s1_in_a_write_cycle = clock_crossing_io_m1_granted_key_s1 & clock_crossing_io_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = key_s1_in_a_write_cycle;

  assign wait_for_key_s1_counter = 0;
  //assign key_s1_irq_from_sa = key_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign key_s1_irq_from_sa = key_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //key/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module led_s1_arbitrator (
                           // inputs:
                            clk,
                            clock_crossing_io_m1_address_to_slave,
                            clock_crossing_io_m1_byteenable,
                            clock_crossing_io_m1_latency_counter,
                            clock_crossing_io_m1_nativeaddress,
                            clock_crossing_io_m1_read,
                            clock_crossing_io_m1_write,
                            clock_crossing_io_m1_writedata,
                            led_s1_readdata,
                            reset_n,

                           // outputs:
                            clock_crossing_io_m1_granted_led_s1,
                            clock_crossing_io_m1_qualified_request_led_s1,
                            clock_crossing_io_m1_read_data_valid_led_s1,
                            clock_crossing_io_m1_requests_led_s1,
                            d1_led_s1_end_xfer,
                            led_s1_address,
                            led_s1_chipselect,
                            led_s1_readdata_from_sa,
                            led_s1_reset_n,
                            led_s1_write_n,
                            led_s1_writedata
                         )
;

  output           clock_crossing_io_m1_granted_led_s1;
  output           clock_crossing_io_m1_qualified_request_led_s1;
  output           clock_crossing_io_m1_read_data_valid_led_s1;
  output           clock_crossing_io_m1_requests_led_s1;
  output           d1_led_s1_end_xfer;
  output  [  1: 0] led_s1_address;
  output           led_s1_chipselect;
  output  [  7: 0] led_s1_readdata_from_sa;
  output           led_s1_reset_n;
  output           led_s1_write_n;
  output  [  7: 0] led_s1_writedata;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address_to_slave;
  input   [  3: 0] clock_crossing_io_m1_byteenable;
  input            clock_crossing_io_m1_latency_counter;
  input   [  4: 0] clock_crossing_io_m1_nativeaddress;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_write;
  input   [ 31: 0] clock_crossing_io_m1_writedata;
  input   [  7: 0] led_s1_readdata;
  input            reset_n;

  wire             clock_crossing_io_m1_arbiterlock;
  wire             clock_crossing_io_m1_arbiterlock2;
  wire             clock_crossing_io_m1_continuerequest;
  wire             clock_crossing_io_m1_granted_led_s1;
  wire             clock_crossing_io_m1_qualified_request_led_s1;
  wire             clock_crossing_io_m1_read_data_valid_led_s1;
  wire             clock_crossing_io_m1_requests_led_s1;
  wire             clock_crossing_io_m1_saved_grant_led_s1;
  reg              d1_led_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_led_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] led_s1_address;
  wire             led_s1_allgrants;
  wire             led_s1_allow_new_arb_cycle;
  wire             led_s1_any_bursting_master_saved_grant;
  wire             led_s1_any_continuerequest;
  wire             led_s1_arb_counter_enable;
  reg              led_s1_arb_share_counter;
  wire             led_s1_arb_share_counter_next_value;
  wire             led_s1_arb_share_set_values;
  wire             led_s1_beginbursttransfer_internal;
  wire             led_s1_begins_xfer;
  wire             led_s1_chipselect;
  wire             led_s1_end_xfer;
  wire             led_s1_firsttransfer;
  wire             led_s1_grant_vector;
  wire             led_s1_in_a_read_cycle;
  wire             led_s1_in_a_write_cycle;
  wire             led_s1_master_qreq_vector;
  wire             led_s1_non_bursting_master_requests;
  wire             led_s1_pretend_byte_enable;
  wire    [  7: 0] led_s1_readdata_from_sa;
  reg              led_s1_reg_firsttransfer;
  wire             led_s1_reset_n;
  reg              led_s1_slavearbiterlockenable;
  wire             led_s1_slavearbiterlockenable2;
  wire             led_s1_unreg_firsttransfer;
  wire             led_s1_waits_for_read;
  wire             led_s1_waits_for_write;
  wire             led_s1_write_n;
  wire    [  7: 0] led_s1_writedata;
  wire             wait_for_led_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~led_s1_end_xfer;
    end


  assign led_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io_m1_qualified_request_led_s1));
  //assign led_s1_readdata_from_sa = led_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign led_s1_readdata_from_sa = led_s1_readdata;

  assign clock_crossing_io_m1_requests_led_s1 = ({clock_crossing_io_m1_address_to_slave[6 : 4] , 4'b0} == 7'h30) & (clock_crossing_io_m1_read | clock_crossing_io_m1_write);
  //led_s1_arb_share_counter set values, which is an e_mux
  assign led_s1_arb_share_set_values = 1;

  //led_s1_non_bursting_master_requests mux, which is an e_mux
  assign led_s1_non_bursting_master_requests = clock_crossing_io_m1_requests_led_s1;

  //led_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign led_s1_any_bursting_master_saved_grant = 0;

  //led_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign led_s1_arb_share_counter_next_value = led_s1_firsttransfer ? (led_s1_arb_share_set_values - 1) : |led_s1_arb_share_counter ? (led_s1_arb_share_counter - 1) : 0;

  //led_s1_allgrants all slave grants, which is an e_mux
  assign led_s1_allgrants = |led_s1_grant_vector;

  //led_s1_end_xfer assignment, which is an e_assign
  assign led_s1_end_xfer = ~(led_s1_waits_for_read | led_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_led_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_led_s1 = led_s1_end_xfer & (~led_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //led_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign led_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_led_s1 & led_s1_allgrants) | (end_xfer_arb_share_counter_term_led_s1 & ~led_s1_non_bursting_master_requests);

  //led_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_s1_arb_share_counter <= 0;
      else if (led_s1_arb_counter_enable)
          led_s1_arb_share_counter <= led_s1_arb_share_counter_next_value;
    end


  //led_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_s1_slavearbiterlockenable <= 0;
      else if ((|led_s1_master_qreq_vector & end_xfer_arb_share_counter_term_led_s1) | (end_xfer_arb_share_counter_term_led_s1 & ~led_s1_non_bursting_master_requests))
          led_s1_slavearbiterlockenable <= |led_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io/m1 led/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock = led_s1_slavearbiterlockenable & clock_crossing_io_m1_continuerequest;

  //led_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign led_s1_slavearbiterlockenable2 = |led_s1_arb_share_counter_next_value;

  //clock_crossing_io/m1 led/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock2 = led_s1_slavearbiterlockenable2 & clock_crossing_io_m1_continuerequest;

  //led_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign led_s1_any_continuerequest = 1;

  //clock_crossing_io_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io_m1_continuerequest = 1;

  assign clock_crossing_io_m1_qualified_request_led_s1 = clock_crossing_io_m1_requests_led_s1 & ~((clock_crossing_io_m1_read & ((clock_crossing_io_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io_m1_read_data_valid_led_s1, which is an e_mux
  assign clock_crossing_io_m1_read_data_valid_led_s1 = clock_crossing_io_m1_granted_led_s1 & clock_crossing_io_m1_read & ~led_s1_waits_for_read;

  //led_s1_writedata mux, which is an e_mux
  assign led_s1_writedata = clock_crossing_io_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io_m1_granted_led_s1 = clock_crossing_io_m1_qualified_request_led_s1;

  //clock_crossing_io/m1 saved-grant led/s1, which is an e_assign
  assign clock_crossing_io_m1_saved_grant_led_s1 = clock_crossing_io_m1_requests_led_s1;

  //allow new arb cycle for led/s1, which is an e_assign
  assign led_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign led_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign led_s1_master_qreq_vector = 1;

  //led_s1_reset_n assignment, which is an e_assign
  assign led_s1_reset_n = reset_n;

  assign led_s1_chipselect = clock_crossing_io_m1_granted_led_s1;
  //led_s1_firsttransfer first transaction, which is an e_assign
  assign led_s1_firsttransfer = led_s1_begins_xfer ? led_s1_unreg_firsttransfer : led_s1_reg_firsttransfer;

  //led_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign led_s1_unreg_firsttransfer = ~(led_s1_slavearbiterlockenable & led_s1_any_continuerequest);

  //led_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_s1_reg_firsttransfer <= 1'b1;
      else if (led_s1_begins_xfer)
          led_s1_reg_firsttransfer <= led_s1_unreg_firsttransfer;
    end


  //led_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign led_s1_beginbursttransfer_internal = led_s1_begins_xfer;

  //~led_s1_write_n assignment, which is an e_mux
  assign led_s1_write_n = ~(((clock_crossing_io_m1_granted_led_s1 & clock_crossing_io_m1_write)) & led_s1_pretend_byte_enable);

  //led_s1_address mux, which is an e_mux
  assign led_s1_address = clock_crossing_io_m1_nativeaddress;

  //d1_led_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_led_s1_end_xfer <= 1;
      else 
        d1_led_s1_end_xfer <= led_s1_end_xfer;
    end


  //led_s1_waits_for_read in a cycle, which is an e_mux
  assign led_s1_waits_for_read = led_s1_in_a_read_cycle & led_s1_begins_xfer;

  //led_s1_in_a_read_cycle assignment, which is an e_assign
  assign led_s1_in_a_read_cycle = clock_crossing_io_m1_granted_led_s1 & clock_crossing_io_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = led_s1_in_a_read_cycle;

  //led_s1_waits_for_write in a cycle, which is an e_mux
  assign led_s1_waits_for_write = led_s1_in_a_write_cycle & 0;

  //led_s1_in_a_write_cycle assignment, which is an e_assign
  assign led_s1_in_a_write_cycle = clock_crossing_io_m1_granted_led_s1 & clock_crossing_io_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = led_s1_in_a_write_cycle;

  assign wait_for_led_s1_counter = 0;
  //led_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign led_s1_pretend_byte_enable = (clock_crossing_io_m1_granted_led_s1)? clock_crossing_io_m1_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //led/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_sdram_s1_module (
                                                         // inputs:
                                                          clear_fifo,
                                                          clk,
                                                          data_in,
                                                          read,
                                                          reset_n,
                                                          sync_reset,
                                                          write,

                                                         // outputs:
                                                          data_out,
                                                          empty,
                                                          fifo_contains_ones_n,
                                                          full
                                                       )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module (
                                                                // inputs:
                                                                 clear_fifo,
                                                                 clk,
                                                                 data_in,
                                                                 read,
                                                                 reset_n,
                                                                 sync_reset,
                                                                 write,

                                                                // outputs:
                                                                 data_out,
                                                                 empty,
                                                                 fifo_contains_ones_n,
                                                                 full
                                                              )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_s1_arbitrator (
                             // inputs:
                              clk,
                              cpu_data_master_address_to_slave,
                              cpu_data_master_byteenable,
                              cpu_data_master_dbs_address,
                              cpu_data_master_dbs_write_16,
                              cpu_data_master_latency_counter,
                              cpu_data_master_read,
                              cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register,
                              cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register,
                              cpu_data_master_write,
                              cpu_instruction_master_address_to_slave,
                              cpu_instruction_master_dbs_address,
                              cpu_instruction_master_latency_counter,
                              cpu_instruction_master_read,
                              reset_n,
                              sdram_s1_readdata,
                              sdram_s1_readdatavalid,
                              sdram_s1_waitrequest,

                             // outputs:
                              cpu_data_master_byteenable_sdram_s1,
                              cpu_data_master_granted_sdram_s1,
                              cpu_data_master_qualified_request_sdram_s1,
                              cpu_data_master_read_data_valid_sdram_s1,
                              cpu_data_master_read_data_valid_sdram_s1_shift_register,
                              cpu_data_master_requests_sdram_s1,
                              cpu_instruction_master_granted_sdram_s1,
                              cpu_instruction_master_qualified_request_sdram_s1,
                              cpu_instruction_master_read_data_valid_sdram_s1,
                              cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                              cpu_instruction_master_requests_sdram_s1,
                              d1_sdram_s1_end_xfer,
                              sdram_s1_address,
                              sdram_s1_byteenable_n,
                              sdram_s1_chipselect,
                              sdram_s1_read_n,
                              sdram_s1_readdata_from_sa,
                              sdram_s1_reset_n,
                              sdram_s1_waitrequest_from_sa,
                              sdram_s1_write_n,
                              sdram_s1_writedata
                           )
;

  output  [  1: 0] cpu_data_master_byteenable_sdram_s1;
  output           cpu_data_master_granted_sdram_s1;
  output           cpu_data_master_qualified_request_sdram_s1;
  output           cpu_data_master_read_data_valid_sdram_s1;
  output           cpu_data_master_read_data_valid_sdram_s1_shift_register;
  output           cpu_data_master_requests_sdram_s1;
  output           cpu_instruction_master_granted_sdram_s1;
  output           cpu_instruction_master_qualified_request_sdram_s1;
  output           cpu_instruction_master_read_data_valid_sdram_s1;
  output           cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  output           cpu_instruction_master_requests_sdram_s1;
  output           d1_sdram_s1_end_xfer;
  output  [ 23: 0] sdram_s1_address;
  output  [  1: 0] sdram_s1_byteenable_n;
  output           sdram_s1_chipselect;
  output           sdram_s1_read_n;
  output  [ 15: 0] sdram_s1_readdata_from_sa;
  output           sdram_s1_reset_n;
  output           sdram_s1_waitrequest_from_sa;
  output           sdram_s1_write_n;
  output  [ 15: 0] sdram_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  input            cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata;
  input            sdram_s1_readdatavalid;
  input            sdram_s1_waitrequest;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sdram_s1;
  wire             cpu_data_master_qualified_request_sdram_s1;
  wire             cpu_data_master_rdv_fifo_empty_sdram_s1;
  wire             cpu_data_master_rdv_fifo_output_from_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_data_master_requests_sdram_s1;
  wire             cpu_data_master_saved_grant_sdram_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_sdram_s1;
  wire             cpu_instruction_master_qualified_request_sdram_s1;
  wire             cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  wire             cpu_instruction_master_rdv_fifo_output_from_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_instruction_master_requests_sdram_s1;
  wire             cpu_instruction_master_saved_grant_sdram_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_sdram_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_sdram_s1;
  wire    [ 23: 0] sdram_s1_address;
  wire             sdram_s1_allgrants;
  wire             sdram_s1_allow_new_arb_cycle;
  wire             sdram_s1_any_bursting_master_saved_grant;
  wire             sdram_s1_any_continuerequest;
  reg     [  1: 0] sdram_s1_arb_addend;
  wire             sdram_s1_arb_counter_enable;
  reg     [  1: 0] sdram_s1_arb_share_counter;
  wire    [  1: 0] sdram_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_s1_arb_share_set_values;
  wire    [  1: 0] sdram_s1_arb_winner;
  wire             sdram_s1_arbitration_holdoff_internal;
  wire             sdram_s1_beginbursttransfer_internal;
  wire             sdram_s1_begins_xfer;
  wire    [  1: 0] sdram_s1_byteenable_n;
  wire             sdram_s1_chipselect;
  wire    [  3: 0] sdram_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_s1_chosen_master_rot_left;
  wire             sdram_s1_end_xfer;
  wire             sdram_s1_firsttransfer;
  wire    [  1: 0] sdram_s1_grant_vector;
  wire             sdram_s1_in_a_read_cycle;
  wire             sdram_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_s1_master_qreq_vector;
  wire             sdram_s1_move_on_to_next_transaction;
  wire             sdram_s1_non_bursting_master_requests;
  wire             sdram_s1_read_n;
  wire    [ 15: 0] sdram_s1_readdata_from_sa;
  wire             sdram_s1_readdatavalid_from_sa;
  reg              sdram_s1_reg_firsttransfer;
  wire             sdram_s1_reset_n;
  reg     [  1: 0] sdram_s1_saved_chosen_master_vector;
  reg              sdram_s1_slavearbiterlockenable;
  wire             sdram_s1_slavearbiterlockenable2;
  wire             sdram_s1_unreg_firsttransfer;
  wire             sdram_s1_waitrequest_from_sa;
  wire             sdram_s1_waits_for_read;
  wire             sdram_s1_waits_for_write;
  wire             sdram_s1_write_n;
  wire    [ 15: 0] sdram_s1_writedata;
  wire    [ 26: 0] shifted_address_to_sdram_s1_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_sdram_s1_from_cpu_instruction_master;
  wire             wait_for_sdram_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_s1_end_xfer;
    end


  assign sdram_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sdram_s1 | cpu_instruction_master_qualified_request_sdram_s1));
  //assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid;

  //assign sdram_s1_readdata_from_sa = sdram_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_readdata_from_sa = sdram_s1_readdata;

  assign cpu_data_master_requests_sdram_s1 = ({cpu_data_master_address_to_slave[26 : 25] , 25'b0} == 27'h2000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest;

  //sdram_s1_arb_share_counter set values, which is an e_mux
  assign sdram_s1_arb_share_set_values = (cpu_data_master_granted_sdram_s1)? 2 :
    (cpu_instruction_master_granted_sdram_s1)? 2 :
    (cpu_data_master_granted_sdram_s1)? 2 :
    (cpu_instruction_master_granted_sdram_s1)? 2 :
    1;

  //sdram_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_s1_non_bursting_master_requests = cpu_data_master_requests_sdram_s1 |
    cpu_instruction_master_requests_sdram_s1 |
    cpu_data_master_requests_sdram_s1 |
    cpu_instruction_master_requests_sdram_s1;

  //sdram_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_s1_any_bursting_master_saved_grant = 0;

  //sdram_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_s1_arb_share_counter_next_value = sdram_s1_firsttransfer ? (sdram_s1_arb_share_set_values - 1) : |sdram_s1_arb_share_counter ? (sdram_s1_arb_share_counter - 1) : 0;

  //sdram_s1_allgrants all slave grants, which is an e_mux
  assign sdram_s1_allgrants = (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector);

  //sdram_s1_end_xfer assignment, which is an e_assign
  assign sdram_s1_end_xfer = ~(sdram_s1_waits_for_read | sdram_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_s1 = sdram_s1_end_xfer & (~sdram_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_s1 & sdram_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_s1 & ~sdram_s1_non_bursting_master_requests);

  //sdram_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_arb_share_counter <= 0;
      else if (sdram_s1_arb_counter_enable)
          sdram_s1_arb_share_counter <= sdram_s1_arb_share_counter_next_value;
    end


  //sdram_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_s1) | (end_xfer_arb_share_counter_term_sdram_s1 & ~sdram_s1_non_bursting_master_requests))
          sdram_s1_slavearbiterlockenable <= |sdram_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sdram/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sdram_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sdram_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_s1_slavearbiterlockenable2 = |sdram_s1_arb_share_counter_next_value;

  //cpu/data_master sdram/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sdram_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master sdram/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = sdram_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master sdram/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = sdram_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted sdram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= cpu_instruction_master_saved_grant_sdram_s1 ? 1 : (sdram_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_sdram_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_sdram_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_sdram_s1 & cpu_instruction_master_requests_sdram_s1;

  //sdram_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_sdram_s1 = cpu_data_master_requests_sdram_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register) | (|cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register))) | ((!cpu_data_master_byteenable_sdram_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //unique name for sdram_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_s1_move_on_to_next_transaction = sdram_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_s1_module rdv_fifo_for_cpu_data_master_to_sdram_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_sdram_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_sdram_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_sdram_s1),
      .full                 (),
      .read                 (sdram_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_sdram_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_sdram_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sdram_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sdram_s1 = (sdram_s1_readdatavalid_from_sa & cpu_data_master_rdv_fifo_output_from_sdram_s1) & ~ cpu_data_master_rdv_fifo_empty_sdram_s1;

  //sdram_s1_writedata mux, which is an e_mux
  assign sdram_s1_writedata = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_sdram_s1 = (({cpu_instruction_master_address_to_slave[26 : 25] , 25'b0} == 27'h2000000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted sdram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_sdram_s1 <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_sdram_s1 <= cpu_data_master_saved_grant_sdram_s1 ? 1 : (sdram_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_sdram_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_sdram_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_sdram_s1 & cpu_data_master_requests_sdram_s1;

  assign cpu_instruction_master_qualified_request_sdram_s1 = cpu_instruction_master_requests_sdram_s1 & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (1 < cpu_instruction_master_latency_counter))) | cpu_data_master_arbiterlock);
  //rdv_fifo_for_cpu_instruction_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module rdv_fifo_for_cpu_instruction_master_to_sdram_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_instruction_master_granted_sdram_s1),
      .data_out             (cpu_instruction_master_rdv_fifo_output_from_sdram_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_instruction_master_rdv_fifo_empty_sdram_s1),
      .full                 (),
      .read                 (sdram_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_s1_waits_for_read)
    );

  assign cpu_instruction_master_read_data_valid_sdram_s1_shift_register = ~cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  //local readdatavalid cpu_instruction_master_read_data_valid_sdram_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_sdram_s1 = (sdram_s1_readdatavalid_from_sa & cpu_instruction_master_rdv_fifo_output_from_sdram_s1) & ~ cpu_instruction_master_rdv_fifo_empty_sdram_s1;

  //allow new arb cycle for sdram/s1, which is an e_assign
  assign sdram_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  assign sdram_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_sdram_s1;

  //cpu/instruction_master grant sdram/s1, which is an e_assign
  assign cpu_instruction_master_granted_sdram_s1 = sdram_s1_grant_vector[0];

  //cpu/instruction_master saved-grant sdram/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_sdram_s1 = sdram_s1_arb_winner[0] && cpu_instruction_master_requests_sdram_s1;

  //cpu/data_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  assign sdram_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_sdram_s1;

  //cpu/data_master grant sdram/s1, which is an e_assign
  assign cpu_data_master_granted_sdram_s1 = sdram_s1_grant_vector[1];

  //cpu/data_master saved-grant sdram/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sdram_s1 = sdram_s1_arb_winner[1] && cpu_data_master_requests_sdram_s1;

  //sdram/s1 chosen-master double-vector, which is an e_assign
  assign sdram_s1_chosen_master_double_vector = {sdram_s1_master_qreq_vector, sdram_s1_master_qreq_vector} & ({~sdram_s1_master_qreq_vector, ~sdram_s1_master_qreq_vector} + sdram_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_s1_arb_winner = (sdram_s1_allow_new_arb_cycle & | sdram_s1_grant_vector) ? sdram_s1_grant_vector : sdram_s1_saved_chosen_master_vector;

  //saved sdram_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_saved_chosen_master_vector <= 0;
      else if (sdram_s1_allow_new_arb_cycle)
          sdram_s1_saved_chosen_master_vector <= |sdram_s1_grant_vector ? sdram_s1_grant_vector : sdram_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_s1_grant_vector = {(sdram_s1_chosen_master_double_vector[1] | sdram_s1_chosen_master_double_vector[3]),
    (sdram_s1_chosen_master_double_vector[0] | sdram_s1_chosen_master_double_vector[2])};

  //sdram/s1 chosen master rotated left, which is an e_assign
  assign sdram_s1_chosen_master_rot_left = (sdram_s1_arb_winner << 1) ? (sdram_s1_arb_winner << 1) : 1;

  //sdram/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_arb_addend <= 1;
      else if (|sdram_s1_grant_vector)
          sdram_s1_arb_addend <= sdram_s1_end_xfer? sdram_s1_chosen_master_rot_left : sdram_s1_grant_vector;
    end


  //sdram_s1_reset_n assignment, which is an e_assign
  assign sdram_s1_reset_n = reset_n;

  assign sdram_s1_chipselect = cpu_data_master_granted_sdram_s1 | cpu_instruction_master_granted_sdram_s1;
  //sdram_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_s1_firsttransfer = sdram_s1_begins_xfer ? sdram_s1_unreg_firsttransfer : sdram_s1_reg_firsttransfer;

  //sdram_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_s1_unreg_firsttransfer = ~(sdram_s1_slavearbiterlockenable & sdram_s1_any_continuerequest);

  //sdram_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_s1_begins_xfer)
          sdram_s1_reg_firsttransfer <= sdram_s1_unreg_firsttransfer;
    end


  //sdram_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_s1_beginbursttransfer_internal = sdram_s1_begins_xfer;

  //sdram_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_s1_arbitration_holdoff_internal = sdram_s1_begins_xfer & sdram_s1_firsttransfer;

  //~sdram_s1_read_n assignment, which is an e_mux
  assign sdram_s1_read_n = ~((cpu_data_master_granted_sdram_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read));

  //~sdram_s1_write_n assignment, which is an e_mux
  assign sdram_s1_write_n = ~(cpu_data_master_granted_sdram_s1 & cpu_data_master_write);

  assign shifted_address_to_sdram_s1_from_cpu_data_master = {cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_s1_address mux, which is an e_mux
  assign sdram_s1_address = (cpu_data_master_granted_sdram_s1)? (shifted_address_to_sdram_s1_from_cpu_data_master >> 1) :
    (shifted_address_to_sdram_s1_from_cpu_instruction_master >> 1);

  assign shifted_address_to_sdram_s1_from_cpu_instruction_master = {cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_s1_end_xfer <= 1;
      else 
        d1_sdram_s1_end_xfer <= sdram_s1_end_xfer;
    end


  //sdram_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_s1_waits_for_read = sdram_s1_in_a_read_cycle & sdram_s1_waitrequest_from_sa;

  //sdram_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_s1_in_a_read_cycle = (cpu_data_master_granted_sdram_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_s1_in_a_read_cycle;

  //sdram_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_s1_waits_for_write = sdram_s1_in_a_write_cycle & sdram_s1_waitrequest_from_sa;

  //sdram_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_s1_in_a_write_cycle = cpu_data_master_granted_sdram_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_s1_in_a_write_cycle;

  assign wait_for_sdram_s1_counter = 0;
  //~sdram_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_s1_byteenable_n = ~((cpu_data_master_granted_sdram_s1)? cpu_data_master_byteenable_sdram_s1 :
    -1);

  assign {cpu_data_master_byteenable_sdram_s1_segment_1,
cpu_data_master_byteenable_sdram_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_sdram_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_sdram_s1_segment_0 :
    cpu_data_master_byteenable_sdram_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_sdram_s1 + cpu_instruction_master_granted_sdram_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_sdram_s1 + cpu_instruction_master_saved_grant_sdram_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module select_i2c_clk_s1_arbitrator (
                                      // inputs:
                                       clk,
                                       clock_crossing_io_m1_address_to_slave,
                                       clock_crossing_io_m1_latency_counter,
                                       clock_crossing_io_m1_nativeaddress,
                                       clock_crossing_io_m1_read,
                                       clock_crossing_io_m1_write,
                                       clock_crossing_io_m1_writedata,
                                       reset_n,
                                       select_i2c_clk_s1_readdata,

                                      // outputs:
                                       clock_crossing_io_m1_granted_select_i2c_clk_s1,
                                       clock_crossing_io_m1_qualified_request_select_i2c_clk_s1,
                                       clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1,
                                       clock_crossing_io_m1_requests_select_i2c_clk_s1,
                                       d1_select_i2c_clk_s1_end_xfer,
                                       select_i2c_clk_s1_address,
                                       select_i2c_clk_s1_chipselect,
                                       select_i2c_clk_s1_readdata_from_sa,
                                       select_i2c_clk_s1_reset_n,
                                       select_i2c_clk_s1_write_n,
                                       select_i2c_clk_s1_writedata
                                    )
;

  output           clock_crossing_io_m1_granted_select_i2c_clk_s1;
  output           clock_crossing_io_m1_qualified_request_select_i2c_clk_s1;
  output           clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1;
  output           clock_crossing_io_m1_requests_select_i2c_clk_s1;
  output           d1_select_i2c_clk_s1_end_xfer;
  output  [  1: 0] select_i2c_clk_s1_address;
  output           select_i2c_clk_s1_chipselect;
  output           select_i2c_clk_s1_readdata_from_sa;
  output           select_i2c_clk_s1_reset_n;
  output           select_i2c_clk_s1_write_n;
  output           select_i2c_clk_s1_writedata;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address_to_slave;
  input            clock_crossing_io_m1_latency_counter;
  input   [  4: 0] clock_crossing_io_m1_nativeaddress;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_write;
  input   [ 31: 0] clock_crossing_io_m1_writedata;
  input            reset_n;
  input            select_i2c_clk_s1_readdata;

  wire             clock_crossing_io_m1_arbiterlock;
  wire             clock_crossing_io_m1_arbiterlock2;
  wire             clock_crossing_io_m1_continuerequest;
  wire             clock_crossing_io_m1_granted_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_qualified_request_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_requests_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_saved_grant_select_i2c_clk_s1;
  reg              d1_reasons_to_wait;
  reg              d1_select_i2c_clk_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_select_i2c_clk_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] select_i2c_clk_s1_address;
  wire             select_i2c_clk_s1_allgrants;
  wire             select_i2c_clk_s1_allow_new_arb_cycle;
  wire             select_i2c_clk_s1_any_bursting_master_saved_grant;
  wire             select_i2c_clk_s1_any_continuerequest;
  wire             select_i2c_clk_s1_arb_counter_enable;
  reg              select_i2c_clk_s1_arb_share_counter;
  wire             select_i2c_clk_s1_arb_share_counter_next_value;
  wire             select_i2c_clk_s1_arb_share_set_values;
  wire             select_i2c_clk_s1_beginbursttransfer_internal;
  wire             select_i2c_clk_s1_begins_xfer;
  wire             select_i2c_clk_s1_chipselect;
  wire             select_i2c_clk_s1_end_xfer;
  wire             select_i2c_clk_s1_firsttransfer;
  wire             select_i2c_clk_s1_grant_vector;
  wire             select_i2c_clk_s1_in_a_read_cycle;
  wire             select_i2c_clk_s1_in_a_write_cycle;
  wire             select_i2c_clk_s1_master_qreq_vector;
  wire             select_i2c_clk_s1_non_bursting_master_requests;
  wire             select_i2c_clk_s1_readdata_from_sa;
  reg              select_i2c_clk_s1_reg_firsttransfer;
  wire             select_i2c_clk_s1_reset_n;
  reg              select_i2c_clk_s1_slavearbiterlockenable;
  wire             select_i2c_clk_s1_slavearbiterlockenable2;
  wire             select_i2c_clk_s1_unreg_firsttransfer;
  wire             select_i2c_clk_s1_waits_for_read;
  wire             select_i2c_clk_s1_waits_for_write;
  wire             select_i2c_clk_s1_write_n;
  wire             select_i2c_clk_s1_writedata;
  wire             wait_for_select_i2c_clk_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~select_i2c_clk_s1_end_xfer;
    end


  assign select_i2c_clk_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io_m1_qualified_request_select_i2c_clk_s1));
  //assign select_i2c_clk_s1_readdata_from_sa = select_i2c_clk_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign select_i2c_clk_s1_readdata_from_sa = select_i2c_clk_s1_readdata;

  assign clock_crossing_io_m1_requests_select_i2c_clk_s1 = ({clock_crossing_io_m1_address_to_slave[6 : 4] , 4'b0} == 7'h60) & (clock_crossing_io_m1_read | clock_crossing_io_m1_write);
  //select_i2c_clk_s1_arb_share_counter set values, which is an e_mux
  assign select_i2c_clk_s1_arb_share_set_values = 1;

  //select_i2c_clk_s1_non_bursting_master_requests mux, which is an e_mux
  assign select_i2c_clk_s1_non_bursting_master_requests = clock_crossing_io_m1_requests_select_i2c_clk_s1;

  //select_i2c_clk_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign select_i2c_clk_s1_any_bursting_master_saved_grant = 0;

  //select_i2c_clk_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign select_i2c_clk_s1_arb_share_counter_next_value = select_i2c_clk_s1_firsttransfer ? (select_i2c_clk_s1_arb_share_set_values - 1) : |select_i2c_clk_s1_arb_share_counter ? (select_i2c_clk_s1_arb_share_counter - 1) : 0;

  //select_i2c_clk_s1_allgrants all slave grants, which is an e_mux
  assign select_i2c_clk_s1_allgrants = |select_i2c_clk_s1_grant_vector;

  //select_i2c_clk_s1_end_xfer assignment, which is an e_assign
  assign select_i2c_clk_s1_end_xfer = ~(select_i2c_clk_s1_waits_for_read | select_i2c_clk_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_select_i2c_clk_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_select_i2c_clk_s1 = select_i2c_clk_s1_end_xfer & (~select_i2c_clk_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //select_i2c_clk_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign select_i2c_clk_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_select_i2c_clk_s1 & select_i2c_clk_s1_allgrants) | (end_xfer_arb_share_counter_term_select_i2c_clk_s1 & ~select_i2c_clk_s1_non_bursting_master_requests);

  //select_i2c_clk_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          select_i2c_clk_s1_arb_share_counter <= 0;
      else if (select_i2c_clk_s1_arb_counter_enable)
          select_i2c_clk_s1_arb_share_counter <= select_i2c_clk_s1_arb_share_counter_next_value;
    end


  //select_i2c_clk_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          select_i2c_clk_s1_slavearbiterlockenable <= 0;
      else if ((|select_i2c_clk_s1_master_qreq_vector & end_xfer_arb_share_counter_term_select_i2c_clk_s1) | (end_xfer_arb_share_counter_term_select_i2c_clk_s1 & ~select_i2c_clk_s1_non_bursting_master_requests))
          select_i2c_clk_s1_slavearbiterlockenable <= |select_i2c_clk_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io/m1 select_i2c_clk/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock = select_i2c_clk_s1_slavearbiterlockenable & clock_crossing_io_m1_continuerequest;

  //select_i2c_clk_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign select_i2c_clk_s1_slavearbiterlockenable2 = |select_i2c_clk_s1_arb_share_counter_next_value;

  //clock_crossing_io/m1 select_i2c_clk/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock2 = select_i2c_clk_s1_slavearbiterlockenable2 & clock_crossing_io_m1_continuerequest;

  //select_i2c_clk_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign select_i2c_clk_s1_any_continuerequest = 1;

  //clock_crossing_io_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io_m1_continuerequest = 1;

  assign clock_crossing_io_m1_qualified_request_select_i2c_clk_s1 = clock_crossing_io_m1_requests_select_i2c_clk_s1 & ~((clock_crossing_io_m1_read & ((clock_crossing_io_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1, which is an e_mux
  assign clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1 = clock_crossing_io_m1_granted_select_i2c_clk_s1 & clock_crossing_io_m1_read & ~select_i2c_clk_s1_waits_for_read;

  //select_i2c_clk_s1_writedata mux, which is an e_mux
  assign select_i2c_clk_s1_writedata = clock_crossing_io_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io_m1_granted_select_i2c_clk_s1 = clock_crossing_io_m1_qualified_request_select_i2c_clk_s1;

  //clock_crossing_io/m1 saved-grant select_i2c_clk/s1, which is an e_assign
  assign clock_crossing_io_m1_saved_grant_select_i2c_clk_s1 = clock_crossing_io_m1_requests_select_i2c_clk_s1;

  //allow new arb cycle for select_i2c_clk/s1, which is an e_assign
  assign select_i2c_clk_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign select_i2c_clk_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign select_i2c_clk_s1_master_qreq_vector = 1;

  //select_i2c_clk_s1_reset_n assignment, which is an e_assign
  assign select_i2c_clk_s1_reset_n = reset_n;

  assign select_i2c_clk_s1_chipselect = clock_crossing_io_m1_granted_select_i2c_clk_s1;
  //select_i2c_clk_s1_firsttransfer first transaction, which is an e_assign
  assign select_i2c_clk_s1_firsttransfer = select_i2c_clk_s1_begins_xfer ? select_i2c_clk_s1_unreg_firsttransfer : select_i2c_clk_s1_reg_firsttransfer;

  //select_i2c_clk_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign select_i2c_clk_s1_unreg_firsttransfer = ~(select_i2c_clk_s1_slavearbiterlockenable & select_i2c_clk_s1_any_continuerequest);

  //select_i2c_clk_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          select_i2c_clk_s1_reg_firsttransfer <= 1'b1;
      else if (select_i2c_clk_s1_begins_xfer)
          select_i2c_clk_s1_reg_firsttransfer <= select_i2c_clk_s1_unreg_firsttransfer;
    end


  //select_i2c_clk_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign select_i2c_clk_s1_beginbursttransfer_internal = select_i2c_clk_s1_begins_xfer;

  //~select_i2c_clk_s1_write_n assignment, which is an e_mux
  assign select_i2c_clk_s1_write_n = ~(clock_crossing_io_m1_granted_select_i2c_clk_s1 & clock_crossing_io_m1_write);

  //select_i2c_clk_s1_address mux, which is an e_mux
  assign select_i2c_clk_s1_address = clock_crossing_io_m1_nativeaddress;

  //d1_select_i2c_clk_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_select_i2c_clk_s1_end_xfer <= 1;
      else 
        d1_select_i2c_clk_s1_end_xfer <= select_i2c_clk_s1_end_xfer;
    end


  //select_i2c_clk_s1_waits_for_read in a cycle, which is an e_mux
  assign select_i2c_clk_s1_waits_for_read = select_i2c_clk_s1_in_a_read_cycle & select_i2c_clk_s1_begins_xfer;

  //select_i2c_clk_s1_in_a_read_cycle assignment, which is an e_assign
  assign select_i2c_clk_s1_in_a_read_cycle = clock_crossing_io_m1_granted_select_i2c_clk_s1 & clock_crossing_io_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = select_i2c_clk_s1_in_a_read_cycle;

  //select_i2c_clk_s1_waits_for_write in a cycle, which is an e_mux
  assign select_i2c_clk_s1_waits_for_write = select_i2c_clk_s1_in_a_write_cycle & 0;

  //select_i2c_clk_s1_in_a_write_cycle assignment, which is an e_assign
  assign select_i2c_clk_s1_in_a_write_cycle = clock_crossing_io_m1_granted_select_i2c_clk_s1 & clock_crossing_io_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = select_i2c_clk_s1_in_a_write_cycle;

  assign wait_for_select_i2c_clk_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //select_i2c_clk/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sw_s1_arbitrator (
                          // inputs:
                           clk,
                           clock_crossing_io_m1_address_to_slave,
                           clock_crossing_io_m1_latency_counter,
                           clock_crossing_io_m1_nativeaddress,
                           clock_crossing_io_m1_read,
                           clock_crossing_io_m1_write,
                           clock_crossing_io_m1_writedata,
                           reset_n,
                           sw_s1_irq,
                           sw_s1_readdata,

                          // outputs:
                           clock_crossing_io_m1_granted_sw_s1,
                           clock_crossing_io_m1_qualified_request_sw_s1,
                           clock_crossing_io_m1_read_data_valid_sw_s1,
                           clock_crossing_io_m1_requests_sw_s1,
                           d1_sw_s1_end_xfer,
                           sw_s1_address,
                           sw_s1_chipselect,
                           sw_s1_irq_from_sa,
                           sw_s1_readdata_from_sa,
                           sw_s1_reset_n,
                           sw_s1_write_n,
                           sw_s1_writedata
                        )
;

  output           clock_crossing_io_m1_granted_sw_s1;
  output           clock_crossing_io_m1_qualified_request_sw_s1;
  output           clock_crossing_io_m1_read_data_valid_sw_s1;
  output           clock_crossing_io_m1_requests_sw_s1;
  output           d1_sw_s1_end_xfer;
  output  [  1: 0] sw_s1_address;
  output           sw_s1_chipselect;
  output           sw_s1_irq_from_sa;
  output  [  3: 0] sw_s1_readdata_from_sa;
  output           sw_s1_reset_n;
  output           sw_s1_write_n;
  output  [  3: 0] sw_s1_writedata;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address_to_slave;
  input            clock_crossing_io_m1_latency_counter;
  input   [  4: 0] clock_crossing_io_m1_nativeaddress;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_write;
  input   [ 31: 0] clock_crossing_io_m1_writedata;
  input            reset_n;
  input            sw_s1_irq;
  input   [  3: 0] sw_s1_readdata;

  wire             clock_crossing_io_m1_arbiterlock;
  wire             clock_crossing_io_m1_arbiterlock2;
  wire             clock_crossing_io_m1_continuerequest;
  wire             clock_crossing_io_m1_granted_sw_s1;
  wire             clock_crossing_io_m1_qualified_request_sw_s1;
  wire             clock_crossing_io_m1_read_data_valid_sw_s1;
  wire             clock_crossing_io_m1_requests_sw_s1;
  wire             clock_crossing_io_m1_saved_grant_sw_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sw_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sw_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] sw_s1_address;
  wire             sw_s1_allgrants;
  wire             sw_s1_allow_new_arb_cycle;
  wire             sw_s1_any_bursting_master_saved_grant;
  wire             sw_s1_any_continuerequest;
  wire             sw_s1_arb_counter_enable;
  reg              sw_s1_arb_share_counter;
  wire             sw_s1_arb_share_counter_next_value;
  wire             sw_s1_arb_share_set_values;
  wire             sw_s1_beginbursttransfer_internal;
  wire             sw_s1_begins_xfer;
  wire             sw_s1_chipselect;
  wire             sw_s1_end_xfer;
  wire             sw_s1_firsttransfer;
  wire             sw_s1_grant_vector;
  wire             sw_s1_in_a_read_cycle;
  wire             sw_s1_in_a_write_cycle;
  wire             sw_s1_irq_from_sa;
  wire             sw_s1_master_qreq_vector;
  wire             sw_s1_non_bursting_master_requests;
  wire    [  3: 0] sw_s1_readdata_from_sa;
  reg              sw_s1_reg_firsttransfer;
  wire             sw_s1_reset_n;
  reg              sw_s1_slavearbiterlockenable;
  wire             sw_s1_slavearbiterlockenable2;
  wire             sw_s1_unreg_firsttransfer;
  wire             sw_s1_waits_for_read;
  wire             sw_s1_waits_for_write;
  wire             sw_s1_write_n;
  wire    [  3: 0] sw_s1_writedata;
  wire             wait_for_sw_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sw_s1_end_xfer;
    end


  assign sw_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io_m1_qualified_request_sw_s1));
  //assign sw_s1_readdata_from_sa = sw_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sw_s1_readdata_from_sa = sw_s1_readdata;

  assign clock_crossing_io_m1_requests_sw_s1 = ({clock_crossing_io_m1_address_to_slave[6 : 4] , 4'b0} == 7'h40) & (clock_crossing_io_m1_read | clock_crossing_io_m1_write);
  //sw_s1_arb_share_counter set values, which is an e_mux
  assign sw_s1_arb_share_set_values = 1;

  //sw_s1_non_bursting_master_requests mux, which is an e_mux
  assign sw_s1_non_bursting_master_requests = clock_crossing_io_m1_requests_sw_s1;

  //sw_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sw_s1_any_bursting_master_saved_grant = 0;

  //sw_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sw_s1_arb_share_counter_next_value = sw_s1_firsttransfer ? (sw_s1_arb_share_set_values - 1) : |sw_s1_arb_share_counter ? (sw_s1_arb_share_counter - 1) : 0;

  //sw_s1_allgrants all slave grants, which is an e_mux
  assign sw_s1_allgrants = |sw_s1_grant_vector;

  //sw_s1_end_xfer assignment, which is an e_assign
  assign sw_s1_end_xfer = ~(sw_s1_waits_for_read | sw_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sw_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sw_s1 = sw_s1_end_xfer & (~sw_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sw_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sw_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sw_s1 & sw_s1_allgrants) | (end_xfer_arb_share_counter_term_sw_s1 & ~sw_s1_non_bursting_master_requests);

  //sw_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sw_s1_arb_share_counter <= 0;
      else if (sw_s1_arb_counter_enable)
          sw_s1_arb_share_counter <= sw_s1_arb_share_counter_next_value;
    end


  //sw_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sw_s1_slavearbiterlockenable <= 0;
      else if ((|sw_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sw_s1) | (end_xfer_arb_share_counter_term_sw_s1 & ~sw_s1_non_bursting_master_requests))
          sw_s1_slavearbiterlockenable <= |sw_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io/m1 sw/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock = sw_s1_slavearbiterlockenable & clock_crossing_io_m1_continuerequest;

  //sw_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sw_s1_slavearbiterlockenable2 = |sw_s1_arb_share_counter_next_value;

  //clock_crossing_io/m1 sw/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock2 = sw_s1_slavearbiterlockenable2 & clock_crossing_io_m1_continuerequest;

  //sw_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sw_s1_any_continuerequest = 1;

  //clock_crossing_io_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io_m1_continuerequest = 1;

  assign clock_crossing_io_m1_qualified_request_sw_s1 = clock_crossing_io_m1_requests_sw_s1 & ~((clock_crossing_io_m1_read & ((clock_crossing_io_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io_m1_read_data_valid_sw_s1, which is an e_mux
  assign clock_crossing_io_m1_read_data_valid_sw_s1 = clock_crossing_io_m1_granted_sw_s1 & clock_crossing_io_m1_read & ~sw_s1_waits_for_read;

  //sw_s1_writedata mux, which is an e_mux
  assign sw_s1_writedata = clock_crossing_io_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io_m1_granted_sw_s1 = clock_crossing_io_m1_qualified_request_sw_s1;

  //clock_crossing_io/m1 saved-grant sw/s1, which is an e_assign
  assign clock_crossing_io_m1_saved_grant_sw_s1 = clock_crossing_io_m1_requests_sw_s1;

  //allow new arb cycle for sw/s1, which is an e_assign
  assign sw_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sw_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sw_s1_master_qreq_vector = 1;

  //sw_s1_reset_n assignment, which is an e_assign
  assign sw_s1_reset_n = reset_n;

  assign sw_s1_chipselect = clock_crossing_io_m1_granted_sw_s1;
  //sw_s1_firsttransfer first transaction, which is an e_assign
  assign sw_s1_firsttransfer = sw_s1_begins_xfer ? sw_s1_unreg_firsttransfer : sw_s1_reg_firsttransfer;

  //sw_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sw_s1_unreg_firsttransfer = ~(sw_s1_slavearbiterlockenable & sw_s1_any_continuerequest);

  //sw_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sw_s1_reg_firsttransfer <= 1'b1;
      else if (sw_s1_begins_xfer)
          sw_s1_reg_firsttransfer <= sw_s1_unreg_firsttransfer;
    end


  //sw_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sw_s1_beginbursttransfer_internal = sw_s1_begins_xfer;

  //~sw_s1_write_n assignment, which is an e_mux
  assign sw_s1_write_n = ~(clock_crossing_io_m1_granted_sw_s1 & clock_crossing_io_m1_write);

  //sw_s1_address mux, which is an e_mux
  assign sw_s1_address = clock_crossing_io_m1_nativeaddress;

  //d1_sw_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sw_s1_end_xfer <= 1;
      else 
        d1_sw_s1_end_xfer <= sw_s1_end_xfer;
    end


  //sw_s1_waits_for_read in a cycle, which is an e_mux
  assign sw_s1_waits_for_read = sw_s1_in_a_read_cycle & sw_s1_begins_xfer;

  //sw_s1_in_a_read_cycle assignment, which is an e_assign
  assign sw_s1_in_a_read_cycle = clock_crossing_io_m1_granted_sw_s1 & clock_crossing_io_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sw_s1_in_a_read_cycle;

  //sw_s1_waits_for_write in a cycle, which is an e_mux
  assign sw_s1_waits_for_write = sw_s1_in_a_write_cycle & 0;

  //sw_s1_in_a_write_cycle assignment, which is an e_assign
  assign sw_s1_in_a_write_cycle = clock_crossing_io_m1_granted_sw_s1 & clock_crossing_io_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sw_s1_in_a_write_cycle;

  assign wait_for_sw_s1_counter = 0;
  //assign sw_s1_irq_from_sa = sw_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sw_s1_irq_from_sa = sw_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sw/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         clock_crossing_io_m1_address_to_slave,
                                         clock_crossing_io_m1_latency_counter,
                                         clock_crossing_io_m1_nativeaddress,
                                         clock_crossing_io_m1_read,
                                         clock_crossing_io_m1_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         clock_crossing_io_m1_granted_sysid_control_slave,
                                         clock_crossing_io_m1_qualified_request_sysid_control_slave,
                                         clock_crossing_io_m1_read_data_valid_sysid_control_slave,
                                         clock_crossing_io_m1_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa,
                                         sysid_control_slave_reset_n
                                      )
;

  output           clock_crossing_io_m1_granted_sysid_control_slave;
  output           clock_crossing_io_m1_qualified_request_sysid_control_slave;
  output           clock_crossing_io_m1_read_data_valid_sysid_control_slave;
  output           clock_crossing_io_m1_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  output           sysid_control_slave_reset_n;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address_to_slave;
  input            clock_crossing_io_m1_latency_counter;
  input   [  4: 0] clock_crossing_io_m1_nativeaddress;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             clock_crossing_io_m1_arbiterlock;
  wire             clock_crossing_io_m1_arbiterlock2;
  wire             clock_crossing_io_m1_continuerequest;
  wire             clock_crossing_io_m1_granted_sysid_control_slave;
  wire             clock_crossing_io_m1_qualified_request_sysid_control_slave;
  wire             clock_crossing_io_m1_read_data_valid_sysid_control_slave;
  wire             clock_crossing_io_m1_requests_sysid_control_slave;
  wire             clock_crossing_io_m1_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg              sysid_control_slave_arb_share_counter;
  wire             sysid_control_slave_arb_share_counter_next_value;
  wire             sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  wire             sysid_control_slave_reset_n;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io_m1_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign clock_crossing_io_m1_requests_sysid_control_slave = (({clock_crossing_io_m1_address_to_slave[6 : 3] , 3'b0} == 7'h70) & (clock_crossing_io_m1_read | clock_crossing_io_m1_write)) & clock_crossing_io_m1_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = clock_crossing_io_m1_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //clock_crossing_io/m1 sysid/control_slave arbiterlock, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock = sysid_control_slave_slavearbiterlockenable & clock_crossing_io_m1_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //clock_crossing_io/m1 sysid/control_slave arbiterlock2, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & clock_crossing_io_m1_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //clock_crossing_io_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io_m1_continuerequest = 1;

  assign clock_crossing_io_m1_qualified_request_sysid_control_slave = clock_crossing_io_m1_requests_sysid_control_slave & ~((clock_crossing_io_m1_read & ((clock_crossing_io_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io_m1_read_data_valid_sysid_control_slave, which is an e_mux
  assign clock_crossing_io_m1_read_data_valid_sysid_control_slave = clock_crossing_io_m1_granted_sysid_control_slave & clock_crossing_io_m1_read & ~sysid_control_slave_waits_for_read;

  //master is always granted when requested
  assign clock_crossing_io_m1_granted_sysid_control_slave = clock_crossing_io_m1_qualified_request_sysid_control_slave;

  //clock_crossing_io/m1 saved-grant sysid/control_slave, which is an e_assign
  assign clock_crossing_io_m1_saved_grant_sysid_control_slave = clock_crossing_io_m1_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_reset_n assignment, which is an e_assign
  assign sysid_control_slave_reset_n = reset_n;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = clock_crossing_io_m1_nativeaddress;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = clock_crossing_io_m1_granted_sysid_control_slave & clock_crossing_io_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = clock_crossing_io_m1_granted_sysid_control_slave & clock_crossing_io_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_s1_arbitrator (
                             // inputs:
                              clk,
                              clock_crossing_io_m1_address_to_slave,
                              clock_crossing_io_m1_latency_counter,
                              clock_crossing_io_m1_nativeaddress,
                              clock_crossing_io_m1_read,
                              clock_crossing_io_m1_write,
                              clock_crossing_io_m1_writedata,
                              reset_n,
                              timer_s1_irq,
                              timer_s1_readdata,

                             // outputs:
                              clock_crossing_io_m1_granted_timer_s1,
                              clock_crossing_io_m1_qualified_request_timer_s1,
                              clock_crossing_io_m1_read_data_valid_timer_s1,
                              clock_crossing_io_m1_requests_timer_s1,
                              d1_timer_s1_end_xfer,
                              timer_s1_address,
                              timer_s1_chipselect,
                              timer_s1_irq_from_sa,
                              timer_s1_readdata_from_sa,
                              timer_s1_reset_n,
                              timer_s1_write_n,
                              timer_s1_writedata
                           )
;

  output           clock_crossing_io_m1_granted_timer_s1;
  output           clock_crossing_io_m1_qualified_request_timer_s1;
  output           clock_crossing_io_m1_read_data_valid_timer_s1;
  output           clock_crossing_io_m1_requests_timer_s1;
  output           d1_timer_s1_end_xfer;
  output  [  2: 0] timer_s1_address;
  output           timer_s1_chipselect;
  output           timer_s1_irq_from_sa;
  output  [ 15: 0] timer_s1_readdata_from_sa;
  output           timer_s1_reset_n;
  output           timer_s1_write_n;
  output  [ 15: 0] timer_s1_writedata;
  input            clk;
  input   [  6: 0] clock_crossing_io_m1_address_to_slave;
  input            clock_crossing_io_m1_latency_counter;
  input   [  4: 0] clock_crossing_io_m1_nativeaddress;
  input            clock_crossing_io_m1_read;
  input            clock_crossing_io_m1_write;
  input   [ 31: 0] clock_crossing_io_m1_writedata;
  input            reset_n;
  input            timer_s1_irq;
  input   [ 15: 0] timer_s1_readdata;

  wire             clock_crossing_io_m1_arbiterlock;
  wire             clock_crossing_io_m1_arbiterlock2;
  wire             clock_crossing_io_m1_continuerequest;
  wire             clock_crossing_io_m1_granted_timer_s1;
  wire             clock_crossing_io_m1_qualified_request_timer_s1;
  wire             clock_crossing_io_m1_read_data_valid_timer_s1;
  wire             clock_crossing_io_m1_requests_timer_s1;
  wire             clock_crossing_io_m1_saved_grant_timer_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_allgrants;
  wire             timer_s1_allow_new_arb_cycle;
  wire             timer_s1_any_bursting_master_saved_grant;
  wire             timer_s1_any_continuerequest;
  wire             timer_s1_arb_counter_enable;
  reg              timer_s1_arb_share_counter;
  wire             timer_s1_arb_share_counter_next_value;
  wire             timer_s1_arb_share_set_values;
  wire             timer_s1_beginbursttransfer_internal;
  wire             timer_s1_begins_xfer;
  wire             timer_s1_chipselect;
  wire             timer_s1_end_xfer;
  wire             timer_s1_firsttransfer;
  wire             timer_s1_grant_vector;
  wire             timer_s1_in_a_read_cycle;
  wire             timer_s1_in_a_write_cycle;
  wire             timer_s1_irq_from_sa;
  wire             timer_s1_master_qreq_vector;
  wire             timer_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  reg              timer_s1_reg_firsttransfer;
  wire             timer_s1_reset_n;
  reg              timer_s1_slavearbiterlockenable;
  wire             timer_s1_slavearbiterlockenable2;
  wire             timer_s1_unreg_firsttransfer;
  wire             timer_s1_waits_for_read;
  wire             timer_s1_waits_for_write;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire             wait_for_timer_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~timer_s1_end_xfer;
    end


  assign timer_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_crossing_io_m1_qualified_request_timer_s1));
  //assign timer_s1_readdata_from_sa = timer_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_readdata_from_sa = timer_s1_readdata;

  assign clock_crossing_io_m1_requests_timer_s1 = ({clock_crossing_io_m1_address_to_slave[6 : 5] , 5'b0} == 7'h0) & (clock_crossing_io_m1_read | clock_crossing_io_m1_write);
  //timer_s1_arb_share_counter set values, which is an e_mux
  assign timer_s1_arb_share_set_values = 1;

  //timer_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_s1_non_bursting_master_requests = clock_crossing_io_m1_requests_timer_s1;

  //timer_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_s1_any_bursting_master_saved_grant = 0;

  //timer_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_s1_arb_share_counter_next_value = timer_s1_firsttransfer ? (timer_s1_arb_share_set_values - 1) : |timer_s1_arb_share_counter ? (timer_s1_arb_share_counter - 1) : 0;

  //timer_s1_allgrants all slave grants, which is an e_mux
  assign timer_s1_allgrants = |timer_s1_grant_vector;

  //timer_s1_end_xfer assignment, which is an e_assign
  assign timer_s1_end_xfer = ~(timer_s1_waits_for_read | timer_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_s1 = timer_s1_end_xfer & (~timer_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_s1 & timer_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests);

  //timer_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_arb_share_counter <= 0;
      else if (timer_s1_arb_counter_enable)
          timer_s1_arb_share_counter <= timer_s1_arb_share_counter_next_value;
    end


  //timer_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_slavearbiterlockenable <= 0;
      else if ((|timer_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_s1) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests))
          timer_s1_slavearbiterlockenable <= |timer_s1_arb_share_counter_next_value;
    end


  //clock_crossing_io/m1 timer/s1 arbiterlock, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock = timer_s1_slavearbiterlockenable & clock_crossing_io_m1_continuerequest;

  //timer_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_s1_slavearbiterlockenable2 = |timer_s1_arb_share_counter_next_value;

  //clock_crossing_io/m1 timer/s1 arbiterlock2, which is an e_assign
  assign clock_crossing_io_m1_arbiterlock2 = timer_s1_slavearbiterlockenable2 & clock_crossing_io_m1_continuerequest;

  //timer_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_s1_any_continuerequest = 1;

  //clock_crossing_io_m1_continuerequest continued request, which is an e_assign
  assign clock_crossing_io_m1_continuerequest = 1;

  assign clock_crossing_io_m1_qualified_request_timer_s1 = clock_crossing_io_m1_requests_timer_s1 & ~((clock_crossing_io_m1_read & ((clock_crossing_io_m1_latency_counter != 0))));
  //local readdatavalid clock_crossing_io_m1_read_data_valid_timer_s1, which is an e_mux
  assign clock_crossing_io_m1_read_data_valid_timer_s1 = clock_crossing_io_m1_granted_timer_s1 & clock_crossing_io_m1_read & ~timer_s1_waits_for_read;

  //timer_s1_writedata mux, which is an e_mux
  assign timer_s1_writedata = clock_crossing_io_m1_writedata;

  //master is always granted when requested
  assign clock_crossing_io_m1_granted_timer_s1 = clock_crossing_io_m1_qualified_request_timer_s1;

  //clock_crossing_io/m1 saved-grant timer/s1, which is an e_assign
  assign clock_crossing_io_m1_saved_grant_timer_s1 = clock_crossing_io_m1_requests_timer_s1;

  //allow new arb cycle for timer/s1, which is an e_assign
  assign timer_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_s1_master_qreq_vector = 1;

  //timer_s1_reset_n assignment, which is an e_assign
  assign timer_s1_reset_n = reset_n;

  assign timer_s1_chipselect = clock_crossing_io_m1_granted_timer_s1;
  //timer_s1_firsttransfer first transaction, which is an e_assign
  assign timer_s1_firsttransfer = timer_s1_begins_xfer ? timer_s1_unreg_firsttransfer : timer_s1_reg_firsttransfer;

  //timer_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_s1_unreg_firsttransfer = ~(timer_s1_slavearbiterlockenable & timer_s1_any_continuerequest);

  //timer_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_reg_firsttransfer <= 1'b1;
      else if (timer_s1_begins_xfer)
          timer_s1_reg_firsttransfer <= timer_s1_unreg_firsttransfer;
    end


  //timer_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_s1_beginbursttransfer_internal = timer_s1_begins_xfer;

  //~timer_s1_write_n assignment, which is an e_mux
  assign timer_s1_write_n = ~(clock_crossing_io_m1_granted_timer_s1 & clock_crossing_io_m1_write);

  //timer_s1_address mux, which is an e_mux
  assign timer_s1_address = clock_crossing_io_m1_nativeaddress;

  //d1_timer_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_s1_end_xfer <= 1;
      else 
        d1_timer_s1_end_xfer <= timer_s1_end_xfer;
    end


  //timer_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_s1_waits_for_read = timer_s1_in_a_read_cycle & timer_s1_begins_xfer;

  //timer_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_s1_in_a_read_cycle = clock_crossing_io_m1_granted_timer_s1 & clock_crossing_io_m1_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_s1_in_a_read_cycle;

  //timer_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_s1_waits_for_write = timer_s1_in_a_write_cycle & 0;

  //timer_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_s1_in_a_write_cycle = clock_crossing_io_m1_granted_timer_s1 & clock_crossing_io_m1_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_s1_in_a_write_cycle;

  assign wait_for_timer_s1_counter = 0;
  //assign timer_s1_irq_from_sa = timer_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_irq_from_sa = timer_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_reset_altpll_sys_domain_synch_module (
                                                            // inputs:
                                                             clk,
                                                             data_in,
                                                             reset_n,

                                                            // outputs:
                                                             data_out
                                                          )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_reset_altpll_adc_domain_synch_module (
                                                            // inputs:
                                                             clk,
                                                             data_in,
                                                             reset_n,

                                                            // outputs:
                                                             data_out
                                                          )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_reset_clk_50_domain_synch_module (
                                                        // inputs:
                                                         clk,
                                                         data_in,
                                                         reset_n,

                                                        // outputs:
                                                         data_out
                                                      )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC_reset_altpll_io_domain_synch_module (
                                                           // inputs:
                                                            clk,
                                                            data_in,
                                                            reset_n,

                                                           // outputs:
                                                            data_out
                                                         )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE0_Nano_SOPC (
                       // 1) global signals:
                        altpll_adc,
                        altpll_io,
                        altpll_sdram,
                        altpll_sys,
                        altpll_sys_c3_out,
                        clk_50,
                        reset_n,

                       // the_adc_spi_read
                        SPI_CLK_from_the_adc_spi_read,
                        SPI_CS_n_from_the_adc_spi_read,
                        SPI_IN_to_the_adc_spi_read,
                        SPI_OUT_from_the_adc_spi_read,

                       // the_altpll_sys
                        locked_from_the_altpll_sys,
                        phasedone_from_the_altpll_sys,

                       // the_epcs
                        data0_to_the_epcs,
                        dclk_from_the_epcs,
                        sce_from_the_epcs,
                        sdo_from_the_epcs,

                       // the_g_sensor_int
                        in_port_to_the_g_sensor_int,

                       // the_gsensor_spi
                        SPI_CS_n_from_the_gsensor_spi,
                        SPI_SCLK_from_the_gsensor_spi,
                        SPI_SDIO_to_and_from_the_gsensor_spi,

                       // the_i2c_scl
                        out_port_from_the_i2c_scl,

                       // the_i2c_sda
                        bidir_port_to_and_from_the_i2c_sda,

                       // the_key
                        in_port_to_the_key,

                       // the_led
                        out_port_from_the_led,

                       // the_sdram
                        zs_addr_from_the_sdram,
                        zs_ba_from_the_sdram,
                        zs_cas_n_from_the_sdram,
                        zs_cke_from_the_sdram,
                        zs_cs_n_from_the_sdram,
                        zs_dq_to_and_from_the_sdram,
                        zs_dqm_from_the_sdram,
                        zs_ras_n_from_the_sdram,
                        zs_we_n_from_the_sdram,

                       // the_select_i2c_clk
                        out_port_from_the_select_i2c_clk,

                       // the_sw
                        in_port_to_the_sw
                     )
;

  output           SPI_CLK_from_the_adc_spi_read;
  output           SPI_CS_n_from_the_adc_spi_read;
  output           SPI_CS_n_from_the_gsensor_spi;
  output           SPI_OUT_from_the_adc_spi_read;
  output           SPI_SCLK_from_the_gsensor_spi;
  inout            SPI_SDIO_to_and_from_the_gsensor_spi;
  output           altpll_adc;
  output           altpll_io;
  output           altpll_sdram;
  output           altpll_sys;
  output           altpll_sys_c3_out;
  inout            bidir_port_to_and_from_the_i2c_sda;
  output           dclk_from_the_epcs;
  output           locked_from_the_altpll_sys;
  output           out_port_from_the_i2c_scl;
  output  [  7: 0] out_port_from_the_led;
  output           out_port_from_the_select_i2c_clk;
  output           phasedone_from_the_altpll_sys;
  output           sce_from_the_epcs;
  output           sdo_from_the_epcs;
  output  [ 12: 0] zs_addr_from_the_sdram;
  output  [  1: 0] zs_ba_from_the_sdram;
  output           zs_cas_n_from_the_sdram;
  output           zs_cke_from_the_sdram;
  output           zs_cs_n_from_the_sdram;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram;
  output  [  1: 0] zs_dqm_from_the_sdram;
  output           zs_ras_n_from_the_sdram;
  output           zs_we_n_from_the_sdram;
  input            SPI_IN_to_the_adc_spi_read;
  input            clk_50;
  input            data0_to_the_epcs;
  input            in_port_to_the_g_sensor_int;
  input   [  1: 0] in_port_to_the_key;
  input   [  3: 0] in_port_to_the_sw;
  input            reset_n;

  wire    [  3: 0] DE0_Nano_SOPC_clock_0_in_address;
  wire    [  3: 0] DE0_Nano_SOPC_clock_0_in_byteenable;
  wire             DE0_Nano_SOPC_clock_0_in_endofpacket;
  wire             DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa;
  wire    [  1: 0] DE0_Nano_SOPC_clock_0_in_nativeaddress;
  wire             DE0_Nano_SOPC_clock_0_in_read;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_in_readdata;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_in_readdata_from_sa;
  wire             DE0_Nano_SOPC_clock_0_in_reset_n;
  wire             DE0_Nano_SOPC_clock_0_in_waitrequest;
  wire             DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa;
  wire             DE0_Nano_SOPC_clock_0_in_write;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_in_writedata;
  wire    [  3: 0] DE0_Nano_SOPC_clock_0_out_address;
  wire    [  3: 0] DE0_Nano_SOPC_clock_0_out_address_to_slave;
  wire    [  3: 0] DE0_Nano_SOPC_clock_0_out_byteenable;
  wire             DE0_Nano_SOPC_clock_0_out_endofpacket;
  wire             DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave;
  wire    [  1: 0] DE0_Nano_SOPC_clock_0_out_nativeaddress;
  wire             DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave;
  wire             DE0_Nano_SOPC_clock_0_out_read;
  wire             DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_out_readdata;
  wire             DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave;
  wire             DE0_Nano_SOPC_clock_0_out_reset_n;
  wire             DE0_Nano_SOPC_clock_0_out_waitrequest;
  wire             DE0_Nano_SOPC_clock_0_out_write;
  wire    [ 31: 0] DE0_Nano_SOPC_clock_0_out_writedata;
  wire             DE0_Nano_SOPC_clock_1_in_address;
  wire    [  1: 0] DE0_Nano_SOPC_clock_1_in_byteenable;
  wire             DE0_Nano_SOPC_clock_1_in_endofpacket;
  wire             DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa;
  wire             DE0_Nano_SOPC_clock_1_in_nativeaddress;
  wire             DE0_Nano_SOPC_clock_1_in_read;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_in_readdata;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_in_readdata_from_sa;
  wire             DE0_Nano_SOPC_clock_1_in_reset_n;
  wire             DE0_Nano_SOPC_clock_1_in_waitrequest;
  wire             DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa;
  wire             DE0_Nano_SOPC_clock_1_in_write;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_in_writedata;
  wire             DE0_Nano_SOPC_clock_1_out_address;
  wire             DE0_Nano_SOPC_clock_1_out_address_to_slave;
  wire    [  1: 0] DE0_Nano_SOPC_clock_1_out_byteenable;
  wire             DE0_Nano_SOPC_clock_1_out_endofpacket;
  wire             DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave;
  wire             DE0_Nano_SOPC_clock_1_out_nativeaddress;
  wire             DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave;
  wire             DE0_Nano_SOPC_clock_1_out_read;
  wire             DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_out_readdata;
  wire             DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave;
  wire             DE0_Nano_SOPC_clock_1_out_reset_n;
  wire             DE0_Nano_SOPC_clock_1_out_waitrequest;
  wire             DE0_Nano_SOPC_clock_1_out_write;
  wire    [ 15: 0] DE0_Nano_SOPC_clock_1_out_writedata;
  wire             SPI_CLK_from_the_adc_spi_read;
  wire             SPI_CS_n_from_the_adc_spi_read;
  wire             SPI_CS_n_from_the_gsensor_spi;
  wire             SPI_OUT_from_the_adc_spi_read;
  wire             SPI_SCLK_from_the_gsensor_spi;
  wire             SPI_SDIO_to_and_from_the_gsensor_spi;
  wire             adc_spi_read_slave_chipselect;
  wire             adc_spi_read_slave_read;
  wire    [ 15: 0] adc_spi_read_slave_readdata;
  wire    [ 15: 0] adc_spi_read_slave_readdata_from_sa;
  wire             adc_spi_read_slave_reset_n;
  wire             adc_spi_read_slave_write;
  wire    [ 15: 0] adc_spi_read_slave_writedata;
  wire             altpll_adc;
  wire             altpll_adc_reset_n;
  wire             altpll_io;
  wire             altpll_io_reset_n;
  wire             altpll_sdram;
  wire             altpll_sys;
  wire             altpll_sys_c3_out;
  wire    [  1: 0] altpll_sys_pll_slave_address;
  wire             altpll_sys_pll_slave_read;
  wire    [ 31: 0] altpll_sys_pll_slave_readdata;
  wire    [ 31: 0] altpll_sys_pll_slave_readdata_from_sa;
  wire             altpll_sys_pll_slave_reset;
  wire             altpll_sys_pll_slave_write;
  wire    [ 31: 0] altpll_sys_pll_slave_writedata;
  wire             altpll_sys_reset_n;
  wire             bidir_port_to_and_from_the_i2c_sda;
  wire             clk_50_reset_n;
  wire    [ 11: 0] clock_crossing_io2_m1_address;
  wire    [ 11: 0] clock_crossing_io2_m1_address_to_slave;
  wire    [  3: 0] clock_crossing_io2_m1_byteenable;
  wire             clock_crossing_io2_m1_endofpacket;
  wire             clock_crossing_io2_m1_granted_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_granted_gsensor_spi_slave;
  wire             clock_crossing_io2_m1_granted_i2c_scl_s1;
  wire             clock_crossing_io2_m1_granted_i2c_sda_s1;
  wire             clock_crossing_io2_m1_latency_counter;
  wire    [  9: 0] clock_crossing_io2_m1_nativeaddress;
  wire             clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_qualified_request_gsensor_spi_slave;
  wire             clock_crossing_io2_m1_qualified_request_i2c_scl_s1;
  wire             clock_crossing_io2_m1_qualified_request_i2c_sda_s1;
  wire             clock_crossing_io2_m1_read;
  wire             clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave;
  wire             clock_crossing_io2_m1_read_data_valid_i2c_scl_s1;
  wire             clock_crossing_io2_m1_read_data_valid_i2c_sda_s1;
  wire    [ 31: 0] clock_crossing_io2_m1_readdata;
  wire             clock_crossing_io2_m1_readdatavalid;
  wire             clock_crossing_io2_m1_requests_epcs_epcs_control_port;
  wire             clock_crossing_io2_m1_requests_gsensor_spi_slave;
  wire             clock_crossing_io2_m1_requests_i2c_scl_s1;
  wire             clock_crossing_io2_m1_requests_i2c_sda_s1;
  wire             clock_crossing_io2_m1_reset_n;
  wire             clock_crossing_io2_m1_waitrequest;
  wire             clock_crossing_io2_m1_write;
  wire    [ 31: 0] clock_crossing_io2_m1_writedata;
  wire    [  9: 0] clock_crossing_io2_s1_address;
  wire    [  3: 0] clock_crossing_io2_s1_byteenable;
  wire             clock_crossing_io2_s1_endofpacket;
  wire             clock_crossing_io2_s1_endofpacket_from_sa;
  wire    [  9: 0] clock_crossing_io2_s1_nativeaddress;
  wire             clock_crossing_io2_s1_read;
  wire    [ 31: 0] clock_crossing_io2_s1_readdata;
  wire    [ 31: 0] clock_crossing_io2_s1_readdata_from_sa;
  wire             clock_crossing_io2_s1_readdatavalid;
  wire             clock_crossing_io2_s1_reset_n;
  wire             clock_crossing_io2_s1_waitrequest;
  wire             clock_crossing_io2_s1_waitrequest_from_sa;
  wire             clock_crossing_io2_s1_write;
  wire    [ 31: 0] clock_crossing_io2_s1_writedata;
  wire    [  6: 0] clock_crossing_io_m1_address;
  wire    [  6: 0] clock_crossing_io_m1_address_to_slave;
  wire    [  3: 0] clock_crossing_io_m1_byteenable;
  wire             clock_crossing_io_m1_endofpacket;
  wire             clock_crossing_io_m1_granted_g_sensor_int_s1;
  wire             clock_crossing_io_m1_granted_key_s1;
  wire             clock_crossing_io_m1_granted_led_s1;
  wire             clock_crossing_io_m1_granted_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_granted_sw_s1;
  wire             clock_crossing_io_m1_granted_sysid_control_slave;
  wire             clock_crossing_io_m1_granted_timer_s1;
  wire             clock_crossing_io_m1_latency_counter;
  wire    [  4: 0] clock_crossing_io_m1_nativeaddress;
  wire             clock_crossing_io_m1_qualified_request_g_sensor_int_s1;
  wire             clock_crossing_io_m1_qualified_request_key_s1;
  wire             clock_crossing_io_m1_qualified_request_led_s1;
  wire             clock_crossing_io_m1_qualified_request_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_qualified_request_sw_s1;
  wire             clock_crossing_io_m1_qualified_request_sysid_control_slave;
  wire             clock_crossing_io_m1_qualified_request_timer_s1;
  wire             clock_crossing_io_m1_read;
  wire             clock_crossing_io_m1_read_data_valid_g_sensor_int_s1;
  wire             clock_crossing_io_m1_read_data_valid_key_s1;
  wire             clock_crossing_io_m1_read_data_valid_led_s1;
  wire             clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_read_data_valid_sw_s1;
  wire             clock_crossing_io_m1_read_data_valid_sysid_control_slave;
  wire             clock_crossing_io_m1_read_data_valid_timer_s1;
  wire    [ 31: 0] clock_crossing_io_m1_readdata;
  wire             clock_crossing_io_m1_readdatavalid;
  wire             clock_crossing_io_m1_requests_g_sensor_int_s1;
  wire             clock_crossing_io_m1_requests_key_s1;
  wire             clock_crossing_io_m1_requests_led_s1;
  wire             clock_crossing_io_m1_requests_select_i2c_clk_s1;
  wire             clock_crossing_io_m1_requests_sw_s1;
  wire             clock_crossing_io_m1_requests_sysid_control_slave;
  wire             clock_crossing_io_m1_requests_timer_s1;
  wire             clock_crossing_io_m1_reset_n;
  wire             clock_crossing_io_m1_waitrequest;
  wire             clock_crossing_io_m1_write;
  wire    [ 31: 0] clock_crossing_io_m1_writedata;
  wire    [  4: 0] clock_crossing_io_s1_address;
  wire    [  3: 0] clock_crossing_io_s1_byteenable;
  wire             clock_crossing_io_s1_endofpacket;
  wire             clock_crossing_io_s1_endofpacket_from_sa;
  wire    [  4: 0] clock_crossing_io_s1_nativeaddress;
  wire             clock_crossing_io_s1_read;
  wire    [ 31: 0] clock_crossing_io_s1_readdata;
  wire    [ 31: 0] clock_crossing_io_s1_readdata_from_sa;
  wire             clock_crossing_io_s1_readdatavalid;
  wire             clock_crossing_io_s1_reset_n;
  wire             clock_crossing_io_s1_waitrequest;
  wire             clock_crossing_io_s1_waitrequest_from_sa;
  wire             clock_crossing_io_s1_write;
  wire    [ 31: 0] clock_crossing_io_s1_writedata;
  wire    [ 26: 0] cpu_data_master_address;
  wire    [ 26: 0] cpu_data_master_address_to_slave;
  wire    [  3: 0] cpu_data_master_byteenable;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1;
  wire    [  1: 0] cpu_data_master_dbs_address;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire             cpu_data_master_debugaccess;
  wire             cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_granted_clock_crossing_io2_s1;
  wire             cpu_data_master_granted_clock_crossing_io_s1;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_granted_sdram_s1;
  wire    [ 31: 0] cpu_data_master_irq;
  wire             cpu_data_master_latency_counter;
  wire             cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_qualified_request_clock_crossing_io2_s1;
  wire             cpu_data_master_qualified_request_clock_crossing_io_s1;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_sdram_s1;
  wire             cpu_data_master_read;
  wire             cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_read_data_valid_clock_crossing_io2_s1;
  wire             cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register;
  wire             cpu_data_master_read_data_valid_clock_crossing_io_s1;
  wire             cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1_shift_register;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_readdatavalid;
  wire             cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in;
  wire             cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in;
  wire             cpu_data_master_requests_clock_crossing_io2_s1;
  wire             cpu_data_master_requests_clock_crossing_io_s1;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_sdram_s1;
  wire             cpu_data_master_waitrequest;
  wire             cpu_data_master_write;
  wire    [ 31: 0] cpu_data_master_writedata;
  wire    [ 26: 0] cpu_instruction_master_address;
  wire    [ 26: 0] cpu_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_instruction_master_dbs_address;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_granted_sdram_s1;
  wire             cpu_instruction_master_latency_counter;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_sdram_s1;
  wire             cpu_instruction_master_read;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_sdram_s1;
  wire             cpu_instruction_master_waitrequest;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire             cpu_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  wire             d1_DE0_Nano_SOPC_clock_0_in_end_xfer;
  wire             d1_DE0_Nano_SOPC_clock_1_in_end_xfer;
  wire             d1_adc_spi_read_slave_end_xfer;
  wire             d1_altpll_sys_pll_slave_end_xfer;
  wire             d1_clock_crossing_io2_s1_end_xfer;
  wire             d1_clock_crossing_io_s1_end_xfer;
  wire             d1_cpu_jtag_debug_module_end_xfer;
  wire             d1_epcs_epcs_control_port_end_xfer;
  wire             d1_g_sensor_int_s1_end_xfer;
  wire             d1_gsensor_spi_slave_end_xfer;
  wire             d1_i2c_scl_s1_end_xfer;
  wire             d1_i2c_sda_s1_end_xfer;
  wire             d1_jtag_uart_avalon_jtag_slave_end_xfer;
  wire             d1_key_s1_end_xfer;
  wire             d1_led_s1_end_xfer;
  wire             d1_sdram_s1_end_xfer;
  wire             d1_select_i2c_clk_s1_end_xfer;
  wire             d1_sw_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_timer_s1_end_xfer;
  wire             dclk_from_the_epcs;
  wire    [  8: 0] epcs_epcs_control_port_address;
  wire             epcs_epcs_control_port_chipselect;
  wire             epcs_epcs_control_port_dataavailable;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_endofpacket;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_irq;
  wire             epcs_epcs_control_port_irq_from_sa;
  wire             epcs_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_epcs_control_port_readdata;
  wire    [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  wire             epcs_epcs_control_port_readyfordata;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  wire             epcs_epcs_control_port_reset_n;
  wire             epcs_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_epcs_control_port_writedata;
  wire    [  1: 0] g_sensor_int_s1_address;
  wire             g_sensor_int_s1_chipselect;
  wire             g_sensor_int_s1_irq;
  wire             g_sensor_int_s1_irq_from_sa;
  wire             g_sensor_int_s1_readdata;
  wire             g_sensor_int_s1_readdata_from_sa;
  wire             g_sensor_int_s1_reset_n;
  wire             g_sensor_int_s1_write_n;
  wire             g_sensor_int_s1_writedata;
  wire    [  3: 0] gsensor_spi_slave_address;
  wire             gsensor_spi_slave_chipselect;
  wire             gsensor_spi_slave_read;
  wire    [  7: 0] gsensor_spi_slave_readdata;
  wire    [  7: 0] gsensor_spi_slave_readdata_from_sa;
  wire             gsensor_spi_slave_reset_n;
  wire             gsensor_spi_slave_write;
  wire    [  7: 0] gsensor_spi_slave_writedata;
  wire    [  1: 0] i2c_scl_s1_address;
  wire             i2c_scl_s1_chipselect;
  wire             i2c_scl_s1_readdata;
  wire             i2c_scl_s1_readdata_from_sa;
  wire             i2c_scl_s1_reset_n;
  wire             i2c_scl_s1_write_n;
  wire             i2c_scl_s1_writedata;
  wire    [  1: 0] i2c_sda_s1_address;
  wire             i2c_sda_s1_chipselect;
  wire             i2c_sda_s1_readdata;
  wire             i2c_sda_s1_readdata_from_sa;
  wire             i2c_sda_s1_reset_n;
  wire             i2c_sda_s1_write_n;
  wire             i2c_sda_s1_writedata;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_irq;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  wire             jtag_uart_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [  1: 0] key_s1_address;
  wire             key_s1_chipselect;
  wire             key_s1_irq;
  wire             key_s1_irq_from_sa;
  wire    [  1: 0] key_s1_readdata;
  wire    [  1: 0] key_s1_readdata_from_sa;
  wire             key_s1_reset_n;
  wire             key_s1_write_n;
  wire    [  1: 0] key_s1_writedata;
  wire    [  1: 0] led_s1_address;
  wire             led_s1_chipselect;
  wire    [  7: 0] led_s1_readdata;
  wire    [  7: 0] led_s1_readdata_from_sa;
  wire             led_s1_reset_n;
  wire             led_s1_write_n;
  wire    [  7: 0] led_s1_writedata;
  wire             locked_from_the_altpll_sys;
  wire             out_clk_altpll_sys_c0;
  wire             out_clk_altpll_sys_c1;
  wire             out_clk_altpll_sys_c2;
  wire             out_clk_altpll_sys_c3;
  wire             out_clk_altpll_sys_c4;
  wire             out_port_from_the_i2c_scl;
  wire    [  7: 0] out_port_from_the_led;
  wire             out_port_from_the_select_i2c_clk;
  wire             phasedone_from_the_altpll_sys;
  wire             reset_n_sources;
  wire             sce_from_the_epcs;
  wire             sdo_from_the_epcs;
  wire    [ 23: 0] sdram_s1_address;
  wire    [  1: 0] sdram_s1_byteenable_n;
  wire             sdram_s1_chipselect;
  wire             sdram_s1_read_n;
  wire    [ 15: 0] sdram_s1_readdata;
  wire    [ 15: 0] sdram_s1_readdata_from_sa;
  wire             sdram_s1_readdatavalid;
  wire             sdram_s1_reset_n;
  wire             sdram_s1_waitrequest;
  wire             sdram_s1_waitrequest_from_sa;
  wire             sdram_s1_write_n;
  wire    [ 15: 0] sdram_s1_writedata;
  wire    [  1: 0] select_i2c_clk_s1_address;
  wire             select_i2c_clk_s1_chipselect;
  wire             select_i2c_clk_s1_readdata;
  wire             select_i2c_clk_s1_readdata_from_sa;
  wire             select_i2c_clk_s1_reset_n;
  wire             select_i2c_clk_s1_write_n;
  wire             select_i2c_clk_s1_writedata;
  wire    [  1: 0] sw_s1_address;
  wire             sw_s1_chipselect;
  wire             sw_s1_irq;
  wire             sw_s1_irq_from_sa;
  wire    [  3: 0] sw_s1_readdata;
  wire    [  3: 0] sw_s1_readdata_from_sa;
  wire             sw_s1_reset_n;
  wire             sw_s1_write_n;
  wire    [  3: 0] sw_s1_writedata;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_clock;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire             sysid_control_slave_reset_n;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_chipselect;
  wire             timer_s1_irq;
  wire             timer_s1_irq_from_sa;
  wire    [ 15: 0] timer_s1_readdata;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  wire             timer_s1_reset_n;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire    [ 12: 0] zs_addr_from_the_sdram;
  wire    [  1: 0] zs_ba_from_the_sdram;
  wire             zs_cas_n_from_the_sdram;
  wire             zs_cke_from_the_sdram;
  wire             zs_cs_n_from_the_sdram;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram;
  wire    [  1: 0] zs_dqm_from_the_sdram;
  wire             zs_ras_n_from_the_sdram;
  wire             zs_we_n_from_the_sdram;
  DE0_Nano_SOPC_clock_0_in_arbitrator the_DE0_Nano_SOPC_clock_0_in
    (
      .DE0_Nano_SOPC_clock_0_in_address                                     (DE0_Nano_SOPC_clock_0_in_address),
      .DE0_Nano_SOPC_clock_0_in_byteenable                                  (DE0_Nano_SOPC_clock_0_in_byteenable),
      .DE0_Nano_SOPC_clock_0_in_endofpacket                                 (DE0_Nano_SOPC_clock_0_in_endofpacket),
      .DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa                         (DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa),
      .DE0_Nano_SOPC_clock_0_in_nativeaddress                               (DE0_Nano_SOPC_clock_0_in_nativeaddress),
      .DE0_Nano_SOPC_clock_0_in_read                                        (DE0_Nano_SOPC_clock_0_in_read),
      .DE0_Nano_SOPC_clock_0_in_readdata                                    (DE0_Nano_SOPC_clock_0_in_readdata),
      .DE0_Nano_SOPC_clock_0_in_readdata_from_sa                            (DE0_Nano_SOPC_clock_0_in_readdata_from_sa),
      .DE0_Nano_SOPC_clock_0_in_reset_n                                     (DE0_Nano_SOPC_clock_0_in_reset_n),
      .DE0_Nano_SOPC_clock_0_in_waitrequest                                 (DE0_Nano_SOPC_clock_0_in_waitrequest),
      .DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa                         (DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa),
      .DE0_Nano_SOPC_clock_0_in_write                                       (DE0_Nano_SOPC_clock_0_in_write),
      .DE0_Nano_SOPC_clock_0_in_writedata                                   (DE0_Nano_SOPC_clock_0_in_writedata),
      .clk                                                                  (altpll_sys),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                           (cpu_data_master_byteenable),
      .cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in                     (cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in           (cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in             (cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in                    (cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_data_master_writedata                                            (cpu_data_master_writedata),
      .d1_DE0_Nano_SOPC_clock_0_in_end_xfer                                 (d1_DE0_Nano_SOPC_clock_0_in_end_xfer),
      .reset_n                                                              (altpll_sys_reset_n)
    );

  DE0_Nano_SOPC_clock_0_out_arbitrator the_DE0_Nano_SOPC_clock_0_out
    (
      .DE0_Nano_SOPC_clock_0_out_address                                (DE0_Nano_SOPC_clock_0_out_address),
      .DE0_Nano_SOPC_clock_0_out_address_to_slave                       (DE0_Nano_SOPC_clock_0_out_address_to_slave),
      .DE0_Nano_SOPC_clock_0_out_byteenable                             (DE0_Nano_SOPC_clock_0_out_byteenable),
      .DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave           (DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave (DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_read                                   (DE0_Nano_SOPC_clock_0_out_read),
      .DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave   (DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_readdata                               (DE0_Nano_SOPC_clock_0_out_readdata),
      .DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave          (DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_reset_n                                (DE0_Nano_SOPC_clock_0_out_reset_n),
      .DE0_Nano_SOPC_clock_0_out_waitrequest                            (DE0_Nano_SOPC_clock_0_out_waitrequest),
      .DE0_Nano_SOPC_clock_0_out_write                                  (DE0_Nano_SOPC_clock_0_out_write),
      .DE0_Nano_SOPC_clock_0_out_writedata                              (DE0_Nano_SOPC_clock_0_out_writedata),
      .altpll_sys_pll_slave_readdata_from_sa                            (altpll_sys_pll_slave_readdata_from_sa),
      .clk                                                              (clk_50),
      .d1_altpll_sys_pll_slave_end_xfer                                 (d1_altpll_sys_pll_slave_end_xfer),
      .reset_n                                                          (clk_50_reset_n)
    );

  DE0_Nano_SOPC_clock_0 the_DE0_Nano_SOPC_clock_0
    (
      .master_address       (DE0_Nano_SOPC_clock_0_out_address),
      .master_byteenable    (DE0_Nano_SOPC_clock_0_out_byteenable),
      .master_clk           (clk_50),
      .master_endofpacket   (DE0_Nano_SOPC_clock_0_out_endofpacket),
      .master_nativeaddress (DE0_Nano_SOPC_clock_0_out_nativeaddress),
      .master_read          (DE0_Nano_SOPC_clock_0_out_read),
      .master_readdata      (DE0_Nano_SOPC_clock_0_out_readdata),
      .master_reset_n       (DE0_Nano_SOPC_clock_0_out_reset_n),
      .master_waitrequest   (DE0_Nano_SOPC_clock_0_out_waitrequest),
      .master_write         (DE0_Nano_SOPC_clock_0_out_write),
      .master_writedata     (DE0_Nano_SOPC_clock_0_out_writedata),
      .slave_address        (DE0_Nano_SOPC_clock_0_in_address),
      .slave_byteenable     (DE0_Nano_SOPC_clock_0_in_byteenable),
      .slave_clk            (altpll_sys),
      .slave_endofpacket    (DE0_Nano_SOPC_clock_0_in_endofpacket),
      .slave_nativeaddress  (DE0_Nano_SOPC_clock_0_in_nativeaddress),
      .slave_read           (DE0_Nano_SOPC_clock_0_in_read),
      .slave_readdata       (DE0_Nano_SOPC_clock_0_in_readdata),
      .slave_reset_n        (DE0_Nano_SOPC_clock_0_in_reset_n),
      .slave_waitrequest    (DE0_Nano_SOPC_clock_0_in_waitrequest),
      .slave_write          (DE0_Nano_SOPC_clock_0_in_write),
      .slave_writedata      (DE0_Nano_SOPC_clock_0_in_writedata)
    );

  DE0_Nano_SOPC_clock_1_in_arbitrator the_DE0_Nano_SOPC_clock_1_in
    (
      .DE0_Nano_SOPC_clock_1_in_address                                     (DE0_Nano_SOPC_clock_1_in_address),
      .DE0_Nano_SOPC_clock_1_in_byteenable                                  (DE0_Nano_SOPC_clock_1_in_byteenable),
      .DE0_Nano_SOPC_clock_1_in_endofpacket                                 (DE0_Nano_SOPC_clock_1_in_endofpacket),
      .DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa                         (DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa),
      .DE0_Nano_SOPC_clock_1_in_nativeaddress                               (DE0_Nano_SOPC_clock_1_in_nativeaddress),
      .DE0_Nano_SOPC_clock_1_in_read                                        (DE0_Nano_SOPC_clock_1_in_read),
      .DE0_Nano_SOPC_clock_1_in_readdata                                    (DE0_Nano_SOPC_clock_1_in_readdata),
      .DE0_Nano_SOPC_clock_1_in_readdata_from_sa                            (DE0_Nano_SOPC_clock_1_in_readdata_from_sa),
      .DE0_Nano_SOPC_clock_1_in_reset_n                                     (DE0_Nano_SOPC_clock_1_in_reset_n),
      .DE0_Nano_SOPC_clock_1_in_waitrequest                                 (DE0_Nano_SOPC_clock_1_in_waitrequest),
      .DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa                         (DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa),
      .DE0_Nano_SOPC_clock_1_in_write                                       (DE0_Nano_SOPC_clock_1_in_write),
      .DE0_Nano_SOPC_clock_1_in_writedata                                   (DE0_Nano_SOPC_clock_1_in_writedata),
      .clk                                                                  (altpll_sys),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                           (cpu_data_master_byteenable),
      .cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in                     (cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in           (cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in             (cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in                    (cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_data_master_writedata                                            (cpu_data_master_writedata),
      .d1_DE0_Nano_SOPC_clock_1_in_end_xfer                                 (d1_DE0_Nano_SOPC_clock_1_in_end_xfer),
      .reset_n                                                              (altpll_sys_reset_n)
    );

  DE0_Nano_SOPC_clock_1_out_arbitrator the_DE0_Nano_SOPC_clock_1_out
    (
      .DE0_Nano_SOPC_clock_1_out_address                              (DE0_Nano_SOPC_clock_1_out_address),
      .DE0_Nano_SOPC_clock_1_out_address_to_slave                     (DE0_Nano_SOPC_clock_1_out_address_to_slave),
      .DE0_Nano_SOPC_clock_1_out_byteenable                           (DE0_Nano_SOPC_clock_1_out_byteenable),
      .DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave           (DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave (DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_read                                 (DE0_Nano_SOPC_clock_1_out_read),
      .DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave   (DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_readdata                             (DE0_Nano_SOPC_clock_1_out_readdata),
      .DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave          (DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_reset_n                              (DE0_Nano_SOPC_clock_1_out_reset_n),
      .DE0_Nano_SOPC_clock_1_out_waitrequest                          (DE0_Nano_SOPC_clock_1_out_waitrequest),
      .DE0_Nano_SOPC_clock_1_out_write                                (DE0_Nano_SOPC_clock_1_out_write),
      .DE0_Nano_SOPC_clock_1_out_writedata                            (DE0_Nano_SOPC_clock_1_out_writedata),
      .adc_spi_read_slave_readdata_from_sa                            (adc_spi_read_slave_readdata_from_sa),
      .clk                                                            (altpll_adc),
      .d1_adc_spi_read_slave_end_xfer                                 (d1_adc_spi_read_slave_end_xfer),
      .reset_n                                                        (altpll_adc_reset_n)
    );

  DE0_Nano_SOPC_clock_1 the_DE0_Nano_SOPC_clock_1
    (
      .master_address       (DE0_Nano_SOPC_clock_1_out_address),
      .master_byteenable    (DE0_Nano_SOPC_clock_1_out_byteenable),
      .master_clk           (altpll_adc),
      .master_endofpacket   (DE0_Nano_SOPC_clock_1_out_endofpacket),
      .master_nativeaddress (DE0_Nano_SOPC_clock_1_out_nativeaddress),
      .master_read          (DE0_Nano_SOPC_clock_1_out_read),
      .master_readdata      (DE0_Nano_SOPC_clock_1_out_readdata),
      .master_reset_n       (DE0_Nano_SOPC_clock_1_out_reset_n),
      .master_waitrequest   (DE0_Nano_SOPC_clock_1_out_waitrequest),
      .master_write         (DE0_Nano_SOPC_clock_1_out_write),
      .master_writedata     (DE0_Nano_SOPC_clock_1_out_writedata),
      .slave_address        (DE0_Nano_SOPC_clock_1_in_address),
      .slave_byteenable     (DE0_Nano_SOPC_clock_1_in_byteenable),
      .slave_clk            (altpll_sys),
      .slave_endofpacket    (DE0_Nano_SOPC_clock_1_in_endofpacket),
      .slave_nativeaddress  (DE0_Nano_SOPC_clock_1_in_nativeaddress),
      .slave_read           (DE0_Nano_SOPC_clock_1_in_read),
      .slave_readdata       (DE0_Nano_SOPC_clock_1_in_readdata),
      .slave_reset_n        (DE0_Nano_SOPC_clock_1_in_reset_n),
      .slave_waitrequest    (DE0_Nano_SOPC_clock_1_in_waitrequest),
      .slave_write          (DE0_Nano_SOPC_clock_1_in_write),
      .slave_writedata      (DE0_Nano_SOPC_clock_1_in_writedata)
    );

  adc_spi_read_slave_arbitrator the_adc_spi_read_slave
    (
      .DE0_Nano_SOPC_clock_1_out_address_to_slave                     (DE0_Nano_SOPC_clock_1_out_address_to_slave),
      .DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave           (DE0_Nano_SOPC_clock_1_out_granted_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave (DE0_Nano_SOPC_clock_1_out_qualified_request_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_read                                 (DE0_Nano_SOPC_clock_1_out_read),
      .DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave   (DE0_Nano_SOPC_clock_1_out_read_data_valid_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave          (DE0_Nano_SOPC_clock_1_out_requests_adc_spi_read_slave),
      .DE0_Nano_SOPC_clock_1_out_write                                (DE0_Nano_SOPC_clock_1_out_write),
      .DE0_Nano_SOPC_clock_1_out_writedata                            (DE0_Nano_SOPC_clock_1_out_writedata),
      .adc_spi_read_slave_chipselect                                  (adc_spi_read_slave_chipselect),
      .adc_spi_read_slave_read                                        (adc_spi_read_slave_read),
      .adc_spi_read_slave_readdata                                    (adc_spi_read_slave_readdata),
      .adc_spi_read_slave_readdata_from_sa                            (adc_spi_read_slave_readdata_from_sa),
      .adc_spi_read_slave_reset_n                                     (adc_spi_read_slave_reset_n),
      .adc_spi_read_slave_write                                       (adc_spi_read_slave_write),
      .adc_spi_read_slave_writedata                                   (adc_spi_read_slave_writedata),
      .clk                                                            (altpll_adc),
      .d1_adc_spi_read_slave_end_xfer                                 (d1_adc_spi_read_slave_end_xfer),
      .reset_n                                                        (altpll_adc_reset_n)
    );

  adc_spi_read the_adc_spi_read
    (
      .SPI_CLK      (SPI_CLK_from_the_adc_spi_read),
      .SPI_CS_n     (SPI_CS_n_from_the_adc_spi_read),
      .SPI_IN       (SPI_IN_to_the_adc_spi_read),
      .SPI_OUT      (SPI_OUT_from_the_adc_spi_read),
      .clk          (altpll_adc),
      .reset_n      (adc_spi_read_slave_reset_n),
      .s_chipselect (adc_spi_read_slave_chipselect),
      .s_read       (adc_spi_read_slave_read),
      .s_readdata   (adc_spi_read_slave_readdata),
      .s_write      (adc_spi_read_slave_write),
      .s_writedata  (adc_spi_read_slave_writedata)
    );

  altpll_sys_pll_slave_arbitrator the_altpll_sys_pll_slave
    (
      .DE0_Nano_SOPC_clock_0_out_address_to_slave                       (DE0_Nano_SOPC_clock_0_out_address_to_slave),
      .DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave           (DE0_Nano_SOPC_clock_0_out_granted_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave (DE0_Nano_SOPC_clock_0_out_qualified_request_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_read                                   (DE0_Nano_SOPC_clock_0_out_read),
      .DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave   (DE0_Nano_SOPC_clock_0_out_read_data_valid_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave          (DE0_Nano_SOPC_clock_0_out_requests_altpll_sys_pll_slave),
      .DE0_Nano_SOPC_clock_0_out_write                                  (DE0_Nano_SOPC_clock_0_out_write),
      .DE0_Nano_SOPC_clock_0_out_writedata                              (DE0_Nano_SOPC_clock_0_out_writedata),
      .altpll_sys_pll_slave_address                                     (altpll_sys_pll_slave_address),
      .altpll_sys_pll_slave_read                                        (altpll_sys_pll_slave_read),
      .altpll_sys_pll_slave_readdata                                    (altpll_sys_pll_slave_readdata),
      .altpll_sys_pll_slave_readdata_from_sa                            (altpll_sys_pll_slave_readdata_from_sa),
      .altpll_sys_pll_slave_reset                                       (altpll_sys_pll_slave_reset),
      .altpll_sys_pll_slave_write                                       (altpll_sys_pll_slave_write),
      .altpll_sys_pll_slave_writedata                                   (altpll_sys_pll_slave_writedata),
      .clk                                                              (clk_50),
      .d1_altpll_sys_pll_slave_end_xfer                                 (d1_altpll_sys_pll_slave_end_xfer),
      .reset_n                                                          (clk_50_reset_n)
    );

  //altpll_sys out_clk assignment, which is an e_assign
  assign altpll_sys = out_clk_altpll_sys_c0;

  //altpll_sdram out_clk assignment, which is an e_assign
  assign altpll_sdram = out_clk_altpll_sys_c1;

  //altpll_io out_clk assignment, which is an e_assign
  assign altpll_io = out_clk_altpll_sys_c2;

  //altpll_sys_c3_out out_clk assignment, which is an e_assign
  assign altpll_sys_c3_out = out_clk_altpll_sys_c3;

  //altpll_adc out_clk assignment, which is an e_assign
  assign altpll_adc = out_clk_altpll_sys_c4;

  altpll_sys the_altpll_sys
    (
      .address   (altpll_sys_pll_slave_address),
      .c0        (out_clk_altpll_sys_c0),
      .c1        (out_clk_altpll_sys_c1),
      .c2        (out_clk_altpll_sys_c2),
      .c3        (out_clk_altpll_sys_c3),
      .c4        (out_clk_altpll_sys_c4),
      .clk       (clk_50),
      .locked    (locked_from_the_altpll_sys),
      .phasedone (phasedone_from_the_altpll_sys),
      .read      (altpll_sys_pll_slave_read),
      .readdata  (altpll_sys_pll_slave_readdata),
      .reset     (altpll_sys_pll_slave_reset),
      .write     (altpll_sys_pll_slave_write),
      .writedata (altpll_sys_pll_slave_writedata)
    );

  clock_crossing_io_s1_arbitrator the_clock_crossing_io_s1
    (
      .clk                                                                  (altpll_sys),
      .clock_crossing_io_s1_address                                         (clock_crossing_io_s1_address),
      .clock_crossing_io_s1_byteenable                                      (clock_crossing_io_s1_byteenable),
      .clock_crossing_io_s1_endofpacket                                     (clock_crossing_io_s1_endofpacket),
      .clock_crossing_io_s1_endofpacket_from_sa                             (clock_crossing_io_s1_endofpacket_from_sa),
      .clock_crossing_io_s1_nativeaddress                                   (clock_crossing_io_s1_nativeaddress),
      .clock_crossing_io_s1_read                                            (clock_crossing_io_s1_read),
      .clock_crossing_io_s1_readdata                                        (clock_crossing_io_s1_readdata),
      .clock_crossing_io_s1_readdata_from_sa                                (clock_crossing_io_s1_readdata_from_sa),
      .clock_crossing_io_s1_readdatavalid                                   (clock_crossing_io_s1_readdatavalid),
      .clock_crossing_io_s1_reset_n                                         (clock_crossing_io_s1_reset_n),
      .clock_crossing_io_s1_waitrequest                                     (clock_crossing_io_s1_waitrequest),
      .clock_crossing_io_s1_waitrequest_from_sa                             (clock_crossing_io_s1_waitrequest_from_sa),
      .clock_crossing_io_s1_write                                           (clock_crossing_io_s1_write),
      .clock_crossing_io_s1_writedata                                       (clock_crossing_io_s1_writedata),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                           (cpu_data_master_byteenable),
      .cpu_data_master_granted_clock_crossing_io_s1                         (cpu_data_master_granted_clock_crossing_io_s1),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_clock_crossing_io_s1               (cpu_data_master_qualified_request_clock_crossing_io_s1),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1                 (cpu_data_master_read_data_valid_clock_crossing_io_s1),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_clock_crossing_io_s1                        (cpu_data_master_requests_clock_crossing_io_s1),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_data_master_writedata                                            (cpu_data_master_writedata),
      .d1_clock_crossing_io_s1_end_xfer                                     (d1_clock_crossing_io_s1_end_xfer),
      .reset_n                                                              (altpll_sys_reset_n)
    );

  clock_crossing_io_m1_arbitrator the_clock_crossing_io_m1
    (
      .clk                                                        (altpll_io),
      .clock_crossing_io_m1_address                               (clock_crossing_io_m1_address),
      .clock_crossing_io_m1_address_to_slave                      (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_byteenable                            (clock_crossing_io_m1_byteenable),
      .clock_crossing_io_m1_granted_g_sensor_int_s1               (clock_crossing_io_m1_granted_g_sensor_int_s1),
      .clock_crossing_io_m1_granted_key_s1                        (clock_crossing_io_m1_granted_key_s1),
      .clock_crossing_io_m1_granted_led_s1                        (clock_crossing_io_m1_granted_led_s1),
      .clock_crossing_io_m1_granted_select_i2c_clk_s1             (clock_crossing_io_m1_granted_select_i2c_clk_s1),
      .clock_crossing_io_m1_granted_sw_s1                         (clock_crossing_io_m1_granted_sw_s1),
      .clock_crossing_io_m1_granted_sysid_control_slave           (clock_crossing_io_m1_granted_sysid_control_slave),
      .clock_crossing_io_m1_granted_timer_s1                      (clock_crossing_io_m1_granted_timer_s1),
      .clock_crossing_io_m1_latency_counter                       (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_qualified_request_g_sensor_int_s1     (clock_crossing_io_m1_qualified_request_g_sensor_int_s1),
      .clock_crossing_io_m1_qualified_request_key_s1              (clock_crossing_io_m1_qualified_request_key_s1),
      .clock_crossing_io_m1_qualified_request_led_s1              (clock_crossing_io_m1_qualified_request_led_s1),
      .clock_crossing_io_m1_qualified_request_select_i2c_clk_s1   (clock_crossing_io_m1_qualified_request_select_i2c_clk_s1),
      .clock_crossing_io_m1_qualified_request_sw_s1               (clock_crossing_io_m1_qualified_request_sw_s1),
      .clock_crossing_io_m1_qualified_request_sysid_control_slave (clock_crossing_io_m1_qualified_request_sysid_control_slave),
      .clock_crossing_io_m1_qualified_request_timer_s1            (clock_crossing_io_m1_qualified_request_timer_s1),
      .clock_crossing_io_m1_read                                  (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_g_sensor_int_s1       (clock_crossing_io_m1_read_data_valid_g_sensor_int_s1),
      .clock_crossing_io_m1_read_data_valid_key_s1                (clock_crossing_io_m1_read_data_valid_key_s1),
      .clock_crossing_io_m1_read_data_valid_led_s1                (clock_crossing_io_m1_read_data_valid_led_s1),
      .clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1     (clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1),
      .clock_crossing_io_m1_read_data_valid_sw_s1                 (clock_crossing_io_m1_read_data_valid_sw_s1),
      .clock_crossing_io_m1_read_data_valid_sysid_control_slave   (clock_crossing_io_m1_read_data_valid_sysid_control_slave),
      .clock_crossing_io_m1_read_data_valid_timer_s1              (clock_crossing_io_m1_read_data_valid_timer_s1),
      .clock_crossing_io_m1_readdata                              (clock_crossing_io_m1_readdata),
      .clock_crossing_io_m1_readdatavalid                         (clock_crossing_io_m1_readdatavalid),
      .clock_crossing_io_m1_requests_g_sensor_int_s1              (clock_crossing_io_m1_requests_g_sensor_int_s1),
      .clock_crossing_io_m1_requests_key_s1                       (clock_crossing_io_m1_requests_key_s1),
      .clock_crossing_io_m1_requests_led_s1                       (clock_crossing_io_m1_requests_led_s1),
      .clock_crossing_io_m1_requests_select_i2c_clk_s1            (clock_crossing_io_m1_requests_select_i2c_clk_s1),
      .clock_crossing_io_m1_requests_sw_s1                        (clock_crossing_io_m1_requests_sw_s1),
      .clock_crossing_io_m1_requests_sysid_control_slave          (clock_crossing_io_m1_requests_sysid_control_slave),
      .clock_crossing_io_m1_requests_timer_s1                     (clock_crossing_io_m1_requests_timer_s1),
      .clock_crossing_io_m1_reset_n                               (clock_crossing_io_m1_reset_n),
      .clock_crossing_io_m1_waitrequest                           (clock_crossing_io_m1_waitrequest),
      .clock_crossing_io_m1_write                                 (clock_crossing_io_m1_write),
      .clock_crossing_io_m1_writedata                             (clock_crossing_io_m1_writedata),
      .d1_g_sensor_int_s1_end_xfer                                (d1_g_sensor_int_s1_end_xfer),
      .d1_key_s1_end_xfer                                         (d1_key_s1_end_xfer),
      .d1_led_s1_end_xfer                                         (d1_led_s1_end_xfer),
      .d1_select_i2c_clk_s1_end_xfer                              (d1_select_i2c_clk_s1_end_xfer),
      .d1_sw_s1_end_xfer                                          (d1_sw_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                            (d1_sysid_control_slave_end_xfer),
      .d1_timer_s1_end_xfer                                       (d1_timer_s1_end_xfer),
      .g_sensor_int_s1_readdata_from_sa                           (g_sensor_int_s1_readdata_from_sa),
      .key_s1_readdata_from_sa                                    (key_s1_readdata_from_sa),
      .led_s1_readdata_from_sa                                    (led_s1_readdata_from_sa),
      .reset_n                                                    (altpll_io_reset_n),
      .select_i2c_clk_s1_readdata_from_sa                         (select_i2c_clk_s1_readdata_from_sa),
      .sw_s1_readdata_from_sa                                     (sw_s1_readdata_from_sa),
      .sysid_control_slave_readdata_from_sa                       (sysid_control_slave_readdata_from_sa),
      .timer_s1_readdata_from_sa                                  (timer_s1_readdata_from_sa)
    );

  clock_crossing_io the_clock_crossing_io
    (
      .master_address       (clock_crossing_io_m1_address),
      .master_byteenable    (clock_crossing_io_m1_byteenable),
      .master_clk           (altpll_io),
      .master_endofpacket   (clock_crossing_io_m1_endofpacket),
      .master_nativeaddress (clock_crossing_io_m1_nativeaddress),
      .master_read          (clock_crossing_io_m1_read),
      .master_readdata      (clock_crossing_io_m1_readdata),
      .master_readdatavalid (clock_crossing_io_m1_readdatavalid),
      .master_reset_n       (clock_crossing_io_m1_reset_n),
      .master_waitrequest   (clock_crossing_io_m1_waitrequest),
      .master_write         (clock_crossing_io_m1_write),
      .master_writedata     (clock_crossing_io_m1_writedata),
      .slave_address        (clock_crossing_io_s1_address),
      .slave_byteenable     (clock_crossing_io_s1_byteenable),
      .slave_clk            (altpll_sys),
      .slave_endofpacket    (clock_crossing_io_s1_endofpacket),
      .slave_nativeaddress  (clock_crossing_io_s1_nativeaddress),
      .slave_read           (clock_crossing_io_s1_read),
      .slave_readdata       (clock_crossing_io_s1_readdata),
      .slave_readdatavalid  (clock_crossing_io_s1_readdatavalid),
      .slave_reset_n        (clock_crossing_io_s1_reset_n),
      .slave_waitrequest    (clock_crossing_io_s1_waitrequest),
      .slave_write          (clock_crossing_io_s1_write),
      .slave_writedata      (clock_crossing_io_s1_writedata)
    );

  clock_crossing_io2_s1_arbitrator the_clock_crossing_io2_s1
    (
      .clk                                                                  (altpll_sys),
      .clock_crossing_io2_s1_address                                        (clock_crossing_io2_s1_address),
      .clock_crossing_io2_s1_byteenable                                     (clock_crossing_io2_s1_byteenable),
      .clock_crossing_io2_s1_endofpacket                                    (clock_crossing_io2_s1_endofpacket),
      .clock_crossing_io2_s1_endofpacket_from_sa                            (clock_crossing_io2_s1_endofpacket_from_sa),
      .clock_crossing_io2_s1_nativeaddress                                  (clock_crossing_io2_s1_nativeaddress),
      .clock_crossing_io2_s1_read                                           (clock_crossing_io2_s1_read),
      .clock_crossing_io2_s1_readdata                                       (clock_crossing_io2_s1_readdata),
      .clock_crossing_io2_s1_readdata_from_sa                               (clock_crossing_io2_s1_readdata_from_sa),
      .clock_crossing_io2_s1_readdatavalid                                  (clock_crossing_io2_s1_readdatavalid),
      .clock_crossing_io2_s1_reset_n                                        (clock_crossing_io2_s1_reset_n),
      .clock_crossing_io2_s1_waitrequest                                    (clock_crossing_io2_s1_waitrequest),
      .clock_crossing_io2_s1_waitrequest_from_sa                            (clock_crossing_io2_s1_waitrequest_from_sa),
      .clock_crossing_io2_s1_write                                          (clock_crossing_io2_s1_write),
      .clock_crossing_io2_s1_writedata                                      (clock_crossing_io2_s1_writedata),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                           (cpu_data_master_byteenable),
      .cpu_data_master_granted_clock_crossing_io2_s1                        (cpu_data_master_granted_clock_crossing_io2_s1),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_clock_crossing_io2_s1              (cpu_data_master_qualified_request_clock_crossing_io2_s1),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1                (cpu_data_master_read_data_valid_clock_crossing_io2_s1),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_clock_crossing_io2_s1                       (cpu_data_master_requests_clock_crossing_io2_s1),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_data_master_writedata                                            (cpu_data_master_writedata),
      .d1_clock_crossing_io2_s1_end_xfer                                    (d1_clock_crossing_io2_s1_end_xfer),
      .reset_n                                                              (altpll_sys_reset_n)
    );

  clock_crossing_io2_m1_arbitrator the_clock_crossing_io2_m1
    (
      .clk                                                            (clk_50),
      .clock_crossing_io2_m1_address                                  (clock_crossing_io2_m1_address),
      .clock_crossing_io2_m1_address_to_slave                         (clock_crossing_io2_m1_address_to_slave),
      .clock_crossing_io2_m1_byteenable                               (clock_crossing_io2_m1_byteenable),
      .clock_crossing_io2_m1_endofpacket                              (clock_crossing_io2_m1_endofpacket),
      .clock_crossing_io2_m1_granted_epcs_epcs_control_port           (clock_crossing_io2_m1_granted_epcs_epcs_control_port),
      .clock_crossing_io2_m1_granted_gsensor_spi_slave                (clock_crossing_io2_m1_granted_gsensor_spi_slave),
      .clock_crossing_io2_m1_granted_i2c_scl_s1                       (clock_crossing_io2_m1_granted_i2c_scl_s1),
      .clock_crossing_io2_m1_granted_i2c_sda_s1                       (clock_crossing_io2_m1_granted_i2c_sda_s1),
      .clock_crossing_io2_m1_latency_counter                          (clock_crossing_io2_m1_latency_counter),
      .clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port (clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port),
      .clock_crossing_io2_m1_qualified_request_gsensor_spi_slave      (clock_crossing_io2_m1_qualified_request_gsensor_spi_slave),
      .clock_crossing_io2_m1_qualified_request_i2c_scl_s1             (clock_crossing_io2_m1_qualified_request_i2c_scl_s1),
      .clock_crossing_io2_m1_qualified_request_i2c_sda_s1             (clock_crossing_io2_m1_qualified_request_i2c_sda_s1),
      .clock_crossing_io2_m1_read                                     (clock_crossing_io2_m1_read),
      .clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port   (clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port),
      .clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave        (clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave),
      .clock_crossing_io2_m1_read_data_valid_i2c_scl_s1               (clock_crossing_io2_m1_read_data_valid_i2c_scl_s1),
      .clock_crossing_io2_m1_read_data_valid_i2c_sda_s1               (clock_crossing_io2_m1_read_data_valid_i2c_sda_s1),
      .clock_crossing_io2_m1_readdata                                 (clock_crossing_io2_m1_readdata),
      .clock_crossing_io2_m1_readdatavalid                            (clock_crossing_io2_m1_readdatavalid),
      .clock_crossing_io2_m1_requests_epcs_epcs_control_port          (clock_crossing_io2_m1_requests_epcs_epcs_control_port),
      .clock_crossing_io2_m1_requests_gsensor_spi_slave               (clock_crossing_io2_m1_requests_gsensor_spi_slave),
      .clock_crossing_io2_m1_requests_i2c_scl_s1                      (clock_crossing_io2_m1_requests_i2c_scl_s1),
      .clock_crossing_io2_m1_requests_i2c_sda_s1                      (clock_crossing_io2_m1_requests_i2c_sda_s1),
      .clock_crossing_io2_m1_reset_n                                  (clock_crossing_io2_m1_reset_n),
      .clock_crossing_io2_m1_waitrequest                              (clock_crossing_io2_m1_waitrequest),
      .clock_crossing_io2_m1_write                                    (clock_crossing_io2_m1_write),
      .clock_crossing_io2_m1_writedata                                (clock_crossing_io2_m1_writedata),
      .d1_epcs_epcs_control_port_end_xfer                             (d1_epcs_epcs_control_port_end_xfer),
      .d1_gsensor_spi_slave_end_xfer                                  (d1_gsensor_spi_slave_end_xfer),
      .d1_i2c_scl_s1_end_xfer                                         (d1_i2c_scl_s1_end_xfer),
      .d1_i2c_sda_s1_end_xfer                                         (d1_i2c_sda_s1_end_xfer),
      .epcs_epcs_control_port_endofpacket_from_sa                     (epcs_epcs_control_port_endofpacket_from_sa),
      .epcs_epcs_control_port_readdata_from_sa                        (epcs_epcs_control_port_readdata_from_sa),
      .gsensor_spi_slave_readdata_from_sa                             (gsensor_spi_slave_readdata_from_sa),
      .i2c_scl_s1_readdata_from_sa                                    (i2c_scl_s1_readdata_from_sa),
      .i2c_sda_s1_readdata_from_sa                                    (i2c_sda_s1_readdata_from_sa),
      .reset_n                                                        (clk_50_reset_n)
    );

  clock_crossing_io2 the_clock_crossing_io2
    (
      .master_address       (clock_crossing_io2_m1_address),
      .master_byteenable    (clock_crossing_io2_m1_byteenable),
      .master_clk           (clk_50),
      .master_endofpacket   (clock_crossing_io2_m1_endofpacket),
      .master_nativeaddress (clock_crossing_io2_m1_nativeaddress),
      .master_read          (clock_crossing_io2_m1_read),
      .master_readdata      (clock_crossing_io2_m1_readdata),
      .master_readdatavalid (clock_crossing_io2_m1_readdatavalid),
      .master_reset_n       (clock_crossing_io2_m1_reset_n),
      .master_waitrequest   (clock_crossing_io2_m1_waitrequest),
      .master_write         (clock_crossing_io2_m1_write),
      .master_writedata     (clock_crossing_io2_m1_writedata),
      .slave_address        (clock_crossing_io2_s1_address),
      .slave_byteenable     (clock_crossing_io2_s1_byteenable),
      .slave_clk            (altpll_sys),
      .slave_endofpacket    (clock_crossing_io2_s1_endofpacket),
      .slave_nativeaddress  (clock_crossing_io2_s1_nativeaddress),
      .slave_read           (clock_crossing_io2_s1_read),
      .slave_readdata       (clock_crossing_io2_s1_readdata),
      .slave_readdatavalid  (clock_crossing_io2_s1_readdatavalid),
      .slave_reset_n        (clock_crossing_io2_s1_reset_n),
      .slave_waitrequest    (clock_crossing_io2_s1_waitrequest),
      .slave_write          (clock_crossing_io2_s1_write),
      .slave_writedata      (clock_crossing_io2_s1_writedata)
    );

  cpu_jtag_debug_module_arbitrator the_cpu_jtag_debug_module
    (
      .clk                                                                  (altpll_sys),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                           (cpu_data_master_byteenable),
      .cpu_data_master_debugaccess                                          (cpu_data_master_debugaccess),
      .cpu_data_master_granted_cpu_jtag_debug_module                        (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module              (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module                (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_cpu_jtag_debug_module                       (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_data_master_writedata                                            (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                              (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_cpu_jtag_debug_module                 (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_latency_counter                               (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module       (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_read                                          (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module         (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register       (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_cpu_jtag_debug_module                (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_jtag_debug_module_address                                        (cpu_jtag_debug_module_address),
      .cpu_jtag_debug_module_begintransfer                                  (cpu_jtag_debug_module_begintransfer),
      .cpu_jtag_debug_module_byteenable                                     (cpu_jtag_debug_module_byteenable),
      .cpu_jtag_debug_module_chipselect                                     (cpu_jtag_debug_module_chipselect),
      .cpu_jtag_debug_module_debugaccess                                    (cpu_jtag_debug_module_debugaccess),
      .cpu_jtag_debug_module_readdata                                       (cpu_jtag_debug_module_readdata),
      .cpu_jtag_debug_module_readdata_from_sa                               (cpu_jtag_debug_module_readdata_from_sa),
      .cpu_jtag_debug_module_reset_n                                        (cpu_jtag_debug_module_reset_n),
      .cpu_jtag_debug_module_resetrequest                                   (cpu_jtag_debug_module_resetrequest),
      .cpu_jtag_debug_module_resetrequest_from_sa                           (cpu_jtag_debug_module_resetrequest_from_sa),
      .cpu_jtag_debug_module_write                                          (cpu_jtag_debug_module_write),
      .cpu_jtag_debug_module_writedata                                      (cpu_jtag_debug_module_writedata),
      .d1_cpu_jtag_debug_module_end_xfer                                    (d1_cpu_jtag_debug_module_end_xfer),
      .reset_n                                                              (altpll_sys_reset_n)
    );

  cpu_data_master_arbitrator the_cpu_data_master
    (
      .DE0_Nano_SOPC_clock_0_in_readdata_from_sa                            (DE0_Nano_SOPC_clock_0_in_readdata_from_sa),
      .DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa                         (DE0_Nano_SOPC_clock_0_in_waitrequest_from_sa),
      .DE0_Nano_SOPC_clock_1_in_readdata_from_sa                            (DE0_Nano_SOPC_clock_1_in_readdata_from_sa),
      .DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa                         (DE0_Nano_SOPC_clock_1_in_waitrequest_from_sa),
      .altpll_sys                                                           (altpll_sys),
      .altpll_sys_reset_n                                                   (altpll_sys_reset_n),
      .clk                                                                  (altpll_sys),
      .clock_crossing_io2_s1_readdata_from_sa                               (clock_crossing_io2_s1_readdata_from_sa),
      .clock_crossing_io2_s1_waitrequest_from_sa                            (clock_crossing_io2_s1_waitrequest_from_sa),
      .clock_crossing_io_s1_readdata_from_sa                                (clock_crossing_io_s1_readdata_from_sa),
      .clock_crossing_io_s1_waitrequest_from_sa                             (clock_crossing_io_s1_waitrequest_from_sa),
      .cpu_data_master_address                                              (cpu_data_master_address),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                           (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_s1                                  (cpu_data_master_byteenable_sdram_s1),
      .cpu_data_master_dbs_address                                          (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                         (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in                     (cpu_data_master_granted_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in                     (cpu_data_master_granted_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_granted_clock_crossing_io2_s1                        (cpu_data_master_granted_clock_crossing_io2_s1),
      .cpu_data_master_granted_clock_crossing_io_s1                         (cpu_data_master_granted_clock_crossing_io_s1),
      .cpu_data_master_granted_cpu_jtag_debug_module                        (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave                  (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_granted_sdram_s1                                     (cpu_data_master_granted_sdram_s1),
      .cpu_data_master_irq                                                  (cpu_data_master_irq),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in           (cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in           (cpu_data_master_qualified_request_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_qualified_request_clock_crossing_io2_s1              (cpu_data_master_qualified_request_clock_crossing_io2_s1),
      .cpu_data_master_qualified_request_clock_crossing_io_s1               (cpu_data_master_qualified_request_clock_crossing_io_s1),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module              (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave        (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_qualified_request_sdram_s1                           (cpu_data_master_qualified_request_sdram_s1),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in             (cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in             (cpu_data_master_read_data_valid_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1                (cpu_data_master_read_data_valid_clock_crossing_io2_s1),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1                 (cpu_data_master_read_data_valid_clock_crossing_io_s1),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module                (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave          (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_sdram_s1                             (cpu_data_master_read_data_valid_sdram_s1),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_readdata                                             (cpu_data_master_readdata),
      .cpu_data_master_readdatavalid                                        (cpu_data_master_readdatavalid),
      .cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in                    (cpu_data_master_requests_DE0_Nano_SOPC_clock_0_in),
      .cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in                    (cpu_data_master_requests_DE0_Nano_SOPC_clock_1_in),
      .cpu_data_master_requests_clock_crossing_io2_s1                       (cpu_data_master_requests_clock_crossing_io2_s1),
      .cpu_data_master_requests_clock_crossing_io_s1                        (cpu_data_master_requests_clock_crossing_io_s1),
      .cpu_data_master_requests_cpu_jtag_debug_module                       (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave                 (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_requests_sdram_s1                                    (cpu_data_master_requests_sdram_s1),
      .cpu_data_master_waitrequest                                          (cpu_data_master_waitrequest),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_data_master_writedata                                            (cpu_data_master_writedata),
      .cpu_jtag_debug_module_readdata_from_sa                               (cpu_jtag_debug_module_readdata_from_sa),
      .d1_DE0_Nano_SOPC_clock_0_in_end_xfer                                 (d1_DE0_Nano_SOPC_clock_0_in_end_xfer),
      .d1_DE0_Nano_SOPC_clock_1_in_end_xfer                                 (d1_DE0_Nano_SOPC_clock_1_in_end_xfer),
      .d1_clock_crossing_io2_s1_end_xfer                                    (d1_clock_crossing_io2_s1_end_xfer),
      .d1_clock_crossing_io_s1_end_xfer                                     (d1_clock_crossing_io_s1_end_xfer),
      .d1_cpu_jtag_debug_module_end_xfer                                    (d1_cpu_jtag_debug_module_end_xfer),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                              (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .d1_sdram_s1_end_xfer                                                 (d1_sdram_s1_end_xfer),
      .epcs_epcs_control_port_irq_from_sa                                   (epcs_epcs_control_port_irq_from_sa),
      .g_sensor_int_s1_irq_from_sa                                          (g_sensor_int_s1_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                              (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                         (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa                      (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .key_s1_irq_from_sa                                                   (key_s1_irq_from_sa),
      .reset_n                                                              (altpll_sys_reset_n),
      .sdram_s1_readdata_from_sa                                            (sdram_s1_readdata_from_sa),
      .sdram_s1_waitrequest_from_sa                                         (sdram_s1_waitrequest_from_sa),
      .sw_s1_irq_from_sa                                                    (sw_s1_irq_from_sa),
      .timer_s1_irq_from_sa                                                 (timer_s1_irq_from_sa)
    );

  cpu_instruction_master_arbitrator the_cpu_instruction_master
    (
      .clk                                                            (altpll_sys),
      .cpu_instruction_master_address                                 (cpu_instruction_master_address),
      .cpu_instruction_master_address_to_slave                        (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                             (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_cpu_jtag_debug_module           (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_granted_sdram_s1                        (cpu_instruction_master_granted_sdram_s1),
      .cpu_instruction_master_latency_counter                         (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_qualified_request_sdram_s1              (cpu_instruction_master_qualified_request_sdram_s1),
      .cpu_instruction_master_read                                    (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module   (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_sdram_s1                (cpu_instruction_master_read_data_valid_sdram_s1),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_readdata                                (cpu_instruction_master_readdata),
      .cpu_instruction_master_readdatavalid                           (cpu_instruction_master_readdatavalid),
      .cpu_instruction_master_requests_cpu_jtag_debug_module          (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_instruction_master_requests_sdram_s1                       (cpu_instruction_master_requests_sdram_s1),
      .cpu_instruction_master_waitrequest                             (cpu_instruction_master_waitrequest),
      .cpu_jtag_debug_module_readdata_from_sa                         (cpu_jtag_debug_module_readdata_from_sa),
      .d1_cpu_jtag_debug_module_end_xfer                              (d1_cpu_jtag_debug_module_end_xfer),
      .d1_sdram_s1_end_xfer                                           (d1_sdram_s1_end_xfer),
      .reset_n                                                        (altpll_sys_reset_n),
      .sdram_s1_readdata_from_sa                                      (sdram_s1_readdata_from_sa),
      .sdram_s1_waitrequest_from_sa                                   (sdram_s1_waitrequest_from_sa)
    );

  cpu the_cpu
    (
      .clk                                   (altpll_sys),
      .d_address                             (cpu_data_master_address),
      .d_byteenable                          (cpu_data_master_byteenable),
      .d_irq                                 (cpu_data_master_irq),
      .d_read                                (cpu_data_master_read),
      .d_readdata                            (cpu_data_master_readdata),
      .d_readdatavalid                       (cpu_data_master_readdatavalid),
      .d_waitrequest                         (cpu_data_master_waitrequest),
      .d_write                               (cpu_data_master_write),
      .d_writedata                           (cpu_data_master_writedata),
      .i_address                             (cpu_instruction_master_address),
      .i_read                                (cpu_instruction_master_read),
      .i_readdata                            (cpu_instruction_master_readdata),
      .i_readdatavalid                       (cpu_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_jtag_debug_module_writedata),
      .reset_n                               (cpu_jtag_debug_module_reset_n)
    );

  epcs_epcs_control_port_arbitrator the_epcs_epcs_control_port
    (
      .clk                                                            (clk_50),
      .clock_crossing_io2_m1_address_to_slave                         (clock_crossing_io2_m1_address_to_slave),
      .clock_crossing_io2_m1_granted_epcs_epcs_control_port           (clock_crossing_io2_m1_granted_epcs_epcs_control_port),
      .clock_crossing_io2_m1_latency_counter                          (clock_crossing_io2_m1_latency_counter),
      .clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port (clock_crossing_io2_m1_qualified_request_epcs_epcs_control_port),
      .clock_crossing_io2_m1_read                                     (clock_crossing_io2_m1_read),
      .clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port   (clock_crossing_io2_m1_read_data_valid_epcs_epcs_control_port),
      .clock_crossing_io2_m1_requests_epcs_epcs_control_port          (clock_crossing_io2_m1_requests_epcs_epcs_control_port),
      .clock_crossing_io2_m1_write                                    (clock_crossing_io2_m1_write),
      .clock_crossing_io2_m1_writedata                                (clock_crossing_io2_m1_writedata),
      .d1_epcs_epcs_control_port_end_xfer                             (d1_epcs_epcs_control_port_end_xfer),
      .epcs_epcs_control_port_address                                 (epcs_epcs_control_port_address),
      .epcs_epcs_control_port_chipselect                              (epcs_epcs_control_port_chipselect),
      .epcs_epcs_control_port_dataavailable                           (epcs_epcs_control_port_dataavailable),
      .epcs_epcs_control_port_dataavailable_from_sa                   (epcs_epcs_control_port_dataavailable_from_sa),
      .epcs_epcs_control_port_endofpacket                             (epcs_epcs_control_port_endofpacket),
      .epcs_epcs_control_port_endofpacket_from_sa                     (epcs_epcs_control_port_endofpacket_from_sa),
      .epcs_epcs_control_port_irq                                     (epcs_epcs_control_port_irq),
      .epcs_epcs_control_port_irq_from_sa                             (epcs_epcs_control_port_irq_from_sa),
      .epcs_epcs_control_port_read_n                                  (epcs_epcs_control_port_read_n),
      .epcs_epcs_control_port_readdata                                (epcs_epcs_control_port_readdata),
      .epcs_epcs_control_port_readdata_from_sa                        (epcs_epcs_control_port_readdata_from_sa),
      .epcs_epcs_control_port_readyfordata                            (epcs_epcs_control_port_readyfordata),
      .epcs_epcs_control_port_readyfordata_from_sa                    (epcs_epcs_control_port_readyfordata_from_sa),
      .epcs_epcs_control_port_reset_n                                 (epcs_epcs_control_port_reset_n),
      .epcs_epcs_control_port_write_n                                 (epcs_epcs_control_port_write_n),
      .epcs_epcs_control_port_writedata                               (epcs_epcs_control_port_writedata),
      .reset_n                                                        (clk_50_reset_n)
    );

  epcs the_epcs
    (
      .address       (epcs_epcs_control_port_address),
      .chipselect    (epcs_epcs_control_port_chipselect),
      .clk           (clk_50),
      .data0         (data0_to_the_epcs),
      .dataavailable (epcs_epcs_control_port_dataavailable),
      .dclk          (dclk_from_the_epcs),
      .endofpacket   (epcs_epcs_control_port_endofpacket),
      .irq           (epcs_epcs_control_port_irq),
      .read_n        (epcs_epcs_control_port_read_n),
      .readdata      (epcs_epcs_control_port_readdata),
      .readyfordata  (epcs_epcs_control_port_readyfordata),
      .reset_n       (epcs_epcs_control_port_reset_n),
      .sce           (sce_from_the_epcs),
      .sdo           (sdo_from_the_epcs),
      .write_n       (epcs_epcs_control_port_write_n),
      .writedata     (epcs_epcs_control_port_writedata)
    );

  g_sensor_int_s1_arbitrator the_g_sensor_int_s1
    (
      .clk                                                    (altpll_io),
      .clock_crossing_io_m1_address_to_slave                  (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_granted_g_sensor_int_s1           (clock_crossing_io_m1_granted_g_sensor_int_s1),
      .clock_crossing_io_m1_latency_counter                   (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_nativeaddress                     (clock_crossing_io_m1_nativeaddress),
      .clock_crossing_io_m1_qualified_request_g_sensor_int_s1 (clock_crossing_io_m1_qualified_request_g_sensor_int_s1),
      .clock_crossing_io_m1_read                              (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_g_sensor_int_s1   (clock_crossing_io_m1_read_data_valid_g_sensor_int_s1),
      .clock_crossing_io_m1_requests_g_sensor_int_s1          (clock_crossing_io_m1_requests_g_sensor_int_s1),
      .clock_crossing_io_m1_write                             (clock_crossing_io_m1_write),
      .clock_crossing_io_m1_writedata                         (clock_crossing_io_m1_writedata),
      .d1_g_sensor_int_s1_end_xfer                            (d1_g_sensor_int_s1_end_xfer),
      .g_sensor_int_s1_address                                (g_sensor_int_s1_address),
      .g_sensor_int_s1_chipselect                             (g_sensor_int_s1_chipselect),
      .g_sensor_int_s1_irq                                    (g_sensor_int_s1_irq),
      .g_sensor_int_s1_irq_from_sa                            (g_sensor_int_s1_irq_from_sa),
      .g_sensor_int_s1_readdata                               (g_sensor_int_s1_readdata),
      .g_sensor_int_s1_readdata_from_sa                       (g_sensor_int_s1_readdata_from_sa),
      .g_sensor_int_s1_reset_n                                (g_sensor_int_s1_reset_n),
      .g_sensor_int_s1_write_n                                (g_sensor_int_s1_write_n),
      .g_sensor_int_s1_writedata                              (g_sensor_int_s1_writedata),
      .reset_n                                                (altpll_io_reset_n)
    );

  g_sensor_int the_g_sensor_int
    (
      .address    (g_sensor_int_s1_address),
      .chipselect (g_sensor_int_s1_chipselect),
      .clk        (altpll_io),
      .in_port    (in_port_to_the_g_sensor_int),
      .irq        (g_sensor_int_s1_irq),
      .readdata   (g_sensor_int_s1_readdata),
      .reset_n    (g_sensor_int_s1_reset_n),
      .write_n    (g_sensor_int_s1_write_n),
      .writedata  (g_sensor_int_s1_writedata)
    );

  gsensor_spi_slave_arbitrator the_gsensor_spi_slave
    (
      .clk                                                       (clk_50),
      .clock_crossing_io2_m1_address_to_slave                    (clock_crossing_io2_m1_address_to_slave),
      .clock_crossing_io2_m1_byteenable                          (clock_crossing_io2_m1_byteenable),
      .clock_crossing_io2_m1_granted_gsensor_spi_slave           (clock_crossing_io2_m1_granted_gsensor_spi_slave),
      .clock_crossing_io2_m1_latency_counter                     (clock_crossing_io2_m1_latency_counter),
      .clock_crossing_io2_m1_nativeaddress                       (clock_crossing_io2_m1_nativeaddress),
      .clock_crossing_io2_m1_qualified_request_gsensor_spi_slave (clock_crossing_io2_m1_qualified_request_gsensor_spi_slave),
      .clock_crossing_io2_m1_read                                (clock_crossing_io2_m1_read),
      .clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave   (clock_crossing_io2_m1_read_data_valid_gsensor_spi_slave),
      .clock_crossing_io2_m1_requests_gsensor_spi_slave          (clock_crossing_io2_m1_requests_gsensor_spi_slave),
      .clock_crossing_io2_m1_write                               (clock_crossing_io2_m1_write),
      .clock_crossing_io2_m1_writedata                           (clock_crossing_io2_m1_writedata),
      .d1_gsensor_spi_slave_end_xfer                             (d1_gsensor_spi_slave_end_xfer),
      .gsensor_spi_slave_address                                 (gsensor_spi_slave_address),
      .gsensor_spi_slave_chipselect                              (gsensor_spi_slave_chipselect),
      .gsensor_spi_slave_read                                    (gsensor_spi_slave_read),
      .gsensor_spi_slave_readdata                                (gsensor_spi_slave_readdata),
      .gsensor_spi_slave_readdata_from_sa                        (gsensor_spi_slave_readdata_from_sa),
      .gsensor_spi_slave_reset_n                                 (gsensor_spi_slave_reset_n),
      .gsensor_spi_slave_write                                   (gsensor_spi_slave_write),
      .gsensor_spi_slave_writedata                               (gsensor_spi_slave_writedata),
      .reset_n                                                   (clk_50_reset_n)
    );

  gsensor_spi the_gsensor_spi
    (
      .SPI_CS_n     (SPI_CS_n_from_the_gsensor_spi),
      .SPI_SCLK     (SPI_SCLK_from_the_gsensor_spi),
      .SPI_SDIO     (SPI_SDIO_to_and_from_the_gsensor_spi),
      .clk          (clk_50),
      .reset_n      (gsensor_spi_slave_reset_n),
      .s_address    (gsensor_spi_slave_address),
      .s_chipselect (gsensor_spi_slave_chipselect),
      .s_read       (gsensor_spi_slave_read),
      .s_readdata   (gsensor_spi_slave_readdata),
      .s_write      (gsensor_spi_slave_write),
      .s_writedata  (gsensor_spi_slave_writedata)
    );

  i2c_scl_s1_arbitrator the_i2c_scl_s1
    (
      .clk                                                (clk_50),
      .clock_crossing_io2_m1_address_to_slave             (clock_crossing_io2_m1_address_to_slave),
      .clock_crossing_io2_m1_granted_i2c_scl_s1           (clock_crossing_io2_m1_granted_i2c_scl_s1),
      .clock_crossing_io2_m1_latency_counter              (clock_crossing_io2_m1_latency_counter),
      .clock_crossing_io2_m1_nativeaddress                (clock_crossing_io2_m1_nativeaddress),
      .clock_crossing_io2_m1_qualified_request_i2c_scl_s1 (clock_crossing_io2_m1_qualified_request_i2c_scl_s1),
      .clock_crossing_io2_m1_read                         (clock_crossing_io2_m1_read),
      .clock_crossing_io2_m1_read_data_valid_i2c_scl_s1   (clock_crossing_io2_m1_read_data_valid_i2c_scl_s1),
      .clock_crossing_io2_m1_requests_i2c_scl_s1          (clock_crossing_io2_m1_requests_i2c_scl_s1),
      .clock_crossing_io2_m1_write                        (clock_crossing_io2_m1_write),
      .clock_crossing_io2_m1_writedata                    (clock_crossing_io2_m1_writedata),
      .d1_i2c_scl_s1_end_xfer                             (d1_i2c_scl_s1_end_xfer),
      .i2c_scl_s1_address                                 (i2c_scl_s1_address),
      .i2c_scl_s1_chipselect                              (i2c_scl_s1_chipselect),
      .i2c_scl_s1_readdata                                (i2c_scl_s1_readdata),
      .i2c_scl_s1_readdata_from_sa                        (i2c_scl_s1_readdata_from_sa),
      .i2c_scl_s1_reset_n                                 (i2c_scl_s1_reset_n),
      .i2c_scl_s1_write_n                                 (i2c_scl_s1_write_n),
      .i2c_scl_s1_writedata                               (i2c_scl_s1_writedata),
      .reset_n                                            (clk_50_reset_n)
    );

  i2c_scl the_i2c_scl
    (
      .address    (i2c_scl_s1_address),
      .chipselect (i2c_scl_s1_chipselect),
      .clk        (clk_50),
      .out_port   (out_port_from_the_i2c_scl),
      .readdata   (i2c_scl_s1_readdata),
      .reset_n    (i2c_scl_s1_reset_n),
      .write_n    (i2c_scl_s1_write_n),
      .writedata  (i2c_scl_s1_writedata)
    );

  i2c_sda_s1_arbitrator the_i2c_sda_s1
    (
      .clk                                                (clk_50),
      .clock_crossing_io2_m1_address_to_slave             (clock_crossing_io2_m1_address_to_slave),
      .clock_crossing_io2_m1_granted_i2c_sda_s1           (clock_crossing_io2_m1_granted_i2c_sda_s1),
      .clock_crossing_io2_m1_latency_counter              (clock_crossing_io2_m1_latency_counter),
      .clock_crossing_io2_m1_nativeaddress                (clock_crossing_io2_m1_nativeaddress),
      .clock_crossing_io2_m1_qualified_request_i2c_sda_s1 (clock_crossing_io2_m1_qualified_request_i2c_sda_s1),
      .clock_crossing_io2_m1_read                         (clock_crossing_io2_m1_read),
      .clock_crossing_io2_m1_read_data_valid_i2c_sda_s1   (clock_crossing_io2_m1_read_data_valid_i2c_sda_s1),
      .clock_crossing_io2_m1_requests_i2c_sda_s1          (clock_crossing_io2_m1_requests_i2c_sda_s1),
      .clock_crossing_io2_m1_write                        (clock_crossing_io2_m1_write),
      .clock_crossing_io2_m1_writedata                    (clock_crossing_io2_m1_writedata),
      .d1_i2c_sda_s1_end_xfer                             (d1_i2c_sda_s1_end_xfer),
      .i2c_sda_s1_address                                 (i2c_sda_s1_address),
      .i2c_sda_s1_chipselect                              (i2c_sda_s1_chipselect),
      .i2c_sda_s1_readdata                                (i2c_sda_s1_readdata),
      .i2c_sda_s1_readdata_from_sa                        (i2c_sda_s1_readdata_from_sa),
      .i2c_sda_s1_reset_n                                 (i2c_sda_s1_reset_n),
      .i2c_sda_s1_write_n                                 (i2c_sda_s1_write_n),
      .i2c_sda_s1_writedata                               (i2c_sda_s1_writedata),
      .reset_n                                            (clk_50_reset_n)
    );

  i2c_sda the_i2c_sda
    (
      .address    (i2c_sda_s1_address),
      .bidir_port (bidir_port_to_and_from_the_i2c_sda),
      .chipselect (i2c_sda_s1_chipselect),
      .clk        (clk_50),
      .readdata   (i2c_sda_s1_readdata),
      .reset_n    (i2c_sda_s1_reset_n),
      .write_n    (i2c_sda_s1_write_n),
      .writedata  (i2c_sda_s1_writedata)
    );

  jtag_uart_avalon_jtag_slave_arbitrator the_jtag_uart_avalon_jtag_slave
    (
      .clk                                                                  (altpll_sys),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave                  (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave        (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave          (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave                 (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_data_master_writedata                                            (cpu_data_master_writedata),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                              (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .jtag_uart_avalon_jtag_slave_address                                  (jtag_uart_avalon_jtag_slave_address),
      .jtag_uart_avalon_jtag_slave_chipselect                               (jtag_uart_avalon_jtag_slave_chipselect),
      .jtag_uart_avalon_jtag_slave_dataavailable                            (jtag_uart_avalon_jtag_slave_dataavailable),
      .jtag_uart_avalon_jtag_slave_dataavailable_from_sa                    (jtag_uart_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_avalon_jtag_slave_irq                                      (jtag_uart_avalon_jtag_slave_irq),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                              (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_read_n                                   (jtag_uart_avalon_jtag_slave_read_n),
      .jtag_uart_avalon_jtag_slave_readdata                                 (jtag_uart_avalon_jtag_slave_readdata),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                         (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_readyfordata                             (jtag_uart_avalon_jtag_slave_readyfordata),
      .jtag_uart_avalon_jtag_slave_readyfordata_from_sa                     (jtag_uart_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_avalon_jtag_slave_reset_n                                  (jtag_uart_avalon_jtag_slave_reset_n),
      .jtag_uart_avalon_jtag_slave_waitrequest                              (jtag_uart_avalon_jtag_slave_waitrequest),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa                      (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_avalon_jtag_slave_write_n                                  (jtag_uart_avalon_jtag_slave_write_n),
      .jtag_uart_avalon_jtag_slave_writedata                                (jtag_uart_avalon_jtag_slave_writedata),
      .reset_n                                                              (altpll_sys_reset_n)
    );

  jtag_uart the_jtag_uart
    (
      .av_address     (jtag_uart_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_avalon_jtag_slave_writedata),
      .clk            (altpll_sys),
      .dataavailable  (jtag_uart_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_avalon_jtag_slave_reset_n)
    );

  key_s1_arbitrator the_key_s1
    (
      .clk                                           (altpll_io),
      .clock_crossing_io_m1_address_to_slave         (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_granted_key_s1           (clock_crossing_io_m1_granted_key_s1),
      .clock_crossing_io_m1_latency_counter          (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_nativeaddress            (clock_crossing_io_m1_nativeaddress),
      .clock_crossing_io_m1_qualified_request_key_s1 (clock_crossing_io_m1_qualified_request_key_s1),
      .clock_crossing_io_m1_read                     (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_key_s1   (clock_crossing_io_m1_read_data_valid_key_s1),
      .clock_crossing_io_m1_requests_key_s1          (clock_crossing_io_m1_requests_key_s1),
      .clock_crossing_io_m1_write                    (clock_crossing_io_m1_write),
      .clock_crossing_io_m1_writedata                (clock_crossing_io_m1_writedata),
      .d1_key_s1_end_xfer                            (d1_key_s1_end_xfer),
      .key_s1_address                                (key_s1_address),
      .key_s1_chipselect                             (key_s1_chipselect),
      .key_s1_irq                                    (key_s1_irq),
      .key_s1_irq_from_sa                            (key_s1_irq_from_sa),
      .key_s1_readdata                               (key_s1_readdata),
      .key_s1_readdata_from_sa                       (key_s1_readdata_from_sa),
      .key_s1_reset_n                                (key_s1_reset_n),
      .key_s1_write_n                                (key_s1_write_n),
      .key_s1_writedata                              (key_s1_writedata),
      .reset_n                                       (altpll_io_reset_n)
    );

  key the_key
    (
      .address    (key_s1_address),
      .chipselect (key_s1_chipselect),
      .clk        (altpll_io),
      .in_port    (in_port_to_the_key),
      .irq        (key_s1_irq),
      .readdata   (key_s1_readdata),
      .reset_n    (key_s1_reset_n),
      .write_n    (key_s1_write_n),
      .writedata  (key_s1_writedata)
    );

  led_s1_arbitrator the_led_s1
    (
      .clk                                           (altpll_io),
      .clock_crossing_io_m1_address_to_slave         (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_byteenable               (clock_crossing_io_m1_byteenable),
      .clock_crossing_io_m1_granted_led_s1           (clock_crossing_io_m1_granted_led_s1),
      .clock_crossing_io_m1_latency_counter          (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_nativeaddress            (clock_crossing_io_m1_nativeaddress),
      .clock_crossing_io_m1_qualified_request_led_s1 (clock_crossing_io_m1_qualified_request_led_s1),
      .clock_crossing_io_m1_read                     (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_led_s1   (clock_crossing_io_m1_read_data_valid_led_s1),
      .clock_crossing_io_m1_requests_led_s1          (clock_crossing_io_m1_requests_led_s1),
      .clock_crossing_io_m1_write                    (clock_crossing_io_m1_write),
      .clock_crossing_io_m1_writedata                (clock_crossing_io_m1_writedata),
      .d1_led_s1_end_xfer                            (d1_led_s1_end_xfer),
      .led_s1_address                                (led_s1_address),
      .led_s1_chipselect                             (led_s1_chipselect),
      .led_s1_readdata                               (led_s1_readdata),
      .led_s1_readdata_from_sa                       (led_s1_readdata_from_sa),
      .led_s1_reset_n                                (led_s1_reset_n),
      .led_s1_write_n                                (led_s1_write_n),
      .led_s1_writedata                              (led_s1_writedata),
      .reset_n                                       (altpll_io_reset_n)
    );

  led the_led
    (
      .address    (led_s1_address),
      .chipselect (led_s1_chipselect),
      .clk        (altpll_io),
      .out_port   (out_port_from_the_led),
      .readdata   (led_s1_readdata),
      .reset_n    (led_s1_reset_n),
      .write_n    (led_s1_write_n),
      .writedata  (led_s1_writedata)
    );

  sdram_s1_arbitrator the_sdram_s1
    (
      .clk                                                                  (altpll_sys),
      .cpu_data_master_address_to_slave                                     (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                           (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_s1                                  (cpu_data_master_byteenable_sdram_s1),
      .cpu_data_master_dbs_address                                          (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                         (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_sdram_s1                                     (cpu_data_master_granted_sdram_s1),
      .cpu_data_master_latency_counter                                      (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sdram_s1                           (cpu_data_master_qualified_request_sdram_s1),
      .cpu_data_master_read                                                 (cpu_data_master_read),
      .cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register (cpu_data_master_read_data_valid_clock_crossing_io2_s1_shift_register),
      .cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register  (cpu_data_master_read_data_valid_clock_crossing_io_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_s1                             (cpu_data_master_read_data_valid_sdram_s1),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register              (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_sdram_s1                                    (cpu_data_master_requests_sdram_s1),
      .cpu_data_master_write                                                (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                              (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                   (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_sdram_s1                              (cpu_instruction_master_granted_sdram_s1),
      .cpu_instruction_master_latency_counter                               (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_sdram_s1                    (cpu_instruction_master_qualified_request_sdram_s1),
      .cpu_instruction_master_read                                          (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_s1                      (cpu_instruction_master_read_data_valid_sdram_s1),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register       (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_sdram_s1                             (cpu_instruction_master_requests_sdram_s1),
      .d1_sdram_s1_end_xfer                                                 (d1_sdram_s1_end_xfer),
      .reset_n                                                              (altpll_sys_reset_n),
      .sdram_s1_address                                                     (sdram_s1_address),
      .sdram_s1_byteenable_n                                                (sdram_s1_byteenable_n),
      .sdram_s1_chipselect                                                  (sdram_s1_chipselect),
      .sdram_s1_read_n                                                      (sdram_s1_read_n),
      .sdram_s1_readdata                                                    (sdram_s1_readdata),
      .sdram_s1_readdata_from_sa                                            (sdram_s1_readdata_from_sa),
      .sdram_s1_readdatavalid                                               (sdram_s1_readdatavalid),
      .sdram_s1_reset_n                                                     (sdram_s1_reset_n),
      .sdram_s1_waitrequest                                                 (sdram_s1_waitrequest),
      .sdram_s1_waitrequest_from_sa                                         (sdram_s1_waitrequest_from_sa),
      .sdram_s1_write_n                                                     (sdram_s1_write_n),
      .sdram_s1_writedata                                                   (sdram_s1_writedata)
    );

  sdram the_sdram
    (
      .az_addr        (sdram_s1_address),
      .az_be_n        (sdram_s1_byteenable_n),
      .az_cs          (sdram_s1_chipselect),
      .az_data        (sdram_s1_writedata),
      .az_rd_n        (sdram_s1_read_n),
      .az_wr_n        (sdram_s1_write_n),
      .clk            (altpll_sys),
      .reset_n        (sdram_s1_reset_n),
      .za_data        (sdram_s1_readdata),
      .za_valid       (sdram_s1_readdatavalid),
      .za_waitrequest (sdram_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram),
      .zs_ba          (zs_ba_from_the_sdram),
      .zs_cas_n       (zs_cas_n_from_the_sdram),
      .zs_cke         (zs_cke_from_the_sdram),
      .zs_cs_n        (zs_cs_n_from_the_sdram),
      .zs_dq          (zs_dq_to_and_from_the_sdram),
      .zs_dqm         (zs_dqm_from_the_sdram),
      .zs_ras_n       (zs_ras_n_from_the_sdram),
      .zs_we_n        (zs_we_n_from_the_sdram)
    );

  select_i2c_clk_s1_arbitrator the_select_i2c_clk_s1
    (
      .clk                                                      (altpll_io),
      .clock_crossing_io_m1_address_to_slave                    (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_granted_select_i2c_clk_s1           (clock_crossing_io_m1_granted_select_i2c_clk_s1),
      .clock_crossing_io_m1_latency_counter                     (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_nativeaddress                       (clock_crossing_io_m1_nativeaddress),
      .clock_crossing_io_m1_qualified_request_select_i2c_clk_s1 (clock_crossing_io_m1_qualified_request_select_i2c_clk_s1),
      .clock_crossing_io_m1_read                                (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1   (clock_crossing_io_m1_read_data_valid_select_i2c_clk_s1),
      .clock_crossing_io_m1_requests_select_i2c_clk_s1          (clock_crossing_io_m1_requests_select_i2c_clk_s1),
      .clock_crossing_io_m1_write                               (clock_crossing_io_m1_write),
      .clock_crossing_io_m1_writedata                           (clock_crossing_io_m1_writedata),
      .d1_select_i2c_clk_s1_end_xfer                            (d1_select_i2c_clk_s1_end_xfer),
      .reset_n                                                  (altpll_io_reset_n),
      .select_i2c_clk_s1_address                                (select_i2c_clk_s1_address),
      .select_i2c_clk_s1_chipselect                             (select_i2c_clk_s1_chipselect),
      .select_i2c_clk_s1_readdata                               (select_i2c_clk_s1_readdata),
      .select_i2c_clk_s1_readdata_from_sa                       (select_i2c_clk_s1_readdata_from_sa),
      .select_i2c_clk_s1_reset_n                                (select_i2c_clk_s1_reset_n),
      .select_i2c_clk_s1_write_n                                (select_i2c_clk_s1_write_n),
      .select_i2c_clk_s1_writedata                              (select_i2c_clk_s1_writedata)
    );

  select_i2c_clk the_select_i2c_clk
    (
      .address    (select_i2c_clk_s1_address),
      .chipselect (select_i2c_clk_s1_chipselect),
      .clk        (altpll_io),
      .out_port   (out_port_from_the_select_i2c_clk),
      .readdata   (select_i2c_clk_s1_readdata),
      .reset_n    (select_i2c_clk_s1_reset_n),
      .write_n    (select_i2c_clk_s1_write_n),
      .writedata  (select_i2c_clk_s1_writedata)
    );

  sw_s1_arbitrator the_sw_s1
    (
      .clk                                          (altpll_io),
      .clock_crossing_io_m1_address_to_slave        (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_granted_sw_s1           (clock_crossing_io_m1_granted_sw_s1),
      .clock_crossing_io_m1_latency_counter         (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_nativeaddress           (clock_crossing_io_m1_nativeaddress),
      .clock_crossing_io_m1_qualified_request_sw_s1 (clock_crossing_io_m1_qualified_request_sw_s1),
      .clock_crossing_io_m1_read                    (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_sw_s1   (clock_crossing_io_m1_read_data_valid_sw_s1),
      .clock_crossing_io_m1_requests_sw_s1          (clock_crossing_io_m1_requests_sw_s1),
      .clock_crossing_io_m1_write                   (clock_crossing_io_m1_write),
      .clock_crossing_io_m1_writedata               (clock_crossing_io_m1_writedata),
      .d1_sw_s1_end_xfer                            (d1_sw_s1_end_xfer),
      .reset_n                                      (altpll_io_reset_n),
      .sw_s1_address                                (sw_s1_address),
      .sw_s1_chipselect                             (sw_s1_chipselect),
      .sw_s1_irq                                    (sw_s1_irq),
      .sw_s1_irq_from_sa                            (sw_s1_irq_from_sa),
      .sw_s1_readdata                               (sw_s1_readdata),
      .sw_s1_readdata_from_sa                       (sw_s1_readdata_from_sa),
      .sw_s1_reset_n                                (sw_s1_reset_n),
      .sw_s1_write_n                                (sw_s1_write_n),
      .sw_s1_writedata                              (sw_s1_writedata)
    );

  sw the_sw
    (
      .address    (sw_s1_address),
      .chipselect (sw_s1_chipselect),
      .clk        (altpll_io),
      .in_port    (in_port_to_the_sw),
      .irq        (sw_s1_irq),
      .readdata   (sw_s1_readdata),
      .reset_n    (sw_s1_reset_n),
      .write_n    (sw_s1_write_n),
      .writedata  (sw_s1_writedata)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                        (altpll_io),
      .clock_crossing_io_m1_address_to_slave                      (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_granted_sysid_control_slave           (clock_crossing_io_m1_granted_sysid_control_slave),
      .clock_crossing_io_m1_latency_counter                       (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_nativeaddress                         (clock_crossing_io_m1_nativeaddress),
      .clock_crossing_io_m1_qualified_request_sysid_control_slave (clock_crossing_io_m1_qualified_request_sysid_control_slave),
      .clock_crossing_io_m1_read                                  (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_sysid_control_slave   (clock_crossing_io_m1_read_data_valid_sysid_control_slave),
      .clock_crossing_io_m1_requests_sysid_control_slave          (clock_crossing_io_m1_requests_sysid_control_slave),
      .clock_crossing_io_m1_write                                 (clock_crossing_io_m1_write),
      .d1_sysid_control_slave_end_xfer                            (d1_sysid_control_slave_end_xfer),
      .reset_n                                                    (altpll_io_reset_n),
      .sysid_control_slave_address                                (sysid_control_slave_address),
      .sysid_control_slave_readdata                               (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                       (sysid_control_slave_readdata_from_sa),
      .sysid_control_slave_reset_n                                (sysid_control_slave_reset_n)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .clock    (sysid_control_slave_clock),
      .readdata (sysid_control_slave_readdata),
      .reset_n  (sysid_control_slave_reset_n)
    );

  timer_s1_arbitrator the_timer_s1
    (
      .clk                                             (altpll_io),
      .clock_crossing_io_m1_address_to_slave           (clock_crossing_io_m1_address_to_slave),
      .clock_crossing_io_m1_granted_timer_s1           (clock_crossing_io_m1_granted_timer_s1),
      .clock_crossing_io_m1_latency_counter            (clock_crossing_io_m1_latency_counter),
      .clock_crossing_io_m1_nativeaddress              (clock_crossing_io_m1_nativeaddress),
      .clock_crossing_io_m1_qualified_request_timer_s1 (clock_crossing_io_m1_qualified_request_timer_s1),
      .clock_crossing_io_m1_read                       (clock_crossing_io_m1_read),
      .clock_crossing_io_m1_read_data_valid_timer_s1   (clock_crossing_io_m1_read_data_valid_timer_s1),
      .clock_crossing_io_m1_requests_timer_s1          (clock_crossing_io_m1_requests_timer_s1),
      .clock_crossing_io_m1_write                      (clock_crossing_io_m1_write),
      .clock_crossing_io_m1_writedata                  (clock_crossing_io_m1_writedata),
      .d1_timer_s1_end_xfer                            (d1_timer_s1_end_xfer),
      .reset_n                                         (altpll_io_reset_n),
      .timer_s1_address                                (timer_s1_address),
      .timer_s1_chipselect                             (timer_s1_chipselect),
      .timer_s1_irq                                    (timer_s1_irq),
      .timer_s1_irq_from_sa                            (timer_s1_irq_from_sa),
      .timer_s1_readdata                               (timer_s1_readdata),
      .timer_s1_readdata_from_sa                       (timer_s1_readdata_from_sa),
      .timer_s1_reset_n                                (timer_s1_reset_n),
      .timer_s1_write_n                                (timer_s1_write_n),
      .timer_s1_writedata                              (timer_s1_writedata)
    );

  timer the_timer
    (
      .address    (timer_s1_address),
      .chipselect (timer_s1_chipselect),
      .clk        (altpll_io),
      .irq        (timer_s1_irq),
      .readdata   (timer_s1_readdata),
      .reset_n    (timer_s1_reset_n),
      .write_n    (timer_s1_write_n),
      .writedata  (timer_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  DE0_Nano_SOPC_reset_altpll_sys_domain_synch_module DE0_Nano_SOPC_reset_altpll_sys_domain_synch
    (
      .clk      (altpll_sys),
      .data_in  (1'b1),
      .data_out (altpll_sys_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    0 |
    0 |
    cpu_jtag_debug_module_resetrequest_from_sa |
    cpu_jtag_debug_module_resetrequest_from_sa |
    0);

  //reset is asserted asynchronously and deasserted synchronously
  DE0_Nano_SOPC_reset_altpll_adc_domain_synch_module DE0_Nano_SOPC_reset_altpll_adc_domain_synch
    (
      .clk      (altpll_adc),
      .data_in  (1'b1),
      .data_out (altpll_adc_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset is asserted asynchronously and deasserted synchronously
  DE0_Nano_SOPC_reset_clk_50_domain_synch_module DE0_Nano_SOPC_reset_clk_50_domain_synch
    (
      .clk      (clk_50),
      .data_in  (1'b1),
      .data_out (clk_50_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset is asserted asynchronously and deasserted synchronously
  DE0_Nano_SOPC_reset_altpll_io_domain_synch_module DE0_Nano_SOPC_reset_altpll_io_domain_synch
    (
      .clk      (altpll_io),
      .data_in  (1'b1),
      .data_out (altpll_io_reset_n),
      .reset_n  (reset_n_sources)
    );

  //DE0_Nano_SOPC_clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign DE0_Nano_SOPC_clock_0_out_endofpacket = 0;

  //DE0_Nano_SOPC_clock_1_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign DE0_Nano_SOPC_clock_1_out_endofpacket = 0;

  //clock_crossing_io_m1_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign clock_crossing_io_m1_endofpacket = 0;

  //sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  assign sysid_control_slave_clock = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/10.1/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/10.1/quartus/eda/sim_lib/220model.v"
`include "c:/altera/10.1/quartus/eda/sim_lib/sgate.v"
`include "altpll_sys.vo"
`include "ip/TARASIC_SPI_3WIRE/TERASIC_SPI_3WIRE.v"
`include "ip/TARASIC_SPI_3WIRE/SPI_3WIRE.v"
`include "ip/TARASIC_SPI_3WIRE/gsensor_fifo.v"
`include "gsensor_spi.v"
`include "ip/TERASIC_ADC_READ/TERASIC_ADC_READ.v"
// ip/TERASIC_ADC_READ/ADC_READ.vhd
`include "adc_spi_read.v"
`include "led.v"
`include "sdram.v"
`include "sdram_test_component.v"
`include "sysid.v"
`include "g_sensor_int.v"
`include "sw.v"
`include "timer.v"
`include "select_i2c_clk.v"
`include "key.v"
`include "DE0_Nano_SOPC_clock_0.v"
`include "epcs.v"
`include "jtag_uart.v"
`include "i2c_scl.v"
`include "clock_crossing_io2.v"
`include "DE0_Nano_SOPC_clock_1.v"
`include "cpu_test_bench.v"
`include "cpu_mult_cell.v"
`include "cpu_oci_test_bench.v"
`include "cpu_jtag_debug_module_tck.v"
`include "cpu_jtag_debug_module_sysclk.v"
`include "cpu_jtag_debug_module_wrapper.v"
`include "cpu.v"
`include "i2c_sda.v"
`include "clock_crossing_io.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             DE0_Nano_SOPC_clock_0_in_endofpacket_from_sa;
  wire             DE0_Nano_SOPC_clock_0_out_endofpacket;
  wire    [  1: 0] DE0_Nano_SOPC_clock_0_out_nativeaddress;
  wire             DE0_Nano_SOPC_clock_1_in_endofpacket_from_sa;
  wire             DE0_Nano_SOPC_clock_1_out_endofpacket;
  wire             DE0_Nano_SOPC_clock_1_out_nativeaddress;
  wire             SPI_CLK_from_the_adc_spi_read;
  wire             SPI_CS_n_from_the_adc_spi_read;
  wire             SPI_CS_n_from_the_gsensor_spi;
  wire             SPI_IN_to_the_adc_spi_read;
  wire             SPI_OUT_from_the_adc_spi_read;
  wire             SPI_SCLK_from_the_gsensor_spi;
  wire             SPI_SDIO_to_and_from_the_gsensor_spi;
  wire             altpll_adc;
  wire             altpll_io;
  wire             altpll_sdram;
  wire             altpll_sys;
  wire             altpll_sys_c3_out;
  wire             bidir_port_to_and_from_the_i2c_sda;
  wire             clk;
  reg              clk_50;
  wire             clock_crossing_io2_s1_endofpacket_from_sa;
  wire             clock_crossing_io_m1_endofpacket;
  wire             clock_crossing_io_s1_endofpacket_from_sa;
  wire             data0_to_the_epcs;
  wire             dclk_from_the_epcs;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  wire             in_port_to_the_g_sensor_int;
  wire    [  1: 0] in_port_to_the_key;
  wire    [  3: 0] in_port_to_the_sw;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             locked_from_the_altpll_sys;
  wire             out_port_from_the_i2c_scl;
  wire    [  7: 0] out_port_from_the_led;
  wire             out_port_from_the_select_i2c_clk;
  wire             phasedone_from_the_altpll_sys;
  reg              reset_n;
  wire             sce_from_the_epcs;
  wire             sdo_from_the_epcs;
  wire             sysid_control_slave_clock;
  wire    [ 12: 0] zs_addr_from_the_sdram;
  wire    [  1: 0] zs_ba_from_the_sdram;
  wire             zs_cas_n_from_the_sdram;
  wire             zs_cke_from_the_sdram;
  wire             zs_cs_n_from_the_sdram;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram;
  wire    [  1: 0] zs_dqm_from_the_sdram;
  wire             zs_ras_n_from_the_sdram;
  wire             zs_we_n_from_the_sdram;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  DE0_Nano_SOPC DUT
    (
      .SPI_CLK_from_the_adc_spi_read        (SPI_CLK_from_the_adc_spi_read),
      .SPI_CS_n_from_the_adc_spi_read       (SPI_CS_n_from_the_adc_spi_read),
      .SPI_CS_n_from_the_gsensor_spi        (SPI_CS_n_from_the_gsensor_spi),
      .SPI_IN_to_the_adc_spi_read           (SPI_IN_to_the_adc_spi_read),
      .SPI_OUT_from_the_adc_spi_read        (SPI_OUT_from_the_adc_spi_read),
      .SPI_SCLK_from_the_gsensor_spi        (SPI_SCLK_from_the_gsensor_spi),
      .SPI_SDIO_to_and_from_the_gsensor_spi (SPI_SDIO_to_and_from_the_gsensor_spi),
      .altpll_adc                           (altpll_adc),
      .altpll_io                            (altpll_io),
      .altpll_sdram                         (altpll_sdram),
      .altpll_sys                           (altpll_sys),
      .altpll_sys_c3_out                    (altpll_sys_c3_out),
      .bidir_port_to_and_from_the_i2c_sda   (bidir_port_to_and_from_the_i2c_sda),
      .clk_50                               (clk_50),
      .data0_to_the_epcs                    (data0_to_the_epcs),
      .dclk_from_the_epcs                   (dclk_from_the_epcs),
      .in_port_to_the_g_sensor_int          (in_port_to_the_g_sensor_int),
      .in_port_to_the_key                   (in_port_to_the_key),
      .in_port_to_the_sw                    (in_port_to_the_sw),
      .locked_from_the_altpll_sys           (locked_from_the_altpll_sys),
      .out_port_from_the_i2c_scl            (out_port_from_the_i2c_scl),
      .out_port_from_the_led                (out_port_from_the_led),
      .out_port_from_the_select_i2c_clk     (out_port_from_the_select_i2c_clk),
      .phasedone_from_the_altpll_sys        (phasedone_from_the_altpll_sys),
      .reset_n                              (reset_n),
      .sce_from_the_epcs                    (sce_from_the_epcs),
      .sdo_from_the_epcs                    (sdo_from_the_epcs),
      .zs_addr_from_the_sdram               (zs_addr_from_the_sdram),
      .zs_ba_from_the_sdram                 (zs_ba_from_the_sdram),
      .zs_cas_n_from_the_sdram              (zs_cas_n_from_the_sdram),
      .zs_cke_from_the_sdram                (zs_cke_from_the_sdram),
      .zs_cs_n_from_the_sdram               (zs_cs_n_from_the_sdram),
      .zs_dq_to_and_from_the_sdram          (zs_dq_to_and_from_the_sdram),
      .zs_dqm_from_the_sdram                (zs_dqm_from_the_sdram),
      .zs_ras_n_from_the_sdram              (zs_ras_n_from_the_sdram),
      .zs_we_n_from_the_sdram               (zs_we_n_from_the_sdram)
    );

  sdram_test_component the_sdram_test_component
    (
      .clk      (altpll_sys),
      .zs_addr  (zs_addr_from_the_sdram),
      .zs_ba    (zs_ba_from_the_sdram),
      .zs_cas_n (zs_cas_n_from_the_sdram),
      .zs_cke   (zs_cke_from_the_sdram),
      .zs_cs_n  (zs_cs_n_from_the_sdram),
      .zs_dq    (zs_dq_to_and_from_the_sdram),
      .zs_dqm   (zs_dqm_from_the_sdram),
      .zs_ras_n (zs_ras_n_from_the_sdram),
      .zs_we_n  (zs_we_n_from_the_sdram)
    );

  initial
    clk_50 = 1'b0;
  always
    #10 clk_50 <= ~clk_50;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on