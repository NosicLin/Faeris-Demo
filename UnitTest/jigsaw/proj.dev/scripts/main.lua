GAME_HEIGHT=960 
GAME_WIDTH=640
DEFAULT_FONT="fonts/stxihei.ttf"
f_import("scripts/utils/util.lua")
f_import("scripts/NsStart.lua")
f_import("scripts/NsJigSaw.lua")

f_import("scripts/Level.lua")

SN_START=NsStart:New() 
SN_JIGSAW=NsJigSaw:New()
SN_JIGSAW:SetLevel(1)

share:director():run(SN_START) 


share:scheduler():scheduleWithMiliSecond(true)

