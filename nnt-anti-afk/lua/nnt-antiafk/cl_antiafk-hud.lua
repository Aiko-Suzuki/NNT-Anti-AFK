AntiAfkLanguage = "EN"
AntiAfkSelTheme = "Large"




include("sh_nnt-antiafk.lua")
hook.Add( "Initialize", "NNT-AntiAFK-FinishLoading-Client", function()
	include("nnt-antiafk/cl_skin.lua")
end)


surface.CreateFont( "HUGETIME", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 50,
	weight = 800
} )

surface.CreateFont( "NNT-TITLE", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 20,
	weight = 500
} )

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


	local NNT_ANTI_MainPanel = vgui.Create( "nnt-main-frame" )
	NNT_ANTI_MainPanel:SetPos( w-250, h-200 )
	NNT_ANTI_MainPanel:SetSize( 500, 400 )
	NNT_ANTI_MainPanel:SetDraggable( true )
	NNT_ANTI_MainPanel:MakePopup()

	NNTNavPage = {}

	local function SetActivePage(panel,tb)
		for k,v in pairs(tb) do
			if v == panel then 
				v:SetVisible(true)
				v.NavBTN.Activated = true
			else 
				v:SetVisible(false) 
				v.NavBTN.Activated = false
			end
		end
	end
	
	local function NNTNavPageCreationMain(name,icon,vis)
		local Pos = table.Count(NNTNavPage)
		local Panel = vgui.Create("nnt-frame",NNT_ANTI_MainPanel)
		Panel:SetPos(100,31)
		Panel:SetSize(410,369)
		function Panel:Paint(w,h) 
			--draw.RoundedBox(0, 0, 0, w, h, Color(120,120,120,255)) 
		end

		Panel.NavBTN = vgui.Create("nnt-nav-btn", NNT_ANTI_MainPanel)
		Panel.NavBTN:SetText(name)
		Panel.NavBTN:SetImage( icon )
		Panel.NavBTN:SetPos( 0, 31 + (Pos * 27))
		Panel.NavBTN:SetSize(100,26)
		Panel.NavBTN:SetTextColor(Color(0,0,0,255))
		Panel.NavBTN.TextPos = 33
		Panel.NavBTN.DoClick = function()
			SetActivePage(Panel,NNTNavPage)
		end
		Panel.NavBTN.Activated = vis
		NNTNavPage[name] = Panel
		Panel:SetVisible(vis)

		return Panel

	end

	local GeneralSettingsM = NNTNavPageCreationMain("Settings","nnt-antiafk/option.png",true)

	local WhitelistU = NNTNavPageCreationMain("WL User's","nnt-antiafk/user.png",false)

	local WhitelistG = NNTNavPageCreationMain("WL Groups","nnt-antiafk/users.png",false)

	local SetAFKMenu = NNTNavPageCreationMain("Set AFK","nnt-antiafk/clock.png",false)

	local Themes = NNTNavPageCreationMain("Themes","nnt-antiafk/theme.png",false)

	local Languages = NNTNavPageCreationMain("Languages","nnt-antiafk/translate.png",false)


	

