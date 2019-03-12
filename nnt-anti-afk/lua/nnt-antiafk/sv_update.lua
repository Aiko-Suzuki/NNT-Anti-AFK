local function LoadConfigFromFile()
    local noewmotherfucker = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
    AntiAFKConfig = util.JSONToTable(noewmotherfucker)
    AFK_WARN_TIME = AntiAFKConfig.Settings.WARN
    AFK_TIME = AntiAFKConfig.Settings.KICK
    AFK_REPEAT = AFK_TIME - AFK_WARN_TIME
    AFK_ENABLE =  AntiAFKConfig.Settings.ANTIAFK
    AFK_ADMINBYPASS = AntiAFKConfig.Settings.BYPASS
    AFK_ADMINUBYPASS = AntiAFKConfig.Settings.UBYPASS
    AFK_ADMINBYPASS_GROUPS = AntiAFKConfig.BypassGroups
    AFK_ADMINBYPASS_USERS = AntiAFKConfig.UsersBypass
    AFK_LANGUAGE =  AntiAFKConfig.Settings.LANGUAGE
    AFK_THEME = AntiAFKConfig.Settings.THEME
    AFK_VERSION = AntiAFKConfig.Version
    AFK_GHOST = AntiAFKConfig.Settings.GHOST
    AFK_DARKRPMONEY = AntiAFKConfig.Settings.DARKPMONEY
end

function NNTAntiAFKUpdate()
    if AFK_GHOST == nil then
        AFK_GHOST = false
    end
    if AFK_DARKRPMONEY == nil then
        AFK_DARKRPMONEY = false
    end
    AFKDefaultConfigUpdate = {}
    AFKDefaultConfigUpdate.BypassGroups = AFK_ADMINBYPASS_GROUPS
    AFKDefaultConfigUpdate.Settings = {
        ["WARN"] = AFK_WARN_TIME,
        ["KICK"] = AFK_TIME,
        ["BYPASS"] = AFK_ADMINBYPASS,
        ["UBYPASS"] =  AFK_ADMINUBYPASS,
        ["ANTIAFK"] = AFK_ENABLE,
        ["LANGUAGE"] = AFK_LANGUAGE,
        ["THEME"] = AFK_THEME,
        ["GHOST"] = AFK_GHOST,
        ["DARKPMONEY"] = AFK_DARKRPMONEY
    }
    AFKDefaultConfigUpdate.UsersBypass = AntiAFKConfig.UsersBypass
    AFKDefaultConfigUpdate.Version = NNTAntiAfkCurrentVersion
    local newdata = util.TableToJSON(AFKDefaultConfigUpdate,true)
    file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
    ReloadAntiAfkConfig()
end
function NNTCheckVersion(stringasdasd)
    local Really = string.Split( stringasdasd, "." )
    local stringversion = Really[1]..Really[2]..Really[3]
    local numversion = tonumber(stringversion,10)
    return numversion
end

function NNTAntiAFKCheckAndUpdate()
    LoadConfigFromFile()
    local LatestVersion = NNTCheckVersion(NNTAntiAfkCurrentVersion)
    if AFK_VERSION == nil then
        local ConfigVersion = 170
        if (LatestVersion > ConfigVersion ) then
            NNTAntiAFKUpdate()
        end
    else
        local ConfigVersion = NNTCheckVersion(AFK_VERSION)
        if (LatestVersion > ConfigVersion ) then
            NNTAntiAFKUpdate()
        end
    end
    /*if (LatestVersion > ConfigVersion ) then
        NNTAntiAFKUpdate()
    end*/
end
