library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Types.all;



entity de10_lite_base is
	generic(
		counts_per_tick: integer := 25_000_000
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
	signal reset: std_logic := '1';
	
	signal sw_sync: std_logic_vector(4 downto 0);
	
	signal state: state_t;

begin
	
	reset_sync: entity work.ResetSynchronizer
		port map(
			aclrn => key(0),
			clk => MAX10_CLK1_50,
			reset => reset
		);
		
	input_sync_gen: for i in 0 to 4 generate
		sw_sync_inst: entity work.InputSynchronizer
			port map(
				clk => MAX10_CLK1_50,
				reset => reset,
				async_in => sw(i),
				sync_out => sw_sync(i)
			);
	end generate;
		
	
	tick_counter: entity work.TickGen
		generic map(
			counts_per_tick => counts_per_tick
		)
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			tick => state_tick
		);

		
	state_machine: entity work.StateMachine
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			tick => state_tick,
			
			state_out => state
		);
	


    
end architecture;