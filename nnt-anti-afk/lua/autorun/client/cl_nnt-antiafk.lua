

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
	SignL:SetText( "AFK WARNING !" )

    local SignM = vgui.Create( "DLabel", AfkPanelHUD )
	SignM:SetPos( w-225,  ScrH() / 6)
    SignM:SetSize( 800, 50)
    SignM:SetFont("AFKMedium")
    SignM:SetColor(Color(255, 255, 255, 255))
	SignM:SetText( "You are gonna be kicked for afk in ".. VarTimeleft .." !" )

	local SignS = vgui.Create( "DLabel", AfkPanelHUD )
	SignS:SetPos( w-80,  ScrH() / 4.8)
    SignS:SetSize( 300, 50)
    SignS:SetFont("AFKsmall")
    SignS:SetColor(Color(255, 255, 255, 255))
	SignS:SetText( "Press any key to cancel !" )

    local SignK = vgui.Create( "DLabel", AfkPanelHUD )
	SignK:SetPos( w-170,  ScrH() / 4.1)
    SignK:SetSize( 500, 50)
    SignK:SetFont("AFKsmallK")
    SignK:SetColor(Color(255, 255, 255, 255))
	SignK:SetText( "(Moving Key / Space / Use key / Reload Key / Zoom key)" )

	net.Start("AFKHUD2")
	net.SendToServer(LocalPlayer())
	net.Receive("AFKHUDR", function(len)
		ReceiveVar = net.ReadString()
		SignM:SetText( "You are gone be kicked for afk in ".. timeToStr(ReceiveVar) .." !" )
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
			SignM:SetText( "You are gone be kicked for afk in ".. timeToStr(VarTimeleft) .." !" )
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
	SignL:SetText( "AFK WARNING !" )

    local SignM = vgui.Create( "DLabel", AfkPanelHUD )
	SignM:SetPos( w-135,  ScrH() / 6)
    SignM:SetSize( 800, 50)
    SignM:SetFont("AFKMedium")
    SignM:SetColor(Color(255, 255, 255, 255))
	SignM:SetText( "You afk since ".. "00h 00m 00s" .." ! " )

	local SignS = vgui.Create( "DLabel", AfkPanelHUD )
	SignS:SetPos( w-118,  ScrH() / 4.8)
    SignS:SetSize( 300, 50)
    SignS:SetFont("AFKsmall")
    SignS:SetColor(Color(255, 255, 255, 255))
	SignS:SetText( "Press any key remove the warning !" )

    local SignK = vgui.Create( "DLabel", AfkPanelHUD )
	SignK:SetPos( w-170,  ScrH() / 4.1)
    SignK:SetSize( 500, 50)
    SignK:SetFont("AFKsmallK")
    SignK:SetColor(Color(255, 255, 255, 255))
	SignK:SetText( "(Moving Key / Space / Use key / Reload Key / Zoom key)" )



	net.Start("AFKHUDSP2")
	net.SendToServer(LocalPlayer())
	net.Receive("AFKHUDRSP", function(len)
		ReceiveVar = net.ReadString()
		SignM:SetText( "You are gone be kicked for afk in ".. timeToStr(ReceiveVar) .." !" )
		VarTimeleft = ReceiveVar
		timer.Create( "AFK:"..LocalPlayer():SteamID(), 1, 0, function()
			x = VarTimeleft + 1
			VarTimeleft = x
			SignM:SetText( "You are gone be kicked for afk in ".. timeToStr(VarTimeleft) .." !" )
		end)
	end)



	net.Start("AFKHUDSP1")
	net.Receive("AFKHUDSP1", function(len)
		AfkPanelHUD:Close()
		timer.Destroy("AFK:"..LocalPlayer():SteamID())
	end)


end

local function AntiafkAdminPanel()
	
    local w = ScrW() / 2 
    local h = ScrH() / 2
    PanelOff = nil
    SomeShittyTest = "undefined"
    SomeShittyTest1 = "undefined"
    net.Start("Refresh")
        net.SendToServer(ply)
        net.Receive("RefreshTime1", function(lan)
            SomeShittyTest = net.ReadString()
        end)
        net.Receive("RefreshTime2", function(lan)
            SomeShittyTest1 = net.ReadString()
    	end)




	local list_window = vgui.Create( "DFrame" )
	list_window:SetPos( w-200, h-200 )
	list_window:SetSize( 300, 200 )
	list_window:SetTitle( "ANTI AFK ADMIN PANEL" )
	list_window:SetDraggable( true )
	list_window:ShowCloseButton( true )
	list_window:MakePopup()	
	function list_window:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 225))
	end

	local yetinfo = vgui.Create( "DLabel", list_window )
    yetinfo:SetPos( 5, 5 )
    yetinfo:SetSize(280, 100)
    yetinfo:SetText( "This panel is to change the After how many second \n someone get kick ! \n Or Set the Warning Time !" )
    yetinfo:SetContentAlignment(5)

    local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( list_window )
    TextEntry:SetPos( 22, 100 )
    TextEntry:SetSize( 65, 25 )
    TextEntry:SetMin( 180 )
    TextEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

    local TextEntry2 = vgui.Create( "DNumberWang")
    TextEntry2:SetParent( list_window )
    TextEntry2:SetPos( 120, 100 )
    TextEntry2:SetSize( 65, 25 )
    TextEntry2:SetMin( 180 )
    TextEntry2.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

    local info = vgui.Create( "DLabel", list_window )
    info:SetPos( 200, 60 )
    info:SetSize(280, 100)
    info:SetText('Current Time : ' .. SomeShittyTest )

    local info2 = vgui.Create( "DLabel", list_window )
    info2:SetPos( 200, 45 )
    info2:SetSize(280, 100)
    info2:SetText('Warn Time : ' .. "Refresh !" )
    net.Receive("RefreshTime1", function(lan)
        SomeShittyTest = net.ReadString()
        info:SetText('Current Time : ' .. SomeShittyTest )
    end)
    net.Receive("RefreshTime2", function(lan)
        SomeShittyTest1 = net.ReadString()
        info2:SetText('Warn Time : ' .. SomeShittyTest1 )
    end)
    

    local list_btn = vgui.Create("DButton")
	list_btn:SetParent( list_window )
	list_btn:SetText( "SET KICK" )
	list_btn:SetPos( 22, 140)
	list_btn:SetSize( 65, 20 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn.DoClick = function ()	
			LocalPlayer():ConCommand( 'setafktime ' .. TextEntry:GetValue()  )
	end

    local list_btn2 = vgui.Create("DButton")
	list_btn2:SetParent( list_window )
	list_btn2:SetText( "SET WARN" )
	list_btn2:SetPos( 120, 140)
	list_btn2:SetSize( 65, 20 )
    list_btn2:SetColor(Color(255, 255, 255))
	list_btn2.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn2.DoClick = function ()	
            net.Start("ChangeWarnTime")
                net.WriteString(TextEntry2:GetValue())
            net.SendToServer()
	end

    local RE_btn = vgui.Create("DButton")
	RE_btn:SetParent( list_window )
	RE_btn:SetText( "REFRESH" )
	RE_btn:SetPos( 200, 120)
	RE_btn:SetSize( 50, 15 )
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
    end

	local Sign = vgui.Create( "DLabel", list_window )
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
	data = net.ReadString()
	if (data == "AntiafkAdminSetAfk") then
		
		AntiafkAdminSetAfk()

	elseif (data == "AntiafkMainHUD") then
		
		AntiafkMainHUD()

	elseif (data == "AntiafkMainHUDSP") then

		AntiafkMainHUDSP()

	elseif (data == "AntiafkAdminPanel") then

		AntiafkAdminPanel()

	end
end)

