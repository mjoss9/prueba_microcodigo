library ieee;
use ieee.std_logic_1164.all;

entity descodCC is
  port(
      in_s: in std_logic_vector(7 downto 0);
      ctrl_index: in std_logic;
      out_s: out std_logic_vector(67 downto 0)
  );
end descodCC;

architecture arch of descodCC is
-- Descodificador USCE
component descodUSCE
  port(
    in_s: in std_logic_vector(7 downto 0);
    out_s: out std_logic_vector(30 downto 0)
  );
end component;
-- Descodificador 2 para instrucciones indexadas
component descod2
  port (in_0: in std_logic_vector(7 downto 0);
  out_0: out std_logic_vector(7 downto 0));
end component;

-- Conexiones para el descodificador USCE
signal usce_out: std_logic_vector(30 downto 0);
signal codOp_index: std_logic_vector(7 downto 0);
signal in_descodUSCE: std_logic_vector(7 downto 0);

-- Conexiones para descodificador Computador Completo CC
begin
-- Descodificamos la instruccion
descod2_0 : descod2 port map(in_0 => in_s, out_0 => codOp_index);
-- Descodificamos la instruccion indexada
descodUSCE_0 : descodUSCE port map(in_s => in_descodUSCE, out_s => usce_out);

  process(ctrl_index, codOp_index, in_s, usce_out) is
  begin
    if ctrl_index = '1' then
      in_descodUSCE <= codOp_index;
         case in_s is
           -- Instrucciones Logicas - Aritmeticas
            -- NEG
          when x"43" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"C3" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- NOT
          when x"44" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"C4" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- INC
          when x"53" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"D3" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- DEC
          when x"54" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"D4" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- AND A
          when x"05" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"85" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- AND B
          when x"15" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"95" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- AND C
          when x"25" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"A5" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- OR A
          when x"06" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"86" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- OR B
          when x"16" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"96" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- OR C
          when x"26" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"A6" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- XOR A
          when x"07" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"87" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- XOR B
          when x"17" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"97" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- XOR C
          when x"27" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"A7" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- ADD A
          when x"08" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"88" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- ADD B
          when x"18" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"98" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- ADD C
          when x"28" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"A8" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- SUB A
          when x"09" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"89" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- SUB B
          when x"19" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"99" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- SUB C
          when x"29" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"A9" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- ADC A
          when x"0A" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"8A" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- ADC B
          when x"1A" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"9A" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- ADC C
          when x"2A" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"AA" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- SBC A
          when x"0B" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"8B" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- SBC B
          when x"1B" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"9B" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
          -- SBC C
          when x"2B" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"AB" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
          -- CMP A
          when x"0C" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"8C" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
          -- CMP B
          when x"1C" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"9C" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
          -- CMP C
          when x"2C" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"AC" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
          -- Instrucciones de control
          -- CLR
          when x"41" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"C1" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
          -- Instrucciones de rotacion y dezplaamiento
            -- ROD
          when x"4D" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"CD" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- ROI
          when x"4E" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"CE" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- RCD
          when x"5D" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"DD" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- RCI
          when x"5E" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"DE" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- DAD
          when x"6D" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"ED" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- DAI
          when x"6E" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"EE" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- DLD
          when x"7D" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"FD" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- Instrucciones de transferencia
            -- LDA A
          when x"01" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"81" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- LDA B
          when x"11" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"91" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- LDA C
          when x"21" => out_s <= "0000000000000100000000000000000000100" & usce_out; --IX
          when x"A1" => out_s <= "0000000100000100000000000000000000100" & usce_out; --IY
            -- STA A
          when x"02" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"82" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- STA B
          when x"12" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"92" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY
            -- STA C
          when x"22" => out_s <= "0100000000000100000000000000000000100" & usce_out; --IX
          when x"A2" => out_s <= "0100000100000100000000000000000000100" & usce_out; --IY

          when others => out_s <= "0000000000000000000000010000000000000" & usce_out;
         end case;
    else
      in_descodUSCE <= in_s;
         case in_s is
           -- Instrucciones Logicas - Aritmeticas
            -- NEG
          when x"03" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- NEG A
          when x"13" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- NEG B
          when x"23" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- NEG C
          when x"33" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- NEG M
            -- NOT
          when x"04" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- NOT A
          when x"14" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- NOT B
          when x"24" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- NOT C
          when x"34" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- NOT M
            -- INC
          when x"43" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- INC A
          when x"53" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- INC B
          when x"63" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- INC C
          when x"73" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- INC M
            -- DEC
          when x"44" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DEC A
          when x"54" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DEC B
          when x"64" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DEC C
          when x"74" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- DEC M
            -- AND A
          when x"45" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- AND A,N
          when x"55" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- AND A,B
          when x"65" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- AND A,C
          when x"75" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- AND A,M
            -- AND B
          when x"85" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- AND B,N
          when x"95" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- AND B,A
          when x"A5" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- AND B,C
          when x"B5" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- AND B,M
            -- AND C
          when x"C5" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- AND C,N
          when x"D5" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- AND C,A
          when x"E5" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- AND C,B
          when x"F5" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- AND C,M
            -- OR A
          when x"46" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- OR A,N
          when x"56" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- OR A,B
          when x"66" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- OR A,C
          when x"76" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- OR A,M
            -- OR B
          when x"86" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- OR B,N
          when x"96" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- OR B,A
          when x"A6" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- OR B,C
          when x"B6" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- OR B,M
            -- OR C
          when x"C6" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- OR C,N
          when x"D6" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- OR C,A
          when x"E6" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- OR C,B
          when x"F6" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- OR C,M
            -- XOR A
          when x"47" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- XOR A,N
          when x"57" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- XOR A,B
          when x"67" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- XOR A,C
          when x"77" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- XOR A,M
            -- XOR B
          when x"87" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- XOR B,N
          when x"97" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- XOR B,A
          when x"A7" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- XOR B,C
          when x"B7" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- XOR B,M
            -- XOR C
          when x"C7" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- XOR C,N
          when x"D7" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- XOR C,A
          when x"E7" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- XOR C,B
          when x"F7" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- XOR C,M
            -- ADD A
          when x"48" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- ADD A,N
          when x"58" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADD A,B
          when x"68" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADD A,C
          when x"78" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- ADD A,M
            -- ADD B
          when x"88" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- ADD B,N
          when x"98" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADD B,A
          when x"A8" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADD B,C
          when x"B8" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- ADD B,M
            -- ADD C
          when x"C8" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- ADD C,N
          when x"D8" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADD C,A
          when x"E8" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADD C,B
          when x"F8" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- ADD C,M
            -- SUB A
          when x"49" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- SUB A,N
          when x"59" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SUB A,B
          when x"69" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SUB A,C
          when x"79" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- SUB A,M
            -- SUB B
          when x"89" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- SUB B,N
          when x"99" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SUB B,A
          when x"A9" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SUB B,C
          when x"B9" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- SUB B,M
            -- SUB C
          when x"C9" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- SUB C,N
          when x"D9" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SUB C,A
          when x"E9" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SUB C,B
          when x"F9" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- SUB C,M
            -- ADC A
          when x"4A" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- ADC A,N
          when x"5A" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADC A,B
          when x"6A" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADC A,C
          when x"7A" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- ADC A,M
            -- ADC B
          when x"8A" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- ADC B,N
          when x"9A" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADC B,A
          when x"AA" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADC B,C
          when x"BA" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- ADC B,M
            -- ADC C
          when x"CA" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- ADC C,N
          when x"DA" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADC C,A
          when x"EA" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ADC C,B
          when x"FA" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- ADC C,M
            -- SBC A
          when x"4B" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- SBC A,N
          when x"5B" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SBC A,B
          when x"6B" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SBC A,C
          when x"7B" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- SBC A,M
            -- SBC B
          when x"8B" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- SBC B,N
          when x"9B" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SBC B,A
          when x"AB" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SBC B,C
          when x"BB" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- SBC B,M
            -- SBC C
          when x"CB" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- SBC C,N
          when x"DB" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SBC C,A
          when x"EB" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SBC C,B
          when x"FB" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- SBC C,M
            -- CMP A
          when x"4C" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- CMP A,N
          when x"5C" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CMP A,B
          when x"6C" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CMP A,C
          when x"7C" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- CMP A,M
            -- CMP B
          when x"8C" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- CMP B,N
          when x"9C" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CMP B,A
          when x"AC" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CMP B,C
          when x"BC" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- CMP B,M
            -- CMP C
          when x"CC" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- CMP C,N
          when x"DC" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CMP C,A
          when x"EC" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CMP C,B
          when x"FC" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- CMP C,M
            -- Instrucciones de control
            -- Instruccion inicial
          when x"00" => out_s <= "0000000000000100000000000000000000000" & usce_out; -- Inicial
            -- NOP
          when x"32" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- NOP
            -- HALT
          when x"10" => out_s <= "0000000000000000000000000000000000001" & usce_out; -- HALT
            -- CLC
          when x"20" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CLC
            --CLV
          when x"30" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CLV
            --SEC
          when x"90" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SEC
            --SEV
          when x"A0" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- SEV
            --CLR
          when x"01" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CLR A
          when x"11" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CLR B
          when x"21" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- CLR C
          when x"31" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- CLR M
            -- Instrucciones de rotacion y dezplaamiento
            -- ROD
          when x"0D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ROD A
          when x"1D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ROD B
          when x"2D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ROD C
          when x"3D" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- ROD M
            -- ROI
          when x"0E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ROI A
          when x"1E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ROI B
          when x"2E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- ROI C
          when x"3E" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- ROI M
            -- RCD
          when x"4D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- RCD A
          when x"5D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- RCD B
          when x"6D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- RCD C
          when x"7D" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- RCD M
            -- RCI
          when x"4E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- RCI A
          when x"5E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- RCI B
          when x"6E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- RCI C
          when x"7E" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- RCI M
            -- DAD
          when x"8D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DAD A
          when x"9D" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DAD B
          when x"AD" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DAD C
          when x"BD" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- DAD M
            -- DAI
          when x"8E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DAI A
          when x"9E" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DAI B
          when x"AE" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DAI C
          when x"BE" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- DAI M
            -- DLD
          when x"CD" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DLD A
          when x"DD" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DLD B
          when x"ED" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- DLD C
          when x"FD" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- DLD M
            -- Instrucciones de transferencia de datos
            -- LDA A
          when x"41" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- LDA A,N
          when x"51" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- LDA A,B
          when x"61" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- LDA A,C
          when x"71" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- LDA A,M
            -- LDA B
          when x"81" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- LDA B,N
          when x"91" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- LDA B,A
          when x"A1" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- LDA B,C
          when x"B1" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- LDA B,M
            -- LDA C
          when x"C1" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- LDA C,N
          when x"D1" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- LDA C,A
          when x"E1" => out_s <= "0000000000000100000000000000000000001" & usce_out; -- LDA C,B
          when x"F1" => out_s <= "0000000000000100000000000000000000011" & usce_out; -- LDA C,M
            -- STA A
          when x"72" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- STA A,M
            -- STA B
          when x"B2" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- STA B,M
            -- STA C
          when x"F2" => out_s <= "0100000000000100000000000000000000011" & usce_out; -- STA C,M
            -- Instrucciones de puntero de datos
            -- CMP X
          when x"3F" => out_s <= "0000000000000100000000000000000000010" & usce_out; -- CMP X,N
            -- CMP Y
          when x"7F" => out_s <= "0000010000000100000000000000000000010" & usce_out; -- CMP Y,N
            -- INC X
          when x"83" => out_s <= "0000000001001100000000000000000000001" & usce_out; -- INC X
            -- INC Yf
          when x"93" => out_s <= "0000000001010100000000000000000000001" & usce_out; -- INC Y
            -- INC P
          when x"A3" => out_s <= "0000000001100100000000000000000000001" & usce_out; -- INC P
            -- DEC X
          when x"84" => out_s <= "0000000000001100000000000000000000001" & usce_out; -- DEC X
            -- DEC Y
          when x"94" => out_s <= "0000000000010100000000000000000000001" & usce_out; -- DEC Y
            -- DEC P
          when x"A4" => out_s <= "0000000000100100000000000000000000001" & usce_out; -- DEC P
            -- LDA X
          when x"8F" => out_s <= "0000000010001100000000000000000001001" & usce_out; -- LDA X,N
          when x"BF" => out_s <= "0000000010001100000000000000000001010" & usce_out; -- LDA X,M
            -- LDA Y
          when x"CF" => out_s <= "0000000010010100000000000000000001001" & usce_out; -- LDA Y,N
          when x"FF" => out_s <= "0000000010010100000000000000000001010" & usce_out; -- LDA Y,M
            -- LDA P
          when x"C3" => out_s <= "0000000010100100000000000000000001001" & usce_out; -- LDA P,N
          when x"F3" => out_s <= "0000000010100100000000000000000001010" & usce_out; -- LDA P,M
            -- STA X
          when x"B0" => out_s <= "0000101000000100000000000000000001000" & usce_out; -- STA X,M
            -- STA Y
          when x"F0" => out_s <= "0001101000000100000000000000000001000" & usce_out; -- STA Y,M
            -- STA P
          when x"F4" => out_s <= "0010101000000100000000000000000001000" & usce_out; -- STA P,M
            -- Instrucciones de ramificacion
            -- BRC
          when x"15" => out_s <= "0000000000000100000000000000000010101" & usce_out;
            -- BNC
          when x"25" => out_s <= "0000000000000100000000000000000100101" & usce_out;
            -- BRV
          when x"16" => out_s <= "0000000000000100000000000000000100101" & usce_out;
            -- BNV
          when x"26" => out_s <= "0000000000000100000000000000000000101" & usce_out;
            -- BRP
          when x"27" => out_s <= "0000000000000100000000000000000000101" & usce_out;
            -- BRN
          when x"17" => out_s <= "0000000000000100000000000000001000101" & usce_out;
            -- BRZ
          when x"18" => out_s <= "0000000000000100000000000000010000101" & usce_out;
            -- BNZ
          when x"28" => out_s <= "0000000000000100000000000000000000101" & usce_out;
            -- BMA
          when x"19" => out_s <= "0000000000000100000000010000000000101" & usce_out;
            -- BMI
          when x"1A" => out_s <= "0000000000000100000000100100000000101" & usce_out;
            -- BME
          when x"1B" => out_s <= "0000000000000100000001000001000000101" & usce_out;
            -- BNI
          when x"1C" => out_s <= "0000000000000100000010001000000000101" & usce_out;
            -- BSU
          when x"29" => out_s <= "0000000000000100000100000000000000101" & usce_out;
            -- BSI
          when x"2A" => out_s <= "0000000000000100001000000000000000101" & usce_out;
            -- BIN
          when x"2B" => out_s <= "0000000000000100010000000000000000101" & usce_out;
            -- BII
          when x"2C" => out_s <= "0000000000000100100000000000000000101" & usce_out;
            -- BRI
          when x"35" => out_s <= "0000000000000100000000001000000000101" & usce_out;
            -- BSR
          when x"36" => out_s <= "0011100000100101000000000000000000110" & usce_out;
            -- RET
          when x"37" => out_s <= "0000000001100110000000000000000000111" & usce_out;
            -- Instrucciones de manejo de la pila
            -- Guardar en pila
            -- GPI A
          when x"42" => out_s <= "1100000000100100000000000000000001011" & "0000000010000000000011000010000";
            -- GPI B
          when x"52" => out_s <= "1100000000100100000000000000000001011" & "0000000110000000000011000010000";
            -- GPI C
          when x"62" => out_s <= "1100000000100100000000000000000001011" & "0000001010000000000011000010000";
            -- GPI X
          when x"C2" => out_s <= "1000100000100100000000000000000001100" & usce_out;
            -- GPI Y
          when x"D2" => out_s <= "1001100000100100000000000000000001100" & usce_out;
            -- GPI F
          when x"E2" => out_s <= "1100000000100100000000000000000001011" & usce_out;
            -- Recuperar de la pila
            -- RPI A
          when x"40" => out_s <= "1000000001100100000000000000000001101" & usce_out;
            -- RPI B
          when x"50" => out_s <= "1000000001100100000000000000000001101" & usce_out;
            -- RPI C
          when x"60" => out_s <= "1000000001100100000000000000000001101" & usce_out;
            -- RPI X
          when x"C0" => out_s <= "1000000011101100000000000000000001110" & usce_out;
            -- RPI Y
          when x"D0" => out_s <= "1000000011110100000000000000000001110" & usce_out;
            -- RPI F
          when x"E0" => out_s <= "1000000001100100000000000000000001101" & usce_out;

          when others => out_s <= "0000000000000100000000000000000000001" & usce_out;
         end case;
    end if;
  end process;
end arch;


