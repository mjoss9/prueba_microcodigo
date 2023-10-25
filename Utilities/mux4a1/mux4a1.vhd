--Diseño del MUX 4 a 1 para 8 bits
library ieee;
use ieee.std_logic_1164.all;
--Describiendo la entidad del MUX 4 a 1
entity mux4a1 is
port(	in0,in1,in2,in3	:	in std_logic_vector(7 downto 0);
		s				:	in std_logic_vector(1 downto 0);
		y				:	out std_logic_vector(7 downto 0));
end mux4a1;

architecture cuerpoMux	of mux4a1 is
begin
		with s select
		y<=in0 when	"00",
			in1 when	"01",
			in2 when	"10",
			in3 when	"11";
end cuerpoMux;