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
-- Module Name: seven_segment_cntrl_tb    le Name: seven_segment_cntrl_tb.vhd  *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- to VHDL lab 3                                                               *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- Insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment_cntrl_tb is
end entity seven_segment_cntrl_tb;

architecture stimulus of seven_segment_cntrl_tb is

    -- component declaration for the dut
    -- for reference
    -- component seven_segment_cntrl
    -- port (
    --      input : in unsigned(2 downto 0);
    --      seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g : out std_logic
    -- 
    -- end component seven_segment_cntrl;

    -- signals to connect to dut
    signal input : unsigned (2 downto 0) := "000";
    signal seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g : std_logic;

begin  -- beginning of architecture body

    -- instantiate unit under test (mult4x4)
    seven_segment_cntrl1 : entity work.seven_segment_cntrl 
        port map (
            input => input, seg_a => seg_a, seg_b => seg_b, seg_c => seg_c,
            seg_d => seg_d, seg_e => seg_e, seg_f => seg_f, seg_g => seg_g
        );

    -- set input equal to values 0 - 7 for  50 ns each
    input <= input + 1 after 50 ns;
        
end architecture stimulus;