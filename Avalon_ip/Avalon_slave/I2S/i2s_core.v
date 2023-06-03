module i2s_core (
    clk,
    reset_n,
    data_right,
    data_left,
    sck,
    sd,
    ws
);
    parameter      DW = 8;
    input          clk;
    input          reset_n;
    input [DW-1:0] data_right;//right channel
    input [DW-1:0] data_left;//left channel
    output         sck;
    output         sd;//one way transaction
    output         ws;//left right channel

    //======detect left right channel change========
    reg ws_d1;
    reg ws_d2;
    wire ws_p = ws_d1 ^ ws_d2;//this pulse means word select(lefg right channel) were changed
    always @(posedge sck or negedge reset_n) begin
        if(!reset_n)begin
            ws_d1 <= 1'b0;
            ws_d2 <= 1'b0;
        end else begin
            ws_d1 <= ws;
            ws_d2 <= ws_d1;
        end
    end

    //======detect left right channel change========

    //======shift register ========

    wire load_data = (ws_d1) ? data_right : data_left;
    reg [DW-1:0]data_sr;
    always @(posedge sck or negedge reset_n) begin
        if(!reset_n)begin
            data_sr <= 0;
        end else begin
            if(ws_p)begin//load data
                data_sr <= load_data; 
            end else begin
                data_sr <= {data_sr[DW-2:0], 1'b0};
            end
        end
    end
    //======shift register ========
endmodule