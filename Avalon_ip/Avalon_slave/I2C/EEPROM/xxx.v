module xxx (
    
);
    input load;
    input inc;
    input  [7:0] addr_i;
    input data;
    output data_word;
    output [7:0] x_dec;
    output [2:0] y_dec;
    assign x_dec = page;
    assign y_dec = cnt;
    reg y;
    reg wptr
    //x dec
    assign addr_o = {page, cnt};
    reg [4:0] page;
    reg [2:0] cnt;
    always @(posedge inc or posedge load) begin
        if(load)begin
            {page, cnt} <= addr_i; 
            y <= y + 1'b0;
        end else begin
            if(inc)begin
                cnt <= cnt + 1'b1;
                y <= y + 1'b0;
            end else begin
                y <= y + 1'b1;
            end
        end
    end
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
