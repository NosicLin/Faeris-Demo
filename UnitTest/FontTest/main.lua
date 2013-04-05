local director =share:director();


-- create layer */
local layer= Layer2D:create();
layer:setViewArea(0,0,1024,800)

--create simsun font font 
local sim_sun_10=FontTTF:create("simsun.ttc",10)
local sim_sun_20=FontTTF:create("simsun.ttc",20)
local sim_sun_30=FontTTF:create("simsun.ttc",30)
local sim_sun_40=FontTTF:create("simsun.ttc",40)


local simsun_lable10=LabelTTF:create("SimSun size 10, Color Red",sim_sun_10)
simsun_lable10:setColor(Color.RED)
simsun_lable10:setPosition(30,30,0)


local simsun_lable20=LabelTTF:create("SimSun size 20, Color GREEN",sim_sun_20)
simsun_lable20:setColor(Color.GREEN)
simsun_lable20:setPosition(30,130,0)

local simsun_lable30=LabelTTF:create("SimSun size 20, Color BLUE",sim_sun_30)
simsun_lable30:setColor(Color.BLUE)
simsun_lable30:setPosition(30,230,0)

local simsun_lable40=LabelTTF:create("SimSun size 20, Color WHITE",sim_sun_40)
simsun_lable40:setColor(Color.WHITE)
simsun_lable40:setPosition(30,330,0)


layer:add(simsun_lable10);
layer:add(simsun_lable20)
layer:add(simsun_lable30)
layer:add(simsun_lable40)

--create staiyun font  test rotate 
local staiyun_20=FontTTF:create("staiyun.ttf",20)
local staiyun_30=FontTTF:create("staiyun.ttf",30)
local staiyun_40=FontTTF:create("staiyun.ttf",40)


local staiyun_label20_30=LabelTTF:create("StaiYun Size 20,rotate 30",staiyun_20)
staiyun_label20_30:setPosition(500,100,0)
staiyun_label20_30:setRotateZ(30)

local staiyun_label20_50=LabelTTF:create("StaiYun Size 20,rotate 50",staiyun_20)
staiyun_label20_50:setPosition(500,100,0)
staiyun_label20_50:setRotateZ(50)

local staiyun_label30_100=LabelTTF:create("StaiYun Size 30,rotate 50",staiyun_30)
staiyun_label30_100:setPosition(500,100,0)
staiyun_label30_100:setRotateZ(100)

layer:add(staiyun_label20_30)
layer:add(staiyun_label20_50)
layer:add(staiyun_label30_100)


--create stxihei.ttf test alignh
local stxihei_50=FontTTF:create("stxihei.ttf",40)

local stxihei_lable_left=LabelTTF:create("StxiHei Size 50,Align Left",stxihei_50)
stxihei_lable_left:setPosition(500,700,0)
stxihei_lable_left:setAlign(LabelTTF.ALIGN_H_LEFT,LabelTTF.ALIGN_V_CENTER)

local stxihei_lable_right=LabelTTF:create("StxiHei Size 50,Align Right",stxihei_50)
stxihei_lable_right:setPosition(500,640,0)
stxihei_lable_right:setAlign(LabelTTF.ALIGN_H_RIGHT,LabelTTF.ALIGN_V_CENTER)

local stxihei_lable_center=LabelTTF:create("StxiHei Size 50,Align Center",stxihei_50)
stxihei_lable_center:setPosition(500,580,0)
stxihei_lable_center:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_CENTER)

layer:add(stxihei_lable_left)
layer:add(stxihei_lable_right)
layer:add(stxihei_lable_center)


--create simsunb.ttf test  alignv

local simsunb_30=FontTTF:create("simsunb.ttf",30)

local simsunb_top=LabelTTF:create("SimsunB top",simsunb_30)
simsunb_top:setPosition(200,500,0)
simsunb_top:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_TOP)

local simsunb_center=LabelTTF:create("SimsunB Center",simsunb_30)
simsunb_center:setPosition(400,500,0)
simsunb_center:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_CENTER)

local simsunb_bottom=LabelTTF:create("SimsunB bottom",simsunb_30)
simsunb_bottom:setPosition(600,500,0)
simsunb_bottom:setAlign(LabelTTF.ALIGN_H_CENTER,LabelTTF.ALIGN_V_BOTTOM)


layer:add(simsunb_bottom)
layer:add(simsunb_top)
layer:add(simsunb_center)







scene= Scene:create()
scene:push(layer)


director:run(scene)
