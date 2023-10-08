library ieee;
use ieee.std_logic_1164.all;

entity binaryDecoder3x8 is
	port(	input: in std_logic_vector(2 downto 0);
			output: out std_logic_vector(7 downto 0));
end entity;


architecture behav0 of binaryDecoder3x8 is
begin

output <= "10000000" when input = "000" else
          "01000000" when input = "001" else
          "00100000" when input = "010" else
          "00010000" when input = "011" else
          "00001000" when input = "100" else
          "00000100" when input = "101" else
          "00000010" when input = "110" else
          "00000001";

end architecture;
