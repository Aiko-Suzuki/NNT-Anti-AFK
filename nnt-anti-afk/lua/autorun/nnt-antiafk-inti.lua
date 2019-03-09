NNTAntiAfkCurrentVersion = "1.8.0"

if CLIENT then
    AddCSLuaFile("nnt-antiafk/cl_antiafk-hud.lua")
    for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/lang/" .. v)
        print("Adding CS Language: " ..v )
	end
    for _,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/themes/" .. v)
        print("Adding CS Themes: " ..v )
	end
    for _,v in pairs((file.Find("nnt-antiafk/modules/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/modules/" .. v)
        print("Adding CS Modules: " ..v )
	end
    include("nnt-antiafk/cl_antiafk-hud.lua")
elseif SERVER then
    AddCSLuaFile("nnt-antiafk/cl_antiafk-hud.lua")
    for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/lang/" .. v)
        print("Adding CS Language: " ..v )
	end
    for _,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/themes/" .. v)
        print("Adding CS Themes: " ..v )
	end
    for _,v in pairs((file.Find("nnt-antiafk/modules/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/modules/" .. v)
        print("Adding CS Modules: " ..v )
	end
    --Loading translation file
    include("nnt-antiafk/sv_nnt-antiafk.lua")
end