f_import("fps.lua")



local emitter=Particle2DEmitter:create("file.fpl")
assert(emitter)

local scene=Scene:create()

local layer=Layer2D:create();

local particle=Particle2DEffect:create(emitter)
particle:setPosition(480,320)

local quad=Quad2D:create("fire.png")
quad:setPosition(400,300)

assert(particle)

particle:start()

layer:setViewArea(0,0,960,640)
layer:add(particle)
layer:add(quad)

layer.data={}
layer.onUpdate=function(self,dt)
	self:update(dt)
	print(particle:getParticleNu())
end 
layer.onTouchBegin=function(self,x,y)
	local x,y= self:toLayerCoord(x,y)
	particle:setPosition(x,y)
end
layer.onTouchMove=function(self,x,y)
	local x,y= self:toLayerCoord(x,y)
	particle:setPosition(x,y)
end
layer.onDraw1=function() 
end

layer:setTouchEnabled(true)


scene:push(layer)

share:director():run(scene)

