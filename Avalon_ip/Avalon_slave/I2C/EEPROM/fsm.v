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
    reg [3:0] state;
    reg [3:0] next_state;
	localparam START=;
    localparam STOP = 0;
    localparam ID6 = 1;
    localparam ID5 = 2;
    localparam ID4 = 3;
    localparam ID3 = 4;
    localparam ID2 = 5;
    localparam ID1 = 6;
    localparam ID0 = 7;
	localparam RW  = ;
    localparam ID_ACK = 1;
	localparam DATA7;
	localparam DATA6;
	localparam DATA5;
	localparam DATA4;
	localparam DATA3;
	localparam DATA2;
	localparam DATA1;
	localparam DATA0;
	localparam DATA_ACK;
    localparam RA7 = 1;
    localparam RA6 = 1;
    localparam RA5 = 1;
    localparam RA4 = 1;
    localparam RA3 = 1;
    localparam RA2 = 1;
    localparam RA1 = 1;
    localparam RA0 = 1;
    
        
    
    localparam RA_ACK = 1;

    always @(negedge scl or posedge start or posedge stop) begin
        if (start)
            state <= ID6; 
		else if (stop)
            state <= STOP;
    	end else
			state <= next_state;
    end

    always @* begin
        case (state)
            ID6   : next_state = ID5;
            ID5   : next_state = ID4;
            ID4   : next_state = ID3;
            ID3   : next_state = ID2;
            ID2   : next_state = ID1;
            ID1   : next_state = ID0;
			RW    : next_state = ID_ACK;
			ID_ACK: if (comp) next_state = DATA7;
			        else      next_state = STOP;
			DATA7 : next_state = DATA6;
			DATA6 : next_state = DATA5;
			DATA5 : next_state = DATA4;
			DATA4 : next_state = DATA3;
			DATA3 : next_state = DATA2;
			DATA2 : next_state = DATA1;
			DATA1 : next_state = DATA0;
			DATA0 : next_state = DATA_ACK;
			DATA_ACK: if(sda) next_state =  DATA7;
            STOP: if(start) next_state = ID6;
				  else      next_state = STOP;
            default: 
        endcase
    end

    always @(posedge scl) begin
        data_word <= {data_word, sda};
    end
endmodule
