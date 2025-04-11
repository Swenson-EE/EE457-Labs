library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity de10_lite_base is
	generic(
		counts_per_tick: positive := 50_000_000	-- 1 second tick
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
    signal reset: std_logic := '1';
	 signal tick: std_logic := '0';
	 
	 --signal wren_input_sync: std_logic := '0';
	 signal wren_rising_edge: std_logic := '0';
	 
	 signal sw_sync: std_logic_vector(9 downto 0);
	 
	 --signal address: std_logic_vector(4 downto 0);
	 --signal data: std_logic_vector(3 downto 0);
	 
	 signal read_address: integer range 0 to 31 := 0;
	 
	 signal data: std_logic_vector(3 downto 0);
	 

begin

	

	
	-- Synchronize the reset button
	reset_sync: entity work.ResetSynchronizer
		port map(
			aclrn => key(0),
			clk => MAX10_CLK1_50,
			reset => reset
		);		
		
	-- Synchronize all switches
	switch_sync_gen: for i in 0 to 9 generate
		data_sync: entity work.InputSynchronizer
			port map(
				clk => MAX10_CLK1_50,
				reset => reset,
				async_in => sw(i),
				sync_out => sw_sync(i)
			);
	end generate;
	
	
	-- Tick for read address
	tick_gen: entity work.TickGen
		generic map(
			counts_per_tick => counts_per_tick
		)
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			tick => tick
		);
	
	
	-- Used for ram write enable
	wren_rising_edge_detect: entity work.RisingEdgeDetector
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			sync_in => sw_sync(9),
			rising_edge_detect => wren_rising_edge
		);
		
		
	
--	dual_port_ram: entity work.ram32x4
--		port map(
--			clock => MAX10_CLK1_50,
--			data => sw_sync(3 downto 0),
--			rdaddress => std_logic_vector(to_unsigned(read_address, 5)),
--			wraddress => sw_sync(8 downto 4),
--			wren => wren_rising_edge,
--			q => data
--		);

	dual_port_ram: entity work.ram2port
		port map(
			clock => MAX10_CLK1_50,
			reset => reset,
			
			read_address => std_logic_vector(to_unsigned(read_address, 5)),
			write_address => sw_sync(8 downto 4),
			
			data => sw_sync(3 downto 0),
			write_enable => wren_rising_edge,
			
			q => data
		);

	
	
	display: entity work.RamDisplay
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			
			write_address => sw_sync(8 downto 4),
			read_address => std_logic_vector(to_unsigned(read_address, 5)),
			
			data_in => sw_sync(3 downto 0),
			data_out => data,
			
			HEX0 => HEX0,
			HEX1 => HEX1,
			HEX2 => HEX2,
			HEX3 => HEX3,
			HEX4 => HEX4,
			HEX5 => HEX5
			
		);
		
		
		
		
		
	address_counter: process(MAX10_CLK1_50, reset)
	begin
		if reset = '0' then
			read_address <= 0;
		elsif rising_edge(MAX10_CLK1_50) then
			if tick = '1' then
				if read_address = 31 then
					read_address <= 0;
				else
					read_address <= read_address + 1;
				end if;
				
			end if;
		end if;
	
	end process;
		
    
end architecture;