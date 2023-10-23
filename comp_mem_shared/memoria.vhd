library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoria is
	port(
		control: in std_logic;
		clock: in std_logic; --Señal de reloj
		s_22: in std_logic := '1'; --s_21=1 ESCRITURA,s_21=0 LECTURA
		address: in integer range 0 to 63; --16 direcciones codificadas por 5 bits
		data_in: in std_logic_vector (7 downto 0); --Ancho de palabra de 8 bits
		data_out: out std_logic_vector (7 downto 0)); --Salida de datos
end memoria;

architecture rtl of memoria is
	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type datos is array (63 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : datos := (
        0 => "00001000",
        1 => "00000100",
        2 => "00000000",
        3 => "00000000",
        4 => "00001001",
        5 => "00000000",
        6 => "00000000",

		10 => "00001010", -- inc mem
		11 => "00000100", -- arg
		12 => "00000100", -- not acc
		13 => "00001101", -- sta mem
		14 => "00000101", -- arg

		-- 15 => "00000100", -- not acc
		-- 16 => "00001100", -- lda acc
		-- 17 => "00000101", -- arg
        -- Finalizando a memoria com zeros
        others => "00000000"
    );
	
	--signal posicion:integer;
	-- Register to hold the address
	signal addr_reg : integer range 0 to 63;
begin
	--posicion<= to_integer(unsigned(address));
	process (clock)
	begin
		if(falling_edge(clock)) then
			if(s_22 = '1') then
				if(control = '1') then
					ram(address) <= data_in;
				end if;
			end if;
		end if;
	end process;
	
	data_out <= ram(address);
	
end rtl;