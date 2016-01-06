-- g06_SECONDS_TIMER gives a pulse a second
-- entity name: g06_SECONDS_TIMER
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 1st November 2014.

library ieee;
use ieee.std_logic_1164.all;

library lpm;
use lpm.lpm_components.all;

entity g06_SECONDS_TIMER is
	port (reset, clock, enable: in std_logic;
		  Tpulse: out std_logic);
		  
end g06_seconds_timer;

Architecture behavior of g06_seconds_timer is

signal c1: std_logic_vector(25 downto 0);
signal b1: std_logic;

begin

inst2: LPM_COUNTER generic map(LPM_WIDTH => 26, LPM_DIRECTION => "DOWN")
					port map(sload => (b1 or reset), cnt_en => enable , clock => clock, data => "10111110101111000001111111", q=> c1);
--"10111110101111000001111111" or "00000000000000001111101000"
with c1 select
			b1 <= '1' when "00000000000000000000000000",
				  '0' when others;
				  
Tpulse <= b1;


end behavior;
			    
			    
			    

