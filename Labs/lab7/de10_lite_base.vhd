library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library work;
use work.WasherTypes.all;


entity de10_lite_base is
	generic (
		counts_per_tick: integer := 50_000_000
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
		LEDR : out std_logic_vector(9 downto 0);
		
		TESTING: in cycle_test_t
	);
end entity;

architecture de10_lite of de10_lite_base is
	signal tick: std_logic := '0';

	signal reset : std_logic := '0';
	--signal emergency_stop: std_logic := '0';
	
	-- signal any_edge_detection: std_logic := '0';
	signal cycle_switch: std_logic := '0';
	
	signal cycle: cycle_t := standard_wash;
	signal water: water_t := EMPTY;
	
	signal state: state_t := OFF;
	signal tick_counter: integer := 0;
	
	-- signal wash_done, spin_done, rinse_done: std_logic := '0';
	
	

begin
	
	reset_sync : entity work.ResetSynchronizer
		port map(
			aclrn => KEY(0),
			clk => MAX10_CLK1_50,
			reset => reset
		);

	tick_gen : entity work.TickGen
		generic map(
			counts_per_tick => counts_per_tick
		)
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			tick => tick
		);
		
--	emergency_stop_sync: entity work.InputSynchronizer
--		port map(
--			clk => MAX10_CLK1_50,
--			reset => reset,
--			
--			async_in => key(1),
--			sync_out => emergency_stop
--		);
		
	cycle_switch_sync : entity work.InputSynchronizer
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			
			async_in => sw(0),
			sync_out => cycle_switch
		);
	
	
		
	state_machine: entity work.WasherStateMachine
		port map(
			clk => MAX10_CLK1_50,
			tick => tick,
			
			reset => reset,
			emergency_stop => key(1),
			
			on_off_switch => sw(1),
			cycle_switch => cycle_switch,
			
			
			state_out => state,
			cycle => cycle,
			water => water,
			tick_counter => tick_counter
			
--			wash_done => wash_done,
--			spin_done => spin_done,
--			rinse_done => rinse_done
			
			
			
		);
	
	
	animation: entity work.WasherAnimation
		generic map(
			counts_per_tick => counts_per_tick
		)
		port map(
			clk => MAX10_CLK1_50,
			tick => tick,
			
			reset => reset,
			
			state => state,
			cycle => cycle,
			water => water,
			
			HEX0 => HEX0,
			HEX1 => HEX1,
			HEX2 => HEX2,
			HEX3 => HEX3,
			HEX4 => HEX4,
			HEX5 => HEX5
		);
	
	
		
    
end architecture;