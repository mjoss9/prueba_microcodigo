-- modulo Registro de datos
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity rdat is
    port (
        dataH : in std_logic_vector (7 downto 0); --Entrada
        dataL : in std_logic_vector (7 downto 0); --Entrada
        clock : in std_logic;         --Entrada clock
        ctrl_dataH : in std_logic;
        ctrl_dataL : in std_logic;
        I : in std_logic; -- Incremento
		Q: out std_logic_vector (15 downto 0));--Salida
end entity;
--Arquitectura del Registro de datos
architecture arch of rdat is
    signal dato_aux : std_logic_vector (15 downto 0) := (others => '0');
begin
    process (clock, ctrl_dataH, ctrl_dataL, I)
    begin
        if (clock'event and clock = '1') then
            if (ctrl_dataH = '1') then
                dato_aux(15 downto 8) <= dataH;
            end if;
            if (ctrl_dataL = '1') then
                dato_aux(7 downto 0) <= dataL;
            end if;
            if (I = '1') then
                dato_aux <= std_logic_vector(unsigned(dato_aux) + 1);
            end if;
        end if;
    end process;
    -- Salida del registro auxiliar
    Q <= dato_aux;
end arch;