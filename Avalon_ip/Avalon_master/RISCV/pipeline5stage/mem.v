module mem (
    clk,
    reset_n,
    addr,
    read,
    write,
    wdata,
    rdata    
);
    input         clk,
    input         reset_n,
    input  [31:0] addr;
    input         read;
    input         write;
    input  [31:0] wdata;
    output [31:0] rdata;
    reg     [7:0] data [0:1024];
    reg    [31:0] data_q;
    always @(posedge clk or negedge reset_n) begin
        if(write)begin
            data[addr] <= wdata;
        end
    end
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            data_q <= 0;
        end else begin
            if(read)begin
                data_q <= data[addr];
            end
        end
    end
    assign rdata = data_q; 
endmodule