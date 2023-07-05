library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity models_tb is
	-- Generic declarations of the tested unit
		generic(
		BALL_SIZE : POSITIVE := 8;
		PADDLE_SIZE : POSITIVE := 32;
		SCREEN_WIDTH : POSITIVE := 240;
		SCREEN_HEIGHT : POSITIVE := 180;
		BALL_SPEED : POSITIVE := 5;
		PADDLE_SPEED : integer := 3;
		PADDLE1_X : POSITIVE := 1;
		PADDLE2_X : POSITIVE := 239 );
end models_tb;

architecture TB_ARCHITECTURE of models_tb is
	-- Component declaration of the tested unit
	component models
		generic(
		BALL_SIZE : POSITIVE := 8;
		PADDLE_SIZE : POSITIVE := 32;
		SCREEN_WIDTH : POSITIVE := 240;
		SCREEN_HEIGHT : POSITIVE := 180;
		BALL_SPEED : POSITIVE := 5;
		PADDLE_SPEED : integer := 3;
		PADDLE1_X : POSITIVE := 1;
		PADDLE2_X : POSITIVE := 239 );
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		start : in STD_LOGIC;
		paddle1_y : out INTEGER;
		paddle2_y : out INTEGER;
		ball_x : out INTEGER;
		ball_y : out INTEGER );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal start : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal paddle1_y : INTEGER;
	signal paddle2_y : INTEGER;
	signal ball_x : INTEGER;
	signal ball_y : INTEGER;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : models
		generic map (
			BALL_SIZE => BALL_SIZE,
			PADDLE_SIZE => PADDLE_SIZE,
			SCREEN_WIDTH => SCREEN_WIDTH,
			SCREEN_HEIGHT => SCREEN_HEIGHT,
			BALL_SPEED => BALL_SPEED,
			PADDLE_SPEED => PADDLE_SPEED,
			PADDLE1_X => PADDLE1_X,
			PADDLE2_X => PADDLE2_X
		)

		port map (
			clk => clk,
			reset => reset,
			start => start,
			paddle1_y => paddle1_y,
			paddle2_y => paddle2_y,
			ball_x => ball_x,
			ball_y => ball_y
		);

	-- Add your stimulus here ...
	  	
	-- Clock process
	process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;

	-- Reset process
	process
	begin
		reset <= '1';
		wait for 10 ns;
		reset <= '0';
		wait for 10 ns;
	end process;

	-- Stimulus process
	process
	begin
		wait for 10 ns;
		reset <= '1';
		wait for 10 ns;
		reset <= '0';
		start <= '1';
		
		wait;
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_models of models_tb is
	for TB_ARCHITECTURE
		for UUT : models
			use entity work.models(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_models;

