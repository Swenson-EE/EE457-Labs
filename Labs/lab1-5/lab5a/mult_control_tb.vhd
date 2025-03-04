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
-- Module Name: mult_control_tb        File Name: mult_control_tb.vhd          *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- to VHDL lab 5a                                                              *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- Insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_control_tb is
end entity mult_control_tb;

architecture stimulus of mult_control_tb is

    -- component declaration for the dut
    -- component mult_control
    -- 	port (
    -- 		clk, reset_a, start : in std_logic;
    -- 		count : in unsigned (1 downto 0);
    -- 		input_sel, shift_sel : out unsigned(1 downto 0);
    -- 		state_out : out unsigned(2 downto 0);
    -- 		done, clk_ena, sclr_n : out std_logic
    -- 	);
    -- end component mult_control;	

    -- signals to connect to dut
    signal clk, reset_a, start : std_logic;
    signal count : unsigned (1 downto 0);
    signal input_sel, shift_sel : unsigned (1 downto 0);
    signal state_out : unsigned (2 downto 0);	
    signal done, clk_ena, sclr_n : std_logic;
    
begin  -- beginning of architecture body

    -- instantiate unit under test (control)
    mult_control1 : entity work.mult_control 
        port map (
            clk => clk, 
            reset_a => reset_a, 
            count => count, 
            input_sel => input_sel,
            shift_sel => shift_sel, 
            state_out => state_out, 
            done => done, 
            clk_ena => clk_ena, 
            sclr_n => sclr_n, 
            start => start
        );
        
    -- process to create clock signal
    clk_proc : process
    begin
        clk <= '0';
        wait for 25 ns;
        clk <= '1';
        wait for 25 ns;
    end process clk_proc;

    -- set the reset control
    reset_a	 <= '1', '0' after 50 ns;
    
    -- process to control counter
    counter_proc : process
    begin
        count <= "00";
        wait for 125 ns;
        for i in 0 to 3 loop
            count <= count + 1;
            wait for 50 ns;
        end loop;
        wait;
    end process counter_proc;
    
    -- start signal control
    start <= '0', '1' after 50 ns, '0' after 100 ns;
        
end architecture stimulus;