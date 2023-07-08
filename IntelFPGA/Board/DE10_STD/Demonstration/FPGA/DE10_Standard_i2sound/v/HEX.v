module  HEX(
input	[3:0]	hex,
output	[6:0]	hex_fps
);


assign hex_fps	=	(hex == 4'd0) ? 7'h40: //0
					(hex == 4'd1) ? 7'h79: //1
					(hex == 4'd2) ? 7'h24: //2
					(hex == 4'd3) ? 7'h30: //3
					(hex == 4'd4) ? 7'h19: //4        
					(hex == 4'd5) ? 7'h12: //5
					(hex == 4'd6) ? 7'h02: //6
					(hex == 4'd7) ? 7'h78: //7
					(hex == 4'd8) ? 7'h00: //8
									7'h10; //9

endmodule 