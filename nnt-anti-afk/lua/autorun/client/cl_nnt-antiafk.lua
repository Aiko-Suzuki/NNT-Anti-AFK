local AntiAfkTranslate = {
	["MAINTEXT"] = "AFK WARNING !",
	["WARN"] = "You are gonna be kicked for afk in ",
	["CANCEL"] = "Press any key to cancel !",
	["REMOVEWARN"] = "Press any key remove the warning !",
	["MOVEKEY"] = "(Moving Key / Space / Use key / Reload Key / Zoom key)",
	["SP-WARNING"] = "You afk since "
}


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
	AfkPanelHUD:SetSize( ScrW(), 400 )
	AfkPanelHUD:SetTitle( "" )
	AfkPanelHUD:SetDraggable( true )
	AfkPanelHUD:ShowCloseButton( false )
	AfkPanelHUD:MakePopup()	
	AfkPanelHUD:SetKeyBoardInputEnabled()
	AfkPanelHUD:SetMouseInputEnabled()
	AfkPanelHUD:SetDraggable(false)
	function AfkPanelHUD:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 235))
	end

	local SignL = vgui.Create( "DLabel", AfkPanelHUD )
	SignL:SetPos( w-175,  ScrH() / 10)
    SignL:SetSize( 600, 50)
    SignL:SetFont("AFKLarge")
    SignL:SetColor(Color(255, 0, 0, 255))
	SignL:SetText( AntiAfkTranslate["MAINTEXT"] )

    local SignM = vgui.Create( "DLabel", AfkPanelHUD )
	SignM:SetPos( w-225,  ScrH() / 6)
    SignM:SetSize( 800, 50)
    SignM:SetFont("AFKMedium")
    SignM:SetColor(Color(255, 255, 255, 255))
	SignM:SetText( AntiAfkTranslate["WARN"].. VarTimeleft .." !" )

	local SignS = vgui.Create( "DLabel", AfkPanelHUD )
	SignS:SetPos( w-80,  ScrH() / 4.8)
    SignS:SetSize( 300, 50)
    SignS:SetFont("AFKsmall")
    SignS:SetColor(Color(255, 255, 255, 255))
	SignS:SetText( AntiAfkTranslate["CANCEL"] )

    local SignK = vgui.Create( "DLabel", AfkPanelHUD )
	SignK:SetPos( w-170,  ScrH() / 4.1)
    SignK:SetSize( 500, 50)
    SignK:SetFont("AFKsmallK")
    SignK:SetColor(Color(255, 255, 255, 255))
	SignK:SetText( AntiAfkTranslate["MOVEKEY"] )

	net.Start("AFKHUD2")
	net.SendToServer(LocalPlayer())
	net.Receive("AFKHUDR", function(len)
		ReceiveVar = net.ReadString()
		SignM:SetText( AntiAfkTranslate["WARN"].. timeToStr(ReceiveVar) .." !" )
		VarTimeleft = ReceiveVar
		timer.Create( "AFK:"..LocalPlayer():SteamID(), 1, ReceiveVar, function()
			if LocalPlayer():IsSuperAdmin() then
				timer.Destroy("AFK:"..LocalPlayer():SteamID())
				timer.Destroy("AFKS:"..LocalPlayer():SteamID())
				AfkPanelHUD:Close()
				return
			end
			x = VarTimeleft - 1
			VarTimeleft = x
			SignM:SetText( AntiAfkTranslate["WARN"].. timeToStr(VarTimeleft) .." !" )
		end)
	end)


	timer.Create( "AFKS:"..LocalPlayer():SteamID(), 30, 0, function() 
		surface.PlaySound("buttons/button18.wav")
		surface.PlaySound("buttons/button18.wav")
		surface.PlaySound("buttons/button18.wav")
	end)


	net.Start("AFKHUD1")
	net.Receive("AFKHUD1", function(len)
		if LocalPlayer():IsSuperAdmin() then return end
		timer.Destroy("AFK:"..LocalPlayer():SteamID())
		timer.Destroy("AFKS:"..LocalPlayer():SteamID())
		AfkPanelHUD:Close()
		return
	end)

	surface.PlaySound("buttons/button18.wav")
	surface.PlaySound("buttons/button18.wav")
	surface.PlaySound("buttons/button18.wav")


