util.import("scripts/NsJigSaw_UiGrid.lua") 
util.import("scripts/Grid.lua")

NsJigSaw_UiGoal={} 
NsJigSaw_UiGoal.__index=NsJigSaw_UiGoal 


function NsJigSaw_UiGoal:New() 
	local ret=Layer2D:create()
	ret.data={}
	setmetatable(ret.data,NsJigSaw_UiGoal)

	ret:Init()
	ret:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)
	return ret
end

function NsJigSaw_UiGoal:Init()

	local group=Entity:create()
	local grid=Grid:New(self.ms_column,self.ms_row)
	for i=0,self.ms_column-1 do 
		for j=0,self.ms_row -1 do 
			local rect=self:GetUnitRect(i,j)
			local u=UiGrid_Unit:New() 
			u:setPosition(rect.x,rect.y)
			u:setRect2D(Rect2D(-rect.width/2,-rect.height/2,rect.width,rect.height))
			group:addChild(u)
			grid:Set(i,j,u)
		end
	end
	local color_quad=ColorQuad2D:create(Rect2D(0,0,GAME_WIDTH,GAME_HEIGHT),Color(155,155,155,155))
	color_quad:setZorder(-1)

	self:add(color_quad)

	group:setPosition(GAME_WIDTH/2,GAME_HEIGHT/2)
	self:add(group)
	self.m_group=group
	self.m_grid=grid 

	self:setTouchEnabled(true)
	self:setSortMode(Layer2D.SORT_ORDER_Z)
end

function NsJigSaw_UiGoal:LoadLevel(l)
	for i=0,self.ms_column-1 do 
		for j=0,self.ms_row - 1 do 
			local id = l.grid[i+self.ms_column*j]
			local res_url=l.res[id]
			local texture= share:textureMgr():load(res_url)
			local u=self.m_grid:Get(i,j)
			u:setTexture(texture)
		end
	end
end



function NsJigSaw_UiGoal:GetUnitRect(i,j) 
	local width=self.ms_unitSize.width 
	local height=self.ms_unitSize.height
	local x=(i-2)*width 
	local y=(2-j)*height
	return {x=x,y=y,width=width,height=height}
end

function NsJigSaw_UiGoal:Active() 
	self:setVisible(true)
	self.m_group:setPosition(100,100)

	self.m_group:setScale(0,0,1)

	self.m_time=self.ms_time
	self.m_dx=(GAME_WIDTH/2-100)/self.m_time
	self.m_dy=(GAME_HEIGHT/2-100)/self.m_time
	self.m_ds=1/self.m_time
	self.m_scale=0

	self.m_posx=100 
	self.m_posy=100

	self.onUpdate=self.OnUpdateActive 
end
function NsJigSaw_UiGoal:DisActive() 
	self.m_dx=-self.m_dx 
	self.m_dy=-self.m_dy
	self.m_scale=-self.m_scale 
	self.m_time=self.ms_time-self.m_time
	self.onUpdate=self.OnUpdateDisActive
end

function NsJigSaw_UiGoal:UpdateGroup(dt)
	local t=dt/1000 
	if t > self.m_time then 
		t=self.m_time 
	end
	self.m_time =self.m_time -t 
	self.m_posx =self.m_posx+self.m_dx*t
	self.m_posy =self.m_posy+self.m_dy*t 
	self.m_scale= self.m_scale+self.m_ds*t 

	self.m_group:setPosition(self.m_posx,self.m_posy) 
	self.m_group:setScale(self.m_scale,self.m_scale,1)
	util.log("scale=%f,x=%d,y=%f",self.m_scale,self.m_posx,self.m_posy)
	if self.m_time<=0  then 
		return true 
	end
	return false 

end

function NsJigSaw_UiGoal:OnUpdateActive(dt) 
	if self:UpdateGroup(dt) then 
		self.onUpdate=nil 
	end
end

function NsJigSaw_UiGoal:OnUpdateDisActive(dt) 
	if self:UpdateGroup(dt) then 
		self:setVisible(false)
	end
end



-- call back -- 


function NsJigSaw_UiGoal:onTouchBegin(x,y)
	self:DisActive()
	return true

end



-- static data -


NsJigSaw_UiGoal.ms_column=5 
NsJigSaw_UiGoal.ms_row=5 
NsJigSaw_UiGoal.ms_unitSize={height=100,width=100}
NsJigSaw_UiGoal.ms_time=0.2











