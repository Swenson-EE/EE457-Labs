library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.CommonTypes.all;
use work.PWM_Types.all;


entity de10_lite_base is
	generic (
		--counts_per_tick: positive := 50_000_000 / 10
		slow_speed_count: 		integer range 0 to 50_000_000 := 50_000_000;
		fast_speed_count: 		integer range 0 to 50_000_000 := 25_000_000;
		pwm_counts_per_tick: 	integer range 0 to 50_000_000 := 10_000_000
	);
	port (
		--clocks
		MAX10_CLK1_50 : in std_logic;
		--seven seg
		HEX0, HEX1, HEX2,
		HEX3, HEX4, HEX5 :    out    std_logic_vector(7 downto 0);
		--general human interface
		KEY : in std_logic_vector(1 downto 0);
		SW : in  std_logic_vector(9 downto 0);
		LEDR : out std_logic_vector(9 downto 0)
	);
end entity;

architecture de10_lite of de10_lite_base is

   signal state_tick: std_logic := '0';
	signal pwm_tick: std_logic := '0';
	
	signal reset: std_logic := '0';
	signal speed: std_logic := '0';
	
	signal duty_cycle_state: duty_cycle_states_t;
	
	signal duty_cycles: LED_Array := (others => 0);
	
	

begin
	
	reset_sync: entity work.ResetSynchronizer
		port map(
			aclrn => KEY(0),
			clk => MAX10_CLK1_50,
			reset => reset
		);
		
	speed_sync: entity work.InputSynchronizer
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			async_in => SW(0),
			sync_out => speed
		);

	
--	tick_counter: entity work.Counter
--		generic map(
--			counts_per_tick => counts_per_tick
--		)
--		port map(
--			clk => MAX10_CLK1_50,
--			reset => reset,
--			tick => tick
--		);
	
	two_speed_tick_counter: entity work.TwoSpeedTickCounter
		generic map(
			slow_speed_count => slow_speed_count,
			fast_speed_count => fast_speed_count
		)
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			speed => speed,
			
			tick => state_tick
		);

	pwm_tick_counter: entity work.Counter
		generic map(
			counts_per_tick => pwm_counts_per_tick
		)
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			
			tick => pwm_tick
		);
		
		
		
	state_machine: entity work.StateMachine
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			tick => state_tick,
			
			duty_cycle_state => duty_cycle_state
		);
		
	
    
end architecture;