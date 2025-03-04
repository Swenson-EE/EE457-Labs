library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter is

	port(
		signal clk			: in std_logic;
		signal aclr_n		: in std_logic;
		
		signal count_out	: out unsigned (1 downto 0)
	);

end entity;



architecture rtl of counter is

begin
	
	process (clk, aclr_n)
		variable count : unsigned (1 downto 0) := "00";
	begin
		-- Clear (active low)
		if aclr_n = '0' then
			count := "00";
		
		-- Clock Rising Edge
		elsif rising_edge(clk) then
			count := count + 1;
			
		end if;
		
		count_out <= count;
	end process;

end architecture;

