library ieee;
use ieee.std_logic_1164.all;

entity ALU_mux is
  port(
    in_a_0, in_a_1, in_a_2 : in std_logic_vector(7 downto 0);
    in_b_0, in_b_1, in_b_2, in_b_3, in_b_4 : in std_logic_vector(7 downto 0);
    sel_a : in std_logic_vector(1 downto 0);
    sel_b : in std_logic_vector(2 downto 0);
    sel_alu : in std_logic_vector(11 downto 0);
    c_in : in std_logic;
    alu_out : out std_logic_vector(7 downto 0);
    alu_C, alu_V, alu_H, alu_N, alu_Z, alu_P :	out std_logic
  );
end ALU_mux;

architecture rtl of ALU_mux is
--Componentes de la ALU con muxs
  --Componente de la ALU
  component ALU is
    port( in_0,in_1	:	in std_logic_vector(7 downto 0);  --Entradas a la ALU
        c_in	: in std_logic;
        s		:	in std_logic_vector(11 downto 0); --Entradas de seleccion
        alu_out		:	out std_logic_vector(7 downto 0); --Salida de la ALU
        C,V,H,N,Z,P		:	out std_logic); 			 --Banderas
    end component;
  --Componente de Multiplexor de 8 entradas
  component mux8a1 is
    port(	in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7	:	in std_logic_vector(7 downto 0);
        s	:	in std_logic_vector(2 downto 0);
        y	:	out std_logic_vector(7 downto 0));
  end component;
  --Componente de Multiplexor de 4 entradas
  component mux4a1 is
      port(	in0,in1,in2,in3	:	in std_logic_vector(7 downto 0);
          s	:	in std_logic_vector(1 downto 0);
          y	:	out std_logic_vector(7 downto 0));
  end component;

--Declarando auxiliar signals
  signal in_alu_0, in_alu_1 : std_logic_vector(7 downto 0);
  signal var_aux : std_logic_vector(7 downto 0);
begin
--Instanciando componentes
  var_aux <= "00000000";
  --Multiplexor de 4 a 1 / Entrada A de la ALU
  mux4a1_0 : mux4a1 port map (in_a_0, in_a_1, in_a_2, var_aux, sel_a, in_alu_0);
  --Multiplexor de 8 a 1 / Entrada B de la ALU
  mux8a1_0 : mux8a1 port map (in_b_0, in_b_1, in_b_2, in_b_3, in_b_4, var_aux, var_aux, var_aux, sel_b, in_alu_1);
  --ALU
  alu_0 : ALU port map (in_alu_0, in_alu_1, c_in, sel_alu, alu_out, alu_C, alu_V, alu_H, alu_N, alu_Z, alu_P);
end rtl;