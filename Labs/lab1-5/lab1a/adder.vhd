LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;


ENTITY adder IS

	PORT(
		SIGNAL dataa 	: IN UNSIGNED (15 DOWNTO 0);
		SIGNAL datab 	: IN UNSIGNED (15 DOWNTO 0);
		
		SIGNAL sum		: OUT UNSIGNED (15 DOWNTO 0)
	);

END ENTITY adder;


ARCHITECTURE adder_arch OF adder IS

BEGIN
	sum <= dataa + datab;

END ARCHITECTURE adder_arch;