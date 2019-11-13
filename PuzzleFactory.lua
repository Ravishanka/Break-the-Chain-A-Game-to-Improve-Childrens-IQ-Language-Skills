
require "Model"

PuzzleFactory ={};


puzzleObjects ={}
			
	

function PuzzleFactory:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self

	return obj
end

function PuzzleFactory:addChain(chain)
	ent =self.puzzleObjects;
	chains_ = ent[5][1];
	chains_[#chains_] =chain;
end

function PuzzleFactory:createPuzzle(puzzleNo)
	
	puzzleObjects=nil

	
	puzzleGroup=display.newGroup();
	local onBallCollision
	local walls ={}	
	local baskets={}
	local triggers ={}
	local balls={}
	local stars ={}
	local ballons ={}
	local blocks ={}
	local chains ={}
	local pipes ={}
	local stones ={}
	local rods ={}
	local windArrows ={}
	
	local createWalls=function()
		
		walls[1]=Wall:create( display.newRect( -300, 960, 1000, 1005 ));
		walls[1]:setLength(760); walls[1]:setBreadth(50)  
		walls[2]=Wall:create(display.newRect( -300, -10, 1000, 0 ));
		walls[2]:setLength(760); walls[2]:setBreadth(10) 
	    walls[3]=Wall:create(display.newRect( -300, -10, -200, 980 ));
		walls[3]:setLength(10); walls[3]:setBreadth(990) 
		walls[4]=Wall:create(display.newRect( 700, -10, 1000, 1005 ));
		walls[4]:setLength(110); walls[4]:setBreadth(990) 
	

		
		return walls;
	end		
	
	local areaSensed= false
	local baloonImpact =false
	local attached =false
	local update = function( event)
			if gameMgr:getLevel()==3  then
				if baloonImpact == true then
					balls[1]:getBody().bodyType="dynamic"
					if ballons[1]~=nil and ballons[1]:getBody().bodyType == "kinematic" then
						weldJoint1 =physics.newJoint( "pivot", ballons[1]:getBody(), balls[1]:getBody(), ballons[1]:getBody().x, ballons[1]:getBody().y)
						ballons[1]:getBody().bodyType="dynamic"
						baloonImpact=false
						attached =true
					end
					 if baloonImpact ==true and ballons[2]~=nil and ballons[2]:getBody().bodyType == "kinematic" then
						weldJoint2 =physics.newJoint( "pivot", ballons[2]:getBody(), balls[1]:getBody(), ballons[2]:getBody().x, ballons[2]:getBody().y)
						ballons[2]:getBody().bodyType="dynamic"
						baloonImpact=false
						attached =true
					end
					
					
				end
				if attached == true then
						 if ballons[1]~=nil and ballons[1]:getBody().bodyType == "dynamic" then
							ballons[1]:getBody():applyForce( 0, -0.225, ballons[1]:getBody().x, ballons[1]:getBody().y )
						 end
						  if ballons[2]~=nil and ballons[2]:getBody().bodyType == "dynamic" then
							ballons[2]:getBody():applyForce( 0, -0.225, ballons[2]:getBody().x, ballons[2]:getBody().y )
						 end
				end
				if areaSensed == true then	
				
					chains[3]=Chain:create(blocks[3],balls[1],60,3,puzzleGroup);
					
					chains[4]=Chain:create(blocks[4],balls[1],125,4,puzzleGroup)
					
					areaSensed =false;
				end
			end
			if gameMgr:getLevel()==4  then
			
				if baloonImpact == true then
					balls[1]:getBody().bodyType="dynamic"
					if ballons[1]~=nil and ballons[1]:getBody().bodyType == "kinematic" then
						weldJoint1 =physics.newJoint( "pivot", ballons[1]:getBody(), balls[1]:getBody(), ballons[1]:getBody().x, ballons[1]:getBody().y)
						ballons[1]:getBody().bodyType="dynamic"
						baloonImpact=false
						attached =true
					end
					baloonImpact=false
					attached =true
				end
				if attached == true then
						 if ballons[1]~=nil and ballons[1]:getBody().bodyType == "dynamic" then
							ballons[1]:getBody():applyForce( 0, -0.225, ballons[1]:getBody().x, ballons[1]:getBody().y )
						 end
				end
				if areaSensed == true then	
						if triggers[1] == nil and triggers[2] ~= nil then
							chains[4]=Chain:create(blocks[4],balls[1],75,4,puzzleGroup);
							chains[5]=Chain:create(blocks[5],balls[1],150,5,puzzleGroup);
						end
						if triggers[2] == nil then
							chains[2]=Chain:create(blocks[2],balls[1],300,2,puzzleGroup);
							chains[3]=Chain:create(blocks[3],balls[1],225,3,puzzleGroup);

						end
						areaSensed =false
				end
			end
			if gameMgr:getLevel()==5 then
				if baloonImpact == true then
					balls[1]:getBody().bodyType="dynamic"
					if ballons[1]~=nil and ballons[1]:getBody().bodyType == "kinematic" then
						weldJoint1 =physics.newJoint( "pivot", ballons[1]:getBody(), balls[1]:getBody(), ballons[1]:getBody().x, ballons[1]:getBody().y)
						ballons[1]:getBody().bodyType="dynamic"
						baloonImpact=false
						attached =true
					end
					baloonImpact=false
					attached =true
				end
				if attached == true then
						 if ballons[1]~=nil and ballons[1]:getBody().bodyType == "dynamic" then
							ballons[1]:getBody():applyForce( -0.2199, -0.145, ballons[1]:getBody().x, ballons[1]:getBody().y )

						 end
				end
			end
			if gameMgr:getLevel()==6  then
			
				if baloonImpact == true then
					balls[1]:getBody().bodyType="dynamic"
					if ballons[1]~=nil and ballons[1]:getBody().bodyType == "kinematic" then
						weldJoint1 =physics.newJoint( "pivot", ballons[1]:getBody(), balls[1]:getBody(), ballons[1]:getBody().x, ballons[1]:getBody().y)
						ballons[1]:getBody().bodyType="dynamic"
						baloonImpact=false
						attached =true
					end
					baloonImpact=false
					attached =true
				end
				if attached == true then
						 if ballons[1]~=nil and ballons[1]:getBody().bodyType == "dynamic" then
							ballons[1]:getBody():applyForce( 0, -0.225, ballons[1]:getBody().x, ballons[1]:getBody().y )
						 end
				end
				if areaSensed == true then	
				areaSensed =false
						if triggers[1] == nil then
							chains[4]=Chain:create(blocks[4],balls[1],15,4,puzzleGroup);
							chains[5]=Chain:create(blocks[5],balls[1],60,5,puzzleGroup);
							chains[6]=Chain:create(blocks[6],balls[1],150,6,puzzleGroup);
						end

						
				end
			end
	end
			
	Runtime:addEventListener( "enterFrame", update )
			
	local removeBaloon = function( event )
		local t = event.target
		local phase = event.phase
		if "began" == phase then
		if t ~= nil then
		t:removeSelf()
		t=nil
		end
		end
	end
	onBallCollision = function(self,event)
		
		if event.phase == "began" and event.other == balls[1]:getBody() then
			
			if (triggers[1]~=nil and self ==triggers[1]:getBody()) or (triggers[2]~=nil and self ==triggers[2]:getBody())   then
				
				self:removeSelf();
				if gameMgr:getLevel()==3 then
					attached =false
					triggers[1]=nil
					if ballons[1]~=nil  and ballons[1]:getBody().bodyType == "dynamic" then
						ballons[1]:getBody():removeSelf(); 
						ballons[1]=nil
					end
					if ballons[2]~=nil  and ballons[2]:getBody().bodyType == "dynamic" then
						ballons[2]:getBody():removeSelf(); 
						ballons[2]=nil
					end

					areaSensed = true
					--puzzleObjects[6][2] =chains;
				end
				if gameMgr:getLevel()==4 then
					
					if triggers[1] == nil then
						triggers[2]=nil
						
					else
				
					triggers[1]=nil
					end
					
					areaSensed = true
				end
				if gameMgr:getLevel()==6 then
					
					triggers[1]=nil
					areaSensed = true
				end
				
			elseif event.other ~= nil and (self ==walls[1]:getBody() or self ==walls[2]:getBody() or self ==walls[3]:getBody() or self ==walls[4]:getBody()) then
				
				event.other :removeSelf();
				gameMgr:gameFinish(false)
				soundManger:playLose()
			elseif event.other  ~= nil and (self ==baskets[1]:getBody()) then
				event.other :removeSelf();
				soundManger:playWin()
				Runtime:removeEventListener( "enterFrame", update )
				gameMgr:gameFinish(true)
			elseif (self ==stars[1]:getBody() or self ==stars[2]:getBody() or self ==stars[3]:getBody()) then
				self:removeSelf();
				gameMgr:starImpact()
				soundManger:playImpact()
			elseif ((ballons[1]~=nil and self ==ballons[1]:getBody()) or (ballons[2]~=nil and self ==ballons[2]:getBody())) then
			if gameMgr:getLevel()==3 or gameMgr:getLevel()== 4 or gameMgr:getLevel()== 5  or gameMgr:getLevel()== 6 then
				--self:removeSelf();
				baloonImpact =true;
				soundManger:playImpact()
				self.bodyType ="dynamic"
				event.other.bodyType ="static"
			end
			end
		end
		end

	
	local createBasket=function(x,y,rot)
		basket =Basket:create(x,y,rot,"static", display.newImage( "basket.png" ));
		return basket;
	end

	entity=self;
	if puzzleNo == 1 then
	
			puzzleObjects ={
				{{name="background"},{}},
				{{name="blocks"},{}},
				{{name="stars"},{}},
				{{name="walls"},{}},
				{{name="basket"},{}}, 
				{{name="chains"},{}},
				{{name="ball"},{}},
				{{name="triggers"},{}}
				
			};
	

		
		stars[1]=Star:create(136,360,0,"static",display.newImage( "star.png" ));
		stars[2]=Star:create(380,530,0,"static",display.newImage( "star.png" ));
	    stars[3]=Star:create(400,795,0,"static",display.newImage( "star.png" ));

		puzzleObjects[3][2]  =stars;
	
		
		local bckGrounds ={}
		background = display.newImageRect( "bkg_bricks.png", 640,960 )
		background.x = display.contentWidth / 2
		background.y = display.contentHeight / 2
		
		puzzleGroup:insert(background)
		
		
		blocks[1]=Block:create(100,100,0,"static", display.newImage( "pivot_.png" ));
	--	blocks[1]:getBody().yReference =blocks[1]:getBody().y ;
	--	blocks[1]:getBody().xReference =blocks[1]:getBody().x ;
		blocks[2]=Block:create(500,120,0,"static",display.newImage( "pivot_.png" ));
		--blocks[2]:getBody().yReference =blocks[2]:getBody().y ;
		--blocks[2]:getBody().xReference =blocks[2]:getBody().x ;
	    blocks[3]=Block:create(375,400,0,"static",display.newImage( "pivot_.png" ));
		--blocks[3]:getBody().yReference =blocks[3]:getBody().y ;
		--blocks[3]:getBody().xReference =blocks[3]:getBody().x ;
		puzzleObjects[2][2] =blocks;
		
		balls[1]=Ball:create(330,120,0,"dynamic",display.newImage( "candy_.png" ))
		--balls[1]:getBody().yReference =balls[1]:getBody().y ;
		--balls[1]:getBody().xReference =balls[1]:getBody().x;
		puzzleObjects[7][2] =balls

		chains[1]=Chain:create(blocks[1],balls[1],0,1,puzzleGroup);
		chains[2]=Chain:create(blocks[2],balls[1],180,2,puzzleGroup)
		chains[3]=Chain:create(blocks[3],balls[1],265,3,puzzleGroup)
		puzzleObjects[6][2] =chains;
	
		puzzleObjects[4][2]  =createWalls();

		baskets[1]=Basket:create(400,890,0,"static", display.newImage( "basket.png" ));
		baskets[1]:getBody().collision = onBallCollision
		baskets[1]:getBody():addEventListener( "collision", baskets[1]:getBody() )
		puzzleObjects[5][2] =baskets
		
	end
	if puzzleNo == 2 then
	
			puzzleObjects ={
				{{name="background"},{}},
				{{name="blocks"},{}},
				{{name="stars"},{}},
				{{name="walls"},{}},
				{{name="basket"},{}}, 
				{{name="chains"},{}},
				{{name="ball"},{}},
				{{name="triggers"},{}}
				
			};
			
		stars[1]=Star:create(200,400,0,"static",display.newImage( "star.png" ));
		stars[2]=Star:create(350,575,0,"static",display.newImage( "star.png" ));
	    stars[3]=Star:create(320,800,0,"static",display.newImage( "star.png" ));
		puzzleObjects[3][2]  =stars;
	
		
		local bckGrounds ={}
		background = display.newImageRect( "bkg_bricks.png", 640,960 )
		background.x = display.contentWidth / 2
		background.y = display.contentHeight / 2
		
		puzzleGroup:insert(background)
		
		
		blocks[1]=Block:create(80,130,0,"static", display.newImage( "pivot_.png" ));
		blocks[2]=Block:create(500,120,0,"static",display.newImage( "pivot_.png" ));
	    blocks[3]=Block:create(440,400,0,"static",display.newImage( "pivot_.png" ));
		blocks[4]=Block:create(60,410,0,"static",display.newImage( "pivot_.png" ));
		puzzleObjects[2][2] =blocks;
		
		balls[1]=Ball:create(330,240,0,"dynamic",display.newImage( "candy_.png" ))
		puzzleObjects[7][2] =balls
		

		
		chains[2]=Chain:create(blocks[2],balls[1],150,2,puzzleGroup);
		chains[1]=Chain:create(blocks[1],balls[1],30,1,puzzleGroup)
		chains[3]=Chain:create(blocks[3],balls[1],240,3,puzzleGroup)
		chains[4]=Chain:create(blocks[4],balls[1],-30,4,puzzleGroup)
		puzzleObjects[6][2] =chains;
		
		

		puzzleObjects[4][2]  =createWalls();
		

		
		baskets[1]=Basket:create(320,860,0,"static", display.newImage( "basket.png" ));
		baskets[1]:getBody().collision = onBallCollision
		baskets[1]:getBody():addEventListener( "collision", baskets[1]:getBody() )
		puzzleObjects[5][2] =baskets


	 end
	if puzzleNo == 3 then	
	 
	 			puzzleObjects ={
				{{name="background"},{}},
				{{name="blocks"},{}},
				{{name="stars"},{}},
				{{name="walls"},{}},
				{{name="basket"},{}}, 
				{{name="chains"},{}},
				{{name="ball"},{}},
				{{name="triggers"},{}},
				{{name="baloons"},{}},
				{{name="windArrows"},{}}
				
			};
			
		stars[1]=Star:create(300,770,0,"static",display.newImage( "star.png" ));
		stars[2]=Star:create(434,204,0,"static",display.newImage( "star.png" ));
	    stars[3]=Star:create(190,330,0,"static",display.newImage( "star.png" ));
		puzzleObjects[3][2]  =stars;
	
		
		local bckGrounds ={}
		background = display.newImageRect( "bkg_bricks.png", 640,960 )
		background.x = display.contentWidth / 2
		background.y = display.contentHeight / 2
		
		puzzleGroup:insert(background)
		
		
		blocks[1]=Block:create(600,400,0,"static", display.newImage( "pivot_.png" ));
		blocks[2]=Block:create(315,600,0,"static",display.newImage( "pivot_.png" ));
	    blocks[3]=Block:create(60,100,0,"static",display.newImage( "pivot_.png" ));
	    blocks[4]=Block:create(310,170,0,"static",display.newImage( "pivot_.png" ));
		puzzleObjects[2][2] =blocks;
		
		balls[1]=Ball:create(440,500,0,"dynamic",display.newImage( "candy_.png" ))
		puzzleObjects[7][2] =balls
		
		
		
		
		chains[2]=Chain:create(blocks[2],balls[1],150,2,puzzleGroup);
		chains[1]=Chain:create(blocks[1],balls[1],150,1,puzzleGroup)
		--chains[3]=Chain:create(blocks[3],balls[1],240,3,puzzleGroup)
		--chains[4]=Chain:create(blocks[4],balls[1],-30,4,puzzleGroup)
		puzzleObjects[6][2] =chains;
		
		

		puzzleObjects[4][2]  =createWalls();
		

		
		baskets[1]=Basket:create(436,110,0,"static", display.newImage( "basket_upsidedown.png" ));
		baskets[1]:getBody().collision = onBallCollision
		baskets[1]:getBody():addEventListener( "collision", baskets[1]:getBody() )
		puzzleObjects[5][2] =baskets
			
		triggers[1]=TriggerArea:create(display.newRect( 76, 70, 280, 210 ));
		triggers[1]:getBody().collision = onBallCollision
		triggers[1]:getBody():addEventListener( "collision", triggers[1]:getBody() )
		puzzleObjects[8][2] =triggers;
		
		ballons[1]=Balloon:create(225,810,0,"kinematic",display.newImage( "bubble.png" ))
		ballons[1]:getBody().collision = onBallCollision
		ballons[1]:getBody():addEventListener( "collision", ballons[1]:getBody() )
		puzzleObjects[9][2] =ballons;
		
		ballons[2]=Balloon:create(410,360,0,"kinematic",display.newImage( "bubble.png" ))
		ballons[2]:getBody().collision = onBallCollision
		ballons[2]:getBody():addEventListener( "collision", ballons[2]:getBody() )
		puzzleObjects[9][2] =ballons;
		
		windArrows[1]= WindArrow:create(300,500,270,"static",display.newImage( "windArrow.png" ));
		puzzleObjects[10][2] =windArrows;
	end
	if puzzleNo == 4 then	
	 	 			puzzleObjects ={
				{{name="background"},{}},
				{{name="blocks"},{}},
				{{name="stars"},{}},
				{{name="walls"},{}},
				{{name="basket"},{}}, 
				{{name="chains"},{}},
				{{name="ball"},{}},
				{{name="triggers"},{}},
				{{name="baloons"},{}},
				{{name="windArrows"},{}}
				
			};
		
		stars[1]=Star:create(140,240,0,"static",display.newImage( "star.png" ));
		stars[2]=Star:create(100,390,0,"static",display.newImage( "star.png" ));
		stars[3]=Star:create(250,450,0,"static",display.newImage( "star.png" ));
		puzzleObjects[3][2]  =stars
		
		local bckGrounds ={}
		background = display.newImageRect( "bkg_bricks.png", 640,960 )
		background.x = display.contentWidth / 2
		background.y = display.contentHeight / 2
		
		puzzleGroup:insert(background)
		
		
		blocks[1]=Block:create(70,90,0,"static", display.newImage( "pivot_.png" ));
		blocks[2]=Block:create(20,620,0,"static",display.newImage( "pivot_.png" ));
		blocks[3]=Block:create(280,370,0,"static",display.newImage( "pivot_.png" ));
		blocks[4]=Block:create(250,65,0,"static",display.newImage( "pivot_.png" ));
		blocks[5]=Block:create(600,150,0,"static",display.newImage( "pivot_.png" ));
		puzzleObjects[2][2] =blocks;
		
		balls[1]=Ball:create(300,250,0,"dynamic",display.newImage( "candy_.png" ))
		puzzleObjects[7][2] =balls
				
		
		chains[1]=Chain:create(blocks[1],balls[1],45,1,puzzleGroup)
		puzzleObjects[6][2] =chains;
		

		puzzleObjects[4][2]  =createWalls();
		

		
		baskets[1]=Basket:create(440,360,0,"static", display.newImage( "basket_upsidedown.png" ));
		baskets[1]:getBody().collision = onBallCollision
		baskets[1]:getBody():addEventListener( "collision", baskets[1]:getBody() )
		puzzleObjects[5][2] =baskets
			
		triggers[2]=TriggerArea:create(display.newRect(  0, 255, 140, 650  ));
		triggers[2]:getBody().collision = onBallCollision
		triggers[2]:getBody():addEventListener( "collision", triggers[2]:getBody() )
		triggers[1]=TriggerArea:create(display.newRect( 125, 30, 150, 600 ));
		triggers[1]:getBody().collision = onBallCollision
		triggers[1]:getBody():addEventListener( "collision", triggers[1]:getBody() )
		puzzleObjects[8][2] =triggers;
		
		ballons[1]=Balloon:create(360,630,0,"kinematic",display.newImage( "bubble.png" ))
		ballons[1]:getBody().collision = onBallCollision
		ballons[1]:getBody():addEventListener( "collision", ballons[1]:getBody() )
		puzzleObjects[9][2] =ballons;
		
		windArrows[1]= WindArrow:create(300,500,270,"static",display.newImage( "windArrow.png" ));
		puzzleObjects[10][2] =windArrows;

	end
	if puzzleNo == 5 then 
			puzzleObjects ={
				{{name="background"},{}},
				{{name="blocks"},{}},
				{{name="stars"},{}},
				{{name="walls"},{}},
				{{name="basket"},{}}, 
				{{name="chains"},{}},
				{{name="ball"},{}},
				{{name="triggers"},{}},
				{{name="baloons"},{}},
				{{name="windArrows"},{}}
				
			};
		
		stars[1]=Star:create(260,400,0,"static",display.newImage( "star.png" ));
		stars[2]=Star:create(100,120,0,"static",display.newImage( "star.png" ));
		stars[3]=Star:create(370,840,0,"static",display.newImage( "star.png" ));
		puzzleObjects[3][2]  =stars
		
		local bckGrounds ={}
		background = display.newImageRect( "bkg_bricks.png", 640,960 )
		background.x = display.contentWidth / 2
		background.y = display.contentHeight / 2
		
		puzzleGroup:insert(background)
		
		
		blocks[1]=Block:create(20,320,0,"static", display.newImage( "pivot_.png" ));
		blocks[2]=Block:create(440,260,0,"static",display.newImage( "pivot_.png" ));
		blocks[3]=Block:create(220,500,0,"static",display.newImage( "pivot_.png" ));
	
		puzzleObjects[2][2] =blocks;
		
		balls[1]=Ball:create(150,220,0,"dynamic",display.newImage( "candy_.png" ))
		puzzleObjects[7][2] =balls
				
		
		chains[1]=Chain:create(blocks[1],balls[1],300,1,puzzleGroup)
		chains[2]=Chain:create(blocks[2],balls[1],180,2,puzzleGroup);
		chains[3]=Chain:create(blocks[3],balls[1],240,3,puzzleGroup);
		puzzleObjects[6][2] =chains;
		

		puzzleObjects[4][2]  =createWalls();
		

		
		baskets[1]=Basket:create(400,900,0,"static", display.newImage( "basket.png" ));
		baskets[1]:getBody().collision = onBallCollision
		baskets[1]:getBody():addEventListener( "collision", baskets[1]:getBody() )
		puzzleObjects[5][2] =baskets
			
		
		ballons[1]=Balloon:create(490,580,0,"kinematic",display.newImage( "bubble.png" ))
		ballons[1]:getBody().collision = onBallCollision
		ballons[1]:getBody():addEventListener( "collision", ballons[1]:getBody() )
		ballons[1]:getBody():addEventListener( "touch", removeBaloon ) 
		puzzleObjects[9][2] =ballons;
		
		windArrows[1]= WindArrow:create(300,500,225,"static",display.newImage( "windArrow.png" ));
		puzzleObjects[10][2] =windArrows;
	end
	if puzzleNo == 6 then 
			puzzleObjects ={
				{{name="background"},{}},
				{{name="blocks"},{}},
				{{name="stars"},{}},
				{{name="walls"},{}},
				{{name="basket"},{}}, 
				{{name="chains"},{}},
				{{name="ball"},{}},
				{{name="triggers"},{}},
				{{name="baloons"},{}},
				{{name="pipes"},{}},
				{{name="windArrows"},{}}
				
			};
		
		stars[1]=Star:create(350,780,0,"static",display.newImage( "star.png" ));
		stars[2]=Star:create(150,370,0,"static",display.newImage( "star.png" ));
		stars[3]=Star:create(530,570,0,"static",display.newImage( "star.png" ));
		puzzleObjects[3][2]  =stars
		
		local bckGrounds ={}
		background = display.newImageRect( "bkg_bricks.png", 640,960 )
		background.x = display.contentWidth / 2
		background.y = display.contentHeight / 2
		
		puzzleGroup:insert(background)
		
		
		blocks[1]=Block:create(0,250,0,"static", display.newImage( "pivot_.png" ));
		blocks[2]=Block:create(240,60,0,"static",display.newImage( "pivot_.png" ));
		blocks[3]=Block:create(300,270,0,"static",display.newImage( "pivot_.png" ));
		blocks[4]=Block:create(210,530,0,"static",display.newImage( "pivot_.png" ));
		blocks[5]=Block:create(385,735,0,"static",display.newImage( "pivot_.png" ));
		blocks[6]=Block:create(500,455,0,"static",display.newImage( "pivot_.png" ));
		puzzleObjects[2][2] =blocks;
		
		balls[1]=Ball:create(150,200,0,"dynamic",display.newImage( "candy_.png" ))
		puzzleObjects[7][2] =balls
				
		
		chains[1]=Chain:create(blocks[1],balls[1],165,1,puzzleGroup)
		chains[2]=Chain:create(blocks[2],balls[1],315,2,puzzleGroup);
		chains[3]=Chain:create(blocks[3],balls[1],210,3,puzzleGroup);
		puzzleObjects[6][2] =chains;
		

		puzzleObjects[4][2]  =createWalls();
		

		pipes[1]=Pipe:create(140,440,30,"static", display.newImage( "pipe.png" ));
		pipes[2]=Pipe:create(290,840,-2,"static",display.newImage( "pipe.png" ));
		puzzleObjects[10][2] =pipes;
		
		baskets[1]=Basket:create(560,300,0,"static", display.newImage( "basket.png" ));
		baskets[1]:getBody().collision = onBallCollision
		baskets[1]:getBody():addEventListener( "collision", baskets[1]:getBody() )
		puzzleObjects[5][2] =baskets
			
		triggers[1]=TriggerArea:create(display.newRect(  200, 600, 500, 680  ));
		triggers[1]:getBody().collision = onBallCollision
		triggers[1]:getBody():addEventListener( "collision", triggers[1]:getBody() )
		
		ballons[1]=Balloon:create(520,840,0,"kinematic",display.newImage( "bubble.png" ))
		ballons[1]:getBody().collision = onBallCollision
		ballons[1]:getBody():addEventListener( "collision", ballons[1]:getBody() )
		ballons[1]:getBody():addEventListener( "touch", removeBaloon ) 
		puzzleObjects[9][2] =ballons;
		
		windArrows[1]= WindArrow:create(300,500,270,"static",display.newImage( "windArrow.png" ));
		puzzleObjects[11][2] =windArrows;
	end
	if puzzleNo == 7 then 
			
	end

	if puzzleNo ~= 7 then 
		for i=1,#walls do
			walls[i]:getBody().collision = onBallCollision
			walls[i]:getBody():addEventListener( "collision", walls[i]:getBody() )
		end
		
		for i=1,#stars do
			stars[i]:getBody().collision = onBallCollision
			stars[i]:getBody():addEventListener( "collision", stars[i]:getBody() )
		end
		
	
	for i=1,#puzzleObjects do

		objects=puzzleObjects[i][2]
		if puzzleObjects[i][1].name == "chains"  then
			
		
		else
			for j =1,#objects do
				print(puzzleObjects[i][1].name)
				puzzleGroup:insert( objects[j]:getBody());
			end
		end
	end
	
	end

	return puzzleGroup;
end




--testMethod();
