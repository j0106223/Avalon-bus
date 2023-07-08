-- DE1_SoC_QSYS_alt_vip_dil_0_tb.vhd


library IEEE;
library altera;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use altera.alt_cusp131_package.all;

entity DE1_SoC_QSYS_alt_vip_dil_0_tb is
end entity DE1_SoC_QSYS_alt_vip_dil_0_tb;

architecture rtl of DE1_SoC_QSYS_alt_vip_dil_0_tb is
	component alt_cusp131_clock_reset is
		port (
			clock : out std_logic;
			reset : out std_logic
		);
	end component alt_cusp131_clock_reset;

	component DE1_SoC_QSYS_alt_vip_dil_0 is
		generic (
			MOTION_MASTERS_REQUIRED                      : integer := 0;
			READ_MASTERS_REQUIRED                        : integer := 0;
			WRITE_MASTERS_REQUIRED                       : integer := 0;
			PARAMETERISATION                             : string  := "<deinterlacerParams><DIL_NAME>my_deinterlacing_core</DIL_NAME><DIL_MAX_WIDTH>640</DIL_MAX_WIDTH><DIL_MAX_HEIGHT>480</DIL_MAX_HEIGHT><DIL_CHANNELS_IN_SEQ>3</DIL_CHANNELS_IN_SEQ><DIL_CHANNELS_IN_PAR>1</DIL_CHANNELS_IN_PAR><DIL_BPS>8</DIL_BPS><DIL_METHOD>DEINTERLACING_BOB_SCANLINE_DUPLICATION</DIL_METHOD><DIL_FRAMEBUFFERS_ADDR>00</DIL_FRAMEBUFFERS_ADDR><DIL_PRODUCE_FIELDS>DEINTERLACING_F0</DIL_PRODUCE_FIELDS><DIL_BUFFER_AS_THOUGH>DEINTERLACING_NO_BUFFERING</DIL_BUFFER_AS_THOUGH><DIL_DEFAULT_INITIAL_FIELD>FIELD_F0_FIRST</DIL_DEFAULT_INITIAL_FIELD><DIL_MASTER_PORT_WIDTH>64</DIL_MASTER_PORT_WIDTH><DIL_MEM_MASTERS_USE_SEPARATE_CLOCK>0</DIL_MEM_MASTERS_USE_SEPARATE_CLOCK><DIL_EDGE_DEPENDENT_INTERPOLATION>1</DIL_EDGE_DEPENDENT_INTERPOLATION><DIL_MOTION_BLEED>0</DIL_MOTION_BLEED><DIL_RDATA_FIFO_DEPTH>64</DIL_RDATA_FIFO_DEPTH><DIL_RDATA_BURST_TARGET>32</DIL_RDATA_BURST_TARGET><DIL_WDATA_FIFO_DEPTH>64</DIL_WDATA_FIFO_DEPTH><DIL_WDATA_BURST_TARGET>32</DIL_WDATA_BURST_TARGET><DIL_MAX_NUMBER_PACKETS>1</DIL_MAX_NUMBER_PACKETS><DIL_MAX_SYMBOLS_IN_PACKET>10</DIL_MAX_SYMBOLS_IN_PACKET><DIL_MA_RUNTIME_CTRL>0</DIL_MA_RUNTIME_CTRL><DIL_PROPAGATE_PROGRESSIVE>0</DIL_PROPAGATE_PROGRESSIVE><DIL_CONTROLLED_DROP_REPEAT>0</DIL_CONTROLLED_DROP_REPEAT><DIL_MA_422>0</DIL_MA_422><DIL_BURST_ALIGNMENT>0</DIL_BURST_ALIGNMENT></deinterlacerParams>";
			AUTO_DEVICE_FAMILY                           : string  := "";
			AUTO_KER_WRITER_CONTROL_CLOCKS_SAME          : string  := "0";
			AUTO_MA_CONTROL_CLOCKS_SAME                  : string  := "0";
			AUTO_MOTION_READ_MASTER_CLOCKS_SAME          : string  := "0";
			AUTO_MOTION_READ_MASTER_INTERRUPT_USED_MASK  : string  := "-1";
			AUTO_MOTION_READ_MASTER_MAX_READ_LATENCY     : string  := "2";
			AUTO_MOTION_READ_MASTER_NEED_ADDR_WIDTH      : string  := "62";
			AUTO_MOTION_WRITE_MASTER_CLOCKS_SAME         : string  := "0";
			AUTO_MOTION_WRITE_MASTER_INTERRUPT_USED_MASK : string  := "-1";
			AUTO_MOTION_WRITE_MASTER_MAX_READ_LATENCY    : string  := "2";
			AUTO_MOTION_WRITE_MASTER_NEED_ADDR_WIDTH     : string  := "62";
			AUTO_READ_MASTER_CLOCKS_SAME                 : string  := "0";
			AUTO_READ_MASTER_INTERRUPT_USED_MASK         : string  := "-1";
			AUTO_READ_MASTER_MAX_READ_LATENCY            : string  := "2";
			AUTO_READ_MASTER_NEED_ADDR_WIDTH             : string  := "62";
			AUTO_WRITE_MASTER_CLOCKS_SAME                : string  := "0";
			AUTO_WRITE_MASTER_INTERRUPT_USED_MASK        : string  := "-1";
			AUTO_WRITE_MASTER_MAX_READ_LATENCY           : string  := "2";
			AUTO_WRITE_MASTER_NEED_ADDR_WIDTH            : string  := "62"
		);
		port (
			clock              : in  std_logic                     := 'X';
			din_data           : in  std_logic_vector(15 downto 0) := (others => 'X');
			din_endofpacket    : in  std_logic                     := 'X';
			din_ready          : out std_logic;
			din_startofpacket  : in  std_logic                     := 'X';
			din_valid          : in  std_logic                     := 'X';
			dout_data          : out std_logic_vector(15 downto 0);
			dout_endofpacket   : out std_logic;
			dout_ready         : in  std_logic                     := 'X';
			dout_startofpacket : out std_logic;
			dout_valid         : out std_logic;
			reset              : in  std_logic                     := 'X'
		);
	end component DE1_SoC_QSYS_alt_vip_dil_0;

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

	dut : component DE1_SoC_QSYS_alt_vip_dil_0
		generic map (
			MOTION_MASTERS_REQUIRED                      => 0,
			READ_MASTERS_REQUIRED                        => 0,
			WRITE_MASTERS_REQUIRED                       => 0,
			PARAMETERISATION                             => "<deinterlacerParams><DIL_NAME>my_deinterlacing_core</DIL_NAME><DIL_MAX_WIDTH>720</DIL_MAX_WIDTH><DIL_MAX_HEIGHT>576</DIL_MAX_HEIGHT><DIL_CHANNELS_IN_SEQ>1</DIL_CHANNELS_IN_SEQ><DIL_CHANNELS_IN_PAR>2</DIL_CHANNELS_IN_PAR><DIL_BPS>8</DIL_BPS><DIL_METHOD>DEINTERLACING_BOB_SCANLINE_INTERPOLATION</DIL_METHOD><DIL_FRAMEBUFFERS_ADDR>00</DIL_FRAMEBUFFERS_ADDR><DIL_PRODUCE_FIELDS>DEINTERLACING_F0</DIL_PRODUCE_FIELDS><DIL_BUFFER_AS_THOUGH>DEINTERLACING_NO_BUFFERING</DIL_BUFFER_AS_THOUGH><DIL_DEFAULT_INITIAL_FIELD>FIELD_F0_FIRST</DIL_DEFAULT_INITIAL_FIELD><DIL_MASTER_PORT_WIDTH>64</DIL_MASTER_PORT_WIDTH><DIL_MEM_MASTERS_USE_SEPARATE_CLOCK>0</DIL_MEM_MASTERS_USE_SEPARATE_CLOCK><DIL_EDGE_DEPENDENT_INTERPOLATION>1</DIL_EDGE_DEPENDENT_INTERPOLATION><DIL_MOTION_BLEED>0</DIL_MOTION_BLEED><DIL_RDATA_FIFO_DEPTH>64</DIL_RDATA_FIFO_DEPTH><DIL_RDATA_BURST_TARGET>32</DIL_RDATA_BURST_TARGET><DIL_WDATA_FIFO_DEPTH>64</DIL_WDATA_FIFO_DEPTH><DIL_WDATA_BURST_TARGET>32</DIL_WDATA_BURST_TARGET><DIL_MAX_NUMBER_PACKETS>1</DIL_MAX_NUMBER_PACKETS><DIL_MAX_SYMBOLS_IN_PACKET>10</DIL_MAX_SYMBOLS_IN_PACKET><DIL_MA_RUNTIME_CTRL>0</DIL_MA_RUNTIME_CTRL><DIL_PROPAGATE_PROGRESSIVE>false</DIL_PROPAGATE_PROGRESSIVE><DIL_CONTROLLED_DROP_REPEAT>0</DIL_CONTROLLED_DROP_REPEAT><DIL_MA_422>0</DIL_MA_422><DIL_BURST_ALIGNMENT>0</DIL_BURST_ALIGNMENT></deinterlacerParams>",
			AUTO_DEVICE_FAMILY                           => "Cyclone V",
			AUTO_KER_WRITER_CONTROL_CLOCKS_SAME          => "0",
			AUTO_MA_CONTROL_CLOCKS_SAME                  => "0",
			AUTO_MOTION_READ_MASTER_CLOCKS_SAME          => "0",
			AUTO_MOTION_READ_MASTER_INTERRUPT_USED_MASK  => "-1",
			AUTO_MOTION_READ_MASTER_MAX_READ_LATENCY     => "2",
			AUTO_MOTION_READ_MASTER_NEED_ADDR_WIDTH      => "62",
			AUTO_MOTION_WRITE_MASTER_CLOCKS_SAME         => "0",
			AUTO_MOTION_WRITE_MASTER_INTERRUPT_USED_MASK => "-1",
			AUTO_MOTION_WRITE_MASTER_MAX_READ_LATENCY    => "2",
			AUTO_MOTION_WRITE_MASTER_NEED_ADDR_WIDTH     => "62",
			AUTO_READ_MASTER_CLOCKS_SAME                 => "0",
			AUTO_READ_MASTER_INTERRUPT_USED_MASK         => "-1",
			AUTO_READ_MASTER_MAX_READ_LATENCY            => "2",
			AUTO_READ_MASTER_NEED_ADDR_WIDTH             => "62",
			AUTO_WRITE_MASTER_CLOCKS_SAME                => "0",
			AUTO_WRITE_MASTER_INTERRUPT_USED_MASK        => "-1",
			AUTO_WRITE_MASTER_MAX_READ_LATENCY           => "2",
			AUTO_WRITE_MASTER_NEED_ADDR_WIDTH            => "62"
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

end architecture rtl; -- of DE1_SoC_QSYS_alt_vip_dil_0_tb
