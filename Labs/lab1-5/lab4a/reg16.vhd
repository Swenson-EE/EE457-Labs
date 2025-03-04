library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg16 is

	port(
		signal clk			: in std_logic;
		signal sclr_n		: in std_logic;
		signal clk_ena		: in std_logic;
		signal datain		: in unsigned (15 downto 0);
		
		signal reg_out		: out unsigned (15 downto 0) 
	);

end entity;



architecture rtl of reg16 is

begin
	process(clk)
	
	begin
		if rising_edge(clk) then
			if clk_ena = '1' then
			
				-- Clear
				if sclr_n = '0' then 
					reg_out <= x"0000";
				-- Output register inputs
				else 
					reg_out <= datain;
				end if;
				
			end if;
			
		end if;
	end process;


end architecture;
