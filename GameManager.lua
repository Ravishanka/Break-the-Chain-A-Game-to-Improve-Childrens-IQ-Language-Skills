

local director = require("director")
ui = require( "ui" )

require "UIFactory"
require "PuzzleFactory"

GameManager ={};

local currentUI 
isMuteVal =false;

buttonFactory =ButtonFactory:new();
loadingUiFactory =LoadingUIFactory:new();
gamelevelButtonFactory=GameLevelButtonFactory:new()
gameLevelMenuFactory =GameLevelMenuFactory:new()
soundManger = SoundLoader:new();
puzzleUIfactory =PuzzleUIFactory:new();
pzzleFactory = PuzzleFactory:new();
gameUIFactory=GameUIFactory:new();
gameLostViewFactory=GameLostViewFactory:new();
gameWinViewFactory =GameWinViewFactory:new();
mainGroup =nil
gameActive =false;
gamescore =0
local scoreText 
local stars =0
local score =0
local level =0;
function GameManager:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	return obj
end

function GameManager:init()
	display.setStatusBar( display.HiddenStatusBar )


	local oldRemove = display.remove
	display.remove = function( o )
		if o ~= nil then

			Runtime:removeEventListener( "enterFrame", o )
			oldRemove( o )
			o = nil
		end
	end

	mainGroup = display.newGroup();
	mainGroup:insert(director.directorView);
	loadingUI_ =loadingUiFactory:CreateUI("loading.png",640,960)
	loadingUI_:changeScreen();

end

function GameManager:gameStart(levelno)
			
	
		physics = require("physics")
		physics.start()
		physics.setGravity( 0, 9.8) 
		physics.setScale(70) 
		stars=0
		gameActive=true
		level =levelno
		gameUIFactory:CreateUI(pzzleFactory:createPuzzle(levelno))
	
end

function GameManager:gameFinish(win)

		--display.remove(currentUI)
		--physics.stop()
	
		if(win ==true) then
	
		gameMgr:scoreInc(50*level)
		fileIO:saveFile("levelinfo"..".data",level);
		fileIO:saveFile("level"..level..".data",score);
		fileIO:saveFile("level"..level.."stars.data",stars);
			gameWinViewFactory:CreateUI()
		else
			gameLostViewFactory:CreateUI()
		end
end

function GameManager:gamePause()
physics.pause()
end

function GameManager:gameResume()
physics.start()
end


function GameManager:scoreInc(val)
	score = score +val
end

function GameManager:scoreReset()

end


function GameManager:stop()

end

function GameManager:isMute()
return isMuteVal;
end

function GameManager:setMute(muteVal)
 isMuteVal =muteVal;
end


function GameManager:isGameActive()
return gameActive;
end

function GameManager:setGameActive(active)
	if active ==true then
		physics.start()
	else
		physics.pause()
	end
 gameActive =active;
end

function GameManager:setCurrentUI(ui)
	--cleanGroups(currentUI)	
	
	display.remove(currentUI)
	currentUI =ui

end

function GameManager:starImpact()

	stars = stars +1;
	local strs = display.newImage( "star_gained_"..stars..".png" ,178,55 )
	strs.x = 100; strs.y = 40;
	score = score +10*stars*level ;
	
	-- if scoreText ~=nil then
		-- display.remove(scoreText)
	-- end
		-- display.remove(scoreText)
		-- scoreText = display.newText( score, 0, 0, "PermanentMarker", 40)
		-- scoreText:setTextColor( 255 )
		-- scoreText.x = 320; scoreText.y = 45;
		-- currentUI:insert(scoreText)

	--gameMgr:scoreUpdate(score)
	
    currentUI:insert(strs)
end

function GameManager:scoreUpdate(val)
	
		--gameMgr:scoreInc(val)
	--if scoreText ~=nil then
	--print(score)

	--end
end

function GameManager:getScore()
	return score;
end

function GameManager:setScore(scr)
	score =scr ;
end

function GameManager:getStars()
	return stars;
end

function GameManager:getLevel()
	return level;
end

function GameManager:setScoreText(text)

	 scoreText =text;
	-- currentUI:insert(scoreText)
end
function GameManager:setStarText(bonusStars)
	--currentUI:insert(bonusStars)
end
function GameManager:test()

end
