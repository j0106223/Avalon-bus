module dcfifo(
    
);
    parameter WIDTH = 32;
    parameter DEPTH = 32;
    input wclk;
    input rclk;
    input reset_n;
    input write;
    input read;
    input          [WIDTH-1:0]wdata;
    output         [WIDTH-1:0]rdata;
    output full;
    output empty;
    output [$clog2(WIDTH)-1:0] used;
    wire   [$clog2(WIDTH)-1:0] wptr_sync;
    wire   [$clog2(WIDTH)-1:0] rptr_sync;
    reg    [$clog2(WIDTH)-1:0] wptr;
    reg    [$clog2(WIDTH)-1:0] rptr;
    reg            [WIDTH-1:0] data [0:DEPTH-1];
    assign used = (wptr < rptr_sync) ?
                  (wptr + DEPTH - rptr_sync):
                  (wptr - rptr_sync);
    assign full = (wptr < rptr_sync) ?
                  ((wptr + DEPTH - rptr_sync) == (DEPTH - 1)):
                  ((wptr - rptr_sync) == (DEPTH - 1));
    assign empty = (rptr == wptr_sync);
    
    always @(posedge wclk or negedge reset_n) begin
        if(write && !full)begin
            data[wptr] <= wdata;
        end
    end
    always @(posedge wclk or negedge reset_n) begin
        if(!reset_n)begin//just init idx pointer 
            wptr <= 0;
        end else begin
            if(write && (!full))begin
                wptr <= wptr + 1'b1;
            end
        end
    end
    always @(posedge wclk or negedge reset_n) begin
        if(!reset_n)begin//just init idx pointer 
            rptr <= 0;
        end else begin
            if(read && (!empty))begin
                rptr <= rptr + 1'b1;
            end            
        end
    end

    synchronizer wsync(.clk(wclk), reset_n(reset_n), in(wptr), out(wptr_sync));
    synchronizer rsync(.clk(rclk), reset_n(reset_n), in(rptr), out(rptr_sync));
endmodule