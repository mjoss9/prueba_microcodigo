-- modulo flip flop tipo D
library ieee;
use ieee.std_logic_1164.all;

entity ffD is
port(in_0,clock:in std_logic;  --entrada de reloj y de datos
		q : buffer std_logic:='0');  --salida Q
end ffD;

architecture arch of ffD is
begin
		process(in_0,clock)
		begin
			IF clock'event and clock='1' then  --de flaco de subida
				if (in_0='0') then
					q<='0';
				elsif (in_0='1') then
					q<='1';
				end if;
			end if;
		end process;
end arch;