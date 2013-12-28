
local max_x=8
local max_y=10

local vertex={
	{x=2,y=7},
	{x=3,y=9},
	{x=4,y=8},
	{x=5,y=7.5},
	{x=6,y=6.5},
	{x=4,y=2.4}
}



local polygon=VertexPolygon:create()

for k,v in ipairs(vertex) do 

	polygon:append(v.x,v.y)

end

local hitarea=0.3

local color_quad=ColorQuad2D:create(Rect2D(-hitarea/2,-hitarea/2,hitarea,hitarea),Color.GREEN)




polygon.data={
	m_fillColor=Color.RED,
	m_outlineColor=Color.GREEN,

	onDraw=function(self,render) 

		self:setMode(VertexPolygon.TRIANGLE_FAN)
		self:setColor(self.m_fillColor)
		self:draw(render)

		self:setMode(VertexPolygon.LINE_LOOP)
		self:setColor(self.m_outlineColor)
		self:draw(render)

		for k,v in ipairs(vertex) do 

			color_quad:setPosition(v.x,v.y)
			color_quad:updateWorldMatrix()
			color_quad:draw(render)

		end

	end
}





local layer=Layer2D:create()

layer:setViewArea(-max_x,-max_y,2*max_x,2*max_y);
layer:add(polygon)
layer:setTouchEnabled(true)

layer.data={
	onTouchBegin=function(self,x,y)
		print("touchbegin")
		local x,y= self:toLayerCoord(x,y)

		self.m_lastPos={x=x,y=y}

		for k,v in ipairs(vertex) do 
			if math.abs(v.x-x)< hitarea then 
				if math.abs(v.y-y) < hitarea then 
					self.m_hitIndex=k 
					return 
				end 
			end
		end

	end,

	onTouchMove=function(self,x,y) 
		if not self.m_hitIndex then 
			return 
		end

		local x,y=self:toLayerCoord(x,y) 
		local diffx=x-self.m_lastPos.x 
		local diffy=y-self.m_lastPos.y 
		self.m_lastPos={x=x,y=y}

		vertex[self.m_hitIndex].x=vertex[self.m_hitIndex].x+diffx
		vertex[self.m_hitIndex].y=vertex[self.m_hitIndex].y+diffy

		polygon:setVertex(self.m_hitIndex-1,vertex[self.m_hitIndex].x,vertex[self.m_hitIndex].y)

	end,

	onTouchEnd=function(self,x,y) 
		self.m_hitIndex=nil
	end

}









local scene=Scene:create()
scene:push(layer)
share:director():run(scene)



























