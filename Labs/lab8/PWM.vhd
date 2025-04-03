library ieee;
use ieee.std_logic_1164.all;

library work;
use work.PWM_Types.all;
use work.CommonTypes.all;



entity PWM is
	
	generic (
		active:			std_logic := '1'	-- To be able to change the active signal (since LEDs are active LOW)
	);
	port (
		clk:					in std_logic; -- system clock
		reset:				in std_logic; -- reset pwm count to 0
		
		tick:					in std_logic; -- tick for pwm
		duty_cycle:			in integer range 0 to PWM_MAX; -- duty cycle input
		
		pwm_out:				out std_logic -- output signal	
		
		
	);

end entity;



architecture rtl of PWM is
	signal count: integer range 0 to PWM_MAX := 0;
begin

	pwm_count: process(clk, reset)
	begin
		if reset = BUTTON_ACTIVE then
			count <= 0;
		elsif rising_edge(clk) then
			
			if tick = '1' then
				if count = (PWM_MAX - 1) then
					count <= 0;
				else
					count <= count + 1;
				end if;
			end if;
		end if;
	
	end process;

	
	--pwm_out <= '1' when (count < duty_cycle) else '0';
	pwm_out <= active when (count < duty_cycle) else NOT(active);
	



end architecture;
