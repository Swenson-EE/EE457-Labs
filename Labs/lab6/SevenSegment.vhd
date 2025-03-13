library ieee;
use ieee.std_logic_1164.ALL;



package SevenSegment is

	constant SEG_b: std_logic_vector(7 downto 0) := "11111111";
	constant SEG_0: std_logic_vector(7 downto 0) := "11000000";
	constant SEG_1: std_logic_vector(7 downto 0) := "11111001";
	constant SEG_2: std_logic_vector(7 downto 0) := "10100100";
	constant SEG_3: std_logic_vector(7 downto 0) := "10110000";
	constant SEG_4: std_logic_vector(7 downto 0) := "10011001";
	constant SEG_5: std_logic_vector(7 downto 0) := "10010010";
	constant SEG_6: std_logic_vector(7 downto 0) := "10000010";
	constant SEG_7: std_logic_vector(7 downto 0) := "11111000";
	constant SEG_8: std_logic_vector(7 downto 0) := "10000000";
	constant SEG_9: std_logic_vector(7 downto 0) := "10010000";
	
	constant SEG_E: std_logic_vector(7 downto 0) := "10000110";
	

	type segment_type is (
		SEGMENT_b,
		SEGMENT_0,
		SEGMENT_1,
		SEGMENT_2,
		SEGMENT_3,
		SEGMENT_4,
		SEGMENT_5,
		SEGMENT_6,
		SEGMENT_7,
		SEGMENT_8,
		SEGMENT_9,
		SEGMENT_E
	);

	function to_seven_segment(input_val: segment_type) return std_logic_vector;

end package;



package body SevenSegment is
	function to_seven_segment(input_val: segment_type) return std_logic_vector is
		variable seg_out : std_logic_vector(7 downto 0);
	begin
		
		case input_val is
			when SEGMENT_b => seg_out := SEG_b;
			when SEGMENT_0 => seg_out := SEG_0;
			when SEGMENT_1 => seg_out := SEG_1;
			when SEGMENT_2 => seg_out := SEG_2;
			when SEGMENT_3 => seg_out := SEG_3;
			when SEGMENT_4 => seg_out := SEG_4;
			when SEGMENT_5 => seg_out := SEG_5;
			when SEGMENT_6 => seg_out := SEG_6;
			when SEGMENT_7 => seg_out := SEG_7;
			when SEGMENT_8 => seg_out := SEG_8;
			when SEGMENT_9 => seg_out := SEG_9;
			when SEGMENT_E => seg_out := SEG_E;
			when others => seg_out := SEG_b;
		end case;
			
		return seg_out;
	
	end function;

end package body;
