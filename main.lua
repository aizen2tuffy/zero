local GITHUB_RAW = "https://raw.githubusercontent.com/aizen2tuffy/zero/refs/heads/main/main.lua?token=GHSAT0AAAAAAD5I5EAJZC5W4G7M5LVMJ47Y2QHZSDA"

local function loadModule(path)
	return loadstring(game:HttpGet(GITHUB_RAW .. path))()
end

local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer  = Players.LocalPlayer

local Notify   = loadModule("modules/Notify.lua")
_G.__AdminNotify = Notify
local Commands = loadModule("modules/Commands.lua")

local _open    = false
local _history = {}
local _histIdx = 0

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "CustomAdminGui"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent         = LocalPlayer:WaitForChild("PlayerGui")

Notify._init(ScreenGui)

local Backdrop = Instance.new("Frame")
Backdrop.Name                    = "Backdrop"
Backdrop.Size                    = UDim2.fromScale(1, 1)
Backdrop.BackgroundColor3        = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency  = 1
Backdrop.BorderSizePixel         = 0
Backdrop.ZIndex                  = 5
Backdrop.Visible                 = false
Backdrop.Parent                  = ScreenGui

local Container = Instance.new("Frame")
Container.Name                   = "Container"
Container.AnchorPoint            = Vector2.new(0.5, 0)
Container.Position               = UDim2.new(0.5, 0, 0, -60)
Container.Size                   = UDim2.new(0, 540, 0, 44)
Container.BackgroundColor3       = Color3.fromRGB(18, 18, 22)
Container.BackgroundTransparency = 0
Container.BorderSizePixel        = 0
Container.ZIndex                 = 10
Container.ClipsDescendants       = true
Container.Parent                 = ScreenGui

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 10)
ContainerCorner.Parent       = Container

local ContainerStroke = Instance.new("UIStroke")
ContainerStroke.Color        = Color3.fromRGB(80, 80, 100)
ContainerStroke.Thickness    = 1
ContainerStroke.Transparency = 0.5
ContainerStroke.Parent       = Container

local Prefix = Instance.new("TextLabel")
Prefix.Name                  = "Prefix"
Prefix.Size                  = UDim2.new(0, 32, 1, 0)
Prefix.Position              = UDim2.new(0, 10, 0, 0)
Prefix.BackgroundTransparency = 1
Prefix.Text                  = "⌘"
Prefix.TextColor3            = Color3.fromRGB(140, 120, 220)
Prefix.TextSize              = 16
Prefix.Font                  = Enum.Font.GothamBold
Prefix.ZIndex                = 11
Prefix.Parent                = Container

local TextBox = Instance.new("TextBox")
TextBox.Name                 = "Input"
TextBox.Position             = UDim2.new(0, 48, 0, 0)
TextBox.Size                 = UDim2.new(1, -60, 1, 0)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3           = Color3.fromRGB(230, 230, 240)
TextBox.PlaceholderColor3    = Color3.fromRGB(90, 90, 110)
TextBox.PlaceholderText      = "type a command…   (↑↓ history)"
TextBox.Text                 = ""
TextBox.TextSize             = 14
TextBox.Font                 = Enum.Font.Gotham
TextBox.TextXAlignment       = Enum.TextXAlignment.Left
TextBox.ClearTextOnFocus     = false
TextBox.ZIndex               = 11
TextBox.Parent               = Container

local SuggestionBar = Instance.new("Frame")
SuggestionBar.Name                   = "SuggestionBar"
SuggestionBar.Size                   = UDim2.new(1, 0, 0, 26)
SuggestionBar.Position               = UDim2.new(0, 0, 1, 0)
SuggestionBar.BackgroundColor3       = Color3.fromRGB(12, 12, 16)
SuggestionBar.BackgroundTransparency = 0
SuggestionBar.BorderSizePixel        = 0
SuggestionBar.ZIndex                 = 10
SuggestionBar.Visible                = false
SuggestionBar.Parent                 = Container

