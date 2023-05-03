`default_nettype none
module clk_gen (
    
);
    input []div;
    input clk_i;
    input reset_n;
    output clk_o;

    reg clk_q;
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