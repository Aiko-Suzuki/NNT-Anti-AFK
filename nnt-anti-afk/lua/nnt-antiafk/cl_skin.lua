

local SKIN = {}
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
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255)

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
			local alpha = 50

			if (panel:GetDisabled()) then
				alpha = 10
			elseif (panel.Depressed) then
				alpha = 180
			elseif (panel.Hovered) then
				alpha = 75
			end

			surface.SetDrawColor(30, 30, 30, alpha)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 0, 180)
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(180, 180, 180, 2)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
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