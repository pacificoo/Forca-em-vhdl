LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Forca IS -- Entidade para realizar a máquina de estado da forca
  PORT (
		a	:in STD_LOGIC_VECTOR(3 downto 0); --Entrada.
		b0, b1, b2, b3, b4	:OUT STD_LOGIC; --Saída. Se um algarismo da palavra da forca foi acertado, a saída correspondente mostra 1. Caso contrário, mostra 0.
		situ, vidas	: out STD_LOGIC_VECTOR(1 downto 0); -- Situalção do jogo e vidas restantes.
		btn, reset	:in STD_LOGIC -- Botão para chute e botão para reset.
    );
END Forca;


ARCHITECTURE TypeArchitecture OF Forca IS

signal	temp0, temp1, temp2, temp3, temp4	:STD_LOGIC := '0';
signal	temp_situ	: STD_LOGIC_VECTOR(1 downto 0):= "00";
signal	temp_vidas: STD_LOGIC_VECTOR(1 downto 0) := "11";

BEGIN

	processo : process (btn, reset)
		begin
			if (reset = '1') then -- Reseta a situação do jogo
				temp0 <= '0';
				temp1 <= '0';
				temp2 <= '0';
				temp3 <= '0';
				temp4 <= '0';
				temp_situ <= "00";
				temp_vidas <= "11";

			elsif rising_edge(btn) then -- A cada sinal de subida do botão, faz o chute correspondente à entrada a.
				if (a = "0000" or temp_vidas = "00") then
					temp0 <= '1';
				elsif (a = "0001" or temp_vidas = "00") then
					temp3 <= '1';
				elsif (a = "0101" or temp_vidas = "00") then
					temp1 <= '1';
				elsif (a = "0110" or temp_vidas = "00") then
					temp2 <= '1';
				elsif (a = "0111" or temp_vidas = "00") then
					temp4 <= '1';
				else -- Se o chute foi errado, uma vida é perdida
					if (temp_vidas = "11") then
						temp_vidas <= 	"10";
					elsif (temp_vidas = "10") then
						temp_vidas <= 	"01";
					else
						temp_vidas <= 	"00";
						temp_situ <= "01";
					end if;
				end if;
			end if;
			
			if (temp0 = '1' and temp1 = '1' and temp2 = '1' and temp3 = '1' and temp4 = '1') then -- Se todos os algarismos estão descobertos, a situação é jogo vecido
				temp_situ <= "10";
			end if;

	
		end process;

		-- Atribuição das saídas
	b0 <= temp0;
	b1 <= temp1;
	b2 <= temp2;
	b3 <= temp3;
	b4 <= temp4;

	vidas <= temp_vidas;
	situ <= temp_situ;
	

	

END TypeArchitecture;
