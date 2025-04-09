library ieee;
use ieee.std_logic_1164.all;

package Types is
	
	--type state_t is (IDLE, UPDATE, ERROR);
	
	type direction_t is (FORWARD, BACKWARD);
	
	subtype LinkVector is std_logic_vector(15 downto 0);
	

	
	
	
	constant HEX_a: 	integer := 0;
	constant HEX_b: 	integer := 1;
	constant HEX_c: 	integer := 2;
	constant HEX_d: 	integer := 3;
	constant HEX_e: 	integer := 4;
	constant HEX_f: 	integer := 5;
	constant HEX_g: 	integer := 6;
	constant HEX_dp:	integer := 7;
	
	
end package;



package body Types is
	

end package body;

