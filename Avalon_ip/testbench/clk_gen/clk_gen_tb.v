`timescale 1ns/1ps
`default_nettype none
`include "../../HDL_Library/clk_gen.v"
module clk_gen_tb;
    
    reg clk;
    reg reset_n;
    wire [9:0]clk_o;
    //parameter clk_div = 3;
    parameter period = 20;//20ns
    initial begin
        $dumpfile("clk_gen.vcd");
        $dumpvars(0, clk_gen_tb);
    end
    initial begin
        clk = 0;
        reset_n = 1;
        #period reset_n = 0;
        #period reset_n = 1;
        forever begin
            #(period/2) clk = ~clk;    
        end
    end
    reg [31:0]cnt;
    //finish condition
    always @(posedge clk or negedge reset_n)begin
        if(!reset_n)begin
            cnt <= 0;
        end else begin
            if(cnt > 10000)begin
                $finish;
            end else begin
                cnt <= cnt + 1;
            end
        end
    end
    genvar i;
    generate
        for(i = 0; i < 10; i = i + 1)begin
            clk_gen dut(.clk_i(clk),.reset_n(reset_n),.clk_div(i),.clk_o(clk_o[i]));
        end
    endgenerate
    /*clk_gen dut(
        .clk_i      (clk),
        .reset_n    (reset_n),
        .clk_div    (clk_div),
        .clk_o      (clk_o)
    );*/
endmodule