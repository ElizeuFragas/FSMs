library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity portao is
	port(
		clk, rst, bt, p, fc1, fc2		: in  std_logic;
		s0, s1 : out std_logic;
		estado : out character
	);
end entity;

architecture comportamento of portao is
	
	type tipo_estado is (A, B, C, D, E);
	signal prox_estado, a_estado : tipo_estado;
	signal cond1, cond2, cond3  : std_logic := '0';
	
	
	begin
		
		logica_proximo_estado : process(a_estado, bt, p, fc1, fc2)

		variable aux, sub : std_logic := '0';

		begin
			
			if bt = '1' and aux = '1' then
				sub := '0';
			else 
				sub := bt;
				aux := bt;
			end if;
			
			case a_estado is
				-- A: Estado fechado
				when A =>
				if sub = '0' then
					prox_estado <= A;
				else 
					prox_estado <= B;
					
				end if;
				-- B: Estado abrindo
				when B => 
				if p = '1' then
					prox_estado <= C;
					cond1 <= '1';
				elsif sub = '1' then
					prox_estado <= D;
				elsif fc1 = '0' then
					prox_estado <= B;
				else
					prox_estado <= E;
				end if;
				-- C: Estado parado
				when C =>
				if p = '1' then
					prox_estado <= C;
				elsif cond1 = '1' then
					prox_estado <= B;
					cond1 <= '0';
				else
					prox_estado <= D;
					cond2 <= '0';
				end if;
				-- D: Estado fechando
				when D =>
				if p = '1' then
					prox_estado <= C;
					cond2 <= '1';
				elsif sub = '1' then
					prox_estado <= B;
				elsif fc2 = '0' then
					prox_estado <= D;
				else
					prox_estado <= A;
				end if;
				-- E: Estado aberto
				when E =>
				if sub = '0' then
					prox_estado <= E;
				else
					prox_estado <= D;
				end if;

				
			end case;
					
	end process;
	
	registrador_estado : process(clk, rst)
	begin
		
		if cond3 = '0' then
			a_estado <= A;
			cond3 <= '1';
		elsif rst = '1' then
			a_estado <= A;
		elsif rising_edge(clk) then
			a_estado <= prox_estado;
		end if;
	end process;
	
	logica_saida : process(a_estado)
	begin
		
		case a_estado is
			when A => s0 <= '0'; s1 <= '0'; estado <= 'A';
			when B => s0 <= '1'; s1 <= '0'; estado <= 'B';
			when C => s0 <= '0'; s1 <= '0'; estado <= 'C';
			when D => s0 <= '0'; s1 <= '1'; estado <= 'D';
			when E => s0 <= '0'; s1 <= '0'; estado <= 'E';
		end case;
	end process;
	
end architecture;