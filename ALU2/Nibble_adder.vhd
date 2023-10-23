LIBRARY ieee;
USE ieee.std_logic_1164.all;
--Sumador de 4 bits
ENTITY Nibble_adder IS
 PORT(J,K: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      C0 : IN STD_LOGIC; 
      L  : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		C4 : OUT STD_LOGIC);
END Nibble_adder;

ARCHITECTURE Sum_4Bits OF Nibble_adder IS

 component Full_adder IS
  PORT(A,B,Ce: IN STD_LOGIC;
       R,C   : OUT STD_LOGIC);
 END component;
 signal C: STD_LOGIC_VECTOR (1 TO 3);

 begin
  S_0 : Full_adder PORT MAP (J(0),K(0),C0,L(0),C(1));
  S_1 : Full_adder PORT MAP (J(1),K(1),C(1),L(1),C(2));
  S_2 : Full_adder PORT MAP (J(2),K(2),C(2),L(2),C(3));
  S_3 : Full_adder PORT MAP (J(3),K(3),C(3),L(3),C4);
end Sum_4Bits;