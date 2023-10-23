--Diseño del MUX 8 a 1 para 8 bits
library ieee;
use ieee.std_logic_1164.all;
--Describiendo la entidad del MUX 8 a 1
entity mux8a1 is
port(	in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7	:	in std_logic_vector(7 downto 0);
		s						:	in std_logic_vector(2 downto 0);
		y						:	out std_logic_vector(7 downto 0));
end mux8a1;

architecture cuerpoMux	of mux8a1 is
begin
		with s select
		y<=in_0 when	"000",
			in_1 when	"001",
			in_2 when	"010",
			in_3 when	"011",
			in_4 when	"100",
			in_5 when	"101",
			in_6 when	"110",
			in_7 when	"111";
end cuerpoMux;