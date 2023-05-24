module vag_core #(
    parameter WDITH = 640, 
    parameter HIGH = 480
)(
    clk,
    reset_n
    en,
    pixel,
    r,
    g,
    b,
    hsync,
    vsync
);
    parameter COLOR_DEPTH = 4;
    input clk;
    input reset_n;
    input en;
    input  [COLOR_DEPTH * 3 - 1:0] pixel;
    output [COLOR_DEPTH - 1:0]         r;
    output [COLOR_DEPTH - 1:0]         g;
    output [COLOR_DEPTH - 1:0]         b;
    output reg hsync;
    output reg vsync;
    assign {b, g, r} = pixel; 
    always @(posedge clk or negedge reset_n) begin//25mhz
        if(!reset_n)begin
            hsync <= 0;
            vsync <= 0;
        end else begin
            if()begin
                hsync <= 1'b1;
            end else begin
                hsync <= 1'b0;
            end
            if()begin
                vsync <= 1'b1;
            end else begin
                vsync <= 1'b0;
            end
        end
    end


    /*
     instance a FIFO
    */
endmodule