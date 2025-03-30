LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

library work;
use work.WasherTypes.all;


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
--
--     MAX10_CLK1_50            :    in        std_logic;
--
--     --seven seg
--     HEX0, HEX1, HEX2,
--     HEX3, HEX4, HEX5        :    out    std_logic_vector(7 downto 0);
--     --general human interface
--     KEY                        :    in        std_logic_vector(1 downto 0);
--     SW                            :    in        std_logic_vector(9 downto 0);
--     LEDR                        :    out    std_logic_vector(9 downto 0)
--
-- );
-- end component;

constant CLK_PER: time := 20 ns;
constant clk_cycle:time := 2*clk_per;


constant COUNTS_PER_TICK: integer := 8;
--constant COUNTS_PER_TICK: integer := 50_000_000;

--constant T_FILL: integer := 3;
--constant T_WASH: integer := 6;
--constant T_RINSE: integer := 6;
--constant T_SPIN: integer := 6;
--constant T_DRAIN: integer := 3;


constant T_STATE_TRANSITION_TIME: time := CLK_PER * COUNTS_PER_TICK;



function wait_for_state(state: state_t) return time is
	--variable time_out : time;
	variable mult: integer;
begin

	case state is
		when FILL => mult := T_FILL;
		when WASH => mult := T_WASH;
		when RINSE => mult := T_RINSE;
		when SPIN => mult := T_SPIN;
		when DRAIN => mult := T_DRAIN;
		when others => mult := 0;
	end case;
	
	return T_STATE_TRANSITION_TIME * mult;
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




signal current_test, next_test: cycle_test_t := STANDARD;




begin
    
	-- clk <= not clk after CLK_PER/2; -- generate a 50MHz clock signal, continuously toggling
	
   
--    vectors:process begin -- put you current_test vectors here, remember to advance the simulation in modelsim
--        aclr_n <= '0';         -- assert the asynchronous reset signal
--
--        aclr_n <= '0';         -- assert the asynchronous reset signal
--        sw     <= "0000000000"; -- drive all the switch inputs to a 0
--        wait for 5 ns;             -- wait for a fraction of the clock so stimulus is not occurring on clock edges
--        aclr_n <= '1';             -- release the reset signal
--
--        wait for 2*clk_cycle; --  wait for a number of clock cycles
--        
--        
--        -- add more vectors to current_test everything
--        
--        end process;
--
	-- key(1) <= aclr_n;
	-- key(0) <= clk;
        

-- instantiate the device under current_test (dut)
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
    LEDR         => ledr,

	TESTING => current_test
);



