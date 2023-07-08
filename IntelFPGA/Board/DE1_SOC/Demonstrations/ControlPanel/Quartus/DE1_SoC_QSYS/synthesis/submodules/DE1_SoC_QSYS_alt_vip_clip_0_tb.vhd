-- DE1_SoC_QSYS_alt_vip_clip_0_tb.vhd


library IEEE;
library altera;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use altera.alt_cusp131_package.all;

entity DE1_SoC_QSYS_alt_vip_clip_0_tb is
end entity DE1_SoC_QSYS_alt_vip_clip_0_tb;

architecture rtl of DE1_SoC_QSYS_alt_vip_clip_0_tb is
	component alt_cusp131_clock_reset is
		port (
			clock : out std_logic;
			reset : out std_logic
		);
	end component alt_cusp131_clock_reset;

	component DE1_SoC_QSYS_alt_vip_clip_0 is
		generic (
			PARAMETERISATION         : string := "<clipperParams><CLIP_NAME>clipper</CLIP_NAME><CLIP_BPS>8</CLIP_BPS><CLIP_CHANNELS_IN_SEQ>3</CLIP_CHANNELS_IN_SEQ><CLIP_CHANNELS_IN_PAR>1</CLIP_CHANNELS_IN_PAR><CLIP_WIDTH>640</CLIP_WIDTH><CLIP_HEIGHT>480</CLIP_HEIGHT><CLIP_RUNTIME_CONTROL>false</CLIP_RUNTIME_CONTROL><CLIP_OFFSETS_NOT_RECTANGLE>true</CLIP_OFFSETS_NOT_RECTANGLE><CLIP_LEFT_OFFSET>10</CLIP_LEFT_OFFSET><CLIP_RIGHT_OFFSET>10</CLIP_RIGHT_OFFSET><CLIP_TOP_OFFSET>10</CLIP_TOP_OFFSET><CLIP_BOTTOM_OFFSET>10</CLIP_BOTTOM_OFFSET></clipperParams>";
			AUTO_DEVICE_FAMILY       : string := "";
			AUTO_CONTROL_CLOCKS_SAME : string := "0"
		);
		port (
			clock              : in  std_logic                     := 'X';
			din_data           : in  std_logic_vector(23 downto 0) := (others => 'X');
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
	end component DE1_SoC_QSYS_alt_vip_clip_0;

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

	dut : component DE1_SoC_QSYS_alt_vip_clip_0
		generic map (
			PARAMETERISATION         => "<clipperParams><CLIP_NAME>clipper</CLIP_NAME><CLIP_BPS>8</CLIP_BPS><CLIP_CHANNELS_IN_SEQ>1</CLIP_CHANNELS_IN_SEQ><CLIP_CHANNELS_IN_PAR>3</CLIP_CHANNELS_IN_PAR><CLIP_WIDTH>720</CLIP_WIDTH><CLIP_HEIGHT>576</CLIP_HEIGHT><CLIP_RUNTIME_CONTROL>false</CLIP_RUNTIME_CONTROL><CLIP_OFFSETS_NOT_RECTANGLE>false</CLIP_OFFSETS_NOT_RECTANGLE><CLIP_LEFT_OFFSET>40</CLIP_LEFT_OFFSET><CLIP_RIGHT_OFFSET>640</CLIP_RIGHT_OFFSET><CLIP_TOP_OFFSET>24</CLIP_TOP_OFFSET><CLIP_BOTTOM_OFFSET>480</CLIP_BOTTOM_OFFSET></clipperParams>",
			AUTO_DEVICE_FAMILY       => "Cyclone V",
			AUTO_CONTROL_CLOCKS_SAME => "0"
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

end architecture rtl; -- of DE1_SoC_QSYS_alt_vip_clip_0_tb
