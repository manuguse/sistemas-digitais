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

	component controle is
	port(
		clock, clear: in std_logic;
		iniciar: in std_logic;
		pronto: out std_logic;
		ctrl1, ctrl2, ctrl3: out std_logic;
		stt1: in std_logic);
	end component;
	
	component operativo is
	port(
		clock, clear: in std_logic;
		address: out std_logic_vector(7 downto 0);
		wren: out std_logic;
		q: in std_logic_vector(7 downto 0)
		ctrl1, ctrl2, ctrl3: in std_logic;
		stt1: out std_logic);
	end component;

	signal ctrl1, ctrl2, ctrl3, stt1: std_logic;

begin
end architecture;