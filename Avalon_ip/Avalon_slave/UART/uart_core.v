`default_nettype none
//no parity check
//2-stage input sync
module uart_core (
    clk,
    reset_n,
    rx_ready,
    rx_data,
    tx_valid,
    tx_ready,
    tx_data,
    clk_div,
    rx,
    tx
);
    input clk;
    input reset_n;
    //rx logic
    output rx_ready;
    output [7:0]rx_data;
    //tx logic
    input  tx_valid;
    output tx_ready;
    input [7:0]tx_data;

    input clk_div; 
    //IO
    input  rx;
    output tx;
//========================rx=====================================
    //2-stage sync input rx
    reg [1:0]sync_rx_q;
    wire       sync_rx;
    assign sync_rx = sync_rx_q[1];

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            sync_rx_q <= 0;
        end else begin
            sync_rx_q[0] <= rx;
            sync_rx_q[1] <= sync_rx_q[0];
        end
    end
//========================rx=====================================
    
    reg []rx_shift_reg;
    always @(posedge uart_clk or negedge reset_n) begin
        if(!reset_n)begin
             <= 0;
        end else begin
            rx_shift_reg <= {rx_shift_regt[6:0], sync_rx};
        end
    end
//========================tx=====================================

    wire uart_clk;
    clk_gen uart_clock_gen(
        .clk_i      (clk),//system, SoC clock or crystal oscillator
        .reset_n    (reset_n),
        .clk_div    (clk_div),
        .clk_o      (uart_clk)
    );
    localparam TX_IDLE;
    localparam TX_LOAD;
    localparam TX_TRANSMIT;
    always @(posedge uart_clk or negedge reset_n) begin
        if(!reset_n)begin
            tx_q <= 0;
        end else begin
            
        end
    end

    
    //shift register
    reg [9:0]tx_shift_reg;
    localparam START_BIT = 1'b0;
    localparam STOP_BIT  = 1'b1;
    assign tx = tx_shift_reg[0];
    always @(posedge uart_clk or negedge reset_n) begin
        if(!reset_n)begin
            tx_shift_reg <= 0;
        end else begin
            case ({load, tx_shift})
                2'b01:tx_shift_reg <= {1'b1, tx_shift_reg[9:1]};
                2'b10:tx_shift_reg <= {STOP_BIT, tx_data, START_BIT};
            endcase
        end
    end
//========================tx=====================================

endmodule