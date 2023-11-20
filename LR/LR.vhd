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
    out_s(0) <= '1' when (s(0) = '1' and C = '1') else '0';
    out_s(1) <= '1' when (s(1) = '1' and V = '1') else '0';
    out_s(2) <= '1' when (s(2) = '1' and N = '1') else '0';
    out_s(3) <= '1' when (s(3) = '1' and Z = '1') else '0';
    out_s(4) <= '1' when (s(4) = '1' and C = '0') else '0';
    out_s(5) <= '1' when (s(5) = '1' and V = '0') else '0';
    out_s(6) <= '1' when (s(6) = '1' and N = '0') else '0';
    out_s(7) <= '1' when (s(7) = '1' and Z = '0') else '0';
    out_s(8) <= '1' when (s(8) = '1') else '0';
    out_s(9) <= '1' when (s(9) = '1' and Z = '0' and (V xor N = '0')) else '0';
    out_s(10) <= '1' when (s(10) = '1' and Z = '1' and (V xor N = '0')) else '0';
    out_s(11) <= '1' when (s(11) = '1' and Z = '0' and (V xor N = '1')) else '0';
    out_s(12) <= '1' when (s(12) = '1' and Z = '1' and (V xor N = '1')) else '0';
    out_s(13) <= '1' when (s(13) = '1' and C = '1' and Z = '0') else '0';
    out_s(14) <= '1' when (s(15) = '1' and C = '0' and Z = '0') else '0';
    out_s(15) <= '1' when (s(14) = '1' and C = '1') else '0';
    out_s(16) <= '1' when (s(16) = '1' and (C xor Z = '0')) else '0';
    out_s(17) <= '1' when (s(17) = '1') else '0';
    out_s(18) <= '1' when (s(18) = '1') else '0';
    --OR of all bits of out_s
    h_c <= '1' when (out_s(0) = '1' or out_s(1) = '1' or out_s(2) = '1' or out_s(3) = '1' or out_s(4) = '1' or out_s(5) = '1' or out_s(6) = '1' or out_s(7) = '1' or out_s(8) = '1' or out_s(9) = '1' or out_s(10) = '1' or out_s(11) = '1' or out_s(12) = '1' or out_s(13) = '1' or out_s(14) = '1' or out_s(15) = '1' or out_s(16) = '1' or out_s(17) = '1' or out_s(18) = '1') else '0';
    
end rtl;

