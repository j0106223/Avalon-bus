module ahb_master (
    hclk,
    hreset_n,
    haddr,
    htrans,
    hsize,
    hwrite,
    hwdata,
    hrdata
);
    parameter DW = 32;
    parameter AW = 32;
    input               hclk;
    input               hreset_n;
    output reg [AW-1:0] haddr;
    output reg    [1:0] htrans;
    output reg    [2:0] hsize;
    output reg          hwrite;
    output reg [DW-1:0] hwdata;
    input      [DW-1:0] hrdata;
    input               hready;

    initial begin
        
    end

    task ahb_write(
        input [AW-1:0]addr,
        input [DW-1:0]data
    );
        begin  
            @(posedge hclk)begin
                haddr = addr;
            end
            @(posedge hclk)begin
                hwdata = data;
            end
            @(posedge hclk)begin
                wait(hready);
            end
            @(posedge hclk);
            hwdata = {DW{1'bx}};
        end
    endtask

    task ahb_read(
        input addr
    );
        begin
        end
    endtask
endmodule