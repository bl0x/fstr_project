library IEEE;
use IEEE.std_logic_1164.all;

-- Adapted using a yosys test bench for the component:
-- https://github.com/YosysHQ/icestorm/blob/master/icefuzz/tests/sb_pll40_core.v
-- Using values determined via icepll

entity pll_16_200 is
port(
       REFERENCECLK: in std_logic;
       RESET: in std_logic;
       PLLOUTCORE: out std_logic;
       PLLOUTGLOBAL: out std_logic;
       LOCK: out std_logic
     );
end entity pll_16_200;

architecture BEHAVIOR of pll_16_200 is

component SB_PLL40_CORE
   generic (
		FEEDBACK_PATH	 		 : string := "SIMPLE";
		DELAY_ADJUSTMENT_MODE_FEEDBACK 	 : string := "FIXED";
		DELAY_ADJUSTMENT_MODE_RELATIVE 	 : string := "FIXED";
		SHIFTREG_DIV_MODE 		: bit_vector(1 downto 0)	:= "00";
	  	FDA_FEEDBACK 			: bit_vector(3 downto 0) 	:= "0000";
		FDA_RELATIVE 			: bit_vector(3 downto 0)	:= "0000";
		PLLOUT_SELECT			: string := "GENCLK";
		DIVF				: bit_vector(6 downto 0);
		DIVR				: bit_vector(3 downto 0);
		DIVQ				: bit_vector(2 downto 0);
		FILTER_RANGE			: bit_vector(2 downto 0);
   		ENABLE_ICEGATE			: bit := '0';
		TEST_MODE			: bit := '0';
		EXTERNAL_DIVIDE_FACTOR		: integer := 1
        );
   port (
         REFERENCECLK		: in std_logic;
         PLLOUTCORE		: out std_logic;
         PLLOUTGLOBAL		: out std_logic;
         EXTFEEDBACK		: in std_logic;
         DYNAMICDELAY		: in std_logic_vector (7 downto 0);
         LOCK			: out std_logic;
         BYPASS			: in std_logic;
         RESETB			: in std_logic;
         LATCHINPUTVALUE	: in std_logic;
         SDO			: out std_logic;
         SDI			: in std_logic;
         SCLK			: in std_logic
        );
end component;

begin
pll_16_200_inst: SB_PLL40_CORE
generic map(
	      -- values from icepll
              FEEDBACK_PATH => "SIMPLE",
              DELAY_ADJUSTMENT_MODE_FEEDBACK => "FIXED",
              DELAY_ADJUSTMENT_MODE_RELATIVE => "FIXED",
              PLLOUT_SELECT => "GENCLK",
              SHIFTREG_DIV_MODE => "00",
              FDA_FEEDBACK => "0000",
              FDA_RELATIVE => "0000",
              DIVR => "0000",
              DIVF => "0110001",
              DIVQ => "010",
              FILTER_RANGE => "001",
              ENABLE_ICEGATE => '0'
            )
port map(
           REFERENCECLK => REFERENCECLK,
           PLLOUTCORE => PLLOUTCORE,
           PLLOUTGLOBAL => PLLOUTGLOBAL,
           EXTFEEDBACK => '0',
           DYNAMICDELAY => "00000000",
           RESETB => RESET,
           BYPASS => '0',
           LATCHINPUTVALUE => '0',
           LOCK => LOCK,
           SDI => '0',
           SDO => open,
           SCLK => '0'
         );

end BEHAVIOR;
