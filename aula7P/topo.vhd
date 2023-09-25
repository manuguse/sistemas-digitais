--inicio
--... se (entrada1 == 0) entao
--...... enquanto (entrada2 < entrada3) faça
--......... comando1;
--......... comando2;
--...... fim enquanto;
--... senão
--...... para ( i=0; i < entrada2; i++) 
--......... comando3;
--...... fim para
--... fim se

library ieee;
use ieee.std_logic_1164.all;

entity topo is 
	generic(n:integer);
	port(
		entrada1: in std_logic;
		entrada2, entrada3: in std_logic_vector(n-1 downto 0)
	);
end entity;

architecture tp os topo is

begin

end architecture;