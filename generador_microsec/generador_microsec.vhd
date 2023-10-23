-- Generador de microsecuencias con posibilidad de reset
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microsecuencia is
    port(
        clk: in std_logic;
        reset: in std_logic;
        q: out std_logic_vector(2 downto 0)
    );
end entity microsecuencia;

architecture rtl of microsecuencia is
    signal q_int: unsigned(N-1 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            q_int <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                q_int <= q_int + 1;
            end if;
        end if;
    end process;
    q <= std_logic_vector(q_int);
end architecture rtl;