AntiAfkTranslate = AntiAfkTranslate or {}
AntiAfkDisponibleLang = {}

print("[NNT-ANTIAFK] Loading Languages")

for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
	include("nnt-antiafk/lang/" .. v)
    print("[ANTI-AFK] Loaded " ..v )
end

for k,v in pairs(AntiAfkTranslate) do
	table.insert(AntiAfkDisponibleLang, table.Count(AntiAfkDisponibleLang) + 1,k)
end