end


local function AntiafkMainHUDSP()
	

	local w = ScrW() / 2 
    local h = ScrH() / 2

    VarTimeleft = "undefined"
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
	local m = tmp % 60
	tmp = math.floor( tmp / 60 )
	local h = tmp
		return string.format( "%02ih %02im %02is", h, m, s )
	end

	local AfkPanelHUD = vgui.Create( "DFrame" )
	AfkPanelHUD:SetPos( 0, h-200 )
	AfkPanelHUD:SetSize( ScrW(), 400 )
	AfkPanelHUD:SetTitle( "" )
	AfkPanelHUD:SetDraggable( true )
	AfkPanelHUD:ShowCloseButton( false )
	AfkPanelHUD:MakePopup()	
	AfkPanelHUD:SetKeyBoardInputEnabled()
    AfkPanelHUD:SetMouseInputEnabled()
	AfkPanelHUD:SetDraggable(false)
	function AfkPanelHUD:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 235))
	end

	local SignL = vgui.Create( "DLabel", AfkPanelHUD )
	SignL:SetPos( w-175,  ScrH() / 10)
    SignL:SetSize( 600, 50)
    SignL:SetFont("AFKLarge")
    SignL:SetColor(Color(255, 0, 0, 255))
	SignL:SetText( AntiAfkTranslate["MAINTEXT"])

    local SignM = vgui.Create( "DLabel", AfkPanelHUD )
	SignM:SetPos( w-135,  ScrH() / 6)
    SignM:SetSize( 800, 50)
    SignM:SetFont("AFKMedium")
    SignM:SetColor(Color(255, 255, 255, 255))
	SignM:SetText( AntiAfkTranslate["SP-WARNING"].. "00h 00m 00s" .." ! " )

	local SignS = vgui.Create( "DLabel", AfkPanelHUD )
	SignS:SetPos( w-118,  ScrH() / 4.8)
    SignS:SetSize( 300, 50)
    SignS:SetFont("AFKsmall")
    SignS:SetColor(Color(255, 255, 255, 255))
	SignS:SetText( AntiAfkTranslate["REMOVEWARN"] )

    local SignK = vgui.Create( "DLabel", AfkPanelHUD )
	SignK:SetPos( w-170,  ScrH() / 4.1)
    SignK:SetSize( 500, 50)
    SignK:SetFont("AFKsmallK")
    SignK:SetColor(Color(255, 255, 255, 255))
	SignK:SetText( AntiAfkTranslate["MOVEKEY"] )



	net.Start("AFKHUD2")
	net.SendToServer(LocalPlayer())
	net.Receive("AFKHUDRSP", function(len)
		ReceiveVar = net.ReadString()
		SignM:SetText( AntiAfkTranslate["SP-WARNING"].. timeToStr(ReceiveVar) .." !" )
		VarTimeleft = ReceiveVar
		timer.Create( "AFK:"..LocalPlayer():SteamID(), 1, 0, function()
			x = VarTimeleft + 1
			VarTimeleft = x
			SignM:SetText( AntiAfkTranslate["SP-WARNING"].. timeToStr(VarTimeleft) .." !" )
		end)
	end)



	net.Start("AFKHUDSP1")
	net.Receive("AFKHUDSP1", function()
		if AfkPanelHUD:IsValid() then
			AfkPanelHUD:Close()
		end
		timer.Destroy("AFK:"..LocalPlayer():SteamID())
		return
	end)

end

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


