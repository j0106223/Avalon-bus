`default_nettype none
module clk_gen (
    
);
    input []div;
    input clk_i;
    input reset_n;
    output clk_o;

    always @(posedge clk_i or negedge reset_n) begin
        if(!reset_n)begin

        end else begin
            
        end
    end
    assign clk_o = ;
endmodule