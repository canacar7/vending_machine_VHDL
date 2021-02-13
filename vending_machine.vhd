library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity vending_machine is
port(
	
	clk : in std_logic;
	rst : in std_logic;
	para_giris : in std_logic;
	para : in std_logic_vector(4 downto 0);
	
	--outputs
	urun_hazir : out std_logic;
	para_ustu : out std_logic
	);
end entity;	

architecture arch of vending_machine is

--durumlarý belirtmek icin
type state_type is (IDLE, Para_g, Urun_t, Para_u);
signal state : state_type;  


--process signal
signal toplam_para : std_logic_vector(4 downto 0);
signal eksik_para_flag : std_logic;

signal fiyat : std_logic_vector(4 downto 0);

begin
    fiyat <= "01010";

--mimari tanýmý

process(clk,rst)
begin
	if(rst = '1') then 
		state <= IDLE;
		toplam_para <= (others => '0');
		urun_hazir <= '0';
		para_ustu <= '0';
		eksik_para_flag <= '0';
	elsif(rising_edge(clk))	then
		case state is
			when IDLE =>
				toplam_para <= (others => '0');
				urun_hazir <= '0';
				para_ustu <= '0';
				eksik_para_flag <= '0';
				if(para_giris = '1') then
					state <= Para_g;
					toplam_para <= toplam_para + para;
				else
					state <= IDLE;
				end if;	
			when Para_g =>
				if(para_giris  = '1') then
					state <= Para_g;
					toplam_para <= toplam_para + para;
				else
					if(toplam_para >= fiyat) then
						state <= Urun_t;
					else
						state <= Para_u;
						eksik_para_flag <= '1';
					end if;	
				end if;
				
			when Urun_t =>
				toplam_para <= toplam_para - fiyat;
				urun_hazir <= '1';
				state <= Para_u;
			when Para_u =>
				if(toplam_para /=  "00000") then
					toplam_para <= toplam_para - "00001";
					para_ustu <= '1';
					urun_hazir <= '0';
					state <= Para_u;
				else
					--TOPLAM PARA 0
					state <=IDLE; 
					para_ustu <= '0';					
				end if;	 
			when others => 	
				state <= IDLE;
				toplam_para <= (others => '0');
				urun_hazir <= '0';
				para_ustu <= '0';
				eksik_para_flag <= '0';	
		end case;	
	end if;
end process;
end architecture;
