-- g06_Stroke_Counter gives the total stroke count and stroke rate over a minute
-- entity name: g06_Stroke_Counter
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 1st November 2014.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity g06_Stroke_Counter is
 
 port(clock, reset, TPULSE, SPULSE : in std_logic;
      STROKE_COUNT : out unsigned(13 downto 0);
      STROKE_RATE: out unsigned(7 downto 0));

end g06_Stroke_Counter;

architecture counter of g06_Stroke_Counter is 

signal STROKE_COUNT_VALUE : unsigned(13 downto 0);
signal STROKE_RATE_VALUE: unsigned (7 downto 0);
signal m : unsigned (7 downto 0);
signal STROKE_RESET_RATE: unsigned (13 downto 0);
signal disable_SPULSE_count: std_logic;
 
 begin
  -- STROKE_COUNT_VALUE <= "00000000000000";
    STROKE_RATE <= m;
   stroke_counter : process(reset,clock, SPULSE)  
     begin
        
        
       if reset = '1' then
       STROKE_COUNT <= "00000000000000";
       STROKE_COUNT_VALUE <= "00000000000000";
       STROKE_RESET_RATE <= "00000000000000";
       STROKE_RATE_VALUE <= "00000000"; 
       m <= "00000000";
       elsif clock = '1' and clock'event then
        if SPULSE = '1' and disable_SPULSE_count = '0' then 
        STROKE_COUNT <=  STROKE_COUNT_VALUE + 1;
        STROKE_COUNT_VALUE <= STROKE_COUNT_VALUE + 1;
        STROKE_RATE_VALUE <= STROKE_RATE_VALUE + 1;
        disable_SPULSE_count <= '1';
        else
        STROKE_COUNT <=  STROKE_COUNT_VALUE;
        STROKE_COUNT_VALUE <= STROKE_COUNT_VALUE;
        end if; -- if SPULSE is 1
        if SPULSE = '0' then
        disable_SPULSE_count <= '0' ;
        end if; -- End if SPULSE 
        if TPULSE = '1'  then
        STROKE_RESET_RATE <= STROKE_RESET_RATE + 1;
        end if;
        if STROKE_RESET_RATE = "00000000111100" then
        m <= STROKE_RATE_VALUE;
        STROKE_RATE_VALUE <= "00000000"; 
        STROKE_RESET_RATE <= "00000000000000";
        end if;
        
        
        
         
       end if; -- if reset is 1
       
       
     end process;
 
 end counter;
        
           