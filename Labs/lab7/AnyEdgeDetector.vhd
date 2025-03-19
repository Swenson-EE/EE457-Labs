library ieee;
use ieee.std_logic_1164.all;


entity AnyEdgeDetector is

	port(
		signal clk			: in std_logic;
		signal reset		: in std_logic;
		
		signal async_in	: in std_logic;
		
		signal detect_out	: out std_logic
	);

end entity;



architecture rtl of AnyEdgeDetector is
	signal a : std_logic := '0';
begin

	process (clk, reset)
	begin
		if reset = '0' then
			a <= '0';
			detect_out <= '0';
		elsif rising_edge(clk) then
			detect_out <= async_in xor a;
			a <= async_in;
			
		end if;
		
		
	end process;
	
	

end architecture;


