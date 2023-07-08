// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/10.1sp1/ip/merlin/altera_merlin_std_arbitrator/altera_merlin_std_arbitrator.sv.terp#1 $
// $Revision: #1 $
// $Date: 2010/11/11 $
// $Author: max $

// ------------------------------------------------------------
// Wrapper for the standard arbitrator
//
// Provides a Merlin arbitrator API around the standard arb
// implementation.
// ------------------------------------------------------------

`timescale 1 ns / 1 ns
// ------------------------------------------
// Generation parameters:
//   output_name:         altera_merlin_std_arbitrator_nwds6k7f
//   NUM_REQUESTERS:      1
//   SCHEME:              "round-robin"
//   ST_DATA_W:           8
//   ST_CHANNEL_W:        1
// ------------------------------------------

module altera_merlin_std_arbitrator_nwds6k7f
(
    // --------------------------------------
    // Request sinks
    // --------------------------------------
    input                       sink0_valid,
    input [8-1    : 0]  sink0_data,
    input [1-1 : 0]  sink0_channel,
    input                       sink0_startofpacket,
    input                       sink0_endofpacket,


    // --------------------------------------
    // Clock/reset
    // --------------------------------------
    input clk,
    input reset,
   
    // --------------------------------------
    // Grant source
    // --------------------------------------
    output [1-1:0] next_grant,    // st source data
    input                       ack            // st source ready
);

    localparam NUM_REQUESTERS = 1;
    localparam SCHEME         = "round-robin";
    localparam ST_DATA_W      = 8;
    localparam ST_CHANNEL_W   = 1;
    // --------------------------------------
    // Signals
    // --------------------------------------
    wire [NUM_REQUESTERS-1:0]   request;

    assign request[0] = sink0_valid;

    altera_merlin_std_arbitrator_core
    #(
        .NUM_REQUESTERS(NUM_REQUESTERS),
        .SCHEME        (SCHEME)
    ) 
    arb (
        .request    (request),
        .next_grant (next_grant),
        .ack        (ack),

        .clk        (clk),
        .reset      (reset)
    );

endmodule



