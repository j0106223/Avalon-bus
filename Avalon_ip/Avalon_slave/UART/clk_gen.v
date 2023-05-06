`default_nettype none
module clk_gen (
    clk_div,
    clk_i,
    clk_o
);
    input [31:0]clk_div;
    input reset_n;
    input  clk_i;
    output clk_o;

    reg clk_q;
    assign clk_o = clk_q;
    always @(posedge clk_i or negedge reset_n) begin
        if(!reset_n)begin
            clk_q <= 0;
        end else begin
            if()begin
                clk_q <= 0;
            end else begin
                clk_q <= 1;
            end
        end
    end
    assign clk_o = clk_q;
endmodule