--Diseño del MUX 8 a 1 para 8 bits
library ieee;
use ieee.std_logic_1164.all;
--Describiendo la entidad del MUX 8 a 1
entity mux8a1 is
port(	in0,in1,in2,in3,in4,in5,in6,in7	:	in std_logic_vector(7 downto 0);
		s						:	in std_logic_vector(2 downto 0);
		y						:	out std_logic_vector(7 downto 0));
end mux8a1;

architecture cuerpoMux	of mux8a1 is
begin
		with s select
		y<=in0 when	"000",
			in1 when	"001",
			in2 when	"010",
			in3 when	"011",
			in4 when	"100",
			in5 when	"101",
			in6 when	"110",
			in7 when	"111";
end cuerpoMux;