library ieee;
use ieee.std_logic_1164.ALL;



package LED is 

	type spin_led_t is (BOTTOM, RIGHT, MID, LEFT, SPIN_OFF, SPIN_ERR);
	
	type fill_led_t is (EMPTY, FILLING, FULL, FILL_OFF, FILL_ERR);
	
	type done_led_t is (D, O, N, E, DONE_OFF, DONE_ERR);

	
	function spin_to_7seg(input_val: spin_led_t) return std_logic_vector;
	function fill_to_7seg(input_val: fill_led_t) return std_logic_vector;
	function done_to_7seg(input_val: done_led_t) return std_logic_vector;
	
	
	function count_to_spin(input_val: integer range 0 to 3) return spin_led_t;
	function count_to_wash(input_val: integer range 0 to 3) return spin_led_t;
	-- function count_to_wash(input_val: integer range 0 to 3) return spin_led_t;
	
	
	
end package;


package body LED is

	function spin_to_7seg(input_val: spin_led_t) return std_logic_vector is
		variable seg_out : std_logic_vector(7 downto 0);
	begin
		case input_val is
			when BOTTOM => seg_out := "11110111";
			when RIGHT => seg_out := "11111011";
			when MID => seg_out := "10111111";
			when LEFT => seg_out := "11101111";
			when SPIN_OFF => seg_out := "11111111";
			when SPIN_ERR => seg_out := "10100011";
			when others => seg_out := "01111111";
		end case;
		
		return seg_out;
		
	
	end function;
	
	
	function fill_to_7seg(input_val: fill_led_t) return std_logic_vector is
		variable seg_out : std_logic_vector(7 downto 0);
	begin
		case input_val is
			when EMPTY => seg_out := "11110111";
			when FILLING => seg_out := "10111111";
			when FULL => seg_out := "11111110";
			when FILL_OFF => seg_out := "11111111";
			when FILL_ERR => seg_out := "10100011";
			when others => seg_out := "01111111";
		end case;
		
		return seg_out;
		
	
	end function;
	

	function done_to_7seg(input_val: done_led_t) return std_logic_vector is
		variable seg_out : std_logic_vector(7 downto 0);
	begin
		case input_val is
			when D => seg_out := "10100001";
			when O => seg_out := "11000000";
			when N => seg_out := "10101011";
			when E => seg_out := "10000110";
			when DONE_OFF => seg_out := "11111111";
			when DONE_ERR => seg_out := "10100011";
			when others => seg_out := "01111111";
		end case;
		
		return seg_out;
		
	
	end function;
	
	
	
	
	function count_to_spin(input_val: integer range 0 to 3) return spin_led_t is
		variable spin_out: spin_led_t := SPIN_OFF;
	begin
		case input_val is
			when 0 => spin_out := BOTTOM;
			when 1 => spin_out := RIGHT;
			when 2 => spin_out := MID;
			when 3 => spin_out := LEFT;
			when others => spin_out := SPIN_ERR;
		end case;
		
		return spin_out;
	end function;
	
	
	function count_to_wash(input_val: integer range 0 to 3) return spin_led_t is
		variable spin_out: spin_led_t := SPIN_OFF;
	begin
		case input_val is
			when 0 => spin_out := LEFT;
			when 1 => spin_out := LEFT;
			when 2 => spin_out := RIGHT;
			when 3 => spin_out := RIGHT;
			when others => spin_out := SPIN_ERR;
		end case;
		
		return spin_out;
	end function;
	
	
	
	
end package body;

