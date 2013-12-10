math.randomseed(os.time())
util={}
function util.log(fmt,...)
	print(string.format(fmt,...))
end

GAME_WIDTH=640
GAME_HEIGHT=960

f_import("script/Unit.lua")
f_import("script/Grid.lua")
f_import("script/PlayLayer.lua")
f_import("script/PlayScene.lua")



local scene=PlayScene:Create()
share:director():run(scene)
share:render():setClearColor(Color(155,155,155))


share:scheduler():scheduleWithMiliSecond(true)
