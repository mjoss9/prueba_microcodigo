-- modulo Registro de direcciones para 16 bits 
-- flip flop D para 16 bits
library IEEE;
use IEEE.std_logic_1164.all;

entity reg_direc is
    port (
        in_0 : in integer range 0 to 65535; --Entrada
        clock : in std_logic;         --Entrada clock
        control : in std_logic;
        I : in std_logic; -- Incremento
		  Q : out integer range 0 to 65535);--Salida
end entity;
--Arquitectura del Acumulador
architecture arch of reg_direc is
    signal dato_aux : integer range 0 to 65535;
begin
    identifier : process (clock)
    begin
        if (falling_edge(clock)) then --Flanco de subida
           if(control = '1') then
                dato_aux <= in_0;
            end if;
            if (I = '1') then
                dato_aux <= dato_aux + 1;
            end if;
        end if;
    end process;
    --Salida del registro
    Q <= dato_aux;
end arch;