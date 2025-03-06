library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ClockDivider is
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
		if reset = '1' then
			counter <= 0;
			clk_out <= '0';
		elsif rising_edge(clk) then
			if counter = 25_000_000 then
				clk_out <= not clk_out;
				count <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;


end architecture;