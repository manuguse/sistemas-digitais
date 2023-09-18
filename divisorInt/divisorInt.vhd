-- passo 0: especificacao da funcionalidade

-- L01: [ uint quociente, uint resto ] = divisorInt ( uint dividendo, uint divisor )
-- L02: quociente = 0
-- L03: resto = dividendo
-- L04: while (resto >= divisor)
-- L05:    resto = resto - divisor
-- L06: 	  quociente += 1
-- L07: return quociente, resto

-- especificacao de entradas e saídas

---- entradas de dados:
------ unit dividendo (n bits)
------ unit divisor (n bits)
---- entrada de controle:
------ bit chipSelect ("iniciar")
---- saidas de dados:
------ unit quociente (n bits)
------ unit resto (n bits)
---- saidas de controle:
------ bit pronto

-- especificacao das operações por variável
---- quociente
------ L02: quociente = 0  -->  ctrlSetaQuocZera
------ L06: quociente += 1  -->  ctrlIncQuoc
---- resto: 
------ L03: resto = dividendo  -->  ctrlSetaRestoDiv
------ L04: while (resto >= divisor)  -->  sttRestMaiorIgualDiv
------ L05:    resto = resto - divisor  -->  ctrlSetaRestoMenosDiv


-- passo 1: captura do comportamento via fsmd

-- diagrama de transicao
---- L01: [ uint quociente, uint resto ] = divisorInt ( uint dividendo, uint divisor )
------ L01 [iniciar] -> L02 // L01 ![iniciar] -> L01
---- L02: quociente = 0
------ L02 -> L03
---- L03: resto = dividendo
------ L03 -> L04
---- L04: while (resto >= divisor)
------ L04(TRUE) -> L05 // L04(FALSE) -> L07
---- L05:    resto = resto - divisor
------ L05 -> L06
---- L06: 	  quociente += 1
------ L06 -> L04
---- L07: return quociente, resto
------ L07 -> L01

-- diagrama de saida
---- L01: [ uint quociente, uint resto ] = divisorInt ( uint dividendo, uint divisor )
------ pronto = 1 >>>> quando uma saída nao é especificada assume-se que ela está inativa
---- L02: quociente = 0
------ ctrlSetaQuocZera
---- L03: resto = dividendo
------ ctrlSetaRestoDiv
---- L04: while (resto >= divisor)
------ /
---- L05:    resto = resto - divisor
------ ctrlSetaRestoMenosDiv
---- L06: 	  quociente += 1
------ ctrlIncQuoc
---- L07: return quociente, resto
------ pronto = 1


-- passo 2: projeto do bloco operativo

-- circuitos combinacionais
---- L04: while (resto >= divisor)
------ ==> comparador maior e igual
---- L05:    resto = resto - divisor
---- L06: 	  quociente += 1
------ ==> subtrator/subtrator

-- circuitos sequenciais
---- L02: quociente = 0 
------ ==> registrador D com reset "RegQuociente"
---- L03: resto = dividendo
------ ==> registrador D com load "RegResto"


-- passo 3: definir as interfaces de blocos operativo e de controle

-- bloco operativo
---- entradas de dados
------ unit dividendo (n bits)
------ unit divisor (n bits)
---- saidas de dados
------ unit quociente (n bits)
------ unit resto (n bits)
---- entradas de controle
------ L02: quociente = 0  -->  ctrlSetaQuocZera
------ L06: quociente += 1  -->  ctrlIncQuoc
------ L03: resto = dividendo  -->  ctrlSetaRestoDiv
------ L05:    resto = resto - divisor  -->  ctrlSetaRestoMenosDiv
---- saidas de controle
------ L04: while (resto >= divisor)  -->  sttRestMaiorIgualDiv

-- bloco operativo
---- entradas de dados
----- saidas de dados
---- entradas de controle
------ L04: while (resto >= divisor)  -->  sttRestMaiorIgualDiv
---- saidas de controle
------ L02: quociente = 0  -->  ctrlSetaQuocZera
------ L06: quociente += 1  -->  ctrlIncQuoc
------ L03: resto = dividendo  -->  ctrlSetaRestoDiv
------ L05:    resto = resto - divisor  -->  ctrlSetaRestoMenosDiv

library ieee;
use ieee.std_logic_1164.all

entity divisorInt is
	generic(n: integer := 8);
	port(
		-- entrada dados
		signal dividendo: in std_logic_vector(n-1 downto 0);
		signal divisor: in std_logic_vector(n-1 downto 0);
		-- entrada controle
		signal clock: in std_logic
		signal iniciar: in std_logic;
		-- saida dadoos
		signal quociente: out std_logic_vector(n-1 downto 0);
		signal resto: out std_logic_vector(n-1 downto 0);
		-- saida controle
		signal pronto: out std_logic;
	);
end divisorInt;

architecture estrutural of divisorInt is

component BlocoControle is
	generic(n: integer);
	port(
		-- entradas de dados
		signal dividendo, divisor: in std_logic_vector(n-1 downto 0);
		-- saidas de dados
		signal quociente, resto: out std_logic_vector(n-1 downto 0);
		-- entradas de controle
		signal ctrlSetaQuocZera, ctrlIncQuoc, ctrlSetaRestoDiv, ctrlSetaRestoMenosDiv: in std_logic;
		-- saidas de controle
		signal sttRestMaiorIgualDiv: out std_logic
	);
end component;

component BlocoControle is
	port(
		-- entradas de dados
		signal dividen
------ unit dividendo (n bits)
------ unit divisor (n bits)
---- saidas de dados
------ unit quociente (n bits)
------ unit resto (n bits)
---- entradas de controle
------ L02: quociente = 0  -->  ctrlSetaQuocZera
------ L06: quociente += 1  -->  ctrlIncQuoc
------ L03: resto = dividendo  -->  ctrlSetaRestoDiv
------ L05:    resto = resto - divisor  -->  ctrlSetaRestoMenosDiv
---- saidas de controle
------ L04: while (resto >= divisor)  -->  sttRestMaiorIgualDiv
	);
end component;

begin

ct: BlocoControle port map(
		dividendo, divisor, quociente, resto, ctrlSetaQuocZera, ctrlIncQuoc, ctrlSetaRestoDiv, ctrlSetaRestoMenosDiv. sttRestMaiorIgualDiv);
	);
	
op: BlocoOperativo port map(
);

end architecture;