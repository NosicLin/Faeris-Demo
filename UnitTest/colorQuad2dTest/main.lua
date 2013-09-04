local quad=ColorQuad2D:create(Rect2D(20,20,500,30),Color.RED)
quad.data=
{
	onUpdate=function(self,dt) 
		local rect=self:getRect2D()
		rect.width=rect.width-0.1
		self:setRect2D(rect)
	end

}


local scene=Scene:create()
local layer=Layer2D:create()
layer:setViewArea(0,0,960,640)

scene:push(layer)
layer:add(quad)

share:director():run(scene)
