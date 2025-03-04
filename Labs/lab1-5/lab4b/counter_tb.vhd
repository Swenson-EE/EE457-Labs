-- *****************************************************************************
--                                                                             *
--                  Copyright (C) 2014 Altera Corporation                      *
--                                                                             *
-- ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX    *
-- are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.      *
--                                                                             *
-- All information provided herein is provided on an "as is" basis,            *
-- without warranty of any kind.                                               *
--                                                                             *
-- Module Name: counter_tb                  File Name: counter_tb.vhd          *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- 					to VHDL lab 3b									           *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- Insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end entity counter_tb;

architecture stimulus of counter_tb is

    -- component declaration for the dut
    -- component counter
    --  port (
    --      clk, aclr_n : in std_logic;
    --      count_out : out unsigned (1 downto 0)
    --  );
    -- end component counter;

    -- signals to connect to dut
    signal clk, aclr_n : std_logic;
    signal count_out : unsigned (1 downto 0);
    
begin  -- beginning of architecture body

    -- instantiate unit under test (counter)
    counter_1 : entity work.counter 
        port map (
            clk => clk, 
            aclr_n => aclr_n, 
            count_out => count_out
        );
        
    -- process to create clock signal
    clk_proc : process
    begin
        clk <= '0';
        wait for 20 ns;
        clk <= '1';
        wait for 20 ns;
    end process clk_proc;

    -- set input values to test register behavior
    aclr_n <= '0', '1' after 40 ns;
        
end architecture stimulus;