-- main.lua
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/aizen2tuffy/zero/main/main.lua"))()

-- ── Already loaded guard ──────────────────────────────────────────────────────
if _G.ZERO_LOADED then
	warn("[Zero] Already loaded.")
	return
end
_G.ZERO_LOADED = true

local GITHUB_RAW = "https://raw.githubusercontent.com/aizen2tuffy/zero/main/main.lua"

local function loadModule(path)
	return loadstring(game:HttpGet(GITHUB_RAW .. path))()
end

-- ── Services ──────────────────────────────────────────────────────────────────
local Players     = game:GetService("Players")
local UIS         = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ── Modules ───────────────────────────────────────────────────────────────────
local Notify = loadModule("modules/Notify.lua")
_G.__ZeroNotify = Notify

local Commands = loadModule("modules/Commands.lua")

-- ── Safety wrappers so nil modules don't hard-crash ───────────────────────────
local function safeNotify(msg, plr, dur)
	if Notify and type(Notify.send) == "function" then
		Notify.send(msg, plr, dur)
	else
		warn("[Zero] " .. tostring(msg))
	end
end

local function getCommandList()
	if Commands and type(Commands.list) == "table" then
		return Commands.list
	end
	return {}
end

-- ── Build GUI in-script ───────────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name             = "ZeroCommandBarGui"
ScreenGui.ResetOnSpawn     = false
ScreenGui.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder     = 10
ScreenGui.IgnoreGuiInset   = true
ScreenGui.Parent           = PlayerGui

-- Centered container — sits in the middle of the screen
local Frame = Instance.new("Frame")
Frame.Name                   = "Frame"
Frame.AnchorPoint            = Vector2.new(0.5, 0.5)
Frame.Position               = UDim2.new(0.5, 0, 0.5, 0)   -- dead centre
Frame.Size                   = UDim2.new(0.55, 0, 0, 40)    -- ~55% wide, 40px tall
Frame.BackgroundColor3       = Color3.fromRGB(22, 22, 32)
Frame.BackgroundTransparency = 0.08
Frame.BorderSizePixel        = 0
Frame.Visible                = false
Frame.ZIndex                 = 1
Frame.Parent                 = ScreenGui

-- Rounded corners
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent       = Frame

-- Accent border via UIStroke
local Stroke = Instance.new("UIStroke")
Stroke.Color       = Color3.fromRGB(110, 100, 220)
Stroke.Thickness   = 1.5
Stroke.Transparency = 0.4
Stroke.Parent      = Frame

-- TextBox
local TextBox = Instance.new("TextBox")
TextBox.Name                  = "TextBox"
TextBox.AnchorPoint           = Vector2.new(0.5, 0.5)
TextBox.Position              = UDim2.new(0.5, 0, 0.5, 0)
TextBox.Size                  = UDim2.new(1, -16, 1, 0)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3            = Color3.fromRGB(235, 235, 255)
TextBox.PlaceholderColor3     = Color3.fromRGB(100, 100, 130)
TextBox.PlaceholderText       = "enter command…"
TextBox.Text                  = ""
TextBox.TextSize              = 16
TextBox.Font                  = Enum.Font.Gotham
TextBox.TextXAlignment        = Enum.TextXAlignment.Left
TextBox.TextEditable          = true
TextBox.ClearTextOnFocus      = false
TextBox.ZIndex                = 2
TextBox.Parent                = Frame

-- Suggestion label — below the frame, bigger & more visible
local SuggestLabel = Instance.new("TextLabel")
SuggestLabel.Name               = "ZeroSuggest"
SuggestLabel.AnchorPoint        = Vector2.new(0.5, 0)
SuggestLabel.Position           = UDim2.new(0.5, 0, 1, 6)   -- just below Frame
SuggestLabel.Size               = UDim2.new(1, 0, 0, 24)
SuggestLabel.BackgroundColor3   = Color3.fromRGB(22, 22, 32)
SuggestLabel.BackgroundTransparency = 0.15
SuggestLabel.TextColor3         = Color3.fromRGB(180, 170, 255)  -- brighter purple-white
SuggestLabel.TextSize           = 15                             -- was 12
SuggestLabel.Font               = Enum.Font.GothamMedium
SuggestLabel.TextXAlignment     = Enum.TextXAlignment.Left
SuggestLabel.Text               = ""
SuggestLabel.ZIndex             = 5
SuggestLabel.Visible            = false
SuggestLabel.Parent             = Frame                          -- child of Frame so it moves with it

local SuggestCorner = Instance.new("UICorner")
SuggestCorner.CornerRadius = UDim.new(0, 5)
SuggestCorner.Parent       = SuggestLabel

local SuggestPad = Instance.new("UIPadding")
SuggestPad.PaddingLeft  = UDim.new(0, 8)
SuggestPad.PaddingRight = UDim.new(0, 8)
SuggestPad.Parent       = SuggestLabel

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
	_open                = false
	Frame.Visible        = false
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
	for name in pairs(getCommandList()) do
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
		SuggestLabel.Text    = "  " .. table.concat(matches, "   ·   ")
		SuggestLabel.Visible = true
	end
end

-- ── Execute ───────────────────────────────────────────────────────────────────
local function execute(raw)
	if not raw or raw == "" then return end

	if raw:lower() == "unload" then
		safeNotify("Zero admin unloaded.", LocalPlayer, 3)
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

	local cmd = getCommandList()[cmdName]
	if cmd then
		local ok, err = pcall(cmd, LocalPlayer, parts)
		if not ok then
			safeNotify("Error: " .. tostring(err), LocalPlayer, 5)
		end
	else
		safeNotify("Unknown: " .. cmdName, LocalPlayer, 3)
	end
end

-- ── Input ─────────────────────────────────────────────────────────────────────
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Semicolon or input.KeyCode == Enum.KeyCode.Quote then
		toggleBar()
	end
end)

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	if _open then updateSuggestions(TextBox.Text) end
end)

UIS.InputBegan:Connect(function(input, _gp)
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

TextBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local text           = TextBox.Text
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

safeNotify("Zero admin loaded. Press ; to open.", LocalPlayer, 4)
