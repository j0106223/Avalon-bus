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
    input  miso;
    output mosi;
    output [DEVICES-1:0]cs;
endmodule