library ieee;
use ieee.std_logic_1164.all;

entity acessoRAM is
port(
	clock, clear: in std_logic;
	iniciar: in std_logic;
	pronto: out std_logic;
	
	dado: out std_logic_vector(7 downto 0); -- 1 byte
	address: out std_logic_vector(7 downto 0);
	wren: out std_logic;
	q: in std_logic_vector(7 downto 0)
);
end entity;

architecture estrutura of acessoRAM is

	signal -- completar

begin
end architecture;