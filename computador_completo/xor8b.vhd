--Funcion XOR para 8 bits
library ieee;
use ieee.std_logic_1164.all;
--Definimos la entidad para la funcion XOR para 8 bits:
entity xor8b is
port (in_0	: in std_logic_vector(7 downto 0); --Entrada x de 8 bits
		in_1	: in std_logic_vector(7 downto 0); --Entrada y de 8 bits
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
end xor8b;

architecture aqr of xor8b is
begin
y <= in_0 xor in_1;
end aqr;