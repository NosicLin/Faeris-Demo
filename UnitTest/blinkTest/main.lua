scene=Scene:create()

layer=Layer2D:create()

scene:push(layer)

q1=Quad2D:create("play.png",80,80)

q1:setPosition(480,320);


q1.data=
{
	max_alpha=1.0,
	min_alpha=0.4,
	alpha_speed=1.3,
	cur_alpha=1.0
}

q1.onUpdate=function(self,dt)

	local alpha=self.cur_alpha+self.alpha_speed*dt 
	if alpha> self.max_alpha then 
		alpha=self.max_alpha
		self.alpha_speed=-1.0 
	elseif alpha< self.min_alpha then 
		alpha=self.min_alpha
		self.alpha_speed=1.0 
	end

	self:setOpacity(alpha) 
	self.cur_alpha=alpha
end








layer:add(q1)
layer:setViewArea(0,0,960,640)
share:director():run(scene)


