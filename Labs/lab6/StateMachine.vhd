library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity StateMachine is
	port (
		clk			: in std_logic;
		reset			: in std_logic;
		direction	: in std_logic;
		
		state_out	: out std_logic_vector(3 downto 0)			-- 2^3 states
	);
end entity;




architecture rtl of StateMachine is
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
	
	signal current_state, next_state: state_type;
begin
	
	
	-- process to control state transitions
	process (clk, reset)
	begin
		if reset = '0' then
			current_state <= STATE_0;
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process;
	
	
	
	-- determine next_state based on current_state and inputs
	process(all)
		constant forward_direction: std_logic := '1';
	begin		-- take direction = '1' as forward
		case current_state is
			when STATE_0 =>
				if direction = forward_direction then
					next_state <= STATE_1;
				else
					next_state <= STATE_9;
				end if;
				
			when STATE_1 =>
				if direction = forward_direction then
					next_state <= STATE_2;
				else
					next_state <= STATE_0;
				end if;
				
			when STATE_2 => 
				if direction = forward_direction then
					next_state <= STATE_3;
				else
					next_state <= STATE_1;
				end if;
				
			when STATE_3 =>
				if direction = forward_direction then
					next_state <= STATE_4;
				else
					next_state <= STATE_2;
				end if;
				
			when STATE_4 =>
				if direction = forward_direction then
					next_state <= STATE_5;
				else
					next_state <= STATE_3;
				end if;
				
			when STATE_5 =>
				if direction = forward_direction then
					next_state <= STATE_6;
				else
					next_state <= STATE_4;
				end if;
				
			when STATE_6 =>
				if direction = forward_direction then
					next_state <= STATE_7;
				else
					next_state <= STATE_5;
				end if;
				
			when STATE_7 =>
				if direction = forward_direction then
					next_state <= STATE_8;
				else
					next_state <= STATE_6;
				end if;
				
			when STATE_8 =>
				if direction = forward_direction then
					next_state <= STATE_9;
				else
					next_state <= STATE_7;
				end if;
				
			when STATE_9 =>
				if direction = forward_direction then
					next_state <= STATE_0;
				else
					next_state <= STATE_8;
				end if;
		end case;
					
		
	end process;
	
	


end architecture;
