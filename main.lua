-- main.lua
-- local Url = ("https://cdn.jsdelivr.net/gh/aizen2tuffy/zero@main/main.lua?%d"):format(tick())
-- loadstring(game:HttpGet(Url))()

if _G.ZERO_LOADED then warn("[Zero] Already loaded.") return end
_G.ZERO_LOADED = true

-- ── Password check ────────────────────────────────────────────────────────────
local function passwordCheck(rconsoleprint)
    if not rconsoleprint then return end -- skip if executor doesn't support it
    rconsolename("Zero Admin")
    rconsoleclear()
    local function prompt()
        rconsoleprint("[")
        rconsoleprint("\27[32mKEY\27[0m")
        rconsoleprint("] Please enter your password: ")
        local input = rconsoleinput()
        rconsoleprint("\n")
        if input == "green123" then
            rconsoleprint("\27[32m[KEY] Correct! Loading Zero...\27[0m\n")
            task.wait(0.5)
            rconsoledestroy()
        else
            rconsoleprint("\27[31m[KEY] Incorrect password.\27[0m\n")
            prompt()
        end
    end
    prompt()
end
passwordCheck()

-- ── Core ──────────────────────────────────────────────────────────────────────
local GITHUB_RAW = "https://cdn.jsdelivr.net/gh/aizen2tuffy/zero@main/"
local function loadModule(path)
    return loadstring(game:HttpGet(GITHUB_RAW .. path .. "?t=" .. tick()))()
end

local Players     = game:GetService("Players")
local UIS         = game:GetService("UserInputService")
local RunService  = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

local Notify   = loadModule("modules/Notify.lua")
_G.__ZeroNotify = Notify
local Commands = loadModule("modules/Commands.lua")

local function safeNotify(msg, dur)
    if Notify and type(Notify.send) == "function" then
        Notify.send(msg, LocalPlayer, dur or 4)
    else warn("[Zero] "..tostring(msg)) end
end
local function cmdList()
    return (Commands and type(Commands.list) == "table") and Commands.list or {}
end

local _open    = false
local _history = {}
local _histIdx = 0

-- ── GUI ───────────────────────────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "ZeroAdminGui"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder   = 100
ScreenGui.Parent         = PlayerGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Name                   = "Frame"
Frame.AnchorPoint            = Vector2.new(0, 0.5)
Frame.Position               = UDim2.new(0, 0, 0.5, 0)
Frame.Size                   = UDim2.new(1, 0, 0, 40)
Frame.BackgroundColor3       = Color3.fromRGB(18, 18, 22)
Frame.BackgroundTransparency = 0
Frame.BorderSizePixel        = 0
Frame.ZIndex                 = 1
Frame.Visible                = false

local TextBox = Instance.new("TextBox", Frame)
TextBox.Name                  = "TextBox"
TextBox.AnchorPoint           = Vector2.new(0.5, 0.5)
TextBox.Position              = UDim2.new(0.5, 0, 0.5, 0)
TextBox.Size                  = UDim2.new(1, 0, 0, 26)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3            = Color3.fromRGB(230, 230, 240)
TextBox.PlaceholderColor3     = Color3.fromRGB(85, 85, 110)
TextBox.PlaceholderText       = "enter command..."
TextBox.Text                  = ""
TextBox.TextScaled            = true
TextBox.Font                  = Enum.Font.Gotham
TextBox.TextXAlignment        = Enum.TextXAlignment.Left
TextBox.TextEditable          = true
TextBox.ClearTextOnFocus      = false
TextBox.ZIndex                = 1

local Pad = Instance.new("UIPadding", TextBox)
Pad.PaddingLeft  = UDim.new(0, 6)
Pad.PaddingRight = UDim.new(0, 6)

-- Suggestion dropdown
local SuggestionBar = Instance.new("Frame", ScreenGui)
SuggestionBar.Name                   = "SuggestionBar"
SuggestionBar.AnchorPoint            = Vector2.new(0, 0)
SuggestionBar.Position               = UDim2.new(0, 0, 0.5, 20)
SuggestionBar.Size                   = UDim2.new(1, 0, 0, 0)
SuggestionBar.BackgroundColor3       = Color3.fromRGB(14, 14, 20)
SuggestionBar.BackgroundTransparency = 0
SuggestionBar.BorderSizePixel        = 0
SuggestionBar.ZIndex                 = 2
SuggestionBar.Visible                = false

local SuggestionLayout = Instance.new("UIListLayout", SuggestionBar)
SuggestionLayout.FillDirection = Enum.FillDirection.Vertical
SuggestionLayout.SortOrder     = Enum.SortOrder.LayoutOrder
SuggestionLayout.Padding       = UDim.new(0, 0)

-- ── Suggestions ───────────────────────────────────────────────────────────────
local _topSuggestion   = nil
local _suggestionLabels = {}

