-- g06_total_calories gives the total calories burned during excercise
-- entity name: g06_total_calories
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 20th November 2014.

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

library lpm;
use lpm.lpm_components.all;

entity g06_total_calories is
port (reset, clock, TPULSE, enable: in std_logic;
	      calorie_rate : in unsigned(11 downto 0);
		  total_calories : out unsigned(13 downto 0)
	 );
end g06_total_calories;

architecture behavior of g06_total_calories is 

signal caloriesburned : unsigned (34 Downto 0); 

begin

total_calories <= caloriesburned(34 downto 21);
calculateTotalCalories : process (clock)
begin 
 
 
if reset ='1' then 
  caloriesburned <= "00000000000000000000000000000000000";

  elsif clock = '1' and clock'event then
	  if TPULSE = '1' then
		 caloriesburned <= caloriesburned + (calorie_rate*"010001111010");
		 
      end if;
  end if;
end process;
end behavior;
