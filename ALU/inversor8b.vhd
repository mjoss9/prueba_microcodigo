--Inversor de 8 bits
library ieee;
use ieee.std_logic_1164.all;
--Definimos la entidad para inversor de 8 bits:
entity inversor8b is
port (in_0	: in std_logic_vector(7 downto 0); --Entrada de 8 bits
		ctl_inv	:	in std_logic;             --Entrada de control
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
end inversor8b;

architecture aqr of inversor8b is
begin
process(in_0, ctl_inv)
begin
--Utilizamos una condicional:
	if (ctl_inv = '1') then y <= not in_0;
	else y <= in_0;
end if;
end process;
end aqr;