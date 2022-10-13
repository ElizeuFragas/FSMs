library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity portao is
	port(
		clk, rst, bt, p		: in  std_logic;
		s0, s1 : out std_logic;
		estado : out character
	);
end entity;

architecture comportamento of portao is
	
	type tipo_estado is (A, B, C);
	signal prox_estado, a_estado : tipo_estado;
	signal cond  : std_logic := '0';
	signal fc1, fc2  : std_logic;
	
	begin
		
		logica_proximo_estado : process(a_estado, bt, p)

		variable aux, sub : std_logic := '0';

		begin
			
			if bt = '1' and aux = '1' then
				sub := '0';
			else 
				sub := bt;
				aux := bt;
			end if;
			
			case a_estado is
				-- Estado fechado
				when A =>
				if sub = '0' then
					prox_estado <= A;
				elsif sub = '1' and p = '1' then
					prox_estado <= B;
					fc1 <= '0';
				else
					prox_estado <= C;
				end if;
				-- Estado parado
				when B => 
				if p = '1' then
					prox_estado <= B;
				elsif fc1 = '0' then
					prox_estado <= C;
					fc1 <= '1';
				else
					prox_estado <= A;
					fc2 <= '1';
				end if;
				-- Estado aberto
				when C =>
				if sub = '0' then
					prox_estado <= C;
				elsif sub = '1' and p = '1' then
					prox_estado <= B;
					fc2 <= '0';
				else
					prox_estado <= A;
				end if;
				
			end case;
					
	end process;
	
	registrador_estado : process(clk, rst)
	begin
		
		if cond = '0' then
			a_estado <= A;
			cond <= '1';
		elsif rst = '1' then
			a_estado <= A;
		elsif falling_edge(clk) then
			a_estado <= prox_estado;
		end if;
	end process;
	
	logica_saida : process(a_estado)
	begin
		
		case a_estado is
			when A => s0 <= '0'; s1 <= '0'; estado <= 'A';
			when B => s0 <= '1'; s1 <= '0'; estado <= 'B';
			when C => s0 <= '0'; s1 <= '1'; estado <= 'C';
		end case;
	end process;
	
end architecture;