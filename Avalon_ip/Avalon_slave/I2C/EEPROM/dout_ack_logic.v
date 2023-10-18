module dout_ack_logic (
    scl,
    sda_i,
    sda_o,
    en,
    rw,
    ack,
    data_i,
    data_o
);
    input ack;
    input [7:0]data_i;
    input en;
    input out_bit;
    output sda_o;
    input  sda_i;
    input  scl;
    
	input [7:0] data;
    always @(negedge scl) begin
        if(en)begin
			
		end else begin
			
		end
    end

    wire   data = (ack == 0) ? 1'b0 : data_i[out_bit];
    assign sda_o = (en && (data == 1'b0)) ? 1'b0: 1'bz;                 
endmodule
