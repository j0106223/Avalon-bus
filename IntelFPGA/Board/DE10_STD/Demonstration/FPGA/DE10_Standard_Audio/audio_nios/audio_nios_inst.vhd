	component audio_nios is
		port (
			altpll_audio_locked_export         : out   std_logic;                                        -- export
			audio_conduit_end_XCK              : out   std_logic;                                        -- XCK
			audio_conduit_end_ADCDAT           : in    std_logic                     := 'X';             -- ADCDAT
			audio_conduit_end_ADCLRC           : in    std_logic                     := 'X';             -- ADCLRC
			audio_conduit_end_DACDAT           : out   std_logic;                                        -- DACDAT
			audio_conduit_end_DACLRC           : in    std_logic                     := 'X';             -- DACLRC
			audio_conduit_end_BCLK             : in    std_logic                     := 'X';             -- BCLK
			clk_clk                            : in    std_logic                     := 'X';             -- clk
			i2c_scl_external_connection_export : out   std_logic;                                        -- export
			i2c_sda_external_connection_export : inout std_logic                     := 'X';             -- export
			key_external_connection_export     : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			pio_0_external_connection_export   : out   std_logic_vector(9 downto 0);                     -- export
			pll_locked_export                  : out   std_logic;                                        -- export
			pll_sdam_clk                       : out   std_logic;                                        -- clk
			reset_reset_n                      : in    std_logic                     := 'X';             -- reset_n
			sdram_wire_addr                    : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba                      : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n                   : out   std_logic;                                        -- cas_n
			sdram_wire_cke                     : out   std_logic;                                        -- cke
			sdram_wire_cs_n                    : out   std_logic;                                        -- cs_n
			sdram_wire_dq                      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                     : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n                   : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                    : out   std_logic;                                        -- we_n
			seg7_conduit_end_export            : out   std_logic_vector(47 downto 0);                    -- export
			sw_external_connection_export      : in    std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component audio_nios;

	u0 : component audio_nios
		port map (
			altpll_audio_locked_export         => CONNECTED_TO_altpll_audio_locked_export,         --         altpll_audio_locked.export
			audio_conduit_end_XCK              => CONNECTED_TO_audio_conduit_end_XCK,              --           audio_conduit_end.XCK
			audio_conduit_end_ADCDAT           => CONNECTED_TO_audio_conduit_end_ADCDAT,           --                            .ADCDAT
			audio_conduit_end_ADCLRC           => CONNECTED_TO_audio_conduit_end_ADCLRC,           --                            .ADCLRC
			audio_conduit_end_DACDAT           => CONNECTED_TO_audio_conduit_end_DACDAT,           --                            .DACDAT
			audio_conduit_end_DACLRC           => CONNECTED_TO_audio_conduit_end_DACLRC,           --                            .DACLRC
			audio_conduit_end_BCLK             => CONNECTED_TO_audio_conduit_end_BCLK,             --                            .BCLK
			clk_clk                            => CONNECTED_TO_clk_clk,                            --                         clk.clk
			i2c_scl_external_connection_export => CONNECTED_TO_i2c_scl_external_connection_export, -- i2c_scl_external_connection.export
			i2c_sda_external_connection_export => CONNECTED_TO_i2c_sda_external_connection_export, -- i2c_sda_external_connection.export
			key_external_connection_export     => CONNECTED_TO_key_external_connection_export,     --     key_external_connection.export
			pio_0_external_connection_export   => CONNECTED_TO_pio_0_external_connection_export,   --   pio_0_external_connection.export
			pll_locked_export                  => CONNECTED_TO_pll_locked_export,                  --                  pll_locked.export
			pll_sdam_clk                       => CONNECTED_TO_pll_sdam_clk,                       --                    pll_sdam.clk
			reset_reset_n                      => CONNECTED_TO_reset_reset_n,                      --                       reset.reset_n
			sdram_wire_addr                    => CONNECTED_TO_sdram_wire_addr,                    --                  sdram_wire.addr
			sdram_wire_ba                      => CONNECTED_TO_sdram_wire_ba,                      --                            .ba
			sdram_wire_cas_n                   => CONNECTED_TO_sdram_wire_cas_n,                   --                            .cas_n
			sdram_wire_cke                     => CONNECTED_TO_sdram_wire_cke,                     --                            .cke
			sdram_wire_cs_n                    => CONNECTED_TO_sdram_wire_cs_n,                    --                            .cs_n
			sdram_wire_dq                      => CONNECTED_TO_sdram_wire_dq,                      --                            .dq
			sdram_wire_dqm                     => CONNECTED_TO_sdram_wire_dqm,                     --                            .dqm
			sdram_wire_ras_n                   => CONNECTED_TO_sdram_wire_ras_n,                   --                            .ras_n
			sdram_wire_we_n                    => CONNECTED_TO_sdram_wire_we_n,                    --                            .we_n
			seg7_conduit_end_export            => CONNECTED_TO_seg7_conduit_end_export,            --            seg7_conduit_end.export
			sw_external_connection_export      => CONNECTED_TO_sw_external_connection_export       --      sw_external_connection.export
		);

