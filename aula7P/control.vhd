library ieee;
use ieee.std_logic_1164.all;

entity control is
	generic(n = integer);
	port(
		statusBC, statusIB, entrada1, inicia: in std_logic;
		comando1, comando2, comando3, aumentaI: out std_logic;
	);
end control;

architecture ctrl of control is

	type estado is (E1, E2, E3, E4, E5, E8, E8b, E9, E10);
	signal estadoAtual, proximoEstado: Estado;
		
	begin
	process()
	
		proximoEstado <= estadoAtual;
			case estadoAtual is
						
				when E1 =>
					if inicia then
						proximoEstado <= E2;
					else
						proximoEstado <= E1;
						
				when E2 =>
					if entrada1 then
						proximoEstado <= E8;
					else
						proximoEstado <= E3;
						
				when E3 =>
					if statusBC then
						proximoEstado <= E4;
					else
						proximoEstado <= ----- estado final -----;
						
				when E4 => 
					comando1 = 1;
					proximoEstado <= E5;
					
				when E5 =>
					comando2 = 1;
					proximoEstado <= E3;
					
				when E8 =>
					i = 0;
					proximoEstado <= E8b;
					
				when E8b =>
					if statusIB then 
						proximoEstado <= E9;
					else
						proximoEstado <= ----- estado final -----;
				
				when E9 =>
					comando3 = 1;
					
				when E10 =>
					aumentaI = 1;
					
			end case;
		end process;
			

end architecture;