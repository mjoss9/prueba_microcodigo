-- modulo Registro de direcciones para 16 bits 
-- flip flop D para 16 bits
library IEEE;
use IEEE.std_logic_1164.all;

entity reg_direc is
    port (
        in_0 : in std_logic_vector (15 downto 0); --Entrada
        clock : in std_logic;         --Entrada clock
		  Q : out std_logic_vector (15 downto 0));--Salida
end entity;
--Arquitectura del Acumulador
architecture arch of reg_direc is
begin
    identifier : process (clock)
    begin
        if (rising_edge(clock)) then --Flanco de subida
           Q <= in_0;
        end if;
    end process;
end arch;