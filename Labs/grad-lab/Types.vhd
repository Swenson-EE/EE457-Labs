library ieee;
use ieee.std_logic_1164.all;

package Types is
	
	type state_t is (IDLE, UPDATE, ERROR);
	
	subtype LinkVector is std_logic_vector(15 downto 0);
	
	
end package;



package body Types is


end package body;

