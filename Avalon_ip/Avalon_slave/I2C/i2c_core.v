`default_nettype none
//only support single master multi slave arch
//so sda need to use open-drain io, but scl don't
module i2c_core (
    clk,
    reset_n,
    rdata_i,
    wdata_o,
    sda_i,
    sda_o,
    scl_i,
    scl_o,
    ack,
    done,
);
    input clk;
    input reset_n;
    input  [7:0] wdata;
    output [7:0] rdata;
    output rdata_valid;
    output wdata_valid;
    input [31:0]clk_div;
    
    output ready;
    input start;
    input stop;
    input read;
    input write;
    input data;
    input nack;
    output ack,
    output done;
    //export
    input sda_i;
    output sda_o;
    output scl_i;
    output scl_o;
    assign done = start_done|
                  read_done |
                  write_done|
                  stop_done;
    reg sda;
    reg scl;
    clk_gen i2c_clock_gen(
        .clk_i      (clk),
        .reset_n    (reset_n),
        .clk_div    (clk_div),
        .clk_o      (i2c_clk)
    );
//========================FSM===============================================
    localparam IDLE  = 0;
    localparam START = 0;
    localparam RDATA = 0;
    localparam WDATA = 0;
    localparam STOP  = 0;
    localparam DONE = 0;
    reg [3:0]state;
    reg [3:0]next_state;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case(state)
            IDLE :begin
                if(start)begin
                    next_state = START;
                end else if(stop)begin
                    next_state = STOP;
                end else if(write)begin
                    next_state = WDATA;
                end else if(read)begin
                    next_state = RDATA;
                end else begin
                   next_state = IDLE;
                end
            end
            START:begin
                if(start_done)begin
                    next_state = IDLE;
                end                
            end
            RDATA:begin
                if(read_done)begin
                    next_state = IDLE;
                end
            end
            WDATA:begin
                if(write_done)begin
                    next_state = IDLE;
                end
            end
            STOP:begin
                if(stop_done)begin
                    next_state = IDLE;
                end
                
            end
            DONE:begin
                next_state = IDLE;
            end
            default:next_state = IDLE;
        endcase
    end
    wire rx_en = (state == RDATA);
    wire tx_en = (state == WDATA);
    //output logic
    assign ready = (state == IDLE);
//========================FSM===============================================
    wire en;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            sda <= 1'b1;
        end else begin
            if(en)begin

            end
        end
    end

    reg [1:0] sda_sync;
    reg [1:0] scl_sync;

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            sda_sync <= 2'b00;
            scl_sync <= 2'b00;
        end else begin
            sda_sync[0] <= sda_i;
            sda_sync[1] <= sda_sync[0];
            scl_sync[0] <= scl_i;
            scl_sync[1] <= scl_sync[0]
        end
    end
    //read shift register
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            sda_sync <= 2'b00;
            scl_sync <= 2'b00;
        end else begin
            sda_sync[0] <= sda_i;
            sda_sync[1] <= sda_sync[0];
            scl_sync[0] <= scl_i;
            scl_sync[1] <= scl_sync[0]
        end
    end

    reg [31:0] cnt;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
        end
    end
    //table

    always @* begin
        case(cnt)
            //start
            0:sda_o = 0;scl_o = 1;
            1:sda_o = 0;scl_o = 0;
            //tx data
            //rx data
            
            //stop
            0:sda_o = 0;scl_o = 1;
            1:sda_o = 0;scl_o = 0;
        endcase
    end

    //rx data
    reg [7:0]rx_data;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            rx_data <= 8'b0000_0000;
        end else begin
            if(rx_en)begin
                if()begin//scl rising
                    rx_data<={rx_data[7:1],scl};
                end
            end
        end
    end
endmodule