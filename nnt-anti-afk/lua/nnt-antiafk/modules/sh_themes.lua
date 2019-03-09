NNTAntiafkThemes = NNTAntiafkThemes or {}
AntiAfkDisponibleThemes = {}

print("[NNT-ANTIAFK] Loading themes")

for k,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
	include("nnt-antiafk/themes/" .. v)
    print("[ANTI-AFK] Loading Themes:  " ..v )
end

for k,v in pairs(NNTAntiafkThemes) do
	table.ForceInsert(AntiAfkDisponibleThemes, k)
    print("[ANTI-AFK] Themes working: " .. k)
end
