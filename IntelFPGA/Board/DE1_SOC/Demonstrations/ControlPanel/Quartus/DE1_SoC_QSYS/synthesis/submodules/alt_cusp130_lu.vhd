-- Legal Notice: (C)2006 Altera Corporation. All rights reserved.  Your
-- use of Altera Corporation's design tools, logic functions and other
-- software and tools, and its AMPP partner logic functions, and any
-- output files any of the foregoing (including device programming or
-- simulation files), and any associated documentation or information are
-- expressly subject to the terms and conditions of the Altera Program
-- License Subscription Agreement or other applicable license agreement,
-- including, without limitation, that your use is for the sole purpose
-- of programming logic devices manufactured by Altera and sold by Altera
-- or its authorized distributors.  Please refer to the applicable
-- agreement for further details.



LIBRARY IEEE, ALTERA;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.textio.ALL;
USE altera.ALT_CUSP130_PACKAGE.ALL;

ENTITY alt_cusp130_lu IS
  GENERIC (
        NAME         : STRING := "";
        SIMULATION   : INTEGER := SIMULATION_OFF;
        OPTIMIZED    : INTEGER := OPTIMIZED_ON;
        FAMILY       : INTEGER := FAMILY_STRATIX;
        WIDTH : INTEGER := 16
  );
  PORT (
      a        : IN STD_LOGIC_VECTOR( WIDTH-1 DOWNTO 0) := (others=>'0');
      b        : IN STD_LOGIC_VECTOR( WIDTH-1 DOWNTO 0) := (others=>'0');
      andNor   : IN STD_LOGIC := '0';
      invert   : IN STD_LOGIC := '0';
      q        : OUT STD_LOGIC_VECTOR( WIDTH-1 DOWNTO 0)
  );
END ENTITY;


ARCHITECTURE rtl OF alt_cusp130_lu IS

  signal q_and_or : STD_LOGIC_VECTOR( WIDTH-1 DOWNTO 0);
  signal q_int : STD_LOGIC_VECTOR( WIDTH-1 DOWNTO 0);
  
BEGIN

q_and_or_comb: with andNor select 
	q_and_or <= a and b when '1', a or b when others;
                
q_int_comb: with invert select
     q_int <= not ( q_and_or ) when '1', q_and_or when others;

q_drive:  q <= q_int;

END ARCHITECTURE;
