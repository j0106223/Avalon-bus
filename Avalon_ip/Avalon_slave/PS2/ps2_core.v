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
    wire    ps2_sync_clk;
    wire    ps2_sync_data;
    synchronizer synchronizer_ps2_clk(
        .clk        (clk),
        .reset_n    (reset_n),
        .in         (ps2_clk),
        .out        (ps2_sync_clk)
    );
    synchronizer synchronizer_ps2_data(
        .clk        (clk),
        .reset_n    (reset_n),
        .in         (ps2_data_i),
        .out        (ps2_sync_data)
    );
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin

        end else begin
            
        end
    end

endmodule