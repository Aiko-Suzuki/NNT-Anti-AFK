NNT = NNT or {}
include("nnt-antiafk/sv_update.lua")
include("nnt-antiafk/sh_nnt-antiafk.lua")
util.AddNetworkString("nnt-antiak-settings")
util.AddNetworkString("AntiAfkSendHUDInfo") -- BASIC HUD INFO LANGUAGE/WHAT TO OPEN
util.AddNetworkString("BroadcastAFKPLAYER")
util.AddNetworkString("AntiAddBypassGroups") -- BYPASS USER NET
util.AddNetworkString("AntiAfksenBypassGroups")
util.AddNetworkString("AntiAfkloaBypassGroups")
util.AddNetworkString("AntiRemBypassGroups")
util.AddNetworkString("AntiAddBypassUsers") -- BYPASSGROUPS NET
util.AddNetworkString("AntiAfksenBypassUsers")
util.AddNetworkString("AntiAfkloaBypassUsers")
util.AddNetworkString("AntiRemBypassUsers")
util.AddNetworkString("AFKHUD1") -- HUD REQUEST AND RESPOND
util.AddNetworkString("AFKHUD2")
util.AddNetworkString("AFKHUDR")

-- $$$$$$$$\                              $$\     $$\                     
-- $$  _____|                             $$ |    \__|                    
-- $$ |   $$\   $$\ $$$$$$$\   $$$$$$$\ $$$$$$\   $$\  $$$$$$\  $$$$$$$\  
-- $$$$$\ $$ |  $$ |$$  __$$\ $$  _____|\_$$  _|  $$ |$$  __$$\ $$  __$$\ 
-- $$  __|$$ |  $$ |$$ |  $$ |$$ /        $$ |    $$ |$$ /  $$ |$$ |  $$ |
-- $$ |   $$ |  $$ |$$ |  $$ |$$ |        $$ |$$\ $$ |$$ |  $$ |$$ |  $$ |
-- $$ |   \$$$$$$  |$$ |  $$ |\$$$$$$$\   \$$$$  |$$ |\$$$$$$  |$$ |  $$ |
-- \__|    \______/ \__|  \__| \_______|   \____/ \__| \______/ \__|  \__|
local function getMinutes(hours, minutes)
    return (hours * 60) + minutes
end

local function IsTimeBetween(StartH, StartM, StopH, StopM, TestH, TestM)
    if (StopH < StartH) then
        local StopHOrg = StopH
        StopH = StopH + 24

        if (TestH <= StopHOrg) then
            TestH = TestH + 24
        end
    end

    local StartTVal = getMinutes(StartH, StartM)
    local StopTVal = getMinutes(StopH, StopM)
    local curTVal = getMinutes(TestH, TestM)

    return curTVal >= StartTVal and curTVal <= StopTVal
end

local function IsNowBetween(StartH, StartM, StopH, StopM)
    local time = os.date("*t")

    return IsTimeBetween(StartH, StartM, StopH, StopM, time.hour, time.min)
end

local function IsKeyExist(tb, key)
    for k, _ in pairs(tb) do
        if k == key then return true end
    end
end

