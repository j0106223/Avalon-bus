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
    input           hclk;
    input           hreset_n;
    output [AW-1:0] haddr;
    output    [1:0] htrans;
    output    [2:0] hsize;
    output          hwrite;
    output [DW-1:0] hwdata;
    input  [DW-1:0] hrdata;
    input           hready;

    initial begin
        
    end
    
    task ahb_write(
        input addr,
        input data
    );
        begin
        end
    endtask

    task ahb_read(
        input addr
    );
        begin
        end
    endtask
endmodule