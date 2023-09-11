library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity baseComb is
    generic(n: natural;
           f1: positive;
           f2: positive;
           f3: positive);
    port(
        input0: in std_logic_vector(n-1 downto 0);
        output0: out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture behav of baseComb is

  signal: resultF2, resultF3: std_logic;
  
begin

gF3: if geraF3 generate
  resultF3 <= f3;
end generate;
ngF3: if not geraF3 generate
  resultF3 <= (0=>'1', others=>'0')

gF2: if geraF2 generate
  resultF2 <= f2 and resultF3;
end generate;
ngF2: if not geraF2 generate
  resultF2 <= resultF3;
end generate;

gF1: if geraF1 generate
  output0 <= f1 and resultF2;
end generate;
ngF1: if not geraF1 generate
  output0 <= resultF2;
end generate;

end architecture;