-- AnyEdge current_testbench
--current_testing_any_edge: entity work.any_edge_tb
--port map(
--	clk => clk,
--	aclrn=> key(1),
--	input => sw(1)
--);





	clk <= not clk after CLK_PER/2;
	
	
	
	vectors: process
	begin
		
		current_test <= next_test;
		
		-- initial values
		sw(0) <= '1';
		sw(1) <= '0'; -- on_off_switch
		
		
		-- initial reset
		key(1) <= '1'; -- emergency stop
		key(0) <= '0'; -- reset
		
		hex0 <= "11111111";
		hex1 <= "11111111";
		hex2 <= "11111111";
		hex3 <= "11111111";
		hex4 <= "11111111";
		hex5 <= "11111111";
		
		wait for 50 ns;
		key(0) <= '1';
		wait for 50 ns;
		
		-- current_test standard wash
		
		
		--wait for COUNTS_PER_TICK * T_FILL;
		--wait for COUNTS_PER_TICK * T_WASH;
		--wait for COUNTS_PER_TICK * T_DRAIN;
		--wait for COUNTS_PER_TICK * T_FILL;
		--wait for COUNTS_PER_TICK * T_RINSE;
		--wait for COUNTS_PER_TICK * T_SPIN;
		--wait for COUNTS_PER_TICK * T_DRAIN;
		
		
		
		
		--sw(0) <= '0';
		
		if current_test = STANDARD or current_test = STANDARD_EMERGENCY_FULL or current_test = STANDARD_EMERGENCY_EMPTY then
			sw(0) <= '1'; -- cycle switch (STANDARD = '1')
		else
			sw(0) <= '0'; -- cycle switch (SOAK = '0')
		end if;
		wait for CLK_PER;
		
		case current_test is
			when STANDARD =>
				--sw(0) <= '1'; -- cycle switch (STANDARD = '1')
				sw(1) <= '1'; -- on_off_switch
				
				wait for wait_for_state(FILL);
				wait for wait_for_state(WASH);
				wait for wait_for_state(DRAIN);
				wait for wait_for_state(FILL);
				wait for wait_for_state(RINSE);
				wait for wait_for_state(SPIN);
				wait for wait_for_state(DRAIN);
				
				next_test <= STANDARD_EMERGENCY_FULL;
				
			when STANDARD_EMERGENCY_FULL =>
				--sw(0) <= '1'; -- cycle switch  (STANDARD = '1')
				sw(1) <= '1'; -- on_off_switch
				
				wait for wait_for_state(FILL);
				--wait for wait_for_state(WASH);
				--wait for wait_for_state(DRAIN);
				--wait for wait_for_state(FILL);
				--wait for wait_for_state(RINSE);
				
				-- Emergency stop
				key(1) <= '0';
				wait for wait_for_state(DRAIN) / 2;
				key(1) <= '1';
				wait for wait_for_state(DRAIN) / 2;
				
				wait for T_STATE_TRANSITION_TIME;
				
				next_test <= STANDARD_EMERGENCY_EMPTY;
				
				
			when STANDARD_EMERGENCY_EMPTY =>
				--sw(0) <= '1'; -- cycle switch  (STANDARD = '1')
				sw(1) <= '1'; -- on_off_switch
				
				wait for wait_for_state(FILL);
				wait for wait_for_state(WASH);
				wait for wait_for_state(DRAIN);
				
				-- Emergency stop
				key(1) <= '0';
				wait for 50 ns;
				key(1) <= '1';
				wait for 50 ns;
				
				
				next_test <= SOAK;
			
			when SOAK =>
				--sw(0) <= '0'; -- cycle switch  (SOAK = '0')
				sw(1) <= '1'; -- on_off_switch
				
				wait for wait_for_state(FILL);
				wait for wait_for_state(WASH);
				wait for wait_for_state(SPIN);
				wait for wait_for_state(DRAIN);
				
				next_test <= SOAK_EMERGENCY_FULL;
				
				
			when SOAK_EMERGENCY_FULL =>
				--sw(0) <= '0'; -- cycle switch  (SOAK = '0')
				sw(1) <= '1'; -- on_off_switch
				
				wait for wait_for_state(FILL);
				--wait for wait_for_state(WASH);
				
				-- Emergency stop
				key(1) <= '0';
				--wait for wait_for_state(DRAIN) / 2;
				wait for 50 ns;
				key(1) <= '1';
				wait for wait_for_state(DRAIN);
				
				wait for T_STATE_TRANSITION_TIME;
				
				next_test <= SOAK_EMERGENCY_EMPTY;
				
				
			when SOAK_EMERGENCY_EMPTY =>
				--sw(0) <= '0'; -- cycle switch  (SOAK = '0')
				sw(1) <= '1'; -- on_off_switch
				
				-- Only one drain for soak, so need to immediately hit emergency stop
				
				-- Emergency stop
				key(1) <= '0';
				wait for 50 ns;
				key(1) <= '1';
				
				wait for 50 ns;
				
				next_test <= STANDARD;
			
			when others =>	
				
		end case;
		
		-- Wiggle room after finishing
		wait for T_STATE_TRANSITION_TIME * 6;
		
		sw(1) <= '0';
		wait for T_STATE_TRANSITION_TIME * 6; -- Wait until done state transition to off
		
		wait for CLK_PER * 10; -- ensure proper time has passed
		
		
		
		
		
	end process;


end architecture;