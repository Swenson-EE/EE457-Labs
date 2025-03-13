library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.StateTypes.all;

entity de10_lite_base is

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
    signal MAX10_CLK2	: std_logic;
	 signal reset : std_logic := '1';
	 signal hold: std_logic := '1';
	 signal direction: std_logic := '1';
	 
	 signal current_state: state_type := STATE_0;

begin
	
	-- Reset synchronizer
	reset_sync: entity work.Synchronizer port map(
		clk => MAX10_CLK1_50,
		async_in => KEY(0),
		sync_out => reset
	);
	
	-- Hold synchronizer
	hold_sync: entity work.Synchronizer port map(
		clk => MAX10_CLK1_50,
		async_in => KEY(1),
		sync_out => hold
	);
	
	-- Direction synchronizer
	dir_sync: entity work.Synchronizer port map(
		clk => MAX10_CLK1_50,
		async_in => SW(0),
		sync_out => direction
	);
	
	-- Slow clock
	clk_div: entity work.clockDivider
		generic map(
			counts_per_tick => 4 -- for synthesis
		)
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			slow_clk => MAX10_CLK2
		);
	
	
	state_machine: entity work.StateMachine port map(
		clk => MAX10_CLK2,
		reset => reset,
		hold => hold,
		direction => direction,
		
		state_out => current_state
	);
	
	state_handler: entity work.StateHandler port map(
		clk => MAX10_CLK2,
		state_in => current_state,
		
		HEX0 => HEX0,
		HEX1 => HEX1,
		HEX2 => HEX2,
		HEX3 => HEX3,
		HEX4 => HEX4,
		HEX5 => HEX5
	);
	
	
	
	
    
end architecture;