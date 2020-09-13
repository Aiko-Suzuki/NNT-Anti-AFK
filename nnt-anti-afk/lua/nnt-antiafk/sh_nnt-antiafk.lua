AntiAfkTranslate = AntiAfkTranslate or {}
NNTAntiafkThemes = NNTAntiafkThemes or {}
print("[ANTI-AFK] : Loading themes")

function NNT_AntiAFK_AddThemes(name, func)
    if name == nil then
        print("Undefined Name for theme")

        return
    end

    if func == nil then
        print("Undefined function for theme")

        return
    end

    if not type(func) == "function" then
        print("the function is not valid !")

        return
    end

    if not type(name) == "string" then
        print("the name must be a string !")

        return
    end

    NNTAntiafkThemes[name] = func
    print("[ANTI-AFK] Theme loaded :  " .. name)
end

for k, v in pairs(file.Find("nnt-antiafk/themes/*.lua", "LUA")) do
    include("nnt-antiafk/themes/" .. v)
end