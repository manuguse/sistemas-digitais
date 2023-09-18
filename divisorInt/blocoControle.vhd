library ieee;
use ieee.std_logic_1164.all;

entity BlocoControle is
	generic(n: integer);
	port(
		-- entradas de dados
		dividendo, divisor: in std_logic_vector(n-1 downto 0);
		-- saidas de dados
		quociente, resto: out std_logic_vector(n-1 downto 0);
		-- entradas de controle
		ctrlSetaQuocZera, ctrlIncQuoc, ctrlSetaRestoDiv, ctrlSetaRestoMenosDiv: in std_logic;
		-- saidas de controle
		sttRestMaiorIgualDiv: out std_logic
	);
end entity;

architecture comportamental of BlocoControle is
	type Estado is (L01, L02, L03, L04, L05, L06, L07);
	signal estadoAtual, proximoEstado: Estado;
	
	begin
	process()
		
		proximoEstado <= estadoAtual;
		case estadoAtual is

---- L01: [ uint quociente, uint resto ] = divisorInt ( uint dividendo, uint divisor )
------ L01 [iniciar] -> L02 // L01 ![iniciar] -> L01		
			when L01 =>
				if iniciar then L02;
				
---- L02: quociente = 0
------ L02 -> L03				
			when L02 => 
				proximoEstado <= L03;
				
---- L03: resto = dividendo
------ L03 -> L04				
			when L03 =>
				proximoEstado <= L04;
				
---- L04: while (resto >= divisor)
------ L04(TRUE) -> L05 // L04(FALSE) -> L07				
			when L04 =>
				if sttRestMaiorIgualDiv then
					proximoEstado <= L05;
				else
					proximoEstado <= L07;
					
---- L05:    resto = resto - divisor
------ L05 -> L06					
			when L05 =>
				proximoEstado <= L06;
				
---- L06: 	  quociente += 1
------ L06 -> L04				
			when L06 =>
				proximoEstado <= L04;
				
---- L07: return quociente, resto
------ L07 -> L01				
			when L07 =>
				proximoEstado <= L01
				
		end case;
	end process;
	
	process(clock) is
	begin 
		if rising_edge(clock) then
			estadoAtual <= proximoEstado;
		end if;
	end process;
	
	pronto <= '1' when estadoAtual = L01 or estadoAtual = L07 else '0';
	ctrlSetaQuocZero <= '1' when estadoAtual = L02 else '0';
	ctrlSetaRestoDiv <= '1' when estadoAtual = L02 else '0';
	
end architecture