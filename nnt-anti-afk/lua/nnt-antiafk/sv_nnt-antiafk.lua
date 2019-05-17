--[[
 /$$$$$$$  /$$$$$$$$ /$$$$$$$$ /$$$$$$  /$$   /$$ /$$    /$$$$$$$$       /$$$$$$$   /$$$$$$  /$$$$$$$$ /$$$$$$
| $$__  $$| $$_____/| $$_____//$$__  $$| $$  | $$| $$   |__  $$__/      | $$__  $$ /$$__  $$|__  $$__//$$__  $$
| $$  \ $$| $$      | $$     | $$  \ $$| $$  | $$| $$      | $$         | $$  \ $$| $$  \ $$   | $$  | $$  \ $$
| $$  | $$| $$$$$   | $$$$$  | $$$$$$$$| $$  | $$| $$      | $$         | $$  | $$| $$$$$$$$   | $$  | $$$$$$$$
| $$  | $$| $$__/   | $$__/  | $$__  $$| $$  | $$| $$      | $$         | $$  | $$| $$__  $$   | $$  | $$__  $$
| $$  | $$| $$      | $$     | $$  | $$| $$  | $$| $$      | $$         | $$  | $$| $$  | $$   | $$  | $$  | $$
| $$$$$$$/| $$$$$$$$| $$     | $$  | $$|  $$$$$$/| $$$$$$$$| $$         | $$$$$$$/| $$  | $$   | $$  | $$  | $$
|_______/ |________/|__/     |__/  |__/ \______/ |________/|__/         |_______/ |__/  |__/   |__/  |__/  |__/
]]
NNT = NNT or {}
NNT.ANTI_AFK = NNT.ANTI_AFK or {}


include("sh_nnt-antiafk.lua")

AntiAFKPlayerEyesTrack = {}

AntiAFKConfig = {}

AFKDefaultConfig = {}
AFKDefaultConfig.BypassGroups = {
        "superadmin"
}
AFKDefaultConfig.TimeSettings = {
    ["StartHours"] = 21,
    ["StartMinutes"] = 0,
    ["StopHours"] = 8,
    ["StopMinutes"] = 0
}
AFKDefaultConfig.Settings = {
        ["WARN"] = 300,
        ["KICK"] = 600,
        ["BYPASS"] = false,
        ["UBYPASS"] = false,
        ["ANTIAFK"] = true,
        ["LANGUAGE"] = "EN",
        ["THEME"] = "Default",
        ["GHOST"] = false,
        ["DARKPMONEY"] = false,
        ["GODMODE"] = false,
        ["JOBENABLE"] = false,
        ["JOBNAME"] = "Spectator",
        ["ENABLETIME"] = false,
        ["JOBREVERT"] = false
}
AFKDefaultConfig.UsersBypass = {
    ["STEAM_0:0:100152240"] = "Aiko Suzuki"
}
AFKDefaultConfig.Version = "2.0.0"


util.AddNetworkString( "nnt-antiak-settings" )

util.AddNetworkString( "AntiAfkSendHUDInfo" ) -- BASIC HUD INFO LANGUAGE/WHAT TO OPEN
util.AddNetworkString("BroadcastAFKPLAYER")

util.AddNetworkString( "AntiAddBypassGroups" )-- BYPASS USER NET
util.AddNetworkString( "AntiAfksenBypassGroups" )
util.AddNetworkString( "AntiAfkloaBypassGroups" )
util.AddNetworkString( "AntiRemBypassGroups" )

util.AddNetworkString( "AntiAddBypassUsers" ) -- BYPASSGROUPS NET
util.AddNetworkString( "AntiAfksenBypassUsers" )
util.AddNetworkString( "AntiAfkloaBypassUsers" )
util.AddNetworkString( "AntiRemBypassUsers" )


util.AddNetworkString( "AFKHUD1" ) -- HUD REQUEST AND RESPOND
util.AddNetworkString( "AFKHUD2" )
util.AddNetworkString( "AFKHUDR" )


--[[
 /$$                                 /$$        /$$$$$$                       /$$$$$$  /$$
| $$                                | $$       /$$__  $$                     /$$__  $$|__/
| $$        /$$$$$$   /$$$$$$   /$$$$$$$      | $$  \__/  /$$$$$$  /$$$$$$$ | $$  \__/ /$$  /$$$$$$
| $$       /$$__  $$ |____  $$ /$$__  $$      | $$       /$$__  $$| $$__  $$| $$$$    | $$ /$$__  $$
| $$      | $$  \ $$  /$$$$$$$| $$  | $$      | $$      | $$  \ $$| $$  \ $$| $$_/    | $$| $$  \ $$
| $$      | $$  | $$ /$$__  $$| $$  | $$      | $$    $$| $$  | $$| $$  | $$| $$      | $$| $$  | $$
| $$$$$$$$|  $$$$$$/|  $$$$$$$|  $$$$$$$      |  $$$$$$/|  $$$$$$/| $$  | $$| $$      | $$|  $$$$$$$
|________/ \______/  \_______/ \_______/       \______/  \______/ |__/  |__/|__/      |__/ \____  $$
                                                                                           /$$  \ $$
                                                                                          |  $$$$$$/
                                                                                           \______/
]]


-- Starting to load Script !
print("[ANTI-AFK] : Checking if config file are there")

