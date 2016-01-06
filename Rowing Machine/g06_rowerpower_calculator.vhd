-- g06_rowerpower_calculator scales rower power by stroke rate
-- entity name: g06_rowerpower_calculator
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 20th November 2014.

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity g06_rowerpower_calculator is 
port ( clk : in std_logic;
	  Stroke_rate : in unsigned(7 downto 0);
	  ROWER_POWER : in unsigned(3 downto 0);
	  new_rower_power : out unsigned(3 downto 0));
end g06_rowerpower_calculator;

architecture behavior of g06_rowerpower_calculator is 

signal rower_power_calculating : unsigned (25 downto 0); 
signal p : unsigned (3 downto 0);
signal q : unsigned (4 downto 0);
begin 


new_rower_power <= p;

limiting : process(clk)
 begin
 rower_power_calculating <= "00000010001011"*Stroke_rate*ROWER_POWER;
   q <= rower_power_calculating(17 downto 13);       
 if (q >= "01111") then
 p <= "1111";
 else
 p <= q(3 downto 0);
 end if;
end process; 

end behavior;