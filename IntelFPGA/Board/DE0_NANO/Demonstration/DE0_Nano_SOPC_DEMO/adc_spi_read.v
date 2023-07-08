// adc_spi_read.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.

module adc_spi_read (
		input  wire        clk,          //       clock.clk
		input  wire        reset_n,      //       reset.reset_n
		input  wire        s_chipselect, //       slave.chipselect
		input  wire        s_read,       //            .read
		output wire [15:0] s_readdata,   //            .readdata
		input  wire        s_write,      //            .write
		input  wire [15:0] s_writedata,  //            .writedata
		output wire        SPI_OUT,      // conduit_end.export
		input  wire        SPI_IN,       //            .export
		output wire        SPI_CS_n,     //            .export
		output wire        SPI_CLK       //            .export
	);

	TERASIC_ADC_READ adc_spi_read (
		.clk          (clk),          //       clock.clk
		.reset_n      (reset_n),      //       reset.reset_n
		.s_chipselect (s_chipselect), //       slave.chipselect
		.s_read       (s_read),       //            .read
		.s_readdata   (s_readdata),   //            .readdata
		.s_write      (s_write),      //            .write
		.s_writedata  (s_writedata),  //            .writedata
		.SPI_OUT      (SPI_OUT),      // conduit_end.export
		.SPI_IN       (SPI_IN),       //            .export
		.SPI_CS_n     (SPI_CS_n),     //            .export
		.SPI_CLK      (SPI_CLK)       //            .export
	);

endmodule
