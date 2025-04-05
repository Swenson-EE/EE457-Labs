library ieee;
use ieee.std_logic_1164.all;



package SevenSegment is
	type SevenSegDec is (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, dError);
	
	-- Get's 1's place of an integer. Assumes value less than 100
	function get1place(input_val: integer) return integer;
	
	-- Get's 10's place of an integer. Assumes value less than 100
	function get10place(input_val: integer) return integer;
	
	-- Translates a 4 bit logic vector into a seven segment value
	function DecodeVectorToSevenSeg(input_val: std_logic_vector(3 downto 0)) return std_logic_vector;
		
	-- Translates a decimal from 0 to 9 into seven segment value
	-- Any value above 9 just returns the default E
	function DecodeDecimalToSevenSeg(input_val: integer) return std_logic_vector;
	
	
end package;


package body SevenSegment is
	
	-- Get's 1's place of an integer. Assumes value less than 100
	function get1place(input_val: integer) return integer is
	begin
		return input_val mod 10;
	end function;
	
	-- Get's 10's place of an integer. Assumes value less than 100
	function get10place(input_val: integer) return integer is
	begin
		return input_val / 10;
	end function;
	
	
	
	-- Translates a 4 bit logic vector into a seven segment value
	function DecodeVectorToSevenSeg(input_val: std_logic_vector(3 downto 0)) return std_logic_vector is
	begin
		case input_val is
			when "0000"	=> return "11000000";
			when "0001" => return "11111001";
			when "0010" => return "10100100";
			when "0011" => return "10110000";
			when "0100" => return "10011001";
			when "0101" => return "10010010";
			when "0110" => return "10000010";
			when "0111" => return "11111000";
			when "1000" => return "10000000";
			when "1001" => return "10010000";
			when "1010" => return "10001000";
			when "1011" => return "10000011";
			when "1100" => return "11000110";
			when "1101" => return "10100001";
			when "1110" => return "10000110";
			when "1111" => return "10001110";
	
			when others => return "00000000";
		
		end case;
		
	end function;
	
	
	-- Translates a decimal from 0 to 9 into seven segment value
	-- Any value above 9 just returns the default E
	function DecodeDecimalToSevenSeg(input_val: integer) return std_logic_vector is
	begin
		case input_val is
			when 0 => return "11000000";
			when 1 => return "11111001";
			when 2 => return "10100100";
			when 3 => return "10110000";
			when 4 => return "10011001";
			when 5 => return "10010010";
			when 6 => return "10000010";
			when 7 => return "11111000";
			when 8 => return "10000000";
			when 9 => return "10010000";
			when others => return "10000110";
		
		end case;
		
	end function;
	
	

end package body;

