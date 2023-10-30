-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(10 downto 0);
        data : out std_logic_vector(12 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 2048) of std_logic_vector(12 downto 0);
    signal mem : mem_type := (
		0  => "0000011000001",  --- Instrucion de comienzo
        1  => "0000000010001",
        2  => "0010000000011",

        32 => "0100101000001",  --- Instruccion de NOT
        33 => "0000000010001",
        34 => "0010000000011",

        64 => "0000000010001",  --- Instruccion de ADD mem
        65 => "0010101000001",
        66 => "0000000010001",
        67 => "0001000000001",
        68 => "0000000110001",
        69 => "0100101000011",

        80 => "0000101000001",  --- Instruccion de INC mem
        81 => "0000000010001",
        82 => "0001000000001",
        83 => "0000000110001",
        84 => "0100101000001",
        85 => "0000000010001",
        86 => "0010000000011",

        96 => "0000101000001",  --- Instruccion LDA
        97 => "0000000010001",
        98 => "0001000000001",
        99 => "0000000110001",
        100 => "0100101000001",
        101 => "0000000010001",
        102 => "0010000000011",

        104 => "0000101000001",  --- Instruccion de STA
        105 => "0000000010001",
        106 => "0001000000001",
        107 => "0000000110001",
        108 => "0000101001001",
        109 => "0000000010001",
        110 => "0010000000011",

        -- Finalizando a memoria com zeros
        others => "0000000000000"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;