-- $$\      $$\            $$\               
-- $$$\    $$$ |           $$ |              
-- $$$$\  $$$$ | $$$$$$\ $$$$$$\    $$$$$$\  
-- $$\$$\$$ $$ |$$  __$$\\_$$  _|   \____$$\ 
-- $$ \$$$  $$ |$$$$$$$$ | $$ |     $$$$$$$ |
-- $$ |\$  /$$ |$$   ____| $$ |$$\ $$  __$$ |
-- $$ | \_/ $$ |\$$$$$$$\  \$$$$  |\$$$$$$$ |
-- \__|     \__| \_______|  \____/  \_______|
NNT.ANTI_AFK = {
    AntiAFKPlayerEyesTrack = {},
    Config = {},
    DefaultConfig = {
        Version = "3.2.1",
        UsersBypass = {},
        BypassGroups = {"superadmin"},
        TimeSettings = {
            ["StartHours"] = 21,
            ["StartMinutes"] = 0,
            ["StopHours"] = 8,
            ["StopMinutes"] = 0
        },
        Settings = {
            ["WARN"] = 300,
            ["KICK"] = 600,
            ["BYPASS"] = false,
            ["UBYPASS"] = false,
            ["ANTIAFK"] = true,
            ["THEME"] = "Default",
            ["GHOST"] = false,
            ["DARKPMONEY"] = false,
            ["GODMODE"] = false,
            ["JOBENABLE"] = false,
            ["JOBNAME"] = "Spectator",
            ["ENABLETIME"] = false,
            ["JOBREVERT"] = false
        }
    },
    AntiAFKInit = function(self)
        if not file.Exists("nnt-antiafk", "DATA") then
            file.CreateDir("nnt-antiafk")
        end

        if (file.Size("nnt-antiafk/AntiAFKConfig.txt", "DATA") > 0) then
            print("[ANTI-AFK] : Loading of Config !")
            self.Config = util.JSONToTable(file.Read("nnt-antiafk/AntiAFKConfig.txt", "DATA"))
            print("[ANTI-AFK] : Loading of Config finished !")
            print("[ANTI-AFK] : Looking for update !")
            NNTAntiAFKCheckAndUpdate()
            print("[ANTI-AFK] : Reloading Config for update !")
            self:ReloadConfig()
            print("[ANTI-AFK] : Reloading of Config finished !")
        else
            print("[ANTI-AFK] : Config not found reloading ...\nAnd Creating File !")
            file.Write("nnt-antiafk/AntiAFKConfig.txt", util.TableToJSON(self.DefaultConfig, true))

            if (file.Size("nnt-antiafk/AntiAFKConfig.txt", "DATA") > 0) then
                print("[ANTI-AFK] : Loading of Config !")
                self.Config = util.JSONToTable(file.Read("nnt-antiafk/AntiAFKConfig.txt", "DATA"))
                print("[ANTI-AFK] : Loading of Config finished !")
                print("[ANTI-AFK] : Looking for update !")
                NNTAntiAFKCheckAndUpdate()
                print("[ANTI-AFK] : Reloading Config for update !")
                self:ReloadConfig()
                print("[ANTI-AFK] : Reloading of Config finished !")
            end
        end
    end,
    ReloadConfig = function(self, ply)
        local noewmotherfucker = file.Read("nnt-antiafk/AntiAFKConfig.txt", "DATA")
        self.Config = util.JSONToTable(noewmotherfucker)
        self.AFK_WARN_TIME = self.Config.Settings.WARN
        self.AFK_TIME = self.Config.Settings.KICK
        self.AFK_REPEAT = self.AFK_TIME - self.AFK_WARN_TIME
        self.AFK_ENABLE = self.Config.Settings.ANTIAFK
        self.AFK_ADMINBYPASS = self.Config.Settings.BYPASS
        self.AFK_ADMINUBYPASS = self.Config.Settings.UBYPASS
        self.AFK_ADMINBYPASS_GROUPS = self.Config.BypassGroups
        self.AFK_ADMINBYPASS_USERS = self.Config.UsersBypass
        self.AFK_THEME = self.Config.Settings.THEME
        self.AFK_VERSION = self.Config.Version
        self.AFK_GHOST = self.Config.Settings.GHOST
        self.AFK_DARKRPMONEY = self.Config.Settings.DARKPMONEY
        self.AFK_GODMODE = self.Config.Settings.GODMODE
        self.AFK_JOBENABLE = self.Config.Settings.JOBENABLE
        self.AFK_JOBNAME = self.Config.Settings.JOBNAME
        self.AFK_JOBREVERT = self.Config.Settings.JOBREVERT
        self.AFK_ENABLETIME = self.Config.Settings.ENABLETIME
        self.AFK_StartTimeHours = math.Round(self.Config.TimeSettings.StartHours)
        self.AFK_StartTimeMinutes = math.Round(self.Config.TimeSettings.StartMinutes)
        self.AFK_StopTimeHours = math.Round(self.Config.TimeSettings.StopHours)
        self.AFK_StopTimeMinutes = math.Round(self.Config.TimeSettings.StopMinutes)

        if not ply == nil and ply:IsValid() then
            net.Start("nnt-antiak-settings")

            local temptable = {
                ["WARN"] = self.AFK_WARN_TIME,
                ["KICK"] = self.AFK_TIME,
                ["BYPASS"] = self.AFK_ADMINBYPASS,
                ["UBYPASS"] = self.AFK_ADMINUBYPASS,
                ["ANTIAFK"] = self.AFK_ENABLE,
                ["GHOST"] = self.AFK_GHOST,
                ["DARKPMONEY"] = self.AFK_DARKRPMONEY,
                ["THEME"] = self.AFK_THEME,
                ["GODMODE"] = self.AFK_GODMODE,
                ["JOBENABLE"] = self.AFK_JOBENABLE,
                ["JOBNAME"] = self.AFK_JOBNAME,
                ["ENABLETIME"] = self.AFK_ENABLETIME,
                ["AFK_StartTimeHours"] = self.AFK_StartTimeHours,
                ["AFK_StartTimeMinutes"] = self.AFK_StartTimeMinutes,
                ["AFK_StopTimeHours"] = self.AFK_StopTimeHours,
                ["AFK_StopTimeMinutes"] = self.AFK_StopTimeMinutes,
                ["JOBREVERT"] = self.AFK_JOBREVERT
            }

            net.WriteString("LoadData")
            net.WriteTable(temptable)
            net.Send(ply)
        end

        if #player.GetAll() > 0 then
            net.Start("AntiAfkSendHUDInfo")
            net.WriteString(self.AFK_THEME)
            net.Broadcast()
        end
    end,
    -- settings = What type of settings to change (Settings,BypassGroups,UsersBypass) -- opt = What option you what to change with the "settings" ,  -- option avaible for Settings (ANTIAFK, WARN, KICK, BYPASS, UBYPASS, GHOST, DARKPMONEY, GODMODE, JOBENABLE, JOBNAME, ENABLETIME, StartHours , StartMinutes, StopHours, StopMinutes, JOBREVERT, LANGUAGE, THEME) -- option avaible for BypassGroups (DEL, ADD) -- option avaible for UsersBypass (DEL, ADD) -- data = data for the change  -- ply = player to use (Only used for whitelist )
    SetConfig = function(self, settings, opt, data, ply)
        local tmp = self.Config

        if settings == "Settings" then
            if opt == "THEME" and NNTAntiafkThemes[data] then
                tmp.Settings.THEME = data
                print("[ANTI-AFK] : Themes has been changed to " .. data)
            elseif IsKeyExist(tmp.Settings, opt) then
                tmp.Settings[opt] = data
            end

            local newdata = util.TableToJSON(tmp, true)
            file.Write("nnt-antiafk/AntiAFKConfig.txt", newdata)
            self:ReloadConfig()
        elseif settings == "BypassGroups" then
            if opt == "DEL" then
                table.RemoveByValue(tmp.BypassGroups, data)
                local newdata = util.TableToJSON(tmp, true)
                file.Write("nnt-antiafk/AntiAFKConfig.txt", newdata)
                self:ReloadConfig()
            elseif opt == "ADD" then
                local count = table.Count(self.Config.BypassGroups)
                table.insert(tmp.BypassGroups, count + 1, data)
                local newdata = util.TableToJSON(tmp, true)
                file.Write("nnt-antiafk/AntiAFKConfig.txt", newdata)
                self:ReloadConfig()
            end
        elseif settings == "UsersBypass" then
            if opt == "ADD" then
                if string.StartWith(data, "STEAM_") then
                    if opt == "STEAM_0:0" then return end

                    local temptable = {
                        [data] = player.GetBySteamID(data):Nick()
                    }

                    table.Merge(tmp.UsersBypass, temptable)
                    local newdata = util.TableToJSON(tmp, true)
                    file.Write("nnt-antiafk/AntiAFKConfig.txt", newdata)
                    print("[ANTI-AFK] : " .. player.GetBySteamID(data):Nick() .. " Has been added to the whitelist !")
                    self:ReloadConfig()
                end
            elseif opt == "DEL" then
                print(tmp.UsersBypass[data])
                local TempTable = {}

                for k, v in pairs(tmp.UsersBypass) do
                    if not (k == data) then
                        TempTable[k] = v
                    end
                end

                table.Empty(tmp.UsersBypass)
                table.Merge(tmp.UsersBypass, TempTable)
                local newdata = util.TableToJSON(tmp, true)
                file.Write("nnt-antiafk/AntiAFKConfig.txt", newdata)
                print("[ANTI-AFK] : " .. player.GetBySteamID(data):Nick() .. " Has been remove from the whitelist !")

                if not ply == nil and ply:IsValid() then
                    self:ReloadConfig(ply)
                else
                    self:ReloadConfig()
                end
            end
        end
    end
}

