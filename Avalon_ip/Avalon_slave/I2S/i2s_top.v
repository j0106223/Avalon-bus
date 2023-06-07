module i2s_top (
    ports
);
    //fsm
    //dc fifo
    //i2s core
    //clock gen

    i2s_core #(.DW())i2s_core_inst(
        .reset_n(reset_n),
        .data_right(),
        .data_left(),
        .sck(i2s_clk),
        .sd(),
        .ws()
    );

    clk_gen clk_gen_i2s(
        .clk_i   (clk),
        .reset_n (reset_n),
        .clk_div (clk_div),
        .clk_o   (i2s_clk)
    );
endmodule