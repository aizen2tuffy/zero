-- main.lua
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/aizen2tuffy/zero/main/main.lua"))()

if _G.ZERO_LOADED then warn("[Zero] Already loaded.") return end
_G.ZERO_LOADED = true

local GITHUB_RAW = "https://raw.githubusercontent.com/aizen2tuffy/zero/main/"

local function loadModule(path)
	return loadstring(game:HttpGet(GITHUB_RAW .. path))()
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
	else
		warn("[Zero] " .. tostring(msg))
	end
end
local function cmdList()
	return (Commands and type(Commands.list) == "table") and Commands.list or {}
end

local _open    = false
local _history = {}
local _histIdx = 0

-- ── GUI — matches your original exactly, but centred vertically ───────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "ZeroAdminGui"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder   = 100
ScreenGui.Parent         = PlayerGui

-- Frame: full width, 40px tall, anchored at left-centre so it sits mid-screen
local Frame = Instance.new("Frame", ScreenGui)
Frame.Name                   = "Frame"
Frame.AnchorPoint            = Vector2.new(0, 0.5)       -- left edge, vertical centre
Frame.Position               = UDim2.new(0, 0, 0.5, 0)  -- exactly mid-screen vertically
Frame.Size                   = UDim2.new(1, 0, 0, 40)   -- full width, 40px tall
Frame.BackgroundColor3       = Color3.fromRGB(18, 18, 22)
Frame.BackgroundTransparency = 0
Frame.BorderSizePixel        = 0
Frame.ZIndex                 = 1
Frame.Visible                = false  -- hidden by default, no flash

-- TextBox: centred inside Frame, matches original anchor (0.5, 0.5)
local TextBox = Instance.new("TextBox", Frame)
TextBox.Name                  = "TextBox"
TextBox.AnchorPoint           = Vector2.new(0.5, 0.5)
TextBox.Position              = UDim2.new(0.5, 0, 0.5, 0)
TextBox.Size                  = UDim2.new(1, 0, 0, 26)   -- same height as original
TextBox.BackgroundTransparency = 1
TextBox.TextColor3            = Color3.fromRGB(230, 230, 240)
TextBox.PlaceholderColor3     = Color3.fromRGB(85, 85, 110)
TextBox.PlaceholderText       = "enter command..."
TextBox.Text                  = ""
TextBox.TextScaled            = true
TextBox.TextSize              = 14
TextBox.Font                  = Enum.Font.Gotham
TextBox.TextXAlignment        = Enum.TextXAlignment.Left
TextBox.TextEditable          = true
TextBox.ClearTextOnFocus      = false
TextBox.ZIndex                = 1

local Pad = Instance.new("UIPadding", TextBox)
Pad.PaddingLeft  = UDim.new(0, 6)
Pad.PaddingRight = UDim.new(0, 6)

-- Suggestion label — below the Frame, bigger and more visible
local SuggestLabel = Instance.new("TextLabel", Frame)
SuggestLabel.Name               = "ZeroSuggest"
SuggestLabel.AnchorPoint        = Vector2.new(0, 0)
SuggestLabel.Position           = UDim2.new(0, 6, 1, 4)
SuggestLabel.Size               = UDim2.new(1, -12, 0, 22)
SuggestLabel.BackgroundTransparency = 1
SuggestLabel.TextColor3         = Color3.fromRGB(190, 175, 255)
SuggestLabel.TextSize           = 15
SuggestLabel.Font               = Enum.Font.GothamMedium
SuggestLabel.TextXAlignment     = Enum.TextXAlignment.Left
SuggestLabel.Text               = ""
SuggestLabel.ZIndex             = 2
SuggestLabel.Visible            = false

-- ── Open / close — simple Visible toggle, exactly like the original ───────────
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
	for name in pairs(cmdList()) do
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
		safeNotify("Zero admin unloaded.", 3)
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
		if not ok then safeNotify("Error: " .. tostring(err), 5) end
	else
		safeNotify("Unknown: " .. cmdName, 3)
	end
end

-- ── Input ─────────────────────────────────────────────────────────────────────
local IYMouse = LocalPlayer:GetMouse()
IYMouse.KeyDown:Connect(function(key)
	if key == ";" then
		RunService.RenderStepped:Wait()
		toggleBar()
	end
end)

UIS.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.Semicolon or input.KeyCode == Enum.KeyCode.Quote then
		toggleBar()
	end
end)

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	if _open then updateSuggestions(TextBox.Text) end
end)

UIS.InputBegan:Connect(function(input, _p)
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
