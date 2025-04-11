library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ram2port is
	generic(
		data_width: positive := 4;
		address_width: positive := 5
	);
	
	port(
		clock:				in std_logic := '0';	-- system clock
		reset:				in std_logic := '1';	-- reset signal
		
		read_address:		in std_logic_vector(address_width - 1 downto 0); -- Address to read from RAM
		write_address:		in std_logic_vector(address_width - 1 downto 0); -- Address to write to RAM
		
		data:					in std_logic_vector(data_width - 1 downto 0); -- Data to write to RAM
		write_enable:		in std_logic := '0';	-- Write enable signal
		
		q:						out std_logic_vector(data_width - 1 downto 0) -- Output data read from RAM
	);

end entity;




architecture rtl of ram2port is
	
	type mem is array(0 to 2**address_width - 1) of std_logic_vector(data_width - 1 downto 0);
	signal ram_block: mem;
	
	-- MIF File init
	attribute ram_init_file: string;
	attribute ram_init_file of ram_block: signal is "ram32x4.mif";
	
	
	signal read_address_reg: integer range 0 to 2**address_width - 1;
	
begin

	process(clock)
	begin
		if rising_edge(clock) then
			if write_enable = '1' then
				ram_block(to_integer(unsigned(write_address))) <= data;
			end if;
			
			read_address_reg <= to_integer(unsigned(read_address));
		end if;
	
	end process;


	q <= ram_block(read_address_reg);

end architecture;

