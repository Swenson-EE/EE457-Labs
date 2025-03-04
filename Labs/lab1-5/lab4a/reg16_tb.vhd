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
-- Module Name: reg16_tb                      File Name: reg16_tb.vhd          *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- to VHDL lab 4a                                                              *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- Insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16_tb is
end entity reg16_tb;

architecture stimulus of reg16_tb is

    -- component declaration for the dut
    -- component reg16
    --  port (
    --      clk, clk_ena, sclr_n : in std_logic;
    --      datain: in unsigned (15 downto 0);
    --      reg_out : out unsigned (15 downto 0)
    --  );
    -- end component reg16;

    -- signals to connect to dut
    signal clk, clk_ena, sclr_n : std_logic;
    signal datain : unsigned (15 downto 0);
    signal reg_out : unsigned (15 downto 0);
    
begin  -- beginning of architecture body

    -- instantiate unit under test (reg16)
    reg16_1 : entity work.reg16 
        port map (
            clk => clk, 
            clk_ena => clk_ena, 
            sclr_n => sclr_n,
            datain => datain, 
            reg_out => reg_out
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
    reg_proc : process
    begin
        clk_ena <= '0';
        sclr_n <= '0';
        datain <= x"1f1f";
        wait for 40 ns;
        clk_ena <= '1';
        wait for 40 ns;
        sclr_n <= '1';
        wait for 40 ns;
        datain <= x"4567";
        clk_ena <= '0';
        wait for 40 ns;
        clk_ena <= '1';
        wait for 40 ns;
        sclr_n <= '0';
        wait;
    end process reg_proc;
        
end architecture stimulus;