NNT.ANTI_AFK.__index = NNT.ANTI_AFK
NNT.ANTI_AFK:AntiAFKInit()
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
            ["PlayerName"] = self:Nick(),
            ["AFKSTATE"] = self.HaveWarning
        }

        if self.Ghost then
            self:SetCollisionGroup(COLLISION_GROUP_NONE)
            self:SetRenderMode(RENDERMODE_NORMAL)
            self:Fire("alpha", 255, 0)
            self.Ghost = false
        end

        if self.GodModeAFK then
            self:GodDisable()
            self.GodModeAFK = false
        end

        net.Start("BroadcastAFKPLAYER")
        net.WriteTable(temporytable)
        net.Broadcast()

        if NNT.ANTI_AFK.AFK_JOBENABLE and NNT.ANTI_AFK.AFK_JOBREVERT then
            if self.PreviousTeam == nil then return end

            if (self.PreviousTeam ~= self:Team()) then
                if gmod.GetGamemode().Name == "DarkRP" then
                    self:changeTeam(self.PreviousTeam)
                else
                    self:SetTeam(self.PreviousTeam)
                end
            end
        end
    elseif bool == true then
        if NNT.ANTI_AFK.AFK_JOBENABLE then
            for k in pairs(team.GetAllTeams()) do
                if team.GetName(k) == NNT.ANTI_AFK.AFK_JOBNAME then
                    if NNT.ANTI_AFK.AFK_JOBREVERT then
                        self.PreviousTeam = self:Team()
                    end

                    if gmod.GetGamemode().Name == "DarkRP" and (self:Team() ~= k) then
                        self:changeTeam(k)
                    elseif (self:Team() ~= k) then
                        self:SetTeam(k)
                    end
                end
            end
        end

        self.HaveWarning = true

        local temporytable = {
            ["PlayerName"] = self:Nick(),
            ["AFKSTATE"] = self.HaveWarning
        }

        if NNT.ANTI_AFK.AFK_GHOST then
            self:SetRenderMode(RENDERMODE_TRANSALPHA)
            self:Fire("alpha", 150, 0)
            self:SetCollisionGroup(COLLISION_GROUP_WORLD)
            self.Ghost = true
        end

        if NNT.ANTI_AFK.AFK_GODMODE then
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
        self:SetNWEntity("NextAFK", CurTime() + time)
    end
