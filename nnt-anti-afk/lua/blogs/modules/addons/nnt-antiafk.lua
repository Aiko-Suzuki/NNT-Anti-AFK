local MODULE = bLogs:Module()
MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name = "AKF Logs"
MODULE.Colour = Color(255, 149, 63)

MODULE:Hook("NNT-ANTIAFK_Warning", "NNT-ANTIAFK_Warning", function(ply)
    MODULE:Log(bLogs:FormatPlayer(ply) .. " is now AFK !")
end)

MODULE:Hook("NNT-ANTIAFK_UnWarning", "NNT-ANTIAFK_UnWarning", function(ply)
    MODULE:Log(bLogs:FormatPlayer(ply) .. " is no longer AFK !")
end)

MODULE:Hook("NNT-ANTIAFK_Kick", "NNT-ANTIAFK_Kick", function(ply)
    MODULE:Log(bLogs:FormatPlayer(ply) .. " is no longer afk since he has been kick for AFK !")
end)

bLogs:AddModule(MODULE)
-----------------------------------------------------------------
local MODULE = bLogs:Module()
MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name = "AKF Kicks"
MODULE.Colour = Color(255, 149, 63)

MODULE:Hook("NNT-ANTIAFK_Kick", "NNT-ANTIAFK_Kick", function(ply)
    MODULE:Log(bLogs:FormatPlayer(ply) .. " was {#H|kicked|#} for being AFK !")
end)

bLogs:AddModule(MODULE)
-----------------------------------------------------------------
local MODULE = bLogs:Module()
MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name = "AFK Commands"
MODULE.Colour = Color(255, 149, 63)

MODULE:Hook("NNT-ANTIAFK_Command", "NNT-ANTIAFK_Command", function(ply, command)
    MODULE:Log(bLogs:FormatPlayer(ply) .. " has executed the command: " .. command)
end)

MODULE:Hook("NNT-ANTIAFK_CommandFail", "NNT-ANTIAFK_CommandFail", function(ply, command)
    MODULE:Log(bLogs:FormatPlayer(ply) .. " has tried to use the command: " .. command)
end)

bLogs:AddModule(MODULE)