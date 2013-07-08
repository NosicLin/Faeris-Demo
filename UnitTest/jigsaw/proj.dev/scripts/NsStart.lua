NsStart={}
NsStart.__index=NsStart


NsStart_UiMenu={}
NsStart_UiMenu.__index=NsStart_UiMenu


function NsStart:New()
	local scene=Scene:create()
	local menu_layer=NsStart_UiMenu:New()
	scene:push(menu_layer) 
	return scene 
end


function NsStart_UiMenu:New()
	local ret=Layer2D:create()
	ret.data={}
	setmetatable(ret.data,NsStart_UiMenu)
	ret:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)
	ret:setTouchEnabled(true)

	local bg=util.QuadNew(self.ms_background)
	ret:add(bg)
	local buttons={}

	for k,v in pairs(self.ms_buttons) do 
		local b=util.QuadNew(v)
		buttons[k]=b
		ret:add(b)
	end

	ret.m_button=buttons
	ret.m_menuLayer=menu_layer
	return ret

end

function NsStart_UiMenu:SetFocus(v) 
	if self.m_focus then 
		self.m_focus:setColor(Color(255,255,255))
		self.m_focus=nil 
	end

	if v then 
		v:setColor(self.ms_fadeColor) 
	end
	self.m_focus=v 
end

function NsStart_UiMenu.OnClickStart() 
	share:director():run(SN_JIGSAW)
end

function NsStart_UiMenu.OnClickAbout()
	util.log("about")
end

function NsStart_UiMenu.OnClickHelp() 
	util.log("help")
end


-- call back --

function NsStart_UiMenu:onTouchBegin(x,y)
	return self:onTouchMove(x,y)
end

function NsStart_UiMenu:onTouchMove(x,y) 
	x,y=self:toLayerCoord(x,y)
	for _,v in pairs(self.m_button)  do 
		if v:hit2D(x,y)  then 
			self:SetFocus(v)
			return true 
		end
	end
	self:SetFocus(nil)
	return false 
end

function NsStart_UiMenu:onTouchEnd(x,y) 
	x,y=self:toLayerCoord(x,y) 
	if self.m_focus then 
		local focus=self.m_focus 
		self:SetFocus(nil)
		focus.m_param.onClick(self)
	end
end 



-- static data -- 

NsStart_UiMenu.ms_buttons=
{
	["start"]={
		url="textures/nsstart_start.png",
		pos={x=GAME_WIDTH/2,y=500},
		size={width=200,height=70},
		onClick=NsStart_UiMenu.OnClickStart,
	},
	["about"]={
		url="textures/nsstart_about.png",
		pos={x=GAME_WIDTH/2,y=400},
		size={width=200,height=70},
		onClick=NsStart_UiMenu.OnClickAbout,
	},
	["help"]={
		url="textures/nsstart_help.png",
		pos={x=GAME_WIDTH/2,y=300},
		size={width=200,height=70},
		onClick=NsStart_UiMenu.OnClickHelp,
	}
}


NsStart_UiMenu.ms_background={
	url="textures/nsstart_bg.png",
	rect={x=0,y=0,width=GAME_WIDTH,height=GAME_HEIGHT},
	zorder=-1,
}

NsStart_UiMenu.ms_fadeColor=Color(155,155,155)





