--Diseño del MUX 4 a 1 para 4 bits
library ieee;
use ieee.std_logic_1164.all;
--Describiendo la entidad del MUX 2 a 1
entity mux4b4a1 is
port(	in_0,in_1, in_2, in_3 :	in std_logic_vector(3 downto 0);
		s				:	in std_logic_vector(1 downto 0);
		y				:	out std_logic_vector(3 downto 0));
end mux4b4a1;

architecture cuerpoMux	of mux4b4a1 is
begin
	with s select
		y<=in_0 when	"00",
			in_1 when	"01",
			in_2 when	"10",
			in_3 when	"11";
end cuerpoMux;