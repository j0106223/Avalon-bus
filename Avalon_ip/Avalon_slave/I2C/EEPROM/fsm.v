module fsm (
    
);
    input scl;
    input sda;
    input start;
    input stop;
    reg [3:0]state;
    reg [3:0]state_next;
    localparam IDLE = 1;
    //localparam IDLE = 1;
    //localparam IDLE = 1;
    //localparam IDLE = 1;
    always @(negedge scl) begin
        
    end
endmodule