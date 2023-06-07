module i2s_top (
    ports
);
    //fsm
    //dc fifo
    //i2s core
    //clock gen
    input clk;
    input reset_n;

    
    i2s_core #(.DW())i2s_core_inst(
        .reset_n(reset_n),
        .data_right(),
        .data_left(),
        .sck(i2s_clk),
        .sd(),
        .ws()
    );


    dcfifo #(
            .WIDTH(16),
            .DEPTH(32)
    ) dcfifo(
        .wclk();
        .rclk();
        .reset_n(reset_n);
        .write(write);
        .read(read);
        .wdata(wdata);
        .rdata(rdata);
        .full(full);
        .empty(empty);
        .used(used);
    );
    
    
    clk_gen clk_gen_i2s(
        .clk_i   (clk),
        .reset_n (reset_n),
        .clk_div (clk_div),
        .clk_o   (i2s_clk)
    );
endmodule