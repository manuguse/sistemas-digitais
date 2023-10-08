library ieee;
use ieee.std_logic_1164.all;

entity binaryEncoder8x3 is
	port(input: in std_logic_vector(7 downto 0);
		valid: out std_logic;
		output: out std_logic_vector(2 downto 0) );
end entity;

architecture behav0 of binaryEncoder8x3 is
begin
    with input select
    output <= "000" when "10000000",
    "001" when "01000000",
    "010" when "00100000",
    "011" when "00010000",
    "100" when "00001000",
    "101" when "00000100",
    "110" when "00000010",
    "111" when others;

end architecture;
