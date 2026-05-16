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
local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local LocalPlayer  = Players.LocalPlayer
local PlayerGui    = LocalPlayer:WaitForChild("PlayerGui")

-- ── Modules (load Notify FIRST so it's available everywhere) ─────────────────
local Notify = loadModule("modules/Notify.lua")
_G.__ZeroNotify = Notify

local Commands = loadModule("modules/Commands.lua")

-- ── Wire into existing CommandBarGui ─────────────────────────────────────────
-- Your game already has this ScreenGui with a Frame+TextBox inside StarterGuiStuff
local CommandBarGui = PlayerGui:WaitForChild("StarterGuiStuff"):WaitForChild("CommandBarGui")
local Frame         = CommandBarGui:WaitForChild("Frame")
local TextBox       = Frame:WaitForChild("TextBox")

-- Frame starts invisible, centred, full-width — matches your GUI data exactly
Frame.Visible = false

-- ── State ─────────────────────────────────────────────────────────────────────
local _open    = false
local _history = {}
local _histIdx = 0

-- ── Suggestion label (appended below the existing TextBox) ────────────────────
local SuggestLabel = Instance.new("TextLabel", Frame)
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

-- ── Open / close (mirrors your existing LocalScript exactly) ──────────────────
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
			SuggestLabel:Destroy()
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

-- ── Input — exactly how your existing LocalScript does it ────────────────────
-- UIS handles ; (Quote in Roblox terms) — gameProcessed check matches yours
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Semicolon then
		toggleBar()
	end
end)

-- ── TextBox wiring ────────────────────────────────────────────────────────────
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

-- FocusLost — mirrors your existing LocalScript logic exactly
TextBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local text = TextBox.Text
		TextBox.Text = ""
		-- toggle off (your script does this on enter too)
		_open         = false
		Frame.Visible = false
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
