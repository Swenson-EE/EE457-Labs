library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.SevenSegment.all;



entity RamDisplay is

	port(
		clk:			in std_logic; -- system clock
		reset:		in std_logic; -- reset signal
		address:		in std_logic_vector(4 downto 0);
		data_in:		in std_logic_vector(3 downto 0);
		data_out:	in std_logic_vector(3 downto 0);	
		
		HEX0, HEX1, HEX2,
		HEX3, HEX4, HEX5:	out std_logic_vector(7 downto 0)
		
	);

end entity;



architecture rtl of RamDisplay is
	constant HEX_CLEAR: std_logic_vector(7 downto 0) := "11111111";
	
begin
	
	
	display_process: process(clk, reset)
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
			
			
			-- Hex 5 and 4 display the address
			HEX5 <= DecodeDecimalToSevenSeg( IntegerToDecimal( get10place( to_integer(unsigned(address)) ) ) );
			HEX4 <= DecodeDecimalToSevenSeg( IntegerToDecimal( get1place( to_integer(unsigned(address)) ) ) );
			
			-- Hex 2 display data in
			HEX2 <= DecodeDecimalToSevenSeg( IntegerToDecimal( to_integer(unsigned(data_in)) ) );
			
			
			-- Hex 0 display data out
			HEX0 <= DecodeDecimalToSevenSeg( IntegerToDecimal( to_integer(unsigned(data_out)) ) );
			
			
			
			
		
		
		end if;
			
		
	
	end process;
	
	

end architecture;




