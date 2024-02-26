module regfile
(
    input           clk,
    input   [4:0]   ra1,        //read1 address
    input   [4:0]   ra2,        //read2 address
    output  [31:0]  rd1,        //read1 data
    output  [31:0]  rd2,        //read2 data
    input           write,
    input   [4:0]   wa,         //write address
    input   [31:0]  wd          //write data
);
    reg [31:0]regiser [1:31];//regiser[0] hot-wire to zero
    assign rd1 = (ra1 == 0) ? 32'h0000_0000 : regiser[ra1];//regiser[0] hard-wired to zero
    assign rd2 = (ra2 == 0) ? 32'h0000_0000 : regiser[ra2];//regiser[0] hard-wired to zero
    
    integer i;
    always @(posedge clk) begin
        if (write) begin
            regiser[wa] <= wd;
        end
    end
endmodule