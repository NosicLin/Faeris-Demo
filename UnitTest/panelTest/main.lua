scene=Scene:create()

layer=Layer2D:create()
layer:setViewArea(0,0,1024,960)
layer:setTouchEnabled(true)
layer:setSortMode(Layer2D.SORT_ORDER_Z);

layer.data={
	ViewX=0,
	ViewY=0,
	ViewWidth=1024,
	ViewHeight=960,
	onTouchBegin=function(self,x,y)
		self:touchBegin(x,y)

		self.m_lastPos={x=x,y=y}
		local tx,ty=self:toLayerCoord(x,y)
		local mat=self:getProjectMatrix()
		local v=mat:mulVector3(Vector3(tx,ty,0))

	end,
	onTouchMove=function(self,x,y)
		self:touchMove(x,y)
		local diffx=x-self.m_lastPos.x 
		local diffy=y-self.m_lastPos.y
		
		self.ViewX=self.ViewX-1024*diffx 
		self.ViewY=self.ViewY-960*diffy
		self:setViewArea(self.ViewX,self.ViewY,self.ViewWidth,self.ViewHeight)

		self.m_lastPos={x=x,y=y}
	end
}

local width,height=300,300
local panel=Panel:create(width,height)


local c_quad_middle=ColorQuad2D:create(Rect2D(-width/2,-height/2,width,height),Color(255,255,0,125));

local width,height=150,150
local c_quad_small=ColorQuad2D:create(Rect2D(-width/2,-height/2,width,height),Color(0,255,0,125));

local width,height=600,600
local c_quad_big=ColorQuad2D:create(Rect2D(-width/2,-height/2,width,height),Color(0,0,255,125));



panel:doAction(RotateZToAction:create(30000,10000))

local seqAction=SeqAction:create()
seqAction:addAction(ScaleToAction:create(0.1,0.1,10))
seqAction:addAction(ScaleToAction:create(1,1,10))

local seq2=SeqAction:create()
seq2:addAction(MoveByAction:create(200,0,10))
seq2:addAction(MoveByAction:create(-200,0,10))

panel:doAction(seqAction)
panel:doAction(seq2)


--panel:setScissorEnabled(false)

panel:addChild(c_quad_big)
panel:addChild(c_quad_middle)
panel:addChild(c_quad_small)

panel:setPosition(512,480)


layer:add(panel)

layer:setDispatchTouchEnabled(true);



scene:push(layer)

share:director():run(scene)




