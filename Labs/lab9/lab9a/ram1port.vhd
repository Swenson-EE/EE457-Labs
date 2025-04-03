library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



--entity ram1port is
--	generic(
--		data_width: integer := 4;
--		address_width: integer := 5
--	);
--	
--	port(
--		address: 		in std_logic_vector(address_width - 1 downto 0);
--		clock:			in std_logic := '1';
--		reset:			in std_logic := '1';
--		data: 			in std_logic_vector(data_width - 1 downto 0);
--		wren: 			in std_logic;
--		q:					out std_logic_vector(data_width - 1 downto 0)
--	);	
--	
--	
--
--end entity;
--
--
--
--
--architecture rtl of ram1port is
--	type mem is array(0 to (2**address_width) - 1) of std_logic_vector(data_width - 1 downto 0);
--	
--	signal ram_block: mem;
--	signal read_address_reg: std_logic_vector(data_width - 1 downto 0);
--	
--begin
--
--	process(clock)
--	begin
--		if reset = '0' then
--			ram_block <= (others => (others => '0'));
--		elsif rising_edge(clock) then
--			if (wren = '1') then
--				ram_block(to_integer(unsigned(address))) <= data;				
--			end if;
--			
--			read_address_reg <= ram_block(to_integer(unsigned(address)));
--			
--		
--		end if;
--	
--	end process;
--	
--	q <= read_address_reg;
--
--end architecture;


entity ram1port is
	
	port(

end entity;




