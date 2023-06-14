`default_nettype none
//no parity check
//2-stage input sync
module uart_core (
    clk,
    reset_n,
    rx_ready,
    rx_data,
    tx_valid,
    tx_ready,
    tx_data,
    clk_div,
    rx,
    tx
);
    input clk;
    input reset_n;
    //rx logic
    output rx_ready;
    output [7:0]rx_data;
    //tx logic
    input  tx_valid;
    output tx_ready;
    input [7:0]tx_data;

    input clk_div; 
    //IO
    input  rx;
    output tx;


    rx_core rx_core_inst(
        .rx_clk  (rx_clk),
        .reset_n (reset_n),
        .rx_data (rx_data),
        .rx_done (rx_done),
        .rx      (tx)
    );

    tx_core tx_core_inst(
        .tx_clk     (tx_clk),
        .reset_n    (reset_n),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx)
    );
endmodule