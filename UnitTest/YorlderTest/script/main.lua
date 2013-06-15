q1=Quad2D:create("textures/aboutButton.png")
q2=Quad2D:create("textures/achivementButton.png")
q3=Quad2D:create("textures/backButton.png")


layer=Layer2D:create()
layer:setViewArea(0,0,640,960)
layer:setSortMode(Layer2D.SORT_Y)

q1:setPosition(120,130)
q1:setZorder(0)
q2:setPosition(150,160)
q2:setZorder(-1)
q3:setPosition(170,140)


layer:add(q1)
layer:add(q2)
layer:add(q3)

scene=Scene:create()
scene:push(layer)
share:director():run(scene);


