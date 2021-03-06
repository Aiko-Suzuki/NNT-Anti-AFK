function Default_NNTAntiafkMainHUD(parent)
    if parent then
        w = parent:GetWide() / 2
        h = parent:GetTall() / 2
        pw = parent:GetWide()
        ph = parent:GetTall()
    else
        w = ScrW() / 2
        h = ScrH() / 2
        pw = ScrW()
        ph = ScrH()
    end

    AntiAFKTimer = AntiAFKTimer or {}
    VarTimeleft = "00m 00s"
    AntiAFKTimer.TimeLeft = "00m 00s"
    net.Start("AFKHUD2")
    net.SendToServer()

    net.Receive("AFKHUDR", function(len)
        ReceiveVar = net.ReadString()
        VarTimeleft = ReceiveVar

        timer.Create("AFK:" .. LocalPlayer():SteamID(), 1, ReceiveVar, function()
            x = VarTimeleft - 1
            VarTimeleft = x
            AntiAFKTimer.TimeLeft = timeToStr(VarTimeleft)
        end)
    end)

    AfkPanelHUD = vgui.Create("DFrame")

    if parent then
        AfkPanelHUD:SetParent(parent)
    end

    AfkPanelHUD:SetPos(pw - w * 1.5, h / 1.4)
    AfkPanelHUD:SetSize(pw / 2, ph / 3)
    AfkPanelHUD:SetTitle("")
    AfkPanelHUD:SetDraggable(true)
    AfkPanelHUD:ShowCloseButton(false)
    AfkPanelHUD:SetKeyboardInputEnabled()
    AfkPanelHUD:SetMouseInputEnabled()
    AfkPanelHUD:SetDraggable(false)

    function AfkPanelHUD:Paint(w, h)
        if not parent then
            Derma_DrawBackgroundBlur(AfkPanelHUD, 1)
        end

        draw.RoundedBox(30, 0, 0, w, h, Color(0, 0, 0, 235))

        if not parent then
            draw.DrawText("#nnt.main_text", "AFKLarge", ScrW() - w * 1.5, ScrH() / 16, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(language.GetPhrase("nnt.warn") .. AntiAFKTimer.TimeLeft, "AFKMedium", ScrH() / 2.2, ScrH() / 7, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText("#nnt.cancel", "AFKsmall", ScrW() - w * 1.5, ScrH() / 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText("#nnt.move_key", "AFKsmallK", ScrW() - w * 1.5, ScrH() / 4, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        end
    end

    if not parent then
        timer.Create("AFKS:" .. LocalPlayer():SteamID(), 30, 0, function()
            surface.PlaySound("buttons/button18.wav")
            surface.PlaySound("buttons/button18.wav")
            surface.PlaySound("buttons/button18.wav")
        end)

        net.Start("AFKHUD1")

        net.Receive("AFKHUD1", function(len)
            timer.Remove("AFK:" .. LocalPlayer():SteamID())
            timer.Remove("AFKS:" .. LocalPlayer():SteamID())
            AfkPanelHUD:Close()
        end)

        surface.PlaySound("buttons/button18.wav")
        surface.PlaySound("buttons/button18.wav")
        surface.PlaySound("buttons/button18.wav")
    end
end

NNT_AntiAFK_AddThemes("Default", Default_NNTAntiafkMainHUD)