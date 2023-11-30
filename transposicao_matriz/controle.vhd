library ieee;
use ieee.std_logic_1164.all;

entity controle is
port(
    clock, clear: in std_logic;
    pronto: out std_logic;
    -- status
    iniciar, stt1, stt2: in std_logic;
    -- control
    ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6: out std_logic);
end entity controle;

architecture ctrl of controle is

    type STATE is (S00, S01, S02, S03, S04, S05, S06, S07, S08, S09);
    signal currentState, nextState: STATE;

    begin
        
        -- next state logic
        process(currentState, iniciar, stt1, stt2) is
        begin
            nextState <= S01;
            case currentState is

                when S00 => 
                    if iniciar = '1' then
                        nextState <= S01;
                    end if;

                when S01 =>
                    nextState <= S02;

                when S02 =>
                    nextState <= S03;

                when S03 =>
                    if stt1 = '1' then
                        nextState <= S04;
                    else 
                        nextState <= S09;
                    end if;

                when S04 =>
                    nextState <= S05;

                when S05 =>
                    if stt2 = '1' then
                        nextState <= S06;
                    else nextState <= S08;
                    end if;

                when S06 =>
                    nextState <= S07;

                when S07 =>
                    nextState <= S05;

                when S08 =>
                    nextState <= S03;

                when S09 =>
                    nextState <= S09;

            end case;
        end process;

        -- register
	    process(clock, clear) is
        begin
            if clear = '1' then
                currentState <= S00;
            elsif rising_edge(clock) then
                currentState <= nextState;
            end if;
        end process;

        -- output logic
        pronto <= '1' when currentState = S00 else '0';
        ctrl1 <= '1' when currentState = S01 else '0';
        ctrl2 <= '1' when currentState = S02 else '0';
        ctrl3 <= '1' when currentState = S04 else '0';
        ctrl4 <= '1' when currentState = S06 else '0';
        ctrl5 <= '1' when currentState = S07 else '0';
        ctrl6 <= '1' when currentState = S08 else '0';

    end architecture ctrl;