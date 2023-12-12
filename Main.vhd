library ieee;
use ieee.std_logic_1164.all;

entity Main is
port(
    
    	CLOCK_50, btn, reset    : in std_logic; ---clock do contador
    	a    : in std_logic_vector (3 downto 0); ----- switches da placa   
    	vidas         : out std_logic_vector (2 downto 0) := (others => '0'); ------ leds 
	RS, RW      : out bit; -- lcd
    	E           : buffer bit;  --lcd
	DB          : out bit_vector(7 downto 0) --lcd 
    
    );
end Main;


architecture hardware of Main is
signal vida : std_logic_vector(2 downto 0);
signal temp0, temp1, temp2, temp3, temp4, temp_situ, resultado: std_logic_vector(3 downto 0);
signal counter: std_logic_vector(7 downto 0);

COMPONENT Interface is 
    port(
    		a	:in STD_LOGIC_VECTOR(3 downto 0);
		situ	:out STD_LOGIC_VECTOR(3 DOWNTO 0);
		s0, s1, s2, s3, s4	:OUT STD_LOGIC_VECTOR(3 downto 0);
		vidas	: out STD_LOGIC_VECTOR(2 downto 0);
		btn, reset	:in STD_LOGIC
    );
END COMPONENT Interface;

COMPONENT LCD is 
   port (
				revelado0, revelado1, revelado2, revelado3, revelado4, resultado : in std_logic_vector(3 downto 0);
		       clk         :     in std_logic; 
				 RS, RW      :    out bit;
		       E           : buffer bit;  
		       DB          :    out bit_vector(7 downto 0);
				 entrada : in std_logic_vector(3 downto 0));
END COMPONENT LCD;



-- codigo somente para juntar os componentes e designar a saida para o LED


    begin
	inter: Interface port map(
		btn => btn,
		reset => reset,
		a => a,
		s0 => temp0,
		s1 => temp1,
		s2 => temp2,
		s3 => temp3,
		s4 => temp4,
		situ => temp_situ,
		vidas => vida
	);
	 LCD1: LCD port map(temp0, temp1, temp2, temp3, temp4, resultado, CLOCK_50, RS, RW, E, DB, a);

	 vidas<=vida; -- atribuindo a saida a variavel que sai de forca.vhd

end hardware;