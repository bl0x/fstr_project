library ieee;
use ieee.std_logic_1164.all;

entity fstr is
	port (
		     CLK : in std_logic;
		     LED : out std_logic;
		     PIN_12 : out std_logic;
		     PIN_13 : out std_logic;
		     USBPU : out std_logic
);
end;

architecture RTL of fstr is
	signal clock : std_logic;
	signal clock_90 : std_logic;
	signal fast_clock : std_logic;
	signal locked : std_logic;

	component clock_div4 is
		port (clock_in : in std_logic;
		clock_div4_0 : out std_logic;
		clock_div4_90 : out std_logic
	);
	end component;
	component pll_16_200 is
		port (
		referenceclk: in std_logic;
		reset : in std_logic;
		plloutcore : out std_logic;
		plloutglobal : out std_logic;
		lock : out std_logic
	);
	end component;
begin
	USBPU <= '0';

	pll1 : pll_16_200 port map (
	referenceclk => CLK,
	reset => '1',
	plloutcore => fast_clock,
	plloutglobal => open,
	lock => locked);

	clockdiv4 : clock_div4 port map (
	clock_in => fast_clock,
	clock_div4_0 => clock,
	clock_div4_90 => clock_90);

	LED <= clock;
	PIN_12 <= clock;
	PIN_13 <= clock_90;
end;
