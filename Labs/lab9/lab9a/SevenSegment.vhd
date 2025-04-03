library ieee;
use ieee.std_logic_1164.all;



package SevenSegment is
	type SevenSegDec is (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, dError);
	
	-- Get's 1's place of an integer. Assumes value less than 100
	function get1place(input_val: integer) return integer;
	
	-- Get's 10's place of an integer. Assumes value less than 100
	function get10place(input_val: integer) return integer;
	
	
	
	
	-- Translates integer value to sevenseg decimal type
	function IntegerToDecimal(input_val: integer) return SevenSegDec;
	
	function DecodeDecimalToSevenSeg(input_val: SevenSegDec) return std_logic_vector;
	
	
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
	
	
	
	function IntegerToDecimal(input_val: integer) return SevenSegDec is
	begin
		case input_val is
			when 0 => return d0;
			when 1 => return d1;
			when 2 => return d2;
			when 3 => return d3;
			when 4 => return d4;
			when 5 => return d5;
			when 6 => return d6;
			when 7 => return d7;
			when 8 => return d8;
			when 9 => return d9;
			when others => return dError;
		end case;
		
	
	end function;


	function DecodeDecimalToSevenSeg(input_val: SevenSegDec) return std_logic_vector is
	begin
		case input_val is
			when d0 => return "11000000";
			when d1 => return "11111001";
			when d2 => return "10100100";
			when d3 => return "10110000";
			when d4 => return "10011001";
			when d5 => return "10010010";
			when d6 => return "10000010";
			when d7 => return "11111000";
			when d8 => return "10000000";
			when d9 => return "10010000";
			when others => return "10000110";
		
		end case;
		
	end function;
	
	

end package body;

