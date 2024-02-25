library ieee;
use ieee.std_logic_1164.all;

entity reg_flags is
  port (
    C_in, V_in, H_in, N_in, Z_in, P_in : in std_logic; -- Banderas provenientes del LCT de banderas
    flags_pila : in std_logic_vector(5 downto 0); -- Banderas provenientes de la pila
    s_14, s_17, s_19, s_21 : in std_logic; -- Signals del descodificador de instrucciones
    s_ctrl: in std_logic; -- Signals de control del microcodigo
    clock : in std_logic; -- Reloj
    flags_out : out std_logic_vector(5 downto 0) -- Salida de las banderas
  );
end reg_flags;

architecture rtl of reg_flags is
  begin
    -- Proceso de registro de banderas
    process (clock)
    begin
      if falling_edge(clock) then
        if s_ctrl = '1' then
          if s_14 = '1' then
            flags_out(0) <= C_in;
          end if;
          if s_17 = '1' then
            flags_out(1) <= V_in;
          end if;
          if s_19 = '1' then
            flags_out(2) <= H_in;
            flags_out(3) <= N_in;
            flags_out(4) <= Z_in;
            flags_out(5) <= P_in;
          end if;
          if s_21 = '1' then
            flags_out <= flags_pila;
          end if;
        end if;
      end if;
    end process;
end rtl;