module ahb_master (
    hclk,
    hreset_n,
    haddr,
    htrans,
    hsize,
    hwrite,
    hwdata,
    hrdata,
    hready
);
    parameter DW = 32;
    parameter AW = 32;

    localparam AHB_IDLE   = 2'b00;
    localparam AHB_BUSY   = 2'b01;
    localparam AHB_NONSEQ = 2'b10;
    localparam AHB_SEQ    = 2'b11;

    input               hclk;
    input               hreset_n;
    output reg [AW-1:0] haddr;
    output reg    [1:0] htrans;
    output reg    [2:0] hsize;
    output reg          hwrite;
    output reg [DW-1:0] hwdata;
    input      [DW-1:0] hrdata;
    input               hready;
    reg [DW-1:0]rdata;
    initial begin
        init();
    end
    task init;
        begin
            haddr = {AW{1'b0}};
            htrans = AHB_IDLE;
            hsize = 3'b0;
            hwrite = 1'b0;
            hwdata = {DW{1'b0}};
        end
    endtask
    task write(
        input [AW-1:0]addr,
        input [DW-1:0]data
    );
        begin
            $display("write %d into address%d", data, addr);
            @(posedge hclk)begin
                htrans = AHB_NONSEQ;
                haddr = addr;
                hwrite = 1'b1;
            end
            @(posedge hclk)begin
                htrans = AHB_IDLE;
                hwdata = data;
                haddr = {AW{1'bx}};
                hwrite = 1'b0;
            end     
            wait(hready)begin
                @(posedge hclk);
            end
            hwdata = {DW{1'bx}};
        end
    endtask

    task read(
        input [AW-1:0]addr
    );
        begin
            @(posedge hclk)begin
                htrans = AHB_NONSEQ;
                haddr = addr;
                hwrite = 1'b0;
            end
            @(posedge hclk)begin
                haddr = {AW{1'bx}};
                htrans = AHB_IDLE;
            end
            @(posedge hclk)begin
                while(!hready)begin
                    @(posedge hclk);
                end
            end
            rdata = hrdata;
            $display("read out %d from address %d", hrdata, addr);
        end
    endtask
endmodule