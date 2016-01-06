-- g06_speed_calories gives the boat speed and calorie rate
-- entity name: g06_speed_calories
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 15th November 2014.
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY altera_mf;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity g06_speed_calories is 
	port ( clk : in std_logic;
	 ROWER_POWER : in unsigned(3 downto 0);
	 BOAT_SPEED, CALORIE_RATE : out unsigned(11 downto 0));
end g06_speed_calories;

architecture behaviour of g06_speed_calories is 

signal rowerpower1 : unsigned (9 downto 0);
signal calorierate1 : unsigned (19 downto 0);
signal boatspeed1 : unsigned (20 downto 0);
signal crc_of_ROWER_POWER : std_logic_vector (11 downto 0);
signal x: unsigned(18 downto 0); 
begin
   
   rowerpower1 <= ROWER_POWER * "100000";

   find_Calorie_Rate: process(clk)
   
   begin 
   
	if clk = '1' and clk'event then
    calorierate1 <= "1101110001"*rowerpower1 + "10010110000000000";
    end if;          
   end process;
    
		CALORIE_RATE <= calorierate1(19 downto 8);
		
		crc_table : lpm_rom -- use the altera rom library macrocell
		GENERIC MAP(
		lpm_widthad => 4, -- sets the width of the ROM address bus
		lpm_numwords => 16, -- sets the words stored in the ROM
		lpm_outdata => "UNREGISTERED", -- no register on the output
		lpm_address_control => "REGISTERED", -- register on the input
		lpm_file => "crc_rom.mif", -- the ascii file containing the ROM data
		lpm_width => 12) -- the width of the word stored in each ROM location
		PORT MAP(inclock => clk, address => std_logic_vector(ROWER_POWER), q => crc_of_ROWER_POWER);


   find_Boat_Speed: process(clk)
   begin 
   
	if clk = '1' and clk'event then
    boatspeed1 <= ("101101011"*unsigned(crc_of_ROWER_POWER));--/x;--*"000000001"; --1/512
    end if;          
   end process;
   
   BOAT_SPEED <= boatspeed1(20 downto 9);
    
 end behaviour;
    
     

   