library IEEE;
use IEEE.Std_Logic_1164.all;

entity registrador is
generic(n:integer);
port (D: in std_logic_vector(n-1 downto 0);  
	  CLK, RST: in std_logic;
	  H: out std_logic_vector(n-1 downto 0));
end registrador;

architecture registrador of registrador is
begin 
	process(CLK, D, RST)
	begin
		if (RST = '1') then H <= "0000";
		elsif (CLK'event and CLK = '1') then H <= D;
		end if;
	end process;
end registrador;