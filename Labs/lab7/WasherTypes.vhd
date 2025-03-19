library ieee;
use ieee.std_logic_1164.all;



package WasherTypes is
	type cycle_t is (standard_wash, soak_n_spin);
	
	type state_t is (OFF, FILL, WASH, DRAIN, RINSE, SPIN, DONE, EMERGENCY_STOP);

	type water_t is (EMPTY, INTERMEDIATE, FULL);
	
	
	
	constant T_FILL: integer := 3;
	constant T_WASH: integer := 6;
	constant T_RINSE: integer := 6;
	constant T_SPIN: integer := 6;
	constant T_DRAIN: integer := 3;
	
	
	function get_state_tick_count(input_val: state_t) return integer;
	
	
	
	
	type cycle_test_t is (STANDARD, STANDARD_EMERGENCY_FULL, STANDARD_EMERGENCY_EMPTY, SOAK, SOAK_EMERGENCY_FULL, SOAK_EMERGENCY_EMPTY);
	
end package;



package body WasherTypes is

	function get_state_tick_count(input_val: state_t) return integer is
		variable tick_count_out: integer;
	begin
		case input_val is
			when FILL => tick_count_out := T_FILL;
			when WASH => tick_count_out := T_WASH;
			when DRAIN => tick_count_out := T_DRAIN;
			when RINSE => tick_count_out := T_RINSE;
			when SPIN => tick_count_out := T_SPIN;
			when others => tick_count_out := 0;
			
		end case;
		
		return tick_count_out;
		
	
	end function;

end package body;
