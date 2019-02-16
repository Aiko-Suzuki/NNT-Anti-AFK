local MODULE = bLogs:Module()

MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name     = "AKF LOGS"
MODULE.Colour   = Color(255, 149, 63)

MODULE:Hook("AikoAfkTimeBefore","AikoAfkTimeBefore",function(ply)
	MODULE:Log(bLogs:FormatPlayer(ply) .. " is now AFK !")
end)

MODULE:Hook("AikoAfkTimeAfter","AikoAfkTimeAfter",function(ply)
	MODULE:Log(bLogs:FormatPlayer(ply) .. " is no longer AFK !")
end)

MODULE:Hook("AikoAfkKICKa","AikoAfkKICKa",function(ply)
	MODULE:Log(bLogs:FormatPlayer(ply) .. " is no longer afk since he has been kick for AFK !")
end)

bLogs:AddModule(MODULE)

-----------------------------------------------------------------

local MODULE = bLogs:Module()

MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name     = "AKF Kicks"
MODULE.Colour   = Color(255, 149, 63)

MODULE:Hook("AikoAfkKICK","AikoAfkKICK",function(ply)
	MODULE:Log(bLogs:FormatPlayer(ply) .. " was {#H|kicked|#} for being AFK !")
end)

bLogs:AddModule(MODULE)

-----------------------------------------------------------------

local MODULE = bLogs:Module()

MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name     = "AFK Commands"
MODULE.Colour   = Color(255, 149, 63)

MODULE:Hook("AikoAfkCommands","AikoAfkCommands",function(ply,command)
	MODULE:Log(bLogs:FormatPlayer(ply) .. " has executed the command: " .. command )
end)
MODULE:Hook("AikoAfkCommandsFail","AikoAfkCommandsFail",function(ply,command)
	MODULE:Log(bLogs:FormatPlayer(ply) .. " has tried to use the command: " .. command )
end)

bLogs:AddModule(MODULE)