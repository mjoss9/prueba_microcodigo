--Interfaz de memoria
library ieee;
use ieee.std_logic_1164.all;

entity InterfazMemo is
port( IXH,IXL,IYH,IYL,PPH,PPL, PIH, PIL, resALU: in std_logic_vector(7 downto 0);
		s22: in std_logic;
		s: in std_logic_vector(3 downto 0);		
		ALU_MEM: out std_logic_vector(7 downto 0);
		DatoMEM: inout std_logic_vector(7 downto 0)
);
end InterfazMemo;
architecture arch of InterfazMemo is
signal outMUX: std_logic_vector(7 downto 0);
begin
	with s select
	outMUX <= 	IXH when "0000",
				IXL when "0001",
				IYH when "0010",
				IYL when "0011",
				PPH when "0100",
				PPL when "0101",
				PIH when "0110",
				PIL when "0111",
				resALU when "1000";
				 
	process(s22)
	begin
	if(s22 = '1') then
		DatoMEM <= outMUX;
	else
		ALU_MEM <= DatoMEM;
	end if;
	end process;
end arch;