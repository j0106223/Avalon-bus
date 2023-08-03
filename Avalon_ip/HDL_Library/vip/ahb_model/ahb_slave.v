module ahb_slave (
    hclk,
    hreset_n,
    hsel,
    haddr,
    htrans,
    hsize,
    hwrite,
    hwdata,
    hrdata,
    hready_i,
    hready_o
);
    parameter DW = 32;
    parameter AW = 32;
    parameter DP = 20;//internal register DEPTH
    localparam AHB_IDLE   = 2'b00;
    localparam AHB_BUSY   = 2'b01;
    localparam AHB_NONSEQ = 2'b10;
    localparam AHB_SEQ    = 2'b11;
    
    input           hclk;
    input           hreset_n;
    input           hsel;
    input  [AW-1:0] haddr;
    input     [1:0] htrans;
    input     [2:0] hsize;
    input           hwrite;
    input  [DW-1:0] hwdata;
    output reg [DW-1:0] hrdata;
    input               hready_i;
    output reg          hready_o;


    reg [DW-1:0] mem_reg [0:DP-1];
    reg [AW-1:0] haddr_d1;
    reg    [1:0] htrans_d1;
    reg    [2:0] hsize_d1;
    reg          hwrite_d1;
    reg          hsel_d1;
    wire write_en = hsel_d1 && (htrans_d1 == AHB_NONSEQ) && hwrite_d1 && hready_i;
    wire read_en  = hsel    && (htrans    == AHB_NONSEQ) && (!hwrite) && hready_i;
    assign hready_o = 1'b1;
    

    always @(posedge hclk or negedge hreset_n) begin
        if(!hreset_n)begin
            haddr_d1  <= 0;
            hsize_d1  <= 0;
            hwrite_d1 <= 0;
            hsel_d1   <= 0;
            htrans_d1 <= AHB_IDLE;
        end else begin
            haddr_d1  <= haddr;
            hsize_d1  <= hsize;
            hwrite_d1 <= hwrite;
            hsel_d1   <= hsel;
            htrans_d1 <= htrans;
        end
    end
    wire [AW-1:0] word_addr = haddr_d1 >> 2;
    //write slave
    always @(posedge hclk or negedge hreset_n) begin
        if(!hreset_n)begin
            for(int i = 0; i < DP; i++)begin
                mem_reg[i] <= 0;
            end
        end else begin
            if(write_en)begin
                mem_reg[haddr_d1 >> 2] <= hwdata;
            end
        end
    end

    //read slave
    reg [DW-1:0] rdata;
    assign hrdata = rdata;
    always @(posedge hclk or negedge hreset_n) begin
        if(!hreset_n)begin
            rdata <= 0;
        end else begin
            if(read_en)begin
                rdata <= mem_reg[haddr >> 2];
            end else if(hready_i)begin
                rdata <= {DW{1'bx}};
            end
        end
    end
endmodule 