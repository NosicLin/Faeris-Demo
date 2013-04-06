local SceneAbout_mText=
{
	{
		x=480,
		y=300,
		text="Faeris Game Studio",
		size=50,
		color=Color.RED,
	},

	{
		x=480,
		y=200,
		text="website: http://www.faeris.com",
		size=30,
		color=Color.WHITE,
	},

	{
		x=480,
		y=100,
		text="forum: http://www.faeris.com/dz",
		size=30,
		color=Color.WHITE,
	},

	{
		x=480,
		y=0,
		text="game: little game for test",
		size=30,
		color=Color.WHITE,
	},

	{
		x=480,
		y=-100,
		text="version: v.1.2",
		size=30,
		color=Color.WHITE,
	},

	{
		x=480,
		y=-200,
		text="mail: support@faeris.com",
		size=30,
		color=Color.WHITE,
	},

}

local MSGLAYER_DEFAULT_SPEED=300

local function MsgLayer_TouchBegin(self,x,y)
	self.data.needToMove=0
	self.data.moveSpeed=0
	self.data.lastpos={x=x,y=y}
	return true;
end

local function MsgLayer_ViewMove(self,diff)
	local data=self.data
	data.needToMove=diff
end

local function MsgLayer_TouchMove(self,x,y)

	local data=self.data
	local pos=self.data.lastpos;
	if not pos  then 
		pos={x=x,y=y}
	end

	local diff=pos.y-y
	data.moveSpeed=0

	data.lastpos={x=x,y=y}

	diff= diff*data.viewHeight

	data.viewY=data.viewY+diff
	self:setViewArea(data.viewX,data.viewY,data.viewWidth,data.viewHeight)

	if diff < 0  then 
		data.direction=0
	else 
		data.direction=1
	end

	return true;
end


local function MsgLayer_TouchEnd(self,x,y)
	MsgLayer_ViewMove(self,240)
	local data=self.data
	data.moveSpeed=MSGLAYER_DEFAULT_SPEED
end



local function MsgLayer_Update(self,dt)
	local data=self.data
	local ds=data.moveSpeed*dt/1000

	if ds >data.needToMove then 
		ds= data.needToMove 
	end

	data.moveSpeed=data.moveSpeed- dt/1000*MSGLAYER_DEFAULT_SPEED

	if data.moveSpeed < 0 then 
		data.moveSpeed =0 
	end


	data.needToMove=data.needToMove-ds

	if data.direction == 1 then 
		data.viewY=data.viewY+ds
	else 
		data.viewY=data.viewY-ds
	end



	self:setViewArea(data.viewX, data.viewY , data.viewWidth,data.viewHeight)

end






local function MsgLayer_Create()
	local layer= Layer2D:create();

	local i
	for i=1,#SceneAbout_mText do 
		local text=SceneAbout_mText[i]
		local font=FontTTF:create("simsun.ttc",text.size)
		local label=LabelTTF:create(text.text,font)
		label:setPosition(text.x,text.y)
		if text.color then 
			label:setColor(text.color)
		end
		label:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_CENTER)

		layer:add(label)
	end

	layer:setTouchEnabled(true)
	layer:setViewArea(0,0,960,640)


	layer.data={
		viewX=0,
		viewY=0,
		viewWidth=960,
		viewHeight=640,
		moveSpeed=0.5,
		needToMove=0,
		onTouchBegin=MsgLayer_TouchBegin,
		onTouchMove=MsgLayer_TouchMove,
		onTouchEnd=MsgLayer_TouchEnd,
		onUpdate=MsgLayer_Update,
	}
	return layer;
end

function BackLayer_Create()
	local layer=Layer2D:create()
	layer:setViewArea(0,0,960,640)

	local font=FontTTF:create("simsun.ttc",40)
	local label=LabelTTF:create("<<back",font)
	layer:add(label)

	label:setPosition(20,630)

	layer:setTouchEnabled(true)

	local function touch(self,x,y) 
		return false 
	end

	layer.data={
		onTouchBegin=function(self,x,y)
			x,y=self:toLayerCoord(x,y)
			if label:hit2D(x,y) then 

				share:director():pop()
				return true
			end
			return false
		end,
		onTouchMove=touch,
		onTouchEnd=touch,
	}
	return layer
end

function SceneAbout_New()
	local scene=Scene:create()
	local msg=MsgLayer_Create()
	local back=BackLayer_Create()
	scene:push(msg)
	scene:push(back)
	return scene;
end



































