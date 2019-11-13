require("physics");
display.setStatusBar(display.HiddenStatusBar);


local theWord = "";
local theWordText ={};
local isNewGame = true
local scoreText ={}
local allBallsGroup
local wordTable = {}
local chosenBalls = {}
local instructionsText ={}
local countDownText = {}
local numBallsToGenerate = 10
local allBalls = {}
local theBombs = {}
local generateBallTimer
local clockTimer
local gameTime = 10
local gotoHomeFuncPtr = {}
wordgame = {};
local gameOver = false;
local groundLine = {}
local lineLeft ={}
local lineRight = {}

function wordgame:new(obj)
	
	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	return obj
end

function wordgame:setup(gotoHomeFunctionPtr)
	gotoHomeFuncPtr = gotoHomeFunctionPtr;
	math.randomseed(os.time());
	setupGameAssets()
	newGame()
end

function newGame()
    gameOver = false;
	isNewGame = true
	chosenBalls = {}
	allBalls = {}
	theWord = ""
	theWordText.text = ""
	instructionsText.text = ""
	countDownText.text = gameTime;
	createVowelBalls(2)
	generateBalls()
    startTimer()
    isNewGame = false
    setBombsVisible();
end

function setupGameBoundaries() 
	local gameBackground = display.newImage("bkg_bricks.png",true);
	gameBackground.x = display.contentWidth / 2
		gameBackground.y = display.contentHeight / 2


groundLine = display.newRect(0, 820,display.contentWidth, 2);
 lineLeft = display.newRect(-29,0,2,display.contentHeight);
 lineRight = display.newRect(display.contentWidth-29,0,2,display.contentHeight)
physics.addBody(groundLine, 'static',{bounce=0,friction=0})
physics.addBody(lineLeft, 'static',{bounce=0,friction=0});
physics.addBody(lineRight,'static',{bounce=0,friction=0});
groundLine.isVisible = false;
lineLeft.isVisible = false;
lineRight.isVisible = false;	
end

function setupButtons()
	local goButton = display.newImage("next_1.png",530,830);
	goButton:addEventListener('tap', checkWord);
	local stopButton = display.newImage("closebtn.png",5,840);
	stopButton:addEventListener('tap',resetWord)
	local bar = display.newImage("raod1.png",0,100);
	
end

function setupTextFields()
	countDownText = display.newText(gameTime,550,10,native.systemFontBold,40)
	countDownText:setTextColor(255, 255, 255, 255 )
	theWordText = display.newText("",60,890,native.systemFontBold,50)
	theWordText:setTextColor(255, 255, 255, 255 );
	instructionsText = display.newText("",0,0,native.systemFontBold,25)
	instructionsText.x = display.contentWidth/2;
	instructionsText.y = display.contentHeight/2;
	instructionsText:setTextColor(255, 255, 255, 255 );
	
end
function setupGameAssets()
	readTextFile()
	setupGameBoundaries()
	setupButtons()
	setupTextFields()
	setupBombs()
	allBallsGroup = display.newGroup();

end
function setupBombs()
	     for i=1, 3 do
		 local tempBomb = display.newImage("bomb.png")
		tempBomb.width = 50
		tempBomb.height = 50
		tempBomb.x =  33 * i
		tempBomb.y = 20
	    tempBomb:addEventListener('tap', explode)
	    table.insert(theBombs,tempBomb)
	end
end

function setBombsVisible()
	for i=1, #theBombs do
	theBombs[i].isVisible = true;
	end
end

function setBombsInvisible()
	for i=1, #theBombs do
	theBombs[i].isVisible = false;
	end
end
function generateBalls()
	timer.performWithDelay(1500,checkGameOver)
	if(isNewGame == true) then
		numBallsToGenerate = 10
	else
		numBallsToGenerate = 2
		--createVowelBalls(1)
	end
	
	generateBallTimer = timer.performWithDelay( 50, createBall, numBallsToGenerate)
end

function startTimer()
	clockTimer = timer.performWithDelay(1500,doCountdown,gameTime)
end

function doCountdown()
   
	local currentTime = countDownText.text
	currentTime = currentTime -1
	countDownText.text = currentTime
	 if(currentTime == 0) then
		generateBalls()
		countDownText.text = gameTime
		startTimer()
	end
	
