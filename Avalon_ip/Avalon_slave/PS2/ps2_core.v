module ps2_core (
    clk,
    reset_n,
    rdata_i,
    wdata_o,
    ps2_clk,
    ps2_data_i,
    ps2_data_o,
);
    input   clk;
    input   reset_n;
    input   ps2_clk;
    input   ps2_data_i;
    output  ps2_data_o;
    input   rdata_i;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin

        end else begin
            
        end
    end

    //sync ps2 clock
    wire ps2_clk_sync;
    reg [1:0]ps2_clk_q;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            ps2_clk_q <= 2'b00;
        end else begin
            ps2_clk_q[0] <= ps2_clk;
            ps2_clk_q[1] <= ps2_clk_q[0];
        end
    end
    //sync ps2 data
    reg [1:0]ps2_data_i_q;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
        end else begin
        end
    end
endmodule