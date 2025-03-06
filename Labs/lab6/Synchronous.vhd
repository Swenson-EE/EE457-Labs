library IEEE;
use ieee.std_logic_1164.all;

entity Synchronizer is

	port(
		signal clk			: in std_logic;
		signal async_in	: in std_logic;
		
		signal sync_out	: out std_logic;
	);

end entity;



architecture rtl of Synchronizer is

	signal stage1, stage2: std_logic;

begin
	process(clk)
		
	begin
		if rising_edge(clk) then
			stage1 <= async_in;
			stage2 <= stage1;
		end if;
		
	end process;
	
	sync_out <= stage2;

end architecture;
