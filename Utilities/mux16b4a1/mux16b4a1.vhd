--Diseño del MUX 4 a 1 para 16 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--Describiendo la entidad del MUX 4 a 1
entity mux16b4a1 is
port(	in_0			:	IN integer range 0 to 65535;--Entradas del multiplexor
		in_1			:	IN integer range 0 to 65535;--Entradas del multiplexor
		in_2			:	IN integer range 0 to 65535;--Entradas del multiplexor
		in_3			:	IN integer range 0 to 65535;--Entradas del multiplexor
		s				:	in std_logic_vector(1 downto 0);
		y				:	OUT integer range 0 to 65535);--Salida del multiplexor
end mux16b4a1;

architecture cuerpoMux	of mux16b4a1 is
begin
	with s select
		y<=in_0 when	"00",
			in_1 when	"01",
			in_2 when	"10",
			in_3 when	"11";
end cuerpoMux;