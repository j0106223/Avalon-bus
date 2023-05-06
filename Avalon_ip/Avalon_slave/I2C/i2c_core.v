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
    input rdata_i;
    output wdata_o;
    input sda_i;
    input scl_i;
    output sda_o;
    output scl_o;
    
endmodule