module data_memory(
    clk
    address
    read
    write
    rdata
    wdata
);
    parameter AW = 32;
    parameter DW = 32;
    input           clk;
    input  [AW-1:0] address;
    input  [DW-1:0] wdata;
    output [DW-1:0] rdata;
    input           read;
    input           write;

    reg [7:0] mem [0:1024];
    reg [DW-1:0] rdata;
    always @(posedge clk) begin
        if (write) begin
            mem[address] <= wdata;
        end
    end

    always @(posedge clk) begin
        if (read) begin
            rdata <= mem[address];
        end
    end
    
endmodule