end

function PlyMeta:GetNextAFK()
    return self.NextAFK
end

function PlyMeta:SPSetAFK(bool)
    if bool == false then
        self.SuperAbuse = false

        local temporytable = {
            ["PlayerName"] = self:Nick(),
            ["AFKSTATE"] = self.SuperAbuse
        }

        net.Start("BroadcastAFKPLAYER")
        net.WriteTable(temporytable)
        net.Broadcast()
    elseif bool == true then
        self.SuperAbuse = true

        local temporytable = {
            ["PlayerName"] = self:Nick(),
            ["AFKSTATE"] = self.SuperAbuse
        }

        net.Start("BroadcastAFKPLAYER")
        net.WriteTable(temporytable)
        net.Broadcast()
    elseif bool == nil then
        self.SuperAbuse = nil
    end
end

-- $$\   $$\            $$\                                       $$\       $$\                     
-- $$$\  $$ |           $$ |                                      $$ |      \__|                    
-- $$$$\ $$ | $$$$$$\ $$$$$$\   $$\  $$\  $$\  $$$$$$\   $$$$$$\  $$ |  $$\ $$\ $$$$$$$\   $$$$$$\  
-- $$ $$\$$ |$$  __$$\\_$$  _|  $$ | $$ | $$ |$$  __$$\ $$  __$$\ $$ | $$  |$$ |$$  __$$\ $$  __$$\ 
-- $$ \$$$$ |$$$$$$$$ | $$ |    $$ | $$ | $$ |$$ /  $$ |$$ |  \__|$$$$$$  / $$ |$$ |  $$ |$$ /  $$ |
-- $$ |\$$$ |$$   ____| $$ |$$\ $$ | $$ | $$ |$$ |  $$ |$$ |      $$  _$$<  $$ |$$ |  $$ |$$ |  $$ |
-- $$ | \$$ |\$$$$$$$\  \$$$$  |\$$$$$\$$$$  |\$$$$$$  |$$ |      $$ | \$$\ $$ |$$ |  $$ |\$$$$$$$ |
-- \__|  \__| \_______|  \____/  \_____\____/  \______/ \__|      \__|  \__|\__|\__|  \__| \____$$ |
--                                                                                        $$\   $$ |
--                                                                                        \$$$$$$  |
--                                                                                         \______/ 
net.Receive("AFKHUD2", function(len, ply)
    net.Start("AFKHUDR")
    net.WriteString(math.Round(ply:GetNextAFK() - CurTime()))
    net.Send(ply)
end)

