library ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp_mem_shared is
    port (
        clk : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        data_out : buffer std_logic_vector(7 downto 0);
        flags : buffer std_logic_vector(5 downto 0);
        RI : out std_LOGIC_VECTOR(7 downto 0);
        PI : out integer range -128 to 127;
        Micro_secuencia : out std_logic_vector(2 downto 0);
        signal_control : out std_LOGIC_VECTOR(10 downto 0);
        cod_ope : out std_LOGIC_VECTOR(7 downto 0);
        data_buss : out std_logic_vector(7 downto 0);
        addr_mem_micro : out std_logic_vector(6 downto 0)
    );
end comp_mem_shared;

architecture rtl of comp_mem_shared is
-- Listamos los componentes que vamos a usar
-- ALU
component ALU is
    port( in_0,in_1	:	in std_logic_vector(7 downto 0);  --Entradas a la ALU
        c_in	: in std_logic;
        s		:	in std_logic_vector(11 downto 0); --Entradas de seleccion
        alu_out		:	out std_logic_vector(7 downto 0); --Salida de la ALU
        C,V,H,N,Z,P		:	out std_logic); 			 --Banderas	
end component ALU;
-- Mux 2 a 1
component mux2a1_rd is
    port(	in_0			:	IN integer range 0 to 255;--Entradas del multiplexor
    in_1			:	IN STD_LOGIC_VECTOR (7 DOWNTO 0);--Entradas del multiplexor
    s				:	in std_logic;
    y				:	OUT STD_LOGIC_VECTOR (7 DOWNTO 0));--Salida del multiplexor
end component mux2a1_rd;
-- Acumulador
component acumulador is
    port (
        in_0 : in std_logic_vector (7 downto 0); --Entrada
        clock : in std_logic;         --Entrada clock
		  control : in std_logic := '0';
		  Q : out std_logic_vector (7 downto 0));--Salida
end component acumulador;
-- Registro de banderas
component reg_flags is
    port (
        C_in, V_in, H_in, N_in, Z_in, P_in : in std_logic;
        s : in std_logic_vector(7 downto 0); --Palabra de control
        ctrl_C, ctrl_V, ctrl_H, ctrl_N, ctrl_Z, ctrl_P : in std_logic;
        C_out, V_out, H_out, N_out, Z_out, P_out : buffer std_logic
    );
end component reg_flags;
-- Memoria compartida
component memoria is
    port(
		control: in std_logic; --signal de control
		clock: in std_logic; --signal de reloj
		s_22: in std_logic := '1'; --s_21=1 ESCRITURA,s_21=0 LECTURA
		address: in natural range 0 to 63; --16 direcciones codificadas por 5 bits
		data_in: in std_logic_vector (7 downto 0); --Ancho de palabra de 8 bits
		data_out: out std_logic_vector (7 downto 0)); --Salida de datos
end component memoria;

-- Puntero de instrucciones
component puntero is
    port(dat: in integer range 0 to 255;	--Dato
		I_D,load,enable,clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		pointer: out integer range -128 to 127);  --Puntero
end component puntero;

-- Decodificador de instrucciones
component descod is
    port(
        data_in : in std_logic_vector(3 downto 0);
        data_out : out std_logic_vector(21 downto 0));
end component descod;

-- LCT para banderas
component LCT_banderas is
    port(N_in,Z_in,P_in,H_in,C_in,V_in : in std_logic; --Banderas de entrada
        s : in std_logic_vector(7 downto 0); --Palabra de control
        clock : in std_logic;	    					--Reloj
        N_out,Z_out,P_out,H_out,C_out,V_out : out std_logic);  --Banderas de salida
end component LCT_banderas;

-- Memoria de microcodigo
component mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(6 downto 0);
        data : out std_logic_vector(10 downto 0)
    );
end component mem_micro_cod;

-- Generador de microsecuencia
component generador_microsec is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        q: out std_logic_vector(2 downto 0)
    );
end component generador_microsec;

------------------ Signal internas
------------------------------------------------
signal data_bus : std_logic_vector(7 downto 0);
signal in_alu_b : std_logic_vector(7 downto 0);
signal out_alu : std_logic_vector(7 downto 0);
signal out_flags_alu : std_logic_vector(5 downto 0);
signal cod_op : std_logic_vector(7 downto 0) := "00001000";
signal cod_argu : std_logic_vector(7 downto 0);
signal pointer : integer range -128 to 127;
signal in_reg_direc : std_logic_vector(7 downto 0);
signal out_reg_direc : std_logic_vector(7 downto 0);

signal descod_signals : std_logic_vector(21 downto 0);

signal microsec : std_logic_vector(2 downto 0);
signal control_signals : std_logic_vector(10 downto 0);

begin

----------------- Conexiones para la Unidad de ejecucion ---------------------
-------------------------------------------------------------------------------

-------------- Conexiones para la unidad de direccionamiento -----------------------
-------------------------------------------------------------------------------
-- Conexiones para el registro de instrucciones
    REG_INSTRUCCIONES_0 : acumulador port map(
        in_0 => data_bus,
        clock => clk,
		  control => control_signals(8),
        Q => cod_op
    );
	 
-- Conexiones del puntero de instrucciones
    PUNTERO_INSTRUCCIONES_0 : puntero port map(
        dat => to_integer(unsigned(data_bus(7 downto 0))),
        I_D => control_signals(6),
        load => '0', ---CONTROL
        enable => control_signals(5), ---CONTROL
        clock => clk,
        pointer => pointer
    );

-- Mux para el registro de direcciones
    MUX_1 : mux2a1_rd port map(
        in_0 => pointer,
        in_1 => cod_argu,
        s => '0',
        y => in_reg_direc
    );
    
-- -- Registro de direcciones
    REG_DIRECCIONES_0 : acumulador port map(
        in_0 => in_reg_direc,
        clock => clk,
		  control => control_signals(6),
        Q => out_reg_direc
    );
-- -- Conexiones para la memoria
    MEMORIA_0 : memoria port map(
		  control => control_signals(7),
        clock => clk,
        s_22 => '0', ---DESCODIFICADOR
        address => to_integer(unsigned(out_reg_direc)),
        data_in => "00000000",
        data_out => data_bus
    );

--------------------- Conexiones para la logica de control --------------------
-------------------------------------------------------------------------------

-- Memoria para almacenar el microcodigo
    MEM_MICRO_COD_0 : mem_micro_cod port map(
        clk => clk,
        addr => cod_op(3 downto 0)&microsec,
        data => control_signals
    );

-- Generador de la microsecuencia
    GEN_MICROSEC_0 : generador_microsec port map(
        clk => clk,
        reset => control_signals(9),
        enable => control_signals(10),
        q => microsec
    );
RI <= cod_op;
PI <= pointer;
Micro_secuencia <= microsec;
signal_control <= control_signals;
cod_ope <= cod_op;
data_buss <= data_bus;
addr_mem_micro <= cod_op(3 downto 0)&microsec;

end rtl;

