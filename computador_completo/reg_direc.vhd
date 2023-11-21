-- modulo Registro de direcciones para 16 bits 
-- flip flop D para 16 bits
library IEEE;
use IEEE.std_logic_1164.all;

entity reg_direc is
    port (
        in_0 : in integer range 0 to 65535; --Entrada
        clock : in std_logic;         --Entrada clock
        control : in std_logic;
		  Q : out integer range 0 to 65535);--Salida
end entity;
--Arquitectura del Acumulador
architecture arch of reg_direc is
begin
    identifier : process (clock)
    begin
        if (falling_edge(clock)) then --Flanco de subida
           if(control = '1') then
            Q <= in_0;
            end if;
        end if;
    end process;
end arch;