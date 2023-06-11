`default_nettype none
//only support single master multi slave arch
//so scl no need to use open-drain io, but sda does
module i2c_core (
    clk,
    reset_n,
    rdata_i,
    wdata_o,
    sda_i,
    sda_o,
    scl_o,
    done
);
    input clk;
    input reset_n;
    input  [7:0] wdata;
    output [7:0] rdata;
    output rdata_valid;
    output wdata_valid;
    input [31:0]clk_div;
    input sda_i;
    output sda_o;
    output scl_o;
    output ready;
    output done;

    reg sda;
    reg scl;
    //start
    //rdata
    //wdata
    //stop
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

    always @(*) begin
        case(state)
            IDLE :begin
                next_state = ;
            end
            START:begin
                next_state = ;
            end
            RDATA:begin
                next_state = ;
            end
            WDATA:begin
                next_state = ;
            end
            STOP:begin
                next_state = ;
            end
            DONE:begin
                next_state = IDLE;
            end
            default;
        endcase
    end

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

    //rdata shift register
    always @(posedge scl_o) begin
        
    end

    //table

    always @(*) begin
        case(cnt)
            0:sda_o = 0;scl_o = 1;
            1:sda_o = 0;scl_o = 0;
        endcase
    end
endmodule