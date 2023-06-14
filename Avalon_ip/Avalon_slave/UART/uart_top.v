module uart_top (
    clk,//system clock
    reset_n,
    clk_div,
);
    wire uart_clk;
    wire rx_clk;
    wire tx_clk;
    assign rx_clk = uart_clk;
    assign tx_clk = uart_clk;
    clk_gen uart_clk_gen(
        .clk_i   (clk),
        .reset_n (reset_n),
        .clk_div (clk_div),
        .clk_o   (uart_clk)
    );

    uart_core uart_core_inst(
        .reset_n    (reset_n),
        .rx_clk     (rx_clk),
        .rx_data    (rx_data),
        .rx_done    (rx_done),
        .rx         (rx),
        .tx_clk     (tx_clk),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx)
    );
endmodule