function nntdrawCircle( x, y, radius, seg , color)
	nntcirle = {}
	table.insert( nntcirle, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( nntcirle, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end
	surface.SetDrawColor(color)
	surface.DrawPoly( nntcirle )
end


surface.CreateFont( "HUDLARGETEXT", {
	font = "Arial",
	size = 16,
	weight = 1300,
} )

surface.CreateFont( "HUDLARGEMEDIUM", {
	font = "Arial",
	size = 15,
	weight = 600,
} )

surface.CreateFont( "HUDLARGESMALL", {
	font = "Arial",
	size = 15,
	weight = 530,
} )

local SKIN = {}
	ComboBoxNormal		= GWEN.CreateTextureBorder( 384, 336+32, 127, 31, 8, 8, 32, 8,  Material( "gwenskin/GModDefault.png" ) )
	ComboBoxHover		= GWEN.CreateTextureBorder( 384, 336+32, 127, 31, 8, 8, 32, 8,  Material( "gwenskin/GModDefault.png" )  )
	ComboBoxDown		= GWEN.CreateTextureBorder( 384, 336+32, 127, 31, 8, 8, 32, 8,  Material( "gwenskin/GModDefault.png" )  )
	ComboBoxDisabled	= GWEN.CreateTextureBorder( 384, 336+96, 127, 31, 8, 8, 32, 8,  Material( "gwenskin/GModDefault.png" )  )

	ComboBoxButtonNormal	= GWEN.CreateTextureNormal( 496, 272,    15, 15,  Material( "gwenskin/GModDefault.png" ) )
	ComboBoxButtonHover		= GWEN.CreateTextureNormal( 496, 272+16, 15, 15,  Material( "gwenskin/GModDefault.png" ) )
	ComboBoxButtonDown		= GWEN.CreateTextureNormal( 496, 272+32, 15, 15,  Material( "gwenskin/GModDefault.png" ) )
	ComboBoxButtonDisabled	= GWEN.CreateTextureNormal( 496, 272+48, 15, 15,  Material( "gwenskin/GModDefault.png" ) )

	SKIN.fontFrame = "Default"
	SKIN.fontTab = "Default"
	SKIN.fontButton = "Default"
	SKIN.Colours = table.Copy(derma.SkinList.Default.Colours)
	SKIN.Colours.Window.TitleActive = Color(0, 0, 0)
	SKIN.Colours.Window.TitleInactive = Color(255, 255, 255)

	SKIN.Colours.Button.Normal = Color(80, 80, 80)
	SKIN.Colours.Button.Hover = Color(255, 255, 255)
	SKIN.Colours.Button.Down = Color(180, 180, 180)
	SKIN.Colours.Button.Disabled = Color(0, 0, 0, 100)

	function SKIN:PaintFrame(panel)
		surface.SetDrawColor(45, 45, 45, 200)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

		surface.SetDrawColor(0, 123, 255,255)
		surface.DrawRect(0, 0, panel:GetWide(), 32)

        surface.SetDrawColor(0, 0, 0,80)
		surface.DrawRect(0, 0, panel:GetWide(), 18)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawRect(0, 32, panel:GetWide(), panel:GetTall())

        surface.SetFont( "HudHintTextLarge" )
	    surface.SetTextColor( 255, 255, 255 )
	    surface.SetTextPos( 10, 10 )
	    surface.DrawText( "[NNT] Anti-AFK | Version :" .. NNTAntiAfkCurrentVersion )

	end

	function SKIN:PaintPanel( panel, w, h )
		if ( !panel.m_bBackground ) then return end
		surface.SetDrawColor(0, 0,  0, 255)
		surface.SetDrawColor(240, 240,  240, 255)
		DisableClipping( true )
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(0, 0, 0, 255)
		DisableClipping( false )
		if !panel.Title then return end
		DisableClipping( true )
		for k,v in pairs(panel.Title) do
			if v["font"] then
				surface.SetFont(  v["font"] )
			else
				surface.SetFont( "ChatFont" )
			end
			local a , b = surface.GetTextSize(k)
			if v["align"] == "center" then
				surface.SetTextPos(v["x"] - ( a / 2.2 )  , v["y"]  )
				else
				surface.SetTextPos(v["x"]   , v["y"]  )
			end
			surface.DrawText(k)
		end
		DisableClipping( false )

	end

	function SKIN:PaintSliderKnob( panel, w, h )
		DisableClipping( true )
		local seg =  4
		local radius = 9
		local x = w / 2
		local y = h / 2
		local color = Color(33, 110, 255, 255)
		local color2 = Color(0, 0, 0, 100)
		local color3 = Color(26, 83, 188, 200)

		draw.NoTexture()
		if ( panel:GetDisabled() ) then	return self.tex.Input.Slider.H.Disabled( 0, 0, w, h ) end

		if ( panel.Depressed ) then
			nntdrawCircle(x, y, radius, seg , color2) nntdrawCircle(x, y, radius, seg , color)
		end

		if ( panel.Hovered ) then
			nntdrawCircle(x, y, radius, seg , color2) nntdrawCircle(x, y, radius, seg , color)
		end


		nntdrawCircle(x, y,11, seg , color3) nntdrawCircle(x, y, radius, seg , color) nntdrawCircle(x, y, 6, seg , color2)
		DisableClipping( false  )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )



	end

	local function PaintNotches( x, y, w, h, num )

		if ( !num ) then return end

		local space = w / num

		for i=0, num do

			surface.DrawRect( x + i * space, y + 4, 1,  5 )

		end

	end

	function SKIN:PaintNumSlider( panel, w, h )

		surface.SetDrawColor( Color( 0, 0, 0, 255 ) )
		surface.DrawRect( 8, h / 2 - 1, w - 15, 1 )
		//PaintNotches( 8, h / 2 - 1, w - 16, 1, panel.m_iNotches )

	end
--[[---------------------------------------------------------
	ComboBox
-----------------------------------------------------------]]

	function SKIN:PaintComboBox( panel, w, h )
		panel:SetTextColor(Color(0,0,0,255))
		local function fuck()
			DisableClipping( true )
			draw.RoundedBox(5, -1, -1,w, h, Color( 0, 0, 0, 255))
			draw.RoundedBox(5, 0, 0,w-2, h-2, Color( 255, 255, 255, 255))
			DisableClipping( false )
		end
		if ( panel:GetDisabled() ) then
			return ComboBoxDisabled( 0, 0, w, h )
		end

		if ( panel.Depressed || panel:IsMenuOpen() ) then
			return fuck()
		end

		if ( panel.Hovered ) then
			return fuck()
		end

		//ComboBoxNormal( 0, 0, w, h )
		DisableClipping( true )
		draw.RoundedBox(5, -1, -1,w, h, Color( 0, 0, 0, 255))
		draw.RoundedBox(5, 0, 0,w-2, h-2, Color(255, 255, 255, 255))
		DisableClipping( false )
	end

	function SKIN:PaintListBox( panel, w, h )

		self.tex.Input.ListBox.Background( 0, 0, w, h )

	end

--[[---------------------------------------------------------
	TextEntry
-----------------------------------------------------------]]
function SKIN:PaintTextEntry( panel, w, h )

	if ( panel.m_bBackground ) then

		if ( panel:GetDisabled() ) then
			self.tex.TextBox_Disabled( 0, 0, w, h )
		elseif ( panel:HasFocus() ) then
			self.tex.TextBox_Focus( 0, 0, w, h )
		else
			self.tex.TextBox( 0, 0, w, h )
		end

	end
	surface.SetDrawColor(0, 0, 0, 255)
	surface.SetTextPos(0, 0)
	surface.DrawText(panel:GetValue())

end


--[[---------------------------------------------------------
	PropertySheet
-----------------------------------------------------------]]


    function SKIN:PaintPropertySheet( panel, w, h )

	    -- TODO: Tabs at bottom, left, right
	    local ActiveTab = panel:GetActiveTab()
	    local Offset = 10
	    if ( ActiveTab ) then Offset = ActiveTab:GetTall()-8 end
        surface.SetDrawColor(221, 221, 221, 255)
        surface.DrawRect(0, 20, w, h)

    end

--[[---------------------------------------------------------
	Tab
-----------------------------------------------------------]]

    function SKIN:PaintTab( panel, w, h )
        panel:SetTextColor(Color( 0, 0, 0, 255 ))
	    if ( panel:GetPropertySheet():GetActiveTab() == panel ) then
		    return self:PaintActiveTab( panel, w, h )
	    end
	    surface.SetDrawColor(244, 244, 244, 255)
        surface.DrawRect(0, 20, w, h)

    end

    function SKIN:PaintActiveTab( panel, w, h )
		DisableClipping( true )
	    surface.SetDrawColor(66, 66, 66, 255)
        surface.DrawRect(0, 20, w, 5)
		DisableClipping( false )

    end



	function SKIN:DrawGenericBackground(x, y, w, h)
		surface.SetDrawColor(45, 45, 45, 240)
		surface.DrawRect(x, y, w, h)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(x, y, w, h)

		surface.SetDrawColor(100, 100, 100, 25)
		surface.DrawOutlinedRect(x + 1, y + 1, w - 2, h - 2)
	end



	function SKIN:PaintButton(panel)
		if (panel:GetPaintBackground()) then
			local w, h = panel:GetWide(), panel:GetTall()
			DisableClipping( true )
			draw.RoundedBox( 8, 0, 0, w  , h + 3 ,  Color(0, 0, 0, 200) )
			DisableClipping( false )
			draw.RoundedBox( 8, 0, 0, w, h,  Color(26, 83, 188, 255) )
		end
	end
    function SKIN:PaintWindowCloseButton( panel, w, h )
        DisableClipping( true )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( Material("nnt-antiafk/exit.png"))
	    surface.DrawTexturedRect( 0, 4, 24, 24 )
        DisableClipping( false )
    end

	-- I don't think we gonna need minimize button and maximize button.
	function SKIN:PaintWindowMinimizeButton( panel, w, h )
	end

	function SKIN:PaintWindowMaximizeButton( panel, w, h )
	end

derma.DefineSkin("NNT-AntiAFK", "[NNT] Skin", SKIN)
derma.RefreshSkins()