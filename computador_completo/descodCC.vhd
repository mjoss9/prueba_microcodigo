library ieee;
use ieee.std_logic_1164.all;

entity descodCC is
  port(
      in_s: in std_logic_vector(7 downto 0);
      ctrl_index: in std_logic;
      out_s: out std_logic_vector(66 downto 0)
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
           when x"43" => out_s <= usce_out & "001100000000000000000001000000000000"; --IX
           when x"C3" => out_s <= usce_out & "001100000000000000000001000000000000"; --IY
           when others => out_s <= usce_out & "000000000000000000000001000000000000";
         end case;
    else
      in_descodUSCE <= in_s;
         case in_s is
           -- Instrucciones Logicas - Aritmeticas
            -- NEG
           when x"03" => out_s <= usce_out & "001100000000000000000001000000000000";
           when x"13" => out_s <= usce_out & "001100000000000000000001000000000000";
           when x"23" => out_s <= usce_out & "001100000000000000000001000000000000";
           when x"33" => out_s <= usce_out & "001100000000000000000001000000000000";
            -- Instrucciones de transferencia de datos
            -- LDA A,MEM
           when x"71" => out_s <= "000000000000100000000000000000000011" & usce_out;
            --NOT
           when others => out_s <= "000000000000100000000001000000000000" & usce_out;
         end case;
    end if;
  end process;
end arch;


