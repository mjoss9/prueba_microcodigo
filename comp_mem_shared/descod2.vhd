library ieee;
use ieee.std_logic_1164.all;

entity descod2 is
    port (in_0: in std_logic_vector(7 downto 0);
          out_0: out std_logic_vector(7 downto 0));
end descod2;

architecture arch of descod2 is
begin
  process(in_0)
  begin
    case in_0 is
      -- Instrucciones Logicas - Aritmeticas
        -- NEG
      when x"43" => out_0 <= x"33"; --IX
      when x"C3" => out_0 <= x"33"; --IY
        -- NOT
      when x"44" => out_0 <= x"34"; --IX
      when x"C4" => out_0 <= x"34"; --IY
        -- INC
      when x"53" => out_0 <= x"73"; --IX
      when x"D3" => out_0 <= x"73"; --IY
        -- DEC
      when x"54" => out_0 <= x"74"; --IX
      when x"D4" => out_0 <= x"74"; --IY
        -- AND A
      when x"05" => out_0 <= x"75"; --IX
      when x"85" => out_0 <= x"75"; --IY
        -- AND B
      when x"15" => out_0 <= x"B5"; --IX
      when x"95" => out_0 <= x"B5"; --IY
        -- AND C
      when x"25" => out_0 <= x"F5"; --IX
      when x"A5" => out_0 <= x"F5"; --IY
        -- OR A
      when x"06" => out_0 <= x"76"; --IX
      when x"86" => out_0 <= x"76"; --IY
        -- OR B
      when x"16" => out_0 <= x"B6"; --IX
      when x"96" => out_0 <= x"B6"; --IY
        -- OR C
      when x"26" => out_0 <= x"F6"; --IX
      when x"A6" => out_0 <= x"F6"; --IY
        -- XOR A
      when x"07" => out_0 <= x"77"; --IX
      when x"87" => out_0 <= x"77"; --IY
        -- XOR B
      when x"17" => out_0 <= x"B7"; --IX
      when x"97" => out_0 <= x"B7"; --IY
        -- XOR C
      when x"27" => out_0 <= x"F7"; --IX
      when x"A7" => out_0 <= x"F7"; --IY
        -- ADD A
      when x"08" => out_0 <= x"78"; --IX
      when x"88" => out_0 <= x"78"; --IY
        -- ADD B
      when x"18" => out_0 <= x"B8"; --IX
      when x"98" => out_0 <= x"B8"; --IY
        -- ADD C
      when x"28" => out_0 <= x"F8"; --IX
      when x"A8" => out_0 <= x"F8"; --IY
        -- SUB A
      when x"09" => out_0 <= x"79"; --IX
      when x"89" => out_0 <= x"79"; --IY
        -- SUB B
      when x"19" => out_0 <= x"B9"; --IX
      when x"99" => out_0 <= x"B9"; --IY
        -- SUB C
      when x"29" => out_0 <= x"F9"; --IX
      when x"A9" => out_0 <= x"F9"; --IY
        -- ADC A
      when x"0A" => out_0 <= x"7A"; --IX
      when x"8A" => out_0 <= x"7A"; --IY
        -- ADC B
      when x"1A" => out_0 <= x"BA"; --IX
      when x"9A" => out_0 <= x"BA"; --IY
        -- ADC C
      when x"2A" => out_0 <= x"FA"; --IX
      when x"AA" => out_0 <= x"FA"; --IY
        -- SBC A
      when x"0B" => out_0 <= x"7B"; --IX
      when x"8B" => out_0 <= x"7B"; --IY
        -- SBC B
      when x"1B" => out_0 <= x"BB"; --IX
      when x"9B" => out_0 <= x"BB"; --IY
        -- SBC C
      when x"2B" => out_0 <= x"FB"; --IX
      when x"AB" => out_0 <= x"FB"; --IY
        -- CMP A
      when x"0C" => out_0 <= x"7C"; --IX
      when x"8C" => out_0 <= x"7C"; --IY
        -- CMP B
      when x"1C" => out_0 <= x"BC"; --IX
      when x"9C" => out_0 <= x"BC"; --IY
        -- CMP C
      when x"2C" => out_0 <= x"FC"; --IX
      when x"AC" => out_0 <= x"FC"; --IY

      -- Instrucciones de control
        -- CLR
      when x"41" => out_0 <= x"31"; --IX
      when x"C1" => out_0 <= x"31"; --IY

      -- Instrucciones de rotacion y dezplazamiento
        --ROD
      when x"4D" => out_0 <= x"3D"; --IX
      when x"CD" => out_0 <= x"3D"; --IY
        --ROI
      when x"4E" => out_0 <= x"3E"; --IX
      when x"CE" => out_0 <= x"3E"; --IY
        --RCD
      when x"5D" => out_0 <= x"7D"; --IX
      when x"DD" => out_0 <= x"7D"; --IY
        --RCI
      when x"5E" => out_0 <= x"7E"; --IX
      when x"DE" => out_0 <= x"7E"; --IY
        --DAD
      when x"6D" => out_0 <= x"BD"; --IX
      when x"ED" => out_0 <= x"BD"; --IY
        --DAI
      when x"6E" => out_0 <= x"BE"; --IX
      when x"EE" => out_0 <= x"BE"; --IY
        --DLD
      when x"7D" => out_0 <= x"FD"; --IX
      when x"FD" => out_0 <= x"FD"; --IY

      --Instrucciones de transferencia
        --LDA A
      when x"01" => out_0 <= x"71"; --IX
      when x"81" => out_0 <= x"71"; --IY
        --LDA B
      when x"11" => out_0 <= x"B1"; --IX
      when x"91" => out_0 <= x"B1"; --IY
        --LDA C
      when x"21" => out_0 <= x"F1"; --IX
      when x"A1" => out_0 <= x"F1"; --IY
        --STA A
      when x"02" => out_0 <= x"72"; --IX
      when x"82" => out_0 <= x"72"; --IY
        --STA B
      when x"12" => out_0 <= x"B2"; --IX
      when x"92" => out_0 <= x"B2"; --IY
        --STA C
      when x"22" => out_0 <= x"F2"; --IX
      when x"A2" => out_0 <= x"F2"; --IY

      when others => out_0 <= x"00";
    end case;
  end process;
end arch;