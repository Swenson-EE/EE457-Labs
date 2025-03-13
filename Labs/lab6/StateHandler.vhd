library ieee;
use ieee.std_logic_1164.ALL;

library work;
use work.StateTypes.all;
use work.SevenSegment.all;

entity StateHandler is

	port (
		clk			: in std_logic;
		state_in		: in state_type;
		
		HEX0, HEX1, HEX2,
		HEX3, HEX4, HEX5 :    out    std_logic_vector(7 downto 0)
	);

end entity;



architecture rtl of StateHandler is	
	
	signal H0, H1, H2,
				H3, H4, H5 : 	segment_type;

begin

	process (all)
		
	begin
		H0 <= SEGMENT_b;
		H1 <= SEGMENT_b;
		H2 <= SEGMENT_b;
		H3 <= SEGMENT_b;
		H4 <= SEGMENT_b;
		H5 <= SEGMENT_b;
	
		case state_in is
			when STATE_0 =>	-- EE457	0
--				HEX5 <= SEG_E;
--				HEX4 <= SEG_E;
--				HEX3 <= SEG_4;
--				HEX2 <= SEG_5;
--				HEX1 <= SEG_7;
--				
--				HEX0 <= SEG_0;

				H5 <= SEGMENT_E;
				H4 <= SEGMENT_E;
				H3 <= SEGMENT_4;
				H2 <= SEGMENT_5;
				H1 <= SEGMENT_7;
		
				H0 <= SEGMENT_0;
				
				
			when STATE_1 =>	-- bEE45	1
--				HEX5 <= SEG_b;
--				HEX4 <= SEG_E;
--				HEX3 <= SEG_E;
--				HEX2 <= SEG_4;
--				HEX1 <= SEG_5;
--				
--				HEX0 <= SEG_1; 
				
				H5 <= SEGMENT_b;
				H4 <= SEGMENT_E;
				H3 <= SEGMENT_E;
				H2 <= SEGMENT_4;
				H1 <= SEGMENT_5;
				
		
				H0 <= SEGMENT_1;
				
			when STATE_2 =>	-- bbEE4	2
--				HEX5 <= SEG_b;
--				HEX4 <= SEG_b;
--				HEX3 <= SEG_E;
--				HEX2 <= SEG_E;
--				HEX1 <= SEG_4;
--				
--				HEX0 <= SEG_2; 

				H5 <= SEGMENT_b;
				H4 <= SEGMENT_b;
				H3 <= SEGMENT_E;
				H2 <= SEGMENT_E;
				H1 <= SEGMENT_4;
				
				H0 <= SEGMENT_2; 
				
			when STATE_3 =>	-- bbbEE	3
--				HEX5 <= SEG_b;
--				HEX4 <= SEG_b;
--				HEX3 <= SEG_b;
--				HEX2 <= SEG_E;
--				HEX1 <= SEG_E;
--				
--				HEX0 <= SEG_3; 

				H5 <= SEGMENT_b;
				H4 <= SEGMENT_b;
				H3 <= SEGMENT_b;
				H2 <= SEGMENT_E;
				H1 <= SEGMENT_E;
				
				H0 <= SEGMENT_3; 

				
			when STATE_4 =>	-- bbbbE	4
--				HEX5 <= SEG_b;
--				HEX4 <= SEG_b;
--				HEX3 <= SEG_b;
--				HEX2 <= SEG_b;
--				HEX1 <= SEG_E;
--				
--				HEX0 <= SEG_4; 

				H5 <= SEGMENT_b;
				H4 <= SEGMENT_b;
				H3 <= SEGMENT_b;
				H2 <= SEGMENT_b;
				H1 <= SEGMENT_E;
				
				H0 <= SEGMENT_4; 

				
			when STATE_5 => 	-- bbbbb	5
--				HEX5 <= SEG_b;
--				HEX4 <= SEG_b;
--				HEX3 <= SEG_b;
--				HEX2 <= SEG_b;
--				HEX1 <= SEG_b;
--				
--				HEX0 <= SEG_5;

				H5 <= SEGMENT_b;
				H4 <= SEGMENT_b;
				H3 <= SEGMENT_b;
				H2 <= SEGMENT_b;
				H1 <= SEGMENT_b;
				
				H0 <= SEGMENT_5;

				
			when STATE_6 =>	-- 7bbbb	6
--				HEX5 <= SEG_7;
--				HEX4 <= SEG_b;
--				HEX3 <= SEG_b;
--				HEX2 <= SEG_b;
--				HEX1 <= SEG_b;
--				
--				HEX0 <= SEG_6;

				H5 <= SEGMENT_7;
				H4 <= SEGMENT_b;
				H3 <= SEGMENT_b;
				H2 <= SEGMENT_b;
				H1 <= SEGMENT_b;
				
				H0 <= SEGMENT_6;

				
			when STATE_7 =>	-- 57bbb	7
--				HEX5 <= SEG_5;
--				HEX4 <= SEG_7;
--				HEX3 <= SEG_b;
--				HEX2 <= SEG_b;
--				HEX1 <= SEG_b;
--				
--				HEX0 <= SEG_7;

				H5 <= SEGMENT_5;
				H4 <= SEGMENT_7;
				H3 <= SEGMENT_b;
				H2 <= SEGMENT_b;
				H1 <= SEGMENT_b;
				
				H0 <= SEGMENT_7;

				
			when STATE_8 =>	-- 457bb	8
--				HEX5 <= SEG_4;
--				HEX4 <= SEG_5;
--				HEX3 <= SEG_7;
--				HEX2 <= SEG_b;
--				HEX1 <= SEG_b;
--				
--				HEX0 <= SEG_8;


				H5 <= SEGMENT_4;
				H4 <= SEGMENT_5;
				H3 <= SEGMENT_7;
				H2 <= SEGMENT_b;
				H1 <= SEGMENT_b;
				
				H0 <= SEGMENT_8;

				
			when STATE_9 =>	-- E457b	9
--				HEX5 <= SEG_E;
--				HEX4 <= SEG_4;
--				HEX3 <= SEG_5;
--				HEX2 <= SEG_7;
--				HEX1 <= SEG_b;
--				
--				HEX0 <= SEG_9;


				H5 <= SEGMENT_E;
				H4 <= SEGMENT_4;
				H3 <= SEGMENT_5;
				H2 <= SEGMENT_7;
				H1 <= SEGMENT_b;
				
				H0 <= SEGMENT_9;

			
			
			when others =>		-- bbbbb	E
--				HEX5 <= SEG_b;
--				HEX4 <= SEG_b;
--				HEX3 <= SEG_b;
--				HEX2 <= SEG_b;
--				HEX1 <= SEG_b;
--				
--				HEX0 <= SEG_E;
				
				H0 <= SEGMENT_E;
		
		
		end case;
		
		
		HEX0 <= to_seven_segment(H0);
		HEX1 <= to_seven_segment(H1);
		HEX2 <= to_seven_segment(H2);
		HEX3 <= to_seven_segment(H3);
		HEX4 <= to_seven_segment(H4);
		HEX5 <= to_seven_segment(H5);
		
	end process;



end architecture;


