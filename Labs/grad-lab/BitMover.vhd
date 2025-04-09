library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Types.all;


entity BitMover is
	generic (
		bit_len: integer := 4
	);
	port (
		clk:				in std_logic;
		reset:			in std_logic;
		hold:				in std_logic;
		
		tick:				in std_logic;
		direction:		in direction_t;
		
		tail_len:		in std_logic_vector(bit_len - 1 downto 0);
		bit_out:			out std_logic_vector(2**bit_len - 1 downto 0)
	);

end entity;





architecture rtl of BitMover is
	signal current_position: integer range 0 to (2**bit_len - 1) := 0;
	signal bit_reg: std_logic_vector(2**bit_len - 1 downto 0);
	
begin

	pos_advance: process(clk, reset)
	begin
		if reset = '0' then
			current_position <= 0;
		elsif rising_edge(clk) then
			if hold = '0' then
				-- Do nothing, just hold current position
		
			elsif tick = '1' then
				if direction = FORWARD then
					if current_position = 15 then
						current_position <= 0;
					else
						current_position <= current_position + 1;
					end if;
				
				else -- backward
					if current_position = 0 then
						current_position <= 15;
					else
						current_position <= current_position - 1;
					end if;
					
				
				end if; -- direction
				
				
			end if; -- tick
			
		
		end if; -- rising_edge(clk)
		
		
	end process;

	
	
	
	pos_to_bit_reg: process(reset, current_position, tail_len)
		variable index: integer range 0 to (2**bit_len) - 1;
		variable tail_length: integer;
		
		constant max_value: integer := 2**bit_len - 1;
	begin
		
		-- When resetting, we want to reset to all 15 segments
		if reset = '0' then
			bit_reg <= (others => '1'); 	-- set all bits to on
			bit_reg(0) <= '0';				-- set the start bit to off
		else
			bit_reg <= (others => '0');
			tail_length := to_integer(unsigned(tail_len));		-- translate the 4 bit tail length into an integer to use
			
			-- To make sure that the bits loop around all 15 bits when shifting, the indices that are on will be determined by
			-- offsetting the current_position by using modulo wrapping that properly wraps around the indices
			-- so that we get the expected behavior for the bit to shift around
			
			-- Using the modulo of the result always keeps the result under the max value (i.e. max_value + 1)
			-- Exiting when the offset is larger than the tail length keeps the result equal to or over 0
			for offset in 0 to 15 loop
				exit when offset > tail_length - 1;		-- ensure that the offset won't dip into indices that would cause an error
				index := (current_position + (max_value - offset)) mod (max_value + 1);	-- modulo wrapping
				bit_reg(index) <= '1';	-- Setting snake bit to on
				
			end loop;
		end if;
		
	
	
	end process;
	
	
	bit_out <= bit_reg;

end architecture;


