	component soc_system is
		port (
			alt_vip_itc_0_clocked_video_vid_clk                          : in    std_logic                     := 'X';             -- vid_clk
			alt_vip_itc_0_clocked_video_vid_data                         : out   std_logic_vector(23 downto 0);                    -- vid_data
			alt_vip_itc_0_clocked_video_underflow                        : out   std_logic;                                        -- underflow
			alt_vip_itc_0_clocked_video_vid_datavalid                    : out   std_logic;                                        -- vid_datavalid
			alt_vip_itc_0_clocked_video_vid_v_sync                       : out   std_logic;                                        -- vid_v_sync
			alt_vip_itc_0_clocked_video_vid_h_sync                       : out   std_logic;                                        -- vid_h_sync
			alt_vip_itc_0_clocked_video_vid_f                            : out   std_logic;                                        -- vid_f
			alt_vip_itc_0_clocked_video_vid_h                            : out   std_logic;                                        -- vid_h
			alt_vip_itc_0_clocked_video_vid_v                            : out   std_logic;                                        -- vid_v
			clk_clk                                                      : in    std_logic                     := 'X';             -- clk
			hps_0_f2h_cold_reset_req_reset_n                             : in    std_logic                     := 'X';             -- reset_n
			hps_0_f2h_debug_reset_req_reset_n                            : in    std_logic                     := 'X';             -- reset_n
			hps_0_f2h_dma_req0_dma_req                                   : in    std_logic                     := 'X';             -- dma_req
			hps_0_f2h_dma_req0_dma_single                                : in    std_logic                     := 'X';             -- dma_single
			hps_0_f2h_dma_req0_dma_ack                                   : out   std_logic;                                        -- dma_ack
			hps_0_f2h_dma_req1_dma_req                                   : in    std_logic                     := 'X';             -- dma_req
			hps_0_f2h_dma_req1_dma_single                                : in    std_logic                     := 'X';             -- dma_single
			hps_0_f2h_dma_req1_dma_ack                                   : out   std_logic;                                        -- dma_ack
			hps_0_f2h_stm_hw_events_stm_hwevents                         : in    std_logic_vector(27 downto 0) := (others => 'X'); -- stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n                             : in    std_logic                     := 'X';             -- reset_n
			hps_0_h2f_reset_reset_n                                      : out   std_logic;                                        -- reset_n
			hps_0_hps_io_hps_io_emac1_inst_TX_CLK                        : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
			hps_0_hps_io_hps_io_emac1_inst_TXD0                          : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
			hps_0_hps_io_hps_io_emac1_inst_TXD1                          : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
			hps_0_hps_io_hps_io_emac1_inst_TXD2                          : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
			hps_0_hps_io_hps_io_emac1_inst_TXD3                          : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
			hps_0_hps_io_hps_io_emac1_inst_RXD0                          : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
			hps_0_hps_io_hps_io_emac1_inst_MDIO                          : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
			hps_0_hps_io_hps_io_emac1_inst_MDC                           : out   std_logic;                                        -- hps_io_emac1_inst_MDC
			hps_0_hps_io_hps_io_emac1_inst_RX_CTL                        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_0_hps_io_hps_io_emac1_inst_TX_CTL                        : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
			hps_0_hps_io_hps_io_emac1_inst_RX_CLK                        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_0_hps_io_hps_io_emac1_inst_RXD1                          : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
			hps_0_hps_io_hps_io_emac1_inst_RXD2                          : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
			hps_0_hps_io_hps_io_emac1_inst_RXD3                          : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
			hps_0_hps_io_hps_io_qspi_inst_IO0                            : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO0
			hps_0_hps_io_hps_io_qspi_inst_IO1                            : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO1
			hps_0_hps_io_hps_io_qspi_inst_IO2                            : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO2
			hps_0_hps_io_hps_io_qspi_inst_IO3                            : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO3
			hps_0_hps_io_hps_io_qspi_inst_SS0                            : out   std_logic;                                        -- hps_io_qspi_inst_SS0
			hps_0_hps_io_hps_io_qspi_inst_CLK                            : out   std_logic;                                        -- hps_io_qspi_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_CMD                            : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
			hps_0_hps_io_hps_io_sdio_inst_D0                             : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
			hps_0_hps_io_hps_io_sdio_inst_D1                             : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
			hps_0_hps_io_hps_io_sdio_inst_CLK                            : out   std_logic;                                        -- hps_io_sdio_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_D2                             : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
			hps_0_hps_io_hps_io_sdio_inst_D3                             : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D0                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
			hps_0_hps_io_hps_io_usb1_inst_D1                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
			hps_0_hps_io_hps_io_usb1_inst_D2                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
			hps_0_hps_io_hps_io_usb1_inst_D3                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D4                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
			hps_0_hps_io_hps_io_usb1_inst_D5                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
			hps_0_hps_io_hps_io_usb1_inst_D6                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
			hps_0_hps_io_hps_io_usb1_inst_D7                             : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
			hps_0_hps_io_hps_io_usb1_inst_CLK                            : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
			hps_0_hps_io_hps_io_usb1_inst_STP                            : out   std_logic;                                        -- hps_io_usb1_inst_STP
			hps_0_hps_io_hps_io_usb1_inst_DIR                            : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
			hps_0_hps_io_hps_io_usb1_inst_NXT                            : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
			hps_0_hps_io_hps_io_spim0_inst_CLK                           : out   std_logic;                                        -- hps_io_spim0_inst_CLK
			hps_0_hps_io_hps_io_spim0_inst_MOSI                          : out   std_logic;                                        -- hps_io_spim0_inst_MOSI
			hps_0_hps_io_hps_io_spim0_inst_MISO                          : in    std_logic                     := 'X';             -- hps_io_spim0_inst_MISO
			hps_0_hps_io_hps_io_spim0_inst_SS0                           : out   std_logic;                                        -- hps_io_spim0_inst_SS0
			hps_0_hps_io_hps_io_spim1_inst_CLK                           : out   std_logic;                                        -- hps_io_spim1_inst_CLK
			hps_0_hps_io_hps_io_spim1_inst_MOSI                          : out   std_logic;                                        -- hps_io_spim1_inst_MOSI
			hps_0_hps_io_hps_io_spim1_inst_MISO                          : in    std_logic                     := 'X';             -- hps_io_spim1_inst_MISO
			hps_0_hps_io_hps_io_spim1_inst_SS0                           : out   std_logic;                                        -- hps_io_spim1_inst_SS0
			hps_0_hps_io_hps_io_uart0_inst_RX                            : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
			hps_0_hps_io_hps_io_uart0_inst_TX                            : out   std_logic;                                        -- hps_io_uart0_inst_TX
			hps_0_hps_io_hps_io_i2c0_inst_SDA                            : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SDA
			hps_0_hps_io_hps_io_i2c0_inst_SCL                            : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SCL
			hps_0_hps_io_hps_io_i2c1_inst_SDA                            : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SDA
			hps_0_hps_io_hps_io_i2c1_inst_SCL                            : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SCL
			hps_0_hps_io_hps_io_gpio_inst_GPIO09                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
			hps_0_hps_io_hps_io_gpio_inst_GPIO35                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
			hps_0_hps_io_hps_io_gpio_inst_GPIO37                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO37
			hps_0_hps_io_hps_io_gpio_inst_GPIO40                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO40
			hps_0_hps_io_hps_io_gpio_inst_GPIO41                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO41
			hps_0_hps_io_hps_io_gpio_inst_GPIO44                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO44
			hps_0_hps_io_hps_io_gpio_inst_GPIO48                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO48
			hps_0_hps_io_hps_io_gpio_inst_GPIO53                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
			hps_0_hps_io_hps_io_gpio_inst_GPIO54                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
			hps_0_hps_io_hps_io_gpio_inst_GPIO61                         : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO61
			ir_rx_conduit_end_export                                     : in    std_logic                     := 'X';             -- export
			key_external_connection_export                               : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			ledr_external_connection_export                              : out   std_logic_vector(9 downto 0);                     -- export
			memory_mem_a                                                 : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                                                : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                                                : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                                              : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                                               : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                                              : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                                             : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                                             : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                                              : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                                           : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                                                : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                                               : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                                             : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                                               : out   std_logic;                                        -- mem_odt
			memory_mem_dm                                                : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin                                             : in    std_logic                     := 'X';             -- oct_rzqin
			reset_reset_n                                                : in    std_logic                     := 'X';             -- reset_n
			seg7_conduit_end_writedata                                   : out   std_logic_vector(47 downto 0);                    -- writedata
			spi_external_MISO                                            : in    std_logic                     := 'X';             -- MISO
			spi_external_MOSI                                            : out   std_logic;                                        -- MOSI
			spi_external_SCLK                                            : out   std_logic;                                        -- SCLK
			spi_external_SS_n                                            : out   std_logic;                                        -- SS_n
			sw_external_connection_export                                : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			terasic_alsa_chip_conduit_end_xck                            : out   std_logic;                                        -- xck
			terasic_alsa_chip_conduit_end_adclrck                        : inout std_logic                     := 'X';             -- adclrck
			terasic_alsa_chip_conduit_end_adcdat                         : in    std_logic                     := 'X';             -- adcdat
			terasic_alsa_chip_conduit_end_bclk                           : inout std_logic                     := 'X';             -- bclk
			terasic_alsa_chip_conduit_end_dacdat                         : out   std_logic;                                        -- dacdat
			terasic_alsa_chip_conduit_end_daclrck                        : inout std_logic                     := 'X';             -- daclrck
			terasic_alsa_clock_sink_44_clk                               : in    std_logic                     := 'X';             -- clk
			terasic_alsa_clock_sink_48_clk                               : in    std_logic                     := 'X';             -- clk
			terasic_alsa_dma_conduit_end_capture_dma_ack                 : in    std_logic                     := 'X';             -- capture_dma_ack
			terasic_alsa_dma_conduit_end_capture_dma_req                 : out   std_logic;                                        -- capture_dma_req
			terasic_alsa_dma_conduit_end_playback_dma_ack                : in    std_logic                     := 'X';             -- playback_dma_ack
			terasic_alsa_dma_conduit_end_playback_dma_req                : out   std_logic;                                        -- playback_dma_req
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_clk            : in    std_logic                     := 'X';             -- vid_clk
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_data           : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- vid_data
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_de             : in    std_logic                     := 'X';             -- vid_de
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_datavalid      : in    std_logic                     := 'X';             -- vid_datavalid
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_locked         : in    std_logic                     := 'X';             -- vid_locked
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_f              : in    std_logic                     := 'X';             -- vid_f
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_v_sync         : in    std_logic                     := 'X';             -- vid_v_sync
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_h_sync         : in    std_logic                     := 'X';             -- vid_h_sync
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_color_encoding : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- vid_color_encoding
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_bit_width      : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- vid_bit_width
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof                : out   std_logic;                                        -- sof
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof_locked         : out   std_logic;                                        -- sof_locked
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_refclk_div         : out   std_logic;                                        -- refclk_div
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_clipping           : out   std_logic;                                        -- clipping
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_padding            : out   std_logic;                                        -- padding
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_overflow           : out   std_logic;                                        -- overflow
			tv_decoder_sdram_wire_addr                                   : out   std_logic_vector(12 downto 0);                    -- addr
			tv_decoder_sdram_wire_ba                                     : out   std_logic_vector(1 downto 0);                     -- ba
			tv_decoder_sdram_wire_cas_n                                  : out   std_logic;                                        -- cas_n
			tv_decoder_sdram_wire_cke                                    : out   std_logic;                                        -- cke
			tv_decoder_sdram_wire_cs_n                                   : out   std_logic;                                        -- cs_n
			tv_decoder_sdram_wire_dq                                     : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			tv_decoder_sdram_wire_dqm                                    : out   std_logic_vector(1 downto 0);                     -- dqm
			tv_decoder_sdram_wire_ras_n                                  : out   std_logic;                                        -- ras_n
			tv_decoder_sdram_wire_we_n                                   : out   std_logic;                                        -- we_n
			vga_stream_clk                                               : in    std_logic                     := 'X'              -- clk
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			alt_vip_itc_0_clocked_video_vid_clk                          => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_clk,                          --               alt_vip_itc_0_clocked_video.vid_clk
			alt_vip_itc_0_clocked_video_vid_data                         => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_data,                         --                                          .vid_data
			alt_vip_itc_0_clocked_video_underflow                        => CONNECTED_TO_alt_vip_itc_0_clocked_video_underflow,                        --                                          .underflow
			alt_vip_itc_0_clocked_video_vid_datavalid                    => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_datavalid,                    --                                          .vid_datavalid
			alt_vip_itc_0_clocked_video_vid_v_sync                       => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_v_sync,                       --                                          .vid_v_sync
			alt_vip_itc_0_clocked_video_vid_h_sync                       => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_h_sync,                       --                                          .vid_h_sync
			alt_vip_itc_0_clocked_video_vid_f                            => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_f,                            --                                          .vid_f
			alt_vip_itc_0_clocked_video_vid_h                            => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_h,                            --                                          .vid_h
			alt_vip_itc_0_clocked_video_vid_v                            => CONNECTED_TO_alt_vip_itc_0_clocked_video_vid_v,                            --                                          .vid_v
			clk_clk                                                      => CONNECTED_TO_clk_clk,                                                      --                                       clk.clk
			hps_0_f2h_cold_reset_req_reset_n                             => CONNECTED_TO_hps_0_f2h_cold_reset_req_reset_n,                             --                  hps_0_f2h_cold_reset_req.reset_n
			hps_0_f2h_debug_reset_req_reset_n                            => CONNECTED_TO_hps_0_f2h_debug_reset_req_reset_n,                            --                 hps_0_f2h_debug_reset_req.reset_n
			hps_0_f2h_dma_req0_dma_req                                   => CONNECTED_TO_hps_0_f2h_dma_req0_dma_req,                                   --                        hps_0_f2h_dma_req0.dma_req
			hps_0_f2h_dma_req0_dma_single                                => CONNECTED_TO_hps_0_f2h_dma_req0_dma_single,                                --                                          .dma_single
			hps_0_f2h_dma_req0_dma_ack                                   => CONNECTED_TO_hps_0_f2h_dma_req0_dma_ack,                                   --                                          .dma_ack
			hps_0_f2h_dma_req1_dma_req                                   => CONNECTED_TO_hps_0_f2h_dma_req1_dma_req,                                   --                        hps_0_f2h_dma_req1.dma_req
			hps_0_f2h_dma_req1_dma_single                                => CONNECTED_TO_hps_0_f2h_dma_req1_dma_single,                                --                                          .dma_single
			hps_0_f2h_dma_req1_dma_ack                                   => CONNECTED_TO_hps_0_f2h_dma_req1_dma_ack,                                   --                                          .dma_ack
			hps_0_f2h_stm_hw_events_stm_hwevents                         => CONNECTED_TO_hps_0_f2h_stm_hw_events_stm_hwevents,                         --                   hps_0_f2h_stm_hw_events.stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n                             => CONNECTED_TO_hps_0_f2h_warm_reset_req_reset_n,                             --                  hps_0_f2h_warm_reset_req.reset_n
			hps_0_h2f_reset_reset_n                                      => CONNECTED_TO_hps_0_h2f_reset_reset_n,                                      --                           hps_0_h2f_reset.reset_n
			hps_0_hps_io_hps_io_emac1_inst_TX_CLK                        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TX_CLK,                        --                              hps_0_hps_io.hps_io_emac1_inst_TX_CLK
			hps_0_hps_io_hps_io_emac1_inst_TXD0                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD0,                          --                                          .hps_io_emac1_inst_TXD0
			hps_0_hps_io_hps_io_emac1_inst_TXD1                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD1,                          --                                          .hps_io_emac1_inst_TXD1
			hps_0_hps_io_hps_io_emac1_inst_TXD2                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD2,                          --                                          .hps_io_emac1_inst_TXD2
			hps_0_hps_io_hps_io_emac1_inst_TXD3                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD3,                          --                                          .hps_io_emac1_inst_TXD3
			hps_0_hps_io_hps_io_emac1_inst_RXD0                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD0,                          --                                          .hps_io_emac1_inst_RXD0
			hps_0_hps_io_hps_io_emac1_inst_MDIO                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_MDIO,                          --                                          .hps_io_emac1_inst_MDIO
			hps_0_hps_io_hps_io_emac1_inst_MDC                           => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_MDC,                           --                                          .hps_io_emac1_inst_MDC
			hps_0_hps_io_hps_io_emac1_inst_RX_CTL                        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RX_CTL,                        --                                          .hps_io_emac1_inst_RX_CTL
			hps_0_hps_io_hps_io_emac1_inst_TX_CTL                        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TX_CTL,                        --                                          .hps_io_emac1_inst_TX_CTL
			hps_0_hps_io_hps_io_emac1_inst_RX_CLK                        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RX_CLK,                        --                                          .hps_io_emac1_inst_RX_CLK
			hps_0_hps_io_hps_io_emac1_inst_RXD1                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD1,                          --                                          .hps_io_emac1_inst_RXD1
			hps_0_hps_io_hps_io_emac1_inst_RXD2                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD2,                          --                                          .hps_io_emac1_inst_RXD2
			hps_0_hps_io_hps_io_emac1_inst_RXD3                          => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD3,                          --                                          .hps_io_emac1_inst_RXD3
			hps_0_hps_io_hps_io_qspi_inst_IO0                            => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO0,                            --                                          .hps_io_qspi_inst_IO0
			hps_0_hps_io_hps_io_qspi_inst_IO1                            => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO1,                            --                                          .hps_io_qspi_inst_IO1
			hps_0_hps_io_hps_io_qspi_inst_IO2                            => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO2,                            --                                          .hps_io_qspi_inst_IO2
			hps_0_hps_io_hps_io_qspi_inst_IO3                            => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO3,                            --                                          .hps_io_qspi_inst_IO3
			hps_0_hps_io_hps_io_qspi_inst_SS0                            => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_SS0,                            --                                          .hps_io_qspi_inst_SS0
			hps_0_hps_io_hps_io_qspi_inst_CLK                            => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_CLK,                            --                                          .hps_io_qspi_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_CMD                            => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_CMD,                            --                                          .hps_io_sdio_inst_CMD
			hps_0_hps_io_hps_io_sdio_inst_D0                             => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D0,                             --                                          .hps_io_sdio_inst_D0
			hps_0_hps_io_hps_io_sdio_inst_D1                             => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D1,                             --                                          .hps_io_sdio_inst_D1
			hps_0_hps_io_hps_io_sdio_inst_CLK                            => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_CLK,                            --                                          .hps_io_sdio_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_D2                             => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D2,                             --                                          .hps_io_sdio_inst_D2
			hps_0_hps_io_hps_io_sdio_inst_D3                             => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D3,                             --                                          .hps_io_sdio_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D0                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D0,                             --                                          .hps_io_usb1_inst_D0
			hps_0_hps_io_hps_io_usb1_inst_D1                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D1,                             --                                          .hps_io_usb1_inst_D1
			hps_0_hps_io_hps_io_usb1_inst_D2                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D2,                             --                                          .hps_io_usb1_inst_D2
			hps_0_hps_io_hps_io_usb1_inst_D3                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D3,                             --                                          .hps_io_usb1_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D4                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D4,                             --                                          .hps_io_usb1_inst_D4
			hps_0_hps_io_hps_io_usb1_inst_D5                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D5,                             --                                          .hps_io_usb1_inst_D5
			hps_0_hps_io_hps_io_usb1_inst_D6                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D6,                             --                                          .hps_io_usb1_inst_D6
			hps_0_hps_io_hps_io_usb1_inst_D7                             => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D7,                             --                                          .hps_io_usb1_inst_D7
			hps_0_hps_io_hps_io_usb1_inst_CLK                            => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_CLK,                            --                                          .hps_io_usb1_inst_CLK
			hps_0_hps_io_hps_io_usb1_inst_STP                            => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_STP,                            --                                          .hps_io_usb1_inst_STP
			hps_0_hps_io_hps_io_usb1_inst_DIR                            => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_DIR,                            --                                          .hps_io_usb1_inst_DIR
			hps_0_hps_io_hps_io_usb1_inst_NXT                            => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_NXT,                            --                                          .hps_io_usb1_inst_NXT
			hps_0_hps_io_hps_io_spim0_inst_CLK                           => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_CLK,                           --                                          .hps_io_spim0_inst_CLK
			hps_0_hps_io_hps_io_spim0_inst_MOSI                          => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_MOSI,                          --                                          .hps_io_spim0_inst_MOSI
			hps_0_hps_io_hps_io_spim0_inst_MISO                          => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_MISO,                          --                                          .hps_io_spim0_inst_MISO
			hps_0_hps_io_hps_io_spim0_inst_SS0                           => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_SS0,                           --                                          .hps_io_spim0_inst_SS0
			hps_0_hps_io_hps_io_spim1_inst_CLK                           => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_CLK,                           --                                          .hps_io_spim1_inst_CLK
			hps_0_hps_io_hps_io_spim1_inst_MOSI                          => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_MOSI,                          --                                          .hps_io_spim1_inst_MOSI
			hps_0_hps_io_hps_io_spim1_inst_MISO                          => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_MISO,                          --                                          .hps_io_spim1_inst_MISO
			hps_0_hps_io_hps_io_spim1_inst_SS0                           => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_SS0,                           --                                          .hps_io_spim1_inst_SS0
			hps_0_hps_io_hps_io_uart0_inst_RX                            => CONNECTED_TO_hps_0_hps_io_hps_io_uart0_inst_RX,                            --                                          .hps_io_uart0_inst_RX
			hps_0_hps_io_hps_io_uart0_inst_TX                            => CONNECTED_TO_hps_0_hps_io_hps_io_uart0_inst_TX,                            --                                          .hps_io_uart0_inst_TX
			hps_0_hps_io_hps_io_i2c0_inst_SDA                            => CONNECTED_TO_hps_0_hps_io_hps_io_i2c0_inst_SDA,                            --                                          .hps_io_i2c0_inst_SDA
			hps_0_hps_io_hps_io_i2c0_inst_SCL                            => CONNECTED_TO_hps_0_hps_io_hps_io_i2c0_inst_SCL,                            --                                          .hps_io_i2c0_inst_SCL
			hps_0_hps_io_hps_io_i2c1_inst_SDA                            => CONNECTED_TO_hps_0_hps_io_hps_io_i2c1_inst_SDA,                            --                                          .hps_io_i2c1_inst_SDA
			hps_0_hps_io_hps_io_i2c1_inst_SCL                            => CONNECTED_TO_hps_0_hps_io_hps_io_i2c1_inst_SCL,                            --                                          .hps_io_i2c1_inst_SCL
			hps_0_hps_io_hps_io_gpio_inst_GPIO09                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO09,                         --                                          .hps_io_gpio_inst_GPIO09
			hps_0_hps_io_hps_io_gpio_inst_GPIO35                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO35,                         --                                          .hps_io_gpio_inst_GPIO35
			hps_0_hps_io_hps_io_gpio_inst_GPIO37                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO37,                         --                                          .hps_io_gpio_inst_GPIO37
			hps_0_hps_io_hps_io_gpio_inst_GPIO40                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO40,                         --                                          .hps_io_gpio_inst_GPIO40
			hps_0_hps_io_hps_io_gpio_inst_GPIO41                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO41,                         --                                          .hps_io_gpio_inst_GPIO41
			hps_0_hps_io_hps_io_gpio_inst_GPIO44                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO44,                         --                                          .hps_io_gpio_inst_GPIO44
			hps_0_hps_io_hps_io_gpio_inst_GPIO48                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO48,                         --                                          .hps_io_gpio_inst_GPIO48
			hps_0_hps_io_hps_io_gpio_inst_GPIO53                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO53,                         --                                          .hps_io_gpio_inst_GPIO53
			hps_0_hps_io_hps_io_gpio_inst_GPIO54                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO54,                         --                                          .hps_io_gpio_inst_GPIO54
			hps_0_hps_io_hps_io_gpio_inst_GPIO61                         => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO61,                         --                                          .hps_io_gpio_inst_GPIO61
			ir_rx_conduit_end_export                                     => CONNECTED_TO_ir_rx_conduit_end_export,                                     --                         ir_rx_conduit_end.export
			key_external_connection_export                               => CONNECTED_TO_key_external_connection_export,                               --                   key_external_connection.export
			ledr_external_connection_export                              => CONNECTED_TO_ledr_external_connection_export,                              --                  ledr_external_connection.export
			memory_mem_a                                                 => CONNECTED_TO_memory_mem_a,                                                 --                                    memory.mem_a
			memory_mem_ba                                                => CONNECTED_TO_memory_mem_ba,                                                --                                          .mem_ba
			memory_mem_ck                                                => CONNECTED_TO_memory_mem_ck,                                                --                                          .mem_ck
			memory_mem_ck_n                                              => CONNECTED_TO_memory_mem_ck_n,                                              --                                          .mem_ck_n
			memory_mem_cke                                               => CONNECTED_TO_memory_mem_cke,                                               --                                          .mem_cke
			memory_mem_cs_n                                              => CONNECTED_TO_memory_mem_cs_n,                                              --                                          .mem_cs_n
			memory_mem_ras_n                                             => CONNECTED_TO_memory_mem_ras_n,                                             --                                          .mem_ras_n
			memory_mem_cas_n                                             => CONNECTED_TO_memory_mem_cas_n,                                             --                                          .mem_cas_n
			memory_mem_we_n                                              => CONNECTED_TO_memory_mem_we_n,                                              --                                          .mem_we_n
			memory_mem_reset_n                                           => CONNECTED_TO_memory_mem_reset_n,                                           --                                          .mem_reset_n
			memory_mem_dq                                                => CONNECTED_TO_memory_mem_dq,                                                --                                          .mem_dq
			memory_mem_dqs                                               => CONNECTED_TO_memory_mem_dqs,                                               --                                          .mem_dqs
			memory_mem_dqs_n                                             => CONNECTED_TO_memory_mem_dqs_n,                                             --                                          .mem_dqs_n
			memory_mem_odt                                               => CONNECTED_TO_memory_mem_odt,                                               --                                          .mem_odt
			memory_mem_dm                                                => CONNECTED_TO_memory_mem_dm,                                                --                                          .mem_dm
			memory_oct_rzqin                                             => CONNECTED_TO_memory_oct_rzqin,                                             --                                          .oct_rzqin
			reset_reset_n                                                => CONNECTED_TO_reset_reset_n,                                                --                                     reset.reset_n
			seg7_conduit_end_writedata                                   => CONNECTED_TO_seg7_conduit_end_writedata,                                   --                          seg7_conduit_end.writedata
			spi_external_MISO                                            => CONNECTED_TO_spi_external_MISO,                                            --                              spi_external.MISO
			spi_external_MOSI                                            => CONNECTED_TO_spi_external_MOSI,                                            --                                          .MOSI
			spi_external_SCLK                                            => CONNECTED_TO_spi_external_SCLK,                                            --                                          .SCLK
			spi_external_SS_n                                            => CONNECTED_TO_spi_external_SS_n,                                            --                                          .SS_n
			sw_external_connection_export                                => CONNECTED_TO_sw_external_connection_export,                                --                    sw_external_connection.export
			terasic_alsa_chip_conduit_end_xck                            => CONNECTED_TO_terasic_alsa_chip_conduit_end_xck,                            --             terasic_alsa_chip_conduit_end.xck
			terasic_alsa_chip_conduit_end_adclrck                        => CONNECTED_TO_terasic_alsa_chip_conduit_end_adclrck,                        --                                          .adclrck
			terasic_alsa_chip_conduit_end_adcdat                         => CONNECTED_TO_terasic_alsa_chip_conduit_end_adcdat,                         --                                          .adcdat
			terasic_alsa_chip_conduit_end_bclk                           => CONNECTED_TO_terasic_alsa_chip_conduit_end_bclk,                           --                                          .bclk
			terasic_alsa_chip_conduit_end_dacdat                         => CONNECTED_TO_terasic_alsa_chip_conduit_end_dacdat,                         --                                          .dacdat
			terasic_alsa_chip_conduit_end_daclrck                        => CONNECTED_TO_terasic_alsa_chip_conduit_end_daclrck,                        --                                          .daclrck
			terasic_alsa_clock_sink_44_clk                               => CONNECTED_TO_terasic_alsa_clock_sink_44_clk,                               --                terasic_alsa_clock_sink_44.clk
			terasic_alsa_clock_sink_48_clk                               => CONNECTED_TO_terasic_alsa_clock_sink_48_clk,                               --                terasic_alsa_clock_sink_48.clk
			terasic_alsa_dma_conduit_end_capture_dma_ack                 => CONNECTED_TO_terasic_alsa_dma_conduit_end_capture_dma_ack,                 --              terasic_alsa_dma_conduit_end.capture_dma_ack
			terasic_alsa_dma_conduit_end_capture_dma_req                 => CONNECTED_TO_terasic_alsa_dma_conduit_end_capture_dma_req,                 --                                          .capture_dma_req
			terasic_alsa_dma_conduit_end_playback_dma_ack                => CONNECTED_TO_terasic_alsa_dma_conduit_end_playback_dma_ack,                --                                          .playback_dma_ack
			terasic_alsa_dma_conduit_end_playback_dma_req                => CONNECTED_TO_terasic_alsa_dma_conduit_end_playback_dma_req,                --                                          .playback_dma_req
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_clk            => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_clk,            -- tv_decoder_alt_vip_cl_cvi_0_clocked_video.vid_clk
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_data           => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_data,           --                                          .vid_data
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_de             => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_de,             --                                          .vid_de
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_datavalid      => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_datavalid,      --                                          .vid_datavalid
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_locked         => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_locked,         --                                          .vid_locked
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_f              => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_f,              --                                          .vid_f
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_v_sync         => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_v_sync,         --                                          .vid_v_sync
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_h_sync         => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_h_sync,         --                                          .vid_h_sync
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_color_encoding => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_color_encoding, --                                          .vid_color_encoding
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_bit_width      => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_vid_bit_width,      --                                          .vid_bit_width
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof                => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof,                --                                          .sof
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof_locked         => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_sof_locked,         --                                          .sof_locked
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_refclk_div         => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_refclk_div,         --                                          .refclk_div
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_clipping           => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_clipping,           --                                          .clipping
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_padding            => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_padding,            --                                          .padding
			tv_decoder_alt_vip_cl_cvi_0_clocked_video_overflow           => CONNECTED_TO_tv_decoder_alt_vip_cl_cvi_0_clocked_video_overflow,           --                                          .overflow
			tv_decoder_sdram_wire_addr                                   => CONNECTED_TO_tv_decoder_sdram_wire_addr,                                   --                     tv_decoder_sdram_wire.addr
			tv_decoder_sdram_wire_ba                                     => CONNECTED_TO_tv_decoder_sdram_wire_ba,                                     --                                          .ba
			tv_decoder_sdram_wire_cas_n                                  => CONNECTED_TO_tv_decoder_sdram_wire_cas_n,                                  --                                          .cas_n
			tv_decoder_sdram_wire_cke                                    => CONNECTED_TO_tv_decoder_sdram_wire_cke,                                    --                                          .cke
			tv_decoder_sdram_wire_cs_n                                   => CONNECTED_TO_tv_decoder_sdram_wire_cs_n,                                   --                                          .cs_n
			tv_decoder_sdram_wire_dq                                     => CONNECTED_TO_tv_decoder_sdram_wire_dq,                                     --                                          .dq
			tv_decoder_sdram_wire_dqm                                    => CONNECTED_TO_tv_decoder_sdram_wire_dqm,                                    --                                          .dqm
			tv_decoder_sdram_wire_ras_n                                  => CONNECTED_TO_tv_decoder_sdram_wire_ras_n,                                  --                                          .ras_n
			tv_decoder_sdram_wire_we_n                                   => CONNECTED_TO_tv_decoder_sdram_wire_we_n,                                   --                                          .we_n
			vga_stream_clk                                               => CONNECTED_TO_vga_stream_clk                                                --                                vga_stream.clk
		);

