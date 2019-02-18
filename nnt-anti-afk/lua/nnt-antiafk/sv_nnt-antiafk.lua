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
AntiAfkTranslate = AntiAfkTranslate or {}
print("[NNT-ANTIAFK] Loading Languages")
for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
	include("nnt-antiafk/lang/" .. v)
    print("Loaded " ..v )
end
NNTAntiafkThemes = NNTAntiafkThemes or {}
print("[NNT-ANTIAFK] Loading themes")
for k,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
	include("nnt-antiafk/themes/" .. v)
    print("Loading Themes:  " ..v )
end

AntiAfkDisponibleLang = {}

AntiAfkDisponibleThemes = {}

for k,v in pairs(AntiAfkTranslate) do
	table.insert(AntiAfkDisponibleLang, table.Count(AntiAfkDisponibleLang) + 1,k)
end

for k,v in pairs(NNTAntiafkThemes) do
	table.ForceInsert(AntiAfkDisponibleThemes, k)
    print("Themes working: " .. k)
end



AntiAFKPlayerEyesTrack = {}

AntiAFKConfig = {}

AFKDefaultConfig = {}
AFKDefaultConfig.BypassGroups = {
        "superadmin"
}
AFKDefaultConfig.Settings = {
        ["WARN"] = 300,
        ["KICK"] = 600,
        ["BYPASS"] = false,
        ["UBYPASS"] = false,
        ["ANTIAFK"] = true,
        ["LANGUAGE"] = "EN",
        ["THEME"] = "Default"
}
AFKDefaultConfig.UsersBypass = {
    ["STEAM_0:0:100152240"] = "Aiko Suzuki"
}

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
print("AntiAkf : Checking if config file are there")


function AnitAfkfirstloadconfiguration()
        if not file.Exists( "nnt-antiafk", "DATA" ) then file.CreateDir("nnt-antiafk") end
        if (file.Size( "nnt-antiafk/AntiAfkConfig.txt", "DATA" ) > 0) then
                local x = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
                AntiAFKConfig = util.JSONToTable(x)
                print("AntiAkf : Loading of config finished !")
        else
            print("AntiAfk: Config not found reloading ...\nAnd Creating File !")
            local x = util.TableToJSON(AFKDefaultConfig,true)
            file.Write("nnt-antiafk/AntiAfkConfig.txt",x)
            if (file.Size( "nnt-antiafk/AntiAfkwarntime.txt", "DATA" )  > 0) then
                local x = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
                AntiAFKConfig = util.JSONToTable(x)
                print("AntiAkf : Loading of config finished !")
            end
        end
end


local function FindPly(name)
	name = string.lower(name);
	for _,v in ipairs(player.GetHumans()) do if(string.find(string.lower(v:Name()),name,1,true) != nil)
			then return v;
		end
	end
	if v == nil then
	    name = string.lower(name);
	    for _,v in ipairs(player.GetBots()) do if(string.find(string.lower(v:Name()),name,1,true) != nil)
			    then return v;
		    end
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

function ReloadAntiAfkConfig()
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
    if #player.GetAll( ) > 0 then
        net.Start("AntiAfkSendHUDInfo")
            net.WriteString(AFK_LANGUAGE)
        net.Broadcast()
        net.Start("AntiAfkSendHUDInfo")
            net.WriteString(AFK_THEME)
        net.Broadcast()
    end
end

function AntiAFKChangeConfigData(settings,data,time)
    local x = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
    local AntiAFKConfig = util.JSONToTable(x)
    local TempConfigData = AntiAFKConfig
    if settings == "Settings" then
        if data == "ANTIAFK" then  TempConfigData.Settings.ANTIAFK = time end
        if data == "WARN" then  TempConfigData.Settings.WARN = time end
        if data == "KICK" then  TempConfigData.Settings.KICK = time end
        if data == "BYPASS" then  TempConfigData.Settings.BYPASS = time end
        if data == "UBYPASS" then TempConfigData.Settings.UBYPASS = time end
        if data == "LANGUAGE" then
            if table.HasValue(AntiAfkDisponibleLang, time) then
                TempConfigData.Settings.LANGUAGE = time
            end
        end
         if data == "THEME" then
            print("Check")
            if table.HasValue(AntiAfkDisponibleThemes, time) then
                TempConfigData.Settings.THEME = time
                print("Change")
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
                local count = table.Count(AntiAFKConfig.UsersBypass)
                local temptable = {[data] = player.GetBySteamID(data):Nick()}
                table.Merge(TempConfigData.UsersBypass, temptable)
                local newdata = util.TableToJSON(TempConfigData,true)
                file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
                ReloadAntiAfkConfig()
            else
                print("This is not a steamid ...")
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
            ReloadAntiAfkConfig()
        end
    end
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
print("RELOAD CONF")
ReloadAntiAfkConfig() -- reload the config to load all the config with the following format AFK_WARN_TIME, AFK_TIME, AFK_REPEAT, AFK_ENABLE, AFK_ADMINBYPASS, AFK_ADMINUBYPASS, AFK_ADMINBYPASS_GROUPS, AFK_ADMINBYPASS_USERS, AFK_LANGUAGE
print("FINISH RELOAD CONF")



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




