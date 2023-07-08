module Debounce_ALL
(
    input    	   clk,
    input 	[9:0] iSW,
    input 	[3:0] iKEY,
    output 	[9:0]	oSW,
    output 	[3:0]	oKEY
);

	generate
		genvar i;
		for(i = 0;i < 10 ;i = i + 1)begin:SW_Debounce
			Debounce inst(.clk(clk), .in(iSW[i]), .out(oSW[i]));
		end
		
		for(i = 0;i < 4 ;i = i + 1)begin:KEY_Debounce
			Debounce inst(.clk(clk), .in(iKEY[i]), .out(oKEY[i]));
		end
	endgenerate
endmodule 