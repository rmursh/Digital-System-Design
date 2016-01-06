-- g06_FSM_controller acts the control circuit for the system monitoring the states of the inputs to the system.
-- entity name: g06_FSM_controller
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 20th November 2014.

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity g06_FSM_controller is 
port (reset, clock, start: in std_logic;
	   reset_out, enable_out: out std_logic  
	 );
end g06_FSM_controller;

architecture behavior of g06_FSM_controller is 

type state is (A, B, C, D);
signal state_now : state;
signal disable_start : std_logic;

begin 
 
 state_determination : process (clock, reset, start)
  begin
 -- If reset is pressed then goes to RESET state 
  if reset = '0' then 
  state_now <= A;
  elsif clock = '1' and clock'event then 
   case state_now is 
  -- If in first state A   
     when A =>
      state_now <= B; 
 -- If in second state B goes to READY TO START state     
     when B => 
      disable_start <= '1';
      if start = '1' then
      disable_start <= '0';
      end if;
      if reset = '0' then 
       state_now <= A; 
      elsif start <= '0' and disable_start = '0' then
       state_now <= C;
      else 
       state_now <= B;    
      end if;  
 -- If in third state C goes to EXCERCISING state
      when C => 
      disable_start <= '1';
      if start = '1' then
      disable_start <= '0';
      end if;
      if reset = '0' then 
       state_now <= A; 
      elsif start <= '0' and disable_start = '0' then
       state_now <= D;
      else 
       state_now <= C;
       --disable_start <= '0';
      end if;
   --In in last state D, goes to HOLD state 
      when D => 
      disable_start <= '1';
      if start ='1' then
      disable_start <= '0';
      end if;
      if reset = '0' then 
       state_now <= A; 
      elsif start <= '0' and disable_start = '0' then
       state_now <= C;
      else 
       state_now <= D;
      end if;
      when others =>
      state_now <= A;
    end case;
  end if;
end process;

reset_out <= '1' when state_now = A else '0';
enable_out <= '1' when state_now = C else '0';

end behavior;
       
      