--Interfaz de memoria
library ieee;
use ieee.std_logic_1164.all;

entity InterfazMemo is
port( acumulador,resALU,IXH,IXL,IYH,IYL,PPH,PPL: in std_logic_vector(7 downto 0);
		s21: in std_logic;
		s: in std_logic_vector(64 downto 62);		--64: MSB
		ALU_MEM: out std_logic_vector(7 downto 0);
		DatoMEM: inout std_logic_vector(7 downto 0)
);
end InterfazMemo;
architecture arch of InterfazMemo is
signal outMUX: std_logic_vector(7 downto 0);
begin
	with s select
	outMUX <= acumulador when "000",
				 resALU when "001",
				 IXH when "010",
				 IXL when "011",
				 IYH when "100",
				 IYL when "101",
				 PPH when "110",
				 PPL when "111";
				 
	process(s21)
	begin
	if(s21 = '1') then
		DatoMEM <= outMUX;
	else
		ALU_MEM <= DatoMEM;
	end if;
	end process;
end arch;