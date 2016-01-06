LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity g06_14_bit_input_register is 

	port ( clock, start, clear : in std_logic;
	        data : in unsigned(13 downto 0);
	        register_output : out unsigned(13 downto 0);
	        shift_out, P : out std_logic);
	        

end g06_14_bit_input_register;

architecture behaviour of g06_14_bit_input_register  is

  signal Q : unsigned(13 downto 0);
	begin
	sreg14bit: process(clear, clock)
       variable Count: integer range 0 to 15;
		begin
	
		 if clear = '1' then
		 Q <= "00000000000000";
		 elsif start = '1' then
		    P <= '0';
			Count := 0;
			Q <= data;
			
		-- end if;
		 elsif clock = '1' and clock'event then
		    
		    if Count = 15 then
		    P <= '1';
		    end if;
			if Count < 15 then 
		    Count := Count + 1;
		    shift_out <= Q(13);
			Q <=  Q(12 downto 0) & '0';
			register_output <= Q;
		    end if; -- if par_ld
		 end if; -- if clear
	end process;
	
end behaviour; 


