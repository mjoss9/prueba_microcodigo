--Diseño del MUX 2 a 1 para 8 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--Describiendo la entidad del MUX 2 a 1
entity mux2a1_rd is
port(	in_0			:	IN integer range 0 to 255;--Entradas del multiplexor
		in_1			:	IN STD_LOGIC_VECTOR (7 DOWNTO 0);--Entradas del multiplexor
		s				:	in std_logic;
		y				:	OUT STD_LOGIC_VECTOR (7 DOWNTO 0));--Salida del multiplexor
end mux2a1_rd;

architecture cuerpoMux	of mux2a1_rd is
signal vect : std_LOGIC_VECTOR(7 downto 0);
begin
vect <= std_logic_vector( to_unsigned( in_0, vect'length));
process(in_0,in_1,s)
begin
	if (s = '0') then y <= vect;
	else y <= in_1;
end if;
end process;
end cuerpoMux;