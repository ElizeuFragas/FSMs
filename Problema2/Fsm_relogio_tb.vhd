library ieee;
use ieee.std_logic_1164.all;

entity Fsm_relogio_tb is
end Fsm_relogio_tb;

architecture testbench of Fsm_relogio_tb is
	component Fsm_relogio
	port(
		clk, rst, bt	: in  std_logic;
		s0, s1 : out std_logic
	);
	end component;
	
	signal clk, bt, s0, s1 : std_logic := '0';
	signal rst : std_logic := '1';
	
	constant bt_array : std_logic_vector(0 to 28) := "00010000111001100000111100010";
begin
	
	instancia: Fsm_relogio
	port map(
		clk => clk,
		rst => rst,
		bt => bt,
		s0 => s0,
		s1 => s1
	);
	
	gerador_entrada : process(clk, rst)
		variable i : integer := 0;
	begin
		if rst = '1' then
			i := 0;
			bt <= bt_array(i);
		elsif rising_edge(clk) then
			bt <= bt_array(i);
			i := i + 1;
			
			if i = bt_array'length then
				i := 0;
			end if;
		end if;
	end process;
	
	clk <= not clk after 5 ns;
	rst <= '0' after 1 us;
end testbench;