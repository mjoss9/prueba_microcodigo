LIBRARY ieee;
USE ieee.std_logic_1164.all;

--Sumador completo
ENTITY Full_adder IS
 PORT(A,B,Ce: IN STD_LOGIC;
      R,C : OUT STD_LOGIC);
END Full_adder;

ARCHITECTURE Sum_Comp OF Full_adder IS

 begin
  R <= (A XOR B) XOR Ce;
  C <= (A AND B) OR (B AND Ce) OR (A AND Ce);
end Sum_Comp;