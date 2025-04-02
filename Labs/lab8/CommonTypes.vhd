library ieee;
use ieee.std_logic_1164.all;


package CommonTypes is 
	constant RESET_ACTIVE: std_logic := '0';
	
	type state_t is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S_Err);
	constant num_states: natural := 10;
	
	
	subtype position_range is  natural range 0 to (num_states - 1);
	
--	constant DUTY_60_MIN_POS: position_range := 1;
--	constant DUTY_20_MIN_POS: position_range := 2;
--	constant DUTY_10_MIN_POS: position_range := 3;
--	
--	constant DUTY_60_MAX_POS: position_range := 8;
--	constant DUTY_20_MAX_POS: position_range := 7;
--	constant DUTY_10_MAX_POS: position_range := 6;

	constant DUTY_LAG_LED_1_MIN_POS: position_range := 1;
	constant DUTY_LAG_LED_2_MIN_POS: position_range := 2;
	constant DUTY_LAG_LED_3_MIN_POS: position_range := 3;
	
	constant DUTY_LEAD_LED_1_MIN_POS: position_range := 8;
	constant DUTY_LEAD_LED_2_MIN_POS: position_range := 7;
	constant DUTY_LEAD_LED_3_MIN_POS: position_range := 6;
	
	
	
end package;



package body CommonTypes is

end package body;
