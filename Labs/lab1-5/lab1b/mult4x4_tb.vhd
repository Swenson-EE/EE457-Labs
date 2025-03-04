--******************************************************************************
--                                                                             *
--                  Copyright (C) 2014 Altera Corporation                      *
--                                                                             *
-- ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX    *
-- are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.      *
--                                                                             *
-- All information provided herein is provided on an "as is" basis,            *
-- without warranty of any kind.                                               *
--                                                                             *
-- Module Name: mult4x4_tb                     File Name: mult4x4.vhd          *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- to VHDL lab 1b                                                              *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult4x4_tb is
end entity mult4x4_tb;

architecture stimulus of mult4x4_tb is

    -- component declaration for multiplier block
    -- again for ref only, un-used due to direct instantiation
    -- component mult4x4
    --  port(
    --      dataa, datab: in unsigned(3 downto 0);
    --      product: out unsigned(7 downto 0)
    --  );
    -- end component;

    -- signals to connect to dut
    signal dataa, datab: unsigned (3 downto 0) := "0000";
    signal product : unsigned (7 downto 0);

begin  -- beginning of architecture body

    -- direct instantiate unit under test (mult4x4)
    mult4x4_1 : entity work.mult4x4 port map (
        dataa => dataa, 
        datab => datab, 
        product => product
    );

    -- add 2 to previous value of "dataa" after ever 10 ns
    dataa <= dataa + 3 after 10 ns;
    
    -- fix "datab" at the value of 2
    datab <= "0010";
        
end architecture stimulus;