net.Receive("nnt-antiak-settings", function(len, ply)
    if ply:IsSuperAdmin() then
        local data5 = net.ReadTable()
        local data4 = net.ReadString()

        if data4 == "SetSettings" then
            for k, v in pairs(data5) do
                NNT.ANTI_AFK:SetConfig("Settings", k, v)
                net.Start("nnt-antiak-settings")

                local temptable = {
                    [k] = v
                }

                net.WriteString("Settings")
                net.WriteTable(temptable)
                net.Send(ply)
            end
        elseif data4 == "LoadData" then
            print("[ANTI-AFK] : Starting to load data")
            net.Start("nnt-antiak-settings")

            local temptable = {
                ["WARN"] = NNT.ANTI_AFK.AFK_WARN_TIME,
                ["KICK"] = NNT.ANTI_AFK.AFK_TIME,
                ["BYPASS"] = NNT.ANTI_AFK.AFK_ADMINBYPASS,
                ["UBYPASS"] = NNT.ANTI_AFK.AFK_ADMINUBYPASS,
                ["ANTIAFK"] = NNT.ANTI_AFK.AFK_ENABLE,
                ["GHOST"] = NNT.ANTI_AFK.AFK_GHOST,
                ["DARKPMONEY"] = NNT.ANTI_AFK.AFK_DARKRPMONEY,
                ["THEME"] = NNT.ANTI_AFK.AFK_THEME,
                ["GODMODE"] = NNT.ANTI_AFK.AFK_GODMODE,
                ["JOBENABLE"] = NNT.ANTI_AFK.AFK_JOBENABLE,
                ["JOBNAME"] = NNT.ANTI_AFK.AFK_JOBNAME,
                ["ENABLETIME"] = NNT.ANTI_AFK.AFK_ENABLETIME,
                ["AFK_StartTimeHours"] = NNT.ANTI_AFK.AFK_StartTimeHours,
                ["AFK_StartTimeMinutes"] = NNT.ANTI_AFK.AFK_StartTimeMinutes,
                ["AFK_StopTimeHours"] = NNT.ANTI_AFK.AFK_StopTimeHours,
                ["AFK_StopTimeMinutes"] = NNT.ANTI_AFK.AFK_StopTimeMinutes,
                ["JOBREVERT"] = NNT.ANTI_AFK.AFK_JOBREVERT
            }

            net.WriteString("LoadData")
            net.WriteTable(temptable)
            net.Send(ply)
        elseif data4 == "LoadAFKTime" then
            net.Start("nnt-antiak-settings")
            net.WriteString("LoadAFKTime")

            net.WriteTable({
                ["AFK_TIME"] = NNT.ANTI_AFK.AFK_TIME
            })

            net.Send(ply)
        end
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

-- ADD USER TO THE USERS WHITELIST
net.Receive("AntiAddBypassUsers", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        if string.StartWith(SomeShittyTest, " ") then return end
        if SomeShittyTest == "" then return end
        if NNT.ANTI_AFK.AFK_ADMINBYPASS_USERS[SomeShittyTest] then return end
        NNT.ANTI_AFK:SetConfig("UsersBypass", "ADD", SomeShittyTest)
        net.Start("AntiAfksenBypassUsers")
        net.WriteTable(NNT.ANTI_AFK.AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

-- REMOVE USER FROM THE WHITE LIST
net.Receive("AntiRemBypassUsers", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        NNT.ANTI_AFK:SetConfig("UsersBypass", "DEL", SomeShittyTest)
        net.Start("AntiAfksenBypassUsers")
        net.WriteTable(NNT.ANTI_AFK.AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

-- LOAD USER FROM THE WHITELIST
net.Receive("AntiAfkloaBypassUsers", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        net.Start("AntiAfksenBypassUsers")
        net.WriteTable(NNT.ANTI_AFK.AFK_ADMINBYPASS_USERS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

-- ADD GROUPS TO THE GROUPS WHITELIST
net.Receive("AntiAddBypassGroups", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        if string.StartWith(SomeShittyTest, " ") then return end
        if SomeShittyTest == "" then return end
        if table.HasValue(NNT.ANTI_AFK.AFK_ADMINBYPASS_GROUPS, SomeShittyTest) then return end
        NNT.ANTI_AFK:SetConfig("BypassGroups", "ADD", SomeShittyTest)
        net.Start("AntiAfksenBypassGroups")
        net.WriteTable(NNT.ANTI_AFK.AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

-- REMOVE GROUPS FROM THE GROUPS WHITELIST
net.Receive("AntiRemBypassGroups", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        SomeShittyTest = net.ReadString()
        NNT.ANTI_AFK:SetConfig("BypassGroups", "DEL", SomeShittyTest)
        net.Start("AntiAfksenBypassGroups")
        net.WriteTable(NNT.ANTI_AFK.AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

-- LOAD GROUPS FROM THE GROUPS WHITELIST
net.Receive("AntiAfkloaBypassGroups", function(len, ply)
    if (ply:GetUserGroup() == "superadmin") then
        net.Start("AntiAfksenBypassGroups")
        net.WriteTable(NNT.ANTI_AFK.AFK_ADMINBYPASS_GROUPS)
        net.Send(ply)
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
    end
end)

--  $$$$$$\                                                                  $$\ 
-- $$  __$$\                                                                 $$ |
-- $$ /  \__| $$$$$$\  $$$$$$\$$$$\  $$$$$$\$$$$\   $$$$$$\  $$$$$$$\   $$$$$$$ |
-- $$ |      $$  __$$\ $$  _$$  _$$\ $$  _$$  _$$\  \____$$\ $$  __$$\ $$  __$$ |
-- $$ |      $$ /  $$ |$$ / $$ / $$ |$$ / $$ / $$ | $$$$$$$ |$$ |  $$ |$$ /  $$ |
-- $$ |  $$\ $$ |  $$ |$$ | $$ | $$ |$$ | $$ | $$ |$$  __$$ |$$ |  $$ |$$ |  $$ |
-- \$$$$$$  |\$$$$$$  |$$ | $$ | $$ |$$ | $$ | $$ |\$$$$$$$ |$$ |  $$ |\$$$$$$$ |
--  \______/  \______/ \__| \__| \__|\__| \__| \__| \_______|\__|  \__| \_______|
concommand.Add("afktime", function(ply, _, _)
    ply:ChatPrint("[ANTI-AFK] : Time before kick " .. NNT.ANTI_AFK.AFK_TIME .. " secondes")
    ply:ChatPrint("[ANTI-AFK] : You should get a warning " .. NNT.ANTI_AFK.AFK_WARN_TIME .. " secondes after being afk ")
    ply:ChatPrint("[ANTI-AFK] : Its been " .. NNT.ANTI_AFK.AFK_TIME - math.Round(ply:GetNextAFK() - CurTime()) .. " secondes since u are afk !")
    ply:ChatPrint("[ANTI-AFK] : " .. math.Round(ply:GetNextAFK() - CurTime()) .. " Secondes left before the kick")
end)

-- need to change this in net library ...
concommand.Add("setafkplayer", function(ply, _, args)
    if (ply:GetUserGroup() == "superadmin") then
        if args[1] == "NULL" then
            ply:ChatPrint("[ANTI-AFK] : Player not found or missing args !")

            return
        end

        targetply = player.GetBySteamID(args[1])

        if not targetply then
            ply:ChatPrint("[ANTI-AFK] : Player not found or missing args !")

            return
        end

        arguments = tonumber(args[2], 10)

        if not arguments then
            ply:ChatPrint("[ANTI-AFK] : Player not found or missing args !")

            return
        end

        if (targetply:IsBot() == false) then
            tplyc = CurTime() + arguments

            if (tplyc < CurTime() + 120) then
                ply:ChatPrint("[ANTI-AFK] : Commands was not exectued because player have less then 120 secondes left before getting kick")

                return
            else
                targetply:SetNextAFK(arguments)
                ply:ChatPrint("[ANTI-AFK] : " .. targetply:Nick() .. " is now afk in " .. math.Round(targetply:GetNextAFK() - CurTime()) .. " secondes he will get kick")
            end
        end
    else
        net.Start("AntiAfkSendHUDInfo")
        net.WriteString("AccessDeniedError")
        net.Send(ply)
        ply:ChatPrint("[ANTI-AFK] : U are not a SuperAdmin !")
    end
end)

-- $$\   $$\                     $$\       
-- $$ |  $$ |                    $$ |      
-- $$ |  $$ | $$$$$$\   $$$$$$\  $$ |  $$\ 
-- $$$$$$$$ |$$  __$$\ $$  __$$\ $$ | $$  |
-- $$  __$$ |$$ /  $$ |$$ /  $$ |$$$$$$  / 
-- $$ |  $$ |$$ |  $$ |$$ |  $$ |$$  _$$<  
-- $$ |  $$ |\$$$$$$  |\$$$$$$  |$$ | \$$\ 
-- \__|  \__| \______/  \______/ \__|  \__|
hook.Add("PlayerInitialSpawn", "MakeAFKVarAndSendLanguage", function(ply)
    ply:SetNextAFK(NNT.ANTI_AFK.AFK_TIME)
    net.Start("nnt-antiak-settings")
    net.WriteString("LoadAFKTime")

    net.WriteTable({
        ["AFK_TIME"] = NNT.ANTI_AFK.AFK_TIME
    })

    net.Send(ply)
end)

hook.Add("Think", "NNT-AFKPLAYERS", function()
    for _, ply in pairs(player.GetHumans()) do
        if (ply:IsConnected() and ply:IsFullyAuthenticated()) then
            if not NNT.ANTI_AFK.AFK_ENABLE then
                ply:SetNextAFK(NNT.ANTI_AFK.AFK_TIME)

                return
            end

            if NNT.ANTI_AFK.AFK_ENABLETIME and not IsNowBetween(NNT.ANTI_AFK.AFK_StartTimeHours, NNT.ANTI_AFK.AFK_StartTimeMinutes, NNT.ANTI_AFK.AFK_StopTimeHours, NNT.ANTI_AFK.AFK_StopTimeMinutes) then return end

            if (not ply:GetNextAFK()) then
                ply:SetNextAFK(NNT.ANTI_AFK.AFK_TIME)
            end

            local afktime = ply:GetNextAFK() - NNT.ANTI_AFK.AFK_TIME

            if (CurTime() >= afktime + NNT.ANTI_AFK.AFK_WARN_TIME) and (not ply:IsAFK()) and (not ply:SPIsAFK()) then
                if NNT.ANTI_AFK.AFK_ADMINBYPASS_USERS[ply:SteamID()] and (not ply:SPIsAFK()) and (not ply:IsAFK()) then
                    if NNT.ANTI_AFK.AFK_ADMINUBYPASS == false then
                        if table.HasValue(NNT.ANTI_AFK.AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup()) and not ply:SPIsAFK() and not ply:IsAFK() and NNT.ANTI_AFK.AFK_ADMINBYPASS then
                            ply:SPSetAFK(true)

                            return
                        else
                            net.Start("AntiAfkSendHUDInfo")
                            net.WriteString("AntiafkMainHUD")
                            net.Send(ply)
                            NNT.ANTI_AFK.AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
                            hook.Call("NNT-ANTIAFK_Warning", GAMEMODE, ply)
                            ply:SetAFK(true)
                        end
                    else
                        ply:SPSetAFK(true)
                    end
                elseif table.HasValue(NNT.ANTI_AFK.AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup()) and (not ply:SPIsAFK()) and (not ply:IsAFK()) then
                    if NNT.ANTI_AFK.AFK_ADMINBYPASS == false then
                        net.Start("AntiAfkSendHUDInfo")
                        net.WriteString("AntiafkMainHUD")
                        net.Send(ply)
                        NNT.ANTI_AFK.AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
                        hook.Call("NNT-ANTIAFK_Warning", GAMEMODE, ply)
                        ply:SetAFK(true)
                    else
                        ply:SPSetAFK(true)
                    end
                else
                    print("[ANTI-AFK]" .. ply:Name() .. "est maintenant AFK !")
                    ply:SetAFK(true)
                    net.Start("AntiAfkSendHUDInfo")
                    net.WriteString("AntiafkMainHUD")
                    net.Send(ply)
                    NNT.ANTI_AFK.AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()
                    hook.Call("NNT-ANTIAFK_Warning", GAMEMODE, ply)
                end
            elseif (CurTime() >= afktime + NNT.ANTI_AFK.AFK_TIME) and (ply:IsAFK()) then
                ply:SetAFK(nil)
                ply:SetNextAFK(nil)
                ply:SPSetAFK(nil)
                ply:Kick("#nnt.kick_message")
                hook.Call("NNT-ANTIAFK_Kick", GAMEMODE, ply)
            end
        end
    end
end)

hook.Add("KeyPress", "NNT-AFK-PlayerMoved", function(ply, _)
    if ply:InVehicle() or not ply:InVehicle() and not (ply:GetAimVector() == NNT.ANTI_AFK.AntiAFKPlayerEyesTrack[ply:SteamID()]) then
        ply:SetNextAFK(NNT.ANTI_AFK.AFK_TIME)
        NNT.ANTI_AFK.AntiAFKPlayerEyesTrack[ply:SteamID()] = ply:GetAimVector()

        if ply:IsAFK() or ply:SPIsAFK() then
            if ply:SPIsAFK() then
                ply:SPSetAFK(false)
            end

            if ply:IsAFK() then
                ply:SetAFK(false)
            end

            print(ply:Name() .. " est plus AFK !")
            hook.Call("NNT-ANTIAFK_UnWarning", GAMEMODE, ply)

            if NNT.ANTI_AFK.AFK_ADMINBYPASS_USERS[ply:SteamID()] and (not ply:SPIsAFK()) and (not ply:IsAFK()) then
                if NNT.ANTI_AFK.AFK_ADMINUBYPASS == false then
                    if table.HasValue(NNT.ANTI_AFK.AFK_ADMINBYPASS_GROUPS, ply:GetUserGroup()) and (not ply:SPIsAFK()) and (not ply:IsAFK()) and not NNT.ANTI_AFK.AFK_ADMINBYPASS then
                        net.Start("AFKHUD1")
                        net.WriteString("true")
                        net.Send(ply)

                        return
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

hook.Add("PlayerSay", "Antiafkcommand", function(ply, text, _)
    if string.StartWith(text, "/afktime") then
        commands = "/afktime"
        hook.Call("NNT-ANTIAFK_Command", GAMEMODE, ply, commands)
        ply:ConCommand("afktime")

        return ""
    elseif (string.StartWith(text, "/setafk") or zthen) then
        commands = "/setafk"

        if (ply:GetUserGroup() == "superadmin") then
            net.Start("AntiAfkSendHUDInfo")
            net.WriteString("AntiafkAdminSetAfk")
            net.Send(ply)
            hook.Call("NNT-ANTIAFK_Command", GAMEMODE, ply, commands)
        else
            net.Start("AntiAfkSendHUDInfo")
            net.WriteString("AccessDeniedError")
            net.Send(ply)
            ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
            hook.Call("NNT-ANTIAFK_CommandFail", GAMEMODE, ply, commands)
        end

        return ""
    elseif (string.StartWith(text, "/afkpanel") == true) then
        commands = "/afkpanel"

        if (ply:GetUserGroup() == "superadmin") then
            net.Start("AntiAfkSendHUDInfo")
            net.WriteString("AntiafkAdminPanel")
            net.Send(ply)
            hook.Call("NNT-ANTIAFK_Command", GAMEMODE, ply, commands)
        else
            net.Start("AntiAfkSendHUDInfo")
            net.WriteString("AccessDeniedError")
            net.Send(ply)
            ply:ChatPrint("[ANTI-AFK] : You don't have the permission to accces the panel !")
            hook.Call("NNT-ANTIAFK_CommandFail", GAMEMODE, ply, commands)
        end

        return ""
    elseif (string.StartWith(text, "/afkhelp") == true) then
        ply:ChatPrint("Disponible commands :")
        ply:ChatPrint("/afktime : Show Afk time before warn , kick etc..")
        ply:ChatPrint("/setafk : Open panel to set a player how much time is left before kick [SuperAdmin only]")
        ply:ChatPrint("/akfpanel : Open Panel to change settings [Live Change] and see settings [SuperAdmin only]")
        ply:ChatPrint("/afkhelp : Print this messages in the chat ")
        commands = "/afkhelp"
        hook.Call("NNT-ANTIAFK_Command", GAMEMODE, ply, commands)

        return ""
    end
end)