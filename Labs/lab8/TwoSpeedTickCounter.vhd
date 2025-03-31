library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.CommonTypes.all;


entity TwoSpeedTickCounter is
	
	generic (
		max: integer := 50_000_000;			-- maximum counts the counter can get
		slow_speed_count: integer := 50_000_000;	-- slow speed max count
		fast_speed_count: integer := 25_000_000	-- fast speed max count
	);
	port (
		clk:		in std_logic; 	-- input clock
		reset:	in std_logic;	-- reset counter to 0
		speed:	in std_logic;	-- speed select for counter speed
		
		tick:		out std_logic	-- 1 clk period tick when max count reached
		
	);


end entity;



architecture rtl of TwoSpeedTickCounter is
	signal count: integer range 0 to max := 0;
	
	signal max_count: integer range 0 to max;
	
begin

	-- MUX for two speeds
	max_count <= fast_speed_count when (speed = '1') else slow_speed_count;
	
--	if speed = '1' then
--		max_count <= fast_speed_count;
--	else
--		max_count <= slow_speed_count;
--	end if;

	counter: process(clk, reset)
	begin
		if reset = RESET_ACTIVE then
			count <= 0;
			--max_count <= max;
		elsif rising_edge(clk) then
			--max_count <= fast_speed_count when (speed = '1') else slow_speed_count;
			
			-- counter logic
			if count >= (max_count - 1) then
				count <= 0;
			else
				count <= count + 1;
			end if;
			
		end if;	
	
	end process;
	

	-- tick <= '1' when count = (max_count - 1) else '0';
	tick <= '1' when count >= (max_count - 1) else '0';
	
end architecture;






