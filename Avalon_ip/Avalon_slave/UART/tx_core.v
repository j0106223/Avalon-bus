module tx_core (
    tx_clk,
    reset_n,
    tx_valid,
    tx_data,
    tx_ready,
    tx_done,
    tx
);
    input       tx_clk;
    input       reset_n;
    input       tx_valid;
    input [7:0] tx_data;
    output      tx_ready;
    output      tx_done;
    output      tx;

//============FSM===============
    //encoding type:gray code
    localparam IDLE     = 2'b00;
    localparam LOAD     = 2'b01;
    localparam TRANSMIT = 2'b11;
    localparam DONE     = 2'b10;
    reg [1:0]state;
    reg [1:0]next_state;
    always @(posedge tx_clk or negedge reset_n) begin
        if(!reset_n)begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            IDLE:begin
                if(tx_valid)begin
                    next_state = LOAD;
                end else begin
                    next_state = IDLE;
                end
            end
            LOAD:begin
                next_state = TRANSMIT;
            end
            TRANSMIT:begin
                if(cnt == 9)begin
                    next_state = DONE;
                end else begin
                    next_state = TRANSMIT;
                end
            end
            DONE:begin
                next_state = IDLE;
            end
            default:next_state = IDLE;
        endcase
    end
    wire   shift    = (state == TRANSMIT);
    wire   load     = (state == LOAD);
    assign tx_done  = (state == DONE);
    assign tx_ready = (state == IDLE);
    
//============FSM===============
    reg [9:0]shift_reg;
    reg [3:0]cnt;
    always @(posedge tx_clk or negedge reset_n) begin
        if(!reset_n)begin
            shift_reg <= 10'b1111111111;
            cnt <= 0;
        end else begin
            case({load, shift})
                2'b10:shift_reg = {1'b1, tx_data, 1'b0};//stop, data, start
                2'b01:begin
                    shift_reg = {1'b1, tx_data[9:1]};
                    cnt <= cnt + 1'b1;
                end 
                default:cnt <= 0;
            endcase
        end
    end

    assign tx = (shift)? shift_reg[0] : 1'b1;
endmodule