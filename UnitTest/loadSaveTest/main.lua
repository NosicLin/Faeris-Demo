
persion_info={
	name="Faeris",
	age=1334,
	room={
		size="124m",
		name="9#1306",
	},
	[0]="one",
	"two",
	"three",
};

-- normal save not encrypt 
f_savetable("normal.sav",persion_info)

-- encrypt save 
f_savetable("encrypt.sav",persion_info,"www.faeris.com")


-- load information  
normal=f_loadtable("normal.sav")
f_utillog(f_tabletostring(normal))


-- load encrypt information 
encrypt=f_loadtable("encrypt.sav","www.faeris.com")
f_utillog(f_tabletostring(normal))




