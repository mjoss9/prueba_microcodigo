library ieee;
use ieee.std_logic_1164.all;

-- Declaracion de la Logica de Ramificacion (LR)
entity LR is
    port(
        C, V, N, Z : in std_logic;  -- Banderas de Condicion
        s : in std_logic_vector(18 downto 0); -- Signals of control
        h_c : out std_logic --Habilitacion de carga
    );
end LR;
architecture rtl of LR is
signal out_s : std_logic_vector(18 downto 0);
begin
    out_s(0) <= s(0) and C;
    out_s(1) <= s(1) and V;
    out_s(2) <= s(2) and N;
    out_s(3) <= s(3) and Z;
    out_s(4) <= s(4) and not C;
    out_s(5) <= s(5) and not V;
    out_s(6) <= s(6) and not N;
    out_s(7) <= s(7) and not Z;
    out_s(8) <= s(8);
    out_s(9) <= s(9) and Z and not (V xor N);
    out_s(10) <= s(10) and Z and not (V xor N);
    out_s(11) <= s(11) and not Z and (V xor N);
    out_s(12) <= s(12) and not Z and (V xor N);
    out_s(13) <= s(13) and C and not Z;
    out_s(14) <= s(15) and not C and not Z;
    out_s(15) <= s(14) and C;
    out_s(16) <= s(16) and not (C xor Z);
    out_s(17) <= s(17);
    out_s(18) <= s(18);
    --OR of all bits of out_s
    h_c <= '1' when (out_s(0) = '1' or out_s(1) = '1' or out_s(2) = '1' or out_s(3) = '1' or out_s(4) = '1' or out_s(5) = '1' or out_s(6) = '1' or out_s(7) = '1' or out_s(8) = '1' or out_s(9) = '1' or out_s(10) = '1' or out_s(11) = '1' or out_s(12) = '1' or out_s(13) = '1' or out_s(14) = '1' or out_s(15) = '1' or out_s(16) = '1' or out_s(17) = '1' or out_s(18) = '1') else '0';
    
end rtl;

