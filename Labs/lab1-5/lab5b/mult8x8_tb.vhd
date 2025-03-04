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
-- Module Name: mult8x8_tb                  File Name: mult8x8_tb.vhd          *
--                                                                             *
-- Module Function: This file contains the testbench for the Introduction      *
-- 					to VHDL lab 4b									           *
--                                                                             *
-- REVISION HISTORY:                                                           *
--  Revision 1.0    12/05/2009 - Initial Revision  for QII 9.1                 *
--******************************************************************************

-- insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult8x8_tb is
end entity mult8x8_tb;

architecture stimulus of mult8x8_tb is

    -- component declaration for the dut for reference
    -- component mult8x8
    -- 	port (
    -- 		clk, start, reset_a : in std_logic;
    -- 		dataa, datab : in unsigned(7 downto 0);
    -- 		product8x8_out : out unsigned(15 downto 0);
    -- 		seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, done_flag : out std_logic
    -- 	);
    -- end component mult8x8;

    -- signals to connect to dut
    signal clk, start, reset_a : std_logic;
    signal dataa, datab : unsigned (7 downto 0) := x"ff"; -- initialized to 1
    signal product8x8_out : unsigned (15 downto 0);
    signal seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, done_flag : std_logic;
    
begin  -- beginning of architecture body

    -- instantiate unit under test (counter)
    mult8x8_1 : entity work.mult8x8 
        port map (
            clk => clk, 
            start => start, 
            reset_a => reset_a,
            dataa => dataa, 
            datab => datab, 
            product8x8_out => product8x8_out,
            done_flag => done_flag, 
            seg_a => seg_a, 
            seg_b => seg_b, 
            seg_c => seg_c,
            seg_d => seg_d, 
            seg_e => seg_e, 
            seg_f => seg_f, 
            seg_g => seg_g
        );
        
    -- process to create clock signal
    clk_proc : process
    begin
        clk <= '0';
        wait for 25 ns;
        clk <= '1';
        wait for 25 ns;
    end process clk_proc;
    
    -- reset control
    reset_a <= '1', '0' after 50 ns;

    -- set input values to control start signal behavior
    start_proc : process
    begin
        start <= '1';
        wait for 50 ns;
        loop
            start <= '1';
            wait for 50 ns;
            start <= '0';
            wait until falling_edge (done_flag);
            wait for 25 ns;
        end loop;
    end process start_proc;
    
    -- process to control data inputs
    data_proc : process
    begin
        wait until falling_edge (done_flag);
        wait for 25 ns;
        dataa <= dataa + 24;
        datab <= datab + 51;
    end process data_proc;

end architecture stimulus;