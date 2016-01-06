library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

library lpm;
use lpm.lpm_components.all;

entity g06_total_distance is
port (reset, clock, enable: in std_logic;
	      Boat_Speed : in unsigned (11 Downto 0) ;
		  minutes: out unsigned(6 downto 0);
		  seconds: out unsigned (5 downto 0)
	 );
end g06_total_distance;