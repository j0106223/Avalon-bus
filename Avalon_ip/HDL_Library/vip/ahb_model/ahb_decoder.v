module ahb_decoder (
    haddr,
    hsel
);
    parameter AW = 32;
    parameter SLAVE_0_BASE = 0;
    parameter SLAVE_0_SIZE = 0;
    parameter SLAVE_NUM = 1;
    input   [AW-1:0]haddr;
    output reg [SLAVE_NUM-1:0]hsel;

    always@* begin
        if(haddr >= SLAVE_0_BASE && haddr < (SLAVE_0_BASE + SLAVE_0_SIZE))begin
            hsel = 1'b1;
        end else begin
            hsel = 1'b0;
        end
    end
endmodule