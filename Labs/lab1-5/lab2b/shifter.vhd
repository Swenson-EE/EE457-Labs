LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY shifter IS

	PORT(
		SIGNAL input			: IN UNSIGNED (7 DOWNTO 0);
		SIGNAL shift_cntrl	: IN UNSIGNED (1 DOWNTO 0);
		
		SIGNAL shift_out		: OUT UNSIGNED (15 DOWNTO 0)
	);

END ENTITY shifter;



ARCHITECTURE shifter_arch OF shifter IS

BEGIN
	
	PROCESS (input, shift_cntrl)
	
	BEGIN
		shift_out <= x"0000";
	
		-- No Shift
		-- shift_out[7:0] = input[7:0] 
		IF (shift_cntrl="00") THEN 
			shift_out (7 DOWNTO 0) <= input;
		
		-- Shift input left 4 bits
		-- shift_out[11:4] = input[7:0]
		ELSIF (shift_cntrl="01") THEN
			shift_out (11 DOWNTO 4) <= input;
		
		-- Shift input left 8 bits
		-- shift_out[15:8] = input[7:0]
		ELSIF (shift_cntrl="10") THEN
			shift_out (15 DOWNTO 8) <= input;
			
		-- No Shift
		-- shift_out[7:0] = input[7:0]
		ELSIF (shift_cntrl="11") THEN
			shift_out (7 DOWNTO 0) <= input;
		
		END IF;
		
	END PROCESS;

END ARCHITECTURE shifter_arch;




