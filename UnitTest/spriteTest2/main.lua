local director =share:director();


-- create layer */
local layer= Layer2D:create();
layer:setViewArea(0,0,1024,800)

local sprites={
	{
		x=50,
		y=130,
		offsetx=0,
		offsety=0,
		color=Color.RED,
		url="boy.fst",
		animation="walk",
		fps=3,
		scale=3
	},
	{
		x=50,
		y=130,
		offsetx=0,
		offsety=100,
		color=Color.WHITE,
		url="boy.fst",
		animation="walk",
		fps=13,
		scale=3
	},

	{
		x=50,
		y=130,
		offsetx=100,
		offsety=100,
		color=Color.WHITE,
		url="boy.fst",
		animation="walk",
		fps=20,
		scale=3
	},

	{
		x=50,
		y=130,
		offsetx=100,
		offsety=0,
		color=Color.WHITE,
		url="boy.fst",
		animation="walk",
		fps=40,
		scale=3
	},
}	



for i=1,#sprites do 
	local s=sprites[i]
	local e=Sprite2D:create(s.url)
	e:setPosition(s.x,s.y,0)
	if s.scale  then 
		e:setScale(s.scale,s.scale,s.scale)
	end
	e:setColor(s.color)
	e:setAnimation(s.animation)
	if s.mode then 
		e:playAnimation(s.mode)
	else
		e:playAnimation()
	end
	if s.fps then 
		e:setFps(s.fps)
	end

	if s.offsetx and s.offsety then 
		e:setAnimationOffset(s.offsetx,s.offsety)
	end

	layer:add(e)
end

scene= Scene:create()
scene:push(layer)
director:run(scene)