local function AntiafkAdminPanel()
	
    local w = ScrW() / 2 
    local h = ScrH() / 2
    PanelOff = nil
    SomeShittyTest = "undefined"
    SomeShittyTest1 = "undefined"
	SomeShittyTest2 = "undefined"
    	
	net.Start("Refresh")
        net.SendToServer(ply)
        net.Receive("RefreshTime1", function(lan)
            SomeShittyTest = net.ReadString()
        end)
        net.Receive("RefreshTime2", function(lan)
            SomeShittyTest1 = net.ReadString()
    	end)
		net.Receive("RefreshTime3", function(lan)
            SomeShittyTest2 = net.ReadString()
    	end)



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

	local yetinfo = vgui.Create( "DLabel", MainPanel )
    yetinfo:SetPos( 5, 5 )
    yetinfo:SetSize(280, 100)
    yetinfo:SetText( "This panel is to change the After how many second \n someone get kick ! \n Or Set the Warning Time !" )
    yetinfo:SetContentAlignment(5)

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
    net.Receive("RefreshTime1", function(lan)
        SomeShittyTest = net.ReadString()
        info:SetText('Current Time : ' .. SomeShittyTest )
    end)
    net.Receive("RefreshTime2", function(lan)
        SomeShittyTest1 = net.ReadString()
        info2:SetText('Warn Time : ' .. SomeShittyTest1 )
    end)


	local checkboxSPbypass = vgui.Create( "DCheckBoxLabel", MainPanel )
	checkboxSPbypass:SetPos( 22, 105 )
	checkboxSPbypass:SetText( "Groups Bypass" )		

	local info3 = vgui.Create( "DLabel", MainPanel )
    info3:SetPos( 22, 45 )
    info3:SetSize(280, 100)
    info3:SetText('SuperAdmin bypass : '.. SomeShittyTest2  )
	info3:SetColor(Color(255,255,0))
	net.Receive("RefreshTime3", function(lan)
        SomeShittyTest2 = net.ReadString()
        info3:SetText('Groups Bypass : ' .. SomeShittyTest2 )
    end)
	if SomeShittyTest2 == "true" then
			checkboxSPbypass:SetValue( 1 )
	end
	timer.Create("Checkifvalueistruefromafk", 0.5, 1, function()
		if SomeShittyTest2 == "true" then
			checkboxSPbypass:SetValue( 1 )
		end
	end)
	
	function checkboxSPbypass:OnChange( val )
		if val then
			net.Start("ChangeSPBypass")
				net.WriteString("true")
			net.SendToServer()
		else
			net.Start("ChangeSPBypass")
				net.WriteString("false")
			net.SendToServer()
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
			LocalPlayer():ConCommand( 'setafktime ' .. TextEntry:GetValue()  )
	end

    local list_btn2 = vgui.Create("DButton")
	list_btn2:SetParent( MainPanel )
	list_btn2:SetText( "SET WARN" )
	list_btn2:SetPos( 120, 160)
	list_btn2:SetSize( 65, 20 )
    list_btn2:SetColor(Color(255, 255, 255))
	list_btn2.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn2.DoClick = function ()	
            net.Start("ChangeWarnTime")
                net.WriteString(TextEntry2:GetValue())
            net.SendToServer()
	end

    local RE_btn = vgui.Create("DButton")
	RE_btn:SetParent( MainPanel )
	RE_btn:SetText( "REFRESH" )
	RE_btn:SetPos( 213, 125 )
	RE_btn:SetSize( 55, 20 )
    RE_btn:SetColor(Color(255, 255, 255))
	RE_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	RE_btn.DoClick = function ()
            net.Start("Refresh")
            net.SendToServer(ply)
            net.Receive("RefreshTime1", function(lan)
                SomeShittyTest = net.ReadString()
                info:SetText('Current Time : ' .. SomeShittyTest )
            end)
            net.Receive("RefreshTime2", function(lan)
                SomeShittyTest1 = net.ReadString()
                info2:SetText('Warn Time : ' .. SomeShittyTest1 )
            end)
			net.Receive("RefreshTime3", function(lan)
            	SomeShittyTest2 = net.ReadString()
				 info3:SetText('SuperAdmin bypass : ' .. SomeShittyTest2 )
    		end)
			timer.Create("Checkifvalueistruefromafk", 1, 1, function()
			if SomeShittyTest2 == "true" then
				checkboxSPbypass:SetValue( 1 )
			end
	    end)
    end

	local Groups_btn = vgui.Create("DButton")
	Groups_btn:SetParent( MainPanel )
	Groups_btn:SetText( "Groups" )
	Groups_btn:SetPos( 213, 90 )
	Groups_btn:SetSize( 55, 20 )
    Groups_btn:SetColor(Color(255, 255, 255))
	Groups_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Groups_btn.DoClick = function ()
		MainPanel:Close()
		AntiafkAdminPanelGroups()
	end

	local Sign = vgui.Create( "DLabel", MainPanel )
	Sign:SetPos( 100, 180 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )




end


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




net.Start("AntiAfkSendHUDInfo")

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
	end
end)