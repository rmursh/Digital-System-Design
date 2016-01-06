-- g06_distance_travelled gives the total distance travlled during excercise
-- entity name: g06_distance_travelled
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 20th November 2014.

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

library lpm;
use lpm.lpm_components.all;

entity g06_distance_travelled is
port (reset, clock, TPULSE, enable: in std_logic;
	      boat_speed : in unsigned(11 downto 0);
		  distance_travelled : out unsigned(13 downto 0);
		  pace_out : out unsigned(8 downto 0);
		  tpulse_out : out unsigned(8 downto 0)
	 );
end g06_distance_travelled;

architecture behaviour of g06_distance_travelled is 

signal distancetravelled : unsigned (22 Downto 0); 
signal distance_travel_pace : unsigned(22 downto 0);
signal tpulse_count : unsigned(8 downto 0);
signal pace_out2 : unsigned(8 downto 0);

begin 

distance_travelled <=  distancetravelled(22 downto 9); 
tpulse_out <= tpulse_count;
pace_out <= pace_out2;

calculateDistance : process (clock)
 begin 
  if reset ='1' then 
  distancetravelled <= "00000000000000000000000";
  distance_travel_pace <= "00000000000000000000000";
  pace_out2 <= "000000000";
  elsif clock = '1' and clock'event then
	  if TPULSE = '1' then
         tpulse_count <= tpulse_count + 1;
		 distancetravelled <= distancetravelled + boat_speed;
		 distance_travel_pace <= distance_travel_pace + boat_speed; 
		 if (distance_travel_pace(22 downto 9) >= "00000111110100") then
         pace_out2 <= tpulse_count;
         distance_travel_pace <= "00000000000000000000000";
         tpulse_count <= "000000000";
         end if;
      end if;
  end if;
end process;

 
end behaviour;
  
