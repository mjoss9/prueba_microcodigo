-- Generador de microsecuencias con posibilidad de reset
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generador_microsec is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        q: out std_logic_vector(3 downto 0)
    );
end entity generador_microsec;

architecture rtl of generador_microsec is
    signal q_int: unsigned(3 downto 0);
begin
    process(clk, reset)
    begin
        if enable = '1' then
            if reset = '1' then
                q_int <= (others => '0');
            elsif falling_edge(clk) then
                q_int <= q_int + 1;
            end if;
        end if;
    end process;
    q <= std_logic_vector(q_int);
end architecture rtl;