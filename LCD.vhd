library ieee;
use ieee.std_logic_1164.all;


		entity LCD is
		generic (fclk: natural := 50_000_000); -- 50MHz
		port (
				revelado0, revelado1, revelado2, revelado3, revelado4, resultado : in std_logic_vector(3 downto 0);-- NUMEROS A SEREM REVELADOS
		       clk         :     in std_logic; --CLOCK DA PLACA 50MHZ
				 RS, RW      :    out bit;
		       E           : buffer bit;  
		       DB          :    out bit_vector(7 downto 0);
				entrada : in std_logic_vector(3 downto 0)); -- numero que está atualmente nos switches
		end LCD;
					

-- DEFINIÇÃO DAS VARIAVEIS -----
		architecture hardware of LCD is
		type state is (FunctionSetl, FunctionSet2, FunctionSet3,
		 FunctionSet4,FunctionSet5,FunctionSet6,FunctionSet7,FunctionSet8,FunctionSet9,FunctionSet10,FunctionSet11,FunctionSet12,
		 FunctionSet13,FunctionSet14,FunctionSet15,FunctionSet16,FunctionSet17,FunctionSet18,FunctionSet19,ClearDisplay, DisplayControl, EntryMode, 
		 WriteDatal, WriteData2, WriteData3, WriteData4, WriteData5,WriteData6,WriteData7,WriteData8,WriteData9,WriteData10,SetAddress,SetAddress1, ReturnHome);
		signal pr_state, nx_state: state; 
		begin
		
