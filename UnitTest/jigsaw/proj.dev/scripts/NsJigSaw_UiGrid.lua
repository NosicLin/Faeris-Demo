util.import("scripts/Grid.lua")

NsJigSaw_UiGrid={}
NsJigSaw_UiGrid.__index=NsJigSaw_UiGrid



UiGrid_Unit={}
UiGrid_Unit.__index=UiGrid_Unit 

function UiGrid_Unit:New()
	local ret=Quad2D:create("textures/unit_default.png")
	ret.data={}
	setmetatable(ret.data,UiGrid_Unit)
	return ret
end


-- ui grid --
function NsJigSaw_UiGrid:New()
	local ret=Layer2D:create()
	ret.data={}
	setmetatable(ret.data,NsJigSaw_UiGrid)
	ret:Init()

	ret:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)
	ret:setTouchEnabled(true)
	ret:setScissorEnabled(true)
	local sx=self.ms_gridPos.x/GAME_WIDTH 
	local sy=(self.ms_gridPos.y-self.ms_row*self.ms_unitSize.height)/GAME_HEIGHT 
	local swidth=self.ms_unitSize.width*self.ms_column/GAME_WIDTH 
	local sheight=self.ms_unitSize.height*self.ms_row/GAME_HEIGHT 
	ret:setScissorArea(sx,sy,swidth,sheight)
	return ret
end

function NsJigSaw_UiGrid:Init()

	local tmp_head=UiGrid_Unit:New()
	local tmp_tail=UiGrid_Unit:New() 
	tmp_head:setRect2D(Rect2D(-self.ms_unitSize.width/2,-self.ms_unitSize.height/2,self.ms_unitSize.width,self.ms_unitSize.height))
	tmp_tail:setRect2D(Rect2D(-self.ms_unitSize.width/2,-self.ms_unitSize.height/2,self.ms_unitSize.width,self.ms_unitSize.height))
	self:add(tmp_head)
	self:add(tmp_tail)


	local grid=Grid:New(self.ms_column,self.ms_row)
	for i=0,self.ms_column-1 do 
		for j=0,self.ms_row -1 do 
			local rect=self:GetUnitRect(i,j)
			local u=UiGrid_Unit:New() 
			u:setPosition(rect.x,rect.y)
			u:setRect2D(Rect2D(-rect.width/2,-rect.height/2,rect.width,rect.height))
			self:add(u)
			grid:Set(i,j,u)
		end
	end

	self.m_tmpHead=tmp_head 
	self.m_tmpTail=tmp_tail
	self.m_grid=grid

	self.onTouchBegin=self.TouchBeginNormal

end



function NsJigSaw_UiGrid:LoadLevel(l)
	for i=0,self.ms_column-1 do 
		for j=0,self.ms_row - 1 do 
			local id = l.grid[i+self.ms_column*j]
			local res_url=l.res[id]
			local texture= share:textureMgr():load(res_url)
			local u=self.m_grid:Get(i,j)
			u:setTexture(texture)
			u.m_id=id
		end
	end

	self.m_level=l

	repeat 
		self.m_grid:ShuffleGrid()
	until not self:CheckSuccess()

	self:AdjustGridPosQuick()
end


function NsJigSaw_UiGrid:CheckSuccess()
	for i=0,self.ms_column-1 do 
		for j=0,self.ms_row-1 do 
			local id = self.m_level.grid[i+self.ms_column*j] 
			local u=self.m_grid:Get(i,j) 
			if u.m_id ~= id  then 
				return false 
			end
		end
	end 
	return true 
end

function NsJigSaw_UiGrid:GetUnitRect(i,j)
	local x=self.ms_gridPos.x+self.ms_unitSize.width/2+self.ms_unitSize.width*i
	local y=self.ms_gridPos.y-self.ms_unitSize.height/2-self.ms_unitSize.height*j
	return {x=x,y=y,width=self.ms_unitSize.width,height=self.ms_unitSize.height}
end

function NsJigSaw_UiGrid:GetHitUnitCoord(x,y)
	local i=(x-self.ms_gridPos.x)/self.ms_unitSize.width
	local j=(self.ms_gridPos.y-y)/self.ms_unitSize.height

	return math.floor(i),math.floor(j)
end


