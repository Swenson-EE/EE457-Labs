-- *****************************************************************************
--                                                                             *
--                  Copyright (C) 2009 Altera Corporation                      *
--                                                                             *
-- ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX    *
-- are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.      *
--                                                                             *
-- All information provided herein is provided on an "as is" basis,            *
-- without warranty of any kind.                                               *
--                                                                             *
-- Module Name: shifter_tb                        File Name: shifter_tb.vhd    *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- to VHDL lab 2b                                                              *
--                                                                             *
-- REVISION HISTORY:                                                           *
--  Revision 1.0    12/05/2009 - Initial Revision  for QII 9.1                 *
--******************************************************************************

-- Insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_tb is
end entity shifter_tb;

architecture stimulus of shifter_tb is

    -- component declaration for the dut for reference
    -- component shifter 
    -- port ( 
    --      input: in unsigned (7 downto 0);
    --      shift_cntrl : in unsigned (1 downto 0);
    --      shift_out : out unsigned (15 downto 0)
    -- 	);
    -- end component shifter;

    -- signals to connect to dut
    signal input : unsigned (7 downto 0);
    signal shift_cntrl : unsigned (1 downto 0) := "00";
    signal shift_out : unsigned (15 downto 0);

begin  -- beginning of architecture body

    -- instantiate unit under test (mult4x4)
    shifter1 : entity work.shifter
        port map (
            input => input, 
            shift_cntrl => shift_cntrl,
            shift_out => shift_out
        );

    -- fix data input to hex value "f4"
    input <= x"f4";
    
    -- create counter on shift control input to cycle through values every 50 ns
    shift_cntrl <= shift_cntrl + 1 after 50 ns;
        
end architecture stimulus;