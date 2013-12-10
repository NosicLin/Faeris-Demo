share:scheduler():scheduleWithMiliSecond(true)
local director =share:director();
local render=share:render()
local scheduler=share:scheduler()
scheduler:setFps(500)

--director:setAutoSwapBuffers(false);


-- create layer */
local layer= Layer2D:create();
layer:setViewArea(0,0,1024,800)


local quad2d= Quad2D:create("grass.png",Rect2D(-100,-100,200,200))
quad2d:setPosition(500,400,0)
quad2d.data={
	onUpdate=function(self,dt)
		print("update:"..dt)
		self:rotateZ(dt/1000*10)
	end 
}

local c_quad=ColorQuad2D:create(Rect2D(-100,-100,200,200),Color.RED)
c_quad:setPosition(300,-300,0);
c_quad:setColor(Color.WHITE,ColorQuad2D.VERTEX_A)




local tree1 =Quad2D:create("tree.png")
tree1.data={
	onUpdate=function(self,dt)
		self:rotateZ(dt/1000*30)
	end 
}
tree1:setPosition(200,200,0)

local tree2 =Quad2D:create("tree2.png")
tree2.data={
	onUpdate=function(self,dt)
		self:rotateZ(dt/1000*10)
	end 
}
tree2:setPosition(200,200,0)

local font=FontTTF:create("simsun.ttc",30)


local label=LabelTTF:create("This Is A Font",font);
label:setPosition(-300,300,0)
label.data={
	onUpdate=function(self,dt)
		self:rotateZ(dt/1000*80)
	end 
	
}

quad2d:addChild(tree1)
quad2d:addChild(c_quad)
quad2d:addChild(label)

tree1:addChild(tree2)



entity={ quad2d, tree1,tree2 ,c_quad,label}

layer:add(quad2d)
layer:setTouchEnabled(true)

layer.data={
	onTouchBegin=function (self,x,y)
		local c=Color(math.random(50,255),math.random(60,255),math.random(80,255))
		x,y=self:toLayerCoord(x,y)
		print("x:"..x.." y:"..y)
		for i=1,#entity do 
			e=entity[i]
			if e:hit2D(x,y) then 
				print("hit")
				e:setColor(c)
				break
			end
		end
	end,

}




local scene=Scene:create()
scene.data={
	onUpdate=function(self,dt) 
		self:update(dt)

	end
}



scene:push(layer)


director:run(scene);










