module eeprom (
    clk,
    write,
    row,
    col,
    data_i,
	data_o
);
    parameter PAGE_NUM = 32;
    input clk;
    input write;
    input  [4:0] row;
    input  [2:0] col;
	input  [7:0] data_i;
	output [7:0] data_o;
    assign data_o = data_q[row];
    wire [7:0] data_q [0:PAGE_NUM-1];

    wire [PAGE_NUM-1:0] page_cs;
    genvar i;
    generate
        for(i = 0;i <  PAGE_NUM;i = i + 1)begin:cs_gen
            assign page_cs[i] = (i == row); 
        end
        for (i = 0; i < PAGE_NUM; i = i + 1) begin:mem_gen
            mem_page mem_inst(
                .clk    (clk),
                .cs     (page_cs[i]),
                .addr   (col),
                .write  (write),
                .data_i (data_i),
                .data_o (data_q[i])
            );
        end
    endgenerate
    
endmodule
