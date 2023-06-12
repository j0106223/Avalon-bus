module rx_core (
    rx_clk,
    reset_n,
    rx_data,
    rx_done,
    rx
);
    input        rx_clk;
    input        reset_n;
    output [7:0] rx_data;
    output       rx_done;
    input        rx; 
    //====2-stage D-FF sync============
    wire rx_sync;
    reg [1:0]rx_q;
    assign rx_sync = rx_q[1];
    always @(posedge rx_clk or negedge reset_n) begin
        if(!reset_n)begin
            rx_q <= 0;
        end else begin
            rx_q[0] <= rx;
            rx_q[1] <= rx_q[0];
        end
    end
    //====2-stage D-FF sync============

    //===================FSM===================
    localparam IDLE     = 2'b00;
    localparam RECEIVE  = 2'b01;
    localparam DONE     = 2'b11;
    
    reg [1:0]state;
    reg [1:0]next_state;
    always @(posedge rx_clk or negedge reset_n) begin
        if(!reset_n)begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            IDLE:begin
                if(!rx_sync)begin//start bit
                    next_state = RECEIVE;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE:begin
                if(cnt == 8)begin
                    next_state = DONE;
                end else begin
                    next_state = RECEIVE;
                end
            end
            DONE: next_state = IDLE;//we dont care stop bit here,no check
            default: next_state = IDLE;
        endcase
    end
    wire shift;
    wire rx_done;
    assign shift   = (state == RECEIVE);
    assign rx_done = (state == DONE);
    //===================FSM===================
    
    //===============rx shift register=================
    
    reg [3:0]cnt;
    reg [7:0]shift_reg;
    assign rx_data = shift_reg; 
    always @(posedge rx_clk or negedge reset_n) begin
        if(!reset_n)begin
            shift_reg <= 0;
            cnt <= 0;
        end else begin
            if(shift)begin
                shift_reg <= {rx_sync,shift_reg[7:1]};
                cnt <= cnt + 1'b1;
            end else begin
                cnt <= 0;
            end
        end
    end
    //===============rx shift register=================
    
endmodule