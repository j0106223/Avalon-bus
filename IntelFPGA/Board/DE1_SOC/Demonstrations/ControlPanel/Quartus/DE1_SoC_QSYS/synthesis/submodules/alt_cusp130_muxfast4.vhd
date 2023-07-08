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

--------------------------------------------------------------------------
--   This Verilog file was developed by Altera Corporation.  It may be
-- freely copied and/or distributed at no cost.  Any persons using this
-- file for any purpose do so at their own risk, and are responsible for
-- the results of such use.  Altera Corporation does not guarantee that
-- this file is complete, correct, or fit for any particular purpose.
-- NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED.  This notice must
-- accompany any copy of this file.
--
--------------------------------------------------------------------------
--
-- Bus of 4:1 Muxes (clustered into LABs using register-cascades)
--
-- (Stratix support only)
--
--------------------------------------------------------------------------
-- Version 1.0                Date 12/May/03            pmetzgen
--
--------------------------------------------------------------------------

LIBRARY IEEE, ALTERA, STRATIX;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE altera.ALT_CUSP130_PACKAGE.ALL;
 -- synopsys synthesis_off
USE STRATIX.stratix_components.all;
USE STRATIX.all;
 -- synopsys synthesis_on
 
ENTITY alt_cusp130_muxfast4_i IS
GENERIC (
  LPM_TYPE : STRING := "alt_cusp_muxfast4_i";
    LPM_SIM : INTEGER := SIMULATION_OFF;      -- use faster simulation model
  LAB_START : STRING := "TRUE"
);
PORT (
  sclr : IN STD_LOGIC;      -- for register cascade chain
  regcascin : IN STD_LOGIC;   -- for register cascade chain
  regcascout : OUT STD_LOGIC;   -- for register cascade chain

  sel_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
  data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  
  mux_out : OUT STD_LOGIC
);
END;


ARCHITECTURE rtl OF alt_cusp130_muxfast4_i IS

  COMPONENT stratix_lcell
  GENERIC (
    operation_mode    : string := "normal";
    synch_mode : string := "off";
    register_cascade_mode   : string := "off";
    sum_lutc_input : string := "datac";
    lut_mask       : string := "ffff";
    power_up : string := "low";
    cin0_used       : string := "false";
    cin1_used       : string := "false";
    cin_used       : string := "false";
    output_mode       : string := "comb_only";
    lpm_type : string := "stratix_lcell"
  );
  PORT (
    -- synopsys synthesis_off
    devclrn : in std_logic := '1';
    devpor  : in std_logic := '1';
    -- synopsys synthesis_on
    clk     : in std_logic := '0';
    dataa     : in std_logic := '1';
    datab     : in std_logic := '1';
    datac     : in std_logic := '1';
    datad     : in std_logic := '1';
    aclr    : in std_logic := '0';
    aload    : in std_logic := '0';
    sclr : in std_logic := '0';
    sload : in std_logic := '0';
    ena : in std_logic := '1';
    cin   : in std_logic := '0';
    cin0   : in std_logic := '0';
    cin1   : in std_logic := '1';
    inverta     : in std_logic := '0';
    regcascin     : in std_logic := '0';
    combout   : out std_logic;
    regout    : out std_logic;
    cout  : out std_logic;
    cout0  : out std_logic;
    cout1  : out std_logic
  );
  END COMPONENT;

  SIGNAL CascChain, RegCascChain : STD_LOGIC;