local function clearSuggestions()
    for _, l in ipairs(_suggestionLabels) do l:Destroy() end
    _suggestionLabels = {}
    SuggestionBar.Visible = false
    SuggestionBar.Size    = UDim2.new(1, 0, 0, 0)
end

local function updateSuggestions(text)
    clearSuggestions()
    _topSuggestion = nil
    if text == "" or text:find(" ") then return end
    local word = (text:match("^(%S+)") or ""):lower()
    local matches = {}
    for name in pairs(cmdList()) do
        if name:sub(1, #word) == word and name ~= word then
            table.insert(matches, name)
        end
    end
    if #matches == 0 then return end
    table.sort(matches)
    -- cap at 6 suggestions
    local ROW_H = 28
    for i = 1, math.min(#matches, 6) do
        local name = matches[i]
        if i == 1 then _topSuggestion = name end
        local row = Instance.new("TextLabel", SuggestionBar)
        row.Size                  = UDim2.new(1, 0, 0, ROW_H)
        row.BackgroundColor3      = i == 1 and Color3.fromRGB(40,35,65) or Color3.fromRGB(14,14,20)
        row.BackgroundTransparency = 0
        row.BorderSizePixel       = 0
        row.TextColor3            = i == 1 and Color3.fromRGB(210,195,255) or Color3.fromRGB(160,150,200)
        row.TextSize              = 15
        row.Font                  = Enum.Font.GothamMedium
        row.TextXAlignment        = Enum.TextXAlignment.Left
        row.Text                  = "  "..name
        row.LayoutOrder           = i
        row.ZIndex                = 3
        table.insert(_suggestionLabels, row)
    end
    SuggestionBar.Size    = UDim2.new(1, 0, 0, ROW_H * math.min(#matches, 6))
    SuggestionBar.Visible = true
end

-- ── Open / close ──────────────────────────────────────────────────────────────
local function openBar()
    _open = true
    Frame.Visible = true
    TextBox.Text  = ""
    task.defer(function()
        task.wait(0.1)
        TextBox:CaptureFocus()
        TextBox.Text         = ""
        TextBox.TextEditable = true
    end)
end

local function closeBar()
    _open         = false
    Frame.Visible = false
    TextBox:ReleaseFocus()
    clearSuggestions()
    TextBox.Text = ""
end

local function toggleBar()
    if _open then closeBar() else openBar() end
end

-- ── Execute ───────────────────────────────────────────────────────────────────
local function execute(raw)
    if not raw or raw == "" then return end
    if raw:lower() == "unload" then
        safeNotify("Zero unloaded.", 3)
        task.delay(0.5, function()
            closeBar()
            task.delay(0.3, function()
                ScreenGui:Destroy()
                _G.ZERO_LOADED  = nil
                _G.__ZeroNotify = nil
            end)
        end)
        return
    end
    if _history[#_history] ~= raw then table.insert(_history, raw) end
    _histIdx = #_history + 1
    local parts   = raw:split(" ")
    local cmdName = parts[1]:lower()
    table.remove(parts, 1)
    local cmd = cmdList()[cmdName]
    if cmd then
        local ok, err = pcall(cmd, LocalPlayer, parts)
        if not ok then safeNotify("Error: "..tostring(err), 5) end
    else
        safeNotify("Unknown: "..cmdName, 3)
    end
end

-- ── Input ─────────────────────────────────────────────────────────────────────
local IYMouse = LocalPlayer:GetMouse()
IYMouse.KeyDown:Connect(function(key)
    if key == ";" then RunService.RenderStepped:Wait() toggleBar() end
end)

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Semicolon or input.KeyCode == Enum.KeyCode.Quote then toggleBar() end
end)

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    if _open then updateSuggestions(TextBox.Text) end
end)

UIS.InputBegan:Connect(function(input, _p)
    if not _open then return end
    if input.KeyCode == Enum.KeyCode.Up then
        _histIdx = math.max(1, _histIdx-1)
        TextBox.Text = _history[_histIdx] or ""
        TextBox.CursorPosition = #TextBox.Text+1
    elseif input.KeyCode == Enum.KeyCode.Down then
        _histIdx = math.min(#_history+1, _histIdx+1)
        TextBox.Text = _history[_histIdx] or ""
        TextBox.CursorPosition = #TextBox.Text+1
    elseif input.KeyCode == Enum.KeyCode.Tab then
        if _topSuggestion then
            TextBox.Text = _topSuggestion.." "
            TextBox.CursorPosition = #TextBox.Text+1
        end
    end
end)

TextBox.FocusLost:Connect(function(enterPressed)
    if not _open then return end
    if enterPressed then
        local text = TextBox.Text
        closeBar()
        execute(text)
    else
        closeBar()
    end
end)

safeNotify("Zero loaded. Press ; to open.", 4)
