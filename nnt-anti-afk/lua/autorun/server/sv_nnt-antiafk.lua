AikoAntiAFK = AikoAntiAFK or {}

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
        ["ANTIAFK"] = true
}
AFKDefaultConfig.UsersBypass = {
    "STEAM_0:0:100152240"
}



-- Starting to load Script !
print("AntiAkf : Checking if config file are there")




function AnitAfkfirstloadconfiguration()
        if not file.Exists( "aikoaddons", "DATA" ) then file.CreateDir("aikoaddons") end
        if (file.Size( "aikoaddons/AntiAfkConfig.txt", "DATA" ) > 0) then
                local x = file.Read("aikoaddons/AntiAfkConfig.txt","DATA")
                AntiAFKConfig = util.JSONToTable(x)
                print("AntiAkf : Loading of config finished !")
        else
            print("AntiAfk: Config not found reloading ...\nAnd Creating File !")
            local x = util.TableToJSON(AFKDefaultConfig,true)
            file.Write("aikoaddons/AntiAfkConfig.txt",x)
            if (file.Size( "aikoaddons/AntiAfkwarntime.txt", "DATA" )  > 0) then
                local x = file.Read("aikoaddons/AntiAfkConfig.txt","DATA")
                AntiAFKConfig = util.JSONToTable(x)
                print("AntiAkf : Loading of config finished !")
            end
        end
end

local function UPDATEConfigFile()
    local noewmotherfucker = file.Read("aikoaddons/AntiAfkConfig.txt","DATA")
    local AntiAFKConfig2 = util.JSONToTable(noewmotherfucker)
    table.Merge(AntiAFKConfig2, AFKDefaultConfig)
    local newdata = util.TableToJSON(AntiAFKConfig2,true)
    file.Write("aikoaddons/AntiAfkConfig.txt",newdata)
    ReloadAntiAfkConfig()
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
function ReloadAntiAfkConfig()
    local noewmotherfucker = file.Read("aikoaddons/AntiAfkConfig.txt","DATA")
    AntiAFKConfig = util.JSONToTable(noewmotherfucker)
    AFK_WARN_TIME = AntiAFKConfig.Settings.WARN
    AFK_TIME = AntiAFKConfig.Settings.KICK
    AFK_REPEAT = AFK_TIME - AFK_WARN_TIME
    AFK_ENABLE =  AntiAFKConfig.Settings.ANTIAFK
    AFK_ADMINBYPASS = AntiAFKConfig.Settings.BYPASS
    AFK_ADMINUBYPASS = AntiAFKConfig.Settings.UBYPASS
    AFK_ADMINBYPASS_GROUPS = AntiAFKConfig.BypassGroups
    AFK_ADMINBYPASS_USERS = AntiAFKConfig.UsersBypass
end

function AntiAFKChangeConfigData(settings,data,time)
    local x = file.Read("aikoaddons/AntiAfkConfig.txt","DATA")
    local AntiAFKConfig = util.JSONToTable(x)
    local TempConfigData = AntiAFKConfig
    if settings == "Settings" then
        if data == "ANTIAFK" then  TempConfigData.Settings.ANTIAFK = time end
        if data == "WARN" then  TempConfigData.Settings.WARN = time end
        if data == "KICK" then  TempConfigData.Settings.KICK = time end
        if data == "BYPASS" then  TempConfigData.Settings.BYPASS = time end
        if data == "UBYPASS" then TempConfigData.Settings.UBYPASS = time end
        local newdata = util.TableToJSON(TempConfigData,true)
        file.Write("aikoaddons/AntiAfkConfig.txt",newdata)
        ReloadAntiAfkConfig()
    elseif settings == "BypassGroups" then
        if time == "DEL" then
            table.RemoveByValue(TempConfigData.BypassGroups,data)
            local newdata = util.TableToJSON(TempConfigData,true)
            file.Write("aikoaddons/AntiAfkConfig.txt",newdata)
            ReloadAntiAfkConfig()
        elseif time == "ADD" then
            local count = table.Count(AntiAFKConfig.BypassGroups)
            table.insert(TempConfigData.BypassGroups, count + 1 , data)
            local newdata = util.TableToJSON(TempConfigData,true)
            file.Write("aikoaddons/AntiAfkConfig.txt",newdata)
            ReloadAntiAfkConfig()
        end
    elseif   settings == "UsersBypass" then
        if time == "ADD" then
            if string.StartWith(data, "STEAM_") then
                local count = table.Count(AntiAFKConfig.UsersBypass)
                table.insert(TempConfigData.UsersBypass, count + 1 , data)
                local newdata = util.TableToJSON(TempConfigData,true)
                file.Write("aikoaddons/AntiAfkConfig.txt",newdata)
                ReloadAntiAfkConfig()
            else
                local count = table.Count(AntiAFKConfig.UsersBypass)
                table.insert(TempConfigData.UsersBypass, count + 1 , FindPly(data):SteamID())
                local newdata = util.TableToJSON(TempConfigData,true)
                file.Write("aikoaddons/AntiAfkConfig.txt",newdata)
                ReloadAntiAfkConfig()
            end

        elseif time == "DEL" then
            table.RemoveByValue(TempConfigData.UsersBypass,data)
            local newdata = util.TableToJSON(TempConfigData,true)
            file.Write("aikoaddons/AntiAfkConfig.txt",newdata)
            ReloadAntiAfkConfig()
        end
    end
