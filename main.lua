-- main.lua
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/aizen2tuffy/zero/main/main.lua"))()

if _G.ZERO_LOADED then warn("[Zero] Already loaded.") return end
_G.ZERO_LOADED = true

-- FIXED base path (was pointing to main.lua itself which broke all modules)
local GITHUB_RAW = "https://raw.githubusercontent.com/aizen2tuffy/zero/main/"

local function loadModule(path)
	return loadstring(game:HttpGet(GITHUB_RAW .. path))()
end

local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local LocalPlayer  = Players.LocalPlayer
local PlayerGui    = LocalPlayer:WaitForChild("PlayerGui")

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

-- ── GUI ───────────────────────────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "ZeroAdminGui"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder   = 100
ScreenGui.Parent         = PlayerGui

-- Container: fixed width, centred, starts OFF screen above centre
local Container = Instance.new("Frame", ScreenGui)
Container.Name                   = "Container"
Container.AnchorPoint            = Vector2.new(0.5, 0.5)
Container.Position               = UDim2.new(0.5, 0, 0.5, -300) -- off screen above centre
Container.Size                   = UDim2.new(0, 540, 0, 44)
Container.BackgroundColor3       = Color3.fromRGB(18, 18, 22)
Container.BackgroundTransparency = 0
Container.BorderSizePixel        = 0
Container.ZIndex                 = 10
Container.ClipsDescendants       = true
Container.Visible                = false  -- hidden until opened, no ugly flash

Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", Container)
Stroke.Color        = Color3.fromRGB(80, 80, 110)
Stroke.Thickness    = 1
Stroke.Transparency = 0.5

local Prefix = Instance.new("TextLabel", Container)
Prefix.Size                   = UDim2.new(0, 32, 1, 0)
Prefix.Position               = UDim2.new(0, 10, 0, 0)
Prefix.BackgroundTransparency = 1
Prefix.Text                   = "⌘"
Prefix.TextColor3             = Color3.fromRGB(140, 110, 230)
Prefix.TextSize               = 16
Prefix.Font                   = Enum.Font.GothamBold
Prefix.ZIndex                 = 11

local TextBox = Instance.new("TextBox", Container)
TextBox.Position               = UDim2.new(0, 48, 0, 0)
TextBox.Size                   = UDim2.new(1, -60, 1, 0)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3             = Color3.fromRGB(230, 230, 240)
TextBox.PlaceholderColor3      = Color3.fromRGB(85, 85, 110)
TextBox.PlaceholderText        = "command...  (↑↓ history, Tab to complete)"
TextBox.Text                   = ""
TextBox.TextSize               = 14
TextBox.Font                   = Enum.Font.Gotham
TextBox.TextXAlignment         = Enum.TextXAlignment.Left
TextBox.ClearTextOnFocus       = false
TextBox.ZIndex                 = 11

-- Suggestion bar — BIGGER and more visible than before
local SuggestionBar = Instance.new("Frame", Container)
SuggestionBar.Size                   = UDim2.new(1, 0, 0, 28)
SuggestionBar.Position               = UDim2.new(0, 0, 1, 0)
SuggestionBar.BackgroundColor3       = Color3.fromRGB(12, 12, 18)
SuggestionBar.BackgroundTransparency = 0
SuggestionBar.BorderSizePixel        = 0
SuggestionBar.ZIndex                 = 10
SuggestionBar.Visible                = false

local SuggestLabel = Instance.new("TextLabel", SuggestionBar)
SuggestLabel.Size                   = UDim2.new(1, -12, 1, 0)
SuggestLabel.Position               = UDim2.new(0, 10, 0, 0)
SuggestLabel.BackgroundTransparency = 1
SuggestLabel.TextColor3             = Color3.fromRGB(190, 175, 255) -- bright purple-white
SuggestLabel.TextSize               = 15                            -- was 12
SuggestLabel.Font                   = Enum.Font.GothamMedium        -- was Gotham
SuggestLabel.TextXAlignment         = Enum.TextXAlignment.Left
SuggestLabel.ZIndex                 = 11

-- ── Tweens ────────────────────────────────────────────────────────────────────
local TI_IN  = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_OUT = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local OPEN_POS  = UDim2.new(0.5, 0, 0.5, 0)    -- true screen centre
local CLOSE_POS = UDim2.new(0.5, 0, 0.5, -300) -- above centre, off screen

local function openBar()
	_open             = true
	Container.Visible = true
	TweenService:Create(Container, TI_IN, {Position = OPEN_POS}):Play()
	task.delay(0.05, function()
		TextBox.Text = ""
		TextBox:CaptureFocus()
	end)
end

local function closeBar()
	_open = false
	TextBox:ReleaseFocus()
	TweenService:Create(Container, TI_OUT, {Position = CLOSE_POS}):Play()
	task.delay(0.2, function()
		if not _open then
			Container.Visible     = false
			SuggestionBar.Visible = false
			Container.Size        = UDim2.new(0, 540, 0, 44)
			TextBox.Text          = ""
		end
	end)
end

local function toggleBar()
	if _open then closeBar() else openBar() end
end

-- ── Autocomplete ──────────────────────────────────────────────────────────────
local _topSuggestion = nil

local function updateSuggestions(text)
	_topSuggestion = nil
	if text == "" or text:find(" ") then
		SuggestionBar.Visible = false
		Container.Size        = UDim2.new(0, 540, 0, 44)
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
		SuggestionBar.Visible = false
		Container.Size        = UDim2.new(0, 540, 0, 44)
	else
		table.sort(matches)
		_topSuggestion        = matches[1]
		SuggestLabel.Text     = "  " .. table.concat(matches, "   ·   ")
		SuggestionBar.Visible = true
		Container.Size        = UDim2.new(0, 540, 0, 72)
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
	if input.KeyCode == Enum.KeyCode.Semicolon then
		toggleBar()
	end
end)

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	if _open then updateSuggestions(TextBox.Text) end
end)

UIS.InputBegan:Connect(function(input, processed)
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
