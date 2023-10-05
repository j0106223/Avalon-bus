module addr_and_cnt (
    scl,
	sda,
	addr_load,
    inc,

);
    input addr_load;
    input inc;
    output data_word;
    output [4:0] row;
    output [2:0] col;
    reg wptr
	reg [7:0] data_word;
	reg [7:0] address;
	reg [2:0] cnt;


    reg  [7:0] shift_reg;
    always @(posedge scl) begin
    	shift_reg <= {shift_reg[7:1], sda};
    end

    always @(posedge scl) begin
		if (addr_load) begin
			cnt <= 3'b000;
		end else begin
			cnt <= cnt + 1'b1;
		end
    end

	always @(posedge scl) begin
		if (rw) begin
			data_word <= data
		end else begin
			address <= data;
		end
	end
endmodule
