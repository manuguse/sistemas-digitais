library ieee;
use ieee.std_logic_1164.all;

entity bcMipsMulticiclo is
	port(
		-- control in
		clock, clear: in std_logic;
		opcode: in std_logic_vector(5 downto 0);
		-- control out
		EscMem, EscReg, IouD, IREsc, LerMem, 
		PCEsc, PCEscCond, MemParaReg, 
		RegDst, ULAFonteA: out std_logic;
		FontePC, ULAFonteB, ULAOp: out std_logic_vector(1 downto 0)
	);
end entity;

architecture descricaoComportamental of bcMipsMulticiclo is
-- COMPLETE
signal estadoAtual, proximoEstado: --COMPLETE
begin
    -- LOGICA DE PROXIMO ESTADO
    -- COMPLETE

    
    -- REGISTRADOR DE ESTADO
    process(clock) is
    begin
        if clear='1' then
            estadoAtual <= -- COMPLETE (estado inicial);
        elsif rising_edge(clock) then
            estadoAtual <= proximoEstado;
        end if;
    end process;
    
    -- LOGICA DE SAIDA
    -- COMPLETE
end architecture;
