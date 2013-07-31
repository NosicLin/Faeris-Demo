sprite=SpineSprite:create("spineboy.json");
sprite:setAnimation("walk");
sprite:playAnimation();
sprite:setPosition(480,320)
--sprite:setColor(Color(255,0,0));
sprite:setScale(0.5,0.5,1)
scene=Scene:create()

layer=Layer2D:create()
layer:setViewArea(0,0,960,640)
scene:push(layer)

layer:add(sprite)



layer.data={
	onTouchBegin=function(self,x,y)
		if cur_animation=="jump" then 
			sprite:setAnimation("walk")
			cur_animation="walk"
		else  
			sprite:setAnimation("jump")
			cur_animation="jump"
		end

	end
}

layer:setTouchEnabled(true)


share:director():run(scene);
