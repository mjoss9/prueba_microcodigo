-- modulo puntero
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity puntero is
port(dat: in integer range 0 to 65536;	--Dato
		I_D,load,enable,clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		pointer: out integer range 0 to 65536);  --Puntero
end puntero;

architecture arch of puntero is
	signal pointer_aux : integer range 0 to 65536 := 0;
begin
	--pointer_aux <= 0;
	process(enable,clock,load,I_D,pointer_aux)
	begin
	if(enable = '1') then
		if(falling_edge(clock)) then
			if (load = '0') then		--
				if (I_D = '0') then
					pointer_aux <= pointer_aux - 1;
				else
					pointer_aux <= pointer_aux + 1;
				end if;
			else
				pointer_aux <= dat;
			end if;
		end if;
	end if;
	end process;
	pointer <= pointer_aux;
end arch;