library ieee;
use ieee.std_logic_1164.all;


library work;
use work.LED.all;
use work.WasherTypes.all;


entity WasherAnimation is
	generic(
		counts_per_tick: integer := 50_000_000
	);
	port(
		clk				: in std_logic;
		tick				: in std_logic;
		
		reset				: in std_logic;
		
		state				: in state_t;
		cycle				: in cycle_t;
		water				: in water_t;
		
		
		--seven seg
		HEX0, HEX1, HEX2,
		HEX3, HEX4, HEX5 :    out    std_logic_vector(7 downto 0)
	);

end entity;




architecture rtl of WasherAnimation is
	signal fill_led: fill_led_t := FILL_OFF;
	signal spin_led: spin_led_t := SPIN_OFF;
	
	signal d1, d2, d3, d4: done_led_t := DONE_OFF;
	
	signal quarter_tick: std_logic := '0';
	signal quarter_tick_counter: integer range 0 to 3 := 0;
	
begin

	quarter_tick_gen : entity work.TickGen
		generic map(
			counts_per_tick => counts_per_tick / 4
		)
		port map(
			clk => clk,
			reset => reset,
			tick => quarter_tick
		);

	
	-- Water animation
	process (clk, reset, state, quarter_tick)
	
	begin
		
	
		if reset = '0' then
			fill_led <= FILL_OFF;
			spin_led <= SPIN_OFF;
			
			d1 <= DONE_OFF;
			d2 <= DONE_OFF;
			d3 <= DONE_OFF;
			d4 <= DONE_OFF;
			
		elsif rising_edge(clk) then
			
			fill_led <= FILL_OFF;
			spin_led <= SPIN_OFF;
			
			d1 <= DONE_OFF;
			d2 <= DONE_OFF;
			d3 <= DONE_OFF;
			d4 <= DONE_OFF;
		
			-- water animation
			if state /= OFF then
				case water is
					when EMPTY => fill_led <= EMPTY;
					when INTERMEDIATE => fill_led <= FILLING;
					when FULL => fill_led <= FULL;
					when others => fill_led <= FILL_ERR;
				end case;
			end if;
			
			if state = DONE then
				d1 <= D;
				d2 <= O;
				d3 <= N;
				d4 <= E;
			end if;
			
			
			-- Quarter tick counter
			if quarter_tick = '1' then
				if quarter_tick_counter = 3 then
					quarter_tick_counter <= 0;
				else
					quarter_tick_counter <= quarter_tick_counter + 1;
				end if;
			
			end if;
			
			
			-- Spin animation
			case state is
				when SPIN =>
					spin_led <= count_to_spin(quarter_tick_counter);
					
				when WASH | RINSE =>
					spin_led <= count_to_wash(quarter_tick_counter);
							
				when others =>
					spin_led <= SPIN_OFF;
					
			end case; -- state
			
			
			
		end if;	
	
	end process;
	
	-- Water digit
	HEX5 <= fill_to_7seg(fill_led);
	
	-- Cycle digit
	HEX4 <= spin_to_7seg(spin_led);
	
	-- Done digits
	HEX3 <= done_to_7seg(d1);
	HEX2 <= done_to_7seg(d2);
	HEX1 <= done_to_7seg(d3);
	HEX0 <= done_to_7seg(d4);
	
end architecture;

