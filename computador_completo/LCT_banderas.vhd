--Modulo Logica de Control y Temporizacion (LCT)
library ieee;
use ieee.std_logic_1164.all;

entity LCT_banderas is
port(N_in,Z_in,P_in,H_in,C_in,V_in : in std_logic; --Banderas de entrada
	  s : in std_logic_vector(7 downto 0); --Palabra de control
	  clock : in std_logic;	    					--Reloj
	  N_out,Z_out,P_out,H_out,C_out,V_out : out std_logic);  --Banderas de salida
end LCT_banderas;

architecture arch of LCT_banderas is	
--Componentes:
--Flip Flop D:
component ffD is
	port(in_0,clock:in std_logic;  --entrada de reloj y de datos
		q : buffer std_logic:='0');  --salida Q
end component;

signal aux : std_logic_vector(8 downto 0); --variable auxiliar para la salida de la parte combinacional
begin
---descripcion de la parte combinacional
aux(8) <= s(7) and clock;
aux(7) <= s(7) and clock;
aux(6) <= s(7) and clock;
aux(5) <= H_in and s(6);
aux(4) <= s(7) and clock;
aux(3) <= (C_in and s(0)) or s(1);
aux(2) <= s(2) and clock;
aux(1) <= (V_in and s(3)) or s(4);
aux(0) <= s(5) and clock;
-- descripcion de la parte secuencial
ffD_1: ffD PORT MAP(N_in,aux(8),N_out);
ffD_2: ffD PORT MAP(Z_in,aux(7),Z_out);
ffD_3: ffD PORT MAP(P_in,aux(6),P_out);
ffD_4: ffD PORT MAP(aux(5),aux(4),H_out);
ffD_5: ffD PORT MAP(aux(3),aux(2),C_out);
ffD_6: ffD PORT MAP(aux(1),aux(0),V_out);

end arch;