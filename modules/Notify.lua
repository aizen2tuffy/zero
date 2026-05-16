local TweenService = game:GetService("TweenService")

local Notify = {}
local _gui = nil
local _active = {}

local COLORS = {
	info    = Color3.fromRGB(180, 180, 255),
	success = Color3.fromRGB(100, 230, 130),
	warn    = Color3.fromRGB(255, 180, 60),
	error   = Color3.fromRGB(255, 80,  80),
}

local function shiftUp()
	for _, label in ipairs(_active) do
		if label and label.Parent then
			label.Position = UDim2.new(
				label.Position.X.Scale, label.Position.X.Offset,
				label.Position.Y.Scale - 0.07, label.Position.Y.Offset
			)
		end
	end
end

local function push(text, color, timer)
	if not _gui then return end
	timer = timer or 4

	shiftUp()

	local fmt = _gui:FindFirstChild("Format")
	if not fmt then return end

	local lbl = fmt:Clone()
	lbl.Name = "N_" .. tostring(tick())
	lbl.Text = text
	lbl.TextColor3 = color or Color3.fromRGB(230, 230, 240)
	lbl.Font = Enum.Font.SourceSans
	lbl.TextSize = 49
	lbl.TextTransparency = 1
	lbl.Visible = true
	lbl.Parent = _gui

	table.insert(_active, lbl)

	TweenService:Create(lbl, TweenInfo.new(0.5), { TextTransparency = 0 }):Play()

	task.delay(timer, function()
		local t = TweenService:Create(lbl, TweenInfo.new(0.5), { TextTransparency = 1 })
		t:Play()
		t.Completed:Wait()
		local idx = table.find(_active, lbl)
		if idx then table.remove(_active, idx) end
		lbl:Destroy()
	end)
end

function Notify._init(screenGui)
	local intuition = Instance.new("ScreenGui")
	intuition.Name = "Intuition"
	intuition.ResetOnSpawn = false
	intuition.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	intuition.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

	local fmt = Instance.new("TextLabel")
	fmt.Name = "Format"
	fmt.Size = UDim2.new(0.547, 0, 0.088, 0)
	fmt.Position = UDim2.new(0.227, 0, 0.796, 0)
	fmt.AnchorPoint = Vector2.new(0, 0)
	fmt.BackgroundTransparency = 1
	fmt.TextTransparency = 1
	fmt.Text = ""
	fmt.TextColor3 = Color3.fromRGB(230, 230, 240)
	fmt.TextSize = 49
	fmt.Font = Enum.Font.SourceSans
	fmt.TextXAlignment = Enum.TextXAlignment.Left
	fmt.TextWrapped = true
	fmt.ZIndex = 1
	fmt.Visible = true
	fmt.Parent = intuition

	_gui = intuition
end

function Notify.info(msg, timer)    push(msg, COLORS.info,    timer) end
function Notify.success(msg, timer) push(msg, COLORS.success, timer) end
function Notify.warn(msg, timer)    push(msg, COLORS.warn,    timer) end
function Notify.error(msg, timer)   push(msg, COLORS.error,   timer) end

return Notify
