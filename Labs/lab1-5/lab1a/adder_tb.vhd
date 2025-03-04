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
-- Module Name: adder_tb                        File Name: adder_tb.vhd        *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- to VHDL lab 1a                                                              *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end entity adder_tb;

architecture stimulus of adder_tb is
        -- component declaration for adder block
        -- as a template for your entity, but we're using direct instantiation below
        -- so this isn't required
        -- component adder
        -- port(
        --      dataa, datab: in unsigned(15 downto 0);
        --      sum: out unsigned(15 downto 0)
        -- );
        -- end component;

    -- signals to connect to dut
    signal dataa, datab, sum : unsigned (15 downto 0);

begin  -- beginning of architecture body

    -- direct instantiation unit under test (entity name adder, only one architecture so optional)
    adder1 : entity work.adder port map (
        dataa => dataa, 
        datab => datab, 
        sum => sum
    );

    -- assign values to "dataa" and "datab" to test adder block
    dataa <= x"0008", x"0000" after 20 ns, x"000a" after 30 ns;
    datab <= x"0005", x"0001" after 20 ns, x"0005" after 30 ns;
        
end architecture stimulus;