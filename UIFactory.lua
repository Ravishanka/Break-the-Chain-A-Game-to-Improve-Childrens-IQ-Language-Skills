
require "UIEntity"
require "IO"
require "SoundLoader"
require "Model"
require "wordgame"

local director = require("director")

ui = require( "ui" )

-- UIFactory Class----------------------------------------------------------

UIFactory ={};

function UIFactory:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	return obj
end

function wordgame:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	return obj
end


function UIFactory:CreateUI(image,x,y)



end

-- UIFactory Class End----------------------------------------------------------


-- LoadingUIFactory Class ----------------------------------------------------------

LoadingUIFactory = UIFactory:new();
wordgamepuzzle=wordgame:new()


function LoadingUIFactory:CreateUI(image,x,y)
	local localGroup = display.newGroup()
	loadingUI =LoadingUI:create();


	loadingImage =display.newImage( image, x, y)
	loadingImage.x = display.contentWidth / 2
	loadingImage.y = display.contentHeight / 2

	loadingUI:setEntity(loadingImage);
	clean = function()

		if loadingImage then

			display.remove( loadingImage )
			loadingImage = nil
		end
	end
	--gameMgr:setCurrentUI(loadingUI);
	return loadingUI;
end
-- LoadingUIFactory Class End----------------------------------------------------------


-- ButtonFactory Class ----------------------------------------------------------

ButtonFactory = UIFactory:new();


function ButtonFactory:CreateUI(image,x,y,id_,sizeX,sizeY,size,onClickFuncPtr,onClickedImg)
		buttonUI=ButtonUI:create()

		btn = ui.newButton{
					defaultSrc = image,
					defaultX = sizeX,
					defaultY = sizeY,
					overSrc = onClickedImg,
					overX =sizeX,
					overY =sizeY,
					onEvent = onClickFuncPtr,
					id = id_,
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = size,
					emboss = false
				}
		btn.x =x btn.y = y;
		buttonUI:setEntity(btn);

		buttonUI:setID(id_)
		return buttonUI;
end
-- ButtonFactory Class End----------------------------------------------------------

-- GameLevelButtonFactory Class ----------------------------------------------------------

GameLevelButtonFactory = UIFactory:new();


function GameLevelButtonFactory:CreateUI(x,y,levelVal)
		gamebuttonUI=GameMenuButtonUI:create()

		local onButtonClick = function( event )

			if event.phase == "release" then
				soundManger:playTap();
				gameMgr:gameStart(event.id)
			end

		end

		fileIO = IO:new();
		local bottomImage;
		local scoreText="";
		local starValImg="";
		local entity;
		local level___ = fileIO:readFile("levelinfo"..".data");
	
		--if (level___ ~= nil and level___ >= levelVal) or levelVal==1 then
		if true then
			button=buttonFactory:CreateUI("level"..levelVal.."btn.png",x,y,levelVal,41,50,nil,onButtonClick,"level"..levelVal.."btn.png");

			gamebuttonUI:setButton(button);
			gamebuttonUI:setID(levelVal);
			
	
			
		local onButtonClick_ = function( event )

			if event.phase == "ended" then
				soundManger:playTap();
				gameMgr:gameStart(levelVal)
			end
		
		end
			
			bottomImage = display.newImageRect( "current_level_blank.png", 107, 109 );
			bottomImage.id=levelVal;
			
			bottomImage:addEventListener("touch", onButtonClick_)
			
			
			local score=fileIO:readFile("level"..levelVal..".data");
					if score == nil then
						score=0;
					end
					gamescore =gamescore +score
					scoreText = display.newText( score, 0, 0, "PermanentMarker", 50)
					scoreText:setTextColor( 255 )
					scoreText.x = x; scoreText.y = y+90;
			local starVal = fileIO:readFile("level"..levelVal.."stars.data");
			
			if starVal == nil then
			starVal =0;
			end
			
			if starVal ~= 0 then
			print(starVal)
				if starVal == 1 then
					starValImg =display.newImageRect( "1stars_level.png", 130, 60 )
				elseif starVal ==2 then
					starValImg =display.newImageRect( "2stars_level.png", 130, 60 )
				else 
					starValImg =display.newImageRect( "3stars_level.png", 130, 60 )
				
				end
				starValImg.x = x+4; starValImg.y =y+50;
			end

		else
			 bottomImage = display.newImageRect( "lock.png", 107, 109 )

		end

			bottomImage.x = x; bottomImage.y =y;

			gamebuttonUI:setImage(bottomImage);
			gamebuttonUI:setScore(scoreText);
			gamebuttonUI:setStar(starValImg);
			return gamebuttonUI;

