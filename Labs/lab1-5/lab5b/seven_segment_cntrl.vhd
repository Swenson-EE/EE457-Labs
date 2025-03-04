LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;



ENTITY seven_segment_cntrl IS

	PORT(
		SIGNAL input			: IN UNSIGNED (2 DOWNTO 0);
		
		SIGNAL seg_a			: OUT STD_LOGIC;
		SIGNAL seg_b			: OUT STD_LOGIC;
		SIGNAL seg_c			: OUT STD_LOGIC;
		SIGNAL seg_d			: OUT STD_LOGIC;
		SIGNAL seg_e			: OUT STD_LOGIC;
		SIGNAL seg_f			: OUT STD_LOGIC;
		SIGNAL seg_g			: OUT STD_LOGIC
	);

END ENTITY;



ARCHITECTURE rtl OF seven_segment_cntrl IS

BEGIN
	
	PROCESS (input)
	BEGIN
		CASE input IS
			WHEN "000" =>
				-- 0
				seg_a <= '1';
				seg_b <= '1';
				seg_c <= '1';
				seg_d <= '1';
				seg_e <= '1';
				seg_f <= '1';
				seg_g <= '0';
		
			WHEN "001" =>
				-- 1
				seg_a <= '0';
				seg_b <= '1';
				seg_c <= '1';
				seg_d <= '0';
				seg_e <= '0';
				seg_f <= '0';
				seg_g <= '0';
		
			WHEN "010" =>
				-- 2
				seg_a <= '1';
				seg_b <= '1';
				seg_c <= '0';
				seg_d <= '1';
				seg_e <= '1';
				seg_f <= '0';
				seg_g <= '1';
				
			WHEN "011" =>
				-- 3
				seg_a <= '1';
				seg_b <= '1';
				seg_c <= '1';
				seg_d <= '1';
				seg_e <= '0';
				seg_f <= '0';
				seg_g <= '1';
			
			
			WHEN OTHERS =>
				seg_a <= '1';
				seg_b <= '0';
				seg_c <= '0';
				seg_d <= '1';
				seg_e <= '1';
				seg_f <= '1';
				seg_g <= '1';
		
		END CASE;
			
	END PROCESS;
	
END ARCHITECTURE;

