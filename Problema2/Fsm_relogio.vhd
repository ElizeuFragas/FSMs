library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Fsm_relogio is
	port(
		clk, rst, bt		: in  std_logic;
		s0, s1 : out std_logic
	);
end entity;

architecture comportamento of Fsm_relogio is
	
	type tipo_estado is (A, B, C, D);
	signal prox_estado, estado : tipo_estado := A;
	signal aux, sub : std_logic;
		
	begin

		logica_proximo_estado : process(estado, bt)
		begin
			if bt = '1' and aux = '1' then
				sub <= '0';
			else 
				aux <= bt;
				sub <= bt;
			end if;
		case estado is
			when A =>
				if bt = '0' then
					prox_estado <= A;
				else
					prox_estado <= B;
				end if;
			when B => 
				if bt = '0' then
					prox_estado <= B;
				else
					prox_estado <= C;
				end if;
			when C =>
				if bt = '0' then
					prox_estado <= C;
				else
					prox_estado <= D;
				end if;
			when D =>
				if bt = '0' then
					prox_estado <= D;
				else
					prox_estado <= A;
				end if;		
		end case;
					
	end process;
	
	registrador_estado : process(clk, rst)
	begin
		if rst = '1' then
			estado <= A;
		elsif rising_edge(clk) then
			estado <= prox_estado;
		end if;
	end process;
	
	logica_saida : process(estado)
	begin
		case estado is
			when A => s0 <= '0'; s1 <= '0';
			when B => s0 <= '1'; s1 <= '0';
			when C => s0 <= '0'; s1 <= '1';
			when D => s0 <= '1'; s1 <= '1';
		end case;
	end process;
	
end architecture;