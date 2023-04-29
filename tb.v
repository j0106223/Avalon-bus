`timescale 1ns/1ps
module tb;
parameter AW = 8;
parameter DW = 32;
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
    end
    
    reg clk;
    reg reset_n;
    initial begin
        clk = 0;
        reset_n = 0;
        #10;
        reset_n = 1;
        forever begin
            #10 clk = ~clk;
        end
    end

    reg [AW-1:0]address;
    reg [DW-1:0]writedata;
    reg write;
    reg read;
    reg waitrequest;

    initial begin
        read = 0;
        write = 0;
        waitrequest = 1;
    end
    integer i;
    integer trans_cnt;
    integer SEED = 87;
    initial begin
        trans_cnt = $random(SEED)%20 + 32'd20;
        for(i = 0; i < trans_cnt; i = i + 1)begin
            if($random(SEED) % 2)begin
                m_read($random(SEED));
            end else begin
                m_write($random(SEED),$random(SEED));
            end
        end
        $finish;
    end

    task m_write(input [AW-1:0]addr, input [DW-1:0]value);
        begin
            address = addr;
            writedata = value;
            @(posedge clk);
                #5 write = 1;
            @(negedge waitrequest);
            @(posedge clk);
            #5 write = 0;
            @(posedge clk);
        end
    endtask

    task m_read(input [AW-1:0]addr);
        begin
            @(posedge clk);
            #5;
            address = addr;
            read = 1;
            @(negedge waitrequest);
            @(posedge clk);
            #5 read = 0;
            @(posedge clk);
        end
    endtask

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            waitrequest <= 1;
        end else begin
            if(read|write)begin
                #5 waitrequest <= 0;
            end else begin
                #5 waitrequest <=1;
            end
        end
    end
endmodule
