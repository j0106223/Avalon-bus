module mem_page (
    clk,
    cs,
    addr,
    write,
    data_i,
    data_o
);
    parameter BYTE_NUM = 8;
    input  [7:0] data_i;
    output [7:0] data_o;
    input  [2:0] addr;
    input clk;
    input cs;
    input write;
    reg [7:0] mem [0:BYTE_NUM-1];
    assign data_o = mem[addr];
    always @(posedge clk) begin
        if(cs)begin
	        if (write) begin
                mem[addr] <= data_i;
	        end
        end
    end    
endmodule
