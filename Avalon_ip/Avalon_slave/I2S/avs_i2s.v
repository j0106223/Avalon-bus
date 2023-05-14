module avs_i2s (
    clk,
    reset_n,
    avs_s0_address,
    avs_s0_read,
    avs_s0_write,
    avs_s0_waitrequest,
    avs_s0_readdata,
    avs_s0_writedata
);
    input clk;
    input reset_n;
    input        avs_s0_address;
    input        avs_s0_read;
    input        avs_s0_write;
    output       avs_s0_waitrequest;
    output [31:0]avs_s0_readdata;
    input  [31:0]avs_s0_writedata;

    
endmodule