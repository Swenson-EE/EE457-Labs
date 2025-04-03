library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


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
    signal reset: std_logic := '1';
	 
	 --signal wren_input_sync: std_logic := '0';
	 signal wren_rising_edge: std_logic := '0';
	 
	 signal sw_sync: std_logic_vector(9 downto 0);
	 
	 --signal address: std_logic_vector(4 downto 0);
	 --signal data: std_logic_vector(3 downto 0);
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
	
	-- Used for ram write enable
	wren_rising_edge_detect: entity work.RisingEdgeDetector
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			sync_in => sw_sync(9),
			rising_edge_detect => wren_rising_edge
		);
		
		
	
	single_port_ram: entity work.ram1port
		port map(
			--address => sw(8 downto 4),
			address => sw_sync(8 downto 4),
			clock => MAX10_CLK1_50,
			reset => reset,
			--data => sw(3 downto 0),
			data => sw(3 downto 0),
			wren => wren_rising_edge,
			q => data
		);
	
	
	display: entity work.RamDisplay
		port map(
			clk => MAX10_CLK1_50,
			reset => reset,
			
			address => sw_sync(8 downto 4),
			
			data_in => sw(3 downto 0),
			data_out => data
		);
	
	
    
end architecture;