module addr_comparator (
    scl,
    sda,
    load,
    comp,
    a2,
    a1,
    a0,
    rw
);
    
    input scl;
    input sda;
    input load;
    input a2;
    input a1;
    input a0;
    output comp;
    output rw;


	reg compare;
	reg read_write;
    reg  [7:0] shift_reg;

    wire [6:0] devicd_id;
	assign rw = read_write;
	assign comp = compare;
    assign devicd_id = {4'b1000, {a2, a1, a0}};


    always @(posedge scl) begin
    	shift_reg <= {shift_reg[7:1], sda};
    end

	always @(posedge scl) begin
		if (load) begin
			compare = (shift_reg[7:1] == device_id);
			read_write = shift_reg[0];
		end
	end
endmodule
