module clk_gen
#(
    parameter ADJUST_DUTY_CYCLE_EN = 0
)(
    clk_i,
    reset_n,
    clk_div,
    clk_o
);
    input       clk_i;
    input       reset_n;
    //let software decide clk_div value to reach the target freq
    input [31:0]clk_div;
    output      clk_o;

    generate
        if(ADJUST_DUTY_CYCLE_EN)begin
           //pwm 
        end else begin
           //50-50
        end
    endgenerate
    reg [31:0]cnt;
    reg clk_q;
    assign clk_o = clk_q;
    always @(posedge clk_i or negedge reset_n) begin
        if(!reset_n)begin
            cnt   <= 0;
            clk_q <= 0;
        end else begin
            if(cnt > clk_div)begin
                clk_q <= ~clk_q;
                cnt <= 0;
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end
endmodule