-- modules/Notify.lua

local TweenService = game:GetService("TweenService")
local Players      = game:GetService("Players")
local LocalPlayer  = Players.LocalPlayer

local module = {}
local ActivePms = {}

-- ── Build the Intuition GUI in-script ────────────────────────────────────────
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenUI = Instance.new("ScreenGui")
ScreenUI.Name           = "Intuition"
ScreenUI.ResetOnSpawn   = false
ScreenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenUI.DisplayOrder   = 50
ScreenUI.Parent         = PlayerGui

-- Format label — matches your GUI data exactly:
-- position x=0.2267, y=0.7964 (scale), size x=0.5467, y=0.0883 (scale), TextSize=31
local Format = Instance.new("TextLabel", ScreenUI)
Format.Name                  = "Format"
Format.AnchorPoint = Vector2.new(0.5, 0)
Format.Position    = UDim2.new(0.5, 0, 0.7964149713516235, 0)  -- x=0.5 = centre
Format.Size        = UDim2.new(0.5466867685317993, 0, 0.08834826946258545, 0)
Format.TextXAlignment = Enum.TextXAlignment.CenterFormat.BackgroundTransparency = 1
Format.Text                  = ""
Format.TextColor3            = Color3.fromRGB(255, 255, 255)
Format.TextSize              = 31
Format.TextScaled            = false
Format.Font                  = Enum.Font.SourceSans
Format.TextYAlignment        = Enum.TextYAlignment.Center
Format.TextTransparency      = 1  -- invisible by default, tweened in
Format.Visible               = true
Format.ZIndex                = 1

-- ── Helpers ───────────────────────────────────────────────────────────────────
local function MoveTextUp()
    for _, label in ipairs(ActivePms) do
        if label and label.Parent then
            label.Position = UDim2.new(
                label.Position.X.Scale,
                label.Position.X.Offset,
                label.Position.Y.Scale - 0.07,
                label.Position.Y.Offset
            )
        end
    end
end

-- ── module.send / module.Intuition (same function, two names) ─────────────────
local function sendNotif(Text, Player, Timer)
    MoveTextUp()
    Timer = Timer or 4

    -- shift existing notifications up slightly
    for _, v in pairs(ScreenUI:GetChildren()) do
        if v.Name ~= "Format" then
            v.Position = UDim2.new(
                v.Position.X.Scale,
                v.Position.X.Offset,
                v.Position.Y.Scale + 0.018,
                v.Position.Y.Offset
            )
        end
    end

    local NewText = Format:Clone()
    NewText.Font            = Enum.Font.SourceSans
    NewText.TextSize        = 49
    NewText.Text            = Text
    NewText.Name            = "NewText"
    NewText.Visible         = true
    NewText.TextTransparency = 1
    NewText.Parent          = ScreenUI

    local TweenIn  = TweenService:Create(NewText, TweenInfo.new(0.5), {TextTransparency = 0})
    local TweenOut = TweenService:Create(NewText, TweenInfo.new(0.5), {TextTransparency = 1})

    table.insert(ActivePms, NewText)
    TweenIn:Play()

    task.delay(Timer, function()
        TweenOut:Play()
        TweenOut.Completed:Wait()
        local idx = table.find(ActivePms, NewText)
        if idx then table.remove(ActivePms, idx) end
        NewText:Destroy()
    end)
end

module.send      = sendNotif
module.Intuition = sendNotif

return module
