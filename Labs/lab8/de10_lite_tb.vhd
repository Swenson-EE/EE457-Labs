LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

library work;
use work.CommonTypes.all;
use work.PWM_Types.all;



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


constant slow_speed_count: integer range 0 to 50_000_000 := 800;
constant fast_speed_count: integer range 0 to 50_000_000 := 200;
constant pwm_counts_per_tick: integer range 0 to 50_000_000 := 1;


constant CLK_PER: time := 20 ns;
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
    
    clk <= not clk after CLK_PER/2; -- generate a 50MHz clock signal, continuously toggling

    
    vectors:process begin -- put you test vectors here, remember to advance the simulation in modelsim
        aclr_n <= '0';         -- assert the asynchronous reset signal

        aclr_n <= '0';         -- assert the asynchronous reset signal
        sw     <= "0000000000"; -- drive all the switch inputs to a 0
        wait for 5 ns;             -- wait for a fraction of the clock so stimulus is not occurring on clock edges
        aclr_n <= '1';             -- release the reset signal

        --wait for 2*clk_cycle; --  wait for a number of clock cycles
        
        
        -- add more vectors to test everything
		
		-- test slow speed
		key(0) <= '0'; -- reset for testing
		wait for 5 ns;
		key(0) <= '1';
		
		sw(0) <= '0';
		
		wait for clk_cycle * slow_speed_count * 22;
		
		
		-- don't reset to test change somewhere in cycle
		-- test fast speed
		sw(0) <= '1';
		wait for clk_cycle * fast_speed_count * 22;
		
		
		
		
		
        
        end process;

--key(1) <= aclr_n;
--key(0) <= clk;
        

-- instantiate the device under test (dut)
dut: entity work.de10_lite_base
generic map(
	--slow_speed_tick => 400,
	--fast_speed_tick => 200,
	
	--pwm_counts_per_tick => 1
	slow_speed_count => slow_speed_count,
	fast_speed_count => fast_speed_count,
	pwm_counts_per_tick => pwm_counts_per_tick
)
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
end architecture;