library ieee;
use ieee.std_logic_1164.all;


entity AnyEdgeDetector is

	port(
		signal clk			: in std_logic;
		signal reset		: in std_logic;
		
		signal async_in	: in std_logic;
		
		signal detect_out	: out std_logic;
	);

end entity;



architecture rtl of AnyEdgeDetector is
	signal a;
begin

	process (clk, reset)
	begin
		if reset = '0' then
			a <= '0';
		elsif rising_edge(clk)
			a <= async_in;
		end if;
	end process;
	
	detect_out <= async_in or a;

end architecture;


