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

NNTAntiafkThemes = NNTAntiafkThemes or {}

print("[NNT-ANTIAFK] Loading themes")

function NNT_AntiAFK_AddThemes(name,func)
	if name == nil then print("Undefined Name for theme") return end
	if func == nil then print("Undefined function for theme") return end
	if !type(func) == "function" then print("the function is not valid !") return end
	if !type(name) == "string" then  print("the name must be a string !") return end
	NNTAntiafkThemes[name] = func
	print("[ANTI-AFK] Theme loaded :  " ..name )
end

for k,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
	include("nnt-antiafk/themes/" .. v)
end
