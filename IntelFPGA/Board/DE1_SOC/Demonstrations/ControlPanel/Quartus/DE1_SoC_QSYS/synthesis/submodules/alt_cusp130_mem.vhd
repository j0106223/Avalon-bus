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

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY alt_cusp130_mem IS
  GENERIC (
        NAME             : STRING  := "";
        OPTIMIZED        : INTEGER := OPTIMIZED_ON;
        FAMILY           : INTEGER := FAMILY_STRATIX;
        INIT_FILE        : STRING  := "UNUSED";
        INIT_CONTENTS    : STRING  := "UNUSED";
        DATA_WIDTH       : INTEGER := 16;
        ADDRESS_WIDTH    : INTEGER := 16;   
        DEPTH            : INTEGER := 16;     
        LATENCY          : INTEGER := 2;
        READ_PORTS       : INTEGER := 0;
        WRITE_PORTS      : INTEGER := 0;
        READ_WRITE_PORTS : INTEGER := 2;
        MODE             : INTEGER := ALT_MEM_MODE_AUTO;
        ALLOW_MULTI_THREAD : INTEGER := 0
  );
  PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        Aena  : IN STD_LOGIC := '1';
        Bena  : IN STD_LOGIC := '0';
        Cena  : IN STD_LOGIC := '0';
        
        --In simple dual port, portA is only a write port
        Aenable    : IN STD_LOGIC := '0';
        Aenable_en : IN STD_LOGIC := '0';
        Aaddr     : IN  STD_LOGIC_VECTOR( ADDRESS_WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
        Awdata    : IN  STD_LOGIC_VECTOR( DATA_WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
        Awdata_en : IN  STD_LOGIC := '0';
        Ardata    : OUT STD_LOGIC_VECTOR( DATA_WIDTH-1 DOWNTO 0);
        
        --portB is not available in single port memory
        --portB is only a read port in half-dual port memory
        --In simple dual port, portB is the read port
        Benable    : IN STD_LOGIC := '0';
        Benable_en : IN STD_LOGIC := '0';
        Baddr     : IN  STD_LOGIC_VECTOR( ADDRESS_WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
        Bwdata    : IN  STD_LOGIC_VECTOR( DATA_WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
        Bwdata_en : IN  STD_LOGIC := '0';
        Brdata    : OUT STD_LOGIC_VECTOR( DATA_WIDTH-1 DOWNTO 0);
        
        --Always a read port
        Cenable    : IN STD_LOGIC := '0';  
        Cenable_en : IN STD_LOGIC := '0';
        Caddr     : IN  STD_LOGIC_VECTOR( ADDRESS_WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
        Crdata    : OUT STD_LOGIC_VECTOR( DATA_WIDTH-1 DOWNTO 0)
        
  );
END;


ARCHITECTURE rtl OF alt_cusp130_mem IS
  
    COMPONENT altsyncram 
       GENERIC
          (
          IMPLEMENT_IN_LES		              : STRING  := "OFF";
          OPERATION_MODE                      : STRING  := "SINGLE_PORT";
          WIDTH_A                             : INTEGER := DATA_WIDTH;
          WIDTHAD_A                           : INTEGER := ADDRESS_WIDTH;
          NUMWORDS_A                          : INTEGER := DEPTH;
          OUTDATA_REG_A                       : STRING  := "UNREGISTERED";     
          WIDTH_B                             : INTEGER := DATA_WIDTH;
          WIDTHAD_B                           : INTEGER := ADDRESS_WIDTH;
          NUMWORDS_B                          : INTEGER := DEPTH;
          RDCONTROL_REG_B                     : STRING  := "CLOCK0";    
          ADDRESS_REG_B                       : STRING  := "CLOCK0";    
          OUTDATA_REG_B                       : STRING  := "UNREGISTERED";      
          INDATA_REG_B                        : STRING  := "CLOCK0";    
          WRCONTROL_WRADDRESS_REG_B           : STRING  := "CLOCK0";    
          BYTEENA_REG_B                       : STRING  := "CLOCK0";      
          CLOCK_ENABLE_INPUT_A                : STRING  := "NORMAL";
          CLOCK_ENABLE_OUTPUT_A               : STRING  := "NORMAL";
          CLOCK_ENABLE_INPUT_B                : STRING  := "NORMAL";
          CLOCK_ENABLE_OUTPUT_B               : STRING  := "NORMAL"; 
          READ_DURING_WRITE_MODE_MIXED_PORTS  : STRING  := "OLD_DATA";    
          RAM_BLOCK_TYPE                      : STRING  := "AUTO";    
          INIT_FILE                           : STRING  := "UNUSED";    
          INIT_FILE_LAYOUT                    : STRING  := "UNUSED";    
          MAXIMUM_DEPTH                       : INTEGER := 0;    
          INTENDED_DEVICE_FAMILY              : STRING  := "STRATIX";
          LPM_HINT                            : STRING  := "UNUSED";
          LPM_TYPE                            : STRING  := "ALTSYNCRAM" );
    
       PORT (
            wren_a                     : IN STD_LOGIC                                          := '0';
            wren_b                     : IN STD_LOGIC                                          := '0';
            clock0                     : IN STD_LOGIC                                          := '1';
            clocken0                   : IN STD_LOGIC                                          := '1';
            data_a                     : IN STD_LOGIC_VECTOR(WIDTH_A - 1 DOWNTO 0)             := (OTHERS => '0');
            data_b                     : IN STD_LOGIC_VECTOR(WIDTH_B - 1 DOWNTO 0)             := (OTHERS => '0');
            address_a                  : IN STD_LOGIC_VECTOR(WIDTHAD_A - 1 DOWNTO 0)           := (OTHERS => '0');
            address_b                  : IN STD_LOGIC_VECTOR(WIDTHAD_B - 1 DOWNTO 0)           := (OTHERS => '0');
            q_a                        : OUT STD_LOGIC_VECTOR(WIDTH_A - 1 DOWNTO 0);
            q_b                        : OUT STD_LOGIC_VECTOR(WIDTH_B - 1 DOWNTO 0);
            addressstall_a             : IN STD_LOGIC                                          := '0';
            addressstall_b             : IN STD_LOGIC                                          := '0');
    
    END COMPONENT;

    SIGNAL Awdata_en_int : STD_LOGIC;
    SIGNAL Bwdata_en_int : STD_LOGIC;
    
    SIGNAL Aaddress_stall_int : STD_LOGIC;
    SIGNAL Baddress_stall_int : STD_LOGIC;
    SIGNAL Caddress_stall_int : STD_LOGIC;
    
    SIGNAL Ardata_en_int : STD_LOGIC;
    SIGNAL Ardata_int : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    
    SIGNAL Brdata_en_int : STD_LOGIC;
    SIGNAL Brdata_int : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    
    SIGNAL Crdata_en_int : STD_LOGIC;
    SIGNAL Crdata_int : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);

    SIGNAL ena : STD_LOGIC;

BEGIN

    tie_off_crdata_gen: IF READ_WRITE_PORTS + READ_PORTS < 3 AND WRITE_PORTS + READ_PORTS < 3 GENERATE
      crdata_drive: Crdata <= (others=>'0');
    END GENERATE;

    	multi_thread_gen : IF ALLOW_MULTI_THREAD = 1 GENERATE
            -- this is broken and should only be allowed for the scaler
    		ena <= Aena OR Bena OR Cena;
    	END GENERATE;
        
        single_thread_gen : IF ALLOW_MULTI_THREAD = 0 GENERATE
    		ena <= Aena;
    	END GENERATE;

        Awdata_en_drive: Awdata_en_int <= Aenable AND Aenable_en AND Awdata_en;
        Bwdata_en_drive: Bwdata_en_int <= Benable AND Benable_en AND Bwdata_en;
        
        latencyX_gen : ASSERT (LATENCY > 0 AND LATENCY < 3) 
                                   REPORT "Only 1 or 2 clock cycle latencies are allowed on memory" 
                                   SEVERITY failure;
        
        cyclone_error_gen : IF FAMILY = FAMILY_CYCLONE OR FAMILY = FAMILY_CYCLONEII GENERATE
            cyclone_mode_error : ASSERT (MODE = ALT_MEM_MODE_AUTO OR MODE = ALT_MEM_MODE_M4K OR MODE = ALT_MEM_MODE_LE) 
                                 REPORT "The memory implementation mode requested is not supported on Cyclone/Cyclone II devices. Use ALT_MEM_MODE_AUTO or ALT_MEM_MODE_M4K." 
                                 SEVERITY FAILURE;                      
        END GENERATE; -- cyclone_error_gen
        
        
        dual_port_err : IF READ_WRITE_PORTS = 2 GENERATE               
            cyclone_dpmem_error :  ASSERT (READ_PORTS = 0 AND WRITE_PORTS = 0) 
                                   REPORT "Cannot support the memory port configuration" 
                                   SEVERITY FAILURE;
        END GENERATE;
            
        single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
            spmem_error :  ASSERT (WRITE_PORTS = 0) 
                           REPORT "A memory of configuration 1 READ/WRITE port and 1 or more WRITE port is not supported" 
                           SEVERITY FAILURE;
            END GENERATE;
            
        
        le_mode_err : IF MODE = ALT_MEM_MODE_LE GENERATE
            le_dp_error : ASSERT(READ_WRITE_PORTS /= 2)
                          REPORT "True dual port memory is not supported in ALT_MEM_MODE_LE" 
                          SEVERITY FAILURE;
        END GENERATE;
        
        stratix_gen: IF FAMILY = FAMILY_STRATIX GENERATE
        
            stratix_latencyX_gen : ASSERT (LATENCY /= 1) 
                                   REPORT "Only 1 clock cycle latencies are allowed on stratix" 
                                   SEVERITY failure;    
            
            process (clock, reset) begin
                if reset = '1' then
                    Ardata_en_int <= '0';
                    Ardata <= (others => '0');
                elsif Rising_edge(clock) then
                	if ena = '1' then
	                    Ardata_en_int <= Aenable AND Aenable_en;
	                    if Ardata_en_int = '1' then
	                        Ardata <= Ardata_int;
	                    end if;
	                end if;
                end if;
            end process;
                                   
            output_register_B: IF READ_PORTS + READ_WRITE_PORTS > 1 GENERATE
                process (clock, reset) begin
                    if reset = '1' then
                        Brdata_en_int <= '0';
                        Brdata <= (others => '0');
                    elsif Rising_edge(clock) then
                    	if ena = '1' then
	                        Brdata_en_int <= Benable AND Benable_en;
	                        if Brdata_en_int = '1' then
	                            Brdata <= Brdata_int;
	                        end if;
	                    end if;
                    end if;
                end process;
            END GENERATE;
            
            output_register_C: IF READ_PORTS + READ_WRITE_PORTS > 2 GENERATE
                process (clock, reset) begin
                    if reset = '1' then
                        Crdata_en_int <= '0';
                        Crdata <= (others => '0');
                    elsif Rising_edge(clock) then
                    	if ena = '1' then
	                        Crdata_en_int <= Cenable AND Cenable_en;
	                        if Crdata_en_int = '1' then
	                            Crdata <= Crdata_int;
	                        end if;
	                    end if;
                    end if;
                end process;
            END GENERATE;
        
            mode_auto_gen : IF MODE = ALT_MEM_MODE_AUTO GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        ); 
                
                END GENERATE; --single_port_rom_gen    
                
                
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        );
                        
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                     
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                    
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED", 
                          init_file => INIT_FILE, 
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata_int
                        );
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_auto_gen
            
            
            mode_m4k_gen : IF MODE = ALT_MEM_MODE_M4K GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        );
                
                END GENERATE; --single_port_rom_gen 
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                 
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                        
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        );
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                        
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                    
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata_int
                        );
                        
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_m4k_gen
    
    
            mode_M512_gen : IF MODE = ALT_MEM_MODE_M512 GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        );
                
                END GENERATE; --single_port_rom_gen
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        );
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        ); 
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                     
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                     
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata_int
                        );  
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_M512_gen
    
    
            mode_MRAM_gen : IF MODE = ALT_MEM_MODE_MRAM GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "MRAM"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        );
                
                END GENERATE; --single_port_rom_gen
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        ); 
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                      
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                       
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata_int
                        );
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_MRAM_gen
    
    
            mode_LE_gen : IF MODE = ALT_MEM_MODE_LE GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        );
                
                END GENERATE; --single_port_rom_gen
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata_int
                        ); 
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata_int,
                          q_b => Brdata_int
                        );
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                     
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                        
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                     
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata_int
                        );
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_LE_gen
        
        END GENERATE; --stratix

        non_stratix_gen: IF FAMILY /= FAMILY_STRATIX GENERATE
        
            Aaddress_stall_drive: Aaddress_stall_int <= NOT (Aenable AND Aenable_en);
            Baddress_stall_drive: Baddress_stall_int <= NOT (Benable AND Benable_en);
            Caddress_stall_drive: Caddress_stall_int <= NOT (Cenable AND Cenable_en);
            
            mode_auto_gen : IF MODE = ALT_MEM_MODE_AUTO GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --single_port_rom_gen    
                
                
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                     
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0", 
                          init_file => INIT_FILE, 
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED", 
                          init_file => INIT_FILE, 
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "AUTO"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_auto_gen
            
            
            mode_m4k_gen : IF MODE = ALT_MEM_MODE_M4K GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --single_port_rom_gen 
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                 
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"                      
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M4K"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_m4k_gen
    
    
            mode_M512_gen : IF MODE = ALT_MEM_MODE_M512 GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --single_port_rom_gen
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                     
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                     
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "M512"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_M512_gen
    
    
            mode_MRAM_gen : IF MODE = ALT_MEM_MODE_MRAM GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "MRAM"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE,
                          RAM_BLOCK_TYPE => "MRAM"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --single_port_rom_gen
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                      
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                       
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          RAM_BLOCK_TYPE => "MRAM",
                          init_file => INIT_FILE,
                          READ_DURING_WRITE_MODE_MIXED_PORTS => "DONT_CARE"
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_MRAM_gen
    
    
            mode_LE_gen : IF MODE = ALT_MEM_MODE_LE GENERATE
            
                single_port_rom_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0 GENERATE               
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "ROM",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --single_port_rom_gen
                
            
                dual_port_gen : IF READ_WRITE_PORTS = 2 OR (READ_PORTS = 2 AND WRITE_PORTS = 0 AND READ_WRITE_PORTS = 0) GENERATE               
                
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          wren_b => Bwdata_en_int,
                          data_a => Awdata,
                          data_b => Bwdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --dual_port_gen
                
            
                single_port_gen : IF READ_WRITE_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          q_a => Ardata,
                          addressstall_a => Aaddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; --single_port_gen
                
                
                half_dual_port_gen : IF READ_WRITE_PORTS = 1 AND READ_PORTS = 1 GENERATE
                    
                    latency1_gen : IF LATENCY = 1 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "BIDIR_DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED", 
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                    
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "SINGLE_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_a => Ardata,
                          q_b => Brdata,
                          addressstall_a => Aaddress_stall_int,
                          addressstall_b => Baddress_stall_int
                        );
                    
                    END GENERATE;  -- latency2_gen  
                    
                END GENERATE; -- half_dual_port_gen
                
                
                simple_dual_port_gen : IF READ_PORTS = 1 AND WRITE_PORTS = 1 GENERATE               
                     
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0", 
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                
                
                two_read_one_write_port_gen : IF READ_PORTS = 2 AND WRITE_PORTS = 1 GENERATE               
                     
                    latency1_gen : IF LATENCY = 1 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "UNREGISTERED",  
                          OUTDATA_REG_B => "UNREGISTERED",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                        
                    END GENERATE; -- latency1_gen
                    
                    
                    latency2_gen : IF LATENCY = 2 GENERATE
                
                        altsyncram_component_one : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Baddr,
                          q_b => Brdata,
                          addressstall_b => Baddress_stall_int
                        );
                        
                        altsyncram_component_two : altsyncram
                        GENERIC MAP (
                          IMPLEMENT_IN_LES=> "ON",
                          OPERATION_MODE => "DUAL_PORT",
                          OUTDATA_REG_A => "CLOCK0",  
                          OUTDATA_REG_B => "CLOCK0",  
                          init_file => INIT_FILE
                        )
                        PORT MAP (
                          clock0 => clock,
                          clocken0 => ena,
                          wren_a => Awdata_en_int,
                          data_a => Awdata,
                          address_a => Aaddr,
                          address_b => Caddr,
                          q_b => Crdata,
                          addressstall_b => Caddress_stall_int
                        );
                
                    END GENERATE;  -- latency2_gen  
                
                END GENERATE; --simple dual_port_gen
                    
            END GENERATE; --mode_LE_gen
        
        END GENERATE; --non stratix
        
END ;
