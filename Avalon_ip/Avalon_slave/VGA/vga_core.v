module vag_core (
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
    parameter WDITH = 640;
    parameter HIGH = 480;
    parameter H_FP = 16;
    parameter H_SP = 96;
    parameter H_BP = 48;
    parameter V_FP = 10;
    parameter V_SP = 2;
    parameter V_BP = 33;
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
    reg hcnt;
    reg vcnt; 
    always @(posedge clk or negedge reset_n) begin//25mhz
        if(!reset_n)begin
            hsync <= 0;
            vsync <= 0;
        end else begin
            if(hcnt >)begin
                hsync <= 1'b1;
            end else begin
                hsync <= 1'b0;
            end
            if(vcnt >)begin
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