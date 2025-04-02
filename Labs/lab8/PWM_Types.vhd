library ieee;
use ieee.std_logic_1164.all;


package PWM_Types is
	
	
	
	
	


	

	constant PWM_MAX: integer := 100;
	
	
	--type integer_vector is array (natural range <>) of integer;
	
	type LED_Array is array (0 to PWM_MAX) of integer;
	
	
	--type PWM_Int is integer (0 to 99);
	subtype PWM_Int is integer range 0 to PWM_MAX;
	
	constant DUTY10: PWM_Int := 10;
	constant DUTY20: PWM_Int := 20;
	constant DUTY60: PWM_Int := 60;
	constant DUTY100: PWM_Int := 100;
	
	
	
	
	
	


end package;


package body PWM_Types is

end package body;

