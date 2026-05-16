-- main.lua
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/aizen2tuffy/zero/main/main.lua"))()

-- ── Already loaded guard ──────────────────────────────────────────────────────
if _G.ZERO_LOADED then
	warn("[Zero] Already loaded.")
	return
end
_G.ZERO_LOADED = true

local GITHUB_RAW = "https://raw.githubusercontent.com/aizen2tuffy/zero/main/"

local function loadModule(path)
	return loadstring(game:HttpGet(GITHUB_RAW .. path))()
end

-- ── Services ──────────────────────────────────────────────────────────────────
local Players     = game:GetService("Players")
local UIS         = game:GetService("UserInputService")
local RunService  = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ── Modules ───────────────────────────────────────────────────────────────────
local Notify = loadModule("modules/Notify.lua")
_G.__ZeroNotify = Notify

local Commands = loadModule("modules/Commands.lua")

-- ── Build GUI in-script ───────────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name                = "CommandBarGui"
ScreenGui.ResetOnSpawn        = false
ScreenGui.ZIndexBehavior      = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder        = 10
ScreenGui.IgnoreGuiInset      = true
ScreenGui.Parent              = PlayerGui

local Frame = Instance.new("Frame")
Frame.Name                    = "Frame"
Frame.AnchorPoint             = Vector2.new(0, 0)
Frame.Position                = UDim2.new(0, 0, 0, 0)
Frame.Size                    = UDim2.new(1, 0, 0, 26)   -- full-width, 26px tall (matches GUI data)
Frame.BackgroundColor3        = Color3.fromRGB(30, 30, 40)
Frame.BackgroundTransparency  = 0.15
Frame.BorderSizePixel         = 0
Frame.Visible                 = false
Frame.ZIndex                  = 1
Frame.Parent                  = ScreenGui

-- subtle bottom border line
local Divider = Instance.new("Frame")
Divider.Name                  = "Divider"
Divider.AnchorPoint           = Vector2.new(0, 1)
Divider.Position              = UDim2.new(0, 0, 1, 0)
Divider.Size                  = UDim2.new(1, 0, 0, 1)
Divider.BackgroundColor3      = Color3.fromRGB(100, 100, 180)
Divider.BackgroundTransparency = 0
Divider.BorderSizePixel       = 0
Divider.ZIndex                = 2
Divider.Parent                = Frame

local TextBox = Instance.new("TextBox")
TextBox.Name                  = "TextBox"
TextBox.AnchorPoint           = Vector2.new(0.5, 0.5)
TextBox.Position              = UDim2.new(0.5, 0, 0.5, 0)
TextBox.Size                  = UDim2.new(1, 0, 0, 26)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3            = Color3.fromRGB(230, 230, 255)
TextBox.PlaceholderColor3     = Color3.fromRGB(110, 110, 140)
TextBox.PlaceholderText       = "enter command…"
TextBox.Text                  = ""
TextBox.TextSize              = 14
TextBox.Font                  = Enum.Font.Gotham
TextBox.TextXAlignment        = Enum.TextXAlignment.Left
TextBox.TextEditable          = true
TextBox.ClearTextOnFocus      = false
TextBox.ZIndex                = 1
TextBox.Visible               = true
TextBox.Parent                = Frame

-- left padding via UIPadding
local Pad = Instance.new("UIPadding")
Pad.PaddingLeft  = UDim.new(0, 6)
Pad.PaddingRight = UDim.new(0, 6)
Pad.Parent       = TextBox

-- ── Suggestion label (sits just below the bar) ────────────────────────────────
local SuggestLabel = Instance.new("TextLabel")
SuggestLabel.Name               = "ZeroSuggest"
SuggestLabel.AnchorPoint        = Vector2.new(0, 0)
SuggestLabel.Position           = UDim2.new(0, 4, 1, 2)
SuggestLabel.Size               = UDim2.new(1, -8, 0, 18)
SuggestLabel.BackgroundTransparency = 1
SuggestLabel.TextColor3         = Color3.fromRGB(130, 130, 160)
SuggestLabel.TextSize           = 12
SuggestLabel.Font               = Enum.Font.Gotham
SuggestLabel.TextXAlignment     = Enum.TextXAlignment.Left
SuggestLabel.Text               = ""
SuggestLabel.ZIndex             = 5
SuggestLabel.Visible            = false
SuggestLabel.Parent             = Frame

