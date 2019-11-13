
defaultBody = display.newRect( -100, -100, -100, -100 );
defaultBody.isVisible=false;
-- Entity Class----------------------------------------------------------
Entity ={name ="",xPos=0;yPos=0,rotation=0.0,type_="",body=defaultBody, sensor=false,Table={}}

function Entity:new(obj)

	obj =obj or{}
	setmetatable(obj,self)
	self.__index=self
	return obj
end



local function setEntity(obj,x,y,rot,typ)
	entity=obj;
	entity.xPos=x;
	entity.yPos=y;
	entity.rotation=rot;
	entity.type_=typ;
	entity.body.x =entity.xPos; entity.body.y =entity.yPos; entity.body.rotation =rot; 
	physics.addBody( entity.body, entity.type_,{ isSensor = entity.sensor } )

end

function Entity:appear(x,y,rot,typ)
	setEntity(self,x,y,rot,typ);

end


function Entity:onCollision()
print("Collided...");
end

function Entity:update()
print("Updating..");
end

function Entity:disappear()
print("disappearing...");
end

function Entity:setName(name_)
	entity =self;
	entity.name=name_;
end

function Entity:getName()
return self.name;
end

function Entity:setSensor(sensor_)
	entity =self;
	entity.sensor=sensor_;
end

function Entity:getSensor()
return self.sensor;
end

function Entity:setTable(tbl)
	entity =self;
	entity.Table=tbl;
end

function Entity:getTable()
return self.Table;
end

function Entity:setBody(body_)
	entity =self;
	entity.body=body_;
end

function Entity:getBody()
return self.body;
end

function Entity:getPos()

return {X=self.body.x,Y=self.body.y,R=self.rotation, T= self.type_};
end

function Entity:printEntity()
print(self.name.." "..self.xPos.." "..self.yPos.." "..self.rotation.." "..self.type_.." ");

end

-- Entity Class End----------------------------------------------------------



-- Ball Class ----------------------------------------------------------


Ball = Entity:new();

function Ball:update()
print("Ball "..self:getName().." Updating..");
end

function Ball:create(x,y,rot,typ,body)
b=Ball:new();
b.x=x ; b.y=y ; b.type_=typ; b.rotation=rot
body.x =x
body.y =y
physics.addBody( body,{ density=0.0011, friction=0, bounce=0})
b:setBody(body);
--b:appear(x,y,rot,typ);
return b;
end

-- Ball Class End----------------------------------------------------------

-- Balloon Class ----------------------------------------------------------


Balloon = Entity:new();

function Balloon:update()
print("Balloon "..self:getName().." Updating..");
end

function Balloon:create(x,y,rot,typ,body)
b=Balloon:new();
b.x=x ; b.y=y ; b.type_=typ; b.rotation=rot
body.x =x
body.y =y
body.type=typ
body.rotation =rot
physics.addBody( body,typ,{ isSensor = true })--,{ density=0.00022, friction=0, bounce=0}
b:setBody(body);
return b;
end

-- Balloon Class End----------------------------------------------------------

-- BackGround Class ----------------------------------------------------------


BackGround = Entity:new();

function BackGround:update()
print("Ball "..self:getName().." Updating..");
end

function BackGround:create(body)
b=BackGround:new();
 body.x = display.contentWidth / 2
 body.y = display.contentHeight / 2
b:setBody(body);
return b;
end

-- BackGround Class End----------------------------------------------------------


-- Block Class ----------------------------------------------------------


Block= Entity:new();

function Block:update()
print("Block "..self:getName().." Updating..");
end

function Block:create(x,y,rot,typ,body_)
b=Block:new();
b:setBody(body_);
b:setSensor(true);
print("block "..b.body.x)

b:appear(x,y,rot,typ);
return b;
end

-- Block Class End----------------------------------------------------------

-- Wall Class ----------------------------------------------------------


Wall = Entity:new {length ="", breadth=""};

