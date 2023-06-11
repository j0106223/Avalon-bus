module tx_core_tb;
    reg tx_clk;
    reg reset_n;
    reg tx_valid;
    reg tx_data;
    reg tx_ready;
    wire tx;
    initial begin
        
    end
    tx_core dut(
        .tx_clk     (tx_clk),
        .reset_n    (reset_n),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx)
    );


    task ();
        begin
        end
    endtask
endmodule