end




Timer = {}

AnitAfkfirstloadconfiguration()
print("RELOAD CONF")
ReloadAntiAfkConfig()
UPDATEConfigFile()
print("FINISH RELOAD CONF")

util.AddNetworkString( "CurrentTime" )
util.AddNetworkString( "ClientMessages" )

util.AddNetworkString( "Refresh" )

util.AddNetworkString( "ChangeWarnTime" )
util.AddNetworkString( "ChangeSPBypass" )
util.AddNetworkString( "ChangeUBypass" )
util.AddNetworkString( "ChangeEnableAntiAFK" )

util.AddNetworkString( "RefreshTime1" )
util.AddNetworkString( "RefreshTime2" )
util.AddNetworkString( "RefreshTime3" )
util.AddNetworkString( "RefreshTime4" )
util.AddNetworkString( "RefreshTime5" )


util.AddNetworkString( "AntiAfkSendHUDInfo" )


util.AddNetworkString( "AntiAddBypassGroups" )
util.AddNetworkString( "AntiAfksenBypassGroups" )
util.AddNetworkString( "AntiAfkloaBypassGroups" )
util.AddNetworkString( "AntiRemBypassGroups" )


util.AddNetworkString( "AntiAddBypassUsers" )
util.AddNetworkString( "AntiAfksenBypassUsers" )
util.AddNetworkString( "AntiAfkloaBypassUsers" )
util.AddNetworkString( "AntiRemBypassUsers" )






net.Receive("Refresh", function(len, ply)
        if (ply:GetUserGroup() == "superadmin") then
            net.Start("RefreshTime2")
                net.WriteString(AFK_WARN_TIME)
            net.Send(ply)
            net.Start("RefreshTime1")
                net.WriteString(AFK_TIME)
            net.Send(ply)
            net.Start("RefreshTime3")
                net.WriteString(tostring(AFK_ADMINBYPASS))
            net.Send(ply)
            net.Start("RefreshTime4")
                net.WriteString(tostring(AFK_ADMINUBYPASS))
            net.Send(ply)
            net.Start("RefreshTime5")
                net.WriteString(tostring(AFK_ENABLE))
            net.Send(ply)
        else
            ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
        end
end)

