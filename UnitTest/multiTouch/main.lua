NS_MulTouchLayer={}

NS_MulTouchLayer.__index=NS_MulTouchLayer 


function NS_MulTouchLayer:Create()
	local layer=Layer2D:create()
	layer.data={}
	setmetatable(layer.data,NS_MulTouchLayer);
	layer.m_touchobj={}

	layer:setViewArea(0,0,960,640)
	layer:setTouchEnabled(true);
	return layer
end


function NS_MulTouchLayer:onTouchesBegin(point_nu, event)
	local id,x,y=event[0].id,event[0].x,event[0].y
	local q=Quad2D:create("circle.png",50,50);
	x,y=self:toLayerCoord(x,y)
	q:setPosition(x,y)
	self:add(q)
	self.m_touchobj[id]=q
end

function NS_MulTouchLayer:onTouchesPointerDown(point_nu,event)
	local id,x,y=event[0].id,event[0].x,event[0].y
	local q=Quad2D:create("circle.png",50,50);
	x,y=self:toLayerCoord(x,y)
	q:setPosition(x,y)
	self:add(q)
	self.m_touchobj[id]=q
end

function NS_MulTouchLayer:onTouchesMove(point_nu,event)
	for i=0,point_nu-1 do 
		local id,x,y=event[i].id,event[i].x,event[i].y 
		x,y=self:toLayerCoord(x,y)
		local q=self.m_touchobj[id]
		q:setPosition(x,y)
	end
end


function NS_MulTouchLayer:onTouchesPointerUp(point_nu,event)
	local id,x,y=event[0].id,event[0].x,event[0].y
	local q=self.m_touchobj[id]
	q:detach()
	self.m_touchobj[q]=nil
end


function NS_MulTouchLayer:onTouchesEnd(point_nu, event )
	print("on touch end")
	local id,x,y=event[0].id,event[0].x,event[0].y
	local q=self.m_touchobj[id]
	q:detach()
	self.m_touchobj[q]=nil
end



local scene=Scene:create()
local layer=NS_MulTouchLayer:Create()

scene:push(layer);


share:director():run(scene)




