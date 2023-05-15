`default_nettype none
//only support single master multi slave arch
//so scl no need to use open-drain io, but sda does
module i2c_core (
    clk,
    reset_n,
    rdata_i,
    wdata_o,
    sda_i,
    scl_i,
    sda_o,
    scl_o
);
    input clk;
    input reset_n;
    input  [7:0] rdata_i;
    output [7:0] wdata_o;
    input [31:0]clk_div;
    input sda_i;
    input scl_i;
    output sda_o;
    output scl_o;
    //start
    //rdata
    //wdata
    //stop
    clk_gen i2c_clock_gen(
        .clk_i      (clk),
        .reset_n    (reset_n),
        .clk_div    (clk_div),
        .clk_o      (i2c_clk)
    );
//========================FSM===============================================
    localparam IDLE ;
    localparam START ;
    localparam RDATA ;
    localparam WDATA ;
    localparam STOP ;
    
//========================FSM===============================================
endmodule