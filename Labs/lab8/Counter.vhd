library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.CommonTypes.all;


entity Counter is
	generic(
		counts_per_tick: integer := 50_000_000
	);

	port(
		signal clk: in STD_LOGIC;
		signal reset: in STD_LOGIC;
		
		signal tick: out STD_LOGIC
	
	);

end entity;



architecture rtl of Counter is
	signal counter: INTEGER range 0 to 50_000_000 := 0;
	
	
begin
	process (clk, reset)
	begin
		if reset = RESET_ACTIVE then
			counter <= 0;
		elsif rising_edge(clk) then
			if counter = (counts_per_tick - 1) then
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

	
	tick <= '1' when counter = (counts_per_tick - 1) else '0';
	
end architecture;