local SuggestLabel = Instance.new("TextLabel")
SuggestLabel.Name                  = "Label"
SuggestLabel.Size                  = UDim2.new(1, -12, 1, 0)
SuggestLabel.Position              = UDim2.new(0, 10, 0, 0)
SuggestLabel.BackgroundTransparency = 1
SuggestLabel.TextColor3            = Color3.fromRGB(120, 120, 150)
SuggestLabel.TextSize              = 12
SuggestLabel.Font                  = Enum.Font.Gotham
SuggestLabel.TextXAlignment        = Enum.TextXAlignment.Left
SuggestLabel.Text                  = ""
SuggestLabel.ZIndex                = 11
SuggestLabel.Parent                = SuggestionBar

local TWEEN_IN  = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_OUT = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local function openBar()
	_open = true
	Backdrop.Visible = true
	TweenService:Create(Backdrop,   TWEEN_IN, { BackgroundTransparency = 0.7 }):Play()
	TweenService:Create(Container,  TWEEN_IN, { Position = UDim2.new(0.5, 0, 0, 14) }):Play()
	task.delay(0.05, function()
		TextBox.Text = ""
		TextBox:CaptureFocus()
	end)
end

local function closeBar()
	_open = false
	TextBox:ReleaseFocus()
	TweenService:Create(Backdrop,  TWEEN_OUT, { BackgroundTransparency = 1 }):Play()
	TweenService:Create(Container, TWEEN_OUT, { Position = UDim2.new(0.5, 0, 0, -60) }):Play()
	task.delay(0.15, function()
		if not _open then
			Backdrop.Visible      = false
			SuggestionBar.Visible = false
			TextBox.Text          = ""
			Container.Size        = UDim2.new(0, 540, 0, 44)
		end
	end)
end

local function toggleBar()
	if _open then closeBar() else openBar() end
end

local function updateSuggestions(text)
	if text == "" then
		SuggestionBar.Visible = false
		Container.Size        = UDim2.new(0, 540, 0, 44)
		return
	end
	local word    = text:match("^(%S+)") or ""
	local matches = {}
	for name in pairs(Commands.list) do
		if name:sub(1, #word) == word:lower() and name ~= word:lower() then
			table.insert(matches, name)
		end
	end
	if #matches == 0 then
		SuggestionBar.Visible = false
		Container.Size        = UDim2.new(0, 540, 0, 44)
	else
		table.sort(matches)
		SuggestLabel.Text     = table.concat(matches, "   ")
		SuggestionBar.Visible = true
		Container.Size        = UDim2.new(0, 540, 0, 70)
	end
end

local function execute(raw)
	if not raw or raw == "" then return end

	if raw:lower():match("^unload$") then
		Notify.info("Admin unloaded.")
		task.delay(0.6, function()
			closeBar()
			task.delay(0.3, function() ScreenGui:Destroy() end)
		end)
		return
	end

	if _history[#_history] ~= raw then
		table.insert(_history, raw)
	end
	_histIdx = #_history + 1

	local parts   = raw:split(" ")
	local cmdName = parts[1]:lower()
	local args    = {}
	for i = 2, #parts do table.insert(args, parts[i]) end

	if Commands.list[cmdName] then
		local ok, err = pcall(Commands.list[cmdName], LocalPlayer, args)
		if not ok then
			Notify.error("Error: " .. tostring(err))
		end
	else
		Notify.warn("Unknown command: " .. cmdName)
	end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Quote
	or input.KeyCode == Enum.KeyCode.BackQuote then
		toggleBar()
	end
end)

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	if not _open then return end
	updateSuggestions(TextBox.Text)
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
	if not _open then return end
	if input.KeyCode == Enum.KeyCode.Up then
		_histIdx        = math.max(1, _histIdx - 1)
		TextBox.Text    = _history[_histIdx] or ""
		TextBox.CursorPosition = #TextBox.Text + 1
	elseif input.KeyCode == Enum.KeyCode.Down then
		_histIdx        = math.min(#_history + 1, _histIdx + 1)
		TextBox.Text    = _history[_histIdx] or ""
		TextBox.CursorPosition = #TextBox.Text + 1
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

Notify.info("Admin loaded  —  press ` to open")
