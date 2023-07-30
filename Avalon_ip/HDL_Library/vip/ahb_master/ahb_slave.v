module ahb_slave (
    hclk,
    hreset_n,
    haddr,
    htrans,
    hsize,
    hwrite,
    hwdata,
    hrdata,
    hready_i,
    hready_o
);
    parameter DW = 32;
    parameter AW = 32;
    input               hclk;
    input               hreset_n;
    output reg [AW-1:0] haddr;
    output reg    [1:0] htrans;
    output reg    [2:0] hsize;
    output reg          hwrite;
    output reg [DW-1:0] hwdata;
    input      [DW-1:0] hrdata;
    input               hready_i;
    output reg          hready_o;
endmodule 