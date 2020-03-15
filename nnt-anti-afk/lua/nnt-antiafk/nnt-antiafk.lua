AddCSLuaFile()

NNTAntiAfkCurrentVersion = "3.2.0"

if CLIENT then
    include("nnt-antiafk/cl_antiafk-hud.lua")

    for _, v in pairs(file.Find("nnt-antiafk/vgui/*.lua", "LUA")) do
        include("nnt-antiafk/vgui/" .. v)
        print("[ANTI-AFK] : Loading VGUI: " .. v)
    end
elseif SERVER then
    for _, v in pairs(file.Find("materials/nnt-antiafk/*", "GAME")) do
        resource.AddFile("materials/nnt-antiafk/" .. v)
        print("[ANTI-AFK] : Adding CS Materials : " .. v)
    end

    for _, v in pairs(file.Find("nnt-antiafk/cl_*.lua", "LUA")) do
        AddCSLuaFile("nnt-antiafk/" .. v)
    end

    for _, v in pairs(file.Find("nnt-antiafk/sh_*.lua", "LUA")) do
        AddCSLuaFile("nnt-antiafk/" .. v)
    end

    for _, v in pairs(file.Find("nnt-antiafk/lang/*.lua", "LUA")) do
        AddCSLuaFile("nnt-antiafk/lang/" .. v)
        print("[ANTI-AFK] : Adding CS Language: " .. v)
    end

    for _, v in pairs(file.Find("nnt-antiafk/themes/*.lua", "LUA")) do
        AddCSLuaFile("nnt-antiafk/themes/" .. v)
        print("[ANTI-AFK] : Adding CS Themes: " .. v)
    end

    for _, v in pairs(file.Find("nnt-antiafk/vgui/*.lua", "LUA")) do
        AddCSLuaFile("nnt-antiafk/vgui/" .. v)
        print("[ANTI-AFK] : Adding CS VGUI: " .. v)
    end

    include("nnt-antiafk/sv_nnt-antiafk.lua")
end