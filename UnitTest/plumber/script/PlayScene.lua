PlayScene={}
PlayScene.__index=PlayScene
f_import("script/level/level_1.lua")

function PlayScene:Create()
	local scene=PlayScene:New()
	scene:Init()
	return scene 
end


function PlayScene:New()
	local scene=Scene:create()
	scene.data={}
	setmetatable(scene.data,PlayScene)
	return scene
end


function PlayScene:Init()
	local playing=PlayLayer:Create(LEVEL_DATA)
	self:push(playing)
end





