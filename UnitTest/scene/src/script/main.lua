import("script/SceneStart.lua")
import("script/SceneAbout.lua")
import("script/ScenePlay.lua")

util={}

function util.changeCallBack(ob,call_backs)
	local data=ob.data 
	if not data then 
		return 
	end 

	data.onUpdate=call_backs.onUpdate
	if not data.onUpdate then 
		print "data.onUpdate is Null"
	end

	data.onDraw=call_backs.onDraw
	data.onTouchBegin=call_backs.onTouchBegin
	data.onTouchMove=call_backs.onTouchMove
	data.onTouchEnd=call_backs.onTouchEnd
end




local director=share:director()


local start=SceneStart_New()

director:run(start)




