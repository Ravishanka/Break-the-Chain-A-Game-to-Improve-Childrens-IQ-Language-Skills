SoundLoader ={};

local tapSound = audio.loadSound( "tapsound.wav" )
local starImpactSound = audio.loadSound( "blastoff.wav" )
local swipeSound = audio.loadSound( "impact.wav" )
local newRoundSound = audio.loadSound( "newround.wav" )
local youWinSound = audio.loadSound( "youwin.wav" )
local youLoseSound = audio.loadSound( "youlose.wav" )

function SoundLoader:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	return obj
end

function SoundLoader:playTap()
	if gameMgr:isMute() == false then
		audio.play( tapSound );
	end
end

function SoundLoader:playImpact()
	if gameMgr:isMute() == false then
		audio.play( starImpactSound );
	end
end

function SoundLoader:playSwipe()
	if gameMgr:isMute() == false then
		audio.play( swipeSound );
	end
end

function SoundLoader:playnewRound()
	if gameMgr:isMute() == false then
		audio.play( newRoundSound );
	end
end

function SoundLoader:playWin()
	if gameMgr:isMute() == false then
		audio.play( youWinSound );
	end
end

function SoundLoader:playLose()
	if gameMgr:isMute() == false then
		audio.play( youLoseSound );
	end
end