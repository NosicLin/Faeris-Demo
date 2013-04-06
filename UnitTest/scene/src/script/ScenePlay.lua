local font=FontTTF:create("simsun.ttc",100)
local font2=FontTTF:create("simsun.ttc",50)
local alpahbet={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

local function Quad_UpdateDead(self,dt)
	local data=self.data
	local scale=data.scale
	data.scale=data.scale-dt/1000*1.5

	if data.scale <0 then 
		self:detach()
	else 
		self:setScale(scale,scale,1)
	end

end

local function Quad_UpdateLive(self,dt)
	local data=self.data
	data.posx=data.posx+dt/1000*data.speedx
	data.posy=data.posy+dt/1000*data.speedy

	if data.posx < 0 or data.posx >960 then 
		data.posx=math.random(0,960)
	end

	if data.posy <0 or data.posy >640 then 
		data.posy=math.random(0,640) 
	end 

	self:setPosition(data.posx,data.posy)

end 

local function Quad_New()
	local litter =alpahbet[math.random(1,#alpahbet)]
	print (litter)
	assert(font)
	local quad=LabelTTF:create(litter,font)
	local posx=math.random(0,960)
	local posy=math.random(0,640)
	local speedx=math.random(-5,5)*10
	local speedy=math.random(-5,5)*10
	local color=Color(math.random(100,255),math.random(100,255),math.random(100,255))

	quad:setPosition(posx,posy)
	quad:setColor(color)
	quad:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_CENTER)
	print(string.format("posx:%f,posy:,%f,speedx:%f,speedy:%f",posx,posy,speedx,speedy))

	quad.data={
		posx=posx,
		posy=posy,
		speedx=speedx,
		speedy=speedy,
		onUpdate=Quad_UpdateLive
	}

	quad.dead=function(self)
		self.data.scale=2
		self.data.onUpdate=Quad_UpdateDead
	end

	return quad
end

local function PlayLayer_OnTouchBegin(self,x,y)
	local data=self.data
	local quads=data.quads
	x,y=self:toLayerCoord(x,y)

	for key,value  in pairs(quads) do 
		if key:hit2D(x,y) then 
			key:dead()
			quads.key=nil
			data.score=data.score+10
			local new_quad=Quad_New()
			self:add(new_quad)
			quads[new_quad]=new_quad
		end
	end
	data.scoreLabel:setString("Score:"..data.score)
	return true;
end


local function PlayLayer_New()
	local layer=Layer2D:create()
	local label=LabelTTF:create("Score:0",font2)
	label:setPosition(20,620)
	layer.data={
		score=0,
		scoreLabel=label,
		onTouchBegin=PlayLayer_OnTouchBegin,
	}
	layer:add(label)

	local quads={}

	for i=0,10 do 
		local q=Quad_New()
		quads[q]=q
		layer:add(q)
	end

	layer.data.quads=quads
	layer:setViewArea(0,0,960,640)
	layer:setTouchEnabled(true)
	return layer
end

local function BackLayer_New()
	local layer=Layer2D:create()
	layer:setViewArea(0,0,960,640)

	local label=LabelTTF:create("<<back",font2)
	layer:add(label)

	label:setPosition(800,620)

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


function ScenePlay_New()
	local play_layer=PlayLayer_New()
	local back_layer=BackLayer_New()
	local scene=Scene:create()
	scene:push(play_layer)
	scene:push(back_layer)

	return scene;
end






