PlayLayer={}
PlayLayer.__index=PlayLayer 


function PlayLayer:Create(level_param)
	local ret=PlayLayer:New()
	ret:Init(level_param)
	return ret
end

function PlayLayer:New()
	local layer=Layer2D:create()
	layer.data={}
	setmetatable(layer.data,PlayLayer)

	return layer
end



function PlayLayer:Init(level_param)
	self.m_grids=Grid:Create(self.ms_gridColumn,self.ms_gridRow)
	local grid=self:RandomGrid(level_param.grids)
	for i=0,self.ms_gridColumn-1 do 
		for j=0,self.ms_gridRow-1 do 
			local u_type=grid[j][i] 
			if u_type ~="N" then 
				local unit=Unit:Create(u_type)
				local rect=self:GetGridRect(i,j)
				unit:setRect2D(Rect2D(-rect.width/2,-rect.height/2,rect.width,rect.height))
				unit:setPosition(rect.x,rect.y)
				--util.log("x=%f,y=%f,width=%f,height=%f",rect.x,rect.y,rect.width,rect.height)
				self.m_grids:Set(i,j,unit)
				self:add(unit)
			end
		end
	end 

	local water_in={}

	for _,v in pairs(level_param.waterIn) do 
		local quad=Quad2D:create("textures/water_in.png",self.ms_gridSize.width,self.ms_gridSize.height)
		local rect=self:GetGridRect(v.x,v.y)
		quad:setPosition(rect.x,rect.y)
		self:add(quad)
		water_in[quad]=quad
		self.m_waterIn=water_in
	end


	local water_out={}
	for _,v in pairs(level_param.waterOut) do 
		local quad=Quad2D:create("textures/water_out.png",self.ms_gridSize.width,self.ms_gridSize.height)
		local rect=self:GetGridRect(v.x,v.y)
		quad:setPosition(rect.x,rect.y)
		self:add(quad)
		water_out[quad]=quad
		self.m_waterOut=water_out
	end

	self:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)

	self:setTouchEnabled(true)

	-- call back -- 
	self.onTouchBegin=PlayLayer.onTouchBegin 
end



function PlayLayer:GetGridRect(i,j)
	local startx=self.ms_gridPos.x
	local starty=self.ms_gridPos.y
	local posx=startx+self.ms_gridSize.width*i
	local posy=starty-self.ms_gridSize.height*j

	return {
		x=posx+self.ms_gridSize.width/2,
		y=posy-self.ms_gridSize.height/2,
		width=self.ms_gridSize.width,
		height=self.ms_gridSize.height,
	}
end

function PlayLayer:GetHitGrid(x,y)
	local lx=x-self.ms_gridPos.x 
	local ly=self.ms_gridPos.y-y

	util.log("lx=%d,ly=%d",lx,ly)

	if lx <0 or lx > self.ms_gridSize.width * self.ms_gridColumn then 

		return nil
	end 

	if ly <0 or ly > self.ms_gridSize.height * self.ms_gridRow then 
		return nil 
	end 

	return math.floor(lx/self.ms_gridSize.width),math.floor(ly/self.ms_gridSize.height)
end


function PlayLayer:RandomGrid(grid)
	local ret={}
	for k,v in pairs(grid) do 
		ret[k]=v 
	end
	for i=0,100 do 
		local x0=math.random(0,self.ms_gridColumn-1)
		local y0=math.random(0,self.ms_gridRow-1)
		local x1=math.random(0,self.ms_gridColumn-1)
		local y1=math.random(0,self.ms_gridRow-1)

		local t=ret[y0][x0]
		ret[y0][x0]=grid[y1][x1]
		ret[y1][x1]=t
	end

	return ret
end


-- call back --

function PlayLayer:onTouchBegin(x,y)
	local x,y=self:toLayerCoord(x,y)

	local c,r=self:GetHitGrid(x,y) 
	if not ( c and r ) then 
		util.log("not touch grid")
		return 
	end

	util.log("touch grid:%d,%d",c,r)

	local unit=self.m_grids:Get(c,r)

	if not unit then 
		return 
	end 


	-- top --
	if  r ~= 0  then 
		local target=self.m_grids:Get(c,r-1)
		if not target then 
			self.m_grids:Set(c,r-1,unit)
			self.m_grids:Set(c,r,nil)
			local rect=self:GetGridRect(c,r-1) 
			unit:MoveTo(rect.x,rect.y,self.ms_moveTime)
			return 
		end
	end 
	
	-- bottom --
	if  r ~= self.ms_gridRow -1 then 
		local target=self.m_grids:Get(c,r+1)
		if not target then 
			self.m_grids:Set(c,r+1,unit)
			self.m_grids:Set(c,r,nil)
			local rect=self:GetGridRect(c,r+1)
			unit:MoveTo(rect.x,rect.y,self.ms_moveTime)
			return 
		end
	end

	-- left -- 
	if c ~= 0 then 
		local target=self.m_grids:Get(c-1,r)
		if not target then 
			self.m_grids:Set(c-1,r,unit)
			self.m_grids:Set(c,r,nil)
			local rect=self:GetGridRect(c-1,r)
			unit:MoveTo(rect.x,rect.y,self.ms_moveTime)
			return 
		end
	end


	-- right -- 
	if c ~= self.ms_gridColumn-1 then 
		local target=self.m_grids:Get(c+1,r)
		if not target then 
			self.m_grids:Set(c+1,r,unit)
			self.m_grids:Set(c,r,nil)
			local rect=self:GetGridRect(c+1,r)
			unit:MoveTo(rect.x,rect.y,self.ms_moveTime)
			return 
		end
	end

end


--static data -- 

PlayLayer.ms_gridColumn=4
PlayLayer.ms_gridRow=7
PlayLayer.ms_gridSize={width=100,height=100}
PlayLayer.ms_gridPos={x=120,y=860}

PlayLayer.ms_moveTime=250


