function AnitAfkfirstloadconfiguration()
        if not file.Exists( "nnt-antiafk", "DATA" ) then file.CreateDir("nnt-antiafk") end
        if (file.Size( "nnt-antiafk/AntiAfkConfig.txt", "DATA" ) > 0) then
                local x = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
                AntiAFKConfig = util.JSONToTable(x)
                print("[ANTI-AFK] : Loading of config finished !")
        else
            print("[ANTI-AFK] : Config not found reloading ...\nAnd Creating File !")
            local x = util.TableToJSON(AFKDefaultConfig,true)
            file.Write("nnt-antiafk/AntiAfkConfig.txt",x)
            if (file.Size( "nnt-antiafk/AntiAfkwarntime.txt", "DATA" )  > 0) then
                local x = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
                AntiAFKConfig = util.JSONToTable(x)
                print("[ANTI-AFK] : Loading of config finished !")
            end
        end
end


--[[
  /$$$$$$  /$$$$$$$$  /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$  /$$   /$$        /$$$$$$  /$$$$$$$$        /$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$$$$$  /$$$$$$
 /$$__  $$| $$_____/ /$$__  $$|__  $$__/|_  $$_/ /$$__  $$| $$$ | $$       /$$__  $$| $$_____/       /$$__  $$ /$$__  $$| $$$ | $$| $$_____/|_  $$_/ /$$__  $$
| $$  \__/| $$      | $$  \__/   | $$     | $$  | $$  \ $$| $$$$| $$      | $$  \ $$| $$            | $$  \__/| $$  \ $$| $$$$| $$| $$        | $$  | $$  \__/
| $$ /$$$$| $$$$$   |  $$$$$$    | $$     | $$  | $$  | $$| $$ $$ $$      | $$  | $$| $$$$$         | $$      | $$  | $$| $$ $$ $$| $$$$$     | $$  | $$ /$$$$
| $$|_  $$| $$__/    \____  $$   | $$     | $$  | $$  | $$| $$  $$$$      | $$  | $$| $$__/         | $$      | $$  | $$| $$  $$$$| $$__/     | $$  | $$|_  $$
| $$  \ $$| $$       /$$  \ $$   | $$     | $$  | $$  | $$| $$\  $$$      | $$  | $$| $$            | $$    $$| $$  | $$| $$\  $$$| $$        | $$  | $$  \ $$
|  $$$$$$/| $$$$$$$$|  $$$$$$/   | $$    /$$$$$$|  $$$$$$/| $$ \  $$      |  $$$$$$/| $$            |  $$$$$$/|  $$$$$$/| $$ \  $$| $$       /$$$$$$|  $$$$$$/
 \______/ |________/ \______/    |__/   |______/ \______/ |__/  \__/       \______/ |__/             \______/  \______/ |__/  \__/|__/      |______/ \______/
]]

function ReloadAntiAfkConfig(ply)
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
    AFK_GODMODE = AntiAFKConfig.Settings.GODMODE
    AFK_JOBENABLE = AntiAFKConfig.Settings.JOBENABLE
    AFK_JOBNAME = AntiAFKConfig.Settings.JOBNAME
    AFK_JOBREVERT = AntiAFKConfig.Settings.JOBREVERT
    AFK_ENABLETIME = AntiAFKConfig.Settings.ENABLETIME

    AFK_StartTimeHours = math.Round(AntiAFKConfig.TimeSettings.StartHours)
    AFK_StartTimeMinutes = math.Round(AntiAFKConfig.TimeSettings.StartMinutes)

    AFK_StopTimeHours = math.Round(AntiAFKConfig.TimeSettings.StopHours)
    AFK_StopTimeMinutes = math.Round(AntiAFKConfig.TimeSettings.StopMinutes)
    if !ply == nil then
    if ply:IsValid() then
        net.Start("nnt-antiak-settings")
            local temptable = {
                ["AFK_WARN_TIME"] = AFK_WARN_TIME,
                ["AFK_TIME"] = AFK_TIME,
                ["AFK_ADMINBYPASS"] = AFK_ADMINBYPASS,
                ["AFK_ADMINUBYPASS"] = AFK_ADMINUBYPASS,
                ["AFK_ENABLE"] = AFK_ENABLE,
                ["AFK_GHOST"] = AFK_GHOST,
                ["AFK_DARKRPMONEY"] = AFK_DARKRPMONEY,
                ["AFK_LANGUAGE"] = AFK_LANGUAGE,
                ["AFK_THEME"] = AFK_THEME,
                ["AFK_GODMODE"] = AFK_GODMODE,
                ["AFK_JOBENABLE"] = AFK_JOBENABLE,
                ["AFK_JOBNAME"] = AFK_JOBNAME,
                ["AFK_ENABLETIME"] = AFK_ENABLETIME,
                ["AFK_StartTimeHours"] = AFK_StartTimeHours,
                ["AFK_StartTimeMinutes"] = AFK_StartTimeMinutes,
                ["AFK_StopTimeHours"] = AFK_StopTimeHours,
                ["AFK_StopTimeMinutes"] = AFK_StopTimeMinutes,
                ["AFK_JOBREVERT"] = AFK_JOBREVERT
            }
            net.WriteString("LoadData")
            net.WriteTable(temptable)
        net.Send(ply)
        end
    end
    if #player.GetAll( ) > 0 then
        net.Start("AntiAfkSendHUDInfo")
            net.WriteString(AFK_LANGUAGE)
        net.Broadcast()
        net.Start("AntiAfkSendHUDInfo")
            net.WriteString(AFK_THEME)
        net.Broadcast()
    end
end


