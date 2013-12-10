g_GpsProvider=GpsProvider:create()

local scene=Scene:create()

local layer=Layer2D:create()

layer:setViewArea(0,0,1024,800)

font= FontTTF:create("simsun.ttc",40)


local t=LabelTTF:create("aaa",font)
t:setPosition(512,400)

layer.data={
	onUpdate=function(self,dt)
		local d1,t1=g_GpsProvider:getLastKnownLocation()
		t:setString("Gps:"..tostring(d1).." "..tostring(t1)) 
	end

}

layer:add(t)
scene:push(layer)

share:director():run(scene)

















