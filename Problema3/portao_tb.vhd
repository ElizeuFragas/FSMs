library ieee;
use ieee.std_logic_1164.all;

entity portao_tb is
end portao_tb;

architecture testbench of portao_tb is
	component portao
	port(
		clk, rst, bt, p, fc1, fc2	: in  std_logic;
		s0, s1 : out std_logic;
        estado : out character
	);
	end component;
	
	signal clk, clk_bt, bt, s0, s1, p, fc1, fc2 : std_logic := '0';
	signal rst : std_logic := '1';
	signal estado : character;

	constant bt_array : std_logic_vector(0 to 17) := "000101110011000010";
	constant p_array : std_logic_vector(0 to 17)  := "000101000011000010";
	constant fc1_array : std_logic_vector(0 to 17)  := "000000000111111111";
	constant fc2_array : std_logic_vector(0 to 17)  := "111111111000000000";
begin
	
	instancia: portao
	port map(
		clk => clk,
		rst => rst,
		bt => bt,
		fc1 => fc1,
		fc2 => fc2,
        p => p,
		s0 => s0,
		s1 => s1,
        estado => estado
	);
	
	gerador_entrada : process(clk, clk_bt, rst)
		variable i : integer := 0;
	begin
		if rst = '1' then
			i := 0;
			bt <= bt_array(i);
		elsif rising_edge(clk_bt) then
			bt <= bt_array(i);
            p <= p_array(i);
            fc1 <= fc1_array(i);
            fc2 <= fc2_array(i);
			i := i + 1;
			
			if i = bt_array'length then
				i := 0;
			end if;
		end if;
	end process;
		
	clk <= not clk after 50 us;
	clk_bt <= not clk_bt after 50 ms;
	rst <= '0' after 1 us;
end testbench;