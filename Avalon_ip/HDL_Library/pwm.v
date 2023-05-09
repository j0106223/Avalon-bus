module pwm (
    clk,
    reset_n,
    period,
    duty_cycle,
    pwm_o
);
    input   clk;
    input   reset_n;
    input [31:0] period;
    input [31:0] duty_cycle;
    output       pwm_o;
    reg   [31:0]cnt;
    assign pwm_o = (cnt >= duty_cycle) ? 1'b0 : 1'b1;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            cnt <= 0;
        end else begin
            if(cnt > period)begin
                cnt <= 0;
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end
endmodule