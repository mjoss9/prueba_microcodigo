-- Generador de microsecuencias con posibilidad de reset
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generador_microsec is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic; -- Control
        enable_descod: in std_logic; -- Descodificador
        q: out std_logic_vector(3 downto 0)
    );
end entity generador_microsec;

architecture rtl of generador_microsec is
    signal q_int: unsigned(3 downto 0) := (others => '0');
begin
    process(clk, reset, enable, enable_descod)
    begin
        if (enable = '1' and enable_descod = '1') then
            if falling_edge(clk) then
                if reset = '1' then
                    q_int <= (others => '0');
                else
                    q_int <= q_int + 1;
                end if;
            end if;
        else
            q_int <= (others => '0');
        end if;
    end process;
    q <= std_logic_vector(q_int);
end architecture rtl;