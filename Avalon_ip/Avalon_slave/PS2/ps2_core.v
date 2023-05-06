module ps2_core (
    clk,
    reset_n,
    rdata_i,
    wdata_o,
    ps2_clk,
    ps2_data,
);
    input clk;
    input reset_n;
    input rdata_i;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin

        end else begin
            
        end
    end
endmodule