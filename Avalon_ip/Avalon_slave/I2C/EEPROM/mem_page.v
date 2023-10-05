module mem_page (
    clk,
    cs,
    write,
    data_i,
    data_o
);
    parameter PAGE_SIZE = BYTE_NUM * 8 = 64;
    input                  clk;
    input                  cs;
    input                  write;
    input  [PAGE_SIZE-1:0] data_i;
    output [PAGE_SIZE-1:0] data_o;
    reg    [PAGE_SIZE-1:0] mem;

    assign data_o = mem;

    always @(posedge clk) begin
        if(cs)begin
	        if (write) begin
                mem <= data_i;
	        end
        end
    end    
endmodule
