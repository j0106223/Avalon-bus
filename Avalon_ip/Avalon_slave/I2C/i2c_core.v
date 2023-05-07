`default_nettype none
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
    input sda_i;
    input scl_i;
    output sda_o;
    output scl_o;
    
endmodule