library IEEE;
use IEEE.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity operativo is
    generic (
        col: positive := 16;
        row: positive := 8);
    port(
        clock, clear: in std_logic;
        matrix: in std_logic_vector(row*col-1 downto 0);
        -- control
        ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6: in std_logic;
        -- status
        iniciar, stt1, stt2: out std_logic;
        output: out std_logic_vector(row*col-1 downto 0));
end entity operativo;

architecture op of operativo is

    
    function logg2 (x: integer) return integer is
        begin 
            return integer(ceil(log2(real(x))));
    end function logg2;


    signal i, iP1, input_J_sum: std_logic_vector(logg2(row)-1 downto 0);
    signal j, jP1, input_J_adder: std_logic_vector(logg2(col) -1 downto 0);
    signal matrix_inverted, matrix_new: std_logic_vector(row*col-1 downto 0);
    signal IvzROW, JvzROW: std_logic_vector(2*logg2(row)-1 downto 0);
    signal row_aux, col_aux: std_logic_vector(logg2(row)-1 downto 0);

    -- componentes
    component registerN is
        generic( 
            width: positive;
            generateLoad: boolean := false;
            clearValue: integer := 0 );
        port(
            clock, clear, load: in std_logic;
            input: in std_logic_vector(width-1 downto 0);
            output: out std_logic_vector(width-1 downto 0));
    end component;

    component addersubtractor is
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

    component multiplier is
        generic(    width: positive);
        port(    input0, input1: in std_logic_vector(width-1 downto 0);
                output: out std_logic_vector(2*width-1 downto 0) );
    end component;

    begin

        row_aux <= std_logic_vector(to_unsigned(row, logg2(row)));
        col_aux <= std_logic_vector(to_unsigned(col, logg2(col)));

        input_J_sum(0) <= '1';
        input_J_sum <= (others => '0');

    IxROW: multiplier
    generic map(
        width => logg2(row))
    port map(
        input0 => i, input1 => row_aux, output => IvzROW);

    JxROW: multiplier
    generic map(
        width => logg2(row))
    port map(
        input0 => j, input1 => row_aux, output => JvzROW);

    reg_I: registerN
    generic map(
        width => logg2(row),
        generateLoad => true,
        clearValue => 0)
    port map(
        clock => clock, clear => ctrl1, load => ctrl6, 
        input => iP1, output => i);

    reg_J: registerN
    generic map(
        width => logg2(col),
        generateLoad => true,
        clearValue => 0)
    port map(
        clock => clock, clear => ctrl3, load => ctrl5, 
        input => jP1, output => j);

    reg_matrix: registerN
    generic map(
        width => row*col, -- nao sei como botar o formato da matriz
        generateLoad => true,
        clearValue => 0)
    port map(
        clock => clock, clear => ctrl2, load => ctrl4, 
        input => matrix_inverted, output => matrix_new);

    addI: addersubtractor
    generic map(
        width => logg2(row), isAdder => true)
    port map(
        a => i, b => input_J_sum, op => '0', result => iP1,
        ovf => open, cout => open);

    addJ: addersubtractor
    generic map(
        width => logg2(col), isAdder => true)
    port map(
        a => j, b => input_J_adder, op => '0', result => jP1,
        ovf => open, cout => open);

    input_J_adder(0) <= '1';
    input_J_adder <= (others => '0');

    matrix_inverted(IvzROW+j) <= matrix(JvzROW+i);
    
    output <= matrix_new;

    end architecture op;