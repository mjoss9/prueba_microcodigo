library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoria is
	port(
		clock: in std_logic; --Señal de reloj
		s_22: in std_logic := '1'; --s_21=1 ESCRITURA,s_21=0 LECTURA
		address: in natural range 0 to 63; --16 direcciones codificadas por 5 bits
		data_in: in std_logic_vector (7 downto 0); --Ancho de palabra de 8 bits
		data_out: out std_logic_vector (7 downto 0)); --Salida de datos
end memoria;

architecture rtl of memoria is
	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type datos is array (63 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : datos;
	
	--signal posicion:integer;
	-- Register to hold the address
	signal addr_reg : natural range 0 to 63;
begin
	--posicion<= to_integer(unsigned(address));
	process (clock)
	begin
		if(falling_edge(clock)) then
			if(s_22 = '1') then
				ram(address) <= data_in;
			end if;
			
			-- Register the address for reading
			addr_reg <= address;
		end if;
	end process;
	
	data_out <= ram(addr_reg);
	
end rtl;