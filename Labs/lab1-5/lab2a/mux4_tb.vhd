-- ******************************************************************************
--                                                                             *
--                  Copyright (C) 2014 Altera Corporation                      *
--                                                                             *
-- ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX    *
-- are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.      *
--                                                                             *
-- All information provided herein is provided on an "as is" basis,            *
-- without warranty of any kind.                                               *
--                                                                             *
-- Module Name: mux4_tb                        File Name: mux4_tb.vhd          *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- to VHDL lab 2a                                                              *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4_tb is
end entity mux4_tb;

architecture stimulus of mux4_tb is

    -- component declaration for multiplier block
    -- again for ref only, un-used due to direct instantiation
    -- component mux4
    --     port ( 
    --     mux_in_a, mux_in_b: in unsigned(3 downto 0);
    --     mux_sel : in std_logic;
    --     mux_out : out unsigned(3 downto 0)
    --     );
    -- end component mux4;

    -- signals to connect to dut
    signal mux_in_a, mux_in_b: unsigned (3 downto 0);
    signal mux_sel : std_logic := '0';
    signal mux_out : unsigned (3 downto 0);

begin  -- beginning of architecture body

    -- instantiate unit under test (mult4x4)
    mux4_1 : entity work.mux4 
        port map (
            mux_in_a => mux_in_a, 
            mux_in_b => mux_in_b,
            mux_sel => mux_sel, 
            mux_out => mux_out
        );

    -- fix mux inputs to input values 9 and 7 respectively
    mux_in_a <= "1001"; -- 9
    mux_in_b <= "0111"; -- 7
    
    -- flip mux_sel between '0' and '1' every 50 ns
    mux_sel <= not mux_sel after 50 ns;
        
end architecture stimulus;