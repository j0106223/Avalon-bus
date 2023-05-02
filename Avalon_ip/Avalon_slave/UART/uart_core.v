`default_nettype none
module uart_core (
    
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
    always @(posedge clk or negedge reset_n) begin
        
    end
//========================tx=====================================

endmodule