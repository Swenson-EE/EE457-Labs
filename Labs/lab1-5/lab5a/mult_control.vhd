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
-- Module Name: mult_control               ile Name: mult_control.vhd          *
--                                                                             *
-- Module Function: state machine control logic for the multiplier             *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- Insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- begin entity declaration for "control"
entity mult_control is
    -- begin port declaration
    port (
        -- declare control inputs "clk", "reset_a", "start", "count"
        clk, reset_a, start : in std_logic;
        count : in unsigned (1 downto 0);
        
        -- declare output control signals "in_sel", "shift_sel", "state_out", "done", "clk_ena" and "sclr_n"
        input_sel, shift_sel : out unsigned(1 downto 0);
        state_out : out unsigned(2 downto 0);
        done, clk_ena, sclr_n : out std_logic
    );
-- end entity
end entity mult_control;

--  begin architecture 
architecture logic of mult_control is

    -- declare enumberated state type consisting of 6 values:  "idle", "lsb", "mid", "msb", "calc_done" and "err"
--- ############### ----
--- your logic here ----
--- ############### ----
	type mult_state is (idle, lsb, mid, msb, calc_done, err);
    
    -- declare two signals named "current_state" and "next_state" to be of enumerated type
--- ############### ----
--- your logic here ----
--- ############### ----
	signal current_state, next_state: mult_state;

 
begin
    -- create sequential process to control state transitions by making current_state equal to next state on
    --	rising edge transitions; use asynchronous clear control
    process (clk, reset_a)
		
		begin
			if reset_a = '1' then
				current_state <= idle;
			elsif rising_edge(clk) then
				current_state <= next_state;
			end if;
		
    end process;
    
    -- create combinational process & case statement to determine next_state based on current state and inputs
    process (all)
    --process (current_state, start, count)  -- would also be valid for legacy designs or tools that do not support "all" (a vhdl 2008 feature)
    begin
        case current_state is
				when idle =>
					if start = '1' then
						next_state <= lsb;
					else
						next_state <= idle;
					end if;
-- complete the case statements
--- ############### ----
--- your logic here ----
--- ############### ----
				when lsb =>
					if start = '0'  then
						next_state <= mid;
					else
						next_state <= err;
					end if;
					
				when mid =>
					if start = '0' then
						if count = "01" then
							next_state <= mid;
						elsif count = "10" then
							next_state <= msb;
						else
							next_state <= err;
						end if;
						
					else
						next_state <= err;
					end if;
				
				when msb =>
					if start = '0' and count = "11" then
						next_state <= calc_done;
					else
						next_state <= err;
					end if;
					
				when calc_done =>
					if start = '0' then
						next_state <= idle;
					else
						next_state <= err;
					end if;
					
				when err =>
					if start = '1' then
						next_state <= lsb;
					else
						next_state <= err;
					end if;

        end case;
    -- end process
    end process;

    -- create process for mealy output logic for input_sel, shift_sel, done, clk_ena and sclr_n(outputs function of inputs and current_state)
    mealy: process (all) -- would also be valid for legacy designs or tools that do not support "all" (a vhdl 2008 feature)
    --mealy: process (current_state, start, count) 
    begin
    
        -- initialize outputs to default values so case only covers when they change
        -- #### the following default values may need to be changed ####
        input_sel <= "00";
        shift_sel <= "00";
		  done <= '0';
        clk_ena <= '0';
        sclr_n <= '1';
        
        case current_state is
            when idle =>
                if start = '1' then
							-- 	00		00		0		*1		*0
                    sclr_n <= '0';
                    clk_ena <= '1';
                end if;
-- complete the case statments....
--- ############### ----
--- your logic here ----
--- ############### ----
				when lsb =>
					if start = '0' and count = "00" then
						--	00		00		0		*1		1
						clk_ena <= '1';
					end if;
				
				when mid =>
					if start = '0' and (count = "10" or count = "01") then
						if count = "01" then
							--	01*	01*		0		1*		1
							input_sel <= "01";
							shift_sel <= "01";
							clk_ena <= '1';
							
						elsif count = "10" then
							-- 10*		01*		0		1*		1
							input_sel <= "10";
							shift_sel <= "01";
							clk_ena <= '1';
							
						else -- Error State
							-- 00		00		0		0		1
						
						end if;
					else -- Error State
						-- 00		00		0		0		1
						
					end if;
					
				when msb =>
					if start = '0' and count = "11" then
						-- 11*	10*	0		1*		1
						input_sel <= "11";
						shift_sel <= "10";
						clk_ena <= '1';
					else
						-- 00		00		0		0		1
					end if;
					
				when calc_done =>
					if start = '0' then
						-- 00		00		1*		0		1
						done <= '1';
					else
						-- 00		00		0		0		1
					end if;
						
				when err =>
					if start = '1' then
						-- 00		00		0		1*		0*
						clk_ena <= '1';
						sclr_n <= '0';
					else
						-- 00		00		0		0		1
					end if;
						
					

        end case;
    -- end process
    end process mealy;

    -- create process for moore output logic for state_out  (outputs function of current_state only)
        moore: process(all)
        --moore: process(current_state) -- would also be valid for legacy designs or tools that do not support "all" (a vhdl 2008 feature)
        begin
            -- initialize state_out to default values so case only covers when they change
            state_out <= "000";
            
            case current_state is
                when idle =>
						null;
                when lsb =>
                    state_out <= "001";
-- complete the case statements
--- ############### ----
--- your logic here ----
--- ############### ----
					when mid =>
						state_out <= "010";
					when msb =>
						state_out <= "011";
					when calc_done =>
						state_out <= "100";
					when err =>
						state_out <= "101";
					



            end case;
        -- end process
        end process moore;
-- end architecture
end architecture logic;