library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity bitsCombCounter is
    generic (
        N: positive;
        count1s: boolean := true
    );
    port (
        input: in std_logic_vector(N-1 downto 0);
        output: out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)
    );
end entity bitsCombCounter;

architecture sequential_behaviour of bitsCombCounter is

    function sum_bits(inputSum : STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result : integer := 0;
    begin
        for i in inputSum'range loop
            if inputSum(i) = '1' then
                result := result +  1;
            end if;
        end loop;
        return std_logic_vector(to_unsigned(result, integer(ceil(log2(real(N))))));
    end function;

begin
    cont1: if count1s generate
        output <= sum_bits(input);
    end generate;

    cont0: if not count1s generate
        output <= sum_bits(not input);
    end generate;

end architecture;