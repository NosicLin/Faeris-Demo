scene=Scene:create()

layer=Layer2D:create()

scene:push(layer)

q1=Quad2D:create("play.png",80,80)
q2=Quad2D:create("play.png",80,80)
q3=Quad2D:create("play.png",80,80)

q1:setPosition(900,600);
q2:setPosition(700,40);
q2:setColor(Color.BLUE)
q3:setPosition(40,40);
q3:setColor(Color.RED)


seq=SeqAction:create()

seq:addAction(MoveToAction:create(400,400,3))
seq:addAction(ScaleToAction:create(2,2,4))
seq:addAction(MoveByAction:create(0,60,2))
seq:addAction(RotateZToAction:create(180,3))

q1:doAction(seq)







q2:doAction(MoveToAction:create(300,500,15))
q2:doAction(RotateZToAction:create(360,15))

layer:add(q1)
layer:add(q2)
layer:add(q3)

layer:setViewArea(0,0,960,640)

share:director():run(scene)


a1=Action:create()
a1.data={
	angle=0.0,
	speed=60,
	onRun=function(self,target,dt)
		self.angle=self.angle+self.speed*dt
		assert(target)
		target:setPosition(180+math.sin(self.angle/180*3.14)*100,320+math.cos(self.angle/180*3.14)*100)
		if self.angle > 360 then 
			return true 
		else 
			return false 
		end
	end
}
a2=Action:create() 
a2.data={
	time=0,
	speedx=40,
	onRun=function(self,target,dt)
		local x,y=target:getPosition()
		x=x+self.speedx*dt
		y=320+math.sin(x)*10
		target:setPosition(x,y)
		self.time=self.time+dt
		if self.time>10 then 
			return true 
		else 
			return false
		end
	end
}

seq2=SeqAction:create()
seq2:addAction(a1)
seq2:addAction(a2)

q3:doAction(seq2)





local t=Test()
t:printSelf()




