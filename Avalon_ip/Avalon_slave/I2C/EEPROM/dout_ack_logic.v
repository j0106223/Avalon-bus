module dout_ack_logic (
    scl,
    sda,
    en,
    rw,
    ack,
    data_i,
    data_o
);
    input ack;
    output data_o;
    assign data_o = en ? 1'b1 : data_i;
    input scl;
    input en;
    always @(negedge scl) begin
        if(en)begin

        end
    end
    assign 
endmodule