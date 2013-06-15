--share:scheduler():setFps(60)

GAME_WIDTH=960 
GAME_HEIGHT=640

scene=Scene:create()

Tetris={}
Tetris.__index=Tetris


function Tetris:MyRotate(value)
	self:rotateZ(value)
end

function Tetris:MyMove(x,y)
	local old_x,old_y=self:getPosition()
	self:setPosition(old_x+x,old_y+y)
	print (string.format("old_x:%f,old_y:%f,movex:%f,movey:%f",old_x,old_y,x,y))
end


function Tetris.Create()
	quad=ColorQuad2D:create(50,50,Color(255,0,0))
	quad.data=
	{
		onUpdate=function(self,dt)
			self:MyRotate(dt/1000*30)
			self:MyMove(dt/1000*30,dt/1000*30)
			local x,y=self:getPosition()
			if x>GAME_WIDTH or y> GAME_HEIGHT then 
				self:setPosition(0,0)
			end
		end
	}
	setmetatable(quad.data,Tetris)
	return quad 
end


t=Tetris.Create()


layer=Layer2D:create()
layer:add(t)
layer:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)

scene=Scene:create()
scene:push(layer)

share:director():run(scene)






