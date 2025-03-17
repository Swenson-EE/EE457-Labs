library ieee;
use ieee.std_logic_1164.all;



package WasherTypes is
	type cycle_t is (standard_wash, soak_n_spin);
	
	type state_t is (OFF, IDLE, FILL, WASH, DRAIN, RINSE, SPIN, DONE);

	type water_t is (EMPTY, INTERMEDIATE, FULL);
	
end package;

