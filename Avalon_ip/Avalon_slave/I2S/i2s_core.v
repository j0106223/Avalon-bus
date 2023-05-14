module i2s_core (
    clk,
    reset_n,
);
    input clk;
    input reset_n;
    input [7:0]data_right;//right channel
    input [7:0]data_left;//left channel
    output scl;
    output sda;//one way transaction
    output ws;//left right channel

endmodule