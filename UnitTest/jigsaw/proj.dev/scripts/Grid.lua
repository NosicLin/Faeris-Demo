Grid={}
Grid.__index=Grid

function Grid:Alloc()
	local ret={}
	setmetatable(ret,Grid)
	return ret
end

function Grid:New(col,row)
	local ret=Grid:Alloc()
	ret:Init(col,row)
	return ret
end

function Grid:Init(col,row)
	self.m_grid={}
	self.m_column=col
	self.m_row=row
end


function Grid:Set(x,y,v)
	self.m_grid[x+self.m_column*y]=v
end


function Grid:Get(x,y)
	return self.m_grid[x+self.m_column*y]
end

function Grid:Clear()
	self.m_grid={}
end


function Grid:ShiftLeft(j)
	local head=self:Get(0,j)
	for i=0,self.m_column-2 do 
		local t=self:Get(i+1,j)
		self:Set(i,j,t)
	end
	self:Set(self.m_column-1,j,head)
end

function Grid:ShiftRight(j)
	local tail=self:Get(self.m_column-1,j)
	for i=self.m_column-1,1,-1 do 
		local t=self:Get(i-1,j)
		self:Set(i,j,t)
	end
	self:Set(0,j,tail)
end

function Grid:ShiftDown(i)
	local down=self:Get(i,self.m_row-1)
	for j=self.m_row-1,1,-1 do 
		--util.log("j=%d",j)
		local t=self:Get(i,j-1)
		self:Set(i,j,t)
	end
	self:Set(i,0,down)

end

function Grid:ShiftUp(i)
	local up=self:Get(i,0)
	for j=0,self.m_row-2 do 
		local t=self:Get(i,j+1)
		self:Set(i,j,t)
	end
	self:Set(i,self.m_row-1,up)
end


function Grid:ShuffleGrid(l)
	if not l then l=self.ms_defaultShuffleValue end 

	for i=0,l-1 do 
		local o_x=math.random(0,self.m_column-1)
		local o_y=math.random(0,self.m_row-1)

		local n_x=math.random(0,self.m_column-1)
		local n_y=math.random(0,self.m_row-1)

		local t=self:Get(o_x,o_y)
		self:Set(o_x,o_y,self:Get(n_x,n_y))
		self:Set(n_x,n_y,t)
	end 
end



-- static data --
Grid.ms_defaultShuffleValue =100 





