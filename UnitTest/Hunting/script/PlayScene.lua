PlayScene={}
PlayScene.__index=PlayScene


function PlayScene:Create()
	local scene=Scene:create()
	local layer=HuntLayer:Create()
	scene:push(layer)
	return scene
end





