//paddle init
@12000
D=A

@delay
M=D

@15
D=A

@position	//initial position in the middle
M=D

@2
D=A

@padlength	//length of paddle
M=D

@15
D=A

@balength	//width of ball
M=D

@8096
D=A

@startrow
M=D

@7584
D=A

@bottomline	//detects using the top row of ball
M=D 

@ballheight
M=0

@16
D=A

@ballpos	//column of ball
M=D

@ballspeed	//speed of ball
M=0

@ballcolor	//position to be colored in, detects whether ball is already created
M=0

@DRAW_PADDLE	//first runs the function that draws the paddle
0;JMP

(GAME_LOOP)	//resets delay to 12000
	@delay
	D=M

(DELAY_LOOP)
	D=D-1

	@DELAY_LOOP	//runs until 12000 becomes 0
	D;JGT

	@i
	M=0

(ERASE_BALL)	//erases the ball
	@ballpos
	D=M

	@ballheight
	D=D+M

	@SCREEN
	A=A+D
	M=0

	@i	//variable that checks if it runs over
	MD=M+1

	@balength
	D=D-M

	@ERASED
	D;JGT

	@32
	D=A

	@ballheight
	M=D+M

	@ERASE_BALL
	0;JMP

(ERASED)
	@480
	D=A

	@ballheight	//resets the height
	M=M-D

	@i	//resets it to 0
	M=0

	@ballspeed
	D=M

	@ballheight
	MD=M+D

	@TOP	//goes to top collide
	D;JLT

	@bottomline
	D=D-M

	@BOT	//goes to bottom collide
	D;JGT

	@DRAW_BALL
	0;JMP

(TOP)	//if the ball reaches the top
	@ballheight
	M=0

	@ballspeed	//changes speed to be - of - speed, so positive speed down the screen
	M=-M

	@DRAW_BALL
	0; JMP

(BOT)	//if the ball reaches the bottom, checks both paddle and screen
	@position
	D=M

	@ballpos
	D=M-D

	@GAME_OVER	//if the paddle doesn’t catch
	D;JLT

	@15
	D=D-A

	@GAME_OVER
	D;JGT

	@bottomline
	D=M

	@ballheight
	M=D

	@ballspeed
	M=-M

(DRAW_BALL)	//draw the ball
	@ballpos
	D=M

	@ballheight
	D=D+M

	@SCREEN	//saves the position in D
	D=A+D

	@drawad	//resets memory to D
	M=D

	@ballcolor
	D=M

	@drawad
	A=M	//physically colors in position on screen
	M=D

	@i	//increments by 1
	MD=M+1

	@balength	//checks if it runs over
	D=D-M

	@DREW
	D;JGT

	@32
	D=A

	@ballheight
	M=D+M

	@DRAW_BALL
	0;JMP

(DREW)
	@480
	D=A

	@ballheight	//resets the height
	M=M-D

	@KBD	//takes keyboard input
	D=M

	@input
	M=D

	@CHANGE_POSITION	//goes to paddle movements only if there is an input
	D;JNE

	@GAME_LOOP
	0;JMP

(CHANGE_POSITION)
	@130
	D=D-A

	@LEFT	//goes left
	D;JEQ

	@input
	D=M

	@132
	D=D-A

	@RIGHT	//goes right
	D;JEQ

	@input
	D=M

	@133
	D=D-A

	@DOWN
	D;JEQ

	@GAME_LOOP
	0;JMP

(LEFT)
	@move	//sets move to -1 so it moves left
	M=-1

	@EVALUATE
	0;JMP

(RIGHT)
	@move	//sets move to +1 so it moves right
	M=1

	@EVALUATE
	0;JMP

(DOWN)
	@ballcolor	//if a ball is already created then back to Game Loop
	D=M

	@GAME_LOOP
	D;JNE

	@ballcolor	//this part only runs if ball has not been created
	M=-1

	@96
	D=A

	@ballspeed	//speed of ball = 3 rows
	M=D

	@GAME_LOOP
	0;JMP

(EVALUATE)
	@position
	D=M

	@move	//moves either left or right by 1 bit
	MD=D+M

	@GAME_LOOP	//if paddle is at far left goes back to game loop
	D;JLT

	@29
	D=D-A

	@GAME_LOOP	//if paddle is at far right goes back to game loop
	D;JGT

(ERASE_PADDLE)	//erases the entire paddle
	@startrow
	D=M

	@position
	D=D+M

	@leftbound
	M=D

	@padlength
	D=D+M

	@rightbound
	M=D

(ERASE)	//erases bits within the row
	@rightbound
	D=M

	@SCREEN
	A=A+D
	M=0	//sets it back to white
	D=D-1
 
	@rightbound	//one less
	M=D

	@leftbound
	D=D-M

	@ERASE
	D;JGE

	@32
	D=A

	@startrow	//increments start row by a layer
	MD=M+D

	@8160
	D=D-A

	@ERASE_PADDLE	//if runs over, goes back to Erase Paddle to iterate 1 over
	D;JLE

	@8096
	D=A

	@startrow
	M=D

	@move
	D=M

	@position
	M=D

(DRAW_PADDLE)	//same idea as Erase Paddle
	@startrow
	D=M

	@position
	D=D+M

	@leftbound
	M=D

	@padlength
	D=D+M

	@rightbound
	M=D

(DRAW)	//same idea as Erase
	@rightbound
	D=M

	@SCREEN
	A=A+D
	M=-1
	D=D-1 

	@rightbound	//top right corner
	M=D

	@leftbound	//top left corner
	D=D-M

	@DRAW
	D;JGE

	@32
	D=A

	@startrow
	MD=M+D

	@8160
	D=D-A

	@DRAW_PADDLE
	D;JLE

	@8096
	D=A

	@startrow
	M=D

	@GAME_LOOP
	0;JMP

(GAME_OVER)	//infinite loop
	@GAME_OVER
	0;JMP
