AntiAfkLanguage = "EN"
AntiAfkSelTheme = "Large"


include("sh_nnt-antiafk.lua")
hook.Add( "Initialize", "NNT-AntiAFK-FinishLoading-Client", function()
	include("nnt-antiafk/cl_skin.lua")
end)

function timeToStr( time )
	local tmp = time
	local s = tmp % 60
	tmp = math.floor( tmp / 60 )
	local m = tmp
	return string.format( "%02im %02is", m, s )
end

	function timeToStr( time )
		local tmp = time
		local s = tmp % 60
		tmp = math.floor( tmp / 60 )
		local m = tmp
		return string.format( "%02im %02is", m, s )
	end


--[[
  /$$$$$$  /$$$$$$$  /$$      /$$ /$$$$$$ /$$   /$$       /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
 /$$__  $$| $$__  $$| $$$    /$$$|_  $$_/| $$$ | $$      | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \ $$| $$  \ $$| $$$$  /$$$$  | $$  | $$$$| $$      | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$$$$$$$| $$  | $$| $$ $$/$$ $$  | $$  | $$ $$ $$      | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$__  $$| $$  | $$| $$  $$$| $$  | $$  | $$  $$$$      | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$  | $$| $$  | $$| $$\  $ | $$  | $$  | $$\  $$$      | $$      | $$  | $$| $$\  $$$| $$      | $$
| $$  | $$| $$$$$$$/| $$ \/  | $$ /$$$$$$| $$ \  $$      | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/  |__/|_______/ |__/     |__/|______/|__/  \__/      |__/      |__/  |__/|__/  \__/|________/|________/
]]
local function NNTAntiafkAdminPanel(data)
    local w = ScrW() / 2
    local h = ScrH() / 2
    SomeShittyTest = "undefined"
    SomeShittyTest1 = "undefined"
	SomeShittyTest2 = "undefined"
	SomeShittyTest3 = "undefined"


	local NNT_ANTI_MainPanel = vgui.Create( "DFrame" )
	NNT_ANTI_MainPanel:SetPos( w-250, h-200 )
	NNT_ANTI_MainPanel:SetSize( 500, 400 )
	NNT_ANTI_MainPanel:SetTitle( "")
	NNT_ANTI_MainPanel:SetDraggable( false )
	NNT_ANTI_MainPanel:ShowCloseButton( true )
	NNT_ANTI_MainPanel:MakePopup()
	NNT_ANTI_MainPanel:SetSkin("NNT-AntiAFK")
	local function MenuGoUP( fraction, change )
		return change / ( fraction ^ 0.6 )
	end
	local LoadMenu = Derma_Anim( "OpenConfigPanel", NNT_ANTI_MainPanel, function( panel, anim, delta )
		panel:SetPos( w-250, MenuGoUP( delta, h-200 ) )
	end )
	LoadMenu:Start( 0.6 )
	NNT_ANTI_MainPanel.Think = function( self )
	if LoadMenu:Active() then
		LoadMenu:Run()
		end
	end

	local WindowSelect = vgui.Create( "DPropertySheet", NNT_ANTI_MainPanel )
	WindowSelect:SetPos(-1,33)
	WindowSelect:SetSize(502, 369)
	WindowSelect:SetFadeTime(0)
	WindowSelect.OnActiveTabChanged = function( old, new )
		surface.PlaySound("garrysmod/ui_return.wav")
	end



	local GeneralSettingsM = vgui.Create( "DPanel" , WindowSelect)
	GeneralSettingsM:SetPos( 0, 0 )
	GeneralSettingsM:SetSize( 500, 336 )
	GeneralSettingsM.Title = {
		[AntiAfkTranslate[AntiAfkLanguage]["GENSETTINGS"]]  = { x = 30 , y = -3, font = "HUDLARGETEXT"}  ,
		["Team Settings !"]  = { x = 45 , y = 220, font = "HUDLARGETEXT"}  ,
		[AntiAfkTranslate[AntiAfkLanguage]["TIMESSETTINGS"]]  = { x = 365 , y = -3, font = "HUDLARGETEXT" , align = "center" },
		["Hours Settings !"]  = { x = 317 , y = 165, font = "HUDLARGETEXT" }
	}
	WindowSelect:AddSheet( "Settings", GeneralSettingsM, "nnt-antiafk/option.png" )


	local WhitelistS = vgui.Create( "DPanel" , WindowSelect)
	WhitelistS:SetPos( 0, 0 )
	WhitelistS:SetSize( 250, 200)
	WindowSelect:AddSheet( " WhiteList!", WhitelistS, "nnt-antiafk/users.png" )
	WhitelistS.Title = {
		["User's Whitelist!"]  = { x = 75 , y = 2, font = "HUDLARGETEXT"}  ,
		["Groups Whitelist!"]  = { x = 360 , y = 2, font = "HUDLARGETEXT" , align = "center" }
	}


	local LanguagesAndThemes = vgui.Create( "DPanel" , WindowSelect)
	LanguagesAndThemes:SetPos( 0, 0 )
	LanguagesAndThemes:SetSize( 500, 336 )
	LanguagesAndThemes.Title = {
		[AntiAfkTranslate[AntiAfkLanguage]["THEME"]]  = { x = 330 , y = 2, font = "HUDLARGETEXT"} ,
		[AntiAfkTranslate[AntiAfkLanguage]["LANGUAGESET"]]  = { x = 70 , y = 2, font = "HUDLARGETEXT"}
	}
	WindowSelect:AddSheet( "Languages and Themes", LanguagesAndThemes, "nnt-antiafk/translate.png" )


	local SetAFKMenu = vgui.Create( "DPanel" , NNT_ANTI_MainPanel)
	SetAFKMenu:SetPos( 0, 20 )
	SetAFKMenu:SetSize( 400, 300 )
	SetAFKMenu.Title = { ["Set Player AFK !"]  = { x = 185 , y = 5, font = "HUDLARGETEXT"}}
	WindowSelect:AddSheet( "Set AFK", SetAFKMenu, "nnt-antiafk/clock.png" )



	local MoreInfo = vgui.Create( "DPanel" , WindowSelect)
	MoreInfo:SetPos( 0, 0 )
	MoreInfo:SetSize( 250, 200)
	WindowSelect:AddSheet( "Info", MoreInfo, "nnt-antiafk/question-mark.png" )

	local ThemesMenu = vgui.Create( "DFrame" , LanguagesAndThemes)
	ThemesMenu:SetPos( 250, 0 )
	ThemesMenu:SetSize( 250, 70 )
	ThemesMenu:SetTitle( "" )
	ThemesMenu:SetDraggable( false )
	ThemesMenu:ShowCloseButton( false )
	function ThemesMenu:Paint(w, h) end

	local LangMenu = vgui.Create( "DFrame" , LanguagesAndThemes)
	LangMenu:SetPos( 0, 0 )
	LangMenu:SetSize( 250, 70 )
	LangMenu:SetTitle( "" )
	LangMenu:SetDraggable( false )
	LangMenu:ShowCloseButton( false )
	function LangMenu:Paint(w, h) end

	local ServerConfigLanguagesAndThemes = vgui.Create( "DLabel", LanguagesAndThemes )
	ServerConfigLanguagesAndThemes:SetPos( 175, 60 )
	ServerConfigLanguagesAndThemes:SetSize(100, 24)
	ServerConfigLanguagesAndThemes:SetFont("HUDLARGETEXT")
	ServerConfigLanguagesAndThemes:SetText( "Server Config !" )
	ServerConfigLanguagesAndThemes:SetTextColor(Color(0, 0, 0))

	local ServerConfigLanguages = vgui.Create( "DLabel", LanguagesAndThemes )
	ServerConfigLanguages:SetPos( 150, 80 )
	ServerConfigLanguages:SetSize(140, 24)
	ServerConfigLanguages:SetFont("Trebuchet18")
	ServerConfigLanguages:SetText( "Languages :" )
	ServerConfigLanguages:SetTextColor(Color(0, 0, 0))

	local ServerConfigThemes = vgui.Create( "DLabel", LanguagesAndThemes )
	ServerConfigThemes:SetPos( 150, 100 )
	ServerConfigThemes:SetSize(100, 24)
	ServerConfigThemes:SetFont("Trebuchet18")
	ServerConfigThemes:SetText( "Theme :" )
	ServerConfigThemes:SetTextColor(Color(0, 0, 0))



	local InfoKickMinutes = vgui.Create( "DLabel", GeneralSettingsM )
	InfoKickMinutes:SetPos( 320, 14 )
	InfoKickMinutes:SetSize(100, 18)
	InfoKickMinutes:SetTextColor(Color(0,0,0))
	InfoKickMinutes:SetText( "Kick Time [Minutes]" )

	local InfoWarnMinutes = vgui.Create( "DLabel", GeneralSettingsM )
	InfoWarnMinutes:SetPos( 320, 70 )
	InfoWarnMinutes:SetSize(100, 18)
	InfoWarnMinutes:SetTextColor(Color(0,0,0))
	InfoWarnMinutes:SetText( "Warn Time [Minutes]" )


	local KickSliderSelect = vgui.Create( "Slider" , GeneralSettingsM)
    KickSliderSelect:SetPos( 255, 40 )
    KickSliderSelect:SetSize( 250, 20 )
    KickSliderSelect:SetMin( 5 )
	KickSliderSelect:SetMax(60)
	KickSliderSelect:SetDecimals(0)
	KickSliderSelect:SetSkin("NNT-AntiAFK")


	local WarnSliderSelect = vgui.Create( "Slider" , GeneralSettingsM)
    WarnSliderSelect:SetPos( 255, 100 )
    WarnSliderSelect:SetSize( 250, 20 )
    WarnSliderSelect:SetMin( 2 )
	WarnSliderSelect:SetMax(55)
	WarnSliderSelect:SetDecimals(0)
	WarnSliderSelect:SetSkin("NNT-AntiAFK")



	--[[----------------------------------------------------------------------
									Loading CheckBox
	----------------------------------------------------------------------]]--

	NNTAntiAFK = {}
	NNTAntiAFK.CheckBox = {}
	-- Enable / Disable Anti-AFK CheckBox
	NNTAntiAFK.CheckBox.ActivateAFK 		= 		{ name = "NNTCheckBoxActivateAFK", text = "Activate AntiAFK" , pos = 1 , pos2 = 1, data = "ANTIAFK" }
	-- Enable / Disable User's Bypass CheckBox
	NNTAntiAFK.CheckBox.UsersBypass 		= 		{  name = "NNTCheckBoxUsersBypass", text = "User's Bypass" , pos = 2 , pos2 = 1 , data = "UBYPASS" }
	-- Enable / Disable Groups Bypass CheckBox
	NNTAntiAFK.CheckBox.GroupsBypass 		= 		{ name = "NNTCheckBoxGroupsBypass", text = "Groups Bypass" , pos = 3 , pos2 = 1 , data = "BYPASS" }
	-- Enable / Disable Ghost Mode CheckBox
	NNTAntiAFK.CheckBox.GhostMode			= 		{ name = "NNTCheckBoxGhostMode", text = "Ghost Mode" , pos = 4 , pos2 = 1 , data = "GHOST" }
	-- Enable / Disable Freeze Salary (DarkRP) CheckBox
	NNTAntiAFK.CheckBox.FreezeSalary		= 		{ name = "NNTCheckBoxFreezeSalary", text = "Freeze Salary (DarkRP)" , pos = 5 , pos2 = 1 , data = "DARKPMONEY" }
	-- Enable / Disable God Mode CheckBox
	NNTAntiAFK.CheckBox.AFKGodMode			= 		{ name = "NNTCheckBoxGodMode", text = "God Mode" , pos = 6 , pos2 = 1, data = "GODMODE" }
	-- Enable / Disable Job Changes when AFK CheckBox
	NNTAntiAFK.CheckBox.AFKJobEnable		= 		{ name = "NNTCheckBoxJobChange", text = "Change Team" , pos = 7 , pos2 = 1, data = "JOBENABLE" }
	-- Enable / Disable Anti Afk only activate between certain hours
	NNTAntiAFK.CheckBox.AFKEnableTime		= 		{ name = "NNTCheckBoxEnableTime", text = "Use Hours Settings" , pos = 8 , pos2 = 1 , data = "ENABLETIME" }
	-- Enable / Disable revert back when no longer afk .. (if team not full)
	NNTAntiAFK.CheckBox.AFKJOBREVERT		= 		{ name = "NNTCheckBoxJOBREVERT", text = "Revert Back (no-longer afk)" , pos = 11.2, pos2 = 1 , data = "JOBREVERT" }



	function NNTCheckChange( p, st, dif ) -- USED FOR THE ANIMATION !
		return dif * ( p ^ 2 ) + st
	end

	local function LoadCheckBoxFromTable(data,tab,buttonY) -- LOAD ALL THE CHECK BOX SET IN THE TABLE ABOVE !
		local loadbutton = buttonY
		for k,v in pairs(tab) do
			if v["data"] then
				local code = [[
				]] .. v["name"] .. [[ = vgui.Create( "NNTDCheckBoxLabel" )
				]] .. v["name"] .. [[:SetParent(...)
				]] .. v["name"] .. [[:SetPos( 10 * ]] .. v["pos2"] .. [[, 24 * ]] .. v["pos"] .. [[)
				]] .. v["name"] .. [[:SetText( "]] .. v["text"] .. [[" )
				]] .. v["name"] .. [[:SetTextColor(Color(0,0,0))
				]] .. v["name"] .. [[.SetAnimtionPos =  2
				timer.Simple(0.3, function()
				if ]] .. v["name"] .. [[:GetValue() == 1 then
					]] .. v["name"] .. [[.SetAnimtionPos =  18
				end
				function ]] .. v["name"] .. [[:OnChange( val )
					surface.PlaySound( "ui/buttonclick.wav" )
					if val then
						]] .. v["name"] .. [[CheckAnime = Derma_Anim( "Active", ]] .. v["name"] .. [[ , function( pnl, CheckAnime, delta, data )
							pnl.SetAnimtionPos =  NNTCheckChange( delta, 2, 17 )
						end )
						]] .. v["name"] .. [[CheckAnime:Start( 0.2 )

						]] .. v["name"] .. [[.Think = function( self )
							if  ]] .. v["name"] .. [[CheckAnime:Active() then
								 ]] .. v["name"] .. [[CheckAnime:Run()
							end
						end
						net.Start("nnt-antiak-settings")
							local temptable = {["]] .. v["data"] .. [["] = true }
							net.WriteTable(temptable)
							net.WriteString("SetSettings")
            			net.SendToServer()
					else
						]] .. v["name"] .. [[CheckAnime = Derma_Anim( "Active", ]] .. v["name"] .. [[ , function( pnl, CheckAnime, delta, data )
							pnl.SetAnimtionPos =  NNTCheckChange( delta, 19, -17 )
						end )
						]] .. v["name"] .. [[CheckAnime:Start( 0.2 )

						]] .. v["name"] .. [[.Think = function( self )
							if  ]] .. v["name"] .. [[CheckAnime:Active() then
								 ]] .. v["name"] .. [[CheckAnime:Run()
							end
						end
						net.Start("nnt-antiak-settings")
							local temptable = {["]] .. v["data"] .. [["] = false }
							net.WriteTable(temptable)
							net.WriteString("SetSettings")
            			net.SendToServer()
					end
				end
				end)
				return ]] .. k .. [[
				]]
				local LoadCheckBox = CompileString( code, k .. ":NNT" )
				LoadCheckBox(data)
			elseif v["data"] == nil then
				local code = [[
				]] .. v["name"] .. [[ = vgui.Create( "NNTDCheckBoxLabel" )
				]] .. v["name"] .. [[:SetParent(...)
				]] .. v["name"] .. [[:SetPos( 10, 24 * ]] .. v["pos"] .. [[)
				]] .. v["name"] .. [[:SetText( "]] .. v["text"] .. [[" )
				]] .. v["name"] .. [[:SetTextColor(Color(0,0,0))
				]] .. v["name"] .. [[:SetSkin("NNT-AntiAFK")
				]] .. v["name"] .. [[.SetAnimtionPos =  2
				timer.Simple(0.3, function()
					if ]] .. v["name"] .. [[:GetValue() == 1 then
						]] .. v["name"] .. [[.SetAnimtionPos =  18
					end
					function ]] .. v["name"] .. [[:OnChange( val )
						surface.PlaySound( "ui/buttonclick.wav" )
						if val then
						else
						end
					end
				end)
				local ]] .. v["name"] .. [[_btn = vgui.Create("DButton")
				]] .. v["name"] .. [[_btn:SetParent( ...)
				]] .. v["name"] .. [[_btn:SetText( "EDIT" )
				]] .. v["name"] .. [[_btn:SetPos( 150, 24 * ]] .. v["pos"] .. [[)
				]] .. v["name"] .. [[_btn:SetSize( 75, 15 )
				]] .. v["name"] .. [[_btn:SetFont("DermaDefaultBold")
    			]] .. v["name"] .. [[_btn:SetColor(Color(255, 255, 255))
				]] .. v["name"] .. [[_btn:SetSkin("NNT-AntiAFK")
				]] .. v["name"] .. [[_btn.DoClick = function ()

				end
				return ]] .. k .. [[
			]]
			local LoadCheckBox = CompileString( code, k .. ":NNT" )
			LoadCheckBox(data)
			end

		end

	end
	LoadCheckBoxFromTable(GeneralSettingsM,NNTAntiAFK.CheckBox,1)

	--[[----------------------------------------------------------------------
						   Finished Loading CheckBox
	----------------------------------------------------------------------]]--


	local SelectTheme = vgui.Create( "DComboBox", ThemesMenu )
	SelectTheme:SetPos( 65, 35 )
	SelectTheme:SetSize( 75, 20 )
	SelectTheme:SetValue( AntiAfkSelTheme )
	SelectTheme:SetSkin("NNT-AntiAFK")
	for k,v in pairs(NNTAntiafkThemes) do
		SelectTheme:AddChoice(k)
	end
	SelectTheme.OnSelect = function( self, index, value )
		for k,v in pairs(NNTAntiafkThemes) do
			if k == value then
				AntiAFKSelectedTheme = k
			end
		end
	end


	local MoreInfoTittle = vgui.Create( "DLabel", MoreInfo )
	MoreInfoTittle:SetPos( 10, 10 )
	MoreInfoTittle:SetSize(200, 24)
	MoreInfoTittle:SetFont("HUDLARGETEXT")
	MoreInfoTittle:SetTextColor(Color(0, 0, 0))
	MoreInfoTittle:SetText( "Incomming Features !" )

	local MoreInfoFeatures = vgui.Create( "DLabel", MoreInfo )
	MoreInfoFeatures:SetPos( 10, 30 )
	MoreInfoFeatures:SetSize(500, 50)
	MoreInfoFeatures:SetFont("HUDLARGESMALL")
	MoreInfoFeatures:SetTextColor(Color(0, 0, 0))
	MoreInfoFeatures:SetText( [[
		- Temp bypass for user
	]] )
	local MoreInfoTittle2 = vgui.Create( "DLabel", MoreInfo )
	MoreInfoTittle2:SetPos( 10, 75 )
	MoreInfoTittle2:SetSize(200, 24)
	MoreInfoTittle2:SetFont("HUDLARGETEXT")
	MoreInfoTittle2:SetTextColor(Color(0, 0, 0))
	MoreInfoTittle2:SetText( "Credits!" )

	local MoreInfoCredits = vgui.Create( "DLabel", MoreInfo )
	MoreInfoCredits:SetPos( 10, 85 )
	MoreInfoCredits:SetSize(450, 100)
	MoreInfoCredits:SetFont("HUDLARGESMALL")
	MoreInfoCredits:SetTextColor(Color(0, 0, 0))
	MoreInfoCredits:SetText( [[
		- Icons made by Freepik from www.flaticon.com is licensed by CC 3.0 BY
		- Icons made by Chanut from www.flaticon.com is licensed by CC 3.0 BY
		- Spanish translation made by Wex[A]rt
	]] )

	local SelectTranslate = vgui.Create( "DComboBox", LangMenu )
	SelectTranslate:SetPos( 65, 35 )
	SelectTranslate:SetSize( 75, 20 )
	SelectTranslate:SetSkin("NNT-AntiAFK")
	SelectTranslate:SetValue( AntiAfkTranslate[AntiAfkLanguage]["NAME"] )
	for k,v in pairs(AntiAfkTranslate) do
	SelectTranslate:AddChoice(v["NAME"])
	end
	SelectTranslate.OnSelect = function( self, index, value )
		for k,v in pairs(AntiAfkTranslate) do
			if v["NAME"] == value then
				AntiAFKSelectedLanguages = k
			end
		end
	end

    local list_btn = vgui.Create("DButton")
	list_btn:SetParent( GeneralSettingsM )
	list_btn:SetText( "APPLY CHANGE" )
	list_btn:SetPos( 317, 135)
	list_btn:SetSize( 100, 20 )
	list_btn:SetFont("DermaDefaultBold")
    list_btn:SetColor(Color(255, 255, 255))
	list_btn:SetSkin("NNT-AntiAFK")


	list_btn.DoClick = function ()
		surface.PlaySound( "garrysmod/ui_click.wav")
		if math.Round(KickSliderSelect:GetValue()) >= 2 then
			if not (math.Round(KickSliderSelect:GetValue()) - 2 >= math.Round(WarnSliderSelect:GetValue())) then
				LocalPlayer():ChatPrint("[ANTI-AFK] You need to enter a time at least 2 min above the warn time !")
				return
			end
			net.Start("nnt-antiak-settings")
				local temptable = {["KICK"] = math.Round(KickSliderSelect:GetValue()) * 60 }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
			LocalPlayer():ChatPrint("[ANTI-AFK] Kick Time has been save !")
		else
			LocalPlayer():ChatPrint("[ANTI-AFK] You need to enter a time above or equal to 180 in the kick time !")
		end
		if math.Round(WarnSliderSelect:GetValue()) >= 2 then
            net.Start("nnt-antiak-settings")
				local temptable = {["WARN"] = math.Round(WarnSliderSelect:GetValue()) * 60 }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
			LocalPlayer():ChatPrint("[ANTI-AFK] Warn Time has been save !")
		else
			LocalPlayer():ChatPrint("[ANTI-AFK] You need to enter a time above or equal to 30 in the warn time !")
		end
	end


	local InfoTimeSettings = vgui.Create( "DLabel", GeneralSettingsM )
	InfoTimeSettings:SetPos( 335, 185 )
	InfoTimeSettings:SetSize(100, 18)
	InfoTimeSettings:SetTextColor(Color(0,0,0))
	InfoTimeSettings:SetText( "Hours | Mins" )

	local InfoTimeSettingsStart = vgui.Create( "DLabel", GeneralSettingsM )
	InfoTimeSettingsStart:SetPos( 420, 205 )
	InfoTimeSettingsStart:SetSize(100, 18)
	InfoTimeSettingsStart:SetTextColor(Color(0,0,0))
	InfoTimeSettingsStart:SetFont("HUDLARGEMEDIUM")
	InfoTimeSettingsStart:SetText( "Start time" )

	local InfoTimeSettingsStop = vgui.Create( "DLabel", GeneralSettingsM )
	InfoTimeSettingsStop:SetPos( 420, 240 )
	InfoTimeSettingsStop:SetSize(100, 18)
	InfoTimeSettingsStop:SetTextColor(Color(0,0,0))
	InfoTimeSettingsStop:SetFont("HUDLARGEMEDIUM")
	InfoTimeSettingsStop:SetText( "Stop time" )

	local FirstHourSelector = vgui.Create( "DComboBox" , GeneralSettingsM )
	FirstHourSelector:SetPos( 320, 205 )
	FirstHourSelector:SetSize( 45, 20 )
	FirstHourSelector:SetValue( "Hours" )
	FirstHourSelector:SetSkin("NNT-AntiAFK")
	local hours = 23
	for i = 0 , hours do
		FirstHourSelector:AddChoice(i)
	end
	FirstHourSelector:SetSortItems(false)

	local FirstMinutesSelector = vgui.Create( "DComboBox" , GeneralSettingsM )
	FirstMinutesSelector:SetPos( 370, 205 )
	FirstMinutesSelector:SetSize( 45, 20 )
	FirstMinutesSelector:SetValue( "Mins" )
	FirstMinutesSelector:SetSkin("NNT-AntiAFK")
	local minutes = 59
	for i = 0 , minutes do
		FirstMinutesSelector:AddChoice(i)
	end
	FirstMinutesSelector:SetSortItems(false)



	local SecondHourSelector = vgui.Create( "DComboBox" , GeneralSettingsM )
	SecondHourSelector:SetPos( 320, 240 )
	SecondHourSelector:SetSize( 45, 20 )
	SecondHourSelector:SetValue( "Hours" )
	SecondHourSelector:SetSkin("NNT-AntiAFK")
	for i = 0 , hours do
		SecondHourSelector:AddChoice(i)
	end
	SecondHourSelector:SetSortItems(false)

	local SecondMinutesSelector = vgui.Create( "DComboBox" , GeneralSettingsM )
	SecondMinutesSelector:SetPos( 370, 240 )
	SecondMinutesSelector:SetSize( 45, 20 )
	SecondMinutesSelector:SetValue( "Mins" )
	SecondMinutesSelector:SetSkin("NNT-AntiAFK")
	for i = 1 , minutes do
		SecondMinutesSelector:AddChoice(i)
	end
	SecondMinutesSelector:SetSortItems(false)


	local AFKSETHOURs_btn = vgui.Create("DButton")
	AFKSETHOURs_btn:SetParent( GeneralSettingsM )
	AFKSETHOURs_btn:SetText( "APPLY CHANGE" )
	AFKSETHOURs_btn:SetPos( 317, 275)
	AFKSETHOURs_btn:SetSize( 100, 20 )
	AFKSETHOURs_btn:SetFont("DermaDefaultBold")
    AFKSETHOURs_btn:SetColor(Color(255, 255, 255))
	AFKSETHOURs_btn:SetSkin("NNT-AntiAFK")


	AFKSETHOURs_btn.DoClick = function ()
		surface.PlaySound( "garrysmod/ui_click.wav")
		local FirstHours 		= 	FirstHourSelector:GetSelected()
		local FirstMinutes 		= 	FirstMinutesSelector:GetSelected()

		local SecondHours 		=  	SecondHourSelector:GetSelected()
		local SecondMinutes	 	= 	SecondMinutesSelector:GetSelected()
		net.Start("nnt-antiak-settings")
			local temptable = {
				["StartHours"] =   FirstHours,
				["StartMinutes"] =  FirstMinutes,
				["StopHours"] =  SecondHours,
				["StopMinutes"] =  SecondMinutes
			}
			net.WriteTable(temptable)
			net.WriteString("SetSettings")
        net.SendToServer()
	end



	local JobSelection = vgui.Create( "DComboBox" , GeneralSettingsM )
	JobSelection:SetPos( 25, 239 )
	JobSelection:SetSize( 130, 20 )
	JobSelection:SetValue( "Select!" )
	JobSelection:SetTextColor(Color(255,255,255,255))
	JobSelection:SetSkin("NNT-AntiAFK")
	for k in pairs(team.GetAllTeams()) do
		JobSelection:AddChoice(team.GetName(k))
	end
	JobSelection.OnSelect = function( a, b, value )
		for k,v in pairs(team.GetAllTeams()) do
			if k == nil then print("NO JOB") return end
			if team.GetName(k) == value then
				JobSelected = team.GetName(k)
			end
		end
	end

	local JobSelection_btn = vgui.Create("DButton")
	JobSelection_btn:SetParent( GeneralSettingsM )
	JobSelection_btn:SetText( "APPLY JOB" )
	JobSelection_btn:SetPos( 37, 295)
	JobSelection_btn:SetSize( 100, 20 )
	JobSelection_btn:SetFont("DermaDefaultBold")
    JobSelection_btn:SetColor(Color(255, 255, 255))
	JobSelection_btn:SetSkin("NNT-AntiAFK")
	local function checkifjobByNameExist(name)
		jobname = nil
		for k in pairs(team.GetAllTeams()) do
			if k == nil then print("NO JOB") return end
			if team.GetName(k) == name then
				jobname = name
				return true
			end
		end
		if jobname == nil then return false end
	end

	JobSelection_btn.DoClick = function ()
		surface.PlaySound( "garrysmod/ui_click.wav")
		if checkifjobByNameExist(JobSelected) then
			net.Start("nnt-antiak-settings")
				local temptable = {["JOBNAME"] = JobSelected }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
        	net.SendToServer()
		else
			LocalPlayer():ChatPrint("[ANTI-AFK] Job does not exist !")
		end
	end


	local Sign = vgui.Create( "DLabel", NNT_ANTI_MainPanel )
	Sign:SetPos( 10, 375 )
	Sign:SetSize(150 , 25)
	Sign:SetColor(Color(0,0,0))
	Sign:SetText( "Made by Aiko Suzuki !" )

	net.Start("nnt-antiak-settings")
		net.WriteTable({"Pleasedata"})
		net.WriteString("LoadData")
	net.SendToServer()
	net.Receive("nnt-antiak-settings", function()
		local data5 = net.ReadString()
		local data4 = net.ReadTable()
		if data5 == "LoadData" then
			print("Loading DATA")
			for k,v in pairs(data4) do
				if k == "AFK_WARN_TIME" then
					AFK_WARN_TIME = v
					WarnSliderSelect:SetValue(tonumber(v,10) / 60)
				elseif k == "AFK_TIME" then
					AFK_TIME = v
					 KickSliderSelect:SetValue(tonumber(v,10) / 60)
				elseif k == "AFK_ADMINBYPASS" then
					AFK_ADMINBYPASS = v
					if AFK_ADMINBYPASS == true then
						NNTCheckBoxGroupsBypass:SetValue( 1 )
					end
				elseif k == "AFK_ADMINUBYPASS" then
					AFK_ADMINUBYPASS = v
					if AFK_ADMINUBYPASS == true then
						NNTCheckBoxUsersBypass:SetValue( 1 )
					end
				elseif k == "AFK_ENABLE" then
					AFK_ENABLE = v
					if AFK_ENABLE == true then
						NNTCheckBoxActivateAFK :SetValue( 1 )
					end
				elseif k == "AFK_GHOST" then
					AFK_GHOST = v
					if AFK_GHOST == true then
						NNTCheckBoxGhostMode:SetValue( 1 )
					end
				elseif k == "AFK_DARKRPMONEY" then
					AFK_DARKRPMONEY = v
					if AFK_DARKRPMONEY == true then
						NNTCheckBoxFreezeSalary:SetValue( 1 )
					end
				elseif k == "AFK_LANGUAGE" then
					AFK_LANGUAGE = v
					AntiAfkLanguage = AFK_LANGUAGE
					AntiAFKSelectedLanguages = AFK_LANGUAGE
					ServerConfigLanguages:SetText( "Languages : " .. AntiAfkTranslate[AFK_LANGUAGE]["NAME"] )
				elseif k == "AFK_THEME" then
					AFK_THEME = v
					AntiAfkSelTheme = AFK_THEME
					AntiAFKSelectedTheme = AFK_THEME
					ServerConfigThemes:SetText( "Theme : "..AFK_THEME )
				elseif k == "AFK_GODMODE" then
					AFK_GODMODE = v
					if AFK_GODMODE then
						NNTCheckBoxGodMode:SetValue( 1 )
					end
				elseif k == "AFK_JOBNAME" then
					AFK_JOBNAME = v
					if AFK_JOBNAME then
						JobSelection:SetValue(AFK_JOBNAME)
						JobSelected = AFK_JOBNAME
					end
				elseif k == "AFK_JOBENABLE" then
					AFK_JOBENABLE = v
					if AFK_JOBENABLE then
						NNTCheckBoxJobChange:SetValue( 1 )
					end
				elseif k == "AFK_ENABLETIME" then
					AFK_ENABLETIME = v
					if AFK_ENABLETIME then
						NNTCheckBoxEnableTime:SetValue( 1 )
					end
				elseif k == "AFK_StartTimeHours" then
					AFK_StartTimeHours = v
					if AFK_StartTimeHours then
						FirstHourSelector:SetValue( AFK_StartTimeHours )
					end
				elseif k == "AFK_StartTimeMinutes" then
					AFK_StartTimeMinutes = v
					if AFK_StartTimeMinutes then
						FirstMinutesSelector:SetValue( AFK_StartTimeMinutes )
					end
				elseif k == "AFK_StopTimeHours" then
					AFK_StopTimeHours = v
					if AFK_StopTimeHours then
						SecondHourSelector:SetValue( AFK_StopTimeHours )
					end
				elseif k == "AFK_StopTimeMinutes" then
					AFK_StopTimeMinutes = v
					if AFK_StopTimeMinutes then
						SecondMinutesSelector:SetValue( AFK_StopTimeMinutes )
					end
				elseif k == "AFK_JOBREVERT" then
					AFK_JOBREVERT = v
					if AFK_JOBREVERT == true then
						NNTCheckBoxJOBREVERT:SetValue( 1 )
					end
				end
			end
		elseif data5 == "Settings" then -- to load separate data
        	for k,v in pairs(data4) do
				if k == "WARN" then
					WarnSliderSelect:SetValue(tonumber(v,10) / 60)
				elseif k == "KICK" then
					KickSliderSelect:SetValue(tonumber(v,10)/60)
				elseif k == "THEME" then
					AFK_THEME = v
					AntiAfkSelTheme = AFK_THEME
					ServerConfigThemes:SetText( "Theme : "..AFK_THEME )
				end
			end
		end

	end)

	local ApplyThemesAndLanguages = vgui.Create("DButton")
	ApplyThemesAndLanguages:SetParent( LanguagesAndThemes )
	ApplyThemesAndLanguages:SetText( "APPLY THEMES AND LANGUAGES" )
	ApplyThemesAndLanguages:SetPos( 110, 240)
	ApplyThemesAndLanguages:SetSize( 250, 20 )
	ApplyThemesAndLanguages:SetFont("DermaDefaultBold")
    ApplyThemesAndLanguages:SetColor(Color(255, 255, 255))
	ApplyThemesAndLanguages:SetSkin("NNT-AntiAFK")

	ApplyThemesAndLanguages.DoClick = function ()
			surface.PlaySound( "garrysmod/ui_click.wav")
			net.Start("nnt-antiak-settings")
				local temptable = {["THEME"] = AntiAFKSelectedTheme }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
			net.Start("nnt-antiak-settings")
					local temptable = {["LANGUAGE"] = AntiAFKSelectedLanguages }
					net.WriteTable(temptable)
					net.WriteString("SetSettings")
            net.SendToServer()

	end


	local PreviewThemes = vgui.Create("DButton")
	PreviewThemes:SetParent( LanguagesAndThemes )
	PreviewThemes:SetText( "PREVIEW THEMES AND LANGUAGES" )
	PreviewThemes:SetPos( 110, 280)
	PreviewThemes:SetSize( 250, 20 )
	PreviewThemes:SetFont("DermaDefaultBold")
    PreviewThemes:SetColor(Color(255, 255, 255))
	PreviewThemes:SetSkin("NNT-AntiAFK")


	PreviewThemes.DoClick = function ()
			local oldtranslation = AntiAfkLanguage
			local NewTranslation = AntiAFKSelectedLanguages
			AntiAfkLanguage = NewTranslation
			NNTAntiafkThemes[AntiAFKSelectedTheme]()
			local PreviewThemesPanel = vgui.Create( "DFrame" )
			PreviewThemesPanel:SetPos( w-100, h-300 )
			PreviewThemesPanel:SetSize( 120, 70 )
			PreviewThemesPanel:SetTitle( "" )
			PreviewThemesPanel:SetDraggable( false )
			PreviewThemesPanel:ShowCloseButton( false )
			PreviewThemesPanel:MakePopup()
			PreviewThemesPanel:SetSkin("NNT-AntiAFK")

			local PreviewThemesButton = vgui.Create("DButton")
			PreviewThemesButton:SetParent( PreviewThemesPanel )
			PreviewThemesButton:SetText( "Close" )
			PreviewThemesButton:SetPos( 25, 35)
			PreviewThemesButton:SetSize( 50, 25 )
			PreviewThemesButton:SetFont("DermaDefaultBold")
    		PreviewThemesButton:SetColor(Color(255, 255, 255))
			PreviewThemesButton:SetSkin("NNT-AntiAFK")
			PreviewThemesButton.DoClick = function ()
				timer.Destroy("AFK:"..LocalPlayer():SteamID())
				timer.Destroy("AFKS:"..LocalPlayer():SteamID())
				AfkPanelHUD:Close()
				PreviewThemesPanel:Close()
				AntiAfkLanguage = oldtranslation
				NNT_ANTI_MainPanel:Show()
			end

		NNT_ANTI_MainPanel:Hide()
	end



