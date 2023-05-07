`default_nettype none
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
    //sync input rx
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

//========================tx=====================================
    assign tx = ;
    reg tx_q;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            tx_q <= 0;
        end else begin
            
        end
    end
//========================tx=====================================

endmodule