BEGIN

  synth_g : IF (LPM_SIM = SIMULATION_OFF) GENERATE

    regcascchain_start_gen :
    IF LAB_START = "TRUE" GENERATE
  
      mux4to1a_lc : stratix_lcell
      ----------------------------------
      -- if b=0 then if a=0 then c
      --            else d
      --      else a
      ----------------------------------
      -- D C B A  Z
      ----------------------------------
      -- 0 0 0 0  0 
      -- 0 0 0 1  0
      -- 0 0 1 0  0
      -- 0 0 1 1  1
      -- 0 1 0 0  1
      -- 0 1 0 1  0
      -- 0 1 1 0  0
      -- 0 1 1 1  1 => 98 (LOW BYTE)
      ----------
      -- 1 0 0 0  0
      -- 1 0 0 1  1
      -- 1 0 1 0  0
      -- 1 0 1 1  1
      -- 1 1 0 0  1
      -- 1 1 0 1  1
      -- 1 1 1 0  0
      -- 1 1 1 1  1 => BA (HIGH BYTE)
      ----------------------------------
      GENERIC MAP (
        operation_mode => "normal",
        synch_mode => "on",
        register_cascade_mode => "off",
        sum_lutc_input => "datac",
        lut_mask => "BA98"
      )
      PORT MAP (
        dataa => sel_in(0),
        datab => sel_in(1),
        datac => data_in(0),
        datad => data_in(1),
        combout => CascChain,
        
        clk => '1',
        sclr => sclr,
        regout => RegCascChain
        );
  
    END GENERATE;
    
    regcascchain_mid_gen :
    IF LAB_START = "FALSE" GENERATE
    
      mux4to1a_lc : stratix_lcell
      ----------------------------------
      -- if b=0 then if a=0 then c
      --            else d
      --      else a
      ----------------------------------
      -- D C B A  Z
      ----------------------------------
      -- 0 0 0 0  0 
      -- 0 0 0 1  0
      -- 0 0 1 0  0
      -- 0 0 1 1  1
      -- 0 1 0 0  1
      -- 0 1 0 1  0
      -- 0 1 1 0  0
      -- 0 1 1 1  1 => 98 (LOW BYTE)
      ----------
      -- 1 0 0 0  0
      -- 1 0 0 1  1
      -- 1 0 1 0  0
      -- 1 0 1 1  1
      -- 1 1 0 0  1
      -- 1 1 0 1  1
      -- 1 1 1 0  0
      -- 1 1 1 1  1 => BA (HIGH BYTE)
      ----------------------------------
      GENERIC MAP (
        operation_mode => "normal",
        synch_mode => "on",
        register_cascade_mode => "on",
        sum_lutc_input => "datac",
        lut_mask => "BA98"
      )
      PORT MAP (
        dataa => sel_in(0),
        datab => sel_in(1),
        datac => data_in(0),
        datad => data_in(1),
        combout => CascChain,
        
        clk => '1',
        sclr => sclr,
        regcascin => regcascin,
        regout => RegCascChain
        );
    
    END GENERATE;
  
    mux4to1b_lc : stratix_lcell
    ----------------------------------
    -- if a=0 then d
    --        else if d=0 then b
    --            else c
    ----------------------------------
    -- D C B A  Z
    ----------------------------------
    -- 0 0 0 0  0 
    -- 0 0 0 1  0
    -- 0 0 1 0  0
    -- 0 0 1 1  1
    -- 0 1 0 0  0
    -- 0 1 0 1  0
    -- 0 1 1 0  0
    -- 0 1 1 1  1 => 88 (LOW BYTE)
    ----------
    -- 1 0 0 0  1
    -- 1 0 0 1  0
    -- 1 0 1 0  1
    -- 1 0 1 1  0
    -- 1 1 0 0  1
    -- 1 1 0 1  1
    -- 1 1 1 0  1
    -- 1 1 1 1  1 => F5 (HIGH BYTE)
    ----------------------------------
    GENERIC MAP (
      operation_mode => "normal",
      synch_mode => "on",
      register_cascade_mode => "on",
      sum_lutc_input => "datac",
      lut_mask => "F588"
    )
    PORT MAP (
      dataa => sel_in(1),
      datab => data_in(2),
      datac => data_in(3),
      datad =>  CascChain,
      combout => mux_out,
      
      clk => '1',
      sclr => sclr,
      regcascin => RegCascChain,
      regout => regcascout
      );
    
  END GENERATE;
  
  sim_g : IF (LPM_SIM = SIMULATION_ON) GENERATE
    
    mux_out <=
      data_in(0) WHEN (sel_in = "00") ELSE
      data_in(1) WHEN (sel_in = "01") ELSE
      data_in(2) WHEN (sel_in = "10") ELSE
      data_in(3);

  END GENERATE;


END ARCHITECTURE;





LIBRARY IEEE, ALTERA;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE altera.ALT_CUSP130_PACKAGE.ALL;

