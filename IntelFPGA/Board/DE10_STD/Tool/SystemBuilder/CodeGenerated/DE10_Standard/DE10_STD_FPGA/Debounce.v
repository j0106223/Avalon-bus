module Debounce
(
	input 		clk,//50mhz
	input 		in,
	output reg 	out
);
//假設一秒十次的手速
reg [1:0]input_buffer;
reg [20:0]counter;
	always@(posedge clk)begin//Synchronous input signal
		input_buffer[0] <= in;
		input_buffer[1] <= input_buffer[0];
	end
	
	always@(posedge clk)begin
		if(counter >= (1250000 - 1))begin//從0開始數所以要-1
			counter	<=	0;
			out		<=	input_buffer[1];
		end else begin
			out		<=	out;//維持不變，其實可以不用寫這一行
			counter	<=	counter + 1'b1;
		end
	end
	
endmodule