function NsJigSaw_UiGrid:AdjustColumnPosQuick(row,diffx) 
	local head_texture=nil
	local tail_texture=nil
	local grid_gap=math.floor(math.abs(diffx)*GAME_WIDTH/self.ms_unitSize.width)
	if diffx <0 then grid_gap=grid_gap*(-1) end
	local dt=diffx*GAME_WIDTH-grid_gap*self.ms_unitSize.width
	for i=0,self.ms_column-1 do 
		--util.log("i=%d,row=%d",i,row)
		local u=self.m_grid:Get(i,row)
		local col=(i+grid_gap)%self.ms_column
		local rect=self:GetUnitRect(col,row)
		if col ==0 then 
			head_texture=u:getTexture()
		elseif col == self.ms_column-1 then 
			tail_texture=u:getTexture()
		end

		u:setPosition(rect.x+dt,rect.y)
	end
	local rect_head=self:GetUnitRect(-1,row)
	local rect_tail=self:GetUnitRect(self.ms_column,row)
	self.m_tmpHead:setTexture(tail_texture)
	self.m_tmpHead:setPosition(rect_head.x+dt,rect_head.y)

	self.m_tmpTail:setTexture(head_texture)
	self.m_tmpTail:setPosition(rect_tail.x+dt,rect_tail.y)

end


function NsJigSaw_UiGrid:AdjustRowPosQuick(col,diffy) 
	--	util.log("row=%d",col)
	local head_texture=nil
	local tail_texture=nil

	local grid_gap=math.floor(math.abs(diffy)*GAME_HEIGHT/self.ms_unitSize.height)
	if diffy <0 then grid_gap=grid_gap*(-1) end

	local dt=diffy*GAME_HEIGHT-grid_gap*self.ms_unitSize.height

	--util.log("dt=%d",dt)
	for j=0,self.ms_row-1 do 
		local u=self.m_grid:Get(col,j)
		local row=(j-grid_gap)%self.ms_row
		local rect=self:GetUnitRect(col,row)
		if row==0 then 
			head_texture=u:getTexture()
		elseif row== self.ms_row-1 then 
			tail_texture=u:getTexture()
		end
		u:setPosition(rect.x,rect.y+dt)
	end

	local rect_head=self:GetUnitRect(col,-1)
	local rect_tail=self:GetUnitRect(col,self.ms_row)

	self.m_tmpHead:setTexture(tail_texture)
	self.m_tmpHead:setPosition(rect_head.x,rect_head.y+dt)

	self.m_tmpTail:setTexture(head_texture)
	self.m_tmpTail:setPosition(rect_tail.x,rect_tail.y+dt)
end

function NsJigSaw_UiGrid:AdjustGridPosQuick() 
	for i=0,self.ms_column-1 do 
		for j=0,self.ms_row-1 do 
			local u=self.m_grid:Get(i,j)
			local rect=self:GetUnitRect(i,j) 
			u:setPosition(rect.x,rect.y)
		end
	end
end


function NsJigSaw_UiGrid:SetGridColumnPos()
	local shift=math.floor((self.m_diffx*GAME_WIDTH+self.ms_unitSize.width/2)/self.ms_unitSize.width)
	local loop=math.abs(shift) 

	if shift>0 then 
		for i=0,loop-1 do 
			self.m_grid:ShiftRight(self.m_hit.row)
		end
	elseif shift<0 then  
		for i=0,loop-1 do 
			self.m_grid:ShiftLeft(self.m_hit.row)
		end
	end
end

function NsJigSaw_UiGrid:SetGridRowPos() 
	local shift=math.floor((self.m_diffy*GAME_HEIGHT+self.ms_unitSize.height/2)/self.ms_unitSize.height)
	local loop=math.abs(shift)
	if shift > 0 then 
		for j=0,loop-1 do 
			self.m_grid:ShiftUp(self.m_hit.col) 
		end
	elseif shift < 0 then 
		for j=0,loop-1 do 
			self.m_grid:ShiftDown(self.m_hit.col)
		end
	end

end


function NsJigSaw_UiGrid:AdjustColumnPosSlow() 
	local rect=self:GetUnitRect(2,self.m_hit.row) 
	local u=self.m_grid:Get(2,self.m_hit.row)
	local x,y=u:getPosition()
	local dt=x-rect.x 
	local speed = nil 

	if dt == 0 then 
		speed =self.ms_speed 
	else 
		speed = -dt/math.abs(dt)* self.ms_speed 
	end

	local time = math.abs(dt/speed*1000) 

	self.m_slowDirection="column"
	self.m_slowHit={col=self.m_hit.col,row=self.m_hit.row}
	self.m_slowTime=time
	self.m_slowDt=dt
	self.m_slowSpeed=speed
	self.onUpdate=self.UpdateAdjustPosSlow

end

