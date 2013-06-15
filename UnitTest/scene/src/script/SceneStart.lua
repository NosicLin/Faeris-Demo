-- quit layer 


local function QuitLayer_New()
	local font=FontTTF:create("simsun.ttc",80)
	local layer=Layer2D:create()
	layer:setViewArea(0,0,960,640)

	local msg= LabelTTF:create("Are You Sure To Quit?",font);
	local quit=LabelTTF:create("Quit",font);
	local cancel=LabelTTF:create("Cancel",font);


	msg:setPosition(480,500)
	msg:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_CENTER)
	msg:setColor(Color.RED)

	quit:setPosition(200,200)
	quit:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_CENTER)
	quit:setColor(Color.RED)

	cancel:setPosition(760,200)
	cancel:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_CENTER)
	cancel:setColor(Color.RED)


	layer:add(msg)
	layer:add(quit)
	layer:add(cancel)
	layer.data={
		quit=quit,
		cancel=cancel,
		onTouchBegin=function(self,x,y)
			local data=self.data
			local x,y=self:toLayerCoord(x,y)
			if data.quit:hit2D(x,y) then 
				share:scheduler():stop()
			elseif data.cancel:hit2D(x,y) then 
				local scene=share:director():current()
				scene:pop()
				scene:pop()
			end
			return true
		end
	}
	layer:setTouchEnabled(true);
	return layer;
end


-- main layer 
local function StartLayer_SelectUpdate(self,dt) 
	self:update(dt)  --call layer update 
end


local function StartLayer_SelectTouchBegin(self,x,y)
	print "select touch "
	local x,y=self:toLayerCoord(x,y)
	local data=self.data
	local focus=nil
	if data.play:hit2D(x,y) then
		focus=data.play
	elseif data.quit:hit2D(x,y) then 
		focus=data.quit
	elseif data.setting:hit2D(x,y) then 
		focus=data.setting 
	end
	self:setFocus(focus)

	return true
end


local function StartLayer_SelectTouchEnd(self,x,y)
	local x,y=self:toLayerCoord(x,y)
	local data=self.data
	if not data.focus then 
		return true
	end
	local focus=data.focus
	self:setFocus(nil)

	local scene = share:director():current()
	if focus == data.play then 
		data.nextScene=ScenePlay_New() 
		local fade_layer=ColorLayer:create(Color(0,0,0,0))
		data.fadeLayer=fade_layer
		data.fadeAlpha=0
		scene:push(fade_layer)
		util.changeCallBack(self,StartLayer_mExitCallBack)

	elseif  focus ==data.setting then 
		data.nextScene=SceneAbout_New()
		local fade_layer=ColorLayer:create(Color(0,0,0,0))
		data.fadeLayer=fade_layer
		data.fadeAlpha=0
		scene:push(fade_layer)

		util.changeCallBack(self,StartLayer_mExitCallBack)
	elseif focus == data.quit then 
		local facd_layer=ColorLayer:create(Color(55,55,55,200))
		scene:push(facd_layer)
		scene:push(QuitLayer_New())
	end
	return true
end





local function StartLayer_StartUpdate(self,dt)
	print (dt)
	self:update(dt) 
	local total_frame=self.data.back_ground:getTotalFrame()
	local cur_frame=self.data.back_ground:getCurFrame()

	if total_frame -1 == cur_frame then 
		self.data.play:setVisible(true)
		self.data.quit:setVisible(true)
		self.data.setting:setVisible(true)
		util.changeCallBack(self,StartLayer_mSelectCallBack)
	end
end


local function StartLayer_UpdateSelect(self,dt)
	self:update(dt)
end

local function StartLayer_ExitUpdate(self,dt)
	local data=self.data
	data.fadeAlpha=data.fadeAlpha+dt/1000*255
	if data.fadeAlpha >255 then 
		data.fadeAlpha=nil
		data.fadeLayer=nil
		local director=share:director()
		local scene=director:current()
		scene:pop()
		director:push()
		director:run(self.data.nextScene)
	else 
		data.fadeLayer:setColor(Color(0,0,0,data.fadeAlpha))
	end
end



local function StartLayer_CreateData()
	local back_ground=Sprite2D:create("sprites/start.fst")
	local play=Quad2D:create("textures/play.png",122,43)
	play:setPosition(480,240)
	local quit=Quad2D:create("textures/quit.png",122,43)
	quit:setPosition(480,180)

	local setting=Quad2D:create("textures/settings.png",270,46)
	setting:setPosition(480,120)

	local data={
		play=play,
		back_ground=back_ground,
		quit=quit,
		setting=setting 
	}
	return data
end


local function StartLayer_OnEnter(self) 
	local data=self.data
	data.focus=nil
	data.nextScene=nil
	data.play:setVisible(false)
	data.quit:setVisible(false)
	data.setting:setVisible(false)
	data.back_ground:setAnimation("default")
	data.back_ground:startAnimation(Sprite2D.ANIM_END)

	util.changeCallBack(self,StartLayer_mStartCallBack)
end


local function StartLayer_SetFocus(self,ob)
	local data=self.data
	if data.focus then 
		data.focus:setScale(1,1,1)
	end
	if ob then 
		ob:setScale(2,2,1)
	end
	data.focus=ob
end



local function StartLayer_New() 
	local layer=Layer2D:create()
	layer.data=StartLayer_CreateData()
	layer.onEnter=StartLayer_OnEnter
	layer.onExit=StartLayer_OnExit
	layer.setFocus=StartLayer_SetFocus
	layer:setViewArea(0,0,960,640)
	layer:setTouchEnabled(true)

	local data=layer.data;

	layer:add(data.back_ground)
	layer:add(data.play)
	layer:add(data.quit)
	layer:add(data.setting)

	return layer
end



-- layer begin call back 
StartLayer_mSelectCallBack=
{
	onUpdate=StartLayer_SelectUpdate,
	onTouchBegin=StartLayer_SelectTouchBegin,
	onTouchMove=StartLayer_SelectTouchBegin,
	onTouchEnd=StartLayer_SelectTouchEnd,
}


StartLayer_mStartCallBack=
{
	onUpdate=StartLayer_StartUpdate,
}


StartLayer_mExitCallBack=
{
	onUpdate=StartLayer_ExitUpdate
}






-- scene  
local function  SceneStart_OnEnter(self)
	self:push(self.data.layer)
	self.data.layer:onEnter();
end


local function SceneStart_OnExit(self)
--	self.data.layer:onExit();
	self:pop()
end 

local function SceneStart_CreateData() 
	return { 

		-- attribute 
		layer=StartLayer_New(),
		--call back 
		onEnter=SceneStart_OnEnter, 
		onExit=SceneStart_OnExit 
	} 
end

function SceneStart_New()

	local scene=Scene:create()
	scene.data=SceneStart_CreateData()
	return scene;

end























