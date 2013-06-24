GAME_WIDTH=960
GAME_HEIGHT=640

tips={
	[0]="\tAttempt doesn't necessarily bring success, but giving up definitely leads to failure.\n\n\t努力不一定成功，但放弃一定失败！",
	"\tThe best preparation for tomorrow is doing your best today.\n\n\t对明天最好的准备就是今天做到最好。",
	"\tI don't care about other questions and I just try to be myself.\n\n\t我不在乎别人的质疑，我只会做好自己",
	"\tYou are already naked. There is no reason not to follow your heart.\n\n\t你已经一无所有，没有什么道理不顺心而为。(乔布斯)",
	"\tThe best colour in the whole world, is the one that looks good, on you!\n\n\t最适合你的颜色，才是世界上最美的颜色。",
	"\tEveryone has his own way of finding happiness.\n\n\t每个人都有各自找到幸福的方式。",
	"\tLife is a journey, one that is much better traveled with a companion by our side.\n\n\t人生是一场旅程，我们最好结伴同行。",
	"\tSometimes you have to fall before you can fly.\n\n\t有时候，你得先跌下去，才能飞起来。",
	"\tIf you are able to appreciate beauty in the ordinary, your life will be more vibrant.\n\n\t如果你擅于欣赏平凡中的美好，你的生活会更加多姿多彩。",
	"\tBe who you are, and never ever apologize for that!\n\n\t坚持做自己，并永远不要为此而后悔！",
	"\tConsider the bad times as down payment for the good times. Hang in there.\n\n\t把苦日子当做好日子的首付，坚持就是胜利！",
	"\tDo not pray for easy lives, pray to be stronger.\n\n\t与其祈求生活平淡点，还不如祈求自己强大点。",
	"\tEverybody can fly without wings when they hold on to their dreams.\n\n\t坚持自己的梦想，即使没有翅膀也能飞翔。",
	"\tThere is no such thing as a great talent without great will power.\n\n\t没有伟大的意志力，便没有雄才大略。",
	"\tI will start fresh, be someone new.\n\n\t我要重新开始，做不一样的自己。《吸血鬼日记》",
	"\tYou can't change your situation. The only thing that you can change is how you choose to deal with it.\n\n\t境遇难以改变，你能改变的唯有面对它时的态度。",
	"\tWhatever is worth doing at all is worth doing well.\n\n\t凡是值得做的事，就值得做好。",
	"\tPerfection is not just about control.It's also about letting go.\n\n\t完美不仅在于控制，也在于释放。 《黑天鹅》",
	"\tDream is what makes you happy, even when you are just trying.\n\n\t梦想就是一种让你感到坚持就是幸福的东西。",
}

font=FontBitmap:create("font/b2.fnt");

Note={}
Note.__index=Note

function Note:Create()
	local layer=Layer2D:create();
	layer.data={}
	layer:setViewArea(0,0,GAME_WIDTH,GAME_HEIGHT)
	setmetatable(layer.data,self)

	local bg=Quad2D:create("textures/note2.png",Rect2D(0,0,GAME_WIDTH,GAME_HEIGHT));
	local pin1=Quad2D:create("textures/pin2.png",60,60);
	local pin2=Quad2D:create("textures/pin2.png",60,60);

	local b_next=Quad2D:create("textures/next.png",120,80);
	local b_prev=Quad2D:create("textures/prev.png",120,80);


	local text_area=LabelBitmap:create(font)
	text_area:setBounds(GAME_WIDTH-200,0)
	text_area:setAlign(LabelBitmap.ALIGN_H_CENTER,LabelBitmap.ALIGN_V_BOTTOM)
	text_area:setTextAlign(LabelBitmap.TEXT_ALIGN_LEFT)

	text_area:setPosition(GAME_WIDTH/2,GAME_HEIGHT-100)

	text_area:setString(tips[0])

	local text_tip=LabelBitmap:create(font)
	text_tip:setPosition(GAME_WIDTH/2,GAME_HEIGHT-40)
	text_tip:setAlign(LabelBitmap.ALIGN_H_CENTER,LabelBitmap.ALIGN_V_BOTTOM)
	text_tip:setTextAlign(LabelBitmap.TEXT_ALIGN_LEFT)



	layer:add(text_area)
	layer:add(text_tip)


	layer:add(bg);
	bg:setZorder(-1);

	layer:add(pin1)
	pin1:setPosition(40,GAME_HEIGHT-40)

	pin1:setZorder(0);
	pin1:setRotateY(180)

	layer:add(pin2);
	pin2:setPosition(GAME_WIDTH-40,GAME_HEIGHT-40)


	layer:add(b_next)
	b_next:setPosition(GAME_WIDTH-70,60)

	layer:add(b_prev)
	b_prev:setPosition(GAME_WIDTH-200,60)
	
	layer:setSortMode(Layer2D.SORT_ORDER_Z)

	layer.m_next=b_next 
	layer.m_prev=b_prev
	layer.m_textArea=text_area
	layer.m_textTip=text_tip;

	layer.m_curIndex=0
	layer.m_maxIndex=#tips+1;
	f_utillog("#tip=%d",#tips)

	layer:setTouchEnabled(true)
	layer:UpdateButtonColor()

	return layer;
end

function Note:onTouchBegin(x,y)
	local x,y=self:toLayerCoord(x,y)
	if self.m_next:hit2D(x,y) then 
		if self.m_curIndex==self.m_maxIndex-1 then 
			return 
		end
		self.m_curIndex=self.m_curIndex+1
		self.m_textArea:setString(tips[self.m_curIndex])
	elseif self.m_prev:hit2D(x,y) then 

		if self.m_curIndex==0 then 
			return 
		end
		self.m_curIndex=self.m_curIndex-1
		self.m_textArea:setString(tips[self.m_curIndex])
	end

	self:UpdateButtonColor()
end

function Note:UpdateButtonColor()
	if self.m_curIndex==0 then 
		self.m_prev:setColor(Color(100,100,100,100));
	else 
		self.m_prev:setColor(Color(255,255,255))
	end

	if self.m_curIndex==self.m_maxIndex-1 then 
		self.m_next:setColor(Color(100,100,100,100))
	else 
		self.m_next:setColor(Color(255,255,255))
	end

	self.m_textTip:setString("tips "..(self.m_curIndex+1).."/"..self.m_maxIndex)

end












scene=Scene:create()
layer=Note:Create()

scene:push(layer);

share:director():run(scene)





