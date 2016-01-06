-- g06_Rower_Machine is the test bed and the entire assembled system.
-- entity name: g06_Rower_Machine
--
-- Authors: Razi Murshed; razi.murshed@mail.mcgill.ca & Muhammad Saad Malik; muhammad.s.malik@mail.mcgill.ca
-- Date 22nd November 2014.

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity g06_Rower_Machine is 
 port (reset, clock, start, SPULSE: in std_logic;
	  rower_power_in: in unsigned (3 Downto 0);
	  data_view_request : in unsigned (2 Downto 0);
	  led_light_up1,led_light_up2,led_light_up3,led_light_up4, led_light_up5,led_light_up6,led_light_up7, led_light_up8 : out std_logic;
      segments1, segments2, segments3, segments4 : out std_logic_vector(6 downto 0)
	  
	 );
end g06_Rower_Machine;

architecture implementation of g06_Rower_Machine is 


-- *******************************************************Defining Components*************************************************************************************
-- FSM Controller
component g06_FSM_controller
port (reset, clock, start: in std_logic;
	   reset_out, enable_out: out std_logic  
	 );
end component;
-- Seconds Timer
component g06_SECONDS_TIMER is
	port (reset, clock, enable: in std_logic;
		  Tpulse: out std_logic);		  
end component;
--Elapsed Time
component g06_elapsed_time 
port (reset, clock, enable: in std_logic;
	      min_enable, TPULSE_O : out std_logic;
		  time_elapsed : out unsigned ( 13 downto 0)
	 );
end component;
--Stroke Counter
component g06_Stroke_Counter 
port(clock, reset, TPULSE, SPULSE : in std_logic;
      STROKE_COUNT : out unsigned(13 downto 0);
      STROKE_RATE: out unsigned(7 downto 0));
end component;
-- Distance Travelled
component g06_distance_travelled 
port (reset, clock, TPULSE, enable: in std_logic;
	      boat_speed : in unsigned(11 downto 0);
		  distance_travelled : out unsigned(13 downto 0);
		  pace_out : out unsigned(8 downto 0);
		  tpulse_out : out unsigned(8 downto 0)
	 );
end component;
--Rower Power Calculator
component g06_rowerpower_calculator  
port ( clk : in std_logic;
	  Stroke_rate : in unsigned(7 downto 0);
	  ROWER_POWER : in unsigned(3 downto 0);
	  new_rower_power : out unsigned(3 downto 0));
end component;
--Speed Calories
component g06_speed_calories  
	port ( clk : in std_logic;
	 ROWER_POWER : in unsigned(3 downto 0);
	 BOAT_SPEED, CALORIE_RATE : out unsigned(11 downto 0));
end component;
--Total Calories
component g06_total_calories 
port (reset, clock, TPULSE, enable: in std_logic;
	      calorie_rate : in unsigned(11 downto 0);
		  total_calories : out unsigned(13 downto 0)
	 );
end component;
--Serial Binary To BCD
component g06_serial_binary_to_bcd 	
	port ( clk, start : in std_logic;
	BIN : in unsigned(13 downto 0);
	ready : out std_logic;
	BCD4, BCD3, BCD2, BCD1 : out std_logic_vector(3 downto 0));
end component;
component g06_14_bit_binary_to_BCD is
	port ( BIN : in unsigned (13 downto 0);
	OVER : out std_logic;
	BCD1, BCD2, BCD3, BCD4 : out std_logic_vector(3 downto 0)
	);
end component;

--BCD7
component bcd7 
port (code : in std_logic_vector(3 downto 0);
	  RippleBlank_In : in std_logic;
	  RippleBlank_Out : out std_logic;
	  segments : out std_logic_vector(6 downto 0));
end component;

--********************************************************************Defining Signals****************************************************************************
signal reset_component, enable_component, tpulse_out : std_logic;
signal time_out : unsigned (13 downto 0);
signal stroke_count_out, distance_travelled_out, total_calories_out : unsigned (13 downto 0);
signal stroke_rate_out : unsigned(7 downto 0);
signal boat_speed_out, calorie_rate_out : unsigned(11 downto 0);
signal pace_out2: unsigned (8 downto 0); 
signal power_out : unsigned (3 downto 0);
signal print : unsigned (13 downto 0);
signal x1,x2, x3, k : std_logic;
signal bc1, bc2, bc3, bc4 : std_logic_vector(3 downto 0);
	  