function Wall:update()
print("Wall "..self:getName().." Updating..");
end

function Wall:create(body)
b=Wall:new();
b:setSensor(true);
b:setBody(body);
physics.addBody( body, "static",{ isSensor = true } )
--b:appear(x,y,rot,typ);
return b;
end

function Wall:setLength(len)
	ent =self
	ent.length =len;
end

function Wall:getLength()
	return self.length ;
end

function Wall:setBreadth(breadth)
	ent =self
	ent.breadth =breadth;
end

function Wall:getLength()
	return self.breadth ;
end
-- Wall Class End----------------------------------------------------------

-- Star Class ----------------------------------------------------------


Star = Entity:new();

function Star:update()
print("Star "..self:getName().." Updating..");
end

function Star:create(x,y,rot,typ,body)
b=Star:new();
b:setSensor(true);
b:setBody(body);
b:appear(x,y,rot,typ);
return b;
end

-- Star Class End----------------------------------------------------------

-- Pipe Class ----------------------------------------------------------


Pipe= Entity:new();

function Pipe:update()
print("Pipe "..self:getName().." Updating..");
end

function Pipe:create(x,y,rot,typ,body_)
b=Pipe:new();
b:setBody(body_);
b:setSensor(false);
print("Pipe "..b.body.x)
b:appear(x,y,rot,typ);
return b;
end

-- Pipe Class End----------------------------------------------------------

-- WindArrow Class ----------------------------------------------------------


WindArrow= Entity:new();

function WindArrow:update()
print("WindArrow "..self:getName().." Updating..");
end

function WindArrow:create(x,y,rot,typ,body_)
b=WindArrow:new();
b:setBody(body_);
b:setSensor(true);
print("WindArrow "..b.body.x)
b:appear(x,y,rot,typ);
return b;
end

-- WindArrow End----------------------------------------------------------


-- Rod Class ----------------------------------------------------------


Rod= Entity:new();

function Rod:update()
print("Rod "..self:getName().." Updating..");
end

function Rod:create(x,y,rot,typ,body_)
b=Rod:new();
b:setBody(body_);
b:setSensor(false);
physics.addBody( body_, "dynamic",{ density=3, friction=0, bounce=1})
return b;
end

-- Rod Class End----------------------------------------------------------

-- Stone Class ----------------------------------------------------------


Stone= Entity:new();

function Stone:update()
print("Stone "..self:getName().." Updating..");
end

function Stone:create(x,y,rot,typ,body_)
b:setBody(body_);
b:setSensor(false);
print("Stone "..b.body.x)

b:appear(x,y,rot,typ);
return b;
end

-- Stone Class End----------------------------------------------------------


-- Link Class ----------------------------------------------------------


Link = Entity:new{index="",linkId=0};

function Link:update()
print("Star "..self:getName().." Updating..");
end

function Link:create(x,y,rot,typ,body)
b=Link:new();
b:setBody(body);

b:appear(x,y,rot,typ);
return b;
end

function Link:setIndex(index)
	ent =self
	ent.index =index;
end

function Link:getIndex()
	return self.index ;
end



function Link:setLinkId(id)
	ent =self
	ent.linkId =id;
end

function Link:getLinkId()
	return self.linkId ;
end
-- Link Class End----------------------------------------------------------


-- Chain Class ----------------------------------------------------------


Chain = Entity:new{links={}};

function Chain:update()
print("Chain "..self:getName().." Updating..");
end

