library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;

entity any_edge_tb is
	
	generic (
		clk_per: time := 20 ns
	);
	
	port(
		clk: in std_logic;
		
		aclrn: inout std_logic;
		input: inout std_logic
	);

end entity;


architecture tb of any_edge_tb is
	signal reset: std_logic;
	signal edge: std_logic;
begin
	
	reset_sync: entity work.ResetSynchronizer
		port map(
			aclrn => aclrn,
			clk => clk,
			reset => reset
		);

	
	any_edge: entity work.AnyEdgeDetector
		port map(
			clk => clk,
			reset => reset,
			
			async_in => input,
			detect_out => edge
		);

	
	vectors: process
	begin
		aclrn <= '1';
	
		wait for clk_per;
	
		input <= '0';
		
		wait for clk_per * 4;
		
		-- Test rising edge
		input <= '1';
		wait for clk_per * 4;
		
		-- Test for falling edge
		input <= '0';
		wait for clk_per * 4;
		
		
		aclrn <= '0';
		wait for clk_per * 3;
		aclrn <= '1';
	
	end process;
	
	
end architecture;
