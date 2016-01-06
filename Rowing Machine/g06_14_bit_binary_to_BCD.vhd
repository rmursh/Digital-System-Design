-- this circuit converts a 14-bit binary number to a 4-digit BCD representation
--
-- entity name: g06_14_bit_binary_to_BCD

-- Author: Razi Murshed; razi.murshed@mail.mcgill.ca

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g06_14_bit_binary_to_BCD is
	port ( BIN : in unsigned (13 downto 0);
	OVER : out std_logic;
	BCD1, BCD2, BCD3, BCD4 : out std_logic_vector(3 downto 0)
	);
end g06_14_bit_binary_to_BCD;


architecture implementation1 of g06_14_bit_binary_to_BCD is
	
	signal a1,a2,a3,a4,b1,b2,b3,b4,c1,c2,c3,c4,d1,d2,d3,d4,e1,e2,e3,e4,f1,f2,f3,f4,g1,g2,g3,g4,h1,h2,h3,h4,i1,i2,i3,i4,j1,j2,j3,j4,k1,k2,k3,k4,l1,l2,l3,l4,
	       m1,m2,m3,m4,n1,n2,n3,n4,o1,o2,o3,o4,p1,p2,p3,p4,q1,q2,q3,q4,r1,r2,r3,r4,s1,s2,s3,s4,t1,t2,t3,t4,u1,u2,u3,u4,v1,v2,v3,v4 : std_logic;
	       
	component g06_Add3 
		port ( X1,X2,X3,X4 : in std_logic;
		Y1,Y2,Y3,Y4 : out std_logic
		);
	end component;
	
	begin
	
	inst0: g06_Add3 port map( X4 => std_logic(BIN(11)), X3 => std_logic(BIN(12)), X2=> std_logic(BIN(13)), X1=> '0', Y1 => a1, Y2 => a2, Y3 => a3, Y4 =>a4); -- 1st Add 3
	
	inst1: g06_Add3 port map( X4 =>std_logic(BIN(10)), X3 => a1 , X2=> a2, X1=> a3, Y1 => b1, Y2 => b2, Y3 => b3, Y4 =>b4); -- 2nd Add 3
	
	inst2: g06_Add3 port map( X4 =>std_logic(BIN(9)), X3 => b1, X2=> b2, X1=> b3 , Y1 => c1, Y2 => c2, Y3 => c3, Y4 => c4); -- 3rd Add 3
	
	inst3: g06_Add3 port map( X4 =>std_logic(BIN(8)), X3 => c1, X2=> c2, X1=> c3 , Y1 => d1, Y2 => d2, Y3 => d3, Y4 => d4); -- 4th Add 3 
	
	inst6: g06_Add3 port map( X4 =>c4, X3 => b4, X2=> a4, X1=> '0' , Y1 => e1, Y2 => e2, Y3 => e3, Y4 => e4); -- 5th Add 3
	
	inst4: g06_Add3 port map( X4 =>std_logic(BIN(7)), X3 => d1, X2=> d2, X1=> d3 , Y1 => f1, Y2 => f2, Y3 => f3, Y4 => f4); -- 6th Add 3
	
	inst7: g06_Add3 port map( X4 =>d4, X3 => e1, X2=> e2, X1=> e3 , Y1 => g1, Y2 => g2, Y3 => g3, Y4 => g4); -- 7th Add 3 
	
	inst5: g06_Add3 port map( X4 =>std_logic(BIN(6)), X3 => f1, X2=> f2, X1=> f3 , Y1 => h1, Y2 => h2, Y3 => h3, Y4 => h4); -- 8th Add 3
	
	inst8: g06_Add3 port map( X4 =>f4, X3 => g1, X2=> g2, X1=> g3 , Y1 => i1, Y2 => i2, Y3 => i3, Y4 => i4); -- 9th Add 3
	
	inst9: g06_Add3 port map( X4 =>std_logic(BIN(5)), X3 => h1, X2=> h2, X1=> h3 , Y1 => j1, Y2 => j2, Y3 => j3, Y4 => j4); -- 10th Add 3
	
	inst12: g06_Add3 port map( X4 =>h4, X3 => i1, X2=> i2, X1=> i3 , Y1 => k1, Y2 => k2, Y3 => k3, Y4 => k4); -- 11th Add 3 
	
	inst15: g06_Add3 port map( X4 =>i4, X3 => g4, X2=> e4, X1=> '0' , Y1 => l1, Y2 => l2, Y3 => l3, Y4 => l4); -- 12th Add 3 
	
	inst10: g06_Add3 port map( X4 =>std_logic(BIN(4)), X3 => j1, X2=> j2, X1=> j3 , Y1 => m1, Y2 => m2, Y3 => m3, Y4 => m4); -- 13th Add 3
	
	inst13: g06_Add3 port map( X4 =>j4, X3 => k1, X2=> k2, X1=> k3 , Y1 => n1, Y2 => n2, Y3 => n3, Y4 => n4); -- 14th Add 3 
	
	inst16: g06_Add3 port map( X4 =>k4, X3 => l1, X2=> l2, X1=> l3 , Y1 => o1, Y2 => o2, Y3 => o3, Y4 => o4); -- 15th Add 3
	 
	inst11: g06_Add3 port map( X4 =>std_logic(BIN(3)), X3 => m1, X2=> m2, X1=> m3 , Y1 => p1, Y2 => p2, Y3 => p3, Y4 => p4); -- 16th Add 3
	 
	inst14: g06_Add3 port map( X4 =>m4, X3 => n1, X2=> n2, X1=> n3 , Y1 => q1, Y2 => q2, Y3 => q3, Y4 => q4); -- 17th Add 3 
	
	inst17: g06_Add3 port map( X4 =>n4, X3 => o1, X2=> o2, X1=> o3 , Y1 => r1, Y2 => r2, Y3 => r3, Y4 => r4); -- 18th Add 3 
	
	inst18: g06_Add3 port map( X4 =>std_logic(BIN(2)), X3 => p1, X2=> p2, X1=> p3 , Y1 => s1, Y2 => s2, Y3 => s3, Y4 => s4); -- 19th Add 3 
	
	inst21: g06_Add3 port map( X4 =>p4, X3 => q1, X2=> q2, X1=> q3 , Y1 => t1, Y2 => t2, Y3 => t3, Y4 => t4); -- 20th Add  
	
	inst24: g06_Add3 port map( X4 =>q4, X3 => r1, X2=> r2, X1=> r3 , Y1 => u1, Y2 => u2, Y3 => u3, Y4 => u4); -- 21st Add 3
	
	inst27: g06_Add3 port map( X4 =>r4, X3 => o4, X2=> l4, X1=> '0' , Y1 => v1, Y2 => v2, Y3 => v3, Y4 => v4); -- 22nd Add 3
	
	inst19: g06_Add3 port map( X4 =>std_logic(BIN(1)), X3 => s1, X2=> s2, X1=> s3 , Y1 => BCD1(1), Y2 => BCD1(2), Y3 => BCD1(3), Y4 => BCD2(0)); -- 23rd Add 3
	
	inst22: g06_Add3 port map( X4 =>s4, X3 => t1, X2=> t2, X1=> t3 , Y1 => BCD2(1), Y2 => BCD2(2), Y3 => BCD2(3), Y4 => BCD3(0)); -- 24th Add 3
	
	inst25: g06_Add3 port map( X4 =>t4, X3 => u1, X2=> u2, X1=> u3 , Y1 => BCD3(1), Y2 => BCD3(2), Y3 => BCD3(3), Y4 => BCD4(0)); -- 25th Add 3
	
	inst28: g06_Add3 port map( X4 =>u4, X3 => v1, X2=> v2, X1=> v3 , Y1 => BCD4(1), Y2 => BCD4(2), Y3 => BCD4(3), Y4 => OVER); -- 26th Add 3
	
	BCD1(0) <= std_logic(BIN(0));
	
end implementation1;    
	  
	
	
	
	
	
	
	
	