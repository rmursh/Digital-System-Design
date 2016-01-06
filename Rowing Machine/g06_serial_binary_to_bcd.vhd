-- g06_serial_binary_to_bcd converts a binary number to BCD
-- entity name: g06_serial_binary_to_bcd
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 15th November 2014.

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity g06_serial_binary_to_bcd is 
	
	port ( clk, start : in std_logic;
	BIN : in unsigned(13 downto 0);
	ready : out std_logic;
	BCD4, BCD3, BCD2, BCD1 : out std_logic_vector(3 downto 0));
	
end g06_serial_binary_to_bcd;

architecture behaviour of g06_serial_binary_to_bcd is
    
    component g06_14_bit_input_register
		port ( clock, start, clear : in std_logic;
				data : in unsigned(13 downto 0);
				register_output : out unsigned(13 downto 0);
				shift_out, P : out std_logic);
	end component;
	
	component g06_16_bit_output_register
		 port ( clock, serial_in, start : in std_logic;
			   datain : in std_logic_vector (15 downto 0);
			   P : out std_logic;
			   dataout : out std_logic_vector (15 downto 0)); 
	end component;
	
	component g06_Add3
		port ( X1,X2,X3,X4 : in std_logic;
		Y1,Y2,Y3,Y4 : out std_logic
		);
	end component;
			        
	signal serial_bit_in, clear, ready1 : std_logic;
	signal reg16_in : std_logic_vector (15 downto 0); 
    signal reg16_out : std_logic_vector (15 downto 0); 
    
    begin 
    
		deassertReady: process(start)
		 
		  begin
			 if start = '1' then
			   ready <= '0';  
			else 
		      ready <= ready1;
		    end if;
		    
		 end process;  
		 
		
		 
		 inst1: g06_14_bit_input_register port map (clock => clk, start => start, clear => '0', data => BIN, shift_out => serial_bit_in);
		 inst2: g06_16_bit_output_register port map ( clock => clk, serial_in => serial_bit_in, start => start, datain => reg16_in, dataout => reg16_out, P => ready1);
		 inst3: g06_Add3 port map ( X4 => reg16_out(0), X3 => reg16_out(1), X2 => reg16_out(2), X1 => reg16_out(3), Y1 => reg16_in(0), Y2 => reg16_in(1), Y3 => reg16_in(2), Y4 => reg16_in(3));
	     inst4: g06_Add3 port map ( X4 => reg16_out(4), X3 => reg16_out(5), X2 => reg16_out(6), X1 => reg16_out(7), Y1 => reg16_in(4), Y2 => reg16_in(5), Y3 => reg16_in(6), Y4 => reg16_in(7));
	     inst5: g06_Add3 port map ( X4 => reg16_out(8), X3 => reg16_out(9), X2 => reg16_out(10), X1 => reg16_out(11), Y1 => reg16_in(8), Y2 => reg16_in(9), Y3 => reg16_in(10), Y4 => reg16_in(11));
	     inst6: g06_Add3 port map ( X4 => reg16_out(12), X3 => reg16_out(13), X2 => reg16_out(14), X1 => reg16_out(15), Y1 => reg16_in(12), Y2 => reg16_in(13), Y3 => reg16_in(14), Y4 => reg16_in(15));
	     
	     BCD1 <= reg16_out(3 downto 0);
		 BCD2 <= reg16_out(7 downto 4);
		 BCD3 <= reg16_out(11 downto 8);
		 BCD4 <= reg16_out(15 downto 12);
		 
		 
		 
	
end behaviour;
	 
	 
	 