module ahb_decoder (
    haddr,
    hsel
);
    parameter AW = 32;
    parameter SLAVE_0_BASE;
    parameter SLAVE_0_BSIZE;
    parameter SLAVE_NUM = 1;
    input   [AW-1:0]haddr;
    output [SLAVE_NUM-1:0]hsel;
endmodule