library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ClockDivider is
	generic(
		counts_per_tick: integer := 25_000_000
	);

	port(
		signal clk: in STD_LOGIC;
		signal reset: in STD_LOGIC;
		
		signal slow_clk: out STD_LOGIC
	
	);

end entity;



architecture rtl of ClockDivider is
	signal counter: INTEGER range 0 to 50_000_000 := 0;
	signal clk_out: STD_LOGIC := '0';
	
	
begin
	process (clk, reset)
	begin
		if reset = '0' then
			counter <= 0;
			clk_out <= '0';
		elsif rising_edge(clk) then
			if counter = (counts_per_tick / 2 - 1) then
				clk_out <= not clk_out;
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

	
	slow_clk <= clk_out;
	
end architecture;