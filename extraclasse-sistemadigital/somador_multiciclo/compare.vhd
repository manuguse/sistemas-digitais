library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compare is
	generic(	width: natural;
				isSigned: boolean;
				generateLessThan: boolean;
				generateEqual: boolean );
	port(	input0, input1: in std_logic_vector(width-1 downto 0);
			lessThan, equal: out std_logic );
end entity;

architecture behav0 of compare is
begin
	if0: if generateEqual generate
		-- COMPLETE
	end generate;
	if1: if generateLessThan generate
		if2: if isSigned generate
	    	-- COMPLETE
		end generate;
		if3: if not isSigned generate
    		-- COMPLETE
		end generate;
	end generate;
end architecture;
