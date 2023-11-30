library ieee;
use ieee.std_logic_1164.all;

entity blocoOperativo4T is
	generic(width_ent: positive;
			width_n: positive);
	port(
		-- control in
		clock, reset: in std_logic;
		-- control in (command signals from BC)
		scont, ccont, zAC, cAC, cT: in std_logic;		
		-- control out (status signals to BC)
		zero, ov: out std_logic;
		-- data in
		ent: in std_logic_vector(width_ent-1 downto 0);
		n: in std_logic_vector(width_n-1 downto 0);
		-- data out
		soma: out std_logic_vector(width_ent-1 downto 0) 
	);
end entity;


architecture descricaoEstrutural of blocoOperativo4T is
	component multiplexer2x1 is
		generic (	width: positive );
		port(	input0, input1: in std_logic_vector(width-1 downto 0);
				sel: in std_logic;
				output: out std_logic_vector(width-1 downto 0) );
	end component;
	component addersubtractor is
		generic (	N: positive;
					isAdder: boolean;
					isSubtractor: boolean;
					generateOvf: boolean);
		port(	op: in std_logic;
				a, b: in std_logic_vector(N-1 downto 0);
				result: out std_logic_vector(N-1 downto 0);
				ovf, cout: out std_logic );
	end component;
	component componentegisterN is
		generic(	width: natural;
					resetValue: integer := 0 );
		port(	-- control
				clock, reset, load: in std_logic;
				-- data
				input: in std_logic_vector(width-1 downto 0);
				output: out std_logic_vector(width-1 downto 0));
	end component;
	component compare is
		generic(	width: natural;
					isSigned: boolean;
					generateLessThan: boolean;
					generateEqual: boolean );
		port(	input0, input1: in std_logic_vector(width-1 downto 0);
				lessThan, equal: out std_logic );
	end component;
	-- COMPLETE COM EVENTUAIS SINAIS INTERNOS

	signal entry_b_sub: std_logic_vector(width_n-1 downto 0);
	signal sub_out, mux0_out, cont_out: std_logic_vector(width_n-1 downto 0);
	signal sum_out, smux_out, regT_out, regAC_out: std_logic_vector(width_ent-1 downto 0);

begin
	-- COMPLETE COM EVENTUAIS COMANDOS CONCORRENTES
	entry_b_sub(0) <= '1';
	entry_b_sub <= (others => '0');

	entry_input1(0) <= '1';
	entry_input1 <= (others => '0');
    -- COMPLETE OS COMANDOS DE INSTANCIACAO ABAIXO
	mux0: multiplexer2x1 
			generic map(width=>width_n)
			port map(input0=>sub_out, input1=>n, sel=>scont, output=>mux0_out);
	cont: componentegisterN 
			generic map(width=>width_n)
			port map(clock=>clock, reset=>'0', load=>ccont,
				input=>mux0_out,	output=>cont_out);
	subtractor0: addersubtractor 
			generic map(N=>width_n, isAdder=>false, isSubtractor=>true, generateOvf=>false)
			port map(op=>'0', a=>cont_out, b=>entry_b_sub, result=>sub_out, ovf=>open, cout=>open);
	compare0: compare
			generic map (width=>width_n, isSigned=>false, generateLessThan=>false, generateEqual=>true)
			port map (input0=>cont_out, input1=>'0', lessThan=>open, equal=>zero);
			
	mux1: multiplexer2x1 
			generic map(width=>width_ent)
			port map(input0=>sum_out, input1=>'0', sel=>zAC, output=>smux_out);
	AC: componentegisterN 
			generic map(width=>width_ent)
			port map(clock=>clock, reset=>reset, load=>cAC,
				input=>smux_out,	output=>regAC_out);
	T: componentegisterN 
			generic map(width=>width_ent)
			port map(clock=>clock, reset=>reset, load=>cT,
				input=>ent,	output=>regT_out);
	adder0: addersubtractor 
			generic map(N=>width_ent, isAdder=>true, isSubtractor=>false, generateOvf=>false)
			port map(op=>'0', a=>regAC_out, b=>regT_out, result=>sum_out, ovf=>ov, cout=>open);
end architecture;
