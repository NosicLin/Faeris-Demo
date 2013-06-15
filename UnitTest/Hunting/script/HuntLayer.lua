HuntLayer={}
HuntLayer.__index=HuntLayer


function HuntLayer:New()
	local layer=Layer2D:create()
	layer.data={
		onTouchBegin=HuntLayer.onTouchBegin,
		onTouchMove=HuntLayer.onTouchMove,
		onTouchEnd=HuntLayer.onTouchEnd,
	}
	setmetatable(layer.data,HuntLayer)
	return layer
end

function HuntLayer:Init()
	self:InitEnvironment()
	self.m_viewArea={x=0,y=0,width=GAME_WIDTH,height=GAME_HEIGHT}
	self:AdjustViewArea()
	self:setTouchEnabled(true)
	self.m_birds={}

	for i=0,2 do 
		self:NewBird()
	end


	local sight_glass=Quad2D:create("textures/sightglass.png",self.ms_sightGlassWidth,self.ms_sightGlassHeight)
	sight_glass:setVisible(false)
	sight_glass:setZorder(1)
	self:add(sight_glass)
	self.m_sightGlass=sight_glass
	self:setSortMode(Layer2D.SORT_ORDER_Z)
end

function HuntLayer:NewBird()
	local bird=Bird:Create()
	bird:setZorder(0)
	self:add(bird)
	self.m_birds[bird]=bird
end



function HuntLayer:InitEnvironment()
	local background=Quad2D:create("textures/background.png",Rect2D(0,0,GAME_WIDTH,GAME_HEIGHT))
	background:setPosition(0,0)
	background:setZorder(-1)

	self:add(background)
end


function HuntLayer:Create()
	local ret=HuntLayer:New()
	ret:Init()
	return ret
end

function HuntLayer:EnlargeViewArea(x,y)
	local lx,ly=self:toLayerCoord(x,y)
	self.m_viewArea=
	{
		x=lx-x*self.ms_enlargeWidth,
		y=ly-y*self.ms_enlargeHeight,
		width=self.ms_enlargeWidth,
		height=self.ms_enlargeHeight,
	}
	print(string.format("view area x=%.2f,y=%.2f,width=%.2f,height=%.2f",self.m_viewArea.x,self.m_viewArea.y,self.m_viewArea.width,self.m_viewArea.height))

	self:AdjustViewArea()
end

function HuntLayer:MoveViewArea(x,y)
	local diffx,diffy=self.m_lastpos.x-x,self.m_lastpos.y-y
	self.m_viewArea.x=self.m_viewArea.x+self.m_viewArea.width*diffx
	self.m_viewArea.y=self.m_viewArea.y+self.m_viewArea.height*diffy
	self:AdjustViewArea()
end

function HuntLayer:AdjustViewArea()
	local view=self.m_viewArea
	self:setViewArea(view.x,view.y,view.width,view.height)
end


function HuntLayer:RestoreViewArea(x,y)
	self.m_viewArea={x=0,y=0,width=GAME_WIDTH,height=GAME_HEIGHT}
	self:AdjustViewArea()
end


function HuntLayer:Fire(x,y)
	local x,y =self:toLayerCoord(x,y)
	local dead_birds={}
	local dead_nu=0
	for _,v in pairs(self.m_birds) do 
		if v:Hit(x,y) then 
			v:Dead()
			dead_birds[v]=v
			dead_nu=dead_nu+1
		end
	end

	

	for _,v in pairs(dead_birds) do 
		self.m_birds[v]=nil
	end

	for i=0,dead_nu-1 do 
		self:NewBird()
	end

end

function HuntLayer:MoveSightClass(x,y)
	local diffx,diffy=self.m_lastpos.x-x,self.m_lastpos.y-y
	local gx,gy=self.m_sightGlass:getPosition()
	local rx=gx-diffx*self.m_viewArea.width
	local ry=gy-diffy*self.m_viewArea.height

	print (string.format("rx=%.2f,ry=%.2f",rx,ry))
	self.m_sightGlass:setPosition(rx,ry)
								  
end
	

-- event call back --
function HuntLayer:onTouchBegin(x,y)
	self:EnlargeViewArea(x,y)
	self.m_lastpos= { x=x, y=y }
	self.m_sightGlass:setVisible(true)
	local lx,ly=self:toLayerCoord(x,y)
	self.m_sightGlass:setPosition(lx,ly)
end

function HuntLayer:onTouchMove(x,y)
	print("touch move")
	--self:MoveViewArea(x,y)
	self:MoveSightClass(x,y)
	self.m_lastpos={x=x,y=y}
end

function HuntLayer:onTouchEnd(x,y)
	print("touch end")
	self:Fire(x,y)
	self:RestoreViewArea(x,y)
	self.m_sightGlass:setVisible(false)
end





-- static data --


HuntLayer.ms_enlargeWidth=960/3
HuntLayer.ms_enlargeHeight=640/3
HuntLayer.ms_sightGlassWidth=48
HuntLayer.ms_sightGlassHeight=48


















