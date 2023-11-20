library ieee;
use ieee.std_logic_1164.all;

entity reg_flags is
  port (
    C_in, V_in, H_in, N_in, Z_in, P_in : in std_logic;
    s : in std_logic_vector(7 downto 0); --Palabra de control
    ctrl_C, ctrl_V, ctrl_H, ctrl_N, ctrl_Z, ctrl_P : in std_logic;
    C_out, V_out, H_out, N_out, Z_out, P_out : buffer std_logic
  );
end reg_flags;

architecture rtl of reg_flags is
signal aux : std_logic_vector(2 downto 0); --variable auxiliar para la salida de la parte combinacional
begin
---descripcion de la parte combinacional
aux(0) <= (C_in and s(0)) or s(1);
aux(1) <= (V_in and s(3)) or s(4);
aux(2) <= H_in and s(6);

  process (C_in, V_in, H_in, N_in, Z_in, P_in, ctrl_C, ctrl_V, ctrl_H, ctrl_N, ctrl_Z, ctrl_P,
           C_out, V_out, H_out, N_out, Z_out, P_out)
  begin
    if (ctrl_C'event and ctrl_C = '1') then
      C_out <= aux(0);
    end if;
    if (ctrl_V'event and ctrl_V = '1') then
      V_out <= aux(1);
    end if;
    if (ctrl_H'event and ctrl_H = '1') then
      H_out <= aux(2);
    end if;
    if (ctrl_N'event and ctrl_N = '1') then
      N_out <= N_in;
    end if;
    if (ctrl_Z'event and ctrl_Z = '1') then
      Z_out <= Z_in;
    end if;
    if (ctrl_P'event and ctrl_P = '1') then
      P_out <= P_in;
    end if;
  end process;
end rtl;