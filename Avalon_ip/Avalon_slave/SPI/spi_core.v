`default_nettype none
module spi_core (
    clk,
    reset_n,
    sclk,
    mosi,
    miso,
    cs
);
    parameter DEVICES = 1;
    input clk;
    input reset_n;
    output sclk;
    input  miso;
    output mosi;
    output [DEVICES-1:0]cs;

    synchronizer miso_sync(.clk(clk), reset_n(reset_n), in(), out());
endmodule