util.AddNetworkString( "nnt-antiak-settings" )


util.AddNetworkString( "AntiAfkSendHUDInfo" ) -- BASIC HUD INFO LANGUAGE/WHAT TO OPEN

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




net.Receive("AFKHUD2", function(len, ply)
    net.Start("AFKHUDR")
        net.WriteString(math.Round(ply.NextAFK - CurTime()))
    net.Send(ply)
end)



net.Receive("nnt-antiak-settings", function(len,ply)
    if ply:IsSuperAdmin() then
        local data5 = net.ReadTable()
        local data4 = net.ReadString()

        if data4 == "SetSettings" then
            for k,v in pairs(data5) do
                print(k)
                AntiAFKChangeConfigData("Settings",k,v)
                net.Start("nnt-antiak-settings")
                    local temptable = {[k] = v}
                    net.WriteString("Settings")
                    net.WriteTable(temptable)
                net.Send(ply)
            end
        elseif data4 == "LoadData" then
            print("Starting to load data")
            net.Start("nnt-antiak-settings")
                local temptable = {
                    ["AFK_WARN_TIME"] = AFK_WARN_TIME,
                    ["AFK_TIME"] = AFK_TIME,
                    ["AFK_ADMINBYPASS"] = AFK_ADMINBYPASS,
                    ["AFK_ADMINUBYPASS"] = AFK_ADMINUBYPASS,
                    ["AFK_ENABLE"] = AFK_ENABLE
                }
                net.WriteString("LoadData")
                net.WriteTable(temptable)
            net.Send(ply)
        elseif data4 == "LoadOneData" then
            for k,v in pairs(data5) do
                local temptable = {}
            end
        end
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
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
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
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
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiAfkloaBypassUsers", function(len, ply) -- LOAD USER FROM THE WHITELIST
    if (ply:GetUserGroup() == "superadmin") then
        ply:ChatPrint("Received!")
        net.Start("AntiAfksenBypassUsers")
            net.WriteTable(AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
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
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
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
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiAfkloaBypassGroups", function(len, ply) -- LOAD GROUPS FROM THE GROUPS WHITELIST
    if (ply:GetUserGroup() == "superadmin") then
        ply:ChatPrint("Received!")
        net.Start("AntiAfksenBypassGroups")
            net.WriteTable(AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)






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

local function findply( name )
	name = string.lower(name);
	for _,v in ipairs(player.GetHumans()) do if(string.find(string.lower(v:Name()),name,1,true) != nil)
			then
			    return v;
		end
	end
end

concommand.Add( "afktime", function( ply, cmd, args )
        ply:ChatPrint("AntiAfk: Time before kick " .. AFK_TIME.. " secondes")
        ply:ChatPrint("AntiAfk: You should get a warning " .. AFK_WARN_TIME .. " secondes after being afk ")
        ply:ChatPrint("AntiAfk: Its been " ..  AFK_TIME - math.Round(ply.NextAFK - CurTime()) .. " secondes since u are afk !")
        ply:ChatPrint(" AntiAfk : "..  math.Round(ply.NextAFK - CurTime()) .. " Secondes left before the kick")
end)

concommand.Add( "setafktime", function( ply, cmd, args ) -- need to change this in net library ...
	 if (ply:GetUserGroup() == "superadmin") then
	     arguments = tonumber(args[1] , 10)
	     if (type(arguments) == "number") then
	        if (arguments > 300) or (arguments == 300) then
	             AntiAFKChangeConfigData("Settings","KICK",arguments)
	             AFK_TIME = AntiAFKConfig["Settings"]["KICK"]
	             ply:ChatPrint("AntiAfk: Time set to " .. AFK_TIME .. " secondes!")
                        net.Start("RefreshTime1")
                            net.WriteString(AFK_TIME)
                        net.Send(ply)
                        net.Start("RefreshTime2")
                            net.WriteString(AntiAFKConfig["Settings"]["WARN"])
                        net.Send(ply)
	         else
	             ply:ChatPrint("AntiAfk: Please Enter a valide time")
	         end
	     end
	 end
end)


concommand.Add("AntiAfkUpdate", function(ply)
    if (ply:GetUserGroup() == "superadmin") then
        local noewmotherfucker = file.Read("nnt-antiafk/AntiAfkConfig.txt","DATA")
        local AntiAFKConfig2 = util.JSONToTable(noewmotherfucker)
        table.Merge(AntiAFKConfig2, AFKDefaultConfig)
        local newdata = util.TableToJSON(AntiAFKConfig2,true)
        file.Write("nnt-antiafk/AntiAfkConfig.txt",newdata)
        ReloadAntiAfkConfig()
        ply:ChatPrint("AntiAfk : Config file as been update")
    end
end)

concommand.Add( "setafkplayer", function( ply, cmd, args )-- need to change this in net library ...
    if (ply:GetUserGroup() == "superadmin") then
        targetply = findply(args[1])
        arguments = tonumber(args[2] , 10)
        if (targetply:IsBot() == false) then
            tplyc = CurTime() + arguments
            if (tplyc < CurTime() + 120) then
                ply:ChatPrint("AntiAfk : Commands was not exectued because player have less then 120 secondes left before getting kick" )
                return
            else
                targetply.NextAFK = CurTime() + arguments
                ply:ChatPrint("AntiAfk : ".. targetply:Nick() .." is now afk in ".. math.Round(targetply.NextAFK - CurTime()) .. " secondes he will get kick" )
                targetply:ChatPrint("AntiAKf : " ..  AFK_TIME - math.Round(targetply.NextAFK - CurTime()) )
                local AikoAfkPlayerSet = hook.Call( "AikoAfkPlayerSet", GAMEMODE, ply , targetply , arguments )
            end
        end
    else
    ply:ChatPrint("AntiAfk : U are not a SuperAdmin !")
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
	ply.NextAFK = CurTime() + AFK_TIME
    net.Start("AntiAfkSendHUDInfo")
            net.WriteString(AFK_LANGUAGE)
    net.Send(ply)
end)

hook.Add("Think", "NNT-AFKPLAYERS", function()
	for _, ply in pairs (player.GetAll()) do
		if ( ply:IsConnected() and ply:IsFullyAuthenticated() ) then
            if !AFK_ENABLE then
                    ply.NextAFK = CurTime() + AFK_TIME
                return
            end
			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end
			local afktime = ply.NextAFK - AFK_TIME
			if (CurTime() >= afktime + AFK_WARN_TIME) and (!ply.Warning) and (!ply.SuperAbuse) then
                if AFK_ADMINBYPASS_USERS[ply:SteamID()] and (!ply.SuperAbuse) and (!ply.Warning) then
		            if AFK_ADMINUBYPASS == false then
                        if table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		                    if AFK_ADMINBYPASS == false then
			                    ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			                    ply:Fire( "alpha", 150, 0 )
                                net.Start("AntiAfkSendHUDInfo")
                                    net.WriteString("AntiafkMainHUD")
                                net.Send(ply)
                                AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
                                for k, v in pairs( player.GetAll() ) do
                                    v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 198, 0, 0 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOWAFK"]..[[" )]])
                                end
			                    local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			                    ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
			                    ply.Warning = true
                                return
	                        else
	                            ply:ChatPrint("AntiAFK : you are "..ply:GetUserGroup().." so u bypass the anti afk system !")
	                            ply.SuperAbuse = true
	                            for k, v in pairs( player.GetAll() ) do
                                    v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 198, 0, 0 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOWAFK"]..[[" )]])
                                end
                                return
	                        end
                        else
			                ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			                ply:Fire( "alpha", 150, 0 )
                            net.Start("AntiAfkSendHUDInfo")
                                net.WriteString("AntiafkMainHUD")
                            net.Send(ply)
                            AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
                            for k, v in pairs( player.GetAll() ) do
                                v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 198, 0, 0 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOWAFK"]..[[" )]])
                            end
			                local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			                ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
			                ply.Warning = true
                        end
	                else
	                    ply:ChatPrint("AntiAFK : you are are whitelisted so u bypass the anti afk system !")
	                    ply.SuperAbuse = true
	                    for k, v in pairs( player.GetAll() ) do
                            v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 198, 0, 0 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOWAFK"]..[[" )]])
                        end
	                end
			    elseif table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		            if AFK_ADMINBYPASS == false then
			            ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			            ply:Fire( "alpha", 150, 0 )
                        net.Start("AntiAfkSendHUDInfo")
                            net.WriteString("AntiafkMainHUD")
                        net.Send(ply)
                        AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
                        for k, v in pairs( player.GetAll() ) do
                            v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 198, 0, 0 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOWAFK"]..[[" )]])
                        end
			            local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			            ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
			            ply.Warning = true
	                else
	                    ply:ChatPrint("AntiAFK : you are "..ply:GetUserGroup().." so u bypass the anti afk system !")
	                    ply.SuperAbuse = true
	                    for k, v in pairs( player.GetAll() ) do
                            v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 198, 0, 0 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOWAFK"]..[[" )]])
                        end
	               end
			    else
			        ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			        ply:Fire( "alpha", 150, 0 )
				    print(ply:Name() .. "est maintenant AFK !")
		            ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
				    ply.Warning = true
				    net.Start("AntiAfkSendHUDInfo")
                        net.WriteString("AntiafkMainHUD")
                    net.Send(ply)
                    AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
				    for k, v in pairs( player.GetAll() ) do
                        v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 198, 0, 0 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOWAFK"]..[[" )]])
                    end
				    local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )

				end
			elseif (CurTime() >= afktime + AFK_TIME) and (ply.Warning) then
				ply.Warning = nil
				ply.NextAFK = nil
				ply.SuperAbuse = nil
				ply:Kick(AntiAfkTranslate[AFK_LANGUAGE]["KICKMESSAGES"])
				local AikoAfkKICK = hook.Call( "AikoAfkKICK", GAMEMODE, ply )
			end
		end
	end
