
local max_x=8
local max_y=10

local vertex={
	{x=2,y=7},
	{x=3,y=9},
	{x=4,y=8},
	{x=5,y=7.5},
	{x=6,y=6.5},
	{x=4,y=2.4}
}

local polygon={}

local param={
	{mode=VertexPolygon.POINTS,color=Color.RED},
	{mode=VertexPolygon.LINES,color=Color.BLUE},
	{mode=VertexPolygon.LINE_STRIP,color=Color.GREEN},

	{mode=VertexPolygon.LINE_LOOP,color=Color(255,255,0)},
	{mode=VertexPolygon.TRIANGLES,color=Color(255,0,255)},
	{mode=VertexPolygon.TRIANGLE_FAN,color=Color(0,255,255)},
	{mode=VertexPolygon.TRIANGLE_STRIP,color=Color(255,125,125)},
}


local layer=Layer2D:create()

layer:setViewArea(-max_x,-max_y,5*max_x,5*max_y);



for k,v in ipairs(param) do 

	local p=VertexPolygon:create();
	for k,v in ipairs(vertex) do 
		p:append(v.x,v.y)
	end

	p:setMode(v.mode)
	p:setColor(v.color)

	polygon[k]=p

	local x=((k-1)%3)*max_x;
	local y=math.floor((k-1)/3)*max_y
	p:setPosition(x,y)

	layer:add(p)
end



local scene=Scene:create()
scene:push(layer)
share:director():run(scene)



























