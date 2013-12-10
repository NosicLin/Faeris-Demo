W_Width=960
W_Height=640
if g_fps then 
	return 
end

local layer=Layer2D:create()
local font=FontTTF:create("simsun.ttc",40)
local label=LabelTTF:create("FPS:0",font)
label:setPosition(W_Width/2 - 80,50)
layer:setViewArea(0,0,W_Width,W_Height)
layer:add(label)

scheduler_target=SchedulerTarget:create()
scheduler_target.data={
	onUpdate=function(self,protity,dt)
		self.m_time=self.m_time+dt 
		self.m_count=self.m_count+1
		if self.m_time >1.0 then 
			self.m_time=self.m_time-1.0

			local scene=share:director():current()
			local entity_nu=0

			if scene then 
				local layer_nu=scene:layerNu()
				for i=0,layer_nu-1 do 
					local layer=scene:getLayer(i)
					entity_nu=entity_nu+layer:getEntityNu()
				end
			end
			self.m_label:setString("FPS:"..self.m_count.." Ety:"..entity_nu);
			self.m_count=0
		end


		local render=share:render();
		self.m_layer:draw(render)
	end;
	m_label=label,
	m_layer=layer;
	m_time=0;
	m_count=0;
}

share:scheduler():add(scheduler_target,Scheduler.LOW)





g_fps=true



