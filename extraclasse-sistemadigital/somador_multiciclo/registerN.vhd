library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerN is
	generic(	width: natural;
				resetValue: integer := 0 );
	port(	-- control
			clock, reset, load: in std_logic;
			-- data
			input: in std_logic_vector(width-1 downto 0);
			output: out std_logic_vector(width-1 downto 0));
end entity;

architecture behav0 of registerN is
-- COMPLETE COM SINAIS INTERNOS ESPERADOS DE UM CIRCUITO SEQUENCIAL
begin
    -- next-state logic  (nao exclua e nem mude esta linha)
    -- COMPLETE

	-- memory element --state register-- (nao exclua e nem mude esta linha)
	-- COMPLETE
	
	-- output logic  (nao exclua e nem mude esta linha)
	-- COMPLETE
end architecture;