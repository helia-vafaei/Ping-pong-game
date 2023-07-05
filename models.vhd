library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Models is
    generic (
		BALL_SIZE : positive := 8;  -- Size of the ball		
		PADDLE_SIZE : positive := 32;  -- Size of the paddle			 
        SCREEN_WIDTH : positive := 240;  -- Width of the screen
        SCREEN_HEIGHT : positive := 180;  -- Height of the screen
        BALL_SPEED : positive := 5;  -- Speed of the ball  
		PADDLE_SPEED : integer := 3;  -- Speed of the paddle	 
		PADDLE1_X : positive := 1; 
		PADDLE2_X : positive := 239
    );									
    port (
        clk : in std_logic;  -- Clock signal
        reset : in std_logic;  -- Reset signal
        start : in std_logic;  -- Start the ball movement
        paddle1_y : out integer;  -- Paddle1 Y position	 
		paddle2_y : out integer;  -- Paddle2 Y position
        ball_x : out integer;  -- Ball X position
        ball_y : out integer  -- Ball Y position
    );
end entity Models;

architecture Behavioral of Models is
begin
    process(clk, reset)	  
	variable ball_x_pos : integer;  -- Internal signal for ball X position
    variable ball_y_pos : integer;  -- Internal signal for ball Y position	  
	variable paddle1_y_pos : integer;  -- Internal signal for paddle1 Y position	
	variable paddle2_y_pos : integer;  -- Internal signal for paddle2 Y position	
    variable ball_x_dir : std_logic := '1';  -- Direction of ball movement along the X-axis
    variable ball_y_dir : std_logic := '1';  -- Direction of ball movement along the Y-axis
	variable paddle1_y_dir : std_logic := '1';  -- Direction of paddle1 movement along the Y-axis 
	variable paddle2_y_dir : std_logic := '0';  -- Direction of paddle2 movement along the Y-axis
    begin
        if (reset = '1') then  -- Reset the ball position
            ball_x_pos := SCREEN_WIDTH/2;
            ball_y_pos := SCREEN_HEIGHT/2;	
		    paddle1_y_pos := SCREEN_WIDTH/2;  	
			paddle2_y_pos := SCREEN_WIDTH/2; 	
			ball_x_dir := '1';	
			ball_y_dir := '1';
			paddle1_y_dir := '1';
			paddle2_y_dir := '0';
        elsif rising_edge(clk) then
            if (start = '1') then  -- Start the ball movement
                -- Update ball X position based on direction
                if (ball_x_dir = '1') then
                    ball_x_pos := ball_x_pos + BALL_SPEED;
                else
                    ball_x_pos := ball_x_pos - BALL_SPEED;
                end if;
                
                -- Update ball Y position based on direction
                if (ball_y_dir = '1') then
                    ball_y_pos := ball_y_pos + BALL_SPEED;
                else
                    ball_y_pos := ball_y_pos - BALL_SPEED;
                end if;	  
				
			    -- Update paddle1 Y position based on direction
                if (paddle1_y_dir = '1') then
                    paddle1_y_pos := paddle1_y_pos + PADDLE_SPEED;
                else
                    paddle1_y_pos := paddle1_y_pos - PADDLE_SPEED;
                end if;	
				
			    -- Update paddle2 Y position based on direction
                if (paddle2_y_dir = '1') then
                    paddle2_y_pos := paddle2_y_pos + PADDLE_SPEED;
                else
                    paddle2_y_pos := paddle2_y_pos - PADDLE_SPEED;
                end if;
                
                -- Check for collision with paddles (adjust direction if needed)
					--paddle1
                if (ball_y_pos >= paddle1_y_pos and ball_y_pos <= paddle1_y_pos + PADDLE_SIZE and ball_x_pos = 1) then
                    ball_x_dir := '1';  -- Reverse direction
                end if;	  
				    --paddle2
				if (ball_y_pos >= paddle2_y_pos and ball_y_pos <= paddle2_y_pos + BALL_SIZE and ball_x_pos = SCREEN_WIDTH - 1) then
                    ball_x_dir := '0';  -- Reverse direction
                end if;
                
                -- Check for collision with top or bottom screen boundary (reverse direction if needed)
                if (ball_y_pos <= 0 or ball_y_pos >= SCREEN_HEIGHT - BALL_SIZE) then
                    ball_y_dir := not ball_y_dir;  -- Reverse direction
                end if;
                
                -- Check for collision with left and right screen boundary (reset position and direction)
                if (ball_x_pos <= 0 or ball_x_pos >= SCREEN_WIDTH - 1) then
                    ball_x_pos := SCREEN_WIDTH/2;  -- Reset position
                    ball_y_pos := SCREEN_HEIGHT/2;  -- Reset position
					paddle1_y_pos := SCREEN_WIDTH/2;  			
					paddle2_y_pos := SCREEN_WIDTH/2; 
                    ball_x_dir := '1';  -- Reset direction
                    ball_y_dir := '1';  -- Reset direction 
					paddle1_y_dir := '1';
					paddle2_y_dir := '0';
                end if;	 	
				
				-- Check for collision paddle1 with top and bottom screen boundary (reset position and direction)
                if (paddle1_y_pos <= 0 or paddle1_y_pos >= SCREEN_HEIGHT - 1) then
					paddle1_y_dir := not paddle1_y_dir;
                end if;	
				
				-- Check for collision paddle2 with top and bottom screen boundary (reset position and direction)
                if (paddle2_y_pos <= 0 or paddle2_y_pos >= SCREEN_HEIGHT - 1) then
					paddle2_y_dir := not paddle2_y_dir;
                end if;	
			ball_x <= ball_x_pos;
	        ball_y <= ball_y_pos;	  
			paddle1_y <= paddle1_y_pos;
			paddle2_y <= paddle2_y_pos;
            end if;	
        end if;	

    end process;
end behavioral;
   
