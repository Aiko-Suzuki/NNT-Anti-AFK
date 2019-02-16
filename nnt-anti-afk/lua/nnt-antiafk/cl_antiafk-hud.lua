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

AntiAfkTranslate = AntiAfkTranslate or {}

AntiAfkDisponibleLang = {}

AntiAfkLanguage = "EN"

for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
	include("nnt-antiafk/lang/" .. v)
    print("Loaded " ..v )
end

AntiAfkDisponibleLang = {}

for k,v in pairs(AntiAfkTranslate) do
	table.insert(AntiAfkDisponibleLang, table.Count(AntiAfkDisponibleLang) + 1,k)
end

--[[
 /$$      /$$  /$$$$$$  /$$$$$$$  /$$   /$$ /$$$$$$ /$$   /$$  /$$$$$$        /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
| $$  /$ | $$ /$$__  $$| $$__  $$| $$$ | $$|_  $$_/| $$$ | $$ /$$__  $$      | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$ /$$$| $$| $$  \ $$| $$  \ $$| $$$$| $$  | $$  | $$$$| $$| $$  \__/      | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$/$$ $$ $$| $$$$$$$$| $$$$$$$/| $$ $$ $$  | $$  | $$ $$ $$| $$ /$$$$      | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$$$_  $$$$| $$__  $$| $$__  $$| $$  $$$$  | $$  | $$  $$$$| $$|_  $$      | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$$/ \  $$$| $$  | $$| $$  \ $$| $$\  $$$  | $$  | $$\  $$$| $$  \ $$      | $$      | $$  | $$| $$\  $$$| $$      | $$
| $$/   \  $$| $$  | $$| $$  | $$| $$ \  $$ /$$$$$$| $$ \  $$|  $$$$$$/      | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/     \__/|__/  |__/|__/  |__/|__/  \__/|______/|__/  \__/ \______/       |__/      |__/  |__/|__/  \__/|________/|________/
]]

