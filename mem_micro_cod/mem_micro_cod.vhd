-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(7 downto 0);
        data : out std_logic_vector(31 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 127) of std_logic_vector(9 downto 0);
    signal mem : mem_type := (
        64 => "0100000100",
        65 => "0001100000",
        66 => "0000001100",
        67 => "0010010000",
        68 => "0000011100",
        69 => "0000011100",
        0 => "00000000000000000000000000000000",
        -- Finalizando a memoria com zeros
        others => "00000000000000000000000000000000"
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;