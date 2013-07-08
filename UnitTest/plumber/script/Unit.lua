Unit={}
Unit.__index=Unit 

function Unit:Create(param)
	local ret=Unit:New()
	ret:Init(param)
	return ret
end


function Unit:New()
	local ret=Quad2D:create("textures/E.png")
	ret.data={}
	setmetatable(ret.data,Unit)
	return ret
end


function Unit:Init(param)
	print(param)
	local raw_info=self.ms_types[param]
	local texture=share:textureMgr():load("textures/"..raw_info.icon)
	self:setTexture(texture)

	self.m_connectInfo=raw_info.connectInfo 
	self.m_waterFrom={}
	self.m_waterTo={}
	--self.m_internalWater=raw_info.connectInfo.internal
end


function Unit:AddWaterFrom(direction)
	self.m_waterFrom[direction]=true
	self:CalWaterTo()
end

function Unit:DelWaterFrom(direction)
	self.m_waterFrom[direction]=nil 
	self:CalWaterTo()
end


function Unit:ClrWaterFrom()
	self.m_waterFrom={}
	self:CalWaterTo()
end

function Unit:GetWaterFrom()
	return self.m_waterFrom
end

function Unit:GetWaterTo()
	return self.m_waterTo 
end

function Unit:CalWaterTo()
	self.m_waterTo={}
	for k,_ in pairs(self.m_waterFrom) do 
		local connect_info=self.m_connectInfo[k] 
		for c,_ in pairs(connect_info) do 
			self.m_waterTo[c]=true 
		end
	end

	for _,v in pairs(self.m_internalWater) do 
		self.m_waterTo[v]=true 
	end
end


function Unit:MoveTo(x,y,time)
	local ox,oy=self:getPosition()

	--util.log("ox=%d,oy=%d,tx=%d,ty=%d,time=%d",ox,oy,x,y,time)
	local speedx=(x-ox)/time
	local speedy=(y-oy)/time
	self.m_speed={x=speedx,y=speedy}
	self.m_times=time
	self.onUpdate=Unit.onUpdateMove
end


-- call back --
function Unit:onUpdateMove(dt)
	local ox,oy=self:getPosition()
	local move_over=false

	--util.log("dt=%d",dt)
	if dt >= self.m_times then 
		dt=self.m_times
		move_over=true
	end

	local x=ox+self.m_speed.x*dt
	local y=oy+self.m_speed.y*dt

	self:setPosition(x,y)
	self.m_times=self.m_times-dt

	if move_over then 
		self.onUpdate=nil
	end
end

-- static data -- 

-- seq L,R,B,T -- 
Unit.ms_connectTypes=
{
	["E"]=
	{
		left={},
		right={},
		bottom={},
		top={},
		internal={},
	},
	-- left begin --
	["L-R#R-L"]=
	{
		left= {right=true},
		right={left=true},
		bottom={},
		top={},
		internal={},
	},
	["L-B#B-L"]=
	{
		left={bottom=true},
		right={},
		bottom={left=true},
		top={},
		internal={},
	},
	["L-T#T-L"]=
	{
		left={top=true},
		right={},
		bottom={},
		top={left=true},
		internal={},
	},

	-- right begin --
	["R-T#T-R"]=
	{
		left={},
		right={top=true},
		bottom={},
		top={right=true},
		internal={},
	},
	["R-B#B-R"]={
		left={},
		right={bottom=true},
		bottom={right=true},
		top={},
		internal={}
	},

	-- bottom begin -- 
	["B-T#T-B"]=
	{
		left={},
		right={},
		bottom={top=true},
		top={bottom=true},
		internal={}
	},
}


Unit.ms_types=
{
	["E"]=
	{
		move=true,
		icon="E.png",
		connectInfo=Unit.ms_connectTypes["E"],
	},

	-- L begin -- 
	["L-R#R-L"]=
	{
		move=true,
		icon="L-R#R-L.png",
		connectInfo=Unit.ms_connectTypes["L-R#R-L"],
	},
	["L-B#B-L"]=
	{
		move=true,
		icon="L-B#B-L.png",
		connectInfo=Unit.ms_connectTypes["L-B#B-L"],
	},
	["L-T#T-L"]=
	{
		move=true,
		icon="L-T#T-L.png",
		connectInfo=Unit.ms_connectTypes["L-T#T-L"],
	},

	-- R begin -- 
	["R-T#T-R"]=
	{
		move=true,
		icon="R-T#T-R.png",
		connectInfo=Unit.ms_connectTypes["R-T#T-R"]
	},
	["R-B#B-R"]=
	{
		move=true,
		icon="R-B#B-R.png",
		connectInfo=Unit.ms_connectTypes["R-B#B-R"]
	},

	-- B begin --
	["B-T#T-B"]=
	{
		move=true,
		icon="B-T#T-B.png",
		connectInfo=Unit.ms_connectTypes["B-T#T-B"]
	},

	-- top begin -- 

	["L-R"]=
	{
		move=true,
		icon="L-R.png",
		connectInfo=Unit.ms_connectTypes["L-R"]
	},
	["R-L"]=
	{
		move=true,
		icon="R-L.png",
		connectInfo=Unit.ms_connectTypes["R-L"]
	},
	["R-T#T-R"]=
	{
		move=true,
		icon="R-T#T-R.png",
		connectInfo=Unit.ms_connectTypes["R-T#T-R.png"]
	}
}









