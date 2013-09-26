audioplayer=AudioEngine:create()


local scene=Scene:create()
local index=1
local music={"bgm_fever.ogg","bgm_main.ogg","bgm_main2.ogg"}

local pause=false 

scene.data={
	onTouchBegin=function(self,x,y) 
		if x < 0.5 then 
			audioplayer:stopBackgroundMusic()
		else 
			local name=music[index%(#music)+1]
			print("playBackgroundMusic:"..name)
			audioplayer:playBackgroundMusic(name)
			index=index+1

		end

	end
}


share:director():run(scene)


