library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	generic(n = integer);
	port(
		entradaB, entradaC: in std_logic_vector(n-1 downto 0);
		comando1, comando2, comando3, aumentaI: in std_logic;
		clock, reset: in std_logic;
		statusBC, statusIB: out std_logic;		
	);
end datapath;

architecture data of datapath is

	component registrador is
		generic(n:integer);
		port (D: in std_logic_vector(n-1 downto 0);  
			  CLK, RST: in std_logic;
			  H: out std_logic_vector(n-1 downto 0));
	end component;

begin
	
	signal i, i_saida: std_logic_vector(n-1 downto 0); 
	statusBC <= entradaB < entradaC;
	statusIB <= i < entradaB;
	
	reg: registrador generic map(n => n)
		port map(D => i, CLK => clock, RST => reset, H => i+aumentaI);

end architecture;