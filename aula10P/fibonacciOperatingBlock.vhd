library ieee;
use ieee.std_logic_1164.all;

entity fibonacciOperatingBlock is
        generic(width: positive);
        port(
            clock, clear: in std_logic;
            ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6, ctrl7, ctrl8, ctrl9: in std_logic;
            stt1, stt2: out std_logic;
            n: in std_logic_vector(width-1 downto 0);
            nterm: out std_logic_vector(width-1 downto 0)
        );
end entity;

architecture structure of fibonacciOperatingBlock is
	component registerN is
	generic(	width: positive;
				generateLoad: boolean := false;
				clearValue: integer := 0 );
	port(	-- control
			clock, clear, load: in std_logic;
			-- data
			input: in std_logic_vector(width-1 downto 0);
			output: out std_logic_vector(width-1 downto 0));
	end component;
	
	component addersubtractor is
	generic(	width: positive;
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
	
	component compare is
	generic(	width: positive;
				isSigned: boolean := false;
				generateEqual: boolean := false ;
				generateLessThan: boolean := false;
				useFixedSecodOperand: boolean := false;
				fixedSecodOperand: integer := 0 );
	port(	input0, input1: in std_logic_vector(width-1 downto 0);
			lessThan, equal: out std_logic );
	end component;
	
	component multiplexer2x1 is
	generic(	width: positive );
	port(	input0, input1: in std_logic_vector(width-1 downto 0);
			sel: in std_logic;
			output: out std_logic_vector(width-1 downto 0) );
	end component;
	
	signal nlt2, neq2, ctrl8or0: std_logic;
	signal iPlus1, rI_q, res_d, t1PlusT2, t1_q, t2_q: std_logic_vector(width-1 downto 0);
begin

	-- n<=2    ---> stt1
	nComp2: compare generic map(width, generateEqual => True,
	            genereateLEssThan => True, useFixedSecondOperand=> True,
	            fixedSecondOperand=>2)
                port map(input0 => n, input1 => (others=>'0'),
                lessThan=>nlt2, equal=>neq2);
    stt1 <= nlt2 or neq2;
                
	-- i<n       ---> stt2
	iCompn: compare generic map(width, genereateLessThan => True, 
	                useFixedSecondOperand=> False,
                    port map(input0 => rI_q, n,
                    lessThan=>stt2, equal=>open);

	-- i=3         ---> ctrl1
	-- i=i+1      ---> ctrl2
	regI: registerN generic(width => width, generateLoad=>true, clearValue3 => 3)
	                port map(clock, clear=>ctrl1, load=>ctrl2,
	                         input => iPlus1, output => rI_q);
	incI: addersubtractor generic map(width=>width, isAdder => True, 
	                      fixedSecondOperand => 1)
	                      port map(a => rI_q, b =>(other => '0'), op => '0',
	                               result => iPlusI, ovf => open, cout => open);
	
	--  t1 = 1     ---> ctrl3
	--  t1 = t2    ---> ctrl4 
	-- COMPLETE
	
	-- t2=1       ---> ctrl5
    -- t2=res    ---> ctrl6
	-- COMPLETE
    
	-- res = 1         ---> ctrl7
    -- res = 2         --->  ctrl8
    -- res = t1+t2   --->  ctrl9
    ctrl8or9 <= ctrl8 or ctrl9;
    
    regRes: registerN generic(width, generateLoad=>true, clearValue3 => 1)
	                port map(clock => clock, clear=>ctrl7, load=>ctrl8or9,
	                         input => res_d, output => res_q);
	t1maist2: addersubtractir generic map(width => width, isAdder=>true)
	                          port map(a=>t1_q, b => t2_q, op => '0',
	                                   result=> t1PlusT2, ovf => open, cout => open);
    muxRes: multiplexer2x1 generic map(width)
                           port map(input0 =>(1=>'1', others=>'0'), input => t1PlusT2,
                           sel => ctrl9, output => res_d);
	
	-- COMPLETE
end architecture;
