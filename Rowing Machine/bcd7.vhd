-- Add3 module
--
-- entity name: g06_bcd7
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity bcd7 is

port (code : in std_logic_vector(3 downto 0);
	  RippleBlank_In : in std_logic;
	  RippleBlank_Out : out std_logic;
	  segments : out std_logic_vector(6 downto 0));

end bcd7;

ARCHITECTURE behavior OF bcd7 IS

signal a: std_logic_vector(4 downto 0);
signal b: std_logic;
BEGIN


a<=(RippleBlank_in&code);

with a select   
	segments<=
		
	"1111111" when "10000",
	"1001111" when "10001", 
	"0010010" when "10010",
	"0000110" when "10011",
	"1001100" when "10100",
	"0100100" when "10101",
	"0100000" when "10110",
	"0001111" when "10111",
	"0000000" when "11000",
	"0000100" when "11001",
	
	"0000001" when "00000",
	"1001111" when "00001", 
	"0010010" when "00010",
	"0000110" when "00011",
	"1001100" when "00100",
	"0100100" when "00101",
	"0100000" when "00110",
	"0001111" when "00111",
	"0000000" when "01000",
	"0000100" when "01001",
	 "0001000" when "11010", 
 
	"0000000" when "11011", 
	"0110001" when "11100", 
	"0000001" when "11101", 
	"0110000" when "11110", 
	"0111000" when "11111", 
 
 
	"0001000" when "01010", 
	"0000000" when "01011", 
	"0110001" when "01100", 
	"0000001" when "01101", 
	"0110000" when "01110", 
	"0111000" when "01111", 

	
	"1111111" when others;

with a select
	rippleBlank_Out<= 
	'1' when "10000",
	'0' when others;

end behavior;