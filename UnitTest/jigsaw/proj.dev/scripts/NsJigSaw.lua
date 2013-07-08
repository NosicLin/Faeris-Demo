util.import("scripts/NsJigSaw_UiControl.lua")
util.import("scripts/NsJigSaw_UiGrid.lua")
util.import("scripts/NsJigSaw_UiGoal.lua")

NsJigSaw={}
NsJigSaw.__index=NsJigSaw 


NsJigSaw_UiHelp={}
NsJigSaw_UiHelp.__index=NsJigSaw_UiHelp

NsJigSaw_UiBg={}
NsJigSaw_UiBg.__index=NsJigSaw_UiBg 



function NsJigSaw:New()
	local scene=Scene:create()
	scene.data={}
	setmetatable(scene.data,NsJigSaw)

	-- create --
	local ui_control=NsJigSaw_UiControl:New()
	local ui_bg=NsJigSaw_UiBg:New()
	local ui_grid=NsJigSaw_UiGrid:New()
	local ui_goal=NsJigSaw_UiGoal:New()

	--local ui_pause=NsJigSaw_Pause:New()
	

	-- push --
	scene:push(ui_bg)
	scene:push(ui_grid)
	scene:push(ui_control)
	scene:push(ui_goal)

	-- assign --
	scene.m_uiControl=ui_control
	scene.m_uiBg=ui_bg 
	scene.m_uiGoal=ui_goal
	--scene.m_uiPause=ui_pause
	scene.m_uiGrid=ui_grid
	return scene 
end



function NsJigSaw:Success()
	self.m_uiControl:Success()
end

function NsJigSaw:SetLevel(i)
	local l=LEVEL_DATA[i] 
	
	self.m_uiControl:LoadLevel(l,i) 
	--self.m_uiBg:LoadLevel(l)
	self.m_uiGrid:LoadLevel(l)
	self.m_uiGoal:LoadLevel(l)
	self.m_uiGoal:setVisible(false)
	self.m_currentLevel=i
end

function NsJigSaw:NextLevel()
	if self.m_currentLevel == MAX_LEVEL then 
		self:SetLevel(self.m_currentLevel) 
		return 
	end
	self:SetLevel(self.m_currentLevel+1 )
end


-- call back --
function NsJigSaw:onEnter()
end


-- ui bg -- 
NsJigSaw_UiBg={}
NsJigSaw_UiBg.__index=NsJigSaw_UiBg 

function NsJigSaw_UiBg:New() 
	local ret=Layer2D:create()
	local bg=Quad2D:create("textures/background/default.png",Rect2D(0,0,GAME_WIDTH,GAME_HEIGHT))
	ret:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)
	ret:add(bg)
	return ret
end





-- static data --


