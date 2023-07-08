module TERASIC_ADC_READ(
	clk,
	reset_n,
	// avalon slave
	s_chipselect,
	s_read,
	s_readdata,
	s_write,
	s_writedata,
	
	// export interface
	SPI_CLK,
	SPI_CS_n,
	SPI_IN,
	SPI_OUT
);

input							clk;
input							reset_n;

input							s_chipselect;
input							s_read;
output	reg	[15:0]	s_readdata;
input							s_write;
input				[15:0]	s_writedata;

output						SPI_CLK;
output						SPI_CS_n;
input							SPI_IN;
output						SPI_OUT;

////////////////////////////////////////////

reg 			Start;
wire 			Done;
wire [11:0]	Data;
reg  [2:0]	Channel;



////////////////////////////////////////////
// avalon read
always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n)
		s_readdata <= 0;
	else if (s_chipselect & s_read)
		s_readdata <= {Done,3'b000,Data}; // 1 + 3 + 12 = 16
end

always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n)
		Start <= 1'b0;
	else if (s_chipselect & s_write)
	begin
		Start <= s_writedata[15];
		if (s_writedata[15])
			Channel <= s_writedata[2:0];
	end
end



////////////////////////////////////////////


ADC_READ ADC_READ_Inst(
				.clk(clk),		
				.reset_n(reset_n),			
				
				.Channel(Channel),			
				.Data(Data),			
				.Start(Start),		
				.Done(Done),			
				
				.oDIN(SPI_OUT),	
				.oCS_n(SPI_CS_n),	
				.oSCLK(SPI_CLK),			
				.iDOUT(SPI_IN)			
			);

endmodule
