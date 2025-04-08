library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Types.all;


entity StateMachine is
	
	port(
		clk:				in std_logic;
		reset:			in std_logic;
		tick:				in std_logic;
		
		state_out:		out state_t;
		link_out:		out LinkVector
	);

end entity;



architecture rtl of StateMachine is
	signal current_state, next_state: state_t;
	
	signal current_link, next_link: LinkVector := (others => '0');

begin
	
	process(clk, reset)
	begin
		if reset = '0' then
			current_state <= IDLE;
		elsif rising_edge(clk) then
			if tick = '1' then
				current_state <= next_state;
				
			end if;
			
		end if;
	
	end process;
	
	
	-- Calculate the next link
	link_proc: process
	begin
		
	end process;
	
	
	
	
	
	
	

	state_out <= current_state;
	link_out <= current_link;

end architecture;
