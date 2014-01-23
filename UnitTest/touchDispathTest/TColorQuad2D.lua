TColorQuad2D=f_newclass()


function TColorQuad2D:New()
	local size=math.random(50,150)
	local ret=ColorQuad2D:create(Rect2D(-size/2,-size/2,size,size),Color(math.random(0,255),math.random(0,255),math.random(0,255)))
	f_extends(ret,self)
	ret:Init()
	return ret
end

function TColorQuad2D:Init()
	self:setTouchEnabled(true)
end


function TColorQuad2D:onTouchBegin(x,y)
	local px,py=self:getPosition()

	self:setColor(Color(math.random(0,255),math.random(0,255),math.random(0,255)))
	self.m_diffx=x-px 
	self.m_diffy=y-py
	return true
end

function TColorQuad2D:onTouchMove(x,y)
	self:setPosition(-self.m_diffx+x,-self.m_diffy+y);
end

function TColorQuad2D:onHit2D(x,y)
	--print("onHit2D",x,y)
	local ret=self:hit2D(x,y)
	if ret then print(ret) end
	return ret
end

