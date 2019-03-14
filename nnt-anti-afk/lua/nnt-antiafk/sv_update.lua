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
local function checkafkdata(data,name)
    if data == nil then
        if name then
            if name == "JOB" then return "Spectator" end
            if name == "THEME" then return "Default" end
            if name == "WARN" then return 300 end
            if name == "KICK" then return 600 end
            if name == "StartHours" then return 21 end
            if name == "StartMinutes" then return 0 end
            if name == "StopHours" then return 8 end
            if name == "StopMinutes" then return 0 end
        end
        return false
    else
        return data
    end
end
function NNTAntiAFKUpdate()
    if AFK_GHOST == nil then
        AFK_GHOST = false
    end
    if AFK_DARKRPMONEY == nil then
        AFK_DARKRPMONEY = false
    end
    if AFK_GODMODE == nil then
        AFK_GODMODE = false
    end




    AFKDefaultConfigUpdate = {}
    AFKDefaultConfigUpdate.BypassGroups = AFK_ADMINBYPASS_GROUPS
    AFKDefaultConfigUpdate.TimeSettings = {
        ["StartHours"] = checkafkdata(AFK_StartTimeHours,"StartHours"),
        ["StartMinutes"] = checkafkdata(AFK_StartTimeMinutes,"StartMinutes"),
        ["StopHours"] = checkafkdata(AFK_StopTimeHours,"StopHours"),
        ["StopMinutes"] = checkafkdata(AFK_StopTimeMinutes,"StopMinutes")
    }
    AFKDefaultConfigUpdate.Settings = {
        ["WARN"] = checkafkdata(AFK_WARN_TIME,"WARN"),
        ["KICK"] = checkafkdata(AFK_TIME,"KICK"),
        ["BYPASS"] = checkafkdata(AFK_ADMINBYPASS),
        ["UBYPASS"] = checkafkdata (AFK_ADMINUBYPASS),
        ["ANTIAFK"] = checkafkdata(AFK_ENABLE),
        ["LANGUAGE"] = checkafkdata(AFK_LANGUAGE),
        ["THEME"] = checkafkdata(AFK_THEME,"THEME"),
        ["GHOST"] = checkafkdata(AFK_GHOST),
        ["DARKPMONEY"] = checkafkdata(AFK_DARKRPMONEY),
        ["GODMODE"] = checkafkdata(AFK_GODMODE),
        ["JOBENABLE"] = checkafkdata(AFK_JOBENABLE),
        ["JOBNAME"] = checkafkdata(AFK_JOBNAME,"JOB"),
        ["ENABLETIME"] =checkafkdata(AFK_ENABLETIME)
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
