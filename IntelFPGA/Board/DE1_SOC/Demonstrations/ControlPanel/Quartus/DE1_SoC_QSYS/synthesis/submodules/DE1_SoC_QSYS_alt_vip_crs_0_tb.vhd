-- DE1_SoC_QSYS_alt_vip_crs_0_tb.vhd


library IEEE;
library altera;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use altera.alt_cusp131_package.all;

entity DE1_SoC_QSYS_alt_vip_crs_0_tb is
end entity DE1_SoC_QSYS_alt_vip_crs_0_tb;

architecture rtl of DE1_SoC_QSYS_alt_vip_crs_0_tb is
	component alt_cusp131_clock_reset is
		port (
			clock : out std_logic;
			reset : out std_logic
		);
	end component alt_cusp131_clock_reset;

	component DE1_SoC_QSYS_alt_vip_crs_0 is
		generic (
			IN_CHANNELS_IN_PAR  : integer := 1;
			OUT_CHANNELS_IN_PAR : integer := 1;
			PARAMETERISATION    : string  := "<chromaResamplerParams><CRS_NAME>chroma_resampler</CRS_NAME><CRS_BPS>8</CRS_BPS><CRS_WIDTH>256</CRS_WIDTH><CRS_HEIGHT>256</CRS_HEIGHT><CRS_PARALLEL_MODE>false</CRS_PARALLEL_MODE><CRS_RESAMPLING><FORMAT><IN>422</IN><OUT>444</OUT></FORMAT><COSITING><V>true</V><H>true</H></COSITING></CRS_RESAMPLING><CRS_ALGORITHM><V><NAME>INTERPOLATION_1D_NEAREST_NEIGHBOUR</NAME><LUMA_ADAPTIVE>false</LUMA_ADAPTIVE></V><H><NAME>INTERPOLATION_1D_FULL_FILTERING</NAME><LUMA_ADAPTIVE>true</LUMA_ADAPTIVE></H></CRS_ALGORITHM></chromaResamplerParams>";
			AUTO_DEVICE_FAMILY  : string  := ""
		);
		port (
			clock              : in  std_logic                     := 'X';
			din_data           : in  std_logic_vector(15 downto 0) := (others => 'X');
			din_endofpacket    : in  std_logic                     := 'X';
			din_ready          : out std_logic;
			din_startofpacket  : in  std_logic                     := 'X';
			din_valid          : in  std_logic                     := 'X';
			dout_data          : out std_logic_vector(23 downto 0);
			dout_endofpacket   : out std_logic;
			dout_ready         : in  std_logic                     := 'X';
			dout_startofpacket : out std_logic;
			dout_valid         : out std_logic;
			reset              : in  std_logic                     := 'X'
		);
	end component DE1_SoC_QSYS_alt_vip_crs_0;

	signal dut_din_ready     : std_logic;                    -- dut:din_ready -> din_tester:data
	signal din_tester_q      : std_logic_vector(0 downto 0); -- din_tester:q -> dut:din_valid
	signal builtin_1_w1_q    : std_logic_vector(0 downto 0); -- ["1", builtin_1_w1:q, "1"] -> [din_tester:ena, dut:dout_ready]
	signal clocksource_clock : std_logic;                    -- clocksource:clock -> [dut:clock, din_tester:clock]
	signal clocksource_reset : std_logic;                    -- clocksource:reset -> din_tester:reset

begin

	builtin_1_w1_q <= "1";

	clocksource : component alt_cusp131_clock_reset
		port map (
			clock => clocksource_clock, -- clock.clk
			reset => clocksource_reset  --      .reset
		);

	dut : component DE1_SoC_QSYS_alt_vip_crs_0
		generic map (
			IN_CHANNELS_IN_PAR  => 2,
			OUT_CHANNELS_IN_PAR => 3,
			PARAMETERISATION    => "<chromaResamplerParams><CRS_NAME>chroma_resampler</CRS_NAME><CRS_BPS>8</CRS_BPS><CRS_WIDTH>720</CRS_WIDTH><CRS_HEIGHT>576</CRS_HEIGHT><CRS_PARALLEL_MODE>true</CRS_PARALLEL_MODE><CRS_RESAMPLING><FORMAT><IN>422</IN><OUT>444</OUT></FORMAT><COSITING><V>true</V><H>true</H></COSITING></CRS_RESAMPLING><CRS_ALGORITHM><V><NAME>INTERPOLATION_1D_NEAREST_NEIGHBOUR</NAME><LUMA_ADAPTIVE>false</LUMA_ADAPTIVE></V><H><NAME>INTERPOLATION_1D_FULL_FILTERING</NAME><LUMA_ADAPTIVE>false</LUMA_ADAPTIVE></H></CRS_ALGORITHM></chromaResamplerParams>",
			AUTO_DEVICE_FAMILY  => "Cyclone V"
		)
		port map (
			clock              => clocksource_clock, -- clock.clk
			reset              => open,              -- reset.reset
			din_ready          => dut_din_ready,     --   din.ready
			din_valid          => din_tester_q(0),   --      .valid
			din_data           => open,              --      .data
			din_startofpacket  => open,              --      .startofpacket
			din_endofpacket    => open,              --      .endofpacket
			dout_ready         => '1',               --  dout.ready
			dout_valid         => open,              --      .valid
			dout_data          => open,              --      .data
			dout_startofpacket => open,              --      .startofpacket
			dout_endofpacket   => open               --      .endofpacket
		);

	din_tester : process (clocksource_clock, clocksource_reset)
	begin
		if clocksource_reset = '1' then
			din_tester_q(0) <= '0';
		elsif clocksource_clock'EVENT and clocksource_clock = '1' and builtin_1_w1_q(0) = '1' then
			din_tester_q(0) <= dut_din_ready;
		end if;
	end process;

end architecture rtl; -- of DE1_SoC_QSYS_alt_vip_crs_0_tb
