LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity divisor_frecuencia is
port (clk_50M : in std_logic;
	  clk_1Hz : out std_logic
     );
end divisor_frecuencia;

architecture Behavioral of divisor_frecuencia is

signal count : integer range 0 to 50000000 :=0;
signal b : std_logic :='0';
begin

 --clk_1Hz generation.For 100 MHz clock this generates 1 Hz clock.
process(clk_50M) 
begin
	if(rising_edge(clk_50M)) then
	count <=count+1;
		if(count = 50000000 -1) then
			b <= not b;
			count <=0;
		end if;
	end if;
	clk_1Hz<=b;
end process;
end;