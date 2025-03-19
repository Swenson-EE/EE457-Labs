library ieee;
use ieee.std_logic_1164.all;


library work;
use work.LED.all;
use work.WasherTypes.all;



entity WasherStateMachine is

	port(
		clk				: in std_logic;
		tick				: in std_logic;
		
		reset				: in std_logic;
		emergency_stop	: in std_logic;
		
		on_off_switch	: in std_logic;
		cycle_switch	: in std_logic;
		
		--cycle_out		: out cycle_t;
		--water_out		: out water_t;
		
		--state_out		: out state_t
		
		state_out			: out state_t;
		cycle					: inout cycle_t;
		water					: inout water_t;
		tick_counter		: inout integer
		
		-- wash_done, spin_done, rinse_done			: inout std_logic
		-- wash_done_out, spin_done_out, rinse_done_out : inout std_logic
		
	);


end entity;




architecture rtl of WasherStateMachine is
	signal current_state, next_state: state_t := OFF;
	--signal next_state: state_t;
	
	--signal start, stop: std_logic := 0;
	
	--signal cycle: cycle_t := standard_wash;
	-- signal water: water_t := EMPTY;
	
	signal on_off_edge_detect: std_logic := '0';
	signal emergency_stop_detect: std_logic := '0';
	
	-- signal tick_counter: integer := 0;
	-- signal current_state_tick, next_state_tick: integer := 0;
	
	
	signal running: std_logic := '0';
	signal wash_done, spin_done, rinse_done: std_logic := '0';
	
	
	
	
begin

	edge_detector : entity work.AnyEdgeDetector
		port map(
			clk => clk,
			reset => reset,
			async_in => on_off_switch,
			detect_out => on_off_edge_detect
		);
		
	emergency_button_edge_detector : entity work.AnyEdgeDetector
		port map(
			clk => clk,
			reset => reset,
			async_in => emergency_stop,
			detect_out => emergency_stop_detect
		);
		
		

	
	-- process to control state transitions
	process(clk, reset, current_state, on_off_switch, water, emergency_stop)
	begin
		if reset = '0' then
			current_state <= OFF;
			tick_counter <= 0;
			
		
		elsif rising_edge(clk) then
--			case current_state is
--				when OFF =>
--					if (on_off_edge_detect = '1' and on_off_switch = '1') then
--						next_state <= FILL;
--					end if;
--					
--				when others =>	
--				
--				
--			end case;

			-- determine running flag
			case current_state is
				when OFF =>
					if cycle_switch = '1' then
						cycle <= standard_wash;
					else
						cycle <= soak_n_spin;
					end if;
					
					if (on_off_edge_detect = '1' and on_off_switch = '1') then
						running <= '1';
					end if;
					
				when DONE =>
					if (on_off_edge_detect = '1' and on_off_switch = '0') then
						running <= '0';
					end if;
					
				when others =>
					
			end case;
			
			
			
			
			-- Handle immediate emergency stop
			if (emergency_stop_detect = '1' and emergency_stop = '0') and current_state /= OFF then
				tick_counter <= 0;
				
				if water = EMPTY then
					current_state <= DONE;
				else
					current_state <= DRAIN;
				end if;
			
			else
				-- tick update logic
				if tick = '1' then
					if current_state /= next_state then
						current_state <= next_state;
						tick_counter <= 0;
						
					else
						tick_counter <= tick_counter + 1;
						
					end if; -- current_state
				
				end if; -- tick
			end if;
			

		
			
		end if;
	end process;
	
	
	-- determine next_state based on current_state and inputs
	process(current_state, tick_counter, running, cycle)
	begin
		-- default assignments
		next_state <= current_state;
		water <= EMPTY;
		
--		spin_done <= spin_done_out;
--		rinse_done <= rinse_done_out;
--		wash_done <= wash_done_out;
		
		
		
		case current_state is
				when OFF =>
--					if (on_off_edge_detect = '1' and on_off_switch = '1') then
--						next_state <= FILL;
--					end if;

					if running = '1' then
						next_state <= FILL;
					end if;
					
					
				
				when FILL =>
					if tick_counter = T_FILL then
						water <= FULL;
						
						if wash_done = '0' then
							next_state <= WASH;
						else
							next_state <= RINSE;
						end if;
						
					elsif tick_counter > 0 then
						water <= INTERMEDIATE;
					else
						water <= EMPTY;
					end if;
					
				when RINSE =>
					water <= FULL;
					rinse_done <= '1';
					next_state <= SPIN;
					
					
				when SPIN =>
					water <= FULL;
					spin_done <= '1';
					next_state <= DRAIN;
					
					
				when WASH =>
					water <= FULL;
					wash_done <= '1';
					
					if cycle = standard_wash then
						next_state <= DRAIN;
					else
						next_state <= SPIN;
					end if;
				
				when DRAIN =>
					if tick_counter = T_DRAIN then
						water <= EMPTY;
						
						if cycle = standard_wash and spin_done = '0' then
							next_state <= FILL;
						else
							next_state <= DONE;
						end if;
						
						
					elsif tick_counter > 0 then
						water <= INTERMEDIATE;
					else
						water <= FULL;
					end if;
				
				when DONE =>
--					if next_state /= OFF then
--						if (on_off_edge_detect = '1' and on_off_switch = '0') then
--							next_state <= OFF;
--						end if;
--					end if;
					if running = '0' then
						next_state <= OFF;
					end if;
					
				
				when others =>
					
				
			end case;
		
	
		
	end process;
	
	
	
	
	
	state_out <= current_state;
	
--	wash_done_out <= wash_done;
--	spin_done_out <= spin_done;
--	rinse_done_out <= rinse_done;
	
	

end architecture;
