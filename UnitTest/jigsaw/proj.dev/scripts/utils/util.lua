util={}

function util.log(fmt,...)
	print(string.format(fmt,...))
end


function util.import(name)
	f_import(name)
end

function util.QuadNew(param)
	local ret=nil 

	if param.size then 
		ret=Quad2D:create(param.url,param.size.width,param.size.height)
	elseif param.rect then  
		ret=Quad2D:create(param.url,Rect2D(param.rect.x,param.rect.y,param.rect.width,param.rect.height))
	else 
		ret=Quad2D:create(param.url)
	end

	for k,v in pairs(param) do 
		if k == "pos" then 
			ret:setPosition(v.x,v.y)
		elseif k=="scale" then 
			ret:setScale(v.x,v.y,1)
		elseif k=="angle" then 
			ret:setRotateZ(v)
		elseif k=="color" then 
			ret:setColor(Color(v.r,v.g,v.b))
		elseif k=="zorder" then 
			ret:setZorder(v)
		end
	end 
	ret.data={m_param=param}
	return ret
end

function util.LabelTTFNew(param) 
	local ret=LabelTTF:create(param.text,param.font)
	for k,v in pairs(param) do 
		if k == "pos" then 
			ret:setPosition(v.x,v.y)
		elseif k=="scale" then 
			ret:setScale(v.x,v.y,1)
		elseif k=="angle" then 
			ret:setRotateZ(v)
		elseif k=="color" then 
			ret:setColor(Color(v.r,v.g,v.b))
		elseif k=="zorder" then 
			ret:setZorder(v)
		elseif k=="align" then 
			ret:setAlign(v.h,v.v)
		end
	end 
	ret.data={m_param=param}
	return ret
end



