--[[
 /$$   /$$  /$$$$$$  /$$$$$$$$ /$$$$$$$   /$$$$$$        /$$      /$$ /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$$$  /$$       /$$$$$$  /$$$$$$  /$$$$$$$$
| $$  | $$ /$$__  $$| $$_____/| $$__  $$ /$$__  $$      | $$  /$ | $$| $$  | $$|_  $$_/|__  $$__/| $$_____/ | $$      |_  $$_/ /$$__  $$|__  $$__/
| $$  | $$| $$  \__/| $$      | $$  \ $$| $$  \__/      | $$ /$$$| $$| $$  | $$  | $$     | $$   | $$       | $$        | $$  | $$  \__/   | $$
| $$  | $$|  $$$$$$ | $$$$$   | $$$$$$$/|  $$$$$$       | $$/$$ $$ $$| $$$$$$$$  | $$     | $$   | $$$$$    | $$        | $$  |  $$$$$$    | $$
| $$  | $$ \____  $$| $$__/   | $$__  $$ \____  $$      | $$$$_  $$$$| $$__  $$  | $$     | $$   | $$__/    | $$        | $$   \____  $$   | $$
| $$  | $$ /$$  \ $$| $$      | $$  \ $$ /$$  \ $$      | $$$/ \  $$$| $$  | $$  | $$     | $$   | $$       | $$        | $$   /$$  \ $$   | $$
|  $$$$$$/|  $$$$$$/| $$$$$$$$| $$  | $$|  $$$$$$/      | $$/   \  $$| $$  | $$ /$$$$$$   | $$   | $$$$$$$$ | $$$$$$$$ /$$$$$$|  $$$$$$/   | $$
 \______/  \______/ |________/|__/  |__/ \______/       |__/     \__/|__/  |__/|______/   |__/   |________/ |________/|______/ \______/    |__/

 /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
| $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$      | $$  | $$| $$\  $$$| $$      | $$
| $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/      |__/  |__/|__/  \__/|________/|________/
]]


	local AdminPanelUsers_view = vgui.Create("DListView")
	AdminPanelUsers_view:SetParent(WhitelistS)
	AdminPanelUsers_view:SetPos(10, 30)
	AdminPanelUsers_view:SetSize(225, 200)
	AdminPanelUsers_view:SetMultiSelect(false)
	--AdminPanelUsers_view.OnClickLine = function(parent,selected,isselected) print(selected:GetValue(1)) end
	AdminPanelUsers_view.OnRowSelected = function(parent,selected,isselected) print(isselected:GetValue(1))
			tauser = isselected:GetValue(1)
	end
	AdminPanelUsers_view:AddColumn("SteamID")
	AdminPanelUsers_view:AddColumn("Name")
	AdminPanelUsers_view:SetSortable(true)
	AdminPanelUsers_view:SetSkin("Default")

	local UserList = vgui.Create( "DComboBox" , WhitelistS )
	UserList:SetPos( 55, 240 )
	UserList:SetSize( 130, 20 )
	UserList:SetValue( "Select!" )

		net.Start("AntiAfkloaBypassUsers")
		net.SendToServer()
		net.Receive("AntiAfksenBypassUsers", function(len)
			AdminPanelUsers_view:Clear()
			antiuserstring = net.ReadTable()
			for k,v in pairs(antiuserstring) do
				if !IsValid(player.GetBySteamID(v)) then
					local plyname = v
					AdminPanelUsers_view:AddLine(k,plyname)
				else
					local plyname = v
					AdminPanelUsers_view:AddLine(k,plyname)
				end
			end
			UserList:Clear()
			for k, v in pairs( player.GetAll() ) do
				if !antiuserstring[v:SteamID()] then
					UserList:AddChoice( v:Nick() )
				end
			end
		end)



	UserList.OnSelect = function( a, b, value )
		for k,v in pairs(player.GetAll()) do
			if v == nil then print("NO PLAYER") return end
			if v:Nick() == value then
				SelectedPlayeris = v
			end
		end
	end


	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( WhitelistS )
	addgroups:SetText( "Add User" )
	addgroups:SetPos( 135, 270)
	addgroups:SetSize( 100, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups:SetSkin("NNT-AntiAFK")
	addgroups.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		if SelectedPlayeris == nil then print("NO PLAYER") return end
		if string.StartWith(SelectedPlayeris:SteamID() , " " ) then
			LocalPlayer():ChatPrint('You cannot add a user starting with a space !')
		return end
		if SelectedPlayeris:SteamID() == "" then
			LocalPlayer():ChatPrint('You cannot add a empty user !')
		return end
		if antiuserstring[SelectedPlayeris:SteamID()] then
			LocalPlayer():ChatPrint('User ' .. SelectedPlayeris:Nick() ..' is already there !')
		return end
		net.Start("AntiAddBypassUsers")
			net.WriteString(SelectedPlayeris:SteamID())
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( WhitelistS )
	delbutton:SetText( "Del User" )
	delbutton:SetPos( 10, 270)
	delbutton:SetSize( 100, 25 )
	delbutton:SetSkin("NNT-AntiAFK")
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		net.Start("AntiRemBypassUsers")
			net.WriteString(tauser)
		net.SendToServer()
	end

--[[
  /$$$$$$  /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$   /$$$$$$        /$$      /$$ /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$$$ /$$       /$$$$$$  /$$$$$$  /$$$$$$$$
 /$$__  $$| $$__  $$ /$$__  $$| $$  | $$| $$__  $$ /$$__  $$      | $$  /$ | $$| $$  | $$|_  $$_/|__  $$__/| $$_____/| $$      |_  $$_/ /$$__  $$|__  $$__/
| $$  \__/| $$  \ $$| $$  \ $$| $$  | $$| $$  \ $$| $$  \__/      | $$ /$$$| $$| $$  | $$  | $$     | $$   | $$      | $$        | $$  | $$  \__/   | $$
| $$ /$$$$| $$$$$$$/| $$  | $$| $$  | $$| $$$$$$$/|  $$$$$$       | $$/$$ $$ $$| $$$$$$$$  | $$     | $$   | $$$$$   | $$        | $$  |  $$$$$$    | $$
| $$|_  $$| $$__  $$| $$  | $$| $$  | $$| $$____/  \____  $$      | $$$$_  $$$$| $$__  $$  | $$     | $$   | $$__/   | $$        | $$   \____  $$   | $$
| $$  \ $$| $$  \ $$| $$  | $$| $$  | $$| $$       /$$  \ $$      | $$$/ \  $$$| $$  | $$  | $$     | $$   | $$      | $$        | $$   /$$  \ $$   | $$
|  $$$$$$/| $$  | $$|  $$$$$$/|  $$$$$$/| $$      |  $$$$$$/      | $$/   \  $$| $$  | $$ /$$$$$$   | $$   | $$$$$$$$| $$$$$$$$ /$$$$$$|  $$$$$$/   | $$
 \______/ |__/  |__/ \______/  \______/ |__/       \______/       |__/     \__/|__/  |__/|______/   |__/   |________/|________/|______/ \______/    |__/

 /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
| $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$      | $$  | $$| $$\  $$$| $$      | $$
| $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/      |__/  |__/|__/  \__/|________/|________/
]]

	local AdminPanelGroups_view = vgui.Create("DListView")
	AdminPanelGroups_view:SetParent(WhitelistS)
	AdminPanelGroups_view:SetPos(250, 30)
	AdminPanelGroups_view:SetSize(225, 200)
	AdminPanelGroups_view:SetMultiSelect(false)
	AdminPanelGroups_view.OnRowSelected = function( panel, rowIndex, row )
			tagroups = row:GetValue(1)
	end
	AdminPanelGroups_view:AddColumn("Groups")
	AdminPanelGroups_view:SetSortable(true)
	AdminPanelGroups_view:SetSkin("Default")
	if ulx then
		local GroupList = vgui.Create( "DComboBox" , WhitelistS )
		GroupList:SetPos( 300, 240 )
		GroupList:SetSize( 130, 20 )
		GroupList:SetValue( "Select a group" )


		net.Start("AntiAfkloaBypassGroups")
		net.SendToServer()
		net.Receive("AntiAfksenBypassGroups", function(len)
			AdminPanelGroups_view:Clear()
			antiusergroupsstring = net.ReadTable()
			for k,v in pairs(antiusergroupsstring) do
				AdminPanelGroups_view:AddLine(v)
			end
			GroupList:Clear()
			for k, v in pairs( ulx.group_names ) do
				if !(table.HasValue(antiusergroupsstring, v)) then
					GroupList:AddChoice( v )
				end
			end
		end)


		GroupList.OnSelect = function( a, b, value )
			SelectedGroups = value

		end
	else
		net.Start("AntiAfkloaBypassGroups")
		net.SendToServer()
		net.Receive("AntiAfksenBypassGroups", function(len)
			AdminPanelGroups_view:Clear()
			antiusergroupsstring = net.ReadTable()
			for k,v in pairs(antiusergroupsstring) do
				AdminPanelGroups_view:AddLine(v)
			end
		end)
		local GroupList = vgui.Create( "DTextEntry", WhitelistS ) -- create the form as a child of frame
		GroupList:SetPos( 125, 244 )
		GroupList:SetSize( 130, 20 )
		GroupList:SetText( "Enter group name" )
		GroupList.OnChange = function( self )
			SelectedGroups = GroupList:GetValue()	-- print the form's text as server text
		end
	end


	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( WhitelistS )
	addgroups:SetText( "Add Groups" )
	addgroups:SetPos( 375, 270)
	addgroups:SetSize( 100, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups:SetSkin("NNT-AntiAFK")
	addgroups.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		if SelectedGroups == "" or SelectedGroups == nil then
			LocalPlayer():ChatPrint('You cannot add a empty group !')
		return end
		if string.StartWith(SelectedGroups , " " ) then
			LocalPlayer():ChatPrint('You cannot add group starting with a space !')
		return end
		if table.HasValue(antiusergroupsstring, SelectedGroups) then
			LocalPlayer():ChatPrint('User group ' .. SelectedGroups ..' is already there !')
		return end
		net.Start("AntiAddBypassGroups")
			net.WriteString(SelectedGroups)
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( WhitelistS )
	delbutton:SetText( "Del Groups" )
	delbutton:SetPos( 250, 270)
	delbutton:SetSize( 100, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton:SetSkin("NNT-AntiAFK")
	delbutton.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		net.Start("AntiRemBypassGroups")
			net.WriteString(tagroups)
		net.SendToServer()
	end

--[[
  /$$$$$$  /$$$$$$$$ /$$$$$$$$        /$$$$$$  /$$$$$$$$ /$$   /$$       /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
 /$$__  $$| $$_____/|__  $$__/       /$$__  $$| $$_____/| $$  /$$/      | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \__/| $$         | $$         | $$  \ $$| $$      | $$ /$$/       | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
|  $$$$$$ | $$$$$      | $$         | $$$$$$$$| $$$$$   | $$$$$/        | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
 \____  $$| $$__/      | $$         | $$__  $$| $$__/   | $$  $$        | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
 /$$  \ $$| $$         | $$         | $$  | $$| $$      | $$\  $$       | $$      | $$  | $$| $$\  $$$| $$      | $$
|  $$$$$$/| $$$$$$$$   | $$         | $$  | $$| $$      | $$ \  $$      | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
 \______/ |________/   |__/         |__/  |__/|__/      |__/  \__/      |__/      |__/  |__/|__/  \__/|________/|________/
]]


	local list_view = vgui.Create("DListView")
	list_view:SetParent(SetAFKMenu)
	list_view:SetPos(5, 30)
	list_view:SetSize(475, 175)
	list_view:SetMultiSelect(false)
	list_view.OnRowSelected = function( panel, rowIndex, row )
			taplayer = row:GetValue(2)
	end
	list_view:SetSkin("Default")
	list_view:AddColumn("Player") -- Add columnfor k,v inpairs(player.GetAll()) do
	list_view:AddColumn("SteamID")
	for k,v in pairs(player.GetAll()) do
    	list_view:AddLine(v:Nick(), v:SteamID()) -- Add lines
	end
	local InfoSetPlayerAFK= vgui.Create( "DLabel", SetAFKMenu )
	InfoSetPlayerAFK:SetPos( 115, 215)
	InfoSetPlayerAFK:SetSize(300, 18)
	InfoSetPlayerAFK:SetTextColor(Color(0,0,0))
	InfoSetPlayerAFK:SetFont("HUDLARGESMALL")
	InfoSetPlayerAFK:SetText( "In how much time the player will get kick [Minutes]" )

	local SetPlayerAFKSliderSelect = vgui.Create( "DNumSlider" , SetAFKMenu)
    SetPlayerAFKSliderSelect:SetPos( -33, 250 )
    SetPlayerAFKSliderSelect:SetSize( 425, 20 )
	//SetPlayerAFKSliderSelect:SetText( "Kick Time [Minutes]" )
    SetPlayerAFKSliderSelect:SetMin( 2 )
	SetPlayerAFKSliderSelect:SetMax(30)
	SetPlayerAFKSliderSelect:SetDecimals(0)
	SetPlayerAFKSliderSelect:SetValue(5)
	SetPlayerAFKSliderSelect:SetSkin("NNT-AntiAFK")



	local list_btn = vgui.Create("DButton")
	list_btn:SetParent( SetAFKMenu )
	list_btn:SetText( "APPLY" )
	list_btn:SetPos( 170, 285)
	list_btn:SetSize( 150, 25 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn:SetSkin("NNT-AntiAFK")
	list_btn.DoClick = function ()
			surface.PlaySound( "garrysmod/ui_click.wav")
			LocalPlayer():ConCommand( 'setafkplayer "' .. taplayer ..'" ' .. math.Round(SetPlayerAFKSliderSelect:GetValue()) * 60  )
	end

	if data == "setafk" then
		WindowSelect:SwitchToName("Set Player")
	end

end

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

net.Receive("AntiAfkSendHUDInfo", function()
	local data1 = net.ReadString()
	if (data1 == "AntiafkAdminSetAfk") then
		NNTAntiafkAdminPanel("setafk")
	elseif (data1 == "AntiafkMainHUD") then
		NNTAntiafkThemes[AntiAfkSelTheme]()
	elseif (data1 == "AntiafkMainHUDSP") then
		NNTAntiafkMainHUDSP()
	elseif (data1 == "AntiafkAdminPanel") then
		NNTAntiafkAdminPanel()
	elseif table.HasValue(NNTAntiafkThemes, data1) then
		AntiAfkSelTheme = data1
		print("ANTIAFK: THEMES SELECTED : " .. AntiAfkSelTheme)
	elseif table.HasValue(AntiAfkDisponibleLang, data1) then
		AntiAfkLanguage = data1
		print("ANTIAFK: LANGUAGE SETTINGS RECEIVED : " .. AntiAfkLanguage)
	elseif (data1 == "AccessDeniedError") then
		notification.AddLegacy( "[NNT] ANTI-AFK : Access Denied !", NOTIFY_ERROR, 3 )
		surface.PlaySound("buttons/button18.wav")
		surface.PlaySound("buttons/button18.wav")
	end
end)
net.Receive("BroadcastAFKPLAYER", function()
	local data2 = net.ReadTable()
	if data2["AFKSTATE"] == true then
		afktext = AntiAfkTranslate[AntiAfkLanguage]["NOWAFK"]
		afkcolor = Color( 198, 0, 0 )
	elseif data2["AFKSTATE"] == false then
		afktext = AntiAfkTranslate[AntiAfkLanguage]["NOLONGERAFK"]
		afkcolor = Color( 0, 0, 198 )
	end
	chat.AddText( Color( 255, 255, 255 ), "[ANTI-AFK]: ",Color( 0, 198, 0 ),data2["PlayerName"],afkcolor, " ", afktext)
end)
net.Receive("nnt-antiak-settings", function()
	local data5 = net.ReadString()
	local data4 = net.ReadTable()
	if data5 == "LoadAFKTime" then
		print("Loading DATA")
		for k,v in pairs(data4) do
			if k == "AFK_TIME" then
				AFK_TIME = v
			end
		end
	end
end)