library ieee;
use ieee.std_logic_1164.all;

package StateTypes is

	type state_type is (
		STATE_0,		-- EE457 0		(Starting State)
		STATE_1,		-- bEE45 1
		STATE_2,		-- bbEE4 2
		STATE_3,		-- bbbEE 3
		STATE_4,		-- bbbbE 4
		STATE_5,		-- bbbbb 5
		STATE_6,		-- 7bbbb 6
		STATE_7,		-- 57bbb 7
		STATE_8,		-- 457bb 8
		STATE_9		-- E457b 9
		
		-- Same as START	state
		-- STATE_10,	-- EE457	10
	);

end package;