NNTAntiafkThemes.Large = "Large_NNTAntiafkMainHUD()"
function Large_NNTAntiafkMainHUD()

	local w = ScrW() / 2
    local h = ScrH() / 2

	AntiAFKTimer = AntiAFKTimer or {}


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
	AntiAFKTimer.TimeLeft = "00m 00s"

	net.Start("AFKHUD2")
	net.SendToServer()
	net.Receive("AFKHUDR", function(len)
		ReceiveVar = net.ReadString()
		VarTimeleft = ReceiveVar
		timer.Create( "AFK:"..LocalPlayer():SteamID(), 1, ReceiveVar, function()
			x = VarTimeleft - 1
			VarTimeleft = x
			AntiAFKTimer.TimeLeft = timeToStr(VarTimeleft)
		end)
	end)

	local AfkPanelHUD = vgui.Create( "DFrame" )
	AfkPanelHUD:SetPos( 0  , h-200 )
	AfkPanelHUD:SetSize( ScrW(), ScrH() / 3 )
	AfkPanelHUD:SetTitle( "" )
	AfkPanelHUD:SetDraggable( true )
	AfkPanelHUD:ShowCloseButton( false )
	AfkPanelHUD:SetKeyBoardInputEnabled()
	AfkPanelHUD:SetMouseInputEnabled()
	AfkPanelHUD:SetDraggable(false)
	function AfkPanelHUD:Paint(w, h)
		Derma_DrawBackgroundBlur(AfkPanelHUD,1)
		draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 0, 235))
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["MAINTEXT"] , "AFKLarge", ScrW()/2  , ScrH() / 16, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["WARN"].. " " .. AntiAFKTimer.TimeLeft , "AFKMedium", ScrW()/2  , ScrH() / 7, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["CANCEL"] , "AFKsmall", ScrW()/2  , ScrH() / 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["MOVEKEY"]  , "AFKsmallK", ScrW()/2  , ScrH() / 4, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end


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