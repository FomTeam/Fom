/***
	Linker
	
	Coded and managed by Trojan
***/

AddCSLuaFile()

local files, dirs = file.Find("fom/*", "LUA")

/***
	Including all files from fom folder
***/

local function add(dir)
	local files, dirs = file.Find("fom/" .. dir .. "/*", "LUA")

	for _, f_file in pairs(files) do
		include("fom/" .. dir .. "/" .. f_file)
		if SERVER then AddCSLuaFile("fom/" .. dir .. "/" .. f_file) end
	end
	
	for _, f_dir in pairs(dirs) do
		add(dir .. "/" .. f_dir) //Recursion!
	end
end

//All dirs from fom/
for _, f_dir in pairs(dirs) do
	add(f_dir)
end

//All files from fom/
for _, f_file in pairs(files) do
	include("fom/" .. f_file)
	if SERVER then AddCSLuaFile("fom/" .. f_file) end
end