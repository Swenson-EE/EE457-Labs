library ieee;
use ieee.std_logic_1164.all;



entity RisingEdgeDetector is

	port (
		clk:							in std_logic;
		reset:						in std_logic;
		sync_in:						in std_logic;
		
		rising_edge_detect:		out std_logic
	);

end entity;




architecture rtl of RisingEdgeDetector is
	signal a: std_logic := '0';

begin
	
	process(clk, reset)
	begin
		if reset = '0' then
			a <= '0';
			rising_edge_detect <= '0';
		elsif rising_edge(clk) then
			rising_edge_detect <= sync_in and not(a);
			a <= sync_in;
		end if;
		
	end process;
	
	
	

end architecture;

