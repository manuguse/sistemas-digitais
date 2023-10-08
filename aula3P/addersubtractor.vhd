library ieee;
use ieee.std_logic_1164.all;

entity addersubtractor is
	generic(width: positive;
			isAdder: boolean;
			isSubtractor: boolean;
			generateCout: boolean := true;
			generateOvf: boolean := true);
	port(	
		a, b: in std_logic_vector(width-1 downto 0);
		op: in std_logic;
		result: out std_logic_vector(width-1 downto 0);
		ovf, cout: out std_logic );
	begin
		assert (isAdder or isSubtractor) report "Pelo menos um dos parametros generic deve ser true" severity error;		
end entity;

architecture behav0 of addersubtractor is
signal operando: std_logic_vector(width-1 downto 0);
begin
    soma: if isAdder and not isSubtractor generate
        operando <= b;
    end generate;
    
    subtrai: if not isAdder and isSubtractor generate
        operando <= (not b) + 1;
    end generate;

    soma_sub: if isAdder and isSubtractor generate
        operando <= b when op ='0' else ((not b) + 1);
    end generate;

    result <= a + operando;

end architecture;
