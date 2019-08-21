local MODULE = GAS.Logging:MODULE()

MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name     = "AFK Logs"
MODULE.Colour   = Color(255, 149, 63)

MODULE:Hook("NNT-ANTIAFK_Warning","NNT-ANTIAFK_Warning",function(ply)
	MODULE:Log(GAS.Logging:FormatPlayer(ply) .. " is now AFK !")
end)

MODULE:Hook("NNT-ANTIAFK_UnWarning","NNT-ANTIAFK_UnWarning",function(ply)
	MODULE:Log(GAS.Logging:FormatPlayer(ply) .. " is no longer AFK !")
end)

MODULE:Hook("NNT-ANTIAFK_Kick","NNT-ANTIAFK_Kick",function(ply)
	MODULE:Log(GAS.Logging:FormatPlayer(ply) .. " is no longer afk since he has been kick for AFK !")
end)

GAS.Logging:AddModule(MODULE)

-----------------------------------------------------------------

local MODULE = GAS.Logging:MODULE()

MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name     = "AKF Kicks"
MODULE.Colour   = Color(255, 149, 63)

MODULE:Hook("NNT-ANTIAFK_Kick","NNT-ANTIAFK_Kick",function(ply)
	MODULE:Log(GAS.Logging:FormatPlayer(ply) .. " was {#H|kicked|#} for being AFK !")
end)

GAS.Logging:AddModule(MODULE)

-----------------------------------------------------------------

local MODULE = GAS.Logging:MODULE()

MODULE.Category = "[NNT] Anti-AFK"
MODULE.Name     = "AFK Commands"
MODULE.Colour   = Color(255, 149, 63)

MODULE:Hook("NNT-ANTIAFK_Command","NNT-ANTIAFK_Command",function(ply,command)
	MODULE:Log(GAS.Logging:FormatPlayer(ply) .. " has executed the command: " .. command )
end)
MODULE:Hook("NNT-ANTIAFK_CommandFail","NNT-ANTIAFK_CommandFail",function(ply,command)
	MODULE:Log(GAS.Logging:FormatPlayer(ply) .. " has tried to use the command: " .. command )
end)

GAS.Logging:AddModule(MODULE)