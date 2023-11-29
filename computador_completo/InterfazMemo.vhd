--Interfaz de memoria
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InterfazMemo is
port( IX,IY,PP, PI: in integer range 0 to 65535;
		resALU: in std_logic_vector(7 downto 0);
		s22: in std_logic;
		s: in std_logic_vector(3 downto 0);
		ctrl_s: in std_logic_vector(3 downto 0);
		ALU_MEM: out std_logic_vector(7 downto 0)
		-- DatoMEM: inout std_logic_vector(7 downto 0)
);
end InterfazMemo;
architecture arch of InterfazMemo is
signal outMUX: std_logic_vector(7 downto 0);
signal IX_vect,IY_vect,PP_vect,PI_vect: std_logic_vector(15 downto 0);
signal select_signal: std_logic_vector(3 downto 0);
begin
	IX_vect <= std_logic_vector(to_unsigned(IX,16));
	IY_vect <= std_logic_vector(to_unsigned(IY,16));
	PP_vect <= std_logic_vector(to_unsigned(PP,16));
	PI_vect <= std_logic_vector(to_unsigned(PI,16));
	select_signal <= s and ctrl_s;

	with select_signal select
	outMUX <= 	IX_vect(15 downto 8) when "0000",
				IX_vect(7 downto 0) when "0001",
				IY_vect(15 downto 8) when "0010",
				IY_vect(7 downto 0) when "0011",
				PP_vect(15 downto 8) when "0100",
				PP_vect(7 downto 0) when "0101",
				PI_vect(15 downto 8) when "0110",
				PI_vect(7 downto 0) when "0111",
				resALU when "1000",
				"00000000" when others;
	-- process(s22)
	-- begin
	-- if(s22 = '1') then
	-- 	DatoMEM <= outMUX;
	-- else
	-- 	ALU_MEM <= DatoMEM;
	-- end if;
	-- end process;
	ALU_MEM <= outMUX;
end arch;