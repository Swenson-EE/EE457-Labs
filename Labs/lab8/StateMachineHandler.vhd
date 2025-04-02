library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.CommonTypes.all;
use work.PWM_Types.all;



entity StateMachineHandler is

	port(
		clk				: in std_logic;	-- system clock
		reset				: in std_logic;	-- reset signal
		state				: in state_t; -- current state
		pwm_signals		: in std_logic_vector(3 downto 0);
		
		LEDR 				: out std_logic_vector(9 downto 0)
	);


end entity;





architecture rtl of StateMachineHandler is
	signal position: position_range := 0; 
begin

	position_process: process(state)
	begin
		case state is
			when S0 => position <= 0;
			when S1 => position <= 1;
			when S2 => position <= 2;
			when S3 => position <= 3;
			when S4 => position <= 4;
			when S5 => position <= 5;
			when S6 => position <= 6;
			when S7 => position <= 7;
			when S8 => position <= 8;
			when S9 => position <= 9;
			when others => position <= 0;
		end case;
	end process;
	
	
	
	
	
	
	led_map: process(clk, reset, position)
	begin
		if reset then
			LEDR <= (others => '0'); -- Clear all LEDs
		elsif rising_edge(clk) then
			LEDR <= (others => '0'); -- Clear all LEDs
			
			LEDR(position) <= pwm_signals(0); -- 100 PWM signal
			
			
			
			-- Lagging LEDs
			if position >= DUTY_LAG_LED_1_MIN_POS then
				LEDR(position - 1) <= pwm_signals(1);			
			end if;
			
			if position >= DUTY_LAG_LED_2_MIN_POS then
				LEDR(position - 2) <= pwm_signals(2);
			end if;
			
			if position >= DUTY_LAG_LED_3_MIN_POS then
				LEDR(position - 3) <= pwm_signals(3);
			end if;

			
				
			-- Leading LEDs
			if position >= DUTY_LEAD_LED_1_MIN_POS then
				LEDR(position + 1) <= pwm_signals(1);			
			end if;
			
			if position >= DUTY_LEAD_LED_2_MIN_POS then
				LEDR(position + 2) <= pwm_signals(2);
			end if;
			
			if position >= DUTY_LEAD_LED_3_MIN_POS then
				LEDR(position + 3) <= pwm_signals(3);
			end if;
			
			
			
			
			
		end if;
		
		
		
		
	end process;
	



end architecture;



