`default_nettype none
module synchronizer(
    clk,
    reset_n,
    in,
    out
);
parameter WIDTH = 1;
//instance example :
/*
synchronizer inst(.clk(clk), reset_n(reset_n), in(), out());
synchronizer #(.WIDTH()) inst(.clk(clk), reset_n(reset_n), in(), out());
*/    
    input  clk;
    input  reset_n;
    input  in;
    output out;
    reg [WIDTH-1:0]q[0:1];
    assign out = q[1];
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            q[0] <= 0;
            q[1] <= 0;
        end else begin
            q[0] <= in;
            q[1] <= q[0];
        end
    end
endmodule