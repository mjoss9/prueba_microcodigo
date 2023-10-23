--Sumador completo de 1 bit
library ieee;
use ieee.std_logic_1164.all;
--Definimos la entidad para el sumador completo:
entity fullAdd1b is
port (	in_0,in_1	: in std_logic;   --Entradas de 1 bit
			c_in	:	in std_logic;  --Acarreo de entrada
			y	: 		out std_logic; --Suma
			c_out	:	out std_logic);--Acarreo de salida
end fullAdd1b;

architecture aqr of fullAdd1b is
begin
--Utilizamos las ecuaciones del sumador completo:
	y	<=	(in_0 xor in_1) xor c_in;
	c_out	<= (in_0 and in_1) or ((in_0 xor in_1 ) and c_in);
end aqr;