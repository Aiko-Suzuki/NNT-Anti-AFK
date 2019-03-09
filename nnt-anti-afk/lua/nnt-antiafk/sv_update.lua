
function NNTAntiAFKUpdate()
    AFKDefaultConfigUpdate = {}
    AFKDefaultConfigUpdate.BypassGroups = AFK_ADMINBYPASS_GROUPS
    AFKDefaultConfigUpdate.Settings = {
        ["WARN"] = AFK_WARN_TIME,
        ["KICK"] = AFK_TIME,
        ["BYPASS"] = AFK_ADMINBYPASS,
        ["UBYPASS"] =  AFK_ADMINUBYPASS,
        ["ANTIAFK"] = AFK_ENABLE,
        ["LANGUAGE"] = AFK_LANGUAGE,
        ["THEME"] = AFK_THEME
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
