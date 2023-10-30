library ieee;
use ieee.std_logic_1164.all;
-- Describimos la entidad del sumador completo de 8 bits:
entity fullAdd8b is
port (	in_0	: in std_logic_vector(7 downto 0); 	--Entrada X
			in_1	: in std_logic_vector(7 downto 0);  --Entrada Y
			c_in:	in std_logic;							--Acarreo de entrada
			y	: out std_logic_vector(7 downto 0); --Suma
			c_out:	out std_logic);						--Acarreo de salida
end fullAdd8b;

architecture aqr of fullAdd8b is
--Usamos como compenente sumadores completos de 1 bit:
component fullAdd1b
port (	in_0,in_1	: in std_logic;   --Entradas de 1 bit
			c_in	:	in std_logic;  --Acarreo de entrada
			y	: 		out std_logic; --Suma
			c_out	:	out std_logic);--Acarreo de salida
end component;
--Declaramos una variable auxiliar n de 7 bits, para alamacenar el acarreo de cada etapa.
		signal n	: std_logic_vector (7 downto 0);
--Realizamos la suma bit a bit de X con Y
begin
		fulladd0 : fullAdd1b port map(in_0(0),in_1(0),c_in,y(0),n(0));
		fulladd1 : fullAdd1b port map(in_0(1),in_1(1),n(0),y(1),n(1));
		fulladd2 : fullAdd1b port map(in_0(2),in_1(2),n(1),y(2),n(2));
		fulladd3 : fullAdd1b port map(in_0(3),in_1(3),n(2),y(3),n(3));
		fulladd4 : fullAdd1b port map(in_0(4),in_1(4),n(3),y(4),n(4));
		fulladd5 : fullAdd1b port map(in_0(5),in_1(5),n(4),y(5),n(5));
		fulladd6 : fullAdd1b port map(in_0(6),in_1(6),n(5),y(6),n(6));
		fulladd7 : fullAdd1b port map(in_0(7),in_1(7),n(6),y(7),n(7));
-- El acarreo de salida es el ultimo bit que se genera y que se guarda en la variable n
		c_out<=n(7); 
end aqr;
		
		
		
