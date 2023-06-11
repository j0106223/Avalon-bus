`timescale 1ns/1ps
module tx_core_tb;
    reg tx_clk;
    reg reset_n;
    reg tx_valid;
    reg [7:0]tx_data;
    reg tx_ready;
    wire tx;
    initial begin
        tx_clk      = 0;
        tx_valid    = 0;
        tx_data     = 0;
        tx_ready    = 0;
        reset_n     = 1;
        #1 reset_n  = 0;
        #1 reset_n  = 1;

    end
    always #1 clk = ~clk;
    
    tx_core dut(
        .tx_clk     (tx_clk),
        .reset_n    (reset_n),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx)
    );


    task tx_write(
        input [7:0]data
    );
        begin
        end
    endtask
endmodule