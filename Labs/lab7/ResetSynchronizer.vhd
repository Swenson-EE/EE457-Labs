library ieee;
use ieee.std_logic_1164.all;


entity ResetSynchronizer is
	
	port(
		signal aclrn		: in std_logic;
		signal clk			: in std_logic;
		
		signal reset		: out std_logic
	);

end entity;



architecture rtl of ResetSynchronizer is
	signal a, b : std_logic;
begin
	process(clk, aclrn)
	begin
		if aclrn = '0' then
			a <= '0';
			b <= '0';
		elsif rising_edge(clk) then
			a <= '1';
			b <= a;
		end if;
	end process;
	
	reset <= b;

end architecture;
