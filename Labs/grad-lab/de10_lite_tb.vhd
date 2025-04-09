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


	procedure SetClr(clr: in std_logic; signal key: out std_logic_vector) is
	begin
		key(1) <= clr;
	end procedure;
	
	procedure SetLinkLengthVector(len: std_logic_vector(3 downto 0); signal sw: out std_logic_vector) is
	begin
		sw(4 downto 1) <= len;
	end procedure;
	
	procedure SetLinkLengthInt(len: integer range 0 to 15; signal sw: out std_logic_vector) is
	begin
		sw(4 downto 1) <= std_logic_vector(to_unsigned(len, 4));
	end procedure;
	
	
	procedure SetDirection(dir: std_logic; signal sw: out std_logic_vector) is
	begin
		sw(0) <= dir;
	end procedure;
	
	
	procedure IncreaseTestNumber(signal num: out integer) is
	begin
		num <= num + 1;
	end procedure;
	



constant COUNTS_PER_TICK: integer := 4;


constant CLK_PER: time := 20 ns;
constant clk_cycle:time := 2*clk_per;



	function GetTimeForTicks(ticks: integer) return time is
	begin
		return CLK_PER * COUNTS_PER_TICK * ticks;
	end function;


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

signal test_number: integer := 0;


begin
    
    clk <= not clk after CLK_PER/2; -- generate a 50MHz clock signal, continuously toggling

    
    vectors:process 
		
	begin -- put you test vectors here, remember to advance the simulation in modelsim
        --aclr_n <= '0';         -- assert the asynchronous reset signal

        --aclr_n <= '0';         -- assert the asynchronous reset signal
        SetClr('0', key);
		sw     <= "0000000000"; -- drive all the switch inputs to a 0
        wait for 5 ns;             -- wait for a fraction of the clock so stimulus is not occurring on clock edges
        --aclr_n <= '1';             -- release the reset signal
		
		
		
		-- At a minimum, tests for each direction will include:
			-- TEST 1: A noticible link length number to test the direction (7 or 8)
			-- TEST 2: A larger link length (11-13)
			-- TEST 3: A small link length (3-5)
			-- TEST 4: Maximum link length (15)
			-- TEST 5: Minimum link length OFF (0)
			-- TEST 6: Set back to a normal length (6)
		


		SetClr('1', key);
		
		for i in std_logic range '1' downto '0' loop
			test_number <= 0;			-- Reset test number for direction
			SetDirection(i, sw);
		
			-- TEST 1: A noticible link length number to test the direction (7 or 8)
			IncreaseTestNumber(test_number);
			SetLinkLengthInt(8, sw);
			wait for GetTimeForTicks(4);
			
			-- TEST 2: A larger link length (11-13)
			IncreaseTestNumber(test_number);
			SetLinkLengthInt(11, sw);
			wait for GetTimeForTicks(5);
			
			-- TEST 3: A small link length (3-5)
			IncreaseTestNumber(test_number);
			SetLinkLengthInt(4, sw);
			wait for GetTimeForTicks(3);
			
			-- TEST 4: Maximum link length (15)
			IncreaseTestNumber(test_number);
			SetLinkLengthInt(15, sw);
			wait for GetTimeForTicks(3);
			
			-- TEST 5: Minimum link length OFF (0)
			IncreaseTestNumber(test_number);
			SetLinkLengthInt(0, sw);
			wait for GetTimeForTicks(3);
			
			-- TEST 6: Set back to a normal length (6)
			IncreaseTestNumber(test_number);
			SetLinkLengthInt(6, sw);
			wait for GetTimeForTicks(4);
			
		
		end loop;
		
        
        -- add more vectors to test everything
        
        end process;

key(1) <= aclr_n;
key(0) <= clk;
        

-- instantiate the device under test (dut)
dut: entity work.de10_lite_base
generic map(
	counts_per_tick => COUNTS_PER_TICK
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