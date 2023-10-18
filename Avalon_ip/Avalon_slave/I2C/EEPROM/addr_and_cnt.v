module addr_and_cnt (//address and counter about the data word whitch should be read out or write in
    scl,
	sda,
	addr_load,
    inc,
	addr
);
	input        scl;
	input        sda;
    input        addr_load;
    input        inc;
    output [7:0] addr;
	
    reg  [7:0] shift_reg;
    always @(posedge scl) begin
    	shift_reg <= {shift_reg[7:1], sda};
    end

	reg [4:0] address;
	reg [2:0] cnt;
    always @(posedge scl) begin
		if (addr_load) begin
			address <= shift_reg[7:3];
			cnt     <= shift_reg[2:0];
		end else begin
			if(inc)begin
				cnt <= cnt + 1'b1;
			end
		end
    end
	assign addr = {address, cnt};
endmodule
