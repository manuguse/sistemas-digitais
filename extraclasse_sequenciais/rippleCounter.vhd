library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rippleCounter is
	generic(	width: positive := 8;
				generateLoad: boolean := true;
				generateEnb: boolean := true;
				generateInc: boolean := true);
	port(	-- control
			clock, reset: in std_logic;
			load, enb, inc: in std_logic;
			-- data
			input: in std_logic_vector(width-1 downto 0);
			output: out std_logic_vector(width-1 downto 0)	);
end entity;


architecture behav0 of rippleCounter is
    subtype state is unsigned(width-1 downto 0);
    signal nextState, currentState, nextState2, nextState3: state;
    signal processState: state;
    signal K: state;
begin

	genK:
        for i in 0 to width-1 generate
            K(i) <= '1' when i = width-1 else '0';
        end generate;
	
	genLoad:
        if generateLoad generate
        nextState2 <= unsigned(input) when load = '1' else
                     processState;
    end generate;
    
    genLoadNotEnb:
    if generateLoad and not generateEnb generate
        processState <= unsigned(input) when load = '1' else
                            nextState;
    end generate;
   
    genEnbLoad:
    if generateLoad and generateEnb generate
        nextState <= nextState2 when enb = '1' else
                     currentState;
    end generate;
    
    genEnb:
    if generateEnb and not generateLoad generate
        nextState <= processState when enb = '1' else
                     currentState;
    end generate;
    
    genNotEnb:
    if not generateEnb generate
        nextState <= processState;
    end generate;
    
    genInc:
    if generateInc generate
        nextState3 <= currentState(width-2 downto 0) & '0' when inc = '1' and currentState /= K else
                        to_unsigned(1, input'length) when inc = '1' and currentState = K else
                        '0' & currentState(width-1 downto 1) when inc = '0' and currentState /= to_unsigned(1, input'length) else
                        K when inc = '0' and currentState = to_unsigned(1, input'length);
    end generate;
    
    genNotInc:
    if not generateInc generate
        nextState3 <= currentState(width-2 downto 0) & '0' when currentState /= K else
                                 to_unsigned(1, input'length) when currentState = K;
    end generate;
    
    prcs:
        process(nextState3)
        variable tempState: unsigned(width-1 downto 0);
        variable break: std_logic;
        begin
            break := '0';
            tempState := (others => '0');
            for i in nextState3'range loop
                if nextState3(i) = '1' and break = '0' then
                    break := '1';
                    tempState(i) := '1';
                end if;
                if break = '0' then
                    tempState(i) := '0';
                end if;
            end loop;
            processState <= tempState;
        end process;
	
	-- memory register
	process(clock, reset) is
	begin
		if reset='1' then
			currentState <= to_unsigned(1, currentState'length);
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output-logic
   	output <= std_logic_vector(currentState);

end architecture;