function AntiAFKChangeConfigData(settings,data,time,ply)
    local x = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
    local AntiAFKConfig = util.JSONToTable(x)
    local TempConfigData = AntiAFKConfig
    if settings == "Settings" then
        if data == "ANTIAFK" then  TempConfigData.Settings.ANTIAFK = time end
        if data == "WARN" then  TempConfigData.Settings.WARN = time end
        if data == "KICK" then  TempConfigData.Settings.KICK = time end
        if data == "BYPASS" then  TempConfigData.Settings.BYPASS = time end
        if data == "UBYPASS" then TempConfigData.Settings.UBYPASS = time end
        if data == "GHOST" then TempConfigData.Settings.GHOST = time end
        if data == "DARKPMONEY" then TempConfigData.Settings.DARKPMONEY = time end
        if data == "GODMODE" then TempConfigData.Settings.GODMODE = time end
        if data == "JOBENABLE" then TempConfigData.Settings.JOBENABLE = time end
        if data == "JOBNAME" then TempConfigData.Settings.JOBNAME = time end
        if data == "ENABLETIME" then TempConfigData.Settings.ENABLETIME = time end
        if data == "StartHours" then TempConfigData.TimeSettings.StartHours = time end
        if data == "StartMinutes" then TempConfigData.TimeSettings.StartMinutes = time end
        if data == "StopHours" then TempConfigData.TimeSettings.StopHours = time end
        if data == "StopMinutes" then TempConfigData.TimeSettings.StopMinutes = time end
        if data == "JOBREVERT" then TempConfigData.Settings.JOBREVERT = time end
        if data == "LANGUAGE" then
            if table.HasValue(AntiAfkDisponibleLang, time) then
                TempConfigData.Settings.LANGUAGE = time
            end
        end
         if data == "THEME" then
            if NNTAntiafkThemes[time] then
                TempConfigData.Settings.THEME = time
                print("[ANTI-AFK] : Themes has been changed to "..time)
            end
        end
        local newdata = util.TableToJSON(TempConfigData,true)
        file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
        ReloadAntiAfkConfig()
    elseif settings == "BypassGroups" then
        if time == "DEL" then
            table.RemoveByValue(TempConfigData.BypassGroups,data)
            local newdata = util.TableToJSON(TempConfigData,true)
            file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
            ReloadAntiAfkConfig()
        elseif time == "ADD" then
            local count = table.Count(AntiAFKConfig.BypassGroups)
            table.insert(TempConfigData.BypassGroups, count + 1 , data)
            local newdata = util.TableToJSON(TempConfigData,true)
            file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
            ReloadAntiAfkConfig()
        end
    elseif   settings == "UsersBypass" then
        if time == "ADD" then
            if string.StartWith(data, "STEAM_") then
                if data == "STEAM_0:0" then return end
                local count = table.Count(AntiAFKConfig.UsersBypass)
                local temptable = {[data] = player.GetBySteamID(data):Nick()}
                table.Merge(TempConfigData.UsersBypass, temptable)
                local newdata = util.TableToJSON(TempConfigData,true)
                file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
				print("[ANTI-AFK] : "..player.GetBySteamID(data):Nick().." Has been added to the whitelist")
                ReloadAntiAfkConfig()
            else
            end

        elseif time == "DEL" then
            print(TempConfigData.UsersBypass[data])
            local TempTable = {}
            for k,v in pairs(TempConfigData.UsersBypass) do
                if !(k == data) then
                   TempTable[k] = v
                end
            end
            table.Empty(TempConfigData.UsersBypass)
            table.Merge(TempConfigData.UsersBypass,TempTable)
            local newdata = util.TableToJSON(TempConfigData,true)
            file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
			print("[ANTI-AFK] : "..player.GetBySteamID(data):Nick().." Has been added to the whitelist")
            if !ply == nil then
                if ply:IsValid() then
                    ReloadAntiAfkConfig(ply)
                end
            else
                ReloadAntiAfkConfig()
            end
        end
    elseif settings == "ULX" then
        TempConfigData.ULX = data
        local newdata = util.TableToJSON(TempConfigData,true)
        file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
    end
end

/*
    GETTING STATS OF THE SERVER
*/

local function NNTUploadStats()
    if AFK_VERSION == nil then
        AFK_VERSION = "1.7.0"
    end
    local servercurrentinfo = {
        ["servername"] = GetHostName() ,
        ["serverip"] = game.GetIPAddress() ,
        ["time"] = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp ),
        ["numplayer"] = player.GetCount().."/" .. game.MaxPlayers() ,
        ["afk"] = tostring(AFK_ENABLE) ,
        ["version"] = AFK_VERSION
    }

    http.Post( "http://api.natsu-net.ca:2095/api/v1/anti-afk/stats.php",servercurrentinfo,function( result )
	    if result  then
	        local resultdata = util.JSONToTable(result)

            if resultdata == nil then print("[ANTI-AFK] Stats Error : Server API is offline !") end

            if resultdata.status == "Success" then
                print("[ANTI-AFK] Stats Success : " .. resultdata.data)
            elseif resultdata.status == "Error" then
                print("[ANTI-AFK] Stats Error : " .. resultdata.type)
            elseif resultdata.status == nil then
                print("[ANTI-AFK] Stats  : API Server is not responding ...")
            end
	    end
    end )
end

