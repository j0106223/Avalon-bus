
module shift_reg (
    clk,
    reset_n,
    en,
    in,
    out,
);
    input clk,
    input reset_n,
    input en,
    input in,
    output out    

    always @(posedge clk or negedge reset_n) begin
        
    end
endmodule