end)

hook.Add("KeyPress", "NNT-AFK-PlayerMoved", function(ply, key)
    if ply:InVehicle() or !ply:InVehicle() and !(ply:GetAimVector() == AntiAFKPlayerEyesTrack[ply:SteamID()]) then
	    ply.NextAFK = CurTime() + AFK_TIME
	    if ply.Warning == true or ply.SuperAbuse == true then
		    ply.Warning = false
		    ply.SuperAbuse = false
		    print(ply:Name() .. " est plus AFK !")
            for k, v in pairs( player.GetAll() ) do
                v:SendLua([[chat.AddText( Color( 255, 255, 255 ), "[AntiAfk]: ",Color( 0, 198, 0 ),"]] ..ply:Nick()..[[",Color( 0, 0, 198 ), " ]] ..AntiAfkTranslate[AFK_LANGUAGE]["NOLONGERAFK"].. [[" )]])
            end
		    local AikoAfkTimeAfter = hook.Call( "AikoAfkTimeAfter", GAMEMODE, ply )
                if AFK_ADMINBYPASS_USERS[ply:SteamID()] and (!ply.SuperAbuse) and (!ply.Warning) then
		            if AFK_ADMINUBYPASS == false then
                        if table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		                    if AFK_ADMINBYPASS == false then
		                        net.Start("AFKHUD1")
                                    net.WriteString("true")
                                net.Send(ply)
                                ply:SetCollisionGroup(COLLISION_GROUP_NONE)
                                ply:SetRenderMode( RENDERMODE_NORMAL )
		                        ply:Fire( "alpha", 255, 0 )
                                return
	                        else
	                            return
	                        end
                        else
                           	net.Start("AFKHUD1")
                                net.WriteString("true")
                            net.Send(ply)
                            ply:SetCollisionGroup(COLLISION_GROUP_NONE)
                            ply:SetRenderMode( RENDERMODE_NORMAL )
		                    ply:Fire( "alpha", 255, 0 )
                            return
                        end
	                else
	                    return
	                end
                else
		            net.Start("AFKHUD1")
                        net.WriteString("true")
                    net.Send(ply)
                    ply:SetCollisionGroup(COLLISION_GROUP_NONE)
                    ply:SetRenderMode( RENDERMODE_NORMAL )
		            ply:Fire( "alpha", 255, 0 )
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

    -----------------------------------------------------------------
    -----------------------------------------------------------------
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
            ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
            local AikoAfkCommandsFail = hook.Call( "AikoAfkCommandsFail", GAMEMODE, ply , commands)
        end
        return"";




    elseif(string.StartWith( text , "/afkpanel" ) == true) then
        commands = "/afkpanel"
        if (ply:GetUserGroup() == "superadmin") then
            net.Start("AntiAfkSendHUDInfo")
                net.WriteString("AntiafkAdminPanel")
            net.Send(ply)
            local AikoAfkCommands = hook.Call( "AikoAfkCommands", GAMEMODE, ply , commands)
        else
            ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
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