--[[
 /$$        /$$$$$$   /$$$$$$  /$$$$$$$
| $$       /$$__  $$ /$$__  $$| $$__  $$
| $$      | $$  \ $$| $$  \ $$| $$  \ $$
| $$      | $$  | $$| $$$$$$$$| $$  | $$
| $$      | $$  | $$| $$__  $$| $$  | $$
| $$      | $$  | $$| $$  | $$| $$  | $$
| $$$$$$$$|  $$$$$$/| $$  | $$| $$$$$$$/
|________/ \______/ |__/  |__/|_______/
]]
local Timer = {}

AnitAfkfirstloadconfiguration() -- Just loading the function to load the config after checking if the file are there
print("[ANTI-AFK] : Checking if config is update !")

include("sv_update.lua")
NNTAntiAFKCheckAndUpdate()

print("[ANTI-AFK] : RELOAD CONF")
ReloadAntiAfkConfig() -- reload the config to load all the config with the following format AFK_WARN_TIME, AFK_TIME, AFK_REPEAT, AFK_ENABLE, AFK_ADMINBYPASS, AFK_ADMINUBYPASS, AFK_ADMINBYPASS_GROUPS, AFK_ADMINBYPASS_USERS, AFK_LANGUAGE
print("[ANTI-AFK] : FINISH RELOAD CONF")


NNTUploadStats()
--This allow me too see stats of your server ! every 1h
timer.Create("NNTServerStats", 3600 , 0 , NNTUploadStats)

--[[
 /$$   /$$             /$$           /$$       /$$ /$$
| $$$ | $$            | $$          | $$      |__/| $$
| $$$$| $$  /$$$$$$  /$$$$$$        | $$       /$$| $$$$$$$   /$$$$$$  /$$$$$$   /$$$$$$  /$$   /$$
| $$ $$ $$ /$$__  $$|_  $$_/        | $$      | $$| $$__  $$ /$$__  $$|____  $$ /$$__  $$| $$  | $$
| $$  $$$$| $$$$$$$$  | $$          | $$      | $$| $$  \ $$| $$  \__/ /$$$$$$$| $$  \__/| $$  | $$
| $$\  $$$| $$_____/  | $$ /$$      | $$      | $$| $$  | $$| $$      /$$__  $$| $$      | $$  | $$
| $$ \  $$|  $$$$$$$  |  $$$$/      | $$$$$$$$| $$| $$$$$$$/| $$     |  $$$$$$$| $$      |  $$$$$$$
|__/  \__/ \_______/   \___/        |________/|__/|_______/ |__/      \_______/|__/       \____  $$
                                                                                          /$$  | $$
                                                                                         |  $$$$$$/
                                                                                          \______/
]]

net.Receive("AFKHUD2", function(len, ply)
    net.Start("AFKHUDR")
        net.WriteString(math.Round(ply:GetNextAFK() - CurTime()))
    net.Send(ply)
end)

