-- g06_elapsed_time gives the total excercise time
-- entity name: g06_elapsed_time
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 20th November 2014.

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

library lpm;
use lpm.lpm_components.all;

entity g06_elapsed_time is
port (reset, clock, enable: in std_logic;
	      min_enable, TPULSE_O : out std_logic;
		  time_elapsed : out unsigned ( 13 downto 0)
	 );
end g06_elapsed_time;

architecture behaviour of g06_elapsed_time is 

signal TPULSE, min_enable2 : std_logic;


signal seconds2 : unsigned (13 downto 0);
signal minutes2 : unsigned (13 downto 0);
-- 
component g06_SECONDS_TIMER 
port (reset, clock, enable: in std_logic;
		  Tpulse: out std_logic);
end component;

begin 


time_elapsed <= minutes2 + seconds2;
TPULSE_O <= TPULSE;


inst1 : g06_SECONDS_TIMER port map (reset => reset, clock => clock, enable => enable, Tpulse => TPULSE);

 secondsCounter : process(clock)
 begin 
   if reset = '1' then
   seconds2 <= "00000000000000";
   minutes2 <= "00000000000000";
   elsif clock = '1' and clock'event then
    if TPULSE = '1' then
     seconds2 <= seconds2 + 1; 
    end if;
    if seconds2 = "111100" then --"111100"
     seconds2 <= "00000000000000";
     minutes2 <= minutes2 + 100;
    end if;
     
   end if;
end process;



end behaviour;