concommand.Add( "setafktime", function( ply, cmd, args )
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




concommand.Add( "setplayerlang", function( ply, cmd, args )
    if (ply:GetUserGroup() == "superadmin") then
        targetply = findply(args[1])
        arguments = tostring(args[2])
        if (targetply:IsBot() == false) then
            targetply:SendLua("RunConsoleCommand( 'gmod_language', '".. arguments .. "' )")
            timer.Simple( 2, function() targetply:SendLua("RunConsoleCommand( 'spawnmenu_reload' )") end)
            
            ply:ChatPrint("AntiAFK: U have set the language of " .. targetply:Nick() .. " to " .. arguments )
        end
    else
    ply:ChatPrint("AntiAfk : U are not a SuperAdmin !")
    end
    
end)

net.Receive("ChangeWarnTime", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = tonumber(net.ReadString() , 10)
        AntiAFKChangeConfigData("Settings","WARN",SomeShittyTest)
        net.Start("RefreshTime2")
            net.WriteString(AFK_WARN_TIME)
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)


net.Receive("AntiAddBypassUsers", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        if string.StartWith(SomeShittyTest , " " ) then return end
		if SomeShittyTest == "" then return end
        if table.HasValue(AFK_ADMINBYPASS_USERS,SomeShittyTest ) then return end
        AntiAFKChangeConfigData("UsersBypass",SomeShittyTest,"ADD")
        net.Start("AntiAfksenBypassUsers")
            net.WriteTable(AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)

net.Receive("AntiRemBypassUsers", function(len, ply)
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

net.Receive("AntiAfkloaBypassUsers", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        ply:ChatPrint("Received!")
        net.Start("AntiAfksenBypassUsers")
            net.WriteTable(AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)




net.Receive("AntiAddBypassGroups", function(len, ply)
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

net.Receive("AntiRemBypassGroups", function(len, ply)
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

net.Receive("AntiAfkloaBypassGroups", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        ply:ChatPrint("Received!")
        net.Start("AntiAfksenBypassGroups")
            net.WriteTable(AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)



net.Receive("ChangeSPBypass", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest1 = tobool( net.ReadString() )
        AntiAFKChangeConfigData("Settings","BYPASS", SomeShittyTest1)
        net.Start("RefreshTime3")
            net.WriteString(tostring(AFK_ADMINBYPASS))
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)

net.Receive("ChangeUBypass", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest1 = tobool( net.ReadString() )
        AntiAFKChangeConfigData("Settings","UBYPASS", SomeShittyTest1)
        net.Start("RefreshTime4")
            net.WriteString(tostring(AFK_ADMINUBYPASS))
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)

net.Receive("ChangeEnableAntiAFK", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest1 = tobool( net.ReadString() )
        AntiAFKChangeConfigData("Settings","ANTIAFK", SomeShittyTest1)
        net.Start("RefreshTime5")
            net.WriteString(tostring(AFK_ENABLE))
        net.Send(ply)
    else
        ply:ChatPrint("AnitAfk : You don't have the permission to accces the panel !")
    end
end)


concommand.Add( "afktime", function( ply, cmd, args )
        ply:ChatPrint("AntiAfk: Time before kick " .. AFK_TIME.. " secondes")
        ply:ChatPrint("AntiAfk: You should get a warning " .. AFK_WARN_TIME .. " secondes after being afk ")
        ply:ChatPrint("AntiAfk: Its been " ..  AFK_TIME - math.Round(ply.NextAFK - CurTime()) .. " secondes since u are afk !") 
        ply:ChatPrint(" AntiAfk : "..  math.Round(ply.NextAFK - CurTime()) .. " Secondes left before the kick")
end)

local t
function findply( name )
	name = string.lower(name);
	for _,v in ipairs(player.GetHumans()) do if(string.find(string.lower(v:Name()),name,1,true) != nil)
			then
			    return v;
		end
	end
end

concommand.Add( "setafkplayer", function( ply, cmd, args )
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

hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
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
                if table.HasValue(AFK_ADMINBYPASS_USERS, ply:SteamID() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		            if AFK_ADMINUBYPASS == false then
                        if table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		                    if AFK_ADMINBYPASS == false then
			                    ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			                    ply:Fire( "alpha", 150, 0 )
                                net.Start("AntiAfkSendHUDInfo")
                                    net.WriteString("AntiafkMainHUD")
                                net.Send(ply)
                                for k, v in pairs( player.GetAll() ) do
                                    v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 198, 0, 0 ), ' is now AFK ' )")
                                end
			                    local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			                    ply:SetCollisionGroup(11)
			                    ply.Warning = true
                                return
	                        else
	                            ply:ChatPrint("AntiAFK : you are "..ply:GetUserGroup().." so u bypass the anti afk system !")
	                            ply.SuperAbuse = true
	                            for k, v in pairs( player.GetAll() ) do
                                    v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 198, 0, 0 ), ' is now AFK ' )")
                                end
                                return
	                        end
                        else
			                ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			                ply:Fire( "alpha", 150, 0 )
                            net.Start("AntiAfkSendHUDInfo")
                                net.WriteString("AntiafkMainHUD")
                            net.Send(ply)
                            for k, v in pairs( player.GetAll() ) do
                                v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 198, 0, 0 ), ' is now AFK ' )")
                            end
			                local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			                ply:SetCollisionGroup(11)
			                ply.Warning = true
                        end
	                else
	                    ply:ChatPrint("AntiAFK : you are are whitelisted so u bypass the anti afk system !")
	                    ply.SuperAbuse = true
	                    for k, v in pairs( player.GetAll() ) do
                            v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 198, 0, 0 ), ' is now AFK ' )")
                        end
	                end
			    elseif table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		            if AFK_ADMINBYPASS == false then
			            ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			            ply:Fire( "alpha", 150, 0 )
                        net.Start("AntiAfkSendHUDInfo")
                            net.WriteString("AntiafkMainHUD")
                        net.Send(ply)
                        for k, v in pairs( player.GetAll() ) do
                            v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 198, 0, 0 ), ' is now AFK ' )")
                        end
			            local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
			            ply:SetCollisionGroup(11)
			            ply.Warning = true
	                else
	                    ply:ChatPrint("AntiAFK : you are "..ply:GetUserGroup().." so u bypass the anti afk system !")
	                    ply.SuperAbuse = true
	                    for k, v in pairs( player.GetAll() ) do
                            v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 198, 0, 0 ), ' is now AFK ' )")
                        end
	               end
			    else
			        ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			        ply:Fire( "alpha", 150, 0 )
				    print(ply:Name() .. "est maintenant AFK !")
		            ply:SetCollisionGroup(11)
				    ply.Warning = true
				    net.Start("AntiAfkSendHUDInfo")
                        net.WriteString("AntiafkMainHUD")
                    net.Send(ply)
				    for k, v in pairs( player.GetAll() ) do
                        v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 198, 0, 0 ), ' is now AFK ' )")
                    end
				    local AikoAfkTimeBefore = hook.Call( "AikoAfkTimeBefore", GAMEMODE, ply )
				    
				end
			elseif (CurTime() >= afktime + AFK_TIME) and (ply.Warning) then
				ply.Warning = nil
				ply.NextAFK = nil
				ply.SuperAbuse = nil
				print(ply:Name() .. " a été kick pour AFK !")
				ply:Kick("\n Vous avez été kick pour AFK !")
				local AikoAfkKICK = hook.Call( "AikoAfkKICK", GAMEMODE, ply )
			end
		end
	end
