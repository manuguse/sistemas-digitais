library ieee;
use ieee.std_logic_1164.all;

entity topComRAM is
port(
	clock, clear: in std_logic;
	iniciar: in std_logic;
	pronto: out std_logic;
);

architecture estrutura of topComRAM is

	component acessoRAM is
	port(
		clock, clear: in std_logic;
		iniciar: in std_logic;
		pronto: out std_logic;
		
		dado: out std_logic_vector(7 downto 0); -- 1 byte
		address: out std_logic_vector(7 downto 0);
		wren: out std_logic;
		q: in std_logic_vector(7 downto 0));
	end component;

	component ram
	port(
		address: in std_logic_vector (7 DOWNTO 0);
		clock: in std_logic  := '1';
		data: in std_logic_vector (7 DOWNTO 0);
		wren: in std_logic ;
		q: out std_logic_vector (7 DOWNTO 0));
	end component;

signal address: std_logic_vector(7 downto 0);
signal data: std_logic_vector(7 downto 0);
signal wren: std_logic_vector(7 downto 0);
signal q: std_logic_vector(7 downto 0);

begin

	SD: acessoRAM 
	port map(
		clock, clear, iniciar, pronto, dado, address, wren, q);
		
	RAM0: ram 
	port map(
		address, clock, data, wren, q);


end architecture;