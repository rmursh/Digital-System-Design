-- This circuit implements the ADD3 function, where the output Y is equal to
-- the input X as long as X is less than 5, otherwise it is equal to X+3
-- The circuit will be used in a binary to BCD converter, hence the X values
-- will be assumed to have values from 0000 to 1001. The output for values other
-- than these are don’t cares.
--
-- entity name: g06_ADD3
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik


library ieee; 
use ieee.std_logic_1164.all; -- allows use of the std_logic_vector type

entity g06_Add3 is
port ( X1,X2,X3,X4 : in std_logic;
Y1,Y2,Y3,Y4 : out std_logic
);
end g06_Add3;

architecture implementation1 of g06_Add3 is 
 
 signal X,Y: std_logic_vector(3 downto 0);

 
begin

 X <= X1&X2&X3&X4;
 Y1 <= Y(0);
 Y2 <= Y(1);
 Y3 <= Y(2);
 Y4 <= Y(3);


with X select 
 
 Y <= 
        "0000" when "0000",
        "0001" when "0001",
        "0010" when "0010",
        "0011" when "0011",
        "0100" when "0100",
        "1000" when "0101",
        "1001" when "0110",
        "1010" when "0111",
        "1011" when "1000",
        "1100" when "1001",
        "----" when others;
 
end implementation1;