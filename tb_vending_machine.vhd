


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_vending_machine is
--  Port ( );
end tb_vending_machine;

architecture Behavioral of tb_vending_machine is
component vending_machine is
port(
	
	clk : in std_logic;
	rst : in std_logic;
	para_giris : in std_logic;
	para : in std_logic_vector(4 downto 0);
	
	--outputs
	urun_hazir : out std_logic;
	para_ustu : out std_logic
	);
end component;	

--baglantý sinyalleri tanýmlama
signal	clk :  std_logic;
signal	rst :  std_logic;
signal	para_giris :  std_logic;
signal	para :  std_logic_vector(4 downto 0);
signal	urun_hazir :  std_logic;
signal	para_ustu :  std_logic ;

constant clk_period : time := 20ns;

begin
--clk'un davranýsýný ayarlýcam
clk_process: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2; 
end process;

--port map yapma adýmý

uut: vending_machine port map(
clk             =>   clk,
rst             =>   rst,
para_giris      =>   para_giris,
para            =>   para,
urun_hazir      =>   urun_hazir,
para_ustu       =>   para_ustu 
);

--test caselere gecebiliriz
sim_process : process
begin
rst <= '1';
para_giris <= '0';
para <= (others => '0');
wait for 100ns;
rst <= '0';
wait for clk_period*2;

--1
para_giris <= '1';
para <= "00001";
wait for clk_period;
para <= "00101";
wait for clk_period;
para <= "01010";
wait for clk_period;
para_giris <= '0';
wait for clk_period*15;



--2
para_giris <= '1';
para <= "00001";
wait for clk_period;
para <= "00001";
wait for clk_period;
para <= "00101";
wait for clk_period;
para_giris <= '0';
wait for clk_period*15;

--3
para_giris <= '1';
para <= "00101";
wait for clk_period;
para <= "00001";
wait for clk_period;
para <= "00001";
wait for clk_period;
para <= "00101";
wait for clk_period;
para_giris <= '0';
wait for clk_period*15;
--4
para_giris <= '1';
para <= "01010";
wait for clk_period;
para <= "00101";
wait for clk_period;
para <= "00101";
wait for clk_period;
para_giris <= '0';
wait for clk_period*15;


end process;

end Behavioral;
