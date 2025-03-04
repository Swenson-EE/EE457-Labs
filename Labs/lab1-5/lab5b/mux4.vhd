LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mux4 IS

	PORT(
		SIGNAL mux_in_a		: IN UNSIGNED (3 DOWNTO 0);
		SIGNAL mux_in_b		: IN UNSIGNED (3 DOWNTO 0);
		SIGNAL mux_sel			: IN STD_LOGIC;
		
		SIGNAL mux_out			: OUT UNSIGNED (3 DOWNTO 0)
	);

END ENTITY mux4;


ARCHITECTURE mux4_arch OF mux4 IS


BEGIN
	mux_out <= 	mux_in_a WHEN mux_sel = '0' ELSE
					mux_in_b WHEN mux_sel = '1';
						

END ARCHITECTURE mux4_arch;


