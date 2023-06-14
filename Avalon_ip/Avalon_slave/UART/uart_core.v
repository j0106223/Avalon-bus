`default_nettype none
//no parity check
//2-stage input sync
module uart_core (
    reset_n,
    rx_clk,
    rx_data,
    rx_done,
    rx,
    tx_clk,
    tx_valid,
    tx_data,
    tx_ready,
    tx_done,
    tx
);
    input        reset_n;
    input        rx_clk;
    output [7:0] rx_data;
    output       rx_done;
    input        rx;
    input        tx_clk;
    input        tx_valid;
    input  [7:0] tx_data;
    output       tx_ready;
    output       tx_done;
    output       tx;
    
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