end)

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



net.Receive("CurrentTime", function(len, ply)
            net.Start("ClientMessages")
            Sometime = AFK_WARN_TIME
            net.WriteString(Sometime)
        net.Broadcast()
end)

util.AddNetworkString( "AFKHUD1" )
util.AddNetworkString( "AFKHUD2" )
util.AddNetworkString( "AFKHUDR" )

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
    if ply:GetVelocity():Length() > 0 or ply:InVehicle() then
	    ply.NextAFK = CurTime() + AFK_TIME
	    if ply.Warning == true or ply.SuperAbuse == true then
		    ply.Warning = false
		    ply.SuperAbuse = false
		    print(ply:Name() .. " est plus AFK !")
            for k, v in pairs( player.GetAll() ) do
                v:SendLua("chat.AddText( Color( 255, 255, 255 ), '[AntiAfk]: ',Color( 0, 198, 0 ),'" ..ply:Nick().."',Color( 0, 0, 198 ), ' is no longer AFK ' )")
            end
		    local AikoAfkTimeAfter = hook.Call( "AikoAfkTimeAfter", GAMEMODE, ply )
                if table.HasValue(AFK_ADMINBYPASS_USERS, ply:SteamID() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		            if AFK_ADMINUBYPASS == false then
                        if table.HasValue(AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup() ) and (!ply.SuperAbuse) and (!ply.Warning) then
		                    if AFK_ADMINBYPASS == false then
		                        net.Start("AFKHUD1")
                                    net.WriteString("true")
                                net.Send(ply)
                                ply:SetCollisionGroup(0)
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
                            ply:SetCollisionGroup(0)
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
                    ply:SetCollisionGroup(0)
                    ply:SetRenderMode( RENDERMODE_NORMAL )
		            ply:Fire( "alpha", 255, 0 )
                end
	    end
	end
end)

hook.Add("PlayerDisconnected", "AntiAfkunloadply", function(ply)
    
end)

concommand.Add( "Something", function( ply, cmd, args )
    ply:SendLua('surface.PlaySound("buttons/button18.wav")')
	ply:SendLua('surface.PlaySound("buttons/button18.wav")')
	ply:SendLua('surface.PlaySound("buttons/button18.wav")')
end )





net.Receive("AFKHUD2", function(len, ply)
    net.Start("AFKHUDR")
        net.WriteString(math.Round(ply.NextAFK - CurTime()))
    net.Send(ply)
end)