function Chain:addLink(link)
	ent =self
	ent.links[#links+1] =link;
end

function Chain:getChainVal(ent)
	return{Links=ent.links,Obj1=ent.object1_,Obj2=ent.object2_,D=ent.d,C=ent.c,G=ent.g} ;
end

function Chain:getLinks()
	return self.links ;
end

function Chain:setLinks(lnk)
	 self.links=lnk ;
end


function Chain:create(object1,object2,rot,typ,pzzlGrp)

	b=Chain:new();
	
	--links_ =b.links;
	links_ ={};

	local getDistance =function(x1,x2,y1,y2)
		xDiff = (x1 -x2)*(x1 -x2)
		yDiff = (y1 -y2)*(y1 -y2)
		return math.sqrt( xDiff + yDiff)
	end

	local getGradient =function(x1,x2,y1,y2)
		if (x1 -x2) ==0 then
			return nil
		elseif(y1 -y2)==0 then
			return 0
		else
			return (y1 -y2)/(x1 -x2)
		end
	end


	
    local getConstant =function(gradient,x,y)
		if gradient == nil then
			return gradient
		else
			return y- gradient*x
		end
    end
	
	local getRadius =function(distanceval,sagittaVal)
		return distanceval*distanceval/(8*sagittaVal) + sagittaVal/2 ;
	end
	
	local calcCenterX =function(distanceval, radius, x1,x2,y1,y2)
		return (x1 + x2)/2 +math.sqrt((radius*radius-(distanceval*distanceval/4)))*(y1-y2)/distanceval;
	end

	local calcCenterY =function(distanceval, radius, x1,x2,y1,y2)
		return (y1 + y2)/2 +math.sqrt((radius*radius-(distanceval*distanceval/4)))*(x2-x1)/distanceval;
	end
	
	local getYPointOftheCircle=function(radius,centerX,centerY,xVAl)
		return math.abs(math.sqrt(radius*radius-(xVAl-centerX)*(xVAl-centerX)))+centerY
	end
	
	local calcCircurmfernceofArc =function(radius,sagittaVal)
		return 2* math.acos(1-sagittaVal/radius)*radius
	end
	
	local breakJoint = function( event )
			local t = event.target
			local phase = event.phase
			if "moved" == phase  then
				
					links = puzzleObjects[6][2][t.myIndex] 
				for j = 1,#links  do
					soundManger:playSwipe()
				
						if links[j] ~= nil  and  t.myIndex == links[j].myIndex then
							
							
						    links[j]:removeSelf()
						--	display.remove(links[j])
							links[j]=nil
						end
				end
			end
		end
	
	local myJoints={};
	
	
	b:setName("chain"..typ);
	distance = getDistance(object1:getPos().X,object2:getPos().X,object1:getPos().Y,object2:getPos().Y)
	b.d=distance
	distance=distance
	gradient = getGradient(object1:getPos().X,object2:getPos().X,object1:getPos().Y,object2:getPos().Y)
	b.g=gradient
	constant = getConstant(gradient,object1:getPos().X,object1:getPos().Y)
	b.c=constant
	
	sagitta =10;
	radi =getRadius(distance,sagitta)
	centX= calcCenterX(distance, radi, object1:getPos().X,object2:getPos().X,object1:getPos().Y,object2:getPos().Y)
	centY= calcCenterY(distance, radi, object1:getPos().X,object2:getPos().X,object1:getPos().Y,object2:getPos().Y)
	arcLength= calcCircurmfernceofArc(radi,sagitta)
	
	numOfLinks =  #links_
		local ballX =object2:getBody().x;
		local ballY =object2:getBody().y;
		
		local tempObj1X=object1:getPos().X
		local tempObj1Y=object1:getPos().Y
		local linkSize =45
		local tempx
		--for j = numOfLinks +1 , numOfLinks +math.round(arcLength/linkSize)-1 do
		for j = numOfLinks +1 , numOfLinks +math.round(distance/linkSize)-1 do
	
			--local x_=object1:getPos().X - (object1:getPos().X -ballX)/math.round(arcLength/linkSize)*(j - numOfLinks)
			local x_
			--local y_= getYPointOftheCircle(radi,centX,centY,x_);
			local y_

			 x_=tempObj1X - (tempObj1X -ballX)/math.round(distance/linkSize)*(j - numOfLinks)
				--x_=object1:getPos().X+ linkSize*j 
				if gradient ~=nil then
					y_ =  x_ * (gradient) + constant
				
				else
					y_ =  tempObj1Y - (tempObj1Y -ballY)/math.round(distance/linkSize)*(j - numOfLinks)
					
				end
			
			links_[j]=display.newImage( "link__.png" )
			links_[j].x =x_
			tempx =x_
			links_[j].y=y_
			links_[j].rotation=rot
			links_[j].myIndex=typ
			links_[j].angularDamping = 0
			links_[j].linearDamping = 0
			--links_[j].yReference =links_[j].y ;
			--links_[j].xReference =links_[j].x ;
			links_[j]:addEventListener( "touch", breakJoint );
			--if j== 1  then
			--physics.addBody( links_[j] , "static", { density=0.009, friction=0, bounce=0 } )
			--else
			physics.addBody( links_[j] , "dynamic", { density=0.009, friction=0, bounce=0 } )
			--end
		--	links_[j]:addEventListener( "touch", breakJoint );
	
			pzzlGrp:insert( links_[j]);
	
			local prevLink
			if (j  >numOfLinks + 1) then
				prevLink = links_[j-1]
			
			else
			
					object1:getBody().x=links_[1].x
					object1:getBody().y=links_[1].y
				prevLink = object1:getBody()
			
			end
			if gradient ~=nil then
	
				myJoints[#myJoints+1] = physics.newJoint( "pivot", prevLink, links_[j], tempObj1X - (tempObj1X -ballX)/math.round(distance/45)*(j - numOfLinks), links_[j].x* gradient + constant)
				--myJoints[#myJoints+1] = physics.newJoint("pivot", prevLink, links_[j], object1:getPos().X , object1:getPos().Y )
				
			else
				myJoints[#myJoints+1] = physics.newJoint( "pivot", prevLink, links_[j], tempObj1X - (tempObj1X -ballX)/math.round(distance/45)*j, tempObj1Y - (tempObj1Y -ballY)/math.round(distance/45)*(j - numOfLinks))
				--myJoints[#myJoints+1] = physics.newJoint( "pivot", prevLink, links_[j], object1:getPos().X , object1:getPos().Y )
				
			end	
				-- myJoints[#myJoints+1] = physics.newJoint( "pivot", prevLink, links_[j],object1:getPos().X ,object1:getPos().Y)

		end
		myJoints[#myJoints+1] = physics.newJoint( "pivot", links_[#links_], object2:getBody(), ballX ,ballY )

		b.links=links_
	return links_;
end




-- Chain Class End----------------------------------------------------------


-- Basket Class ----------------------------------------------------------


Basket = Entity:new();


function Basket:update()
print("Basket "..self:getName().." Updating..");
end

function Basket:create(x,y,rot,typ,body)
b=Basket:new();
b:setSensor(true);
b:setBody(body);
b:appear(x,y,rot,typ);
return b;
end



-- Basket Class End----------------------------------------------------------

-- TriggerArea Class ----------------------------------------------------------


TriggerArea = Entity:new();


function TriggerArea:update()
print("Basket "..self:getName().." Updating..");
end

function TriggerArea:create(body)

b=TriggerArea:new();


--b:appear(x,y,rot,typ);
body.alpha = 0
body:setFillColor( 0, 0, 0, 0 )
physics.addBody( body, "static",{ isSensor = true } )

b:setBody(body);
return b;
end



-- TriggerArea Class End----------------------------------------------------------

local function testMethod()
	b=Ball:create(10.0,15.0,25.0,"dynamic");
	b:setName("B");
	b:update();
	--b:appear(10.0,15.0,25.0,"dynamic");
	b:printEntity();

	b_=Ball:create(12.0,12.0,27.0,"static");
	b_:setName("B_");
	b_:update();
	--b_:appear(12.0,12.0,27.0,"static");
	b_:printEntity();

end

--testMethod();

