--um circuito combinacional que calcule o endereço de um dado da memória RAM. O dado pode ser uma variável, 
--um elemento de um vetor ou um elemento de uma matriz bidimensional. Quando o dado é uma variável, ele não
--é nem um vetor nem uma matriz (configuração default). O dado pode ter um ou mais bytes ("dataWidth", em bits).
--Seu circuito deve ser parametrizável e deve gerar apenas o hardware necessário para calcular o endereço que 
--acessa o byte solicitado (sinal "dataByte") do dado armazenado em memória, com base em seu endereço-base. 
--Você deve se basear na apresentação sobre acessos a estruturas de dados em RAM. Você também deve respeitar
--todas as Regras para descrição de circuitos e sistemas digitais nas aulas práticas de INE5406, demonstrando
--seu aprendizado de VHDL neste semestre.

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
--arch
use ieee.numeric_std.all;

entity dataAddress is
	generic(	addressWidth: positive;
				dataWidth: positive := 8;
				isVector: boolean := false;
				isMatrix: boolean := false;
				matrixColumnElements: positive := 10);
	port(	baseAddress: in std_logic_vector(addresswidth-1 downto 0);
	        rowElement, columnElement: in std_logic_vector(addressWidth - 1 downto 0);
	        dataByte: in std_logic_vector(integer(ceil(log2(real(dataWidth)/8.0)))-1 downto 0); -- byte solicitado
			address: out std_logic_vector(addressWidth-1 downto 0) );
	begin
	    assert not (isVector and isMatrix) report "Data can not be a vector and a matrix at the same time" severity error;
end entity;

architecture youdecide of dataAddress is
begin

signal tempAddress: std_logic_vector(address'len - 1 downto 0) := (others => '0');
signal iXn: std_logic_vector() := (others => '0') -- completar

component multiplier is
    generic(width: positive);
    port(input0, input1: in std_logic_vector(width-1 downto 0);
         output: out std_logic_vector(2*width-1 downto 0) );
end component;

end architecture;
    
vectorAdd:
if isVector generate
    --iMultN: multiplier 
        --generic map() -- descobrir
        --port map(
        --    input0 => dataWidth/8,
        --    input1 => rowElement,
        --    output => iXn
        --);
end generate;
        
matrixAdd:
if isMatrix generate
    --iMultN: multiplier 
    --generic map() -- descobrir
    --port map(
    --    input0 => dataWidth/8,
    --    input1 => rowElement*n + columnElement,
    --    output => iXn
    --);

adress = baseAddress +  dataByte - 1 + iXn
end generate;