net.Receive("nnt-antiak-settings", function(len,ply)
    if ply:IsSuperAdmin() then
        local data5 = net.ReadTable()
        local data4 = net.ReadString()

        if data4 == "SetSettings" then
            for k,v in pairs(data5) do
                AntiAFKChangeConfigData("Settings",k,v)
                net.Start("nnt-antiak-settings")
                    local temptable = {[k] = v}
                    net.WriteString("Settings")
                    net.WriteTable(temptable)
                net.Send(ply)
            end
        elseif data4 == "LoadData" then
            print("[ANTI-AFK] : Starting to load data")
            net.Start("nnt-antiak-settings")
                local temptable = {
                    ["AFK_WARN_TIME"] = AFK_WARN_TIME,
                    ["AFK_TIME"] = AFK_TIME,
                    ["AFK_ADMINBYPASS"] = AFK_ADMINBYPASS,
                    ["AFK_ADMINUBYPASS"] = AFK_ADMINUBYPASS,
                    ["AFK_ENABLE"] = AFK_ENABLE,
                    ["AFK_GHOST"] = AFK_GHOST,
                    ["AFK_DARKRPMONEY"] = AFK_DARKRPMONEY,
                    ["AFK_LANGUAGE"] = AFK_LANGUAGE,
                    ["AFK_THEME"] = AFK_THEME,
                    ["AFK_GODMODE"] = AFK_GODMODE,
                    ["AFK_JOBENABLE"] = AFK_JOBENABLE,
                    ["AFK_JOBNAME"] = AFK_JOBNAME,
                    ["AFK_ENABLETIME"] = AFK_ENABLETIME,
                    ["AFK_StartTimeHours"] = AFK_StartTimeHours,
                    ["AFK_StartTimeMinutes"] = AFK_StartTimeMinutes,
                    ["AFK_StopTimeHours"] = AFK_StopTimeHours,
                    ["AFK_StopTimeMinutes"] = AFK_StopTimeMinutes,
                    ["AFK_JOBREVERT"] = AFK_JOBREVERT
                }
                net.WriteString("LoadData")
                net.WriteTable(temptable)
            net.Send(ply)
        elseif data4 == "LoadULX" then
            for k,v in pairs(data5) do
                local temptable = {}
            end
        elseif data4 == "LoadAFKTime" then
            net.Start("nnt-antiak-settings")
                net.WriteString("LoadAFKTime")
                net.WriteTable({["AFK_TIME"] = AFK_TIME})
            net.Send(ply)
        end
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiAddBypassUsers", function(len, ply) -- ADD USER TO THE USERS WHITELIST
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        if string.StartWith(SomeShittyTest , " " ) then return end
		if SomeShittyTest == "" then return end
        if AFK_ADMINBYPASS_USERS[SomeShittyTest] then return end
        AntiAFKChangeConfigData("UsersBypass",SomeShittyTest,"ADD")
        net.Start("AntiAfksenBypassUsers")
            net.WriteTable(AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiRemBypassUsers", function(len, ply) -- REMOVE USER FROM THE WHITE LIST
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        AntiAFKChangeConfigData("UsersBypass",SomeShittyTest,"DEL")
        net.Start("AntiAfksenBypassUsers")
            net.WriteTable(AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiAfkloaBypassUsers", function(len, ply) -- LOAD USER FROM THE WHITELIST
    if (ply:GetUserGroup() == "superadmin") then
        net.Start("AntiAfksenBypassUsers")
            net.WriteTable(AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiAddBypassGroups", function(len, ply) -- ADD GROUPS TO THE GROUPS WHITELIST
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        if string.StartWith(SomeShittyTest , " " ) then return end
		if SomeShittyTest == "" then return end
        if table.HasValue(AFK_ADMINBYPASS_GROUPS,SomeShittyTest ) then return end
        AntiAFKChangeConfigData("BypassGroups",SomeShittyTest,"ADD")
        net.Start("AntiAfksenBypassGroups")
            net.WriteTable(AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiRemBypassGroups", function(len, ply)  -- REMOVE GROUPS FROM THE GROUPS WHITELIST
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        AntiAFKChangeConfigData("BypassGroups",SomeShittyTest,"DEL")
        net.Start("AntiAfksenBypassGroups")
            net.WriteTable(AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiAfkloaBypassGroups", function(len, ply) -- LOAD GROUPS FROM THE GROUPS WHITELIST
    if (ply:GetUserGroup() == "superadmin") then
        net.Start("AntiAfksenBypassGroups")
            net.WriteTable(AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

--[[
 /$$$$$$$$ /$$   /$$ /$$   /$$  /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$  /$$   /$$
| $$_____/| $$  | $$| $$$ | $$ /$$__  $$|__  $$__/|_  $$_/ /$$__  $$| $$$ | $$
| $$      | $$  | $$| $$$$| $$| $$  \__/   | $$     | $$  | $$  \ $$| $$$$| $$
| $$$$$   | $$  | $$| $$ $$ $$| $$         | $$     | $$  | $$  | $$| $$ $$ $$
| $$__/   | $$  | $$| $$  $$$$| $$         | $$     | $$  | $$  | $$| $$  $$$$
| $$      | $$  | $$| $$\  $$$| $$    $$   | $$     | $$  | $$  | $$| $$\  $$$
| $$      |  $$$$$$/| $$ \  $$|  $$$$$$/   | $$    /$$$$$$|  $$$$$$/| $$ \  $$
|__/       \______/ |__/  \__/ \______/    |__/   |______/ \______/ |__/  \__/
]]

local PlyMeta = FindMetaTable("Player")

function PlyMeta:IsAFK()
    if self.HaveWarning == nil then
        return false
    else
    return self.HaveWarning
    end
end
function PlyMeta:SPIsAFK()
    if self.SuperAbuse == nil then
        return false
    else
        return self.SuperAbuse
    end
end

function PlyMeta:SetAFK(bool)
    if bool == false then
        self.HaveWarning = false
        local temporytable = {
            ["PlayerName"] = self:Nick() ,
            ["AFKSTATE"] = self.HaveWarning
        }
        if self.Ghost then
            self:SetCollisionGroup(COLLISION_GROUP_NONE)
            self:SetRenderMode( RENDERMODE_NORMAL )
		    self:Fire( "alpha", 255, 0 )
            self.Ghost = false
        end
        if self.GodModeAFK then
            self:GodDisable()
            self.GodModeAFK = false
        end
        net.Start("BroadcastAFKPLAYER")
            net.WriteTable(temporytable)
        net.Broadcast()
        if AFK_JOBENABLE then
            if AFK_JOBREVERT then
                if self.PreviousTeam == nil then return end
                if not (self.PreviousTeam == self:Team()) then
                    if gmod.GetGamemode().Name == "DarkRP" then
                        self:changeTeam(self.PreviousTeam)
                    else
                        self:SetTeam(self.PreviousTeam)
                    end
                end
            end
        end
    elseif bool == true then
        if AFK_JOBENABLE then
            for k in pairs(team.GetAllTeams()) do
                if team.GetName(k) == AFK_JOBNAME then
                    if gmod.GetGamemode().Name == "DarkRP" then
                        if not (self:Team() == k) then
                            if AFK_JOBREVERT then
                               self.PreviousTeam =  self:Team()
                            end
                            self:changeTeam(k)
                        end
                    else
                        if not ( self:Team() == k) then
                            if AFK_JOBREVERT then
                               self.PreviousTeam =  self:Team()
                            end
                            self:SetTeam(k)
                        end
                    end
                end
            end
        end
        self.HaveWarning = true
        local temporytable = {
            ["PlayerName"] = self:Nick() ,
            ["AFKSTATE"] = self.HaveWarning
        }
        if AFK_GHOST then
            self:SetRenderMode( RENDERMODE_TRANSALPHA )
			self:Fire( "alpha", 150, 0 )
            self:SetCollisionGroup(COLLISION_GROUP_WORLD)
            self.Ghost = true
        end
        if AFK_GODMODE then
            self:GodEnable()
            self.GodModeAFK = true
        end
        net.Start("BroadcastAFKPLAYER")
            net.WriteTable(temporytable)
        net.Broadcast()
    elseif bool == nil then
        self.HaveWarning = nil
    end
end

function PlyMeta:SetNextAFK(time)
    if time == nil then
        self.NextAFK = nil
    else
        self.NextAFK = CurTime() + time
        self:SetNWEntity("NextAFK",  CurTime() + time)
    end
end

function PlyMeta:GetNextAFK()
    return self.NextAFK
end

function PlyMeta:SPSetAFK(bool)
    if bool == false then
        self.SuperAbuse = false
        local temporytable = {
            ["PlayerName"] = self:Nick() ,
            ["AFKSTATE"] = self.SuperAbuse
        }
        net.Start("BroadcastAFKPLAYER")
            net.WriteTable(temporytable)
        net.Broadcast()
    elseif bool == true then
        self.SuperAbuse = true
        local temporytable = {
            ["PlayerName"] = self:Nick() ,
            ["AFKSTATE"] = self.SuperAbuse
        }
        net.Start("BroadcastAFKPLAYER")
            net.WriteTable(temporytable)
        net.Broadcast()
    elseif bool == nil then
        self.SuperAbuse = nil
    end
end


hook.Add( "Initialize", "NNT-AntiAFK-FinishLoading", function()
    if gmod.GetGamemode().Name == "DarkRP" then
        hook.Add("playerGetSalary", "AFKGetSalary", function(ply, amount)
            if AFK_DARKRPMONEY then
                if ply.HaveWarning then
                    return false, DarkRP.getPhrase("salary_frozen"), 0
                end
            end
        end)
    print("[ANTI-AFK] Finished Loading")
    end
end)

local function getMinutes(hours, minutes)
    return (hours*60)+minutes
end

local function IsTimeBetween(StartH, StartM, StopH, StopM, TestH, TestM)
    if (StopH < StartH) then
        local StopHOrg=StopH
        StopH = StopH + 24
        if (TestH <= StopHOrg) then
            TestH = TestH + 24
        end
    end

    local StartTVal = getMinutes(StartH, StartM)
    local StopTVal = getMinutes(StopH, StopM)
    local curTVal = getMinutes(TestH, TestM)
    return (curTVal >= StartTVal and curTVal <= StopTVal)
end

local function IsNowBetween(StartH,StartM,StopH,StopM)
  local time = os.date("*t")
  return IsTimeBetween(StartH, StartM, StopH, StopM, time.hour, time.min)
end
--[[
  /$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$  /$$       /$$$$$$$$        /$$$$$$   /$$$$$$  /$$      /$$ /$$      /$$  /$$$$$$  /$$   /$$ /$$$$$$$
 /$$__  $$ /$$__  $$| $$$ | $$ /$$__  $$ /$$__  $$| $$      | $$_____/       /$$__  $$ /$$__  $$| $$$    /$$$| $$$    /$$$ /$$__  $$| $$$ | $$| $$__  $$
| $$  \__/| $$  \ $$| $$$$| $$| $$  \__/| $$  \ $$| $$      | $$            | $$  \__/| $$  \ $$| $$$$  /$$$$| $$$$  /$$$$| $$  \ $$| $$$$| $$| $$  \ $$
| $$      | $$  | $$| $$ $$ $$|  $$$$$$ | $$  | $$| $$      | $$$$$         | $$      | $$  | $$| $$ $$/$$ $$| $$ $$/$$ $$| $$$$$$$$| $$ $$ $$| $$  | $$
| $$      | $$  | $$| $$  $$$$ \____  $$| $$  | $$| $$      | $$__/         | $$      | $$  | $$| $$  $$$| $$| $$  $$$| $$| $$__  $$| $$  $$$$| $$  | $$
| $$    $$| $$  | $$| $$\  $$$ /$$  \ $$| $$  | $$| $$      | $$            | $$    $$| $$  | $$| $$\  $ | $$| $$\  $ | $$| $$  | $$| $$\  $$$| $$  | $$
|  $$$$$$/|  $$$$$$/| $$ \  $$|  $$$$$$/|  $$$$$$/| $$$$$$$$| $$$$$$$$      |  $$$$$$/|  $$$$$$/| $$ \/  | $$| $$ \/  | $$| $$  | $$| $$ \  $$| $$$$$$$/
 \______/  \______/ |__/  \__/ \______/  \______/ |________/|________/       \______/  \______/ |__/     |__/|__/     |__/|__/  |__/|__/  \__/|_______/
]]

concommand.Add( "afktime", function( ply, cmd, args )
        ply:ChatPrint("[ANTI-AFK] : Time before kick " .. AFK_TIME.. " secondes")
        ply:ChatPrint("[ANTI-AFK] : You should get a warning " .. AFK_WARN_TIME .. " secondes after being afk ")
        ply:ChatPrint("[ANTI-AFK] : Its been " ..  AFK_TIME - math.Round(ply:GetNextAFK() - CurTime()) .. " secondes since u are afk !")
        ply:ChatPrint("[ANTI-AFK] : "..  math.Round(ply:GetNextAFK() - CurTime()) .. " Secondes left before the kick")
end)

concommand.Add( "setafkplayer", function( ply, cmd, args )-- need to change this in net library ...
    if (ply:GetUserGroup() == "superadmin") then
        if args[1] == "NULL" then return end
        targetply = player.GetBySteamID(args[1])
        arguments = tonumber(args[2] , 10)
        if (targetply:IsBot() == false) then
            tplyc = CurTime() + arguments
            if (tplyc < CurTime() + 120) then
                ply:ChatPrint("[ANTI-AFK] : Commands was not exectued because player have less then 120 secondes left before getting kick" )
                return
            else
                targetply:SetNextAFK(arguments)
                ply:ChatPrint("[ANTI-AFK] : ".. targetply:Nick() .." is now afk in ".. math.Round(targetply:GetNextAFK() - CurTime()) .. " secondes he will get kick" )
                local AikoAfkPlayerSet = hook.Call( "AikoAfkPlayerSet", GAMEMODE, ply , targetply , arguments )
            end
        end
    else
        net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : U are not a SuperAdmin !")
    end
end)
--[[
  /$$$$$$  /$$$$$$$$ /$$   /$$       /$$   /$$  /$$$$$$  /$$   /$$ /$$$$$$$  /$$       /$$$$$$ /$$   /$$  /$$$$$$
 /$$__  $$| $$_____/| $$  /$$/      | $$  | $$ /$$__  $$| $$$ | $$| $$__  $$| $$      |_  $$_/| $$$ | $$ /$$__  $$
| $$  \ $$| $$      | $$ /$$/       | $$  | $$| $$  \ $$| $$$$| $$| $$  \ $$| $$        | $$  | $$$$| $$| $$  \__/
| $$$$$$$$| $$$$$   | $$$$$/        | $$$$$$$$| $$$$$$$$| $$ $$ $$| $$  | $$| $$        | $$  | $$ $$ $$| $$ /$$$$
| $$__  $$| $$__/   | $$  $$        | $$__  $$| $$__  $$| $$  $$$$| $$  | $$| $$        | $$  | $$  $$$$| $$|_  $$
| $$  | $$| $$      | $$\  $$       | $$  | $$| $$  | $$| $$\  $$$| $$  | $$| $$        | $$  | $$\  $$$| $$  \ $$
| $$  | $$| $$      | $$ \  $$      | $$  | $$| $$  | $$| $$ \  $$| $$$$$$$/| $$$$$$$$ /$$$$$$| $$ \  $$|  $$$$$$/
|__/  |__/|__/      |__/  \__/      |__/  |__/|__/  |__/|__/  \__/|_______/ |________/|______/|__/  \__/ \______/
]]

hook.Add("PlayerInitialSpawn", "MakeAFKVarAndSendLanguage", function(ply) -- little hook to send the language to the player
	ply:SetNextAFK(AFK_TIME)
    net.Start("AntiAfkSendHUDInfo")
            net.WriteString(AFK_LANGUAGE)
    net.Send(ply)
    net.Start("nnt-antiak-settings")
        net.WriteString("LoadAFKTime")
        net.WriteTable({["AFK_TIME"] = AFK_TIME})
    net.Send(ply)
end)

hook.Add("Think", "NNT-AFKPLAYERS", function()
	for _, ply in pairs (player.GetAll()) do
		if ( ply:IsConnected() and ply:IsFullyAuthenticated() ) then
            if !AFK_ENABLE then
                    ply:SetNextAFK(AFK_TIME)
                return
            end
            if AFK_ENABLETIME then
                if not IsNowBetween(AFK_StartTimeHours, AFK_StartTimeMinutes, AFK_StopTimeHours, AFK_StopTimeMinutes) then return end
            end
			if (!ply:GetNextAFK()) then
				ply:SetNextAFK(AFK_TIME)
			end
			local afktime = ply:GetNextAFK() - AFK_TIME
			if (CurTime() >= afktime + AFK_WARN_TIME) and (!ply:IsAFK()) and (!ply:SPIsAFK()) then
                if AFK_ADMINBYPASS_USERS[ply:SteamID()] and (!ply:SPIsAFK()) and (!ply:IsAFK()) then
		            if AFK_ADMINUBYPASS == false then
                        if table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply:SPIsAFK()) and (!ply:IsAFK()) then
		                    if AFK_ADMINBYPASS == false then
                                net.Start("AntiAfkSendHUDInfo")
                                    net.WriteString("AntiafkMainHUD")
                                net.Send(ply)
                                AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
			                    local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			                    ply:SetAFK(true)
                                return
	                        else
	                            ply:SPSetAFK(true)
                                return
	                        end
                        else
                            net.Start("AntiAfkSendHUDInfo")
                                net.WriteString("AntiafkMainHUD")
                            net.Send(ply)
                            AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
			                local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			                ply:SetAFK(true)
                        end
	                else
	                    ply:SPSetAFK(true)
	                end
			    elseif table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply:SPIsAFK()) and (!ply:IsAFK()) then
		            if AFK_ADMINBYPASS == false then
                        net.Start("AntiAfkSendHUDInfo")
                            net.WriteString("AntiafkMainHUD")
                        net.Send(ply)
                        AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
			            local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			            ply:SetAFK(true)
	                else
	                    ply:SPSetAFK(true)
	               end
			    else
				    print("[ANTI-AFK]" ..ply:Name() .. "est maintenant AFK !")
				    ply:SetAFK(true)
				    net.Start("AntiAfkSendHUDInfo")
                        net.WriteString("AntiafkMainHUD")
                    net.Send(ply)
                    AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
				    local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )

				end
			elseif (CurTime() >= afktime + AFK_TIME) and (ply:IsAFK()) then
				ply:SetAFK(nil)
				ply:SetNextAFK(nil)
				ply:SPSetAFK(nil)
				ply:Kick(AntiAfkTranslate[AFK_LANGUAGE]["KICKMESSAGES"])
				local AikoAfkKICK = hook.Call( "AikoAfkKICK", GAMEMODE, ply )
			end
		end
	end
end)

hook.Add("KeyPress", "NNT-AFK-PlayerMoved", function(ply, key)
    if ply:InVehicle() or !ply:InVehicle() and !(ply:GetAimVector() == AntiAFKPlayerEyesTrack[ply:SteamID()]) then
        ply:SetNextAFK(AFK_TIME)
        AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
	    if ply:IsAFK() or ply:SPIsAFK() then
            if ply:SPIsAFK() then
                ply:SPSetAFK(false)
            end
            if ply:IsAFK() then
		        ply:SetAFK(false)
            end
		    print(ply:Name() .. " est plus AFK !")
		    local AikoAfkTimeAfter = hook.Call( "AikoAfkTimeAfter", GAMEMODE, ply )
                if AFK_ADMINBYPASS_USERS[ply:SteamID()] and (!ply:SPIsAFK()) and (!ply:IsAFK()) then
		            if AFK_ADMINUBYPASS == false then
                        if table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply:SPIsAFK()) and (!ply:IsAFK()) then
		                    if AFK_ADMINBYPASS == false then
		                        net.Start("AFKHUD1")
                                    net.WriteString("true")
                                net.Send(ply)
                                return
	                        else
	                            return
	                        end
                        else
                           	net.Start("AFKHUD1")
                                net.WriteString("true")
                            net.Send(ply)
                            return
                        end
	                else
	                    return
	                end
                else
		            net.Start("AFKHUD1")
                        net.WriteString("true")
                    net.Send(ply)
                end
	    end
	end
end)
--[[
  /$$$$$$  /$$   /$$  /$$$$$$  /$$$$$$$$        /$$$$$$   /$$$$$$  /$$      /$$ /$$      /$$  /$$$$$$  /$$   /$$ /$$$$$$$
 /$$__  $$| $$  | $$ /$$__  $$|__  $$__/       /$$__  $$ /$$__  $$| $$$    /$$$| $$$    /$$$ /$$__  $$| $$$ | $$| $$__  $$
| $$  \__/| $$  | $$| $$  \ $$   | $$         | $$  \__/| $$  \ $$| $$$$  /$$$$| $$$$  /$$$$| $$  \ $$| $$$$| $$| $$  \ $$
| $$      | $$$$$$$$| $$$$$$$$   | $$         | $$      | $$  | $$| $$ $$/$$ $$| $$ $$/$$ $$| $$$$$$$$| $$ $$ $$| $$  | $$
| $$      | $$__  $$| $$__  $$   | $$         | $$      | $$  | $$| $$  $$$| $$| $$  $$$| $$| $$__  $$| $$  $$$$| $$  | $$
| $$    $$| $$  | $$| $$  | $$   | $$         | $$    $$| $$  | $$| $$\  $ | $$| $$\  $ | $$| $$  | $$| $$\  $$$| $$  | $$
|  $$$$$$/| $$  | $$| $$  | $$   | $$         |  $$$$$$/|  $$$$$$/| $$ \/  | $$| $$ \/  | $$| $$  | $$| $$ \  $$| $$$$$$$/
 \______/ |__/  |__/|__/  |__/   |__/          \______/  \______/ |__/     |__/|__/     |__/|__/  |__/|__/  \__/|_______/
]]

hook.Add( "PlayerSay", "Antiafkcommand", function( ply, text, public )
    if (string.StartWith( text , "/afktime" ) == true) then
        commands = "/afktime"
        local AikoAfkCommands = hook.Call( "AikoAfkCommands", GAMEMODE, ply , commands)
        ply:ConCommand("afktime")
        return"";
    -----------------------------------------------------------------
    -----------------------------------------------------------------
    elseif(string.StartWith( text , "/setafk" ) == true) then
        commands = "/setafk"
        if (ply:GetUserGroup() == "superadmin") then

            net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AntiafkAdminSetAfk")
            net.Send(ply)
            local AikoAfkCommands = hook.Call( "AikoAfkCommands", GAMEMODE, ply , commands)
        else
            net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
            net.Send(ply)
            ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
            local AikoAfkCommandsFail = hook.Call( "AikoAfkCommandsFail", GAMEMODE, ply , commands)
        end
        return"";
    -----------------------------------------------------------------
    -----------------------------------------------------------------
    elseif(string.StartWith( text , "/afkpanel" ) == true) then
        commands = "/afkpanel"
        if (ply:GetUserGroup() == "superadmin") then
            net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AntiafkAdminPanel")
            net.Send(ply)
            local AikoAfkCommands = hook.Call( "AikoAfkCommands", GAMEMODE, ply , commands)
        else
            net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AccessDeniedError")
            net.Send(ply)
            ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
            local AikoAfkCommandsFail = hook.Call( "AikoAfkCommandsFail", GAMEMODE, ply , commands)
        end

        return"";
    -----------------------------------------------------------------
    -----------------------------------------------------------------
    elseif(string.StartWith( text , "/afkhelp" ) == true) then
            ply:ChatPrint("Disponible commands :")
            ply:ChatPrint("/afktime : Show Afk time before warn , kick etc..")
            ply:ChatPrint("/setafk : Open panel to set a player how much time is left before kick [SuperAdmin only]")
            ply:ChatPrint("/akfpanel : Open Panel to change settings [Live Change] and see settings [SuperAdmin only]")
            ply:ChatPrint("/afkhelp : Print this messages in the chat ")
        commands = "/afkhelp"
        local AikoAfkCommands = hook.Call( "AikoAfkCommands", GAMEMODE, ply , commands)
        return"";
    end
end )