ENTITY alt_cusp130_muxfast4 IS
GENERIC (
        NAME         : STRING := "";
        SIMULATION   : INTEGER := SIMULATION_OFF;
        OPTIMIZED    : INTEGER := OPTIMIZED_ON;
        FAMILY       : INTEGER := FAMILY_STRATIX;
        PORTS        : INTEGER := 4;
  WIDTH : INTEGER := 16
);
PORT (
  sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

  data0 : IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0) := (others=>'0');
  data1 : IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0) := (others=>'0');
  data2 : IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0) := (others=>'0');
  data3 : IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0) := (others=>'0');
  
  q : OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
);
END;


ARCHITECTURE rtl OF alt_cusp130_muxfast4 IS

  constant CLUSTERSIZE : integer := 4;  -- Pack groups of CLUSTERSIZE muxes into a LAB

  COMPONENT alt_cusp130_muxfast4_i IS
  GENERIC (
    LPM_TYPE : STRING := "alt_cusp_muxfast4_i";
    LPM_SIM : INTEGER := SIMULATION_OFF;      -- use faster simulation model
    LAB_START : STRING := "TRUE"
  );
  PORT (
    sclr : IN STD_LOGIC;      -- for register cascade chain
    regcascin : IN STD_LOGIC;   -- for register cascade chain
    regcascout : OUT STD_LOGIC;   -- for register cascade chain

    sel_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);   -- [00 -> data00, 01 -> data01, 10 -> data10, 11 -> data11]
    data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  
    mux_out : OUT STD_LOGIC
  );
  END COMPONENT;

  SIGNAL RegCascChain : STD_LOGIC_VECTOR(WIDTH-1+CLUSTERSIZE DOWNTO 0);

  SIGNAL TiedLow : STD_LOGIC;

BEGIN

  synth_g : IF (OPTIMIZED = OPTIMIZED_ON AND FAMILY = FAMILY_STRATIX) GENERATE

    labs_g : FOR i IN 0 TO WIDTH-1+CLUSTERSIZE-1 GENERATE
      TiedLow <= '0';
      
      lab_start_g : IF ((i MOD CLUSTERSIZE) = 0) AND (i < WIDTH) GENERATE
        mux4to1_inst : alt_cusp130_muxfast4_i
        GENERIC MAP (
          LPM_SIM => OPTIMIZED,
          LAB_START => "TRUE"
        )
        PORT MAP (
          sclr => RegCascChain((i/CLUSTERSIZE)*CLUSTERSIZE + CLUSTERSIZE-1),
          regcascin => TiedLow,
          regcascout => RegCascChain(i),

          sel_in => sel,
          data_in(0) => data0(i),
          data_in(1) => data1(i),
          data_in(2) => data2(i),
          data_in(3) => data3(i),
          mux_out => q(i)
        );
      END GENERATE;

      lab_fill_g : IF ((i MOD CLUSTERSIZE) /= 0) AND (i < WIDTH) GENERATE
        mux4to1_inst : alt_cusp130_muxfast4_i
        GENERIC MAP (
          LPM_SIM => OPTIMIZED,
          LAB_START => "FALSE"
        )
        PORT MAP (
          sclr => RegCascChain((i/CLUSTERSIZE)*CLUSTERSIZE + CLUSTERSIZE-1 ),
          regcascin => RegCascChain(i-1),
          regcascout => RegCascChain(i),

          sel_in => sel,
          data_in(0) => data0(i),
          data_in(1) => data1(i),
          data_in(2) => data2(i),
          data_in(3) => data3(i),
          mux_out => q(i)
        );
      END GENERATE;

      lab_pad_g : IF (i >= WIDTH) GENERATE
        RegCascChain(i) <= RegCascChain(i-1);   -- Tie off last chain if less than 4 muxes
      END GENERATE;
      
    END GENERATE;

  END GENERATE;
  
  sim_g : IF (OPTIMIZED = OPTIMIZED_OFF OR  FAMILY /= FAMILY_STRATIX) GENERATE
    
    q <=
      data0 WHEN (sel = "00") ELSE
      data1 WHEN (sel = "01") ELSE
      data2 WHEN (sel = "10") ELSE
      data3;

  END GENERATE;


END ARCHITECTURE;