--[[
  /$$$$$$                                                   /$$        /$$$$$$              /$$     /$$     /$$     /$$                              
 /$$__  $$                                                 | $$       /$$__  $$            | $$    | $$    | $$    |__/                              
| $$  \__/  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$ | $$      | $$  \__/  /$$$$$$  /$$$$$$ /$$$$$$ /$$$$$$   /$$ /$$$$$$$   /$$$$$$   /$$$$$$$
| $$ /$$$$ /$$__  $$| $$__  $$ /$$__  $$ /$$__  $$|____  $$| $$      |  $$$$$$  /$$__  $$|_  $$_/|_  $$_/|_  $$_/  | $$| $$__  $$ /$$__  $$ /$$_____/
| $$|_  $$| $$$$$$$$| $$  \ $$| $$$$$$$$| $$  \__/ /$$$$$$$| $$       \____  $$| $$$$$$$$  | $$    | $$    | $$    | $$| $$  \ $$| $$  \ $$|  $$$$$$ 
| $$  \ $$| $$_____/| $$  | $$| $$_____/| $$      /$$__  $$| $$       /$$  \ $$| $$_____/  | $$ /$$| $$ /$$| $$ /$$| $$| $$  | $$| $$  | $$ \____  $$
|  $$$$$$/|  $$$$$$$| $$  | $$|  $$$$$$$| $$     |  $$$$$$$| $$      |  $$$$$$/|  $$$$$$$  |  $$$$/|  $$$$/|  $$$$/| $$| $$  | $$|  $$$$$$$ /$$$$$$$/
 \______/  \_______/|__/  |__/ \_______/|__/      \_______/|__/       \______/  \_______/   \___/   \___/   \___/  |__/|__/  |__/ \____  $$|_______/ 
                                                                                                                                  /$$  \ $$          
                                                                                                                                 |  $$$$$$/          
                                                                                                                                  \______/           
]]

	--[[----------------------------------------------------------------------
								Loading CheckBox
	----------------------------------------------------------------------]]--

	local SwitchLabel = vgui.Create("DLabel", GeneralSettingsM)
	SwitchLabel:SetText("Enable / Disable")
	SwitchLabel:SetTextColor(Color(255, 255, 255, 255))
	SwitchLabel:SetPos(45,5)
	SwitchLabel:SizeToContents()

	local switchTable = {}

	local function NNTAddCheckBox(text,posX,posY,netdata,parent)
		local Pos = table.Count(switchTable)
		local NNTCheckBox = vgui.Create( "nnt-switch", parent)
		NNTCheckBox:SetPos(7, 26 + (24 * Pos) )
		NNTCheckBox:SetText(text)
		NNTCheckBox:SetTextColor(Color(255, 255, 255, 255))
		NNTCheckBox.netdata = netdata
		
		switchTable[netdata] = {}
		switchTable[netdata].valid = true
		switchTable[netdata].check = NNTCheckBox
	end

	local NNTCheck_ActivateAFK = NNTAddCheckBox("Avitvate Anti-AFK",1,1,"ANTIAFK",GeneralSettingsM)

	local NNTCheck_UsersBypass = NNTAddCheckBox("User's Whitelist",2,1,"UBYPASS",GeneralSettingsM)

	local NNTCheck_GroupsBypass = NNTAddCheckBox("Groups Whitelist",3,1,"BYPASS",GeneralSettingsM)

	local NNTCheck_GhostMode = NNTAddCheckBox("Ghost Mode",4,1,"GHOST",GeneralSettingsM)

	local NNTCheck_FreezeSalary = NNTAddCheckBox("Freeze Salary (DarkRP)",5,1,"DARKPMONEY",GeneralSettingsM)

	local NNTCheck_AFKGodMode = NNTAddCheckBox("God Mode",6,1,"GODMODE",GeneralSettingsM)

	local NNTCheck_AFKEnableTime = NNTAddCheckBox("Use Time Settings",7,1,"ENABLETIME",GeneralSettingsM)

	local NNTCheck_AFKJobEnable = NNTAddCheckBox("Change Job/Team",8,1,"JOBENABLE",GeneralSettingsM)

	local NNTCheck_AFKJOBREVERT = NNTAddCheckBox("Job/Team Revert Back",9,1,"JOBREVERT",GeneralSettingsM)



	--[[----------------------------------------------------------------------
						   Finished Loading CheckBox
	----------------------------------------------------------------------]]--
	local InfoKickMinutes = vgui.Create( "DLabel", GeneralSettingsM )
	InfoKickMinutes:SetPos( 228, 5 )
	InfoKickMinutes:SetText( "Kick Time [Minutes]" )
	InfoKickMinutes:SizeToContents(true)
	InfoKickMinutes:SetTextColor(Color(255,255,255))

	local InfoWarnMinutes = vgui.Create( "DLabel", GeneralSettingsM )
	InfoWarnMinutes:SetPos( 223, 70 )
	InfoWarnMinutes:SetText( "Warn Time [Minutes]" )
	InfoWarnMinutes:SizeToContents(true)
	InfoWarnMinutes:SetTextColor(Color(255,255,255))


	local KickSliderSelect = vgui.Create( "nnt-slider" , GeneralSettingsM)
    KickSliderSelect:SetPos( 178, 35 )
    KickSliderSelect:SetSize( 250, 20 )
    KickSliderSelect:SetMin( 5 )
	KickSliderSelect:SetMax(60)
	KickSliderSelect:SetDecimals(0)


	local WarnSliderSelect = vgui.Create( "nnt-slider" , GeneralSettingsM)
    WarnSliderSelect:SetPos( 178, 95 )
    WarnSliderSelect:SetSize( 250, 20 )
    WarnSliderSelect:SetMin( 2 )
	WarnSliderSelect:SetMax(55)
	WarnSliderSelect:SetDecimals(0)

	
 	local list_btn = vgui.Create("nnt-small-btn",GeneralSettingsM)
	list_btn:SetText( "APPLY CHANGE" )
	list_btn:SetPos( 233, 130)
	list_btn:SetSize( 100, 24 )
	list_btn:SetFont("DermaDefaultBold")
    list_btn:SetColor(Color(255, 255, 255))
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

	local timeselect


	local TitleTimeSettings = vgui.Create( "DLabel", GeneralSettingsM )
	TitleTimeSettings:SetPos( 243, 165 )
	TitleTimeSettings:SetText( "Time Settings" )
	TitleTimeSettings:SetFont( "Trebuchet18" )
	TitleTimeSettings:SizeToContents(true)
	TitleTimeSettings:SetTextColor(Color(255,255,255))

	local TitleStarttime = vgui.Create( "DLabel", GeneralSettingsM )
	TitleStarttime:SetPos( 258, 185 )
	TitleStarttime:SetText( "Start Time" )
	TitleStarttime:SizeToContents(true)
	TitleStarttime:SetTextColor(Color(255,255,255))


	local Starttime = vgui.Create( "DTextEntry", GeneralSettingsM ) -- create the form as a child of frame
	Starttime:SetPos( 223, 205 )
	Starttime:SetSize( 100, 30 )
	Starttime:SetDisabled( true )
	Starttime:SetFont( "DermaLarge" )
	Starttime:SetText( "12 : 10" )

	StarttimeButton = vgui.Create( "DImageButton", GeneralSettingsM )
	StarttimeButton:SetPos( 323, 205 )				// Set position
	StarttimeButton:SetSize( 30, 30 )			// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
	StarttimeButton:SetImage( "nnt-antiafk/time-edit.png" )	// Set the material - relative to /materials/ directory
	function StarttimeButton:Paint(w,h)
		draw.RoundedBox(1, 0, 0, w, h, Color(200,200,200,255))
	end
	StarttimeButton.DoClick = function()
		local Starttimeselect = vgui.Create( "nnt-frame" )
		Starttimeselect:SetPos( ScrW() /1.9, ScrH() / 2.3 )
		Starttimeselect:SetSize( 180, 100 )
		Starttimeselect:MakePopup()
		function Starttimeselect:Paint(w,h) 
			draw.RoundedBox(10, 0, 0, w, h, Color(255,255,255,255)) 
		end
		timer.Simple(0.5, function()
			function Starttimeselect:Think()
				if not Starttime:IsValid() then Starttimeselect:Remove() end
				if not Starttimeselect:HasFocus() then 
					Starttime:SetText(TimeText:GetValue())
					Starttimeselect:Remove() 
				end

			end
		end)

		TimeText = vgui.Create( "DLabel", Starttimeselect )
		TimeText:SetPos( 27, 24 )
		TimeText:SetFont("HUGETIME")
		TimeText:SetColor(Color(0,0,0))
		TimeText:SetText( Starttime:GetValue() )
		TimeText:SizeToContents()


		UpButtonHour = vgui.Create( "DImageButton", Starttimeselect )
		UpButtonHour:SetImage( "nnt-antiafk/up-arrow.png" )
		UpButtonHour:SetPos( 38, 3 )	
		UpButtonHour:SizeToContents()	
		UpButtonHour.DoClick = function()
			NNTAntiAFK_ChangeTime(1,true,TimeText,false)
		end


		DownButtonHour = vgui.Create( "DImageButton", Starttimeselect )
		DownButtonHour:SetImage( "nnt-antiafk/down-arrow.png" )
		DownButtonHour:SetPos( 38, 73 )	
		DownButtonHour:SizeToContents()	
		DownButtonHour.DoClick = function()
			NNTAntiAFK_ChangeTime(-1,true,TimeText,false)
		end
		


		UpButtonMinute = vgui.Create( "DImageButton", Starttimeselect )
		UpButtonMinute:SetImage( "nnt-antiafk/up-arrow.png" )
		UpButtonMinute:SetPos( 120, 3 )	
		UpButtonMinute:SizeToContents()	
		UpButtonMinute.DoClick = function()
			NNTAntiAFK_ChangeTime(1,false,TimeText,false)
		end


		DownButtonMinute = vgui.Create( "DImageButton", Starttimeselect )
		DownButtonMinute:SetImage( "nnt-antiafk/down-arrow.png" )
		DownButtonMinute:SetPos( 120, 73 )	
		DownButtonMinute:SizeToContents()	
		DownButtonMinute.DoClick = function()
			NNTAntiAFK_ChangeTime(-1,false,TimeText,false)
		end



	end


	local TitleStoptime = vgui.Create( "DLabel", GeneralSettingsM )
	TitleStoptime:SetPos( 258, 245 )
	TitleStoptime:SetText( "Stop Time" )
	TitleStoptime:SizeToContents(true)
	TitleStoptime:SetTextColor(Color(255,255,255))

	local Stoptime = vgui.Create( "DTextEntry", GeneralSettingsM ) -- create the form as a child of frame
	Stoptime:SetPos( 223, 265 )
	Stoptime:SetSize( 100, 30 )
	Stoptime:SetDisabled( true )
	Stoptime:SetFont( "DermaLarge" )
	Stoptime:SetText( "12 : 10" )

	StoptimeButton = vgui.Create( "DImageButton", GeneralSettingsM )
	StoptimeButton:SetPos( 323, 265 )				// Set position
	StoptimeButton:SetSize( 30, 30 )			// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
	StoptimeButton:SetImage( "nnt-antiafk/time-edit.png" )	// Set the material - relative to /materials/ directory
	function StoptimeButton:Paint(w,h)
		draw.RoundedBox(1, 0, 0, w, h, Color(200,200,200,255))
	end
	StoptimeButton.DoClick = function()
		local stoptimeselect = vgui.Create( "nnt-frame" )
		stoptimeselect:SetPos( ScrW() /1.9, ScrH() / 2.04 )
		stoptimeselect:SetSize( 173, 100 )
		stoptimeselect:MakePopup()
		function stoptimeselect:Paint(w,h) 
			draw.RoundedBox(10, 0, 0, w, h, Color(255,255,255,255)) 
		end
		timer.Simple(0.5, function()
			function stoptimeselect:Think()
				if not Stoptime:IsValid() then stoptimeselect:Remove() end
				if not stoptimeselect:HasFocus() then 
					Stoptime:SetText(TimeText:GetValue())
					stoptimeselect:Remove() 
				end

			end
		end)

		TimeText = vgui.Create( "DLabel", stoptimeselect )
		TimeText:SetPos( 27, 24 )
		TimeText:SetFont("HUGETIME")
		TimeText:SetColor(Color(0,0,0))
		TimeText:SetText( Stoptime:GetValue() )
		TimeText:SizeToContents()


		UpButtonHour = vgui.Create( "DImageButton", stoptimeselect )
		UpButtonHour:SetImage( "nnt-antiafk/up-arrow.png" )
		UpButtonHour:SetPos( 38, 3 )	
		UpButtonHour:SizeToContents()	
		UpButtonHour.DoClick = function()
			NNTAntiAFK_ChangeTime(1,true,TimeText,false)
		end


		DownButtonHour = vgui.Create( "DImageButton", stoptimeselect )
		DownButtonHour:SetImage( "nnt-antiafk/down-arrow.png" )
		DownButtonHour:SetPos( 38, 73 )	
		DownButtonHour:SizeToContents()	
		DownButtonHour.DoClick = function()
			NNTAntiAFK_ChangeTime(-1,true,TimeText,false)
		end
		


		UpButtonMinute = vgui.Create( "DImageButton", stoptimeselect )
		UpButtonMinute:SetImage( "nnt-antiafk/up-arrow.png" )
		UpButtonMinute:SetPos( 120, 3 )	
		UpButtonMinute:SizeToContents()	
		UpButtonMinute.DoClick = function()
			NNTAntiAFK_ChangeTime(1,false,TimeText,false)
		end


		DownButtonMinute = vgui.Create( "DImageButton", stoptimeselect )
		DownButtonMinute:SetImage( "nnt-antiafk/down-arrow.png" )
		DownButtonMinute:SetPos( 120, 73 )	
		DownButtonMinute:SizeToContents()	
		DownButtonMinute.DoClick = function()
			NNTAntiAFK_ChangeTime(-1,false,TimeText,false)
		end



	end

	function NNTAntiAFK_ChangeTime(v, b, p, s)
		if s then 
			local data = string.Split(p:GetValue()," : ")
			local currentH = data[1]
			local currentM = data[2]
			if b then 
				local currentH = v
				local currentM = data[2]
				if string.len(currentH) < 2 then currentH = "0"..currentH end
				p:SetText(currentH .. " : " .. currentM )
			elseif !b then
				local currentM = v
				local currentH = data[1]
				if string.len(currentM) < 2 then currentM = "0"..currentM end
				p:SetText(currentH .. " : " .. currentM )
			end
		else
			local data = string.Split(p:GetValue()," : ")
			local currentH = data[1]
			local currentM = data[2]

			if b then
				local currentH = currentH + v
				if currentH < 0 then currentH = 23 end
				if currentH >= 24 then currentH = 0 end
				if string.len(currentH) < 2 then currentH = "0"..currentH end
				p:SetText(currentH .. " : " .. currentM )
			elseif !b then
				local currentM = currentM + v
				if currentM < 0 then currentM = 59 end
				if currentM > 59 then currentM = 0 end
				if string.len(currentM) < 2 then currentM = "0"..currentM end
				p:SetText(currentH .. " : " .. currentM )
			end
		end
	end


	local AFKSETHOURs_btn = vgui.Create("nnt-small-btn")
	AFKSETHOURs_btn:SetParent( GeneralSettingsM )
	AFKSETHOURs_btn:SetText( "APPLY CHANGE" )
	AFKSETHOURs_btn:SetPos( 233, 315)
	AFKSETHOURs_btn:SetSize( 100, 24 )
	AFKSETHOURs_btn:SetFont("DermaDefaultBold")
    AFKSETHOURs_btn:SetColor(Color(255, 255, 255))


	AFKSETHOURs_btn.DoClick = function ()
		surface.PlaySound( "garrysmod/ui_click.wav")
		local startdata = string.Split(Starttime:GetValue()," : ")
		local FirstHours  = startdata[1]
		local FirstMinutes = startdata[2]

		local stopdata = string.Split(Stoptime:GetValue()," : ")
		local SecondHours  = stopdata[1]
		local SecondMinutes = stopdata[2]
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

	



	local TitleStoptime = vgui.Create( "DLabel", GeneralSettingsM )
	TitleStoptime:SetPos( 55, 254 )
	TitleStoptime:SetText( "Job To Change" )
	TitleStoptime:SizeToContents(true)
	TitleStoptime:SetTextColor(Color(255,255,255))

	local JobSelection = vgui.Create( "DComboBox" , GeneralSettingsM )
	JobSelection:SetPos( 25, 278 )
	JobSelection:SetSize( 130, 20 )
	JobSelection:SetValue( "Select!" )
	JobSelection:SetTextColor(Color(0,0,0,255))
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

	local JobSelection_btn = vgui.Create("nnt-small-btn")
	JobSelection_btn:SetParent( GeneralSettingsM )
	JobSelection_btn:SetText( "APPLY JOB" )
	JobSelection_btn:SetPos( 37, 315)
	JobSelection_btn:SetSize( 100, 24 )
	JobSelection_btn:SetFont("DermaDefaultBold")
    JobSelection_btn:SetColor(Color(255, 255, 255))
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








	local PreviewScreen = vgui.Create("nnt-frame", Themes)
	PreviewScreen:SetPos(10,20)
	PreviewScreen:SetSize(380,240)


	local SelectTheme = vgui.Create( "DComboBox", Themes )
	SelectTheme:SetPos( 155, 270 )
	SelectTheme:SetSize( 100, 20 )
	SelectTheme:SetValue( AntiAfkSelTheme )
	for k,v in pairs(NNTAntiafkThemes) do
		SelectTheme:AddChoice(k)
	end
	SelectTheme.OnSelect = function( self, index, value )
		for k,v in pairs(NNTAntiafkThemes) do
			if k == value then
				AntiAFKSelectedTheme = k
				if PreviewEnable then 
					if AfkPanelHUD:IsValid() then AfkPanelHUD:Close() end
					NNTAntiafkThemes[AntiAFKSelectedTheme](PreviewScreen)
				end
			end
		end
	end

	SelectTheme:ChooseOption(AntiAfkSelTheme, "Large" )

	local ApplyThemes = vgui.Create("nnt-small-btn")
	ApplyThemes:SetParent( Themes )
	ApplyThemes:SetText( "APPLY THEMES" )
	ApplyThemes:SetPos( 80, 305)
	ApplyThemes:SetFont("DermaDefaultBold")
	ApplyThemes:SetSize( 250, 20 )
 	ApplyThemes:SetColor(Color(255, 255, 255))
	ApplyThemes.DoClick = function ()
		surface.PlaySound( "garrysmod/ui_click.wav")
		net.Start("nnt-antiak-settings")
			local temptable = {["LANGUAGE"] = AntiAFKSelectedLanguages }
			net.WriteTable(temptable)
			net.WriteString("SetSettings")
        net.SendToServer()
	end

	PreviewEnable = true 
	local PreviewThemes = vgui.Create("nnt-small-btn")
	PreviewThemes:SetParent( Themes )
	PreviewThemes:SetText( "DISABLE THEMES PREVIEW" )
	PreviewThemes:SetPos( 80, 330)
	PreviewThemes:SetSize( 250, 20 )
	PreviewThemes:SetFont("DermaDefaultBold")
 	PreviewThemes:SetColor(Color(255, 255, 255))
	PreviewThemes.DoClick = function ()
		if PreviewEnable then 
			PreviewEnable = false
			if AfkPanelHUD:IsValid() then AfkPanelHUD:Close() end
			PreviewThemes:SetText("ENABLE THEMES PREVIEW")
		else
			PreviewEnable = true
			if AfkPanelHUD:IsValid() then AfkPanelHUD:Close() end
			NNTAntiafkThemes[AntiAFKSelectedTheme](PreviewScreen)
			PreviewThemes:SetText("DISABLE THEMES PREVIEW")
		end
	end


	local TranslatePreviewGenTable = {}
	local function TranslatePreviewGen(e,t)
		local pos = table.Count(TranslatePreviewGenTable)
		local dlabel = vgui.Create( "DLabel", Languages )
		dlabel:SetPos( 10, 10 + (20 * pos) )
		dlabel:SetText(AntiAfkTranslate[e][t])
		dlabel:SizeToContents()
		TranslatePreviewGenTable[t] = dlabel
	end

	local function getLangTable(e)
		if table.Count(TranslatePreviewGenTable) > 0 then
			for k,v in pairs(TranslatePreviewGenTable) do
				v:Remove()
			end
			table.Empty(TranslatePreviewGenTable)
		end
		for k,v in pairs(AntiAfkTranslate[e]) do
			TranslatePreviewGen(e,k)
		end
	end

	getLangTable(AntiAfkLanguage)

	local SelectTranslate = vgui.Create( "DComboBox", Languages )
	SelectTranslate:SetPos( 155, 270 )
	SelectTranslate:SetSize( 100, 20 )
	SelectTranslate:SetValue( AntiAfkTranslate[AntiAfkLanguage]["NAME"] )
	for k,v in pairs(AntiAfkTranslate) do
		SelectTranslate:AddChoice(v["NAME"])
	end
	SelectTranslate.OnSelect = function( self, index, value )
		for k,v in pairs(AntiAfkTranslate) do
			if v["NAME"] == value then
				AntiAFKSelectedLanguages = k
				getLangTable(k)
			end
		end
	end


	local ApplyLanguages = vgui.Create("nnt-small-btn")
	ApplyLanguages:SetParent( Languages )
	ApplyLanguages:SetText( "APPLY LANGUAGES" )
	ApplyLanguages:SetPos( 80, 305)
	ApplyLanguages:SetSize( 250, 20 )
	ApplyLanguages:SetFont("DermaDefaultBold")
 	ApplyLanguages:SetColor(Color(255, 255, 255))

	ApplyLanguages.DoClick = function ()
			surface.PlaySound( "garrysmod/ui_click.wav")
			net.Start("nnt-antiak-settings")
				local temptable = {["THEME"] = AntiAFKSelectedTheme }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
         net.SendToServer()
	end


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
				if switchTable[k] != nil then
					if v == true then 
						switchTable[k].check:SetValue( 1 )
					elseif v == false then 
						switchTable[k].check:SetValue( 0 )
					end

				elseif k == "KICK" then
					KickSliderSelect:SetValue(tonumber(v,10) / 60)

				elseif k == "WARN" then
					WarnSliderSelect:SetValue(tonumber(v,10) / 60)


				elseif k == "AFK_StartTimeHours" then
					if v then
						NNTAntiAFK_ChangeTime(v,true,Starttime,true)
					end

				elseif k == "AFK_StartTimeMinutes" then
					if v then
						NNTAntiAFK_ChangeTime(v,false,Starttime,true)
					end

				elseif k == "AFK_StopTimeHours" then
					if v then
						NNTAntiAFK_ChangeTime(v,true,Stoptime,true)
					end

				elseif k == "AFK_StopTimeMinutes" then
					if v then
						NNTAntiAFK_ChangeTime(v,false,Stoptime,true)
					end
				elseif k == "JOBNAME" then
					if v then
						JobSelection:SetValue(v)
						JobSelected = v
					end
				elseif k == "LANGUAGE" then
					AntiAfkLanguage = v
					AntiAFKSelectedLanguages = v
				elseif k == "THEME" then
					AntiAfkSelTheme = v
					AntiAFKSelectedTheme = v
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
				end
			end
		end

	end)





