LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity de10_lite_tb is  -- Ok for the TB to be empty, it has no inputs or outputs
end entity;

architecture tb of de10_lite_tb is

--Component declaration left for reference
-- component de10_lite_base is
--     generic (
--         COUNTS_PER_TICK : integer
--     );
-- port (
--     --clocks

--     MAX10_CLK1_50            :    in        std_logic;

--     --seven seg
--     HEX0, HEX1, HEX2,
--     HEX3, HEX4, HEX5        :    out    std_logic_vector(7 downto 0);
--     --general human interface
--     KEY                        :    in        std_logic_vector(1 downto 0);
--     SW                            :    in        std_logic_vector(9 downto 0);
--     LEDR                        :    out    std_logic_vector(9 downto 0)

-- );
-- end component;

constant number_of_states: integer := 10;
-- constant slow_clk_wait: time := 1 sec;
constant slow_clk_counts_per_tick: integer := 4;


constant clk_per: time := 20 ns;				-- 50 MHz Clock
constant clk_cycle:time := 2*clk_per;		

signal aclr_n : std_logic;
signal clk    : std_logic := '0';
signal sw     : std_logic_vector(9 downto 0);
signal key    : std_logic_vector(1 downto 0);
signal ledr   : std_logic_vector(9 downto 0);
signal hex0    : std_logic_vector(7 downto 0); -- right most
signal hex1    : std_logic_vector(7 downto 0);    
signal hex2    : std_logic_vector(7 downto 0);    
signal hex3    : std_logic_vector(7 downto 0);    
signal hex4    : std_logic_vector(7 downto 0);    
signal hex5    : std_logic_vector(7 downto 0); -- left most

begin
    
--    clk <= not clk after CLK_PER/2; -- generate a 50MHz clock signal, continuously toggling
    
--    vectors:process begin -- put you test vectors here, remember to advance the simulation in modelsim
--        aclr_n <= '0';         -- assert the asynchronous reset signal
--
--        aclr_n <= '0';         -- assert the asynchronous reset signal
--        sw     <= "0000000000"; -- drive all the switch inputs to a 0
--        wait for 5 ns;             -- wait for a fraction of the clock so stimulus is not occurring on clock edges
--        aclr_n <= '1';             -- release the reset signal
--
--        wait for 2*clk_cycle; --  wait for a number of clock cycles      
--        
--        -- add more vectors to test everything
--        
--        end process;
--
-- key(1) <= aclr_n;
-- key(0) <= clk;




-- instantiate the device under test (dut)
dut: entity work.de10_lite_base
port map (
    --clocks
            
    MAX10_CLK1_50    => clk,
            
    --seven seg
    HEX0         => hex0,
    HEX1         => hex1,
    HEX2         => hex2,
    HEX3         => hex3,
    HEX4         => hex4,
    HEX5         => hex5,
    --general human interface
    KEY          => key,
    SW           => sw,
    LEDR         => ledr

);


	-- Clock process
	clk_process: process
	begin
		wait for clk_per / 2;
		clk <= not clk;
		
	end process;
	
	
	
	vectors: process
	begin
		key(1) <= '1';	-- hold button
		sw(0) <= '1';	-- direction switch
	
		-- Initial reset
		key(0) <= '0';
		wait for 50 ns;
		key(0) <= '1';
		wait for 50 ns;
		
		-- Step through states in the forward direction
		sw(0) <= '1';
		for i in 0 to (number_of_states + 2) loop
			-- wait for slow_clk_wait;
			wait for (clk_per * slow_clk_counts_per_tick);
		end loop;
		
		-- Hold test
		key(1) <= '0';
		wait for (clk_per * slow_clk_counts_per_tick);
		key(1) <= '1';
		
		
		-- reverse direction
		sw(0) <= '0';
		for i in 0 to (number_of_states + 2) loop
			-- wait for slow_clk_wait;
			wait for (clk_per * slow_clk_counts_per_tick);
		end loop;
		
		
		-- reset test
		wait for 100 ns;
		key(0) <= '0';
		wait for 50 ns;
		key(0) <= '1';
		
		-- more state transitions after reset
		for i in 0 to 5 loop
			-- wait for slow_clk_wait;
			wait for (clk_per * slow_clk_counts_per_tick);
		end loop;
		
		
		
	end process;


        


end architecture;