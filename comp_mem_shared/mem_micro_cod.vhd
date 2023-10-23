-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(6 downto 0);
        data : out std_logic_vector(10 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 127) of std_logic_vector(10 downto 0);
    signal mem : mem_type := (
		  0  => "01000000000",
        64 => "00011000001",
        65 => "00000010001",
        66 => "00100100001",
        67 => "00000110001",
        68 => "00000110001",
        -- Finalizando a memoria com zeros
        others => "00000000000"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;