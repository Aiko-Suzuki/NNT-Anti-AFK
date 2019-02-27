--[[
 /$$$$$$$$ /$$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$  /$$        /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$  /$$   /$$
|__  $$__/| $$__  $$ /$$__  $$| $$$ | $$ /$$__  $$| $$       /$$__  $$|__  $$__/|_  $$_/ /$$__  $$| $$$ | $$
   | $$   | $$  \ $$| $$  \ $$| $$$$| $$| $$  \__/| $$      | $$  \ $$   | $$     | $$  | $$  \ $$| $$$$| $$
   | $$   | $$$$$$$/| $$$$$$$$| $$ $$ $$|  $$$$$$ | $$      | $$$$$$$$   | $$     | $$  | $$  | $$| $$ $$ $$
   | $$   | $$__  $$| $$__  $$| $$  $$$$ \____  $$| $$      | $$__  $$   | $$     | $$  | $$  | $$| $$  $$$$
   | $$   | $$  \ $$| $$  | $$| $$\  $$$ /$$  \ $$| $$      | $$  | $$   | $$     | $$  | $$  | $$| $$\  $$$
   | $$   | $$  | $$| $$  | $$| $$ \  $$|  $$$$$$/| $$$$$$$$| $$  | $$   | $$    /$$$$$$|  $$$$$$/| $$ \  $$
   |__/   |__/  |__/|__/  |__/|__/  \__/ \______/ |________/|__/  |__/   |__/   |______/ \______/ |__/  \__/
]]


AntiAfkLanguage = "EN"
AntiAfkSelTheme = "Large"


AntiAfkTranslate = AntiAfkTranslate or {}
AntiAfkDisponibleLang = {}
for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
	include("lang/" .. v)
    print("Loaded Language: " ..v )
end

for k,v in pairs(AntiAfkTranslate) do
	table.insert(AntiAfkDisponibleLang, table.Count(AntiAfkDisponibleLang) + 1,k)
end


NNTAntiafkThemes = NNTAntiafkThemes or {}
AntiAfkDisponibleThemes = {}
for k,v in pairs((file.Find("nnt-antiafk/themes/*.lua","LUA"))) do
	include("themes/" .. v)
    print("Loading Themes:  " ..v )
end

