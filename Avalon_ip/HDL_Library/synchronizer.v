`default_nettype none
module synchronizer(
    clk,
    reset_n,
    in,
    out
);
//instance example :
/*
synchronizer (.clk(clk), reset_n(reset_n), in(), out());
*/    
    input  clk;
    input  reset_n;
    input  in;
    output out;
    reg [1:0]q;
    assign out = q[1];
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            q <= 2'b00;
        end else begin
            q[0] <= in;
            q[1] <= q[0];
        end
    end
endmodule