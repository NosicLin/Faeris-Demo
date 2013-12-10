GAME_WIDTH= 960
GAME_HEIGHT=640
share:scheduler():scheduleWithMiliSecond(true)

util={}
function util.log(fmt,...)
	print(string.format(fmt,...))
end

f_import("script/Bird.lua")
f_import("script/HuntLayer.lua")
f_import("script/PlayScene.lua")

local scene=PlayScene:Create()

share:director():run(scene)

