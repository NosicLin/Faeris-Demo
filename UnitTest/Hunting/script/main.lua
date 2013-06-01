GAME_WIDTH= 960
GAME_HEIGHT=640

util={}
function util.log(fmt,...)
	print(string.format(fmt,...))
end

import("script/Bird.lua")
import("script/HuntLayer.lua")
import("script/PlayScene.lua")

local scene=PlayScene:Create()

share:director():run(scene)

