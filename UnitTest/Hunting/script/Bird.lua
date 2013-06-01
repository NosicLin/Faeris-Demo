Bird={}
Bird.__index=Bird

function Bird:Create()
	local bird=Bird:New()
	bird:Init()
	return bird
end

function Bird:New()
	local quad=Quad2D:create("textures/firebird.png",Bird.ms_width,Bird.ms_height)
	quad.data={}
	setmetatable(quad.data,Bird)
	return quad 
end

function Bird:Init()

	self.m_flyAngle=math.random(0,360)

	local px=math.random(0,GAME_WIDTH)
	local py=math.random(0,GAME_HEIGHT)
	self:setPosition(px,py)

	self.m_flySpeed=self.ms_flySpeed
	self.onUpdate=Bird.LiveUpdate
end


function Bird:Hit(x,y)
	return self:hit2D(x,y)
end

function Bird:Dead()
	self.m_scale=2.0
	self:setScale(2.0,2.0,1.0)
	self.onUpdate=Bird.DeadUpdate
end


function Bird:LiveUpdate(dt)
	local x,y= self:getPosition()
	local dx= dt/1000*self.m_flySpeed*math.cos(self.m_flyAngle)
	local dy= dt/1000*self.m_flySpeed*math.sin(self.m_flyAngle)

	x=x+dx
	y=y+dy

	if x> GAME_WIDTH+100 or x< -100 
		or y>GAME_HEIGHT+100 or y<-100 then 
		local rx=math.random(0,GAME_WIDTH)
		local ry=math.random(0,GAME_HEIGHT)
		self:setPosition(rx,ry)

	else 
		self:setPosition(x,y)
	end
end

function Bird:DeadUpdate(dt)
	self.m_scale=self.m_scale-dt/1000*1.5
	if self.m_scale < 0 then 
		self:detach()
	else 
		self:setScale(self.m_scale,self.m_scale,1)
	end
end




-- static data -- 

Bird.ms_width=30
Bird.ms_height=30
Bird.ms_flySpeed=40













