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
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial(Material("nnt-antiafk/Main-BG.png"))
			surface.DrawTexturedRect( 0, 0, 500, 400 )

			DisableClipping(true)
			surface.SetFont( "HudHintTextLarge" )
	    	surface.SetTextColor( 255, 255, 255 )
	    	surface.SetTextPos( 18, 9 )
	    	surface.DrawText( "[NNT] Anti-AFK | Version :" .. NNTAntiAfkCurrentVersion  )
			DisableClipping(false)

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

		if ( panel.Depressed ) then
			nntdrawCircle(x, y, radius, seg , color2) nntdrawCircle(x, y, radius, seg , color)
		end

		if ( panel.Hovered ) then
			nntdrawCircle(x, y, radius, seg , color2) nntdrawCircle(x, y, radius, seg , color)
		end

		nntdrawCircle(x, y,11, seg , color3) nntdrawCircle(x, y, radius, seg , color) nntdrawCircle(x, y, 6, seg , color2)
		DisableClipping( false  )



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
	CheckBox
-----------------------------------------------------------]]

function SKIN:PaintCheckBox( panel, w, h )
	DisableClipping(true)
	if ( panel:GetChecked() ) then
		if panel:GetParent().SetAnimtionPos == 2 then
			panel:GetParent().SetAnimtionPos = 18
		end
		draw.RoundedBox(7, 1, -1, 37, panel:GetTall(), Color(52, 105, 229))
		draw.RoundedBox(7,panel:GetParent().SetAnimtionPos, 1, 16, 16, Color(255, 255, 255))
	else
		draw.RoundedBox(7, 1, -1, 37, panel:GetTall(), Color(211, 211, 211))
		draw.RoundedBox(7,panel:GetParent().SetAnimtionPos + 1 , 1, 16, 16, Color(255, 255, 255))
	end
	DisableClipping(false)
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
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial(Material("nnt-antiafk/Small-BTN.png"))
			surface.DrawTexturedRect( 0, 0, 100, 30 )
			DisableClipping( false )
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

--[[---------------------------------------------------------
	DCheckBoxLabel
-----------------------------------------------------------]]

local DCHECKPANEL = {}   --- this is just for adding space for the switch !

AccessorFunc( DCHECKPANEL, "m_iIndent", "Indent" )

function DCHECKPANEL:Init()
	self:SetTall( 16 )

	self.Button = vgui.Create( "DCheckBox", self )
	self.Button.OnChange = function( _, val ) self:OnChange( val ) end

	self.Label = vgui.Create( "DLabel", self )
	self.Label:SetMouseInputEnabled( true )
	self.Label.DoClick = function() self:Toggle() end
end

function DCHECKPANEL:SetDark( b )
	self.Label:SetDark( b )
end

function DCHECKPANEL:SetBright( b )
	self.Label:SetBright( b )
end

function DCHECKPANEL:SetConVar( cvar )
	self.Button:SetConVar( cvar )
end

function DCHECKPANEL:SetValue( val )
	self.Button:SetValue( val )
end

function DCHECKPANEL:SetChecked( val )
	self.Button:SetChecked( val )
end

function DCHECKPANEL:GetChecked( val )
	return self.Button:GetChecked()
end

function DCHECKPANEL:Toggle()
	self.Button:Toggle()
end

function DCHECKPANEL:PerformLayout()

	local x = self.m_iIndent || 0

	self.Button:SetSize( 38, 20 )
	self.Button:SetPos( x, math.floor( ( self:GetTall() - self.Button:GetTall() ) / 2 ) )

	self.Label:SizeToContents()
	self.Label:SetPos( x + self.Button:GetWide() + 9, 1 )

end

function DCHECKPANEL:SetTextColor( color )

	self.Label:SetTextColor( color )

end

function DCHECKPANEL:SizeToContents()

	self:InvalidateLayout( true ) -- Update the size of the DLabel and the X offset
	self:SetWide( self.Label.x + self.Label:GetWide() )
	self:SetTall( math.max( self.Button:GetTall(), self.Label:GetTall() ) )
	self:InvalidateLayout() -- Update the positions of all children

end

function DCHECKPANEL:SetText( text )

	self.Label:SetText( text )
	self:SizeToContents()

end

function DCHECKPANEL:SetFont( font )

	self.Label:SetFont( font )
	self:SizeToContents()

end

function DCHECKPANEL:GetText()

	return self.Label:GetText()

end

function DCHECKPANEL:Paint()
end

function DCHECKPANEL:OnChange( bVal )

	-- For override

end

function DCHECKPANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
	ctrl:SetText( "Switch / CheckBox" )
	ctrl:SetWide( 200 )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "NNTDCheckBoxLabel", "Simple Switch / Checkbox reskin", DCHECKPANEL, "DCheckBoxLabel" )

derma.RefreshSkins()