module fsm (
    scl,
    sda,
    comp,
    load_addr_compare,
);
    input scl;
    input sda;
    input start;
    input stop;
    output [7:0]data_word;
    output data_load;
    reg [3:0]state;
    reg [3:0]next_state;
    localparam STOP = 0;
    localparam ID6 = 1;
    localparam ID5 = 2;
    localparam ID4 = 3;
    localparam ID3 = 4;
    localparam ID2 = 5;
    localparam ID1 = 6;
    localparam ID0 = 7;
    localparam ID_ACK = 1;
    localparam RA7 = 1;
    localparam RA6 = 1;
    localparam RA5 = 1;
    localparam RA4 = 1;
    localparam RA3 = 1;
    localparam RA2 = 1;
    localparam RA1 = 1;
    localparam RA0 = 1;
    
    
    
    
    
    
    localparam RA_ACK = 1;

    always @(negedge scl or posedge stop) begin
        if(start)begin
            state <= stop;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            : next_state;
            default: 
        endcase
    end

    always @(posedge scl) begin
        data_word <= {data_word, sda};
    end
endmodule