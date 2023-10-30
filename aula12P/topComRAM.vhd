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
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;


begin
end architecture;