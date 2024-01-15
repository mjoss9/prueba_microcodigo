--Modulo Logica de Control y Temporizacion (LCT)
library ieee;
use ieee.std_logic_1164.all;

entity LCT_banderas is
port(N_in,Z_in,P_in,H_in,C_in,V_in : in std_logic; --Banderas de entrada
	C_cp, N_cp, Z_cp, V_cp : in std_logic; --Banderas de Comparacion de punteros
	s_12, s_13, s_15, s_16, s_18, s_20 : in std_logic; --Señales de descodificacion
	N_out,Z_out,P_out,H_out,C_out,V_out : out std_logic);  --Banderas de salida
end LCT_banderas;

architecture arch of LCT_banderas is
signal aux : std_logic_vector(2 downto 0); --variable auxiliar para la salida de la parte combinacional
begin
---descripcion de la parte combinacional
aux(0) <= (C_in and s_12) or s_13;
aux(1) <= (V_in and s_15) or s_16;
aux(2) <= H_in and s_18;
-- descripcion de los Mux con las banderas de comparacion de punteros con la señal de descodificacion 20
C_out <= (C_cp and s_20) or (aux(0) and not s_20);
N_out <= (N_cp and s_20) or (N_in and not s_20);
Z_out <= (Z_cp and s_20) or (Z_in and not s_20);
V_out <= (V_cp and s_20) or (aux(1) and not s_20);

P_out <= P_in;
H_out <= aux(2);

end arch;