end
function createBall(createVowel)
	local var alphabetArray = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
	local vowels = {"A","E","I","O","U"}
	local ballType = math.random(4);
	local ballSize = math.random(2)
	local letterIndex
	local letter 
	if(createVowel == true) then
	   letterIndex = math.random(#vowels)
	   letter = vowels[letterIndex];
	else
	 letterIndex = math.random(#alphabetArray);
	 letter = alphabetArray[letterIndex];
	end
	
	local ballGroup = display.newGroup();
	local ball
	local ballRadius
	if(ballType == 1) then
		 ball = display.newImage("greenBall.png");
	elseif(ballType == 2) then
	     ball = display.newImage("brownBall.png");
	elseif(ballType == 3) then
	     ball = display.newImage("pinkBall.png");
	else
	     ball = display.newImage("redBall.png");
	end
	if(ballSize == 1)then
		ball.width  = 116;
		ball.height = 116;
		ballRadius = 58;
	else
	    ball.width = 116;
	    ball.height = 116;
	    ballRadius = 58
	end
	
	local letterText = display.newText( letter, 0,0, native.systemFontBold, 25 );
	letterText:setTextColor(0,0, 0);
	letterText.x = ball.x;
	letterText.y = ball.y;
	ballGroup:insert(ball);
	ballGroup:insert(letterText);
	ballGroup.x = math.random(ballRadius,display.contentWidth-ballRadius*2);
	ballGroup.y= - 40;
   physics.addBody(ballGroup, 'dynamic',{friction = 0,bounce = 0,radius = ballRadius});
	ballGroup.name = "ball";
	ballGroup.letter = letter;
	ballGroup:addEventListener('tap',formString);
	table.insert(allBalls,ballGroup)
	allBallsGroup:insert(ballGroup)
	
end

function checkGameOver ()

	for i=1,#allBalls do
	    if(allBalls[i].y < (100 - allBalls[i].height))then
		      gameOver = true;
		      break;
	    end
	end
	if(gameOver) then
		for i=allBallsGroup.numChildren,1,-1 do
			 local child = allBallsGroup[i]
			  child:removeSelf()
			 child = nil;
		end
	timer.cancel(generateBallTimer)
	timer.cancel(clockTimer)
	instructionsText.text = "GameOver";
	instructionsText:toFront()
	setBombsInvisible()
	--timer.performWithDelay(3000,newGame);
	gotoHomeFuncPtr()
	groundLine:removeSelf()
	lineLeft:removeSelf()
	lineRight:removeSelf()
	end
end
function checkWord()
	if(#theWord <= 1) then
	    return;
	end
	local lowerCaseWord = string.lower(theWord)
	local tempBall
	 if(table.indexOf(wordTable,lowerCaseWord) == nil) then
	 	instructionsText.text = "NOT A WORD!";
	 	instructionsText:toFront()
	 else
	     
		 for i=1, #chosenBalls do
		 	table.remove(allBalls,table.indexOf(allBalls,chosenBalls[i]))
     	   chosenBalls[i]:removeSelf();
     	   chosenBalls[i] = nil;
     	   theWord = ""
     	   theWordText.text = ""
     	   
		 end
		 print (#allBalls)
	     chosenBalls = {}
	 end
end

function resetWord()
   instructionsText.text = "";
	theWord = ''
	theWordText.text = ""
	chosenBalls = {}
end
function createVowelBalls(number)
	for i=1, number do
		createBall(true)
		
	end
end
function formString(e)
	 local thisSprite = e.target
	 local theLetter = thisSprite.letter;
	 if(table.indexOf(chosenBalls,thisSprite) == nil) then
	 table.insert(chosenBalls,thisSprite);
	 theWord = theWord .. theLetter;
	 theWordText.text = theWord;
	 theWordText.x = display.contentWidth/2;
	 else
	 print("You already chose that ball silly");
	 end
end
 function explode(e)
 	local thisSprite = e.target
 	thisSprite.isVisible = false
 	local randomIndex
 	local randomBall
 	if(#allBalls < 5) then
 		for i=1, #allBalls do
 			removeBall()
 		end
 		else
 		for i=1, 5 do
 		removeBall()
 		end
 		end
 		print(#allBalls)
 end
 
 function removeBall()
 	local randomIndex = math.random(#allBalls)
 	local tempBall = allBalls[randomIndex]
 	tempBall:removeSelf()
 	tempBall = nil
 	table.remove(allBalls,randomIndex);
 end
 
function readTextFile()
local path = system.pathForFile( "wordlist.txt",  	system.ResourceDirectory)

local file = io.open( path, "r" )

for line in file:lines() do
	 line = string.sub(line, 
       1, #line - 1);
    table.insert(wordTable,line)
end
io.close( file )
file = nil
end

--setup()





