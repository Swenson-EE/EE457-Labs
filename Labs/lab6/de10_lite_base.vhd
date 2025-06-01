library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.StateTypes.all;

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
		LEDR : out std_logic_vector(9 downto 0)
	);
end entity;

architecture de10_lite of de10_lite_base is
	signal tick: std_logic := '0';
	signal reset : std_logic := '1';
	signal hold: std_logic := '1';
	signal direction: std_logic := '1';
	 
	signal current_state: state_type := STATE_0;

begin
	
	-- Reset synchronizer
	reset_sync: entity work.ResetSynchronizer
		port map(
			clk => MAX10_CLK1_50,
			aclrn => KEY(0),
			reset => reset
		);
	
	
	-- Hold synchronizer
	hold_sync: entity work.InputSynchronizer
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			async_in => KEY(1),
			sync_out => hold
		);
	
	-- Direction synchronizer
	dir_sync: entity work.InputSynchronizer
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			async_in => SW(0),
			sync_out => direction
		);
	
	-- Tick gen
	tick_gen: entity work.Counter
		generic map(
			counts_per_tick => counts_per_tick
		)
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			tick => tick
		);
	
	state_machine: entity work.StateMachine port map(
		clk => MAX10_CLK1_50,
		tick => tick,
		reset => reset,
		hold => hold,
		direction => direction,
		
		state_out => current_state
	);
	
	state_handler: entity work.StateHandler port map(
		clk => MAX10_CLK1_50,
		state_in => current_state,
		
		HEX0 => HEX0,
		HEX1 => HEX1,
		HEX2 => HEX2,
		HEX3 => HEX3,
		HEX4 => HEX4,
		HEX5 => HEX5
	);
	
	
	
	
    
end architecture;