signal	strke_count_out, dist_travelled_out, total_cal_out :  unsigned (13 downto 0);
signal strke_rate_out :  unsigned(13 downto 0);
signal boat_spd_out, cal_rate_out :  unsigned(13 downto 0);
signal pce_out2:  unsigned (13 downto 0); 

--********************************************************************Making Connections*************************************************************************
begin
FSMController : g06_FSM_controller port map (reset => reset, clock => clock, start => start, reset_out => reset_component, enable_out => enable_component);
SecondsTimer: g06_SECONDS_TIMER port map (reset => reset_component, clock => clock, enable => enable_component, TPULSE => tpulse_out);
ElapsedTime: g06_elapsed_time port map (reset => reset_component, clock => clock, enable => enable_component, time_elapsed => time_out);
StrokeCounter: g06_Stroke_counter port map (reset => reset_component, clock => clock, TPULSE => tpulse_out, SPULSE => SPULSE, STROKE_COUNT => stroke_count_out, STROKE_RATE => stroke_rate_out);
DistanceTravelled : g06_distance_travelled port map (reset => reset_component, clock => clock, enable => enable_component, TPULSE => tpulse_out, boat_speed => boat_speed_out,distance_travelled => distance_travelled_out, pace_out => pace_out2);
RowerPowerCalculator: g06_rowerpower_calculator port map (clk => clock, Stroke_rate => stroke_rate_out, ROWER_POWER => rower_power_in, new_rower_power => power_out);
SpeedCalories : g06_speed_calories port map (clk => clock, ROWER_POWER => power_out, boat_speed => boat_speed_out, calorie_rate => calorie_rate_out);
TotalCalories : g06_total_calories port map (reset => reset_component, clock => clock, enable => enable_component, TPULSE => tpulse_out, calorie_rate => calorie_rate_out, total_calories => total_calories_out);


	 
	 strke_count_out <=  stroke_count_out;
	 dist_travelled_out <= distance_travelled_out;
	 total_cal_out  <= total_calories_out;
	 strke_rate_out <= "000000"&stroke_rate_out;
	 boat_spd_out <=  "00000000000"&boat_speed_out(11 downto 9);
	 cal_rate_out <= "00"&calorie_rate_out(11 downto 0);
	 pce_out2 <= "00000"&pace_out2;
--	 k(0) <= '0';
--	 k(1) <= '0';
--	 k(3 downto 2) <= print(13 downto 12); 

	 
	 with data_view_request select
	 
	 print <=
	 strke_count_out when "001",
	 dist_travelled_out when "010",
	 total_cal_out when "011",
	 strke_rate_out  when "100",
	 boat_spd_out when "101",
	 cal_rate_out when "110",
	 pce_out2 when "111",
	 time_out when others;
	 
	 
	 with data_view_request select
	 led_light_up1 <=
      '1' when "000" ,
      '0' when others;
     with data_view_request select 
     led_light_up2 <=
      '1' when  "001" ,
      '0' when others;
     with data_view_request select
     led_light_up3 <=
      '1' when  "010" ,
      '0' when others;
     with data_view_request select
     led_light_up4 <=
      '1' when  "011", 
      '0' when others;
     with data_view_request select
     led_light_up5 <=
      '1' when  "100", 
      '0' when others;
     with data_view_request select
     led_light_up6 <=
      '1' when  "101", 
      '0' when others;
     with data_view_request select
     led_light_up7 <=
      '1' when  "110", 
      '0' when others;
     with data_view_request select
     led_light_up8 <=
      '1' when  "111" ,
      '0' when others;
 



     
	 
SerialBCS : g06_14_bit_binary_to_BCD port map (BIN => print, over => k, BCD1 => bc1, BCD2 => bc2, BCD3 => bc3, BCD4 => bc4); 	 
BCD4: bcd7 port map ( code =>bc4 , RippleBlank_In => '1', RippleBlank_Out => x1, segments => segments1);  
inst3: bcd7 port map ( code => bc3, RippleBlank_In => x1, RippleBlank_Out => x2, segments => segments2);  
inst4: bcd7 port map ( code => bc2, RippleBlank_In => x2, RippleBlank_Out => x3, segments => segments3);  
inst5: bcd7 port map ( code => bc1, RippleBlank_In => '0', segments => segments4);
	  
	  
		    
	 
end implementation;