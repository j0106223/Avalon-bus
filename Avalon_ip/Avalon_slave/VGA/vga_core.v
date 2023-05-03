module vag_core (
    clk,
    
    pixel,
    r,
    g,
    b
);
    parameter COLOR_DEPTH = 4;
    input  [COLOR_DEPTH * 3 - 1:0] pixel;
    output [COLOR_DEPTH - 1:0]         r;
    output [COLOR_DEPTH - 1:0]         g;
    output [COLOR_DEPTH - 1:0]         b;
    /*
     instance a FIFO
    */
endmodule