for k,v in pairs(NNTAntiafkThemes) do
	table.ForceInsert(AntiAfkDisponibleThemes, k)
	--table.insert(AntiAfkDisponibleThemes, table.Count(NNTAntiafkThemes) + 1,k)
    print("Themes working: " .. k)
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
function NNTAntiafkAdminPanel(data)


    local w = ScrW() / 2
    local h = ScrH() / 2
    PanelOff = nil
    SomeShittyTest = "undefined"
    SomeShittyTest1 = "undefined"
	SomeShittyTest2 = "undefined"
	SomeShittyTest3 = "undefined"


	local MainPanel = vgui.Create( "DFrame" )
	MainPanel:SetPos( w-200, h-150 )
	MainPanel:SetSize( 400, 300 )
	MainPanel:SetTitle( "" )
	MainPanel:SetDraggable( false )
	MainPanel:ShowCloseButton( false )
	MainPanel:MakePopup()

	function MainPanel:Paint(w, h)
		Derma_DrawBackgroundBlur(MainPanel,1)
		draw.RoundedBox( 10, 0, 0, w, h,  Color(0, 0, 0, 225))
		draw.DrawText("ANTI-AFK PANEL", "Trebuchet24",200, 0,Color( 255, 0, 0, 255 ),TEXT_ALIGN_CENTER)
	end



	local GeneralSettingsM = vgui.Create( "DFrame" , MainPanel)
	GeneralSettingsM:SetPos( 0, 20 )
	GeneralSettingsM:SetSize( 200, 120 )
	GeneralSettingsM:SetTitle( "" )
	GeneralSettingsM:SetDraggable( false )
	GeneralSettingsM:ShowCloseButton( false )
	function GeneralSettingsM:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["GENSETTINGS"], "HudHintTextLarge",100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end
	local WhitelistS = vgui.Create( "DFrame" , MainPanel)
	WhitelistS:SetPos( 200, 20 )
	WhitelistS:SetSize( 200, 120 )
	WhitelistS:SetTitle( "" )
	WhitelistS:SetDraggable( false )
	WhitelistS:ShowCloseButton( false )
	function WhitelistS:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["GROUPSUSERSW"], "HudHintTextLarge", 100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end
	local ThemesMenu = vgui.Create( "DFrame" , MainPanel)
	ThemesMenu:SetPos( 200, 140 )
	ThemesMenu:SetSize( 200, 70 )
	ThemesMenu:SetTitle( "" )
	ThemesMenu:SetDraggable( false )
	ThemesMenu:ShowCloseButton( false )
	function ThemesMenu:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["THEME"], "HudHintTextLarge", 100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end

	local LangMenu = vgui.Create( "DFrame" , MainPanel)
	LangMenu:SetPos( 200, 210 )
	LangMenu:SetSize( 200, 70 )
	LangMenu:SetTitle( "" )
	LangMenu:SetDraggable( false )
	LangMenu:ShowCloseButton( false )
	function LangMenu:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["LANGUAGESET"], "HudHintTextLarge", 100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end

	local TimeSettingMenu = vgui.Create( "DFrame" , MainPanel)
	TimeSettingMenu:SetPos( 0, 140 )
	TimeSettingMenu:SetSize( 200, 140 )
	TimeSettingMenu:SetTitle( "" )
	TimeSettingMenu:SetDraggable( false )
	TimeSettingMenu:ShowCloseButton( false )
	function TimeSettingMenu:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["TIMESSETTINGS"], "HudHintTextLarge", 100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end

	local SetAFKMenu = vgui.Create( "DFrame" , MainPanel)
	SetAFKMenu:SetPos( 0, 20 )
	SetAFKMenu:SetSize( 400, 300 )
	SetAFKMenu:SetTitle( "" )
	SetAFKMenu:SetDraggable( false )
	SetAFKMenu:ShowCloseButton( false )
	function SetAFKMenu:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText("Set Player AFK !", "HudHintTextLarge",200, 5,Color( 255, 255, 255, 255 ),TEXT_ALIGN_CENTER)
	end

	local UserWhiteListPanel = vgui.Create( "DFrame" , MainPanel)
	UserWhiteListPanel:SetPos( 0, 20 )
	UserWhiteListPanel:SetSize( 400, 300 )
	UserWhiteListPanel:SetTitle( "" )
	UserWhiteListPanel:SetDraggable( false )
	UserWhiteListPanel:ShowCloseButton( false )
	function UserWhiteListPanel:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText("User Whitelist !", "HudHintTextLarge",200, 5,Color( 255, 255, 255, 255 ),TEXT_ALIGN_CENTER)
	end

	local GroupsWhiteListPanel = vgui.Create( "DFrame" , MainPanel)
	GroupsWhiteListPanel:SetPos( 0, 20 )
	GroupsWhiteListPanel:SetSize( 400, 300 )
	GroupsWhiteListPanel:SetTitle( "" )
	GroupsWhiteListPanel:SetDraggable( false )
	GroupsWhiteListPanel:ShowCloseButton( false )
	function GroupsWhiteListPanel:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 10))
		draw.DrawText("Groups Whitelist !", "HudHintTextLarge",200, 5,Color( 255, 255, 255, 255 ),TEXT_ALIGN_CENTER)
	end
	SetAFKMenu:Hide()
	UserWhiteListPanel:Hide()
	GroupsWhiteListPanel:Hide()
	local ReturnBut  = vgui.Create( "DImageButton", MainPanel )
	ReturnBut:SetPos( 10, 10 )
	ReturnBut:SetSize( 32, 32 )
	ReturnBut:SetImage( "icon16/arrow_left.png" )
	ReturnBut.DoClick = function()
		if UserWhiteListPanel:IsVisible() then
			UserWhiteListPanel:Hide()
			GeneralSettingsM:Show()
			WhitelistS:Show()
			ThemesMenu:Show()
			LangMenu:Show()
			TimeSettingMenu:Show()
			ReturnBut:Hide()
		elseif GroupsWhiteListPanel:IsVisible() then
			GroupsWhiteListPanel:Hide()
			GeneralSettingsM:Show()
			WhitelistS:Show()
			ThemesMenu:Show()
			LangMenu:Show()
			TimeSettingMenu:Show()
			ReturnBut:Hide()
		elseif SetAFKMenu:IsVisible() then
			SetAFKMenu:Hide()
			GeneralSettingsM:Show()
			WhitelistS:Show()
			ThemesMenu:Show()
			LangMenu:Show()
			TimeSettingMenu:Show()
			ReturnBut:Hide()

		end
	end
	ReturnBut:Hide()
	local function NNTAntiafkAdminPanelOpen()
		GeneralSettingsM:Show()
		WhitelistS:Show()
		ThemesMenu:Show()
		LangMenu:Show()
		TimeSettingMenu:Show()
		ReturnBut:Hide()
	end
	local function NNTAntiafkAdminPanelHide()
		GeneralSettingsM:Hide()
		WhitelistS:Hide()
		ThemesMenu:Hide()
		LangMenu:Hide()
		TimeSettingMenu:Hide()
		ReturnBut:Show()
	end
	if data == "setafk" then
		NNTAntiafkAdminPanelHide()
		SetAFKMenu:Show()
	end
	local ExitBut = vgui.Create( "DImageButton", MainPanel )
	ExitBut:SetPos( 365, 10 )
	ExitBut:SetSize( 24, 24 )
	ExitBut:SetImage( "icon16/cross.png" )
	timer.Create("MoveExitButtoninfront",0.5,0, function()
		ExitBut:MoveToFront()
		ReturnBut:MoveToFront()
	end)
	ExitBut:MoveToFront()
	ExitBut.DoClick = function()
		MainPanel:Close()
		timer.Destroy("MoveExitButtoninfront")
	end


	local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( TimeSettingMenu )
    TextEntry:SetPos( 22, 24 )
    TextEntry:SetSize( 65, 25 )
    TextEntry:SetMin( 0 )
	TextEntry:SetMax(999999)
    function TextEntry:OnValueChanged( val )
	    -- print the form's text as server text
    end

    local TextEntry2 = vgui.Create( "DNumberWang")
    TextEntry2:SetParent( TimeSettingMenu )
    TextEntry2:SetPos( 120, 24 )
    TextEntry2:SetSize( 65, 25 )
    TextEntry2:SetMin( 0 )
	TextEntry2:SetMax(999999)
   	function TextEntry2:OnValueChanged( val )
	    	-- print the form's text as server text
    end


	local Users_btn = vgui.Create("DButton")
	Users_btn:SetParent( TimeSettingMenu )
	Users_btn:SetText( "Set AFK" )
	Users_btn:SetPos( 65, 100 )
	Users_btn:SetSize( 75, 30 )
	Users_btn:SetFont("Trebuchet18")
    Users_btn:SetColor(Color(255, 255, 255))
	Users_btn.Paint = function( self, w, h ) draw.RoundedBox( 15, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Users_btn.DoClick = function ()
		NNTAntiafkAdminPanelHide()
		SetAFKMenu:Show()
	end


	-- Groups Bypass
	local checkboxGroupsbypass = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxGroupsbypass:SetPos( 22,80 )
	checkboxGroupsbypass:SetText( "Groups Bypass" )

	function checkboxGroupsbypass:OnChange( val )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["BYPASS"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["BYPASS"] = false }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end


	-- User Bypass
	local checkboxUbypass = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxUbypass:SetPos( 22, 55 )
	checkboxUbypass:SetText( "User Bypass" )

	function checkboxUbypass:OnChange( val )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["UBYPASS"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["UBYPASS"] = false  }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end


	-- Anti AFK ENABLE
	local checkboxAntiAFK = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxAntiAFK:SetPos( 22, 30 )
	checkboxAntiAFK:SetText( "Activate AntiAFK" )

	function checkboxAntiAFK:OnChange( val )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["ANTIAFK"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["ANTIAFK"] = false }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end


	local SelectTheme = vgui.Create( "DComboBox", ThemesMenu )
	SelectTheme:SetPos( 65, 35 )
	SelectTheme:SetSize( 75, 20 )
	SelectTheme:SetValue( AntiAfkSelTheme )
	for k,v in pairs(AntiAfkDisponibleThemes) do
		SelectTheme:AddChoice(v)
	end
	SelectTheme.OnSelect = function( self, index, value )
		for k,v in pairs(AntiAfkDisponibleThemes) do
			if v == value then
					net.Start("nnt-antiak-settings")
						local temptable = {["THEME"] = v }
						net.WriteTable(temptable)
						net.WriteString("SetSettings")
            		net.SendToServer()
			end
		end
	end



	local SelectTranslate = vgui.Create( "DComboBox", LangMenu )
	SelectTranslate:SetPos( 65, 35 )
	SelectTranslate:SetSize( 75, 20 )
	SelectTranslate:SetValue( AntiAfkTranslate[AntiAfkLanguage]["NAME"] )
	for k,v in pairs(AntiAfkTranslate) do
	SelectTranslate:AddChoice(v["NAME"])
	end
	SelectTranslate.OnSelect = function( self, index, value )
		for k,v in pairs(AntiAfkTranslate) do
			if v["NAME"] == value then
					net.Start("nnt-antiak-settings")
						local temptable = {["LANGUAGE"] = k }
						net.WriteTable(temptable)
						net.WriteString("SetSettings")
            		net.SendToServer()
			end
		end
	end

    local list_btn = vgui.Create("DButton")
	list_btn:SetParent( TimeSettingMenu )
	list_btn:SetText( "SET KICK" )
	list_btn:SetPos( 18, 60)
	list_btn:SetSize( 70, 20 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 10, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn.DoClick = function ()
			if TextEntry:GetValue() >= 180 then
			net.Start("nnt-antiak-settings")
				local temptable = {["KICK"] = TextEntry:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
			else
				LocalPlayer():ChatPrint("[AFK] You need to enter a time above or equal to 180 in the kick time !")
			end
	end

    local list_btn2 = vgui.Create("DButton")
	list_btn2:SetParent( TimeSettingMenu )
	list_btn2:SetText( "SET WARN" )
	list_btn2:SetPos( 116, 60)
	list_btn2:SetSize( 70, 20 )
    list_btn2:SetColor(Color(255, 255, 255))
	list_btn2.Paint = function( self, w, h ) draw.RoundedBox( 10, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn2.DoClick = function ()
		if TextEntry2:GetValue() >= 30 then
            net.Start("nnt-antiak-settings")
				local temptable = {["WARN"] = TextEntry2:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
		LocalPlayer():ChatPrint("[AFK] You need to enter a time above or equal to 30 in the warn time !")
		end
	end


	local Groups_btn = vgui.Create("DButton")
	Groups_btn:SetParent( WhitelistS )
	Groups_btn:SetText( "Groups" )
	Groups_btn:SetPos( 65, 75 )
	Groups_btn:SetSize( 75, 30 )
	Groups_btn:SetFont("Trebuchet18")
    Groups_btn:SetColor(Color(255, 255, 255))
	Groups_btn.Paint = function( self, w, h ) draw.RoundedBox( 15, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Groups_btn.DoClick = function ()
		NNTAntiafkAdminPanelHide()
		GroupsWhiteListPanel:Show()
	end

	local Users_btn = vgui.Create("DButton")
	Users_btn:SetParent( WhitelistS )
	Users_btn:SetText( "Users" )
	Users_btn:SetPos( 65, 35 )
	Users_btn:SetSize( 75, 30 )
	Users_btn:SetFont("Trebuchet18")
    Users_btn:SetColor(Color(255, 255, 255))
	Users_btn.Paint = function( self, w, h ) draw.RoundedBox( 15, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Users_btn.DoClick = function ()
		NNTAntiafkAdminPanelHide()
		UserWhiteListPanel:Show()
	end

	local Sign = vgui.Create( "DLabel", MainPanel )
	Sign:SetPos( 20, 280 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )

	net.Start("nnt-antiak-settings")
		net.WriteTable({"Pleasedata"})
		net.WriteString("LoadData")
	net.SendToServer()
	net.Receive("nnt-antiak-settings", function()
		local data5 = net.ReadString()
		local data4 = net.ReadTable()
		if data5 == "LoadData" then -- load all data at once
			print("Loading DATA")
			for k,v in pairs(data4) do
				if k == "AFK_WARN_TIME" then
					AFK_WARN_TIME = v
					TextEntry2:SetValue(tonumber(v,10))
				elseif k == "AFK_TIME" then
					AFK_TIME = v
					 TextEntry:SetValue(tonumber(v,10))
				elseif k == "AFK_ADMINBYPASS" then
					AFK_ADMINBYPASS = v
					if AFK_ADMINBYPASS == true then
						checkboxGroupsbypass:SetValue( 1 )
					end
				elseif k == "AFK_ADMINUBYPASS" then
					AFK_ADMINUBYPASS = v
					if AFK_ADMINUBYPASS == true then
						checkboxUbypass:SetValue( 1 )
					end
				elseif k == "AFK_ENABLE" then --Activate AntiAFK
					AFK_ENABLE = v
					if AFK_ENABLE == true then
						checkboxAntiAFK:SetValue( 1 )
					end
				end
			end
		elseif data5 == "Settings" then -- to load separate data
        	for k,v in pairs(data4) do
				if k == "WARN" then
					TextEntry2:SetValue(tonumber(v,10))
				elseif k == "KICK" then
					TextEntry:SetValue(tonumber(v,10))
				end
			end
		end
	end)
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
	AdminPanelUsers_view:SetParent(UserWhiteListPanel)
	AdminPanelUsers_view:SetPos(25, 30)
	AdminPanelUsers_view:SetSize(350, 200)
	AdminPanelUsers_view:SetMultiSelect(false)
	--AdminPanelUsers_view.OnClickLine = function(parent,selected,isselected) print(selected:GetValue(1)) end
	AdminPanelUsers_view.OnRowSelected = function(parent,selected,isselected) print(isselected:GetValue(1))
			tauser = isselected:GetValue(1)
	end
	AdminPanelUsers_view:AddColumn("SteamID")
	AdminPanelUsers_view:AddColumn("Name")
	AdminPanelUsers_view:SetSortable(true)

	local UserList = vgui.Create( "DComboBox" , UserWhiteListPanel )
	UserList:SetPos( 135, 244 )
	UserList:SetSize( 130, 20 )
	UserList:SetValue( "Select Player !" )

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
			if v:Nick() == value then
				SelectedPlayeris = v
				print(SelectedPlayeris:SteamID())
			end
		end
	end


	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( UserWhiteListPanel )
	addgroups:SetText( "Add User" )
	addgroups:SetPos( 280, 240)
	addgroups:SetSize( 100, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
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
	delbutton:SetParent( UserWhiteListPanel )
	delbutton:SetText( "Del User" )
	delbutton:SetPos( 20, 240)
	delbutton:SetSize( 100, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
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
	AdminPanelGroups_view:SetParent(GroupsWhiteListPanel)
	AdminPanelGroups_view:SetPos(25, 30)
	AdminPanelGroups_view:SetSize(350, 200)
	AdminPanelGroups_view:SetMultiSelect(false)
	AdminPanelGroups_view.OnRowSelected = function( panel, rowIndex, row )
			tagroups = row:GetValue(1)
	end
	AdminPanelGroups_view:AddColumn("Groups")
	AdminPanelGroups_view:SetSortable(true)

	local GroupList = vgui.Create( "DComboBox" , GroupsWhiteListPanel )
	GroupList:SetPos( 135, 244 )
	GroupList:SetSize( 130, 20 )
	GroupList:SetValue( "Select Group !" )


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


	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( GroupsWhiteListPanel )
	addgroups:SetText( "Add Groups" )
	addgroups:SetPos( 280, 240)
	addgroups:SetSize( 100, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
		if string.StartWith(SelectedGroups , " " ) then
			LocalPlayer():ChatPrint('You cannot add group starting with a space !')
		return end
		if SelectedGroups == "" then
			LocalPlayer():ChatPrint('You cannot add a empty group !')
		return end
		if table.HasValue(antiusergroupsstring, SelectedGroups) then
			LocalPlayer():ChatPrint('User group ' .. SelectedGroups ..' is already there !')
		return end
		net.Start("AntiAddBypassGroups")
			net.WriteString(SelectedGroups)
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( GroupsWhiteListPanel )
	delbutton:SetText( "Del Groups" )
	delbutton:SetPos( 20, 240)
	delbutton:SetSize( 100, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
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
	list_view:SetPos(25, 30)
	list_view:SetSize(350, 175)
	list_view:SetMultiSelect(false)
	list_view.OnRowSelected = function( panel, rowIndex, row )
			taplayer = row:GetValue(2)
	end
	list_view:AddColumn("Player") -- Add columnfor k,v inpairs(player.GetAll()) do
	list_view:AddColumn("SteamID")
	for k,v in pairs(player.GetAll()) do
    	list_view:AddLine(v:Nick(), v:SteamID()) -- Add lines
	end

    local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( SetAFKMenu )
    TextEntry:SetPos( 165, 210 )
    TextEntry:SetSize( 75, 25 )
    TextEntry:SetMin( 180 )
    TextEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

	local list_btn = vgui.Create("DButton")
	list_btn:SetParent( SetAFKMenu )
	list_btn:SetText( "Set AFK" )
	list_btn:SetPos( 120, 240)
	list_btn:SetSize( 150, 25 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 10, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn.DoClick = function ()
			LocalPlayer():ConCommand( 'setafkplayer "' .. taplayer ..'" ' .. TextEntry:GetValue()  )
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
		RunString(NNTAntiafkThemes[AntiAfkSelTheme].."()","Load Warning")
	elseif (data1 == "AntiafkMainHUDSP") then
		NNTAntiafkMainHUDSP()
	elseif (data1 == "AntiafkAdminPanel") then
		NNTAntiafkAdminPanel()
	elseif (data1 == "AntiafkAdminPanelGroups") then
		NNTAntiafkAdminPanelGroups()
	elseif table.HasValue(AntiAfkDisponibleThemes, data1) then
		AntiAfkSelTheme = data1
		print("ANTIAFK: THEMES SELECTED " .. AntiAfkSelTheme)
	elseif table.HasValue(AntiAfkDisponibleLang, data1) then
		AntiAfkLanguage = data1
		print("ANTIAFK: LANGUAGE SETTINGS RECEIVED " .. AntiAfkLanguage)
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