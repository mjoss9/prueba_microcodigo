-- modulo Acumulador para 8 bits 
-- flip flop D para 8 bits
library IEEE;
use IEEE.std_logic_1164.all;

entity acumulador is
    port (
        in_0 : in std_logic_vector (7 downto 0); --Entrada
        clock : in std_logic;         --Entrada cloc
        control : in std_logic;
		  Q : out std_logic_vector (7 downto 0));--Salida
end entity;
--Arquitectura del Acumulador
architecture arch of acumulador is
begin
    identifier : process (clock, control)
    begin
        if (falling_edge(clock)) then --Flanco de subida
           if(control = '1') then
            Q <= in_0;
            end if;
        end if;
    end process;
end arch;