-- [[
--  /$$   /$$  /$$$$$$  /$$$$$$$$ /$$$$$$$   /$$$$$$        /$$      /$$ /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$$$  /$$       /$$$$$$  /$$$$$$  /$$$$$$$$
-- | $$  | $$ /$$__  $$| $$_____/| $$__  $$ /$$__  $$      | $$  /$ | $$| $$  | $$|_  $$_/|__  $$__/| $$_____/ | $$      |_  $$_/ /$$__  $$|__  $$__/
-- | $$  | $$| $$  \__/| $$      | $$  \ $$| $$  \__/      | $$ /$$$| $$| $$  | $$  | $$     | $$   | $$       | $$        | $$  | $$  \__/   | $$
-- | $$  | $$|  $$$$$$ | $$$$$   | $$$$$$$/|  $$$$$$       | $$/$$ $$ $$| $$$$$$$$  | $$     | $$   | $$$$$    | $$        | $$  |  $$$$$$    | $$
-- | $$  | $$ \____  $$| $$__/   | $$__  $$ \____  $$      | $$$$_  $$$$| $$__  $$  | $$     | $$   | $$__/    | $$        | $$   \____  $$   | $$
-- | $$  | $$ /$$  \ $$| $$      | $$  \ $$ /$$  \ $$      | $$$/ \  $$$| $$  | $$  | $$     | $$   | $$       | $$        | $$   /$$  \ $$   | $$
-- |  $$$$$$/|  $$$$$$/| $$$$$$$$| $$  | $$|  $$$$$$/      | $$/   \  $$| $$  | $$ /$$$$$$   | $$   | $$$$$$$$ | $$$$$$$$ /$$$$$$|  $$$$$$/   | $$
--  \______/  \______/ |________/|__/  |__/ \______/       |__/     \__/|__/  |__/|______/   |__/   |________/ |________/|______/ \______/    |__/

--  /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
-- | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
-- | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
-- | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
-- | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
-- | $$      | $$  | $$| $$\  $$$| $$      | $$
-- | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
-- |__/      |__/  |__/|__/  \__/|________/|________/
-- ]]

	local WhitelistedUser = {}
	local WhitelistedUserBtn = {}

	local UserWhiteTitle = vgui.Create( "DLabel", WhitelistU )
	UserWhiteTitle:SetPos( 135, 0 )
	UserWhiteTitle:SetText( "User's WhiteList" )
	UserWhiteTitle:SetFont("NNT-TITLE")
	UserWhiteTitle:SizeToContents(true)
	UserWhiteTitle:SetTextColor(Color(255,255,255))

	local AdminPanelUsers_view = vgui.Create( "DScrollPanel", WhitelistU )
	AdminPanelUsers_view:SetPos(10,20)
	AdminPanelUsers_view:SetSize(380,300)
	function AdminPanelUsers_view:Paint(w,h)
		surface.SetDrawColor(40, 40, 40, 255)
		surface.DrawRect(0,0, w, h)
	end

	local function WhiteBtnSelect(b)
		for k,v in pairs(WhitelistedUserBtn) do
			if WhitelistedUserBtn[k] == b then 
				v.Selected = true
				v:SetTextColor(Color(255,255,255))
			else
				v.Selected = false
				v:SetTextColor(Color(0,0,0))
			end
		end
	end

	local function AddminUserTolist()
		AdminPanelUsers_view:Rebuild()
		if table.Count(WhitelistedUser) <= 0 then 
			local btn = AdminPanelUsers_view:Add( "DButton" ) 
			btn:SetText( "NO USER FOUND")
			btn:SetSize(390,30)
			btn:SetDisabled(true)
			btn:SetTextColor(Color(255,255,255))
			btn:SetPos(0,AdminPanelUsers_view:GetTall() /2.1)
			function btn:Paint(w,h)
				surface.SetDrawColor(40, 40, 40, 255)
				surface.DrawRect(0, 0,w,h)
			end
		else
			for k,v in pairs(WhitelistedUser) do
				local btn = AdminPanelUsers_view:Add( "DButton" )
				btn:SetText( "SteamID : ".. k .. ",  Name : " .. v )
				btn:Dock( TOP )
				btn:DockMargin( 0, 0, 0, 1 )
				btn.Selected = false
				btn.DoClick = function()
					WhiteBtnSelect(btn)
					tauser = k
				end
				function btn:Paint(w,h)
					surface.SetDrawColor(200, 200, 200, 255)
					if self.Selected then surface.SetDrawColor(76, 175, 80, 255) end
					surface.DrawRect(0, 0,w,h)
				end
				WhitelistedUserBtn[k] = btn

			end
		end
	end

	local UserList = vgui.Create( "DComboBox" , WhitelistU )
	UserList:SetPos( 135, 335 )
	UserList:SetSize( 130, 20 )
	UserList:SetValue( "Select!" )

	net.Start("AntiAfkloaBypassUsers")
	net.SendToServer()
	net.Receive("AntiAfksenBypassUsers", function(len)
		table.Empty(WhitelistedUser)
		table.Empty(WhitelistedUserBtn)
		AdminPanelUsers_view:Clear()
		antiuserstring = net.ReadTable()
		for k,v in pairs(antiuserstring) do
			WhitelistedUser[k] = v
		end
		AddminUserTolist()
		UserList:Clear()
		for k, v in pairs( player.GetHumans() ) do
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


	local adduser = vgui.Create("nnt-small-btn")
	adduser:SetParent( WhitelistU )
	adduser:SetText( "Add User" )
	adduser:SetPos( 275, 333)
	adduser:SetSize( 100, 24 )
    adduser:SetColor(Color(255, 255, 255))
	adduser.DoClick = function ()
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

	local delbutton = vgui.Create("nnt-small-btn")
	delbutton:SetParent( WhitelistU )
	delbutton:SetText( "Remove User" )
	delbutton:SetPos( 25, 333)
	delbutton.SetRed = true
	delbutton:SetSize( 100, 24 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		net.Start("AntiRemBypassUsers")
			net.WriteString(tauser)
		net.SendToServer()
	end

-- [[
--   /$$$$$$  /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$   /$$$$$$        /$$      /$$ /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$$$ /$$       /$$$$$$  /$$$$$$  /$$$$$$$$
--  /$$__  $$| $$__  $$ /$$__  $$| $$  | $$| $$__  $$ /$$__  $$      | $$  /$ | $$| $$  | $$|_  $$_/|__  $$__/| $$_____/| $$      |_  $$_/ /$$__  $$|__  $$__/
-- | $$  \__/| $$  \ $$| $$  \ $$| $$  | $$| $$  \ $$| $$  \__/      | $$ /$$$| $$| $$  | $$  | $$     | $$   | $$      | $$        | $$  | $$  \__/   | $$
-- | $$ /$$$$| $$$$$$$/| $$  | $$| $$  | $$| $$$$$$$/|  $$$$$$       | $$/$$ $$ $$| $$$$$$$$  | $$     | $$   | $$$$$   | $$        | $$  |  $$$$$$    | $$
-- | $$|_  $$| $$__  $$| $$  | $$| $$  | $$| $$____/  \____  $$      | $$$$_  $$$$| $$__  $$  | $$     | $$   | $$__/   | $$        | $$   \____  $$   | $$
-- | $$  \ $$| $$  \ $$| $$  | $$| $$  | $$| $$       /$$  \ $$      | $$$/ \  $$$| $$  | $$  | $$     | $$   | $$      | $$        | $$   /$$  \ $$   | $$
-- |  $$$$$$/| $$  | $$|  $$$$$$/|  $$$$$$/| $$      |  $$$$$$/      | $$/   \  $$| $$  | $$ /$$$$$$   | $$   | $$$$$$$$| $$$$$$$$ /$$$$$$|  $$$$$$/   | $$
--  \______/ |__/  |__/ \______/  \______/ |__/       \______/       |__/     \__/|__/  |__/|______/   |__/   |________/|________/|______/ \______/    |__/

--  /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
-- | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
-- | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
-- | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
-- | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
-- | $$      | $$  | $$| $$\  $$$| $$      | $$
-- | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
-- |__/      |__/  |__/|__/  \__/|________/|________/
-- ]]


	local WhitelistedGroup = {}
	local WhitelistedGroupBtn = {}


	local WhitelistedGroupTitle = vgui.Create( "DLabel", WhitelistG )
	WhitelistedGroupTitle:SetPos( 133, 0 )
	WhitelistedGroupTitle:SetText( "Groups WhiteList" )
	WhitelistedGroupTitle:SetFont("NNT-TITLE")
	WhitelistedGroupTitle:SizeToContents(true)
	WhitelistedGroupTitle:SetTextColor(Color(255,255,255))

	local AdminPanelGroups_view = vgui.Create( "DScrollPanel", WhitelistG )
	AdminPanelGroups_view:SetPos(10,20)
	AdminPanelGroups_view:SetSize(380,300)
	function AdminPanelGroups_view:Paint(w,h)
		surface.SetDrawColor(40, 40, 40, 255)
		surface.DrawRect(0,0, w, h)
	end

	local function WhiteBtnSelect(b)
		for k,v in pairs(WhitelistedGroupBtn) do
			if WhitelistedGroupBtn[k] == b then 
				v.Selected = true
				v:SetTextColor(Color(255,255,255))
			else
				v.Selected = false
				v:SetTextColor(Color(0,0,0))
			end
		end
	end

	local function AddminGroupTolist()
		AdminPanelGroups_view:Rebuild()
		if table.Count(WhitelistedGroup) <= 0 then 
			local btn = AdminPanelGroups_view:Add( "DButton" ) 
			btn:SetText( "NO GROUP FOUND")
			btn:SetSize(390,30)
			btn:SetDisabled(true)
			btn:SetTextColor(Color(255,255,255))
			btn:SetPos(0,AdminPanelGroups_view:GetTall() /2.1)
			function btn:Paint(w,h)
				surface.SetDrawColor(40, 40, 40, 255)
				surface.DrawRect(0, 0,w,h)
			end
		else
			for k,v in pairs(WhitelistedGroup) do
				local btn = AdminPanelGroups_view:Add( "DButton" )
				btn:SetText( "SteamID : ".. k .. ",  Name : " .. v )
				btn:Dock( TOP )
				btn:DockMargin( 0, 0, 0, 1 )
				btn.Selected = false
				btn.DoClick = function()
					WhiteBtnSelect(btn)
					tagroups = v
				end
				function btn:Paint(w,h)
					surface.SetDrawColor(200, 200, 200, 255)
					if self.Selected then surface.SetDrawColor(76, 175, 80, 255) end
					surface.DrawRect(0, 0,w,h)
				end
				WhitelistedGroupBtn[k] = btn

			end
		end
	end


	if ulx then
		local GroupList = vgui.Create( "DComboBox" , WhitelistG )
		GroupList:SetPos( 135, 335 )
		GroupList:SetSize( 130, 20 )
		GroupList:SetValue( "Select a group" )


		net.Start("AntiAfkloaBypassGroups")
		net.SendToServer()
		net.Receive("AntiAfksenBypassGroups", function(len)
			AdminPanelGroups_view:Clear()
			table.Empty(WhitelistedGroup)
			table.Empty(WhitelistedGroupBtn)
			antiusergroupsstring = net.ReadTable()
			for k,v in pairs(antiusergroupsstring) do
				WhitelistedGroup[k] = v
			end
			AddminGroupTolist()
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
			table.Empty(WhitelistedGroup)
			table.Empty(WhitelistedGroupBtn)
			antiusergroupsstring = net.ReadTable()
			for k,v in pairs(antiusergroupsstring) do
				WhitelistedGroup[k] = v
			end
			AddminGroupTolist()
		end)
		local GroupList = vgui.Create( "DTextEntry", WhitelistG ) -- create the form as a child of frame
		GroupList:SetPos( 135, 335 )
		GroupList:SetSize( 130, 20 )	
		GroupList:SetTextColor(Color(0,0,0,255))
		GroupList:SetPlaceholderColor( Color(0, 0, 0) )
		GroupList:SetText( "Enter group name" )
		GroupList.OnChange = function( self )
			SelectedGroups = GroupList:GetValue()	-- print the form's text as server text
		end
	end


	local addgroups = vgui.Create("nnt-small-btn")
	addgroups:SetParent( WhitelistG )
	addgroups:SetText( "Add Groups" )
	addgroups:SetPos( 275, 333)
	addgroups:SetSize( 100, 24 )
    addgroups:SetColor(Color(255, 255, 255))
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

	local delbutton = vgui.Create("nnt-small-btn")
	delbutton:SetParent( WhitelistG )
	delbutton:SetText( "Remove Groups" )
	delbutton:SetPos( 25, 333)
	delbutton.SetRed = true
	delbutton:SetSize( 100, 24 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		net.Start("AntiRemBypassGroups")
			net.WriteString(tagroups)
		net.SendToServer()
	end

-- [[
--   /$$$$$$  /$$$$$$$$ /$$$$$$$$        /$$$$$$  /$$$$$$$$ /$$   /$$       /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
--  /$$__  $$| $$_____/|__  $$__/       /$$__  $$| $$_____/| $$  /$$/      | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
-- | $$  \__/| $$         | $$         | $$  \ $$| $$      | $$ /$$/       | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
-- |  $$$$$$ | $$$$$      | $$         | $$$$$$$$| $$$$$   | $$$$$/        | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
--  \____  $$| $$__/      | $$         | $$__  $$| $$__/   | $$  $$        | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
--  /$$  \ $$| $$         | $$         | $$  | $$| $$      | $$\  $$       | $$      | $$  | $$| $$\  $$$| $$      | $$
-- |  $$$$$$/| $$$$$$$$   | $$         | $$  | $$| $$      | $$ \  $$      | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
--  \______/ |________/   |__/         |__/  |__/|__/      |__/  \__/      |__/      |__/  |__/|__/  \__/|________/|________/
-- ]]
	local SetAFKMenuUser = {}
	local SetAFKMenuUserBtn = {}


	local SetAFKMenuUserTitle = vgui.Create( "DLabel", SetAFKMenu )
	SetAFKMenuUserTitle:SetPos( 133, 0 )
	SetAFKMenuUserTitle:SetText( "Set AFK Menu" )
	SetAFKMenuUserTitle:SetFont("NNT-TITLE")
	SetAFKMenuUserTitle:SizeToContents(true)
	SetAFKMenuUserTitle:SetTextColor(Color(255,255,255))

	local SetAFKMenuUser_view = vgui.Create( "DScrollPanel", SetAFKMenu )
	SetAFKMenuUser_view:SetPos(10,20)
	SetAFKMenuUser_view:SetSize(380,280)
	function SetAFKMenuUser_view:Paint(w,h)
		surface.SetDrawColor(40, 40, 40, 255)
		surface.DrawRect(0,0, w, h)
	end

	local function WhiteBtnSelect(b)
		for k,v in pairs(SetAFKMenuUserBtn) do
			if SetAFKMenuUserBtn[k] == b then 
				v.Selected = true
				v:SetTextColor(Color(255,255,255))
			else
				v.Selected = false
				v:SetTextColor(Color(0,0,0))
			end
		end
	end

	local function AddminUserTolist()
		SetAFKMenuUser_view:Rebuild()
		if table.Count(SetAFKMenuUser) <= 0 then 
			local btn = SetAFKMenuUser_view:Add( "DButton" ) 
			btn:SetText( "NO GROUP FOUND")
			btn:SetSize(390,30)
			btn:SetDisabled(true)
			btn:SetTextColor(Color(255,255,255))
			btn:SetPos(0,SetAFKMenuUser_view:GetTall() /2.1)
			function btn:Paint(w,h)
				surface.SetDrawColor(40, 40, 40, 255)
				surface.DrawRect(0, 0,w,h)
			end
		else
			for k,v in pairs(SetAFKMenuUser) do
				local btn = SetAFKMenuUser_view:Add( "DButton" )
				btn:SetText( "SteamID : ".. k .. ",  Name : " .. v )
				btn:Dock( TOP )
				btn:DockMargin( 0, 0, 0, 1 )
				btn.Selected = false
				btn.DoClick = function()
					WhiteBtnSelect(btn)
					taplayer = k
				end
				function btn:Paint(w,h)
					surface.SetDrawColor(200, 200, 200, 255)
					if self.Selected then surface.SetDrawColor(76, 175, 80, 255) end
					surface.DrawRect(0, 0,w,h)
				end
				SetAFKMenuUserBtn[k] = btn

			end
		end
	end

	for k,v in pairs(player.GetHumans()) do
		SetAFKMenuUser[v:SteamID()] = v:Nick()
	end

	AddminUserTolist()

	local InfoSetPlayerAFK= vgui.Create( "DLabel", SetAFKMenu )
	InfoSetPlayerAFK:SetPos( 50, 300)
	InfoSetPlayerAFK:SetSize(300, 18)
	InfoSetPlayerAFK:SetTextColor(Color(255,255,255))
	InfoSetPlayerAFK:SetFont("HUDLARGESMALL")
	InfoSetPlayerAFK:SetText( "How much time left before the player get kick [Minutes]" )

	local SetPlayerAFKSliderSelect = vgui.Create( "nnt-slider" , SetAFKMenu)
    SetPlayerAFKSliderSelect:SetPos( 70, 317 )
    SetPlayerAFKSliderSelect:SetSize( 300, 20 )
	//SetPlayerAFKSliderSelect:SetText( "Kick Time [Minutes]" )
    SetPlayerAFKSliderSelect:SetMin( 2 )
	SetPlayerAFKSliderSelect:SetMax(60)
	SetPlayerAFKSliderSelect:SetDecimals(0)
	SetPlayerAFKSliderSelect:SetValue(5)



	local list_btn = vgui.Create("nnt-small-btn")
	list_btn:SetParent( SetAFKMenu )
	list_btn:SetText( "SET PLAYER AFK" )
	list_btn:SetPos( 125, 340)
	list_btn:SetSize( 150, 24 )
    list_btn:SetColor(Color(255, 255, 255))
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