function NsJigSaw_UiGrid:AdjustRowPosSlow() 
	local rect=self:GetUnitRect(self.m_hit.col,2) 
	local u=self.m_grid:Get(self.m_hit.col,2)
	local x,y=u:getPosition()
	local dt=y-rect.y 

	local speed=nil 

	if dt ==0 then 
		speed=self.ms_speed
	else 
		speed=-dt/math.abs(dt)*self.ms_speed 
	end

	local time=math.abs(dt/speed*1000)

	self.m_slowDirection="row"
	self.m_slowHit={col=self.m_hit.col,row=self.m_hit.row}
	self.m_slowTime=time
	self.m_slowDt=dt
	self.m_slowSpeed=speed
	self.onUpdate=self.UpdateAdjustPosSlow

	--util.log("slow time=%d ,dt=%d,speed=%d",time,dt,speed)
end 


-- call back -- 
function NsJigSaw_UiGrid:UpdateAdjustPosSlow(time) 
	if time > self.m_slowTime then 
		if self.m_slowTime < 0 then 
			time =0 
		else 
			time = self.m_slowTime 
		end
	end
	self.m_slowTime= self.m_slowTime - time 

	local dt=time/1000*self.m_slowSpeed 

	self.m_slowDt=self.m_slowDt+dt

	--util.log("time=%f,self.time=%f,dt=%f,self.m_slowSpeed=%d",time,self.m_slowTime,self.m_slowDt, self.m_slowSpeed)

	if self.m_slowDirection == "row" then 
		self:AdjustRowPosQuick(self.m_slowHit.col,self.m_slowDt/GAME_HEIGHT)

	elseif self.m_slowDirection== "column" then 
		self:AdjustColumnPosQuick(self.m_slowHit.row,self.m_slowDt/GAME_WIDTH)
	else 
		assert(0) 
	end
	if self.m_slowTime <=0 then 
		self.m_moveLock=false 
		self.onUpdate=nil 
		self:AdjustGridPosQuick()
	end
end 


function NsJigSaw_UiGrid:TouchBeginNormal(x,y) 
	self.m_lastPos={x=x,y=y}
	self.m_diffx=0 
	self.m_diffy=0 
	self.m_moveTime=0
	self.m_direction=nil
	self.onTouchMove=self.TouchMoveNormal
	self.onTouchEnd=self.TouchEndNormal
	local lx,ly=self:toLayerCoord(x,y)
	local i,j= self:GetHitUnitCoord(lx,ly)
	self.m_hit={col=i,row=j}
	--util.log("i="..i.." j="..j )

end

function  NsJigSaw_UiGrid:TouchMoveNormal(x,y) 
	local dx=x-self.m_lastPos.x 
	local dy=y-self.m_lastPos.y 
	self.m_diffx=self.m_diffx+dx 
	self.m_diffy=self.m_diffy+dy 

	self.m_moveTime=self.m_moveTime+1 

	if self.m_moveLock then 
		return 
	end

	if not self.m_direction then 
		if self.m_moveTime > 3 then 
			if math.abs(self.m_diffx) > math.abs(self.m_diffy) then 
				self.m_direction="column" 
			else 
				self.m_direction="row"
			end
			self.m_diffx=0
			self.m_diffy=0
		end 

	elseif self.m_direction  == "column" then 
		--util.log("direction =column(%d) diffx=%d",self.m_hit.col,self.m_diffx)
		self:AdjustColumnPosQuick(self.m_hit.row,self.m_diffx)
	elseif self.m_direction  == "row" then 
		self:AdjustRowPosQuick(self.m_hit.col,self.m_diffy)
	end

	self.m_lastPos={x=x,y=y}
end

function NsJigSaw_UiGrid:TouchEndNormal(x,y) 
	self.m_moveLock =true 
	if not self.m_direction  then 
		self.m_moveLock=false
	elseif self.m_direction == "column" then 
		self:SetGridColumnPos()
		self:AdjustColumnPosSlow()
	elseif self.m_direction == "row" then 
		self:SetGridRowPos()
		self:AdjustRowPosSlow()
	end

	if self:CheckSuccess() then 
		local scene=share:director():current()
		scene:Success()
	end

	self.onTouchMove=nil 
	self.onTouchEnd=nil
end

-- static data -- 

NsJigSaw_UiGrid.ms_column=5
NsJigSaw_UiGrid.ms_row=5

NsJigSaw_UiGrid.ms_unitSize={width=128,height=128}
NsJigSaw_UiGrid.ms_gridPos={x=0,y=810}
NsJigSaw_UiGrid.ms_defaultShuffleValue=100

NsJigSaw_UiGrid.ms_speed=256



