end
-- GameLevelButtonFactory Class End----------------------------------------------------------


-- GameLevelMenuFactory Class ----------------------------------------------------------

GameLevelMenuFactory = UIFactory:new();

function GameLevelMenuFactory:CreateUI(image,x,y,menuSetNo)
	menuGroup = display.newGroup();
	soundManger:playTap();

	menu=MenuUI:create()

	backgroundImage =display.newRect( 0, 0, x, y )
	backgroundImage.x = display.contentWidth / 2
	backgroundImage.y = display.contentHeight / 2
	menuGroup:insert( backgroundImage )

	local shadeRect = display.newRect( 0, 0, x, y )
	shadeRect:setFillColor( 0, 0, 0, 255 )
	shadeRect.alpha = 0
	menuGroup:insert( shadeRect )
	transition.to( shadeRect, { time=100, alpha=0.85 } )

	local levelSelectionBg = display.newImageRect( image, x, y )
	levelSelectionBg.x = x/2; levelSelectionBg.y =y/2
	levelSelectionBg.isVisible = false
	menuGroup:insert( levelSelectionBg )
	timer.performWithDelay( 200, function() levelSelectionBg.isVisible = true; end, 1 )

	for i = menuSetNo*2-2 +1, menuSetNo*6 do
		levelNumber = i- (menuSetNo -1)*2
		x_ =((i-1)%2)*300 +150;
		y_ =(((i-1)-(i-1)%2)/2)*200 +100;
		
		gamelevelBtn = gamelevelButtonFactory:CreateUI(x_,y_,i);
		menuGroup:insert( gamelevelBtn:getImage());
		score_ =gamelevelBtn:getScore();

		if score_ ~= "" and score_ ~= nil  then
			menuGroup:insert( score_);
		end

		gmBtn =gamelevelBtn:getButton();

		if gmBtn ~= "" and gmBtn ~= nil  then
			btn =gmBtn:getEntity();
			btn.isActive =true;
			menuGroup:insert( btn);
		end
	end
	
	--gameMgr:setScore(gamescore)
	local nextLevelSetbutton
	local closeBtn
	local helpBtn
	local muteBtn
	local unMuteBtn
	local creditBtn
	local onButtonClick = function(event )
			if event.phase == "release" then

				soundManger:playTap();

				if event.id =="closeBtn" then
					closeBtn:changeScreen()
				elseif event.id =="nextLevelSetBtn" then
					nextLevelSetbutton:changeScreen()
				elseif event.id =="helpBtn" then
					helpBtn:changeScreen()
				elseif event.id =="creditBtn" then
					creditBtn:changeScreen()
				elseif event.id =="muteBtn" then
					muteBtn:getEntity().isVisible=false;
					unMuteBtn:getEntity().isVisible=true;
					gameMgr:setMute(true)
					muteBtn:changeScreen()
				elseif event.id =="unMuteBtn" then
					unMuteBtn:getEntity().isVisible=false;
					muteBtn:getEntity().isVisible=true;
					gameMgr:setMute(false)
					unMuteBtn:changeScreen()
				else
				end
			end

	end

	 closeBtn=buttonFactory:CreateUI("closebtn.png",75,875,"closeBtn",118,118,16,onButtonClick,"exit_pressed.png");
	 menuGroup:insert( closeBtn:getEntity());

	 nextLevelSetbutton=buttonFactory:CreateUI("next.png",320,775,"nextLevelSetBtn",118,118,16,onButtonClick,"next_pressed.png");
	 menuGroup:insert( nextLevelSetbutton:getEntity());

	 
	 helpBtn=buttonFactory:CreateUI("faq.png",225,875,"helpBtn",118,118,16,onButtonClick,"faq_pressed.png");
	 menuGroup:insert( helpBtn:getEntity());

	 creditBtn=buttonFactory:CreateUI("credit.png",375,875,"creditBtn",118,118,16,onButtonClick,"credits_pressed.png");
	 menuGroup:insert( creditBtn:getEntity());

	 
	 muteBtn=buttonFactory:CreateUI("volume_off.png",525,875,"muteBtn",118,118,16,onButtonClick,"volume_pressed.png");
	 menuGroup:insert( muteBtn:getEntity());
	 
	 
	 unMuteBtn=buttonFactory:CreateUI("volume.png",525,875,"unMuteBtn",118,118,16,onButtonClick,"volume_pressed.png");
	 menuGroup:insert( unMuteBtn:getEntity());
	
	if gameMgr:isMute() == false then
		unMuteBtn:getEntity().isVisible =false;
	else
		muteBtn:getEntity().isVisible =false;
	end

	 menu:setEntity(menuGroup);
	 gameMgr:setCurrentUI(menuGroup);
