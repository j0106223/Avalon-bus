module	DeBUG_TEST (	//	Host Side
							iCLK,
							iRST_N,
							isound_off1,
							isound_off2,
							oSin_CLK
						  );

input			iCLK;
input			iRST_N;
input			isound_off1;
input			isound_off2;

output		oSin_CLK;

reg [31:0]	Cont;
reg			sound_off1,sound_off2;

assign	oSin_CLK	=	Cont[4];
//=============================================================================
// Structural coding
//=============================================================================

always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		Cont <= 0;
		sound_off1	<= 0;
		sound_off2	<= 0;
	end
	else
	begin
		Cont <= Cont+1;
		sound_off1	<=	isound_off1;
		sound_off2	<=	isound_off2;
	end
end

endmodule