-- ── State ─────────────────────────────────────────────────────────────────────
local _open    = false
local _history = {}
local _histIdx = 0

-- ── Open / close ──────────────────────────────────────────────────────────────
local function openBar()
	_open         = true
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
	SuggestLabel.Text    = ""
	SuggestLabel.Visible = false
end

local function toggleBar()
	if _open then closeBar() else openBar() end
end

-- ── Autocomplete ──────────────────────────────────────────────────────────────
local _topSuggestion = nil

local function updateSuggestions(text)
	_topSuggestion = nil
	if text == "" or text:find(" ") then
		SuggestLabel.Visible = false
		SuggestLabel.Text    = ""
		return
	end
	local word    = (text:match("^(%S+)") or ""):lower()
	local matches = {}
	for name in pairs(Commands.list) do
		if name:sub(1, #word) == word and name ~= word then
			table.insert(matches, name)
		end
	end
	if #matches == 0 then
		SuggestLabel.Visible = false
		SuggestLabel.Text    = ""
	else
		table.sort(matches)
		_topSuggestion       = matches[1]
		SuggestLabel.Text    = table.concat(matches, "   ")
		SuggestLabel.Visible = true
	end
end

-- ── Execute ───────────────────────────────────────────────────────────────────
local function execute(raw)
	if not raw or raw == "" then return end

	if raw:lower() == "unload" then
		Notify.send("Zero admin unloaded.", LocalPlayer, 3)
		task.delay(0.5, function()
			closeBar()
			ScreenGui:Destroy()
			_G.ZERO_LOADED  = nil
			_G.__ZeroNotify = nil
		end)
		return
	end

	if _history[#_history] ~= raw then
		table.insert(_history, raw)
	end
	_histIdx = #_history + 1

	local parts   = raw:split(" ")
	local cmdName = parts[1]:lower()
	table.remove(parts, 1)

	local cmd = Commands.list[cmdName]
	if cmd then
		local ok, err = pcall(cmd, LocalPlayer, parts)
		if not ok then
			Notify.send("Error: " .. tostring(err), LocalPlayer, 5)
		end
	else
		Notify.send("Unknown: " .. cmdName, LocalPlayer, 3)
	end
end

-- ── Input ─────────────────────────────────────────────────────────────────────
-- Toggle on ; (Quote/Semicolon)
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Semicolon or input.KeyCode == Enum.KeyCode.Quote then
		toggleBar()
	end
end)

-- TextBox live autocomplete
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	if _open then updateSuggestions(TextBox.Text) end
end)

-- History nav + Tab autocomplete
UIS.InputBegan:Connect(function(input, gameProcessed)
	if not _open then return end
	if input.KeyCode == Enum.KeyCode.Up then
		_histIdx               = math.max(1, _histIdx - 1)
		TextBox.Text           = _history[_histIdx] or ""
		TextBox.CursorPosition = #TextBox.Text + 1
	elseif input.KeyCode == Enum.KeyCode.Down then
		_histIdx               = math.min(#_history + 1, _histIdx + 1)
		TextBox.Text           = _history[_histIdx] or ""
		TextBox.CursorPosition = #TextBox.Text + 1
	elseif input.KeyCode == Enum.KeyCode.Tab then
		if _topSuggestion then
			TextBox.Text           = _topSuggestion .. " "
			TextBox.CursorPosition = #TextBox.Text + 1
		end
	end
end)

-- FocusLost
TextBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local text = TextBox.Text
		TextBox.Text         = ""
		_open                = false
		Frame.Visible        = false
		SuggestLabel.Visible = false
		SuggestLabel.Text    = ""
		if text and text ~= "" then
			execute(text)
		end
	else
		closeBar()
	end
end)

Notify.send("Zero admin loaded. Press ; to open.", LocalPlayer, 4)
