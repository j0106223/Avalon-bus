module eeprom (
    clk,
    write,
    row,
    col,
    data_i,
	data_o
);
    parameter PAGE_NUM = 32;
    parameter PAGE_SIZE = BYTE_NUM * 8 = 64;
    input clk;
    input write;
    input  [4:0] row;
    input  [2:0] col;
	input  [PAGE_SIZE-1:0] data_i;
	output [7:0] data_o;
    assign data_o = data_q[row];
    wire [PAGE_SIZE-1:0] data_q [0:PAGE_NUM-1];

    wire [PAGE_NUM-1:0] page_cs;
    genvar i;
    generate
        for(i = 0;i <  PAGE_NUM;i = i + 1)begin:cs_gen
            assign page_cs[i] = (i == row); 
        end
        for (i = 0; i < PAGE_NUM; i = i + 1) begin:mem_gen
            mem_page mem_inst(
                .clk    (clk),//STOP PULSE SIGNAL
                .cs     (page_cs[i]),
                .write  (write),
                .data_i (data_i),
                .data_o (data_q[i])
            );
        end
    endgenerate

    reg [7:0] page_buffer[0:7];
    always @(posedge scl) begin
        page_buffer[0]<=[];
    end
    page_buffer = {};
    [63:0] page_buffer
endmodule
