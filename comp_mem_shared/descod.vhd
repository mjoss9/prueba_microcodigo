library ieee;
use ieee.std_logic_1164.all;

entity descod is
    port(
        data_in : in std_logic_vector(3 downto 0);
        data_out : out std_logic_vector(21 downto 0));
end entity descod;

architecture rtl of descod is
begin
    process(data_in)
    begin
        case data_in is
            when "0000" => data_out <= "0010000000011000000000";  --clr
            when "0001" => data_out <= "0000000000011000010000";  --nop
            when "0010" => data_out <= "0010000000011000001000";  --in
            when "0011" => data_out <= "0010000000011000010101";  --neg
            when "0100" => data_out <= "0010000000011000010100";  --not
            when "0101" => data_out <= "1010000000000000000000";  --and
            when "0110" => data_out <= "1010000000001000000000";  --or
            when "0111" => data_out <= "1010000000010000000000";  --xor
            when "1000" => data_out <= "1011101101011000011000";  --add ---
            when "1001" => data_out <= "1011101101011000011011";  --sub  
            when "1010" => data_out <= "0011101000011000001001";  --inc
            when "1011" => data_out <= "0011101000011000001100";  --dec 
            when "1100" => data_out <= "1010000000011000001000";  --lda 
            when "1101" => data_out <= "1100000000011000010000";  --sta
            when "1110" => data_out <= "1011101101011000111000";  --adc 
            when "1111" => data_out <= "0010000000011000000000";  --nop
            when others => data_out <= "0000000000000000000000";
        end case;
    end process;
end architecture rtl;