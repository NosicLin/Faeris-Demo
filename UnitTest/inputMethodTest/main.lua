local scene=Scene:create()

local layer=Layer2D:create()
layer:setViewArea(0,0,960,640)


local font=FontTTF:create("simsun.ttc",48)
local label=LabelTTF:create("afasf",font);

label:setPosition(480,320);
layer:add(label);



layer.data={

	onTouchBegin=function(self,x,y)
		Sys:openInputTextDialog("sfdsfs","bbbbb")
		print("aaaa")
	end

}

scene.data={
	onInputText=function(self,str)
		label:setString(str)
	end
}
layer:setTouchEnabled(true)
scene:push(layer)


share:director():run(scene)







