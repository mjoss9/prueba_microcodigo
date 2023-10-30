--Control de paso de 8 bits
library ieee;
use ieee.std_logic_1164.all;
--Definimos la entidad para el control de paso de 8 bits:
entity paso8b is
port (in_0	: in std_logic_vector(7 downto 0); --Entrada de 8 bits
		ctl_pass	:	in std_logic;             --Entrada de control
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
end paso8b;

architecture aqr of paso8b is
begin
process(in_0, ctl_pass)
begin
--Utilizamos una condicional:
	if (ctl_pass = '1') then y <= in_0;
	else y <= "00000000";
end if;
end process;
end aqr;