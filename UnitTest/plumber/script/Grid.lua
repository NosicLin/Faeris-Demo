Grid={}
Grid.__index=Grid 

function Grid:Create(row,column)
	local ret={}
	ret.m_row=row
	ret.m_column=column
	ret.m_grids={}
	setmetatable(ret,Grid)
	return ret
end

function Grid:Get(x,y)
	local ret=self.m_grids[y*self.m_column+x]
	return ret
end

function Grid:Set(x,y,value) 
	self.m_grids[y*self.m_column+x]=value
end


