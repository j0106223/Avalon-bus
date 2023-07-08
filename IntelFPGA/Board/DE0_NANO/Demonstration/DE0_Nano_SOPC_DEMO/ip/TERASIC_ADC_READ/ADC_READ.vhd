LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
	USE IEEE.STD_LOGIC_ARITH.ALL;
	USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ADC_READ IS
	PORT	(
				clk					:	IN		STD_LOGIC;
				reset_n				:	IN		STD_LOGIC;
				
				Channel				:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				Data				:	OUT		STD_LOGIC_VECTOR(11 DOWNTO 0);
				Start				:	IN		STD_LOGIC;
				Done				:	OUT		STD_LOGIC;
				
				oDIN				:	OUT		STD_LOGIC;
				oCS_n				:	OUT		STD_LOGIC;
				oSCLK				:	OUT		STD_LOGIC;
				iDOUT				:	IN		STD_LOGIC
			);

END ADC_READ;

ARCHITECTURE TERASIC OF ADC_READ IS
	TYPE STATE IS (st_00,st_01,st_02,st_03);
	SIGNAL	st				:	STATE;
	
	SIGNAL	start_en		:	STD_LOGIC;
	SIGNAL	start_ack		:	STD_LOGIC;
	
	SIGNAL	read_en			:	STD_LOGIC;
	SIGNAL	read_ack		:	STD_LOGIC;
	SIGNAL	read_cont		:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL	read_clk		:	STD_LOGIC;
	SIGNAL	read_data		:	STD_LOGIC_VECTOR(11 DOWNTO 0);

---------------------------------------------------------------------------------------------
--PROGRAM START
	
BEGIN
	PROCESS(clk,reset_n)
	BEGIN
		IF reset_n = '0' THEN
			st <= st_00;

		ELSIF clk'EVENT AND clk = '1' THEN
			CASE st IS
				WHEN st_00 =>
					IF start_en = '1' THEN
						st <= st_01;
					END IF;

				WHEN st_01 =>								--READ DATA
					IF read_ack = '1' THEN
						st <= st_02;
					END IF;
						
				WHEN st_02 =>								--READ DATA to register
						st <= st_03;
				
				WHEN st_03 =>								--finish
					IF start_en = '1' THEN
						st <= st_01;
					END IF;
				
			END CASE;
		END IF;
	END PROCESS;

--------------------------------------------------------------------------------------------
-- STATUS CONTROL

	PROCESS(Start,start_ack)
	BEGIN
		IF start_ack = '1' THEN
			start_en	<=	'0';
		ELSIF Start' EVENT AND Start = '1' THEN
			start_en	<=	'1';
		END IF;
	END PROCESS;

	WITH st SELECT
		read_en				<=	'1'		WHEN st_01,
								'0'		WHEN OTHERS;
	
	WITH st SELECT
		read_clk			<=	'0'		WHEN st_02,
								'1'		WHEN OTHERS;
	
	WITH st SELECT
		oSCLK				<=	clk		WHEN st_01,
								'1'		WHEN OTHERS;

	WITH st SELECT
		oCS_n				<=	'1'		WHEN st_00|st_03,
								'0'		WHEN OTHERS;

	WITH st SELECT
		Done				<=	'1'		WHEN st_03,
								'0'		WHEN OTHERS;

	WITH st SELECT
		start_ack			<=	'1'		WHEN st_02,
								'0'		WHEN OTHERS;


--------------------------------------------------------------------------------------------
-- st_01
	PROCESS(clk,read_en)
	BEGIN
		IF read_en = '0' THEN
			read_cont	<=	"0000";
		ELSIF clk' EVENT AND clk = '1' THEN
			read_cont	<=	read_cont + '1';
		END IF;
		
		IF read_en = '0' THEN
			read_ack	<=	'0';
		ELSIF clk' EVENT AND clk = '0' THEN
			IF read_cont >= "1111" THEN
				read_ack	<=	'1';
			ELSE
				read_ack	<=	'0';
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(clk,read_en)					--A/D CH SELECT
	BEGIN
		IF clk' EVENT AND clk = '0' THEN
			IF read_cont = "0010" THEN			--ADDR2
				oDIN	<=	Channel(2);
			ELSIF read_cont = "0011" THEN		--ADDR1
				oDIN	<=	Channel(1);
			ELSIF read_cont = "0100" THEN		--ADDR0
				oDIN	<=	Channel(0);
			ELSE
				oDIN	<=	'0';
			END IF;
		END IF;
		
		IF read_en = '0' THEN					--A/D DATA READ
			read_data	<=	read_data;
		ELSIF clk' EVENT AND clk = '1' THEN
			IF read_cont = "0100" THEN
				read_data(11)	<=	iDOUT;
			ELSIF read_cont = "0101" THEN
				read_data(10)	<=	iDOUT;
			ELSIF read_cont = "0110" THEN
				read_data(9)		<=	iDOUT;
			ELSIF read_cont = "0111" THEN
				read_data(8)		<=	iDOUT;
			ELSIF read_cont = "1000" THEN
				read_data(7)		<=	iDOUT;
			ELSIF read_cont = "1001" THEN
				read_data(6)		<=	iDOUT;
			ELSIF read_cont= "1010" THEN
				read_data(5)		<=	iDOUT;
			ELSIF read_cont = "1011" THEN
				read_data(4)		<=	iDOUT;
			ELSIF read_cont = "1100" THEN
				read_data(3)		<=	iDOUT;
			ELSIF read_cont = "1101" THEN
				read_data(2)		<=	iDOUT;
			ELSIF read_cont = "1110" THEN
				read_data(1)		<=	iDOUT;
			ELSIF read_cont = "1111" THEN
				read_data(0)		<=	iDOUT;
			END IF;
		END IF;
	END PROCESS;

--------------------------------------------------------------------------------------------
-- st_02

	PROCESS(read_clk,reset_n)
	BEGIN
		IF reset_n = '0' THEN
			Data	<= "000000000000";	
		ELSIF read_clk' EVENT AND read_clk = '1' THEN
			Data	<= read_data;
		END IF;
	END PROCESS;
	
--------------------------------------------------------------------------------------------
-- OUTPUT CONTROL


--------------------------------------------------------------------------------------------
END TERASIC;
