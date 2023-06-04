`timescale 1ns/1ps
module i2s_tb;
    
    reg reset_n;
    reg sck;
    reg ws;

    reg [7:0]data_right;
    reg [7:0]data_left;
    wire sd;
    initial begin
        $dumpfile("i2s.vcd");
        $dumpvars(0, i2s_tb);    
    end

    initial begin
        #10000;
        $finish;
    end
    initial begin
        reset_n = 1;
        sck = 0;
        #1;
        reset_n = 0;
        #1;
        reset_n = 1;
        forever begin
           #1 sck = ~sck;
        end
    end
    reg [7:0]cnt;
    always @(posedge sck or negedge reset_n) begin
        if(!reset_n)begin
            cnt <= 0;
            ws  <= 0;
            data_right <= $random();
            data_left <= $random();
        end else begin
            if(cnt > 15)begin
                cnt <= 0;
                ws <= ~ws;
                data_left  <= $random();
                data_right <= $random();
            end else begin
                cnt <= cnt + 1'b1;
                if(cnt == 7)begin
                    ws <= ~ws;
                end
            end
        end
    end


    i2s_core dut(
        .reset_n    (reset_n),
        .sck        (sck),
        .ws         (ws),
        .data_right (data_right),
        .data_left  (data_left),
        .sd         (sd)
    );
endmodule