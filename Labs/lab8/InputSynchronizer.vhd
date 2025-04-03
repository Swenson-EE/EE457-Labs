library ieee;
use ieee.std_logic_1164.all;

library work;
use work.CommonTypes.all;


entity InputSynchronizer is
	
	port(
		signal clk			: in std_logic;
		signal reset		: in std_logic;
		
		signal async_in	: in std_logic;
		
		signal sync_out	: out std_logic
	);
	
end entity;



architecture rtl of InputSynchronizer is
	signal input_state, stage1, stage2: std_logic;
begin
	process (clk, reset)
	begin
		if reset = BUTTON_ACTIVE then
			stage1 <= '0';
			stage2 <= '0';
		elsif rising_edge(clk) then
			stage1 <= async_in;
			stage2 <= stage1;
		end if;
		
	end process;
	
	sync_out <= stage2;

end architecture;


