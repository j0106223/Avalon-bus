`timescale 1ns/1ps
module tri_tb;
parameter AW = 2;
parameter DW = 32;
    initial begin
        $dumpfile("tri_tb.vcd");
        $dumpvars(0,tri_tb);
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
    wire[DW-1:0]readdata;
    reg [DW-1:0]rdata;
    reg write;
    reg read;
    wire waitrequest;
    reg isTri;
    initial begin
        read = 0;
        write = 0;
    end
    integer trans_cnt;
    integer SEED = 55;
    integer i;
    initial begin
        for(i = 0; i < 1000; i = i + 1)begin
            test_tri($random(SEED)%32'd256,$random(SEED)%32'd256,$random(SEED)%32'd256);
        end
        $finish;
    end
    isTriangle DUT(
        .clk        (clk),
        .reset_n    (reset_n),
        .address    (address),
        .read       (read),
        .write      (write),
        .writedata  (writedata),
        .waitrequest(waitrequest),
        .readdata   (readdata)
    );
    
    task test_tri;
        input [31:0]A, B, C;
        reg [31:0]isTri;
        begin
            m_write(0, A);
            m_write(1, B);
            m_write(2, C);
            m_read(3, isTri);
            if(isTri == 1)begin
                $display("A:%d, B:%d, C:%d, is a triangle PASS!!",A,B,C);
            end else begin
                $display("A:%d, B:%d, C:%d, is not a triangle fail!!",A, B, C);
            end
        end
    endtask

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

    task m_read(input [AW-1:0]addr,output [DW-1:0]rdata);
        begin
            @(posedge clk);
            #5;
            address = addr;
            read = 1;
            @(negedge waitrequest);
            @(posedge clk);
            #5 rdata = readdata;
            #5 read = 0;
            @(posedge clk);
        end
    endtask
endmodule