---—GERADOR DE CLOCK (E->500Hz) :---------
		process (clk)
		variable count: natural range 0 to fclk/1000; 
		begin
			if (clk' event and clk = '1') then 
				count := count + 1;
				if (count=fclk/1000) then 
				 E <= not E; 
				 count := 0; 
				end if; 
			end if; 
		end process;
		

		process (E) 
		begin
			if (E' event and E = '1') then 
				pr_state <= FunctionSetl; 
		pr_state <= nx_state; 
		end if; 
		end process;
		

		process (pr_state) 
		begin
		case pr_state is

--INICIALIZAÇÃO E DEFINIÇÃO -------
		when FunctionSetl => 
		RS<= '0'; RW<= '0'; 
		DB<= "00111000"; 
		nx_state <= FunctionSet2; 
		when FunctionSet2 => 
		RS<= '0'; RW<= '0'; 
		DB <= "00111000";
		nx_state <= FunctionSet3; 
		when FunctionSet3 => 
		RS <= '0'; RW<='0'; 
		DB <= "00111000"; 
		nx_state <= FunctionSet4;

		when   FunctionSet4   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet5;

		when   FunctionSet5   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet6;

		when   FunctionSet6   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet7;

		when   FunctionSet7   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet8;

		when   FunctionSet8   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet9;

		when   FunctionSet9   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet10;

		when   FunctionSet10   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet11;

		when   FunctionSet11   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet12;

		when   FunctionSet12   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet13;

		when   FunctionSet13   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet14;

		when   FunctionSet14   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet15;

		when   FunctionSet15   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet16;

		when   FunctionSet16   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet17;

		when   FunctionSet17   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet18;

		when   FunctionSet18   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet19;


		when   FunctionSet19   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= ClearDisplay ;



		when ClearDisplay =>
		RS<= '0'; RW<= '0';
		DB <= "00000001";
		nx_state   <=   DisplayControl; 
		when   DisplayControl   =>
		RS<= '0';   RW<=  '0';
		DB   <=  "00001100";
		nx_state <= EntryMode; 
		when EntryMode =>
		RS<= '0'; RW<= '0';
		DB <= "00000110";
		nx_state   <=  WriteDatal; 

		when  WriteDatal =>
		RS<=   '1';   RW <='0';
		DB   <=   "00100000";   
		nx_state <= SetAddress1; 

		when SetAddress1 =>
		RS<=   '0';   RW<=   '0';
		DB   <=  "10000000";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 0 "10000000" 
		nx_state  <= WriteData2; 

		when WriteData2 =>
		RS<= '1'; RW<= '0';
			case revelado0 is -- CASO DESCOBERTO, MOSTRA O NUMERO, CASO CONTRARIO MOSTRA "X"
			                  -- FUNCIONA DA MESMA FORMA PARA TODOS OS 6 DIGITOS A SEREM DESCOBERTOS
				
				when "0000" => 
					DB <= X"30"; --0
				when "0001" => 
					DB <= X"31"; --1
				when "0010" => 
					DB <= X"32"; --2
				when "0011" => 
					DB <= X"33"; --3
				when "0100" => 
					DB <= X"34"; --4
				when "0101" => 
					DB <= X"35"; --5
				when "0110" => 
					DB <= X"36"; --6
				when "0111" => 
					DB <= X"37"; --7
				when "1000" => 
					DB <= X"38"; --8
				when "1001" => 
					DB <= X"39"; --9
				when others => 
					DB <= X"58"; --null=X
				end case;
				
		nx_state <= WriteData3;
		
		when WriteData3 =>
		RS<= '1'; RW<= '0';
		case revelado1 is 
			
				
				when "0000" => 
					DB <= X"30"; --0
				when "0001" => 
					DB <= X"31"; --1
				when "0010" => 
					DB <= X"32"; --2
				when "0011" => 
					DB <= X"33"; --3
				when "0100" => 
					DB <= X"34"; --4
				when "0101" => 
					DB <= X"35"; --5
				when "0110" => 
					DB <= X"36"; --6
				when "0111" => 
					DB <= X"37"; --7
				when "1000" => 
					DB <= X"38"; --8
				when "1001" => 
					DB <= X"39"; --9
				when others => 
					DB <= X"58"; --null=X
				end case;   
				
		nx_state  <= WriteData4; 
		
		when  WriteData4   =>
		RS<=   '1';   RW<=   '0';
		case revelado2 is 
			
				
				when "0000" => 
					DB <= X"30"; --0
				when "0001" => 
					DB <= X"31"; --1
				when "0010" => 
					DB <= X"32"; --2
				when "0011" => 
					DB <= X"33"; --3
				when "0100" => 
					DB <= X"34"; --4
				when "0101" => 
					DB <= X"35"; --5
				when "0110" => 
					DB <= X"36"; --6
				when "0111" => 
					DB <= X"37"; --7
				when "1000" => 
					DB <= X"38"; --8
				when "1001" => 
					DB <= X"39"; --9
				when others => 
					DB <= X"58"; --null=X
				end case;                
		nx_state  <= WriteData5;	

		when  WriteData5   =>
		RS<=   '1';   RW<=   '0';
		case revelado3 is 
			
				
				when "0000" => 
					DB <= X"30"; --0
				when "0001" => 
					DB <= X"31"; --1
				when "0010" => 
					DB <= X"32"; --2
				when "0011" => 
					DB <= X"33"; --3
				when "0100" => 
					DB <= X"34"; --4
				when "0101" => 
					DB <= X"35"; --5
				when "0110" => 
					DB <= X"36"; --6
				when "0111" => 
					DB <= X"37"; --7
				when "1000" => 
					DB <= X"38"; --8
				when "1001" => 
					DB <= X"39"; --9
				when others => 
					DB <= X"58"; --null=X
				end case;                
		nx_state  <= WriteData6;

		when  WriteData6   =>
		RS<=   '1';   RW<=   '0';
		case revelado4 is 
			
				
				when "0000" => 
					DB <= X"30"; --0
				when "0001" => 
					DB <= X"31"; --1
				when "0010" => 
					DB <= X"32"; --2
				when "0011" => 
					DB <= X"33"; --3
				when "0100" => 
					DB <= X"34"; --4
				when "0101" => 
					DB <= X"35"; --5
				when "0110" => 
					DB <= X"36"; --6
				when "0111" => 
					DB <= X"37"; --7
				when "1000" => 
					DB <= X"38"; --8
				when "1001" => 
					DB <= X"39"; --9
				when others => 
					DB <= X"58"; --null=X
				end case;                           
		nx_state  <= WriteData8;
		
		when  WriteData8   =>
		RS<=   '1';   RW<=   '0';
		case resultado is          -- QUANDO O RESULTADO AINDA NAO FOI DEFINIDO SEU LUGAR FICA UM @, APOS DEFINIDO, P OU G 
			
				
				when "1100" => 
					DB <= X"47"; --ganhou G
				when "1110" => 
					DB <= X"50"; --perdeu P
				when others => 
					DB <= X"40"; --@
				end case;                 
		nx_state  <= WriteData9;
		
		when  WriteData9   =>
		RS<=   '1';   RW<=   '0'; ---- MOSTRA O PALPITE DA PESSOA (numero atual dos switches)
		case entrada is 
			   when "0000" => 
					DB <= X"30"; --0
				when "0001" => 
					DB <= X"31"; --1
				when "0010" => 
					DB <= X"32"; --2
				when "0011" => 
					DB <= X"33"; --3
				when "0100" => 
					DB <= X"34"; --4
				when "0101" => 
					DB <= X"35"; --5
				when "0110" => 
					DB <= X"36"; --6
				when "0111" => 
					DB <= X"37"; --7
				when "1000" => 
					DB <= X"38"; --8
				when "1001" => 
					DB <= X"39"; --9
				when others => 
					DB <= X"58"; --null=X
				end case;                 
		nx_state  <= SetAddress;

		

		when SetAddress =>

		RS<=   '0';   RW<=   '0';
		DB   <=  "11001111";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 1 COLUNA 16  "11001111" 
		nx_state  <= ReturnHome; 

				


		when   ReturnHome   =>   --- VOLTA PARA  O ESTADO INICIAL 
		RS<=   '0';   RW<=  '0';
		DB   <=  "10000000";
		nx_state <= WriteDatal; 
		
		when others =>
		nx_state <= WriteDatal;
		end case; 
		end process;
		
	end hardware;