library ieee;
use ieee.std_logic_1164.all;

entity controle is
port(
	clock, clear: in std_logic;
	iniciar: in std_logic;
	pronto: out std_logic;
	-- BO
	ctrl1, ctrl2, ctrl3: out std_logic;
	stt1: in std_logic);
end entity;

architecture bhvr of controle is

	type STATE is (L01, L02, L03, L04, L05);
	signal currentState, nextState: STATE;

begin

	-- next state
	process(iniciar, currentState, stt1) is
	begin
		nextState <= ;
	end process;

	-- register
	process(clock, clear) is
	begin
		if clear = '1' then
			currentState <= L01;
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;

	-- output
	ctrl1 <= '1' when currentState = L02 else '0';
	ctrl2 <= '1' when currentState = L05 else '0';
	ctrl3 <= '1' when currentState = L04 else '0';

end architecture;