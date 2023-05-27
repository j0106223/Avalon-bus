module dcfifo(
    
);
    parameter WIDTH = 32;
    parameter DEPTH = 32;
    input wclk;
    input rclk;
    input reset_n;
    input write;
    input read;
    output wvalid;
    output rvalid;
    input  wdata;
    output rdata;
    output full;
    output empty;
    output 
    reg [WIDTH-1:0] data [0:DEPTH-1];
    reg widx;
    reg ridx;
    integer i;
    always @(posedge wclk or negedge reset_n) begin
        if(!reset_n)begin//just init idx pointer 
            
        end else begin
            if(write && !full)begin

            end
        end
    end
    always @(posedge wclk or negedge reset_n) begin
        if(!reset_n)begin//just init idx pointer 
            
        end else begin
            if(read && !empty)begin

            end
        end
    end
    synchronizer wsync(.clk(wclk), reset_n(reset_n), in(), out());
    synchronizer rsync(.clk(rclk), reset_n(reset_n), in(), out());
endmodule