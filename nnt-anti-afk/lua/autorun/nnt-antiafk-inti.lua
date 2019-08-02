NNTAntiAfkCurrentVersion = "2.0.1"

if CLIENT then
    include("nnt-antiafk/cl_antiafk-hud.lua")
elseif SERVER then

    resource.AddFile( "materials/nnt-antiafk/clock.png" )
    resource.AddFile( "materials/nnt-antiafk/exit.png" )
    resource.AddFile( "materials/nnt-antiafk/option.png" )
    resource.AddFile( "materials/nnt-antiafk/question-mark.png" )
    resource.AddFile( "materials/nnt-antiafk/translate.png" )
    resource.AddFile( "materials/nnt-antiafk/users.png" )


    for _,v in pairs((file.Find("nnt-antiafk/cl_*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/"..v)
	end
    for _,v in pairs((file.Find("nnt-antiafk/sh_*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/"..v)
	end
    for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/lang/" .. v)
        print("Adding CS Language: " ..v )
	end
    for _,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/themes/" .. v)
        print("Adding CS Themes: " ..v )
	end
    for _,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
		AddCSLuaFile("nnt-antiafk/themes/" .. v)
        print("Adding CS Themes: " ..v )
	end


    include("nnt-antiafk/sv_nnt-antiafk.lua")
end