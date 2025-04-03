library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity de10_lite_base is
    port (
        --clocks
        MAX10_CLK1_50 : in std_logic;
        --seven seg
        HEX0, HEX1, HEX2,
        HEX3, HEX4, HEX5 :    out    std_logic_vector(7 downto 0);
        --general human interface
        KEY : in std_logic_vector(1 downto 0);
        SW : in  std_logic_vector(9 downto 0);
        LEDR : out std_logic_vector(9 downto 0)
    );
end entity;

architecture de10_lite of de10_lite_base is
    

begin

    
end architecture;