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




	-- Sets the write value to it's place in sw
	procedure SetWriteEnable(wren: in std_logic; signal sw: out std_logic_vector) is
	begin
		sw(9) <= wren;
	end procedure;
	
	
	-- Sets the address to it's place in sw
	procedure SetAddress(address: in integer; signal sw: out std_logic_vector) is
		variable addr: std_logic_vector(4 downto 0);
	begin
		addr := std_logic_vector(to_unsigned(address, addr'length));
		sw(8 downto 4) <= addr;
	end procedure;
	
	
	-- Sets the data value to it's place in sw
	procedure SetData(data: in std_logic_vector(3 downto 0); signal sw: out std_logic_vector) is
	begin
		sw(3 downto 0) <= data;
	end procedure;
	

constant COUNTS_PER_TICK: integer := 2;

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


	function GetTimeForTicks(ticks: integer) return time is
	begin
		return CLK_PER * COUNTS_PER_TICK * ticks;
	end function;
	



begin
    
    clk <= not clk after CLK_PER/2; -- generate a 50MHz clock signal, continuously toggling

    
    vectors:process begin -- put you test vectors here, remember to advance the simulation in modelsim
        aclr_n <= '0';         -- assert the asynchronous reset signal

        --aclr_n <= '0';         -- assert the asynchronous reset signal
        sw     <= "0000000000"; -- drive all the switch inputs to a 0
        SetClr('0', key);
		wait for 5 ns;             -- wait for a fraction of the clock so stimulus is not occurring on clock edges
        --aclr_n <= '1';             -- release the reset signal
		SetClr('1', key);

        wait for 2*clk_cycle; --  wait for a number of clock cycles
        
        
        -- add more vectors to test everything
		
		
		-- Let the process run through all 32 addresses to see that it has the data from the .mif file
		wait for GetTimeForTicks(32);
		
		
		-- Set data to some addresses
		SetAddress(10, sw);
		SetData("1111", sw);
		SetWriteEnable('1', sw);
		wait for GetTimeForTicks(1);
		SetWriteEnable('0', sw);
		wait for GetTimeForTicks(1);
		
		
		SetAddress(11, sw);
		SetData("1110", sw);
		SetWriteEnable('1', sw);
		wait for GetTimeForTicks(1);
		SetWriteEnable('0', sw);
		wait for GetTimeForTicks(1);
		
		
		SetAddress(12, sw);
		SetData("1100", sw);
		SetWriteEnable('1', sw);
		wait for GetTimeForTicks(1);
		SetWriteEnable('0', sw);
		wait for GetTimeForTicks(1);
		
		
		
        
        end process;

--key(1) <= aclr_n;
--key(0) <= clk;
        

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