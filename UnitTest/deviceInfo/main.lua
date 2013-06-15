NS_MulTouchLayer={}

NS_MulTouchLayer.__index=NS_MulTouchLayer 

local font=FontTTF:create("simsun.ttc",35)

function NS_MulTouchLayer:Create()
	local layer=Layer2D:create()
	layer.data={}
	setmetatable(layer.data,NS_MulTouchLayer);
	layer.m_touchobj={}

	layer:setViewArea(0,0,960,640)
	layer:setTouchEnabled(true);

	local str_imei=f_getenv("imei") or "Unkown"

	local str_imsi=f_getenv("imsi") or "Unkown"
	local str_device_name=f_getenv("device_name") or "Unkown"
	local str_package_name=f_getenv("package_name") or "Unkown"
	local str_os_type=f_getenv("os_type") or "Unkown" 
	local str_os_version=f_getenv("os_version") or "Unkown"

	local imei=LabelTTF:create("IMEI:"..str_imei,font);
	imei:setPosition(100,600)
	layer:add(imei)

	local imsi=LabelTTF:create("IMSI:"..str_imsi,font);
	imsi:setPosition(100,550)
	layer:add(imsi)

	local device_name=LabelTTF:create("device_name:"..str_device_name,font)
	device_name:setPosition(100,500)
	layer:add(device_name)

	local package_name=LabelTTF:create("package_name:"..str_package_name,font)
	package_name:setPosition(100,450)
	layer:add(package_name)

	local os_type=LabelTTF:create("os_type:"..str_os_type,font)
	os_type:setPosition(100,400)
	layer:add(os_type)

	local os_version=LabelTTF:create("os_version:"..str_os_version,font);
	os_version:setPosition(100,350)
	layer:add(os_version)

	return layer

end




local scene=Scene:create()
local layer=NS_MulTouchLayer:Create()

scene:push(layer);


share:director():run(scene)




