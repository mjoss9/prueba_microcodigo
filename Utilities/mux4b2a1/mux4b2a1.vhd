--Diseño del MUX 2 a 1 para 8 bits
library ieee;
use ieee.std_logic_1164.all;
--Describiendo la entidad del MUX 2 a 1
entity mux4b2a1 is
port(	in_0,in_1			:	in std_logic_vector(3 downto 0);
		s				:	in std_logic;
		y				:	out std_logic_vector(3 downto 0));
end mux4b2a1;

architecture cuerpoMux	of mux4b2a1 is
begin
process(in_0,in_1,s)
begin
	if (s = '0') then y <= in_0;
	else y <= in_1;
end if;
end process;
end cuerpoMux;