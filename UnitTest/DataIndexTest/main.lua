--share:scheduler():setFps(60)
scene=Scene:create()

layer=Layer2D:create()
layer.data=
{
	a=3,
	printa=function (self) 
		local data=self.data 
		print("value a is "..data.a)
	end
}

layer.a=4
layer:printa()


layer.a=5
layer:printa()

print (layer.a )
print (layer.data.a)

layer.data={a=100}

-- should error 
--layer.printa()  
--
layer.data=nil

print (tostring(layer.data ))
print (layer.a)




share:director():run(scene)
