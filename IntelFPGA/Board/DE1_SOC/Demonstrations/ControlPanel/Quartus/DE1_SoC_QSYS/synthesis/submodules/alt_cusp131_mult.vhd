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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.textio.ALL;

USE altera.ALT_CUSP131_PACKAGE.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY alt_cusp131_mult IS
   GENERIC (  
      NAME         : STRinG := "";
      SIMULATION   : INTEGER := SIMULATION_OFF;
      OPTIMIZED    : INTEGER := OPTIMIZED_ON;
      FAMILY       : INTEGER := FAMILY_STRATIX;    
      WIDTH        : INTEGER := 16;
      WIDTHX2      : INTEGER := 32;
      LATENCY      : INTEGER := 2;
      RESTART      : INTEGER := 1
   );
   PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      ena   : IN STD_LOGIC := '1';   -- Chip enable
    
      a     : IN  STD_LOGIC_VECTOR( WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
      a_en  : IN  STD_LOGIC := '1';
      b     : IN  STD_LOGIC_VECTOR( WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
      signa  : IN  STD_LOGIC                           := '0';
      signb  : IN  STD_LOGIC                           := '0';
      q     : OUT STD_LOGIC_VECTOR( WIDTHx2-1 DOWNTO 0)
   );
END;


ARCHITECTURE rtl OF alt_cusp131_mult IS


    COMPONENT 	hopt_mult_l5 
        PORT (
	clock0 : IN STD_LOGIC := '1';
	ena0 : IN STD_LOGIC := '0';
	dataa : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	datab : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	signb : IN STD_LOGIC := '0';
	signa : IN STD_LOGIC := '0';
	result : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
	);
	END COMPONENT;

    COMPONENT 	hopt_mult_l4 
        PORT (
	clock0 : IN STD_LOGIC := '1';
	ena0 : IN STD_LOGIC := '0';
	dataa : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	datab : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	signb : IN STD_LOGIC := '0';
	signa : IN STD_LOGIC := '0';
	result : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT 	hopt_mult_l3 
        PORT (
	clock0 : IN STD_LOGIC := '1';
	ena0 : IN STD_LOGIC := '0';
	dataa : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	datab : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	signb : IN STD_LOGIC := '0';
	signa : IN STD_LOGIC := '0';
	result : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
	);
	END COMPONENT;
	
    
    COMPONENT altmult_add 
   GENERIC
      (WIDTH_A                               : INTEGER := 1;
      WIDTH_B                                : INTEGER := 1;
      WIDTH_RESULT                           : INTEGER := 1;
      NUMBER_OF_MULTIPLIERS                  : INTEGER := 1;
      INPUT_REGISTER_A0                      : STRING  := "CLOCK0";
      INPUT_ACLR_A0                          : STRING  := "ACLR3";
      INPUT_SOURCE_A0                        : STRING  := "DATAA";
      INPUT_REGISTER_A1                      : STRING  := "CLOCK0";
      INPUT_ACLR_A1                          : STRING  := "ACLR3";
      INPUT_SOURCE_A1                        : STRING  := "DATAA";
      INPUT_REGISTER_A2                      : STRING  := "CLOCK0";
      INPUT_ACLR_A2                          : STRING  := "ACLR3";
      INPUT_SOURCE_A2                        : STRING  := "DATAA";
      INPUT_REGISTER_A3                      : STRING  := "CLOCK0";
      INPUT_ACLR_A3                          : STRING  := "ACLR3";
      INPUT_SOURCE_A3                        : STRING  := "DATAA";
      REPRESENTATION_A                       : STRING  := "UNSIGNED";
      SIGNED_REGISTER_A                      : STRING  := "CLOCK0";
      SIGNED_ACLR_A                          : STRING  := "ACLR3";
      SIGNED_PIPELINE_REGISTER_A             : STRING  := "UNREGISTERED";
      SIGNED_PIPELINE_ACLR_A                 : STRING  := "ACLR3";
      INPUT_REGISTER_B0                      : STRING  := "CLOCK0";
      INPUT_ACLR_B0                          : STRING  := "ACLR3";
      INPUT_SOURCE_B0                        : STRING  := "DATAB";
      INPUT_REGISTER_B1                      : STRING  := "CLOCK0";
      INPUT_ACLR_B1                          : STRING  := "ACLR3";
      INPUT_SOURCE_B1                        : STRING  := "DATAB";
      INPUT_REGISTER_B2                      : STRING  := "CLOCK0";
      INPUT_ACLR_B2                          : STRING  := "ACLR3";
      INPUT_SOURCE_B2                        : STRING  := "DATAB";
      INPUT_REGISTER_B3                      : STRING  := "CLOCK0";
      INPUT_ACLR_B3                          : STRING  := "ACLR3";
      INPUT_SOURCE_B3                        : STRING  := "DATAB";
      REPRESENTATION_B                       : STRING  := "UNSIGNED";
      SIGNED_REGISTER_B                      : STRING  := "CLOCK0";
      SIGNED_ACLR_B                          : STRING  := "ACLR3";
      SIGNED_PIPELINE_REGISTER_B             : STRING  := "UNREGISTERED";
      SIGNED_PIPELINE_ACLR_B                 : STRING  := "ACLR3";
      MULTIPLIER_REGISTER0                   : STRING  := "CLOCK0";
      MULTIPLIER_ACLR0                       : STRING  := "ACLR3";
      MULTIPLIER_REGISTER1                   : STRING  := "CLOCK0";
      MULTIPLIER_ACLR1                       : STRING  := "ACLR3";
      MULTIPLIER_REGISTER2                   : STRING  := "CLOCK0";
      MULTIPLIER_ACLR2                       : STRING  := "ACLR3";
      MULTIPLIER_REGISTER3                   : STRING  := "CLOCK0";
      MULTIPLIER_ACLR3                       : STRING  := "ACLR3";
      ADDNSUB_MULTIPLIER_REGISTER1           : STRING  := "CLOCK0";
      ADDNSUB_MULTIPLIER_ACLR1               : STRING  := "ACLR3";
      ADDNSUB_MULTIPLIER_PIPELINE_REGISTER1  : STRING  := "UNREGISTERED";
      ADDNSUB_MULTIPLIER_PIPELINE_ACLR1      : STRING  := "ACLR3";
      ADDNSUB_MULTIPLIER_REGISTER3           : STRING  := "CLOCK0";
      ADDNSUB_MULTIPLIER_ACLR3               : STRING  := "ACLR3";
      ADDNSUB_MULTIPLIER_PIPELINE_REGISTER3  : STRING  := "UNREGISTERED";
      ADDNSUB_MULTIPLIER_PIPELINE_ACLR3      : STRING  := "ACLR3";
      MULTIPLIER1_DIRECTION                  : STRING  := "ADD";
      MULTIPLIER3_DIRECTION                  : STRING  := "ADD";
      OUTPUT_REGISTER                        : STRING  := "CLOCK0";
      OUTPUT_ACLR                            : STRING  := "ACLR0";
      -- Added this to remove the failure in simulation when the component is used on V series devices.
      -- Tracked by FB case 70560
      PORT_ADDNSUB1                          : STRING  := "PORT_UNUSED";
      PORT_ADDNSUB3                          : STRING  := "PORT_UNUSED";
      SYSTOLIC_DELAY1                        : STRING  := "UNREGISTERED";
		SYSTOLIC_DELAY3                        : STRING  := "UNREGISTERED";
--      MULTIPLIER01_ROUNDING                  : STRING  := "NO";
--      MULTIPLIER01_SATURATION                : STRING  := "NO";
--      MULTIPLIER23_ROUNDING                  : STRING  := "NO";
--      MULTIPLIER23_SATURATION                : STRING  := "NO";
--      ADDER1_ROUNDING                        : STRING  := "NO";
--      ADDER3_ROUNDING                        : STRING  := "NO";
--      ADDER1_SATURATION                      : STRING  := "NO";
--      ADDER3_SATURATION                      : STRING  := "NO";
--      PORT_MULT0_IS_SATURATED                : STRING  := "UNUSED";
--      PORT_MULT1_IS_SATURATED                : STRING  := "UNUSED";
--      PORT_MULT2_IS_SATURATED                : STRING  := "UNUSED";
--      PORT_MULT3_IS_SATURATED                : STRING  := "UNUSED";
      EXTRA_LATENCY                          : INTEGER := 0;
      DEDICATED_MULTIPLIER_CIRCUITRY         : STRING  := "AUTO";
      DSP_BLOCK_BALANCING                    : STRING  := "AUTO";
      LPM_HINT                               : STRING  := "UNUSED";
      LPM_TYPE                               : STRING  := "ALTMULT_ADD";
      INTENDED_DEVICE_FAMILY                 : STRING  := "STRATIX");

   PORT (dataa                                   : IN STD_LOGIC_VECTOR(NUMBER_OF_MULTIPLIERS * WIDTH_A -1 DOWNTO 0);
        datab                                    : IN STD_LOGIC_VECTOR(NUMBER_OF_MULTIPLIERS * WIDTH_B -1 DOWNTO 0);
        signa                                    : IN STD_LOGIC := '0';
        signb                                    : IN STD_LOGIC := '0';
        clock0                                   :  IN STD_LOGIC := '1';
        ena0                                     : IN STD_LOGIC := '1';
        result                                   : OUT STD_LOGIC_VECTOR(WIDTH_RESULT -1 DOWNTO 0)
        );

END COMPONENT;
    
  SIGNAL result  : STD_LOGIC_VECTOR ((2*WIDTH)-1 DOWNTO 0);

  SIGNAL enable : STD_LOGIC;
  type shift_reg is array (0 to LATENCY-1) of STD_LOGIC;
  SIGNAL mult_res_en : shift_reg;

  SIGNAL  q_int     :  STD_LOGIC_VECTOR( (2*WIDTH)-1 DOWNTO 0);

BEGIN

    latencyx_gen: ASSERT LATENCY < 4 
						OR (WIDTH = 24 AND FAMILY = FAMILY_CYCLONEII  AND LATENCY < 6)
						REPORT "Only 0, 1, 2, or 3 clock cycle latencies are allowed on multiplier" SEVERITY failure;
    
    mult_res_en_reg_1: if LATENCY > 1 generate                        
        PROCESS (clock, reset)
        BEGIN
            IF reset = '1' THEN
                mult_res_en(1) <= '0';
            ELSIF Rising_edge(clock) THEN
                IF ena = '1' THEN
                    mult_res_en(1) <= a_en; 
                END IF;
            END IF;
        END PROCESS;
    end generate;       
          
    mult_res_en_resg: if LATENCY > 2 generate
        mult_res_en_regs_shift: for I in 2 to LATENCY-1 generate
            PROCESS (clock, reset)
            BEGIN
                IF reset = '1' THEN
                    mult_res_en(I) <= '0';
                ELSIF Rising_edge(clock) THEN
                    IF ena = '1' THEN
                        mult_res_en(I) <= mult_res_en(I-1); 
                    END IF;
                END IF;
            END PROCESS;  
        end generate;
    end generate;

    latency7_gen: IF  LATENCY = 7 GENERATE
      enable_comb_latency7 :  enable <= ena and ( a_en or mult_res_en(1) or mult_res_en(2) or mult_res_en(3) or mult_res_en(4) or mult_res_en(5) or mult_res_en(6));
    END GENERATE;


    latency6_gen: IF  LATENCY = 6 GENERATE
      enable_comb_latency6 :  enable <= ena and ( a_en or mult_res_en(1) or mult_res_en(2) or mult_res_en(3) or mult_res_en(4) or mult_res_en(5));
    END GENERATE;

    latency5_gen: IF  LATENCY = 5 GENERATE
      enable_comb_latency5 :  enable <= ena and ( a_en or mult_res_en(1) or mult_res_en(2) or mult_res_en(3) or mult_res_en(4));
    END GENERATE;

    latency4_gen: IF  LATENCY = 4 GENERATE
      enable_comb_latency4 :  enable <= ena and ( a_en or mult_res_en(1) or mult_res_en(2) or mult_res_en(3));
    END GENERATE;
       
    latency3_gen: IF  LATENCY = 3 GENERATE
      enable_comb_latency3 :  enable <= ena and ( a_en or mult_res_en(1) or mult_res_en(2));
    END GENERATE;
    
    latency2_gen: IF  LATENCY = 2 GENERATE
      enable_comb_latency2 :  enable <= ena and ( a_en or mult_res_en(1));
    END GENERATE;
      
    latency1_gen: IF  LATENCY = 1 GENERATE
        mult_res_en_latency1: enable <= ena and a_en;
    END GENERATE;
  
    q_int_drive:     q_int <= result;
    q_drive:         q     <= q_int;
      
      altera_24bit_l5_cycloneii : IF LATENCY = 5 AND WIDTH = 24 AND FAMILY = FAMILY_CYCLONEII GENERATE
          altmult_add_COMPONENT : hopt_mult_l5
          PORT MAP
          (
              dataa => a,
              datab => b,
              signa => signa,
              signb => signb,
              clock0 => clock,
              --aclr3 => reset,
              ena0 => enable,
              result => result
          );
      END GENERATE;
      
      altera_24bit_l4_cycloneii : IF LATENCY = 4 AND WIDTH = 24 AND FAMILY = FAMILY_CYCLONEII GENERATE
          altmult_add_COMPONENT : hopt_mult_l4
          PORT MAP
          (
              dataa => a,
              datab => b,
              signa => signa,
              signb => signb,
              clock0 => clock,
              --aclr3 => reset,
              ena0 => enable,
              result => result
          );
      END GENERATE;
      
      altera_24bit_l3_cycloneii : IF LATENCY = 3 AND WIDTH = 24 AND FAMILY = FAMILY_CYCLONEII GENERATE
          altmult_add_COMPONENT : hopt_mult_l3
          PORT MAP
          (
              dataa => a,
              datab => b,
              signa => signa,
              signb => signb,
              clock0 => clock,
              --aclr3 => reset,
              ena0 => enable,
              result => result
          );
      END GENERATE;
      
      
      
      
      altera_latency0_gen : IF LATENCY = 0 GENERATE
          altmult_add_COMPONENT : altmult_add
          GENERIC MAP
          (
              WIDTH_A => WIDTH,
              WIDTH_B => WIDTH,
              WIDTH_RESULT => WIDTHX2,
              NUMBER_OF_MULTIPLIERS => 1,
              INPUT_REGISTER_A0  => "UNREGISTERED",
              INPUT_REGISTER_B0  => "UNREGISTERED",
              SIGNED_REGISTER_A => "UNREGISTERED",
              MULTIPLIER_REGISTER0 => "UNREGISTERED",
              OUTPUT_REGISTER => "UNREGISTERED",
              DEDICATED_MULTIPLIER_CIRCUITRY => "YES",
              EXTRA_LATENCY => 0
          )
          PORT MAP
          (
              dataa => a,
              datab => b,
              signa => signa,
              signb => signb,
              result => result
          );
      END GENERATE;
      
      altera_latency1_gen : IF LATENCY = 1 GENERATE
          altmult_add_COMPONENT : altmult_add
          GENERIC MAP
          (
              WIDTH_A => WIDTH,
              WIDTH_B => WIDTH,
              WIDTH_RESULT => WIDTHX2,
              NUMBER_OF_MULTIPLIERS => 1,
              INPUT_REGISTER_A0  => "CLOCK0",
              --INPUT_ACLR_A0  => "ACLR3",
              INPUT_REGISTER_B0  => "CLOCK0",
              --INPUT_ACLR_B0  => "ACLR3",
              SIGNED_REGISTER_A => "CLOCK0",
              --SIGNED_ACLR_A => "ACLR3",
              MULTIPLIER_REGISTER0 => "UNREGISTERED",
              OUTPUT_REGISTER => "UNREGISTERED",
              DEDICATED_MULTIPLIER_CIRCUITRY => "YES",
              EXTRA_LATENCY => 0
          )
          PORT MAP
          (
              dataa => a,
              datab => b,
              signa => signa,
              signb => signb,
              clock0 => clock,
              --aclr3 => reset,
              ena0 => enable,
              result => result
          );
      END GENERATE;
      
      
      
      
      altera_latency2_gen : IF LATENCY = 2 GENERATE
          altmult_add_COMPONENT : altmult_add
          GENERIC MAP
          (
              WIDTH_A => WIDTH,
              WIDTH_B => WIDTH,
              WIDTH_RESULT => WIDTHX2,
              NUMBER_OF_MULTIPLIERS => 1,
              INPUT_REGISTER_A0  => "CLOCK0",
              --INPUT_ACLR_A0  => "ACLR3",
              INPUT_REGISTER_B0  => "CLOCK0",
              --INPUT_ACLR_B0  => "ACLR3",
              SIGNED_REGISTER_A => "CLOCK0",
              --SIGNED_ACLR_A => "ACLR3",
              MULTIPLIER_REGISTER0 => "UNREGISTERED",
              OUTPUT_REGISTER => "CLOCK0",
              --OUTPUT_ACLR => "ACLR3",
              DEDICATED_MULTIPLIER_CIRCUITRY => "YES",
              EXTRA_LATENCY => 0
          )
          PORT MAP
          (
              dataa => a,
              datab => b,
              signa => signa,
              signb => signb,
              clock0 => clock,
              --aclr3 => reset,
              ena0 => enable,
              result => result
          );
      END GENERATE;
      
      altera_latency3_gen : IF LATENCY = 3 AND ( WIDTH = 24 NAND FAMILY = FAMILY_CYCLONEII)  GENERATE
          altmult_add_COMPONENT : altmult_add
          GENERIC MAP
          (
              WIDTH_A => WIDTH,
              WIDTH_B => WIDTH,
              WIDTH_RESULT => WIDTHX2,
              NUMBER_OF_MULTIPLIERS => 1,
              INPUT_REGISTER_A0  => "CLOCK0",
              --INPUT_ACLR_A0  => "ACLR3",
              INPUT_REGISTER_B0  => "CLOCK0",
              --INPUT_ACLR_B0  => "ACLR3",
              SIGNED_REGISTER_A => "CLOCK0",
              --SIGNED_ACLR_A => "ACLR3",
              MULTIPLIER_REGISTER0 => "CLOCK0",
              --MULTIPLIER_ACLR0 => "ACLR3",
              OUTPUT_REGISTER => "CLOCK0",
              --OUTPUT_ACLR => "ACLR3",
              DEDICATED_MULTIPLIER_CIRCUITRY => "YES",
              EXTRA_LATENCY => 0
          )
          PORT MAP
          (
              dataa => a,
              datab => b,
              signa => signa,
              signb => signb,
              clock0 => clock,
              --aclr3 => reset,
              ena0 => enable,
              result => result
          );
      END GENERATE;

END;
