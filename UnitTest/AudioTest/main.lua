audioplayer=AudioEngine:create()


audioplayer:playBackgroundMusic("mainmenu.ogg",true)
--audioplayer:playSound("mainmenu.ogg",-1)

audios={
	{
		src="Burp07.ogg",
		icon="Music-icon.png",
		x=48*1,
		y=48*1,
		width=48,
		height=48,
	},
	{
		src="Cartoon_Sneeze.ogg",
		icon="Music-icon.png",
		x=48*2,
		y=48*1,
		width=48,
		height=48,
	},
	{
		src="Male_Attack_Grunt01.ogg",
		icon="Music-icon.png",
		x=48*3,
		y=48*1,
		width=48,
		height=48,
	},
	{
		src="Wind_Loop01.ogg",
		icon="Music-icon.png",
		x=48*4,
		y=48*1,
		width=48,
		height=48,
	},
	{
		src="Wind_LowLoop1.ogg",
		icon="Music-icon.png",
		x=48*5,
		y=48*1,
		width=48,
		height=48,
	},
}





quad_add=Quad2D:create("add.png",48,48)
quad_dec=Quad2D:create("dec.png",48,48)
quad_background=Quad2D:create("add.png",48,48)

quad_add:setPosition(50,200)
quad_dec:setPosition(50,300)
quad_background:setPosition(200,300)

font = FontTTF:create("font.ttf",20)
label= LabelTTF:create("Volume:1.0",font)
label:setPosition(50,350)
label:setColor(Color(255,255,255))

layer=Layer2D:create()
layer:add(quad_add)
layer:add(quad_dec)
layer:add(label)
layer:add(quad_background)


volume=1.0
background_play=false;
background_channel=nil

layer.data={
	quads={},
	onTouchBegin=function(layer,x,y)
		local data=layer.data
		local x,y=layer:toLayerCoord(x,y)

		if quad_add:hit2D(x,y) then 
			volume=volume + 0.1
			if volume > 1.0 then volume=1.0 end
			audioplayer:setVolume(volume)
			label:setString("Volume:"..volume)
			return true
		end

		if quad_dec:hit2D(x,y) then 
			volume = volume - 0.1
			if volume < 0.0 then volume = 0.0 end 
			audioplayer:setVolume(volume)
			label:setString("Volume:"..volume)
			return true 
		end

		if quad_background:hit2D(x,y) then 
			if not background_play then  
				background_channel=audioplayer:resumeBackgroundMusic()
				background_play=true
			else 
				audioplayer:pauseBackgroundMusic();
				background_play=false
			end
			return true 
		end 




		for _,v in pairs(data.quads) do 
			if v:hit2D(x,y) then 
				audioplayer:playSound(v.data.sound)
				break
			end
		end
	end
}

for  _,v in pairs(audios) do 
	local quad=Quad2D:create(v.icon,v.width,v.height)
	layer.data.quads[quad]=quad

	quad:setPosition(v.x,v.y)
	local sound=audioplayer:loadSound(v.src)

	quad.data={
		sound=v.src
	}

	layer:add(quad)

end 

layer:setTouchEnabled(true)




scene=Scene:create()

scene:push(layer)
layer:setViewArea(0,0,960,640)

share:director():run(scene)































