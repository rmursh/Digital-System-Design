LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity g06_16_bit_output_register is 

	port ( clock, serial_in, start : in std_logic;
	       datain : in std_logic_vector (15 downto 0);
	       P : out std_logic;
	       dataout : out std_logic_vector (15 downto 0));        

end g06_16_bit_output_register;
	
architecture behavior of g06_16_bit_output_register is 
    signal Q:  std_logic_vector (15 downto 0);
	begin
	dataout <= Q;
	sreg16bit: process(start, clock)
       variable Count: integer range 0 to 15;
		  
		begin
	
		 if start = '1' then
		
		 Q <=  "0000000000000000";
		 Count := 0;
		 P <= '0';
		
		-- end if;
		 elsif clock = '1' and clock'event then
		    
		    P <= '1';
		    if Count < 15 then
		     Count := Count + 1;
		       P <= '0';
				Q <= datain( 14 downto 0) & serial_in;
		    end if; -- if par_ld
		 end if; -- if clear
	end process;
	end behavior; 