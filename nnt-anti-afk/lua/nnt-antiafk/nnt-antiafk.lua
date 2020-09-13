AddCSLuaFile()
NNTAntiAfkCurrentVersion = "3.2.1"

if CLIENT then
    include("nnt-antiafk/cl_antiafk-hud.lua")

    for _, v in pairs(file.Find("nnt-antiafk/vgui/*.lua", "LUA")) do
        include("nnt-antiafk/vgui/" .. v)
        print("[ANTI-AFK] : Loading VGUI: " .. v)
    end
elseif SERVER then
    local function Recursive(path)
        local files, dirs = file.Find(path .. "*", "GAME")

        for _, v in pairs(files) do
            if (v == "nnt_antiafk.properties") then
                resource.AddFile(path .. v)
                print("[ANTI-AFK] : Adding CS : " .. path .. v)
                break
            end
        end

        for _, v in pairs(dirs) do
            if (file.IsDir(path .. v, "GAME")) then
                Recursive(path .. v .. "/")
            end
        end
    end

    Recursive("resource/localization/")

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