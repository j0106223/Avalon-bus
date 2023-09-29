module mem_page (
    clk,
    cs,
    byte_addr,
    rw,
    data_i,
    data_o
);
    input  [7:0] data_i;
    output [7:0] data_o;
    input  [2:0] byte_addr;
    parameter page_size = 8;
    input cs;//page address selected
    input clk;//fsm en
    reg [7:0] mem [0:page_size];
    assign data_o = mem[byte_addr];
    always @(posedge clk) begin
        if(cs)begin
            mem[byte_addr] <= data_i;;
        end
    end
    
endmodule