library ieee;
use ieee.std_logic_1164.all;

entity operativo is
port(
	clock, clear: in std_logic;
	-- RAM
	address: out std_logic_vector(7 downto 0);
	wren: out std_logic;
	q: in std_logic_vector(7 downto 0)
	-- BC
	ctrl1, ctrl2, ctrl3: in std_logic;
	stt1: out std_logic);
end entity;

architecture estrutural of operativo is

	component compare is
		generic(	
			width: positive;
			isSigned: boolean := false;
			generateEqual: boolean := false ;
			generateLessThan: boolean := false;
			useFixedSecodOperand: boolean := false;
			fixedSecodOperand: integer := 0 );
		port(	
			input0, input1: in std_logic_vector(width-1 downto 0);
			lessThan, equal: out std_logic );
	end component;
	
	component addersubtractor
		generic(
			width: positive;
			isAdder: boolean := false;
			isSubtractor: boolean := false;
			generateCout: boolean := false;
			generateOvf: boolean := false;
			fixedSecodOperand: integer := 0);
		port(	
			a, b: in std_logic_vector(width-1 downto 0);
			op: in std_logic;
			result: out std_logic_vector(width-1 downto 0);
			ovf, cout: out std_logic );
	end component;

	signal -- completar

begin
end architecture;