local function AntiafkMainHUD()

	local w = ScrW() / 2
    local h = ScrH() / 2


    VarTimeleft = "00m 00s"


    surface.CreateFont( "AFKLarge", {
	font = "Arial",
	extended = false,
	size = 60,
    } )
    surface.CreateFont( "AFKMedium", {
	font = "Arial",
	extended = false,
	size = 30,
    } )
    surface.CreateFont( "AFKsmall", {
	font = "Arial",
	extended = false,
	size = 21,
    } )
    surface.CreateFont( "AFKsmallK", {
	font = "Arial",
	extended = false,
	size = 18,
    } )

	function timeToStr( time )
	local tmp = time
	local s = tmp % 60
	tmp = math.floor( tmp / 60 )
	local m = tmp
		return string.format( "%02im %02is", m, s )
	end

	local AfkPanelHUD = vgui.Create( "DFrame" )
	AfkPanelHUD:SetPos( 0, h-200 )
	AfkPanelHUD:SetSize( ScrW(), ScrH() / 3 )
	AfkPanelHUD:SetTitle( "" )
	AfkPanelHUD:SetDraggable( true )
	AfkPanelHUD:ShowCloseButton( false )
	AfkPanelHUD:SetKeyBoardInputEnabled()
	AfkPanelHUD:SetMouseInputEnabled()
	AfkPanelHUD:SetDraggable(false)
	function AfkPanelHUD:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 235))
	end

	local SignL = vgui.Create( "DLabel", AfkPanelHUD )
	SignL:SetPos( 0, 0)
	SignL:SetContentAlignment(5)
    SignL:SetSize( ScrW(), ScrH() / 4.5)
    SignL:SetFont("AFKLarge")
    SignL:SetColor(Color(255, 0, 0, 255))
	SignL:SetText( AntiAfkTranslate[AntiAfkLanguage]["MAINTEXT"] )

    local SignM = vgui.Create( "DLabel", AfkPanelHUD )
	SignM:SetPos( 0, 0)
	SignM:SetContentAlignment(5)
    SignM:SetSize( ScrW(), ScrH() / 3)
    SignM:SetFont("AFKMedium")
    SignM:SetColor(Color(255, 255, 255, 255))
	SignM:SetText( AntiAfkTranslate[AntiAfkLanguage]["WARN"].." ".. VarTimeleft .." !" )

	local SignS = vgui.Create( "DLabel", AfkPanelHUD )
	SignS:SetPos( 0, 0)
	SignS:SetContentAlignment(5)
    SignS:SetSize( ScrW(), ScrH() / 2.4)
    SignS:SetFont("AFKsmall")
    SignS:SetColor(Color(255, 255, 255, 255))
	SignS:SetText( AntiAfkTranslate[AntiAfkLanguage]["CANCEL"] )

    local SignK = vgui.Create( "DLabel", AfkPanelHUD )
	SignK:SetPos( 0, 0)
	SignK:SetContentAlignment(5)
    SignK:SetSize( ScrW(), ScrH() / 2)
    SignK:SetFont("AFKsmallK")
    SignK:SetColor(Color(255, 255, 255, 255))
	SignK:SetText( AntiAfkTranslate[AntiAfkLanguage]["MOVEKEY"] )

	net.Start("AFKHUD2")
	net.SendToServer(LocalPlayer())
	net.Receive("AFKHUDR", function(len)
		ReceiveVar = net.ReadString()
		SignM:SetText( AntiAfkTranslate[AntiAfkLanguage]["WARN"].." ".. timeToStr(ReceiveVar) .." !" )
		VarTimeleft = ReceiveVar
		timer.Create( "AFK:"..LocalPlayer():SteamID(), 1, ReceiveVar, function()
			x = VarTimeleft - 1
			VarTimeleft = x
			SignM:SetText( AntiAfkTranslate[AntiAfkLanguage]["WARN"].." ".. timeToStr(VarTimeleft) .." !" )
		end)
	end)


	timer.Create( "AFKS:"..LocalPlayer():SteamID(), 30, 0, function()
		surface.PlaySound("buttons/button18.wav")
		surface.PlaySound("buttons/button18.wav")
		surface.PlaySound("buttons/button18.wav")
	end)


	net.Start("AFKHUD1")
	net.Receive("AFKHUD1", function(len)
		timer.Destroy("AFK:"..LocalPlayer():SteamID())
		timer.Destroy("AFKS:"..LocalPlayer():SteamID())
		AfkPanelHUD:Close()
	end)

	surface.PlaySound("buttons/button18.wav")
	surface.PlaySound("buttons/button18.wav")
	surface.PlaySound("buttons/button18.wav")


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



