`timescale 1ns/1ps
module tb;
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end
    parameter AW = 32;
    parameter DW = 32;
    parameter SLAVE_0_BASE = 0;
    parameter SLAVE_0_SIZE = 80;
    bit clk;
    bit reset_n;

    wire [AW-1:0] haddr;
    wire    [1:0] htrans;
    wire    [2:0] hsize;
    wire          hwrite;
    wire [DW-1:0] hwdata;
    wire [DW-1:0] hrdata;
    reg           hready;


    always #1 clk = ~clk;
    
    initial begin
        reset_n = 1'b1;
        #1;
        reset_n = 1'b0;
        #1;
        reset_n = 1'b1;
    end
    int temp;
    initial begin
        @(posedge reset_n);
        repeat(1000)begin
            for(int i = 0; i < 20; i++)begin
                temp = $random();
                ahb_master.write(i*4, temp);
                ahb_master.read(i*4);
                if(ahb_master.rdata != temp)begin
                    $display("fail");
                    $finish;
                end
            end
        end
        $display("pass");
        $finish;
    end

    ahb_master #(
        .AW (AW),
        .DW (DW)
    )ahb_master(
        .hclk       (clk),
        .hreset_n   (reset_n),
        .haddr      (haddr),
        .htrans     (htrans),
        .hsize      (hsize),
        .hwrite     (hwrite),
        .hwdata     (hwdata),
        .hrdata     (hrdata),
        .hready     (hready_o)
    );
    ahb_slave ahb_slave(
        .hclk       (clk),
        .hreset_n   (reset_n),
        .hsel       (hsel),
        .haddr      (haddr),
        .htrans     (htrans),
        .hsize      (hsize),
        .hwrite     (hwrite),
        .hwdata     (hwdata),
        .hrdata     (hrdata),
        .hready_i   (hready_o),
        .hready_o   (hready_o)
    );

    ahb_decoder #(
        .SLAVE_0_BASE(SLAVE_0_BASE),
        .SLAVE_0_SIZE(SLAVE_0_SIZE)
    )ahb_decoder(
        .haddr  (haddr),
        .hsel   (hsel)
    );
endmodule 