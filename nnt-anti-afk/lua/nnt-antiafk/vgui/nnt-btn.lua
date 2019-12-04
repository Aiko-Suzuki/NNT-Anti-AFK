local PANEL = {}
AccessorFunc(PANEL, "m_bBorder", "DrawBorder", FORCE_BOOL)

function PANEL:Init()
    self:SetContentAlignment(5)
    --
    -- These are Lua side commands
    -- Defined above using AccessorFunc
    --
    self:SetDrawBorder(true)
    self:SetPaintBackground(true)
    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetCursor("hand")
    self:SetFont("DermaDefault")
end

function PANEL:IsDown()
    return self.Depressed
end

function PANEL:SetImage(img)
    if (not img) then
        if (IsValid(self.m_Image)) then
            self.m_Image:Remove()
        end

        return
    end

    if (not IsValid(self.m_Image)) then
        self.m_Image = vgui.Create("DImage", self)
    end

    self.m_Image:SetImage(img)
    self.m_Image:SizeToContents()
end

function PANEL:Paint(w, h)
    local textposX, textposY = self.TextPos, 5

    if self.Activated then
        draw.RoundedBox(0, 0, 0, w, h, Color(75, 75, 75, 255))
        draw.DrawText(self:GetText(), "DermaDefault", textposX, textposY, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
    else
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 255))
        draw.DrawText(self:GetText(), "DermaDefault", textposX, textposY, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
    end

    return true
end

function PANEL:UpdateColours(skin)
    if (not self:IsEnabled()) then return self:SetTextStyleColor(skin.Colours.Button.Disabled) end
    if (self:IsDown() or self.m_bSelected) then return self:SetTextStyleColor(skin.Colours.Button.Down) end
    if (self.Hovered) then return self:SetTextStyleColor(skin.Colours.Button.Hover) end

    return self:SetTextStyleColor(skin.Colours.Button.Normal)
end

function PANEL:PerformLayout()
    if (IsValid(self.m_Image)) then
        self.m_Image:SetPos(1, (self:GetTall() - self.m_Image:GetTall()) * 0.5)
    end

    DLabel.PerformLayout(self)
end

function PANEL:SetFunc(func)
    self.DoClick = function()
        func()
    end
end

function PANEL:SizeToContents()
    local w, h = self:GetContentSize()
    self:SetSize(w + 8, h + 4)
end

local PANEL = derma.DefineControl("nnt-nav-btn", "nnt navigation button", PANEL, "DLabel")
local PANEL = {}
AccessorFunc(PANEL, "m_bBorder", "DrawBorder", FORCE_BOOL)

function PANEL:Init()
    self:SetContentAlignment(5)
    --
    -- These are Lua side commands
    -- Defined above using AccessorFunc
    --
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetCursor("hand")
end

function PANEL:IsDown()
    return self.Depressed
end

function PANEL:Paint(w, h)
    surface.DisableClipping(true)
    surface.SetDrawColor(43, 187, 101, 255)

    if self.SetRed then
        surface.SetDrawColor(186, 32, 32, 255)
    end

    if self:IsDown() then
        surface.DrawRect(0, 0, w, h)
    else
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
    end

    --surface.DrawTexturedRect( 0, 0, w, h )
    surface.DisableClipping(false)
end

local PANEL = derma.DefineControl("nnt-small-btn", "nnt small button", PANEL, "DButton")