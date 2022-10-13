library ieee;
use ieee.std_logic_1164.all;

entity portao_tb is
end portao_tb;

architecture testbench of portao_tb is
	component portao
	port(
		clk, rst, bt, p	: in  std_logic;
		s0, s1 : out std_logic;
        estado : out character
	);
	end component;
	
	signal clk, bt, s0, s1, p : std_logic := '0';
	signal rst : std_logic := '1';
	signal estado : character;

	constant bt_array : std_logic_vector(0 to 17) := "000101110011000010";
	constant p_array : std_logic_vector(0 to 17)  := "000101000011000010";
begin
	
	instancia: portao
	port map(
		clk => clk,
		rst => rst,
		bt => bt,
        p => p,
		s0 => s0,
		s1 => s1,
        estado => estado
	);
	
	gerador_entrada : process(clk, rst)
		variable i : integer := 0;
	begin
		if rst = '1' then
			i := 0;
			bt <= bt_array(i);
		elsif rising_edge(clk) then
			bt <= bt_array(i);
            p <= p_array(i);
			i := i + 1;
			
			if i = bt_array'length then
				i := 0;
			end if;
		end if;
	end process;
	
	clk <= not clk after 5 us;
	rst <= '0' after 1 us;
end testbench;