module addr_and_cnt (
    load,
    inc,
);
    input load;
    input inc;
    input  [7:0] addr_i;
    input data;
    output data_word;
    output [4:0] row;
    output [2:0] col;
    reg wptr
	reg [7:0] data_word;
	reg [7:0] address;
	reg [2:0] cnt;	
    always @(posedge inc posedge load) begin
		if (load) begin
			cnt <= 3'b000;
		end else begin
			cnt <= cnt + 1'b1;
		end
    end

	always @(posedge load) begin
		if (rw) begin
			data_word <= data
		end else begin
			address <= data;
		end
	end
endmodule
