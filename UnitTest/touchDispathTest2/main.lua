f_import("TColorQuad2D.lua")
scene=Scene:create()

layer=Layer2D:create()

layer:setViewArea(0,0,1024,960)
layer:setTouchEnabled(true)
layer:setSortMode(Layer2D.SORT_ORDER_Z);
layer:setDispatchTouchEnabled(true)


local panelx,panely=1024*0.8,960*0.8 


local panel=Panel:create(panelx,panely)
panel:setPosition(1024/2,960/2)
panel:setDispatchTouchEnabled(true)
panel:setScissorEnabled(false)

local color=ColorQuad2D:create(Rect2D(-panelx/2,-panely/2,panelx,panely),Color(255,255,0,100))
color:setZorder(-1)
panel:addChild(color)

layer:add(panel)





for i=1,30 do 
	local t=TColorQuad2D:New()
	panel:addChild(t)
	t:setPosition(math.random(-1024/2,1024/2),math.random(-960/2,960/2))
end


scene:push(layer)

share:director():run(scene)




