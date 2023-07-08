
module soc_system (
	alt_vip_itc_0_clocked_video_vid_clk,
	alt_vip_itc_0_clocked_video_vid_data,
	alt_vip_itc_0_clocked_video_underflow,
	alt_vip_itc_0_clocked_video_vid_datavalid,
	alt_vip_itc_0_clocked_video_vid_v_sync,
	alt_vip_itc_0_clocked_video_vid_h_sync,
	alt_vip_itc_0_clocked_video_vid_f,
	alt_vip_itc_0_clocked_video_vid_h,
	alt_vip_itc_0_clocked_video_vid_v,
	clk_clk,
	hps_0_f2h_cold_reset_req_reset_n,
	hps_0_f2h_debug_reset_req_reset_n,
	hps_0_f2h_dma_req0_dma_req,
	hps_0_f2h_dma_req0_dma_single,
	hps_0_f2h_dma_req0_dma_ack,
	hps_0_f2h_dma_req1_dma_req,
	hps_0_f2h_dma_req1_dma_single,
	hps_0_f2h_dma_req1_dma_ack,
	hps_0_f2h_stm_hw_events_stm_hwevents,
	hps_0_f2h_warm_reset_req_reset_n,
	hps_0_h2f_reset_reset_n,
	hps_0_hps_io_hps_io_emac1_inst_TX_CLK,
	hps_0_hps_io_hps_io_emac1_inst_TXD0,
	hps_0_hps_io_hps_io_emac1_inst_TXD1,
	hps_0_hps_io_hps_io_emac1_inst_TXD2,
	hps_0_hps_io_hps_io_emac1_inst_TXD3,
	hps_0_hps_io_hps_io_emac1_inst_RXD0,
	hps_0_hps_io_hps_io_emac1_inst_MDIO,
	hps_0_hps_io_hps_io_emac1_inst_MDC,
	hps_0_hps_io_hps_io_emac1_inst_RX_CTL,
	hps_0_hps_io_hps_io_emac1_inst_TX_CTL,
	hps_0_hps_io_hps_io_emac1_inst_RX_CLK,
	hps_0_hps_io_hps_io_emac1_inst_RXD1,
	hps_0_hps_io_hps_io_emac1_inst_RXD2,
	hps_0_hps_io_hps_io_emac1_inst_RXD3,
	hps_0_hps_io_hps_io_qspi_inst_IO0,
	hps_0_hps_io_hps_io_qspi_inst_IO1,
	hps_0_hps_io_hps_io_qspi_inst_IO2,
	hps_0_hps_io_hps_io_qspi_inst_IO3,
	hps_0_hps_io_hps_io_qspi_inst_SS0,
	hps_0_hps_io_hps_io_qspi_inst_CLK,
	hps_0_hps_io_hps_io_sdio_inst_CMD,
	hps_0_hps_io_hps_io_sdio_inst_D0,
	hps_0_hps_io_hps_io_sdio_inst_D1,
	hps_0_hps_io_hps_io_sdio_inst_CLK,
	hps_0_hps_io_hps_io_sdio_inst_D2,
	hps_0_hps_io_hps_io_sdio_inst_D3,
	hps_0_hps_io_hps_io_usb1_inst_D0,
	hps_0_hps_io_hps_io_usb1_inst_D1,
	hps_0_hps_io_hps_io_usb1_inst_D2,
	hps_0_hps_io_hps_io_usb1_inst_D3,
	hps_0_hps_io_hps_io_usb1_inst_D4,
	hps_0_hps_io_hps_io_usb1_inst_D5,
	hps_0_hps_io_hps_io_usb1_inst_D6,
	hps_0_hps_io_hps_io_usb1_inst_D7,
	hps_0_hps_io_hps_io_usb1_inst_CLK,
	hps_0_hps_io_hps_io_usb1_inst_STP,
	hps_0_hps_io_hps_io_usb1_inst_DIR,
	hps_0_hps_io_hps_io_usb1_inst_NXT,
	hps_0_hps_io_hps_io_spim0_inst_CLK,
	hps_0_hps_io_hps_io_spim0_inst_MOSI,
	hps_0_hps_io_hps_io_spim0_inst_MISO,
	hps_0_hps_io_hps_io_spim0_inst_SS0,
	hps_0_hps_io_hps_io_spim1_inst_CLK,
	hps_0_hps_io_hps_io_spim1_inst_MOSI,
	hps_0_hps_io_hps_io_spim1_inst_MISO,
	hps_0_hps_io_hps_io_spim1_inst_SS0,
	hps_0_hps_io_hps_io_uart0_inst_RX,
	hps_0_hps_io_hps_io_uart0_inst_TX,
	hps_0_hps_io_hps_io_i2c0_inst_SDA,
	hps_0_hps_io_hps_io_i2c0_inst_SCL,
	hps_0_hps_io_hps_io_i2c1_inst_SDA,
	hps_0_hps_io_hps_io_i2c1_inst_SCL,
	hps_0_hps_io_hps_io_gpio_inst_GPIO09,
	hps_0_hps_io_hps_io_gpio_inst_GPIO35,
	hps_0_hps_io_hps_io_gpio_inst_GPIO37,
	hps_0_hps_io_hps_io_gpio_inst_GPIO40,
	hps_0_hps_io_hps_io_gpio_inst_GPIO41,
	hps_0_hps_io_hps_io_gpio_inst_GPIO44,
	hps_0_hps_io_hps_io_gpio_inst_GPIO48,
	hps_0_hps_io_hps_io_gpio_inst_GPIO53,
	hps_0_hps_io_hps_io_gpio_inst_GPIO54,
	hps_0_hps_io_hps_io_gpio_inst_GPIO61,
	ir_rx_conduit_end_export,
	key_external_connection_export,
	ledr_external_connection_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	reset_reset_n,
	seg7_conduit_end_writedata,
	spi_external_MISO,
	spi_external_MOSI,
	spi_external_SCLK,
	spi_external_SS_n,
	sw_external_connection_export,
	terasic_alsa_chip_conduit_end_xck,
	terasic_alsa_chip_conduit_end_adclrck,
	terasic_alsa_chip_conduit_end_adcdat,
	terasic_alsa_chip_conduit_end_bclk,
	terasic_alsa_chip_conduit_end_dacdat,
	terasic_alsa_chip_conduit_end_daclrck,
	terasic_alsa_clock_sink_44_clk,
	terasic_alsa_clock_sink_48_clk,
	terasic_alsa_dma_conduit_end_capture_dma_ack,
	terasic_alsa_dma_conduit_end_capture_dma_req,
	terasic_alsa_dma_conduit_end_playback_dma_ack,
	terasic_alsa_dma_conduit_end_playback_dma_req,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_clk,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_data,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_de,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_datavalid,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_locked,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_f,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_v_sync,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_h_sync,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_color_encoding,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_bit_width,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof_locked,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_refclk_div,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_clipping,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_padding,
	tv_decoder_alt_vip_cl_cvi_0_clocked_video_overflow,
	tv_decoder_sdram_wire_addr,
	tv_decoder_sdram_wire_ba,
	tv_decoder_sdram_wire_cas_n,
	tv_decoder_sdram_wire_cke,
	tv_decoder_sdram_wire_cs_n,
	tv_decoder_sdram_wire_dq,
	tv_decoder_sdram_wire_dqm,
	tv_decoder_sdram_wire_ras_n,
	tv_decoder_sdram_wire_we_n,
	vga_stream_clk);	

	input		alt_vip_itc_0_clocked_video_vid_clk;
	output	[23:0]	alt_vip_itc_0_clocked_video_vid_data;
	output		alt_vip_itc_0_clocked_video_underflow;
	output		alt_vip_itc_0_clocked_video_vid_datavalid;
	output		alt_vip_itc_0_clocked_video_vid_v_sync;
	output		alt_vip_itc_0_clocked_video_vid_h_sync;
	output		alt_vip_itc_0_clocked_video_vid_f;
	output		alt_vip_itc_0_clocked_video_vid_h;
	output		alt_vip_itc_0_clocked_video_vid_v;
	input		clk_clk;
	input		hps_0_f2h_cold_reset_req_reset_n;
	input		hps_0_f2h_debug_reset_req_reset_n;
	input		hps_0_f2h_dma_req0_dma_req;
	input		hps_0_f2h_dma_req0_dma_single;
	output		hps_0_f2h_dma_req0_dma_ack;
	input		hps_0_f2h_dma_req1_dma_req;
	input		hps_0_f2h_dma_req1_dma_single;
	output		hps_0_f2h_dma_req1_dma_ack;
	input	[27:0]	hps_0_f2h_stm_hw_events_stm_hwevents;
	input		hps_0_f2h_warm_reset_req_reset_n;
	output		hps_0_h2f_reset_reset_n;
	output		hps_0_hps_io_hps_io_emac1_inst_TX_CLK;
	output		hps_0_hps_io_hps_io_emac1_inst_TXD0;
	output		hps_0_hps_io_hps_io_emac1_inst_TXD1;
	output		hps_0_hps_io_hps_io_emac1_inst_TXD2;
	output		hps_0_hps_io_hps_io_emac1_inst_TXD3;
	input		hps_0_hps_io_hps_io_emac1_inst_RXD0;
	inout		hps_0_hps_io_hps_io_emac1_inst_MDIO;
	output		hps_0_hps_io_hps_io_emac1_inst_MDC;
	input		hps_0_hps_io_hps_io_emac1_inst_RX_CTL;
	output		hps_0_hps_io_hps_io_emac1_inst_TX_CTL;
	input		hps_0_hps_io_hps_io_emac1_inst_RX_CLK;
	input		hps_0_hps_io_hps_io_emac1_inst_RXD1;
	input		hps_0_hps_io_hps_io_emac1_inst_RXD2;
	input		hps_0_hps_io_hps_io_emac1_inst_RXD3;
	inout		hps_0_hps_io_hps_io_qspi_inst_IO0;
	inout		hps_0_hps_io_hps_io_qspi_inst_IO1;
	inout		hps_0_hps_io_hps_io_qspi_inst_IO2;
	inout		hps_0_hps_io_hps_io_qspi_inst_IO3;
	output		hps_0_hps_io_hps_io_qspi_inst_SS0;
	output		hps_0_hps_io_hps_io_qspi_inst_CLK;
	inout		hps_0_hps_io_hps_io_sdio_inst_CMD;
	inout		hps_0_hps_io_hps_io_sdio_inst_D0;
	inout		hps_0_hps_io_hps_io_sdio_inst_D1;
	output		hps_0_hps_io_hps_io_sdio_inst_CLK;
	inout		hps_0_hps_io_hps_io_sdio_inst_D2;
	inout		hps_0_hps_io_hps_io_sdio_inst_D3;
	inout		hps_0_hps_io_hps_io_usb1_inst_D0;
	inout		hps_0_hps_io_hps_io_usb1_inst_D1;
	inout		hps_0_hps_io_hps_io_usb1_inst_D2;
	inout		hps_0_hps_io_hps_io_usb1_inst_D3;
	inout		hps_0_hps_io_hps_io_usb1_inst_D4;
	inout		hps_0_hps_io_hps_io_usb1_inst_D5;
	inout		hps_0_hps_io_hps_io_usb1_inst_D6;
	inout		hps_0_hps_io_hps_io_usb1_inst_D7;
	input		hps_0_hps_io_hps_io_usb1_inst_CLK;
	output		hps_0_hps_io_hps_io_usb1_inst_STP;
	input		hps_0_hps_io_hps_io_usb1_inst_DIR;
	input		hps_0_hps_io_hps_io_usb1_inst_NXT;
	output		hps_0_hps_io_hps_io_spim0_inst_CLK;
	output		hps_0_hps_io_hps_io_spim0_inst_MOSI;
	input		hps_0_hps_io_hps_io_spim0_inst_MISO;
	output		hps_0_hps_io_hps_io_spim0_inst_SS0;
	output		hps_0_hps_io_hps_io_spim1_inst_CLK;
	output		hps_0_hps_io_hps_io_spim1_inst_MOSI;
	input		hps_0_hps_io_hps_io_spim1_inst_MISO;
	output		hps_0_hps_io_hps_io_spim1_inst_SS0;
	input		hps_0_hps_io_hps_io_uart0_inst_RX;
	output		hps_0_hps_io_hps_io_uart0_inst_TX;
	inout		hps_0_hps_io_hps_io_i2c0_inst_SDA;
	inout		hps_0_hps_io_hps_io_i2c0_inst_SCL;
	inout		hps_0_hps_io_hps_io_i2c1_inst_SDA;
	inout		hps_0_hps_io_hps_io_i2c1_inst_SCL;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO09;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO35;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO37;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO40;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO41;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO44;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO48;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO53;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO54;
	inout		hps_0_hps_io_hps_io_gpio_inst_GPIO61;
	input		ir_rx_conduit_end_export;
	input	[3:0]	key_external_connection_export;
	output	[9:0]	ledr_external_connection_export;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	input		reset_reset_n;
	output	[47:0]	seg7_conduit_end_writedata;
	input		spi_external_MISO;
	output		spi_external_MOSI;
	output		spi_external_SCLK;
	output		spi_external_SS_n;
	input	[9:0]	sw_external_connection_export;
	output		terasic_alsa_chip_conduit_end_xck;
	inout		terasic_alsa_chip_conduit_end_adclrck;
	input		terasic_alsa_chip_conduit_end_adcdat;
	inout		terasic_alsa_chip_conduit_end_bclk;
	output		terasic_alsa_chip_conduit_end_dacdat;
	inout		terasic_alsa_chip_conduit_end_daclrck;
	input		terasic_alsa_clock_sink_44_clk;
	input		terasic_alsa_clock_sink_48_clk;
	input		terasic_alsa_dma_conduit_end_capture_dma_ack;
	output		terasic_alsa_dma_conduit_end_capture_dma_req;
	input		terasic_alsa_dma_conduit_end_playback_dma_ack;
	output		terasic_alsa_dma_conduit_end_playback_dma_req;
	input		tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_clk;
	input	[7:0]	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_data;
	input		tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_de;
	input		tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_datavalid;
	input		tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_locked;
	input		tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_f;
	input		tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_v_sync;
	input		tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_h_sync;
	input	[7:0]	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_color_encoding;
	input	[7:0]	tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_bit_width;
	output		tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof;
	output		tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof_locked;
	output		tv_decoder_alt_vip_cl_cvi_0_clocked_video_refclk_div;
	output		tv_decoder_alt_vip_cl_cvi_0_clocked_video_clipping;
	output		tv_decoder_alt_vip_cl_cvi_0_clocked_video_padding;
	output		tv_decoder_alt_vip_cl_cvi_0_clocked_video_overflow;
	output	[12:0]	tv_decoder_sdram_wire_addr;
	output	[1:0]	tv_decoder_sdram_wire_ba;
	output		tv_decoder_sdram_wire_cas_n;
	output		tv_decoder_sdram_wire_cke;
	output		tv_decoder_sdram_wire_cs_n;
	inout	[15:0]	tv_decoder_sdram_wire_dq;
	output	[1:0]	tv_decoder_sdram_wire_dqm;
	output		tv_decoder_sdram_wire_ras_n;
	output		tv_decoder_sdram_wire_we_n;
	input		vga_stream_clk;
endmodule
