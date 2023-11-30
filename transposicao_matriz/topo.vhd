library ieee;
use ieee.std_logic_1164.all;

entity topo is
    generic (
        col: positive := 16;
        row: positive := 8);
    port (
        clock, clear: in std_logic;
        matrix: in std_logic_vector(row*col-1 downto 0);
        -- output
        output: out std_logic_vector(row*col-1 downto 0));
end entity;

architecture tp of topo is 

signal ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6: std_logic;
signal stt1, stt2, pronto, iniciar: std_logic;

-- components declaration

    component controle is
        port(
            clock, clear: in std_logic;
            pronto: out std_logic;
            -- status
            iniciar, stt1, stt2: in std_logic;
            -- control
            ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6: out std_logic);
    end component;

    component operativo is
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
    end component;

    begin
    -- port maps
    contrl: controle port map(
        clock => clock, clear => clear, pronto => pronto, iniciar => iniciar,
                 stt1 => stt1, stt2 => stt2,  ctrl1 => ctrl1, ctrl2 => ctrl2,
                 ctrl3 => ctrl3, ctrl4 => ctrl4, ctrl5 => ctrl5, ctrl6 => ctrl6);

    op: operativo generic map(col => 16, row => 8)
        port map( clock => clock, clear => clear, matrix => matrix, ctrl1 => ctrl1,
                  ctrl2 => ctrl2, ctrl3 => ctrl3, ctrl4 => ctrl4, ctrl5 => ctrl5,
                  ctrl6 => ctrl6, iniciar => iniciar, stt1 => stt1, stt2 => stt2,
                  output => output);

    end architecture;