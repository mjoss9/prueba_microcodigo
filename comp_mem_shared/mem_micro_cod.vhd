-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(6 downto 0);
        data : out std_logic_vector(11 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 127) of std_logic_vector(11 downto 0);
    signal mem : mem_type := (
		0  => "000011000001",  --- Instrucion de comienzo
        1  => "000000010001",
        2  => "010000000011",

        32 => "000000010001",  --- Instruccion de NOT
        33 => "010000000001",
        34 => "100101000011",

        64 => "000000010001",  --- Instruccion de ADD mem
        65 => "010101000001",
        66 => "000000010001",
        67 => "001000000001",
        68 => "000000110001",
        69 => "100101000011",

        80 => "000000010001",  --- Instruccion de INC mem
        81 => "010101000001",
        82 => "000000010001",
        83 => "001000000001",
        84 => "000000110001",
        85 => "100101000011",

        96 => "000000010001",  --- Instruccion LDA
        97 => "010101000001",
        98 => "000000010001",
        99 => "001000000001",
        100 => "000000110001",
        101 => "100101000011",

        104 => "000000010001",  --- Instruccion de STA
        105 => "010101000001",
        106 => "000000010001",
        107 => "001000000001",
        108 => "000000110001",
        109 => "000101001011",

        -- Finalizando a memoria com zeros
        others => "000000000000"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;