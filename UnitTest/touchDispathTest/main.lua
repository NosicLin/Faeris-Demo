f_import("TColorQuad2D.lua")
scene=Scene:create()

layer=Layer2D:create()
layer:setViewArea(0,0,1024,960)
layer:setTouchEnabled(true)
layer:setSortMode(Layer2D.SORT_ORDER_Z);
layer:setDispatchTouchEnabled(true)

for i=1,30 do 
	local t=TColorQuad2D:New()
	layer:add(t)
	t:setPosition(math.random(0,1024),math.random(0,960))
end


scene:push(layer)

share:director():run(scene)




