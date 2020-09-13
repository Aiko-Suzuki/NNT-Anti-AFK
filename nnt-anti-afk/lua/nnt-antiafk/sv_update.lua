local function LoadConfigFromFile()
    local noewmotherfucker = file.Read("nnt-antiafk/AntiAFKConfig.txt", "DATA")
    NNT.ANTI_AFK.Config = util.JSONToTable(noewmotherfucker)
    AFK_WARN_TIME = NNT.ANTI_AFK.Config.Settings.WARN
    AFK_TIME = NNT.ANTI_AFK.Config.Settings.KICK
    AFK_REPEAT = AFK_TIME - AFK_WARN_TIME
    AFK_ENABLE = NNT.ANTI_AFK.Config.Settings.ANTIAFK
    AFK_ADMINBYPASS = NNT.ANTI_AFK.Config.Settings.BYPASS
    AFK_ADMINUBYPASS = NNT.ANTI_AFK.Config.Settings.UBYPASS
    AFK_ADMINBYPASS_GROUPS = NNT.ANTI_AFK.Config.BypassGroups
    AFK_ADMINBYPASS_USERS = NNT.ANTI_AFK.Config.UsersBypass
    AFK_THEME = NNT.ANTI_AFK.Config.Settings.THEME
    AFK_VERSION = NNT.ANTI_AFK.Config.Version
    AFK_GHOST = NNT.ANTI_AFK.Config.Settings.GHOST
    AFK_DARKRPMONEY = NNT.ANTI_AFK.Config.Settings.DARKPMONEY
end

local function checkafkdata(data, name)
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

local function NNTAntiAFKUpdate()
    if AFK_GHOST == nil then
        AFK_GHOST = false
    end

    if AFK_DARKRPMONEY == nil then
        AFK_DARKRPMONEY = false
    end

    if AFK_GODMODE == nil then
        AFK_GODMODE = false
    end

    NNT.ANTI_AFK.DefaultConfigUpdate = {}
    NNT.ANTI_AFK.DefaultConfigUpdate.BypassGroups = AFK_ADMINBYPASS_GROUPS

    NNT.ANTI_AFK.DefaultConfigUpdate.TimeSettings = {
        ["StartHours"] = checkafkdata(AFK_StartTimeHours, "StartHours"),
        ["StartMinutes"] = checkafkdata(AFK_StartTimeMinutes, "StartMinutes"),
        ["StopHours"] = checkafkdata(AFK_StopTimeHours, "StopHours"),
        ["StopMinutes"] = checkafkdata(AFK_StopTimeMinutes, "StopMinutes")
    }

    NNT.ANTI_AFK.DefaultConfigUpdate.Settings = {
        ["WARN"] = checkafkdata(AFK_WARN_TIME, "WARN"),
        ["KICK"] = checkafkdata(AFK_TIME, "KICK"),
        ["BYPASS"] = checkafkdata(AFK_ADMINBYPASS),
        ["UBYPASS"] = checkafkdata(AFK_ADMINUBYPASS),
        ["ANTIAFK"] = checkafkdata(AFK_ENABLE),
        ["THEME"] = checkafkdata(AFK_THEME, "THEME"),
        ["GHOST"] = checkafkdata(AFK_GHOST),
        ["DARKPMONEY"] = checkafkdata(AFK_DARKRPMONEY),
        ["GODMODE"] = checkafkdata(AFK_GODMODE),
        ["JOBENABLE"] = checkafkdata(AFK_JOBENABLE),
        ["JOBNAME"] = checkafkdata(AFK_JOBNAME, "JOB"),
        ["ENABLETIME"] = checkafkdata(AFK_ENABLETIME),
        ["JOBREVERT"] = checkafkdata(AFK_JOBREVERT)
    }

    NNT.ANTI_AFK.DefaultConfigUpdate.UsersBypass = NNT.ANTI_AFK.Config.UsersBypass
    NNT.ANTI_AFK.DefaultConfigUpdate.Version = NNTAntiAfkCurrentVersion
    local newdata = util.TableToJSON(NNT.ANTI_AFK.DefaultConfigUpdate, true)
    file.Write("nnt-antiafk/AntiAFKConfig.txt", newdata)
    NNT.ANTI_AFK:ReloadConfig()
end

local function NNTCheckVersion(stringasdasd)
    local Really = string.Split(stringasdasd, ".")
    local stringversion = Really[1] .. Really[2] .. Really[3]
    local numversion = tonumber(stringversion, 10)

    return numversion
end

function NNTAntiAFKCheckAndUpdate()
    LoadConfigFromFile()
    local LatestVersion = NNTCheckVersion(NNTAntiAfkCurrentVersion)

    if AFK_VERSION == nil then
        local ConfigVersion = 170

        if (LatestVersion > ConfigVersion) then
            NNTAntiAFKUpdate()
        end
    else
        local ConfigVersion = NNTCheckVersion(AFK_VERSION)

        if (LatestVersion > ConfigVersion) then
            NNTAntiAFKUpdate()
        end
    end
    --[[if (LatestVersion > ConfigVersion ) then
        NNTAntiAFKUpdate()
    end]]
end