


-- UIEntity Class----------------------------------------------------------

UIEntity ={entity=""};

function UIEntity:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	
	return obj;
end


function UIEntity:changeScreen()

end

function UIEntity:create()

end

function UIEntity:destroy()

	-- if self.entity ~= nil then
	
		-- if self.entity then
			--levelGroup:removeSelf()
			-- display.remove( self.entity )
			-- self.entity = nil
		-- end
	-- end
	--display.remove( self.entity )
	
		local removeEntity = function()
		display.remove( self.entity )
	end
	
	timer.performWithDelay( 1000000, removeEntity, 1 )
	
	self=nil;
end

function UIEntity:setEntity(entity_)
ent =self;
ent.entity =entity_;

end

function UIEntity:getEntity()
return self.entity;
end
-- UIEntity Class End------------------------------------------------------


-- LoadingUI Class --------------------------------------------------------

LoadingUI = UIEntity:new();


function LoadingUI:changeScreen()
	
	local loadMainMenu = function()
		gameLevelMenuFactory:CreateUI("levelselection.png",640,960,1);
	end
	
	timer.performWithDelay( 1000, loadMainMenu, 1 )
	--display.remove( self.entity )
end

function LoadingUI:create()
	
	loadingUI = LoadingUI:new()
	
	return loadingUI;

end


-- LoadingUI Class End------------------------------------------------------


-- ButtonUI Class --------------------------------------------------------

ButtonUI = UIEntity:new{id=""};


function ButtonUI:changeScreen()
	ent =self;
		if self.id== "muteBtn" then
			gameMgr:setMute(true)
		elseif self.id == "unMuteBtn" then
			gameMgr:setMute(false)
		elseif self.id == "closeBtn" then
			local function onPopUpClicked( event )
				alert.toFront();
				if "clicked" == event.action then
					if event.index==2 then
						os.exit() ;
					end
				end
			end
			local alert = native.showAlert( "Break The Chain", "Are you sure that you want to exit?", 
																{ "No", "Yes" }, onPopUpClicked );
		else
		end
end

function ButtonUI:create()
	buttonUI = ButtonUI:new()
	return buttonUI;
end

function ButtonUI:setID(id_)
--print(id_);
self.id =id_;

end

function ButtonUI:getID()
return self.id;
end
-- ButtonUI Class End------------------------------------------------------



-- GameButtonUI Class --------------------------------------------------------

GameMenuButtonUI = ButtonUI:new{button="", image="",score="",id=0,starsGained=""};

function GameMenuButtonUI:changeScreen()
	entity =self;

	gameMgr:gameStart(self.id)
end

function GameMenuButtonUI:create()
	GameMenuButtonUI = GameMenuButtonUI:new()
	return GameMenuButtonUI;
end

function GameMenuButtonUI:setButton(button_)
self.button =button_;

end

function GameMenuButtonUI:getButton()
return self.button;
end


function GameMenuButtonUI:getImage()
return self.image;
end

function GameMenuButtonUI:setImage(image_)
self.image =image_;

end


function GameMenuButtonUI:setScore(Score_)
self.score =Score_;

end

function GameMenuButtonUI:getScore()
return self.score;
end

function GameMenuButtonUI:setStar(star_)
self.starsGained =star_;

end

function GameMenuButtonUI:getStar()
return self.starsGained;
end

function GameMenuButtonUI:setID(id_)

self.id =id_;

end

function GameMenuButtonUI:getID()
return self.id;
end

-- GameButtonUI Class End------------------------------------------------------

-- MenuUI Class --------------------------------------------------------

MenuUI = UIEntity:new();

function MenuUI:create()
	
	MenuUI_ = MenuUI:new()
	return MenuUI_;

end

-- LoadingUI Class End------------------------------------------------------


-- PuzzleViewUI Class --------------------------------------------------------

PuzzleViewUI = UIEntity:new();

function PuzzleViewUI:create()
	
	puzzle = PuzzleViewUI:new()
	return puzzle;

end

-- PuzzleViewUI Class End------------------------------------------------------

-- GameUI Class --------------------------------------------------------

GameUI = UIEntity:new();

function GameUI:create()
	
	game = GameUI:new()
	return game;

end

-- GameUI Class End------------------------------------------------------