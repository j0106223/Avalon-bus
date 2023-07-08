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


// $Id: //acds/rel/10.1sp1/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2010/11/11 $
// $Author: max $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module altera_merlin_router_hbodtawx
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [68-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [68-1    : 0] src_data,
    output reg [17-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 44;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 66;
    localparam PKT_DEST_ID_L = 62;
    localparam ST_DATA_W = 68;
    localparam ST_CHANNEL_W = 17;
    localparam DECODER_TYPE = 0;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;

    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(32'h20 - 32'h0);
    localparam PAD1 = log2ceil(32'h138 - 32'h130);
    localparam PAD2 = log2ceil(32'h70 - 32'h60);
    localparam PAD3 = log2ceil(32'h80 - 32'h70);
    localparam PAD4 = log2ceil(32'h90 - 32'h80);
    localparam PAD5 = log2ceil(32'ha0 - 32'h90);
    localparam PAD6 = log2ceil(32'h40 - 32'h20);
    localparam PAD7 = log2ceil(32'hb0 - 32'ha0);
    localparam PAD8 = log2ceil(32'hc0 - 32'hb0);
    localparam PAD9 = log2ceil(32'hd0 - 32'hc0);
    localparam PAD10 = log2ceil(32'he0 - 32'hd0);
    localparam PAD11 = log2ceil(32'hf0 - 32'he0);
    localparam PAD12 = log2ceil(32'h60 - 32'h40);
    localparam PAD13 = log2ceil(32'h100 - 32'hf0);
    localparam PAD14 = log2ceil(32'h110 - 32'h100);
    localparam PAD15 = log2ceil(32'h120 - 32'h110);
    localparam PAD16 = log2ceil(32'h130 - 32'h120);

    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 32'h138;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;
    localparam RG = RANGE_ADDR_WIDTH-1;

    reg [PKT_ADDR_W-1 : 0] address;

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;


    always @* begin
        src_data    = sink_data;
        src_channel = 0;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------
        address     = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];

        // ( 0x0 .. 0x20 )
        if ( {address[RG:PAD0],{PAD0{1'b0}}} == 'h0 ) begin
            src_channel = 'b00000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
        end

        // ( 0x130 .. 0x138 )
        if ( {address[RG:PAD1],{PAD1{1'b0}}} == 'h130 ) begin
            src_channel = 'b00000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
        end

        // ( 0x60 .. 0x70 )
        if ( {address[RG:PAD2],{PAD2{1'b0}}} == 'h60 ) begin
            src_channel = 'b00000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
        end

        // ( 0x70 .. 0x80 )
        if ( {address[RG:PAD3],{PAD3{1'b0}}} == 'h70 ) begin
            src_channel = 'b00000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
        end

        // ( 0x80 .. 0x90 )
        if ( {address[RG:PAD4],{PAD4{1'b0}}} == 'h80 ) begin
            src_channel = 'b00000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
        end

        // ( 0x90 .. 0xa0 )
        if ( {address[RG:PAD5],{PAD5{1'b0}}} == 'h90 ) begin
            src_channel = 'b00000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
        end

        // ( 0x20 .. 0x40 )
        if ( {address[RG:PAD6],{PAD6{1'b0}}} == 'h20 ) begin
            src_channel = 'b00000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
        end

        // ( 0xa0 .. 0xb0 )
        if ( {address[RG:PAD7],{PAD7{1'b0}}} == 'ha0 ) begin
            src_channel = 'b00000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
        end

        // ( 0xb0 .. 0xc0 )
        if ( {address[RG:PAD8],{PAD8{1'b0}}} == 'hb0 ) begin
            src_channel = 'b00000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
        end

        // ( 0xc0 .. 0xd0 )
        if ( {address[RG:PAD9],{PAD9{1'b0}}} == 'hc0 ) begin
            src_channel = 'b00000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
        end

        // ( 0xd0 .. 0xe0 )
        if ( {address[RG:PAD10],{PAD10{1'b0}}} == 'hd0 ) begin
            src_channel = 'b00000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
        end

        // ( 0xe0 .. 0xf0 )
        if ( {address[RG:PAD11],{PAD11{1'b0}}} == 'he0 ) begin
            src_channel = 'b00000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
        end

        // ( 0x40 .. 0x60 )
        if ( {address[RG:PAD12],{PAD12{1'b0}}} == 'h40 ) begin
            src_channel = 'b00001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
        end

        // ( 0xf0 .. 0x100 )
        if ( {address[RG:PAD13],{PAD13{1'b0}}} == 'hf0 ) begin
            src_channel = 'b00010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
        end

        // ( 0x100 .. 0x110 )
        if ( {address[RG:PAD14],{PAD14{1'b0}}} == 'h100 ) begin
            src_channel = 'b00100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
        end

        // ( 0x110 .. 0x120 )
        if ( {address[RG:PAD15],{PAD15{1'b0}}} == 'h110 ) begin
            src_channel = 'b01000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
        end

        // ( 0x120 .. 0x130 )
        if ( {address[RG:PAD16],{PAD16{1'b0}}} == 'h120 ) begin
            src_channel = 'b10000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
        end

    end

    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[63:0] val;
        reg [63:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


