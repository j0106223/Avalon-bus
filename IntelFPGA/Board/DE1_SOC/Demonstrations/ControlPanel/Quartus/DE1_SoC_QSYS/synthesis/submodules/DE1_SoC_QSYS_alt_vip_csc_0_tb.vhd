-- DE1_SoC_QSYS_alt_vip_csc_0_tb.vhd


library IEEE;
library altera;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use altera.alt_cusp131_package.all;

entity DE1_SoC_QSYS_alt_vip_csc_0_tb is
end entity DE1_SoC_QSYS_alt_vip_csc_0_tb;

architecture rtl of DE1_SoC_QSYS_alt_vip_csc_0_tb is
	component alt_cusp131_clock_reset is
		port (
			clock : out std_logic;
			reset : out std_logic
		);
	end component alt_cusp131_clock_reset;

	component DE1_SoC_QSYS_alt_vip_csc_0 is
		generic (
			PARAMETERISATION         : string := "<cscParams> <CSC_NAME>a_csc</CSC_NAME> <CSC_CHANNELS_IN_SEQ>3</CSC_CHANNELS_IN_SEQ>  <CSC_CHANNELS_IN_PAR>1</CSC_CHANNELS_IN_PAR>  <CSC_INPUT_OUTPUT_DATATYPES>   <IODT_INPUT_BPS>8</IODT_INPUT_BPS>   <IODT_OUTPUT_BPS>8</IODT_OUTPUT_BPS>   <IODT_INPUT_DATA_TYPE>DATA_TYPE_UNSIGNED</IODT_INPUT_DATA_TYPE>   <IODT_OUTPUT_DATA_TYPE>DATA_TYPE_UNSIGNED</IODT_OUTPUT_DATA_TYPE>   <IODT_USE_INPUT_GUARD_BANDS>false</IODT_USE_INPUT_GUARD_BANDS>   <IODT_INPUT_GUARD_MIN>0</IODT_INPUT_GUARD_MIN>   <IODT_INPUT_GUARD_MAX>255</IODT_INPUT_GUARD_MAX>   <IODT_USE_OUTPUT_GUARD_BANDS>false</IODT_USE_OUTPUT_GUARD_BANDS>   <IODT_OUTPUT_GUARD_MIN>0</IODT_OUTPUT_GUARD_MIN>   <IODT_OUTPUT_GUARD_MAX>255</IODT_OUTPUT_GUARD_MAX>  </CSC_INPUT_OUTPUT_DATATYPES>  <CSC_PREDEFINED_CONVERSION>SDTV_CRGB_TO_YCBCR</CSC_PREDEFINED_CONVERSION>  <CSC_COEFFICIENTS>   <row>    <mult>0.66</mult>    <mult>0.66</mult>    <mult>0.66</mult>    <add>-128</add>   </row>   <row>    <mult>0.66</mult>    <mult>0.66</mult>    <mult>0.66</mult>    <add>-128</add>   </row>   <row>    <mult>0.66</mult>    <mult>0.66</mult>    <mult>0.66</mult>    <add>-128</add>   </row>  </CSC_COEFFICIENTS>  <CSC_COEFF_PRECISION>   <CPC_INTEGER_BITS>0</CPC_INTEGER_BITS>   <CPC_FRACTION_BITS>8</CPC_FRACTION_BITS>   <CPC_COEFFS_SIGNED>true</CPC_COEFFS_SIGNED>  </CSC_COEFF_PRECISION>  <CSC_SUMM_PRECISION>   <CPC_INTEGER_BITS>8</CPC_INTEGER_BITS>   <CPC_FRACTION_BITS>8</CPC_FRACTION_BITS>   <CPC_COEFFS_SIGNED>false</CPC_COEFFS_SIGNED>  </CSC_SUMM_PRECISION>  <CSC_OUTPUT_CONVERSION>   <ODTC_SCALE>0</ODTC_SCALE>   <ODTC_FIXEDPOINT_TO_INTEGER>FRACTION_BITS_ROUND_HALF_UP</ODTC_FIXEDPOINT_TO_INTEGER>   <ODTC_CONVERT_SIGNED_TO_UNSIGNED>CONVERT_TO_UNSIGNED_SATURATE</ODTC_CONVERT_SIGNED_TO_UNSIGNED>  </CSC_OUTPUT_CONVERSION> <CSC_RUNTIME_COEFFICIENTS>false</CSC_RUNTIME_COEFFICIENTS> </cscParams>";
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
	end component DE1_SoC_QSYS_alt_vip_csc_0;

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

	dut : component DE1_SoC_QSYS_alt_vip_csc_0
		generic map (
			PARAMETERISATION         => "<cscParams> <CSC_NAME>a_csc</CSC_NAME> <CSC_CHANNELS_IN_SEQ>1</CSC_CHANNELS_IN_SEQ>  <CSC_CHANNELS_IN_PAR>3</CSC_CHANNELS_IN_PAR>  <CSC_INPUT_OUTPUT_DATATYPES>   <IODT_INPUT_BPS>8</IODT_INPUT_BPS>   <IODT_OUTPUT_BPS>8</IODT_OUTPUT_BPS>   <IODT_INPUT_DATA_TYPE>DATA_TYPE_UNSIGNED</IODT_INPUT_DATA_TYPE>   <IODT_OUTPUT_DATA_TYPE>DATA_TYPE_UNSIGNED</IODT_OUTPUT_DATA_TYPE>   <IODT_USE_INPUT_GUARD_BANDS>true</IODT_USE_INPUT_GUARD_BANDS>   <IODT_INPUT_GUARD_MIN>16</IODT_INPUT_GUARD_MIN>   <IODT_INPUT_GUARD_MAX>240</IODT_INPUT_GUARD_MAX>   <IODT_USE_OUTPUT_GUARD_BANDS>false</IODT_USE_OUTPUT_GUARD_BANDS>   <IODT_OUTPUT_GUARD_MIN>0</IODT_OUTPUT_GUARD_MIN>   <IODT_OUTPUT_GUARD_MAX>255</IODT_OUTPUT_GUARD_MAX>  </CSC_INPUT_OUTPUT_DATATYPES>  <CSC_PREDEFINED_CONVERSION>SDTV_YCBCR_TO_CRGB</CSC_PREDEFINED_CONVERSION>  <CSC_COEFFICIENTS><row><mult>2.018</mult><mult>0.0</mult><mult>1.164</mult><add>-276.928</add></row><row><mult>-0.391</mult><mult>-0.813</mult><mult>1.164</mult><add>135.488</add></row><row><mult>0.0</mult><mult>1.596</mult><mult>1.164</mult><add>-222.912</add></row></CSC_COEFFICIENTS>  <CSC_COEFF_PRECISION>   <CPC_INTEGER_BITS>2</CPC_INTEGER_BITS>   <CPC_FRACTION_BITS>8</CPC_FRACTION_BITS>   <CPC_COEFFS_SIGNED>true</CPC_COEFFS_SIGNED>  </CSC_COEFF_PRECISION>  <CSC_SUMM_PRECISION>   <CPC_INTEGER_BITS>9</CPC_INTEGER_BITS>   <CPC_FRACTION_BITS>8</CPC_FRACTION_BITS>   <CPC_COEFFS_SIGNED>true</CPC_COEFFS_SIGNED>  </CSC_SUMM_PRECISION>  <CSC_OUTPUT_CONVERSION>   <ODTC_SCALE>0</ODTC_SCALE>   <ODTC_FIXEDPOINT_TO_INTEGER>FRACTION_BITS_ROUND_HALF_UP</ODTC_FIXEDPOINT_TO_INTEGER>   <ODTC_CONVERT_SIGNED_TO_UNSIGNED>CONVERT_TO_UNSIGNED_SATURATE</ODTC_CONVERT_SIGNED_TO_UNSIGNED>  </CSC_OUTPUT_CONVERSION> <CSC_RUNTIME_COEFFICIENTS>false</CSC_RUNTIME_COEFFICIENTS> </cscParams>",
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

end architecture rtl; -- of DE1_SoC_QSYS_alt_vip_csc_0_tb