local function AntiafkAdminPanelUsers()


    local w = ScrW() / 2
    local h = ScrH() / 2

	local AdminPanelUsers = vgui.Create( "DFrame" )
	AdminPanelUsers:SetPos( w-200, h-200 )
	AdminPanelUsers:SetSize( 400, 430 )
	AdminPanelUsers:SetTitle( "Anti AFK bypass Groupss" )
	AdminPanelUsers:SetDraggable( true )
	AdminPanelUsers:ShowCloseButton( true )
	AdminPanelUsers:MakePopup()
	function AdminPanelUsers:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 175))
	end



	local AdminPanelUsers_view = vgui.Create("DListView")
	AdminPanelUsers_view:SetParent(AdminPanelUsers)
	AdminPanelUsers_view:SetPos(0, 30)
	AdminPanelUsers_view:SetSize(400, 300)
	AdminPanelUsers_view:SetMultiSelect(false)
	--AdminPanelUsers_view.OnClickLine = function(parent,selected,isselected) print(selected:GetValue(1)) end
	AdminPanelUsers_view.OnRowSelected = function(parent,selected,isselected) print(isselected:GetValue(1))
			tauser = isselected:GetValue(1)
	end
	AdminPanelUsers_view:AddColumn("SteamID")
	AdminPanelUsers_view:AddColumn("Name")

		net.Start("AntiAfkloaBypassUsers")
		net.SendToServer()
		net.Receive("AntiAfksenBypassUsers", function(len)
			AdminPanelUsers_view:Clear()
			antiuserstring = net.ReadTable()
			for k,v in pairs(antiuserstring) do
				if !IsValid(player.GetBySteamID(v)) then
					local plyname = "Not Connected !"
					AdminPanelUsers_view:AddLine(v,plyname)
				else
					local plyname = player.GetBySteamID(v):Nick()
					AdminPanelUsers_view:AddLine(v,plyname)
				end
			end
		end)


    local UserEntry = vgui.Create( "DTextEntry")
    UserEntry:SetParent( AdminPanelUsers )
    UserEntry:SetPos( 150, 340 )
    UserEntry:SetSize( 100, 30 )
    UserEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )
    end

	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( AdminPanelUsers )
	addgroups:SetText( "Add User" )
	addgroups:SetPos( 220, 380)
	addgroups:SetSize( 150, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
		if string.StartWith(UserEntry:GetValue() , " " ) then
			LocalPlayer():ChatPrint('You cannot add a user starting with a space !')
		return end
		if UserEntry:GetValue() == "" then
			LocalPlayer():ChatPrint('You cannot add a empty user !')
		return end
		if table.HasValue(antiuserstring, UserEntry:GetValue()) then
			LocalPlayer():ChatPrint('User ' .. UserEntry:GetValue() ..' is already there !')
		return end
		net.Start("AntiAddBypassUsers")
			net.WriteString(UserEntry:GetValue())
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( AdminPanelUsers )
	delbutton:SetText( "Del User" )
	delbutton:SetPos( 30, 380)
	delbutton:SetSize( 150, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
		net.Start("AntiRemBypassUsers")
			net.WriteString(tauser)
		net.SendToServer()
	end

	local Sign = vgui.Create( "DLabel", AdminPanelUsers )
	Sign:SetPos( 25, 410 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )


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

local function AntiafkAdminPanelGroups()


    local w = ScrW() / 2
    local h = ScrH() / 2

	local AdminPanelGroups = vgui.Create( "DFrame" )
	AdminPanelGroups:SetPos( w-200, h-200 )
	AdminPanelGroups:SetSize( 400, 430 )
	AdminPanelGroups:SetTitle( "Anti AFK bypass Groupss" )
	AdminPanelGroups:SetDraggable( true )
	AdminPanelGroups:ShowCloseButton( true )
	AdminPanelGroups:MakePopup()
	function AdminPanelGroups:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 175))
	end



	local AdminPanelGroups_view = vgui.Create("DListView")
	AdminPanelGroups_view:SetParent(AdminPanelGroups)
	AdminPanelGroups_view:SetPos(0, 30)
	AdminPanelGroups_view:SetSize(400, 300)
	AdminPanelGroups_view:SetMultiSelect(false)
	AdminPanelGroups_view.OnRowSelected = function( panel, rowIndex, row )
			tagroups = row:GetValue(1)
	end
	AdminPanelGroups_view:AddColumn("Groups")
		net.Start("AntiAfkloaBypassGroups")
		net.SendToServer()
		net.Receive("AntiAfksenBypassGroups", function(len)
			AdminPanelGroups_view:Clear()
			antiusergroupsstring = net.ReadTable()
			for k,v in pairs(antiusergroupsstring) do
				AdminPanelGroups_view:AddLine(v)
			end
		end)


    local GroupEntry = vgui.Create( "DTextEntry")
    GroupEntry:SetParent( AdminPanelGroups )
    GroupEntry:SetPos( 150, 340 )
    GroupEntry:SetSize( 100, 30 )
    GroupEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )
    end

	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( AdminPanelGroups )
	addgroups:SetText( "Add Groups" )
	addgroups:SetPos( 220, 380)
	addgroups:SetSize( 150, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
		if string.StartWith(GroupEntry:GetValue() , " " ) then
			LocalPlayer():ChatPrint('You cannot add group starting with a space !')
		return end
		if GroupEntry:GetValue() == "" then
			LocalPlayer():ChatPrint('You cannot add a empty group !')
		return end
		if table.HasValue(antiusergroupsstring, GroupEntry:GetValue()) then
			LocalPlayer():ChatPrint('User group ' .. GroupEntry:GetValue() ..' is already there !')
		return end
		net.Start("AntiAddBypassGroups")
			net.WriteString(GroupEntry:GetValue())
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( AdminPanelGroups )
	delbutton:SetText( "Del Groups" )
	delbutton:SetPos( 30, 380)
	delbutton:SetSize( 150, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
		net.Start("AntiRemBypassGroups")
			net.WriteString(tagroups)
		net.SendToServer()
	end

	local Sign = vgui.Create( "DLabel", AdminPanelGroups )
	Sign:SetPos( 25, 410 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )


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
local function AntiafkAdminPanel()

    local w = ScrW() / 2
    local h = ScrH() / 2
    PanelOff = nil
    SomeShittyTest = "undefined"
    SomeShittyTest1 = "undefined"
	SomeShittyTest2 = "undefined"
	SomeShittyTest3 = "undefined"



	local MainPanel = vgui.Create( "DFrame" )
	MainPanel:SetPos( w-200, h-200 )
	MainPanel:SetSize( 300, 200 )
	MainPanel:SetTitle( "ANTI AFK ADMIN PANEL" )
	MainPanel:SetDraggable( true )
	MainPanel:ShowCloseButton( true )
	MainPanel:MakePopup()

	function MainPanel:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 225))
	end


    local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( MainPanel )
    TextEntry:SetPos( 22, 130 )
    TextEntry:SetSize( 65, 25 )
    TextEntry:SetMin( 180 )
    TextEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

    local TextEntry2 = vgui.Create( "DNumberWang")
    TextEntry2:SetParent( MainPanel )
    TextEntry2:SetPos( 120, 130 )
    TextEntry2:SetSize( 65, 25 )
    TextEntry2:SetMin( 180 )
    TextEntry2.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

    local info = vgui.Create( "DLabel", MainPanel )
    info:SetPos( 200, 110 )
    info:SetSize(280, 100)
    info:SetText('Current Time : ' .. SomeShittyTest )
	info:SetColor(Color(255,255,0))

    local info2 = vgui.Create( "DLabel", MainPanel )
    info2:SetPos( 200, 122 )
    info2:SetSize(280, 100)
    info2:SetText('Warn Time : ' .. "Refresh !" )
	info2:SetColor(Color(255,255,0))


	-- Groups Bypass
	local checkboxGroupsbypass = vgui.Create( "DCheckBoxLabel", MainPanel )
	checkboxGroupsbypass:SetPos( 22, 90 )
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
	local checkboxUbypass = vgui.Create( "DCheckBoxLabel", MainPanel )
	checkboxUbypass:SetPos( 22, 70 )
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
	local checkboxAntiAFK = vgui.Create( "DCheckBoxLabel", MainPanel )
	checkboxAntiAFK:SetPos( 22, 50 )
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



	local SelectTranslate = vgui.Create( "DComboBox", MainPanel )
	SelectTranslate:SetPos( 205, 97 )
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
				--[[net.Start("AntiAfkSendHUDInfo")
					net.WriteString(k)
				net.SendToServer()]]
			end
		end
	end

    local list_btn = vgui.Create("DButton")
	list_btn:SetParent( MainPanel )
	list_btn:SetText( "SET KICK" )
	list_btn:SetPos( 22, 160)
	list_btn:SetSize( 65, 20 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn.DoClick = function ()
			net.Start("nnt-antiak-settings")
				local temptable = {["KICK"] = TextEntry:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
	end

    local list_btn2 = vgui.Create("DButton")
	list_btn2:SetParent( MainPanel )
	list_btn2:SetText( "SET WARN" )
	list_btn2:SetPos( 120, 160)
	list_btn2:SetSize( 65, 20 )
    list_btn2:SetColor(Color(255, 255, 255))
	list_btn2.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn2.DoClick = function ()
            net.Start("nnt-antiak-settings")
				local temptable = {["WARN"] = TextEntry2:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
	end


	local Groups_btn = vgui.Create("DButton")
	Groups_btn:SetParent( MainPanel )
	Groups_btn:SetText( "Groups" )
	Groups_btn:SetPos( 213, 70 )
	Groups_btn:SetSize( 55, 20 )
    Groups_btn:SetColor(Color(255, 255, 255))
	Groups_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Groups_btn.DoClick = function ()
		AntiafkAdminPanelGroups()
	end

	local Users_btn = vgui.Create("DButton")
	Users_btn:SetParent( MainPanel )
	Users_btn:SetText( "Users" )
	Users_btn:SetPos( 213, 45 )
	Users_btn:SetSize( 55, 20 )
    Users_btn:SetColor(Color(255, 255, 255))
	Users_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Users_btn.DoClick = function ()
		AntiafkAdminPanelUsers()
	end

	local Sign = vgui.Create( "DLabel", MainPanel )
	Sign:SetPos( 100, 180 )
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
					info2:SetText('Warn Time : ' .. v )
				elseif k == "AFK_TIME" then
					AFK_TIME = v
					info:SetText('Current Time : ' .. v )
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
				elseif k == "AFK_TIME" then
					AFK_TIME = v
					info:SetText('Current Time : ' .. v )
				end
			end
		elseif data5 == "Settings" then -- to load separate data
        	for k,v in pairs(data4) do
				if k == "WARN" then
					info2:SetText('Warn Time : ' .. v )
				elseif k == "KICK" then
					info:SetText('Current Time : ' .. v )
				elseif k == "ANTIAFK" then

				elseif k == "BYPASS" then

				elseif k == "UBYPASS" then

				end
			end
		end
	end)




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

local function AntiafkAdminSetAfk()


    local w = ScrW() / 2
    local h = ScrH() / 2

	local list_window = vgui.Create( "DFrame" )
	list_window:SetPos( w-200, h-200 )
	list_window:SetSize( 400, 555 )
	list_window:SetTitle( "Afk Set time" )
	list_window:SetDraggable( true )
	list_window:ShowCloseButton( true )
	list_window:MakePopup()
	function list_window:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 175))
	end

	local list_view = vgui.Create("DListView")
	list_view:SetParent(list_window)
	list_view:SetPos(0, 30)
	list_view:SetSize(400, 400)
	list_view:SetMultiSelect(false)
	list_view.OnRowSelected = function( panel, rowIndex, row )
			taplayer = row:GetValue(1)
	end
	list_view:AddColumn("Player") -- Add columnfor k,v inpairs(player.GetAll()) do
	for k,v in pairs(player.GetAll()) do
    	list_view:AddLine(v:Nick()) -- Add lines
	end

    local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( list_window )
    TextEntry:SetPos( 150, 440 )
    TextEntry:SetSize( 75, 25 )
    TextEntry:SetMin( 180 )
    TextEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

	local list_btn = vgui.Create("DButton")
	list_btn:SetParent( list_window )
	list_btn:SetText( "Set AFK" )
	list_btn:SetPos( 120, 480)
	list_btn:SetSize( 150, 25 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn.DoClick = function ()
			LocalPlayer():ConCommand( 'setafkplayer "' .. taplayer ..'" ' .. TextEntry:GetValue()  )
	end

	local Sign = vgui.Create( "DLabel", list_window )
	Sign:SetPos( 25, 520 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )



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
		AntiafkAdminSetAfk()
	elseif (data1 == "AntiafkMainHUD") then
		AntiafkMainHUD()
	elseif (data1 == "AntiafkMainHUDSP") then
		AntiafkMainHUDSP()
	elseif (data1 == "AntiafkAdminPanel") then
		AntiafkAdminPanel()
	elseif (data1 == "AntiafkAdminPanelGroups") then
		AntiafkAdminPanelGroups()
	elseif table.HasValue(AntiAfkDisponibleLang, data1) then
		AntiAfkLanguage = data1
		print("ANTIAFK: LANGUAGE SETTINGS RECEIVED " .. AntiAfkLanguage)
	end
end)