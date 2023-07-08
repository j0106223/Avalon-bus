-- DE1_SoC_QSYS_alt_vip_tpg_0_tb.vhd


library IEEE;
library altera;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use altera.alt_cusp130_package.all;

entity DE1_SoC_QSYS_alt_vip_tpg_0_tb is
end entity DE1_SoC_QSYS_alt_vip_tpg_0_tb;

architecture rtl of DE1_SoC_QSYS_alt_vip_tpg_0_tb is
	component alt_cusp130_clock_reset is
		port (
			clock : out std_logic;
			reset : out std_logic
		);
	end component alt_cusp130_clock_reset;

	component DE1_SoC_QSYS_alt_vip_tpg_0 is
		generic (
			CHANNELS_IN_PAR          : integer := 1;
			CTRL_INTERFACE_DEPTH     : integer := 10;
			PARAMETERISATION         : string  := "<testPatternGeneratorParams><TPG_NAME>MyPatternGenerator</TPG_NAME><TPG_RUNTIME_CONTROL>0</TPG_RUNTIME_CONTROL><TPG_BPS>8</TPG_BPS><TPG_MAX_WIDTH>640</TPG_MAX_WIDTH><TPG_MAX_HEIGHT>480</TPG_MAX_HEIGHT><TPG_COLORSPACE>COLORSPACE_RGB</TPG_COLORSPACE><TPG_FORMAT>SAMPLE_444</TPG_FORMAT><TPG_INTERLACE>PROGRESSIVE_FRAMES</TPG_INTERLACE><TPG_PARALLEL_MODE>0</TPG_PARALLEL_MODE></testPatternGeneratorParams>";
			AUTO_DEVICE_FAMILY       : string  := "";
			AUTO_CONTROL_CLOCKS_SAME : string  := "0"
		);
		port (
			clock              : in  std_logic                     := 'X';
			dout_data          : out std_logic_vector(23 downto 0);
			dout_endofpacket   : out std_logic;
			dout_ready         : in  std_logic                     := 'X';
			dout_startofpacket : out std_logic;
			dout_valid         : out std_logic;
			reset              : in  std_logic                     := 'X'
		);
	end component DE1_SoC_QSYS_alt_vip_tpg_0;

	signal clocksource_clock : std_logic; -- clocksource:clock -> dut:clock

begin

	clocksource : component alt_cusp130_clock_reset
		port map (
			clock => clocksource_clock, -- clock.clk
			reset => open               --      .reset
		);

	dut : component DE1_SoC_QSYS_alt_vip_tpg_0
		generic map (
			CHANNELS_IN_PAR          => 3,
			CTRL_INTERFACE_DEPTH     => 10,
			PARAMETERISATION         => "<testPatternGeneratorParams><TPG_NAME>MyPatternGenerator</TPG_NAME><TPG_RUNTIME_CONTROL>0</TPG_RUNTIME_CONTROL><TPG_BPS>8</TPG_BPS><TPG_MAX_WIDTH>1024</TPG_MAX_WIDTH><TPG_MAX_HEIGHT>768</TPG_MAX_HEIGHT><TPG_COLORSPACE>COLORSPACE_RGB</TPG_COLORSPACE><TPG_FORMAT>SAMPLE_444</TPG_FORMAT><TPG_INTERLACE>PROGRESSIVE_FRAMES</TPG_INTERLACE><TPG_PARALLEL_MODE>true</TPG_PARALLEL_MODE><TPG_PATTERN>TPG_PATTERN_COLORBARS</TPG_PATTERN><TPG_UNIFORM_VAL_C1>128</TPG_UNIFORM_VAL_C1><TPG_UNIFORM_VAL_C2>128</TPG_UNIFORM_VAL_C2><TPG_UNIFORM_VAL_C3>128</TPG_UNIFORM_VAL_C3></testPatternGeneratorParams>",
			AUTO_DEVICE_FAMILY       => "Cyclone V",
			AUTO_CONTROL_CLOCKS_SAME => "0"
		)
		port map (
			clock              => clocksource_clock, -- clock.clk
			reset              => open,              -- reset.reset
			dout_ready         => '1',               --  dout.ready
			dout_valid         => open,              --      .valid
			dout_data          => open,              --      .data
			dout_startofpacket => open,              --      .startofpacket
			dout_endofpacket   => open               --      .endofpacket
		);

end architecture rtl; -- of DE1_SoC_QSYS_alt_vip_tpg_0_tb
