NsJigSaw_UiControl={}
NsJigSaw_UiControl.__index=NsJigSaw_UiControl 


function NsJigSaw_UiControl:New()
	local ret=Layer2D:create()
	ret.data={}
	setmetatable(ret.data,NsJigSaw_UiControl)

	ret:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)
	ret:setTouchEnabled(true)

	local children={}
	local event={}

	for k,v in pairs(self.ms_layouts) do 
		local t=v.onCreate(v)
		ret:add(t)
		children[k]=t
		if v.event then 
			event[k]=t 
		end
	end
	ret.m_eventPlay={children["pause"],children["help"]}
	--ret.m_eventSuccess={children["next"],children["prev"]}
	ret.m_eventSuccess={children["next"]}

	ret.m_children=children 
	ret.m_event=event
	ret.m_time={minute=0,second=0,mesc=0}

	return ret
end

function NsJigSaw_UiControl:SetLevel(l) 
	self.m_children["level"]:setString("Level "..l)
end


function NsJigSaw_UiControl:LoadLevel(l,i) 
	self.m_time={minute=0,second=0,mesc=0}
	self:SetLevel(i)
	self.m_children["success"]:setVisible(false)
	self.m_children["next"]:setVisible(false)
	--self.m_children["prev"]:setVisible(false)
	
	self.onUpdate=nil 
	self.onTouchBegin=nil 
	self.onTouchMove=nil 
	self.onTouchEnd=nil 

end



function NsJigSaw_UiControl:updateTime(dt)
	self.m_time.mesc=self.m_time.mesc+dt

	if self.m_time.mesc >=1000  then 
		local second=math.floor(self.m_time.mesc/1000)
		self.m_time.mesc=self.m_time.mesc-second*1000
		self.m_time.second=self.m_time.second+second 

		if self.m_time.second >=60 then 
			local minute=math.floor(self.m_time.second/60)
			self.m_time.second=self.m_time.second-minute*60 
			self.m_time.minute=self.m_time.minute+minute
		end
	end
	local second=nil 
	local minute=nil 
	if self.m_time.second >=10 then 
		second=tostring(self.m_time.second)
	else 
		second="0"..tostring(self.m_time.second) 
	end

	if self.m_time.minute >=10 then 
		minute=tostring(self.m_time.minute) 
	else 
		minute="0"..tostring(self.m_time.minute)
	end

	self.m_children["time"]:setString(string.format("Time %s:%s",minute,second))
end






--[[
time{
	minute:number,
	second:number,
	mesc:number,
}
--]]

function NsJigSaw_UiControl:SetTime(time) 
	self.m_time=time
end

function NsJigSaw_UiControl:Success()
	self.onTouchBegin=self.onSuccessTouchBegin 
	self.onTouchMove=self.onSuccessTouchMove 
	self.onTouchEnd=self.onSuccessTouchEnd 
	self.onUpdate=nil
	self.m_children["success"]:setVisible(true)
	self.m_children["next"]:setVisible(true)
	--self.m_children["prev"]:setVisible(true)

end


-- click method --


function NsJigSaw_UiControl:OnClickPause() 
	local scene=share:director():current()
	scene.m_uiPause:Active()
end

function NsJigSaw_UiControl:OnClickGoal()
	local scene=share:director():current()
	scene.m_uiGoal:Active()
end


function NsJigSaw_UiControl:OnClickPrev() 
	local scene=share:director():current()
	scene:NextLevel()
end

function NsJigSaw_UiControl:OnClickNext()
	local scene=share:director():current()
	scene:NextLevel()
end


function NsJigSaw_UiControl:OnClickHelp() 
	local scene=share:director():current() 
	scene.m_uiGoal:Active()
end


-- call back -- 

function NsJigSaw_UiControl:onUpdate(dt)
	self:updateTime(dt)
end

function NsJigSaw_UiControl:onSuccessTouchBegin(x,y) 
	x,y=self:toLayerCoord(x,y)
	for k,v in pairs(self.m_eventSuccess) do 
		if v:hit2D(x,y) then 
			v.m_param.onClick(self)
			return  true
		end
	end
	return true
end

function NsJigSaw_UiControl:onSuccessTouchMove(x,y) 
	return true 
end
function NsJigSaw_UiControl:onSuccessTouchEnd(x,y)
	return true
end

function NsJigSaw_UiControl:onTouchBegin(x,y)
	util.log("onTouchBegin")
	x,y=self:toLayerCoord(x,y)
	for k,v in pairs(self.m_eventPlay) do 
		if v:hit2D(x,y) then 
			v.m_param.onClick(self)
			return  true
		end
	end

	return false
end


function NsJigSaw_UiControl:onTouchMove(x,y) 
	return false 
end


function NsJigSaw_UiControl:onTouchEnd(x,y) 
	return false 
end


-- ui control static data --

NsJigSaw_UiControl.ms_font=FontTTF:create(DEFAULT_FONT,32)


NsJigSaw_UiControl.ms_layouts={
	level={
		onCreate=util.LabelTTFNew,
		font=NsJigSaw_UiControl.ms_font,
		text="Level 1000",
		pos={x=20,y=GAME_HEIGHT-50},
		align={h=LabelTTF.ALIGN_H_RIGHT,v=LabelTTF.ALIGN_V_CENTER}
	},

	time={
		onCreate=util.LabelTTFNew,
		font=NsJigSaw_UiControl.ms_font,
		text="Time 00:00",
		pos={x=250,y=GAME_HEIGHT-50},
		align={h=LabelTTF.ALIGN_H_RIGHT,v=LabelTTF.ALIGN_V_CENTER}
	},

	pause={
		event=true,
		url="textures/nsjigsaw_pause.png",
		onCreate=util.QuadNew,
		size={width=48,height=48},
		pos={x=600,y=GAME_HEIGHT-50},
		onClick=NsJigSaw_UiControl.OnClickPause,
	},

	help={
		event=true,
		url="textures/nsjigsaw_help.png",
		onCreate=util.QuadNew,
		size={width=200,height=70},
		pos={x=100,y=100},
		onClick=NsJigSaw_UiControl.OnClickHelp,
	},

	--[[
	["prev"]=
	{
		event=true,
		url="textures/prev_level.png",
		onCreate=util.QuadNew,
		size={width=200,height=70},
		pos={x=200,y=400},
		onClick=NsJigSaw_UiControl.OnClickPrev,
	},
	--]]
	["next"]=
	{
		event=true,
		url="textures/next_level.png",
		onCreate=util.QuadNew,
		size={width=200,height=70},
		pos={x=440,y=400},
		onClick=NsJigSaw_UiControl.OnClickNext,
	},
	["success"]=
	{
		url="textures/success.png",
		onCreate=util.QuadNew,
		size={width=300,height=100},
		pos={x=320,y=550},
	}

}







