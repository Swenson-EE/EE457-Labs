library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.SevenSegment.all;



entity RamDisplay is

	port(
		clk:						in std_logic; -- system clock
		reset:					in std_logic; -- reset signal
		write_address:			in std_logic_vector(4 downto 0);
		read_address:			in std_logic_vector(4 downto 0);
		data_in:					in std_logic_vector(3 downto 0);
		data_out:				in std_logic_vector(3 downto 0);	
		
		HEX0, HEX1, HEX2,
		HEX3, HEX4, HEX5:		out std_logic_vector(7 downto 0)
		
	);

end entity;



architecture rtl of RamDisplay is
	constant HEX_CLEAR: std_logic_vector(7 downto 0) := "11111111";
	
begin
	
	
	display_process: process(clk, reset)
		
		variable read_address10: integer;
		variable read_address1: integer;
		
		variable write_address10: integer;
		variable write_address1: integer;
		
	
	
	begin
		if reset = '0' then
			HEX0 <= HEX_CLEAR;
			HEX1 <= HEX_CLEAR;
			HEX2 <= HEX_CLEAR;
			HEX3 <= HEX_CLEAR;
			HEX4 <= HEX_CLEAR;
			HEX5 <= HEX_CLEAR;
		elsif rising_edge(clk) then
			HEX0 <= HEX_CLEAR;
			HEX1 <= HEX_CLEAR;
			HEX2 <= HEX_CLEAR;
			HEX3 <= HEX_CLEAR;
			HEX4 <= HEX_CLEAR;
			HEX5 <= HEX_CLEAR;
			
			
			
			 -- Hex 3 and 2 show the read address
			read_address10 := get10place(to_integer(unsigned(read_address)));
			read_address1 := get1place(to_integer(unsigned(read_address)));
			
			HEX3 <= DecodeDecimalToSevenSeg(read_address10);
			HEX2 <= DecodeDecimalToSevenSeg(read_address1);
			
			
			-- Hex 5 and 4 show the write address
			write_address10 := get10place(to_integer(unsigned(write_address)));
			write_address1 := get1place(to_integer(unsigned(write_address)));
			
			HEX5 <= DecodeDecimalToSevenSeg(write_address10);
			HEX4 <= DecodeDecimalToSevenSeg(write_address1);
			
			-- Hex 1 shows the write data
			HEX1 <= DecodeVectorToSevenSeg(data_in);
			
			
			-- Hex 0 shows the read data
			HEX0 <= DecodeVectorToSevenSeg(data_out);
			
			
			
		
		
		end if;
			
		
	
	end process;
	
	

end architecture;




