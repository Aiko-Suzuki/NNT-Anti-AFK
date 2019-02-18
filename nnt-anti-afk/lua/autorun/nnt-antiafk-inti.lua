if CLIENT then
    include("../nnt-antiafk/cl_antiafk-hud.lua")
elseif SERVER then
    --Loading translation file
    for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/lang/" .. v)
        print("Adding CS Language: " ..v )
	end
    for _,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/themes/" .. v)
        print("Adding CS Themes: " ..v )
	end
    AddCSLuaFile("../nnt-antiafk/cl_antiafk-hud.lua")
    include("../nnt-antiafk/sv_nnt-antiafk.lua")
end