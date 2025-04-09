library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Types.all;



entity SnakeDraw is

	port (
		snake_bits:				in std_logic_vector(15 downto 0);
		HEX0, HEX1, HEX2,
		HEX3, HEX4, HEX5:		out std_logic_vector(7 downto 0)
	);
	
end entity;




architecture rtl of SnakeDraw is

begin
	
	
	draw: process(snake_bits)
		variable bits_reg: std_logic_vector(15 downto 0);
	begin
		bits_reg := NOT(snake_bits); -- Flip the bits since the displays are active low
		
	
		HEX5 <= "11111111";
		HEX4 <= "11111111";
		HEX3 <= "11111111";
		HEX2 <= "11111111";
		HEX1 <= "11111111";
		HEX0 <= "11111111";
		
		
		-- Starting at top left vertical of HEX5, working around clockwise for all the bits for the snake
		
		HEX5(HEX_f) <= bits_reg(0);
		HEX5(HEX_e) <= bits_reg(1);
		HEX5(HEX_d) <= bits_reg(2);
		
		HEX4(HEX_d) <= bits_reg(3);
		
		HEX3(HEX_d) <= bits_reg(4);
		
		HEX2(HEX_d) <= bits_reg(5);
		
		HEX1(HEX_d) <= bits_reg(6);
		
		HEX0(HEX_d) <= bits_reg(7);
		HEX0(HEX_c) <= bits_reg(8);
		HEX0(HEX_b) <= bits_reg(9);
		
		HEX0(HEX_a) <= bits_reg(10);
		HEX1(HEX_a) <= bits_reg(11);
		HEX2(HEX_a) <= bits_reg(12);
		HEX3(HEX_a) <= bits_reg(13);
		HEX4(HEX_a) <= bits_reg(14);
		HEX5(HEX_a) <= bits_reg(15);
		
		
		
	
	end process;
	
	


end architecture;



