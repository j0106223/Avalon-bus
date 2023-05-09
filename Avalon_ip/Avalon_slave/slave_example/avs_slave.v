//this is a general avalon slave example
`default_nettype none
module avs_slave (
    clk,
    reset_n,
    avs_s0_address,
    avs_s0_read,
    avs_s0_readdata,
    avs_s0_waitrequest,
    avs_s0_write,
    avs_s0_writedata
);
//===========avalon MM interface==================================
    input   clk;
    input   reset_n;
    //assume you have max 16 internal register
    input  [3:0]    avs_s0_address;
    input           avs_s0_read;
    output [31:0]   avs_s0_readdata;
    output          avs_s0_waitrequest;
    input           avs_s0_write;
    input  [31:0]   avs_s0_writedata;
    //write internal register
    integer i;
    reg [31:0]avs_reg[0:15];//avalon slave register
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            for(i = 0;i < 16; i = i + 1)begin
                avs_reg <= 0;
            end
        end else begin
            if(avs_s0_write)begin//can also be written by slave, in order to update status register or data register
                avs_reg[avs_s0_address] <= avs_s0_writedata;
            end
        end
    end
    //read internal register
    reg [31:0]readdata;
    assign avs_s0_readdata = readdata;
    always @(*) begin
        if(avs_s0_read && !avs_s0_waitrequest)begin
            readdata = avs_reg[avs_s0_address];
        end else begin
            readdata = 0;
        end
    end
    //waitrequest logic,
    assign waitrequest = !(avs_s0_read | avs_s0_write);
//===========avalon MM interface==================================



    //slave core
endmodule