return 	menuGroup;
end
-- GameLevelMenuFactory Class End----------------------------------------------------------

-- PuzzleUIFactory Class ----------------------------------------------------------

PuzzleUIFactory = UIFactory:new{puzzle =""};

function PuzzleUIFactory:CreateUI(puzzle_)
	pzzleUI = PuzzleViewUI:create()
	puzzle =puzzle_;


	local numberOfchains
	for i=1,#puzzle_ do

		objects=puzzle_[i][2]
		if puzzle_[i][1].name == "chains"  then
		else
			for j =1,#objects do
				print(puzzle_[i][1].name)
				puzzleGroup:insert( objects[j]:getBody());
			end
		end
	end


	--pzzleUI =pzzleUI:setEntity(puzzleGroup);

	return puzzleGroup ;

end
-- PuzzleUIFactory Class End----------------------------------------------------------


-- GameUIFactory Class ----------------------------------------------------------

GameUIFactory = UIFactory:new();

function GameUIFactory:CreateUI(puzzle_)
	gameUI = GameUI:create();
	
	
	
	gameGroup = display.newGroup();
	
	local score
	local backGround;
	local homBtn
	local bonusStars
	
	
		gameGroup:insert( puzzle_ )
		
		bonusStars = display.newImage( "stars_gained_blank.png" ,178,55 )
		bonusStars.x = 100; bonusStars.y = 40;
		gameGroup:insert(bonusStars)
		--gameMgr:setStarText(bonusStars)
		
		-- scoreText = display.newText(gameMgr:getScore(), 0, 0, "PermanentMarker", 40)
		-- scoreText:setTextColor( 255 )
		-- scoreText.x = 320; scoreText.y = 45;
		-- gameGroup:insert(scoreText)
		--gameMgr:setScoreText(scoreText)
		--gameGroup:insert(scoreText)
			local onButtonClick = function( event )
			if event.phase == "release" then
				gameMgr:gamePause();
								local shadeRect1 = display.newRect( 0, 0, 640, 960 );
								shadeRect1:setFillColor( 0, 0, 0, 255 );
								shadeRect1.alpha = 0;
								shadeRect1:addEventListener("touch", function() return true end)
								shadeRect1:addEventListener("tap", function() return true end)
								gameGroup:insert( shadeRect1 );
								transition.to( shadeRect1, { time=100, alpha=0.85 } );	
				local onComplete = function ( event )
						if "clicked" == event.action then
							if(shadeRect1 ~=nil) then
								gameGroup:remove(shadeRect1);
							end
							local i = event.index
							if i == 1 then
								
							elseif i == 2 then
								
								gameLevelMenuFactory:CreateUI("levelselection.png",640,960,1);
							end
						end
						if(shadeRect1 ~= nil) then
							gameGroup:remove(shadeRect1);
						end
						gameMgr:gameResume();
						
					end
						local alert = native.showAlert( "Break The Chain", "Your current game will stop..!!!", 
														{ "No", "Yes" }, onComplete )
				end
			end
				
				-- Show alert with two buttons
	  

	homBtn =buttonFactory:CreateUI("backtohome.png",600,40,"homeBtn",70,70,16,onButtonClick,"backtohome_pressed.png");
	gameGroup:insert( homBtn:getEntity());
	--gameMgr:setCurrentUI(gameGroup)
	
	
	
			local onResetButtonClick = function( event )
				if event.phase == "release" then
					gameMgr:gamePause();
					local shadeRect2 = display.newRect( 0, 0, 640, 960 );
								shadeRect2:setFillColor( 0, 0, 0, 255 );
								shadeRect2.alpha = 0;
								shadeRect2:addEventListener("touch", function() return true end)
								shadeRect2:addEventListener("tap", function() return true end)
								gameGroup:insert( shadeRect2 );
								transition.to( shadeRect2, { time=100, alpha=0.85 } );
								
					local onResetComplete = function ( event )
						if "clicked" == event.action then
								if(shadeRect2 ~=nil) then
									gameGroup:remove(shadeRect2);
								end
								print("Game no "..gameMgr:getLevel());
								soundManger:playTap();
								gameMgr:gameStart(gameMgr:getLevel())	;
							
						end
							if(shadeRect2 ~=nil) then
								gameGroup:remove(shadeRect2);
							end
						gameMgr:gameResume();
					end
						
						local alert = native.showAlert( "Break The Chain", "Your' game will be restarted.!!!", 
														{ "No", "Yes" }, onResetComplete )
								
				end
			end
				
				-- Show alert with two buttons
	  
restBtn =buttonFactory:CreateUI("retry.png",515,40,"homeBtn",70,70,16,onResetButtonClick,"retry_pressed.png");
	gameGroup:insert( restBtn:getEntity());
	
	
	
	gameMgr:setCurrentUI(gameGroup)	
	
	
	
	return gameGroup ;

end
-- GameUIFactory Class End----------------------------------------------------------


-- PuzzleUIFactory Class End----------------------------------------------------------


-- GameLostViewFactory Class ----------------------------------------------------------

GameLostViewFactory = UIFactory:new();

function GameLostViewFactory:CreateUI()
	
	
	local gamelostGroup = display.newGroup();
	
		local bck=display.newImageRect( "bkg_bricks.png", 640,960 );
		bck.x = display.contentWidth / 2
		bck.y = display.contentHeight / 2
		gamelostGroup:insert(bck)
		
		local gameLost =display.newImage( "lost_bg.png", 640, 960 )
		gameLost.x = 320
		gameLost.y = 480
		gamelostGroup:insert(gameLost)

		local lostfaceimage = display.newImage( "lost-face.png", 130, 131 )
		lostfaceimage.x =325;lostfaceimage.y = 600
		gamelostGroup:insert( lostfaceimage )
		
		local gameOverDisplay = display.newImageRect( "youlost.png", 448, 93 )
		gameOverDisplay.x = 340; gameOverDisplay.y = 200
		gamelostGroup:insert(gameOverDisplay)
		
		local scoreTextGameOver = display.newText( gamescore, 0, 0, "PermanentMarker", 100)
		scoreTextGameOver:setTextColor( 245 )
		scoreTextGameOver.x = 320; scoreTextGameOver.y = 450; 
		gamelostGroup:insert(scoreTextGameOver)
		
		if gameMgr:getStars() ~= 0 then
		local starOnegameOver = display.newImage( gameMgr:getStars().."stars.png" ,387,166 )
		starOnegameOver.x = 320; starOnegameOver.y = 315;
		gamelostGroup:insert(starOnegameOver)
		end
		
		local onRestartBtnClick= function (event)
				if event.phase == "release" then
				soundManger:playTap()
				gameMgr:gameStart(gameMgr:getLevel())
			end
		end
		restartBtn=buttonFactory:CreateUI("restartbtn.png",400,750,"restartBtn",144,143,16,onRestartBtnClick,"retry_pressed.png");
		gamelostGroup:insert( restartBtn:getEntity());

		local onHomeBtnClick= function (event)
			if event.phase == "release" then
				soundManger:playTap()
				gameLevelMenuFactory:CreateUI("levelselection.png",640,960,1);
			end
		end
		homeBtn=buttonFactory:CreateUI("menubtn.png",250,750,"homeBtn",144,143,16,onHomeBtnClick,"menubtn.png");
		gamelostGroup:insert(homeBtn:getEntity());
		
	gameMgr:setCurrentUI(gamelostGroup)
	return gamelostGroup ;

end
-- GameLostViewFactory Class End----------------------------------------------------------

-- GameWinViewFactory Class ----------------------------------------------------------

GameWinViewFactory = UIFactory:new();

function gotoHome()
	soundManger:playTap()
	gameLevelMenuFactory:CreateUI("levelselection.png",640,960,1);
end

function GameWinViewFactory:CreateUI()
	
	
	local gameWinGroup = display.newGroup();
	
		local bck=display.newImageRect( "bkg_bricks.png", 640,960 );
		bck.x = display.contentWidth / 2
		bck.y = display.contentHeight / 2
		gameWinGroup:insert(bck)
		
		local gameLost =display.newImage( "lost_bg.png", 640, 960 )
		gameLost.x = 320
		gameLost.y = 480
		gameWinGroup:insert(gameLost)


		
		local gameOverDisplay = display.newImageRect( "youwin.png", 448, 93 )
		gameOverDisplay.x = 340; gameOverDisplay.y = 300
		gameWinGroup:insert(gameOverDisplay)
		
		local scoreTextGameOver = display.newText( gameMgr:getScore(), 0, 0, "PermanentMarker", 100)
		scoreTextGameOver:setTextColor( 245 )
		scoreTextGameOver.x = 320; scoreTextGameOver.y = 700; 
		gameWinGroup:insert(scoreTextGameOver)
		
		if gameMgr:getStars() ~= 0 then
		local starOnegameOver = display.newImage( gameMgr:getStars().."stars.png" ,387,166 )
		starOnegameOver.x = 320; starOnegameOver.y = 500;
		gameWinGroup:insert(starOnegameOver)
		end
		
		local onRestartBtnClick= function (event)
				if event.phase == "release" then
				soundManger:playTap()
				gameMgr:gameStart(gameMgr:getLevel())
			end
		end
		restartBtn=buttonFactory:CreateUI("restartbtn.png",330,880,"restartBtn",144,143,12,onRestartBtnClick,"retry_pressed.png");
		gameWinGroup:insert( restartBtn:getEntity());

		local onHomeBtnClick= function (event)
			if event.phase == "release" then
				gotoHome()
			end
		end
		homeBtn=buttonFactory:CreateUI("menubtn.png",180,880,"homeBtn",144,143,16,onHomeBtnClick,"menubtn.png");
		gameWinGroup:insert(homeBtn:getEntity());
		
		
		local onNextBtnClick= function (event)
			if event.phase == "release" and gameMgr:getLevel() ~= 6 then
				soundManger:playTap()
				--gameMgr:gameStart(gameMgr:getLevel()+1)
				wordgamepuzzle:setup(gotoHome)
			end
		end
		nxtBtn=buttonFactory:CreateUI("nextlevelbtn.png",480,880,"nxtBtn",144,143,16,onNextBtnClick,"next_level_pressed.png");
		gameWinGroup:insert(nxtBtn:getEntity());
		
	
		
		
		
	gameMgr:setCurrentUI(gameWinGroup)
	return gameWinGroup ;

end
-- GameWinViewFactory Class End-----------------------------------------------