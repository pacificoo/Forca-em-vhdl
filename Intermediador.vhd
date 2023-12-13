LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Interface IS --Transforma as saídas da entidade forca
  PORT (
  		a	:in STD_LOGIC_VECTOR(3 downto 0); --Entrada
		situ	:out STD_LOGIC_VECTOR(3 DOWNTO 0); --Situação do jogo (Venceu (1100), perdeu (1110) ou ainda jogando (0000))
		s0, s1, s2, s3, s4	:OUT STD_LOGIC_VECTOR(3 downto 0);
		vidas	: out STD_LOGIC_VECTOR(2 downto 0);
		btn, reset	:in STD_LOGIC
    );
END Interface;


ARCHITECTURE TypeArchitecture OF Interface IS

component Forca is
	PORT (a	:in STD_LOGIC_VECTOR(3 downto 0);
		b0, b1, b2, b3, b4	:OUT STD_LOGIC;
		situ, vidas	: out STD_LOGIC_VECTOR(1 downto 0);
		btn, reset	:in STD_LOGIC
		);
	end component;

SIGNAL temp0, temp1, temp2, temp3, temp4: STD_LOGIC;
SIGNAL temp_situ, temp_vidas: STD_LOGIC_VECTOR(1 downto 0);

BEGIN
	Forc: Forca PORT MAP(
	btn => btn,
	reset => reset,
	a => a,
	b0 => temp0,
	b1 => temp1,
	b2 => temp2,
	b3 => temp3,
	b4 => temp4,
	situ => temp_situ,
	vidas => temp_vidas
	);

	--transforma cada saída em um número binário correspondente caso ela estiver correspondente com algum chute passado do usuário

	s0 <= "0000" when (temp0 = '1' or temp_situ = "01") else
		 "1111";

	s1 <= "0101" when (temp1 = '1' or temp_situ = "01") else
		 "1111";

	s2 <= "0110" when (temp2 = '1' or temp_situ = "01") else
		 "1111";

	s3 <= "0001" when (temp3 = '1' or temp_situ = "01") else
		 "1111";

	s4 <= "0111" when (temp4 = '1' or temp_situ = "01") else
		 "1111";

		 -- Diz a situação do jogo
	situ <= "1110" when temp_situ = "01" else
		   "1100" when temp_situ = "10" else
		   "0000";

		   -- Mostra a quantidade de vidas pelos 3 leds usados para isso
	vidas <= "111" when temp_vidas = "11" else
			"110" when temp_vidas = "10" else
			"100" when temp_vidas = "01" else
			"000" when temp_vidas = "00";


END TypeArchitecture;