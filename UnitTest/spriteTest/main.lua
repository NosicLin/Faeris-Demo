local director =share:director();


-- create layer */
local layer= Layer2D:create();
layer:setViewArea(0,0,1024,800)

local sprites={
	{
		x=50,
		y=130,
		color=Color.WHITE,
		url="boy.fst",
		animation="walk",
		fps=3,
		scale=3
	},
	{
		x=100,
		y=330,
		color=Color.RED,
		url="boy.fst",
		animation="strike",
		scale=0.5
	},
	{
		x=320,
		y=430,
		color=Color.GREEN,
		url="boy.fst",
		animation="run",
	},
	{
		x=100,
		y=530,
		color=Color.BLUE,
		url="boy.fst",
		animation="throw",
		scale=4
	},
	{
		x=140,
		y=303,
		color=Color(255,0,255),
		url="boy.fst",
		animation="dodge01",
	},


	{
		x=740,
		y=303,
		color=Color.WHITE,
		url="boy.fst",
		animation="kick01",
	},
	{
		x=840,
		y=500,
		color=Color.WHITE,
		url="boy.fst",
		animation="fallback",
		mode=Sprite2D.ANIM_END,
	},
	{
		x=940,
		y=303,
		color=Color.WHITE,
		url="boy.fst",
		animation="loose",
		mode=Sprite2D.ANIM_START,
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

	layer:add(e)
end

scene= Scene:create()
scene:push(layer)
director:run(scene)

