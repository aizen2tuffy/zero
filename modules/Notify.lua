-- modules/Notify.lua

local TweenService = game:GetService("TweenService")
local module = {}
local ActivePms = {}

local function MoveTextUp()
	for _, label in ipairs(ActivePms) do
		if label and label.Parent then
			label.Position = UDim2.new(
				label.Position.X.Scale, label.Position.X.Offset,
				label.Position.Y.Scale - 0.07, label.Position.Y.Offset
			)
		end
	end
end

module.send = function(Text, Player, Timer)
	MoveTextUp()
	Timer = Timer or 4

	local PlayerGui = Player:WaitForChild("PlayerGui")
	local ScreenUI  = PlayerGui:WaitForChild("Intuition")
	local Format    = ScreenUI:WaitForChild("Format")

	for _, v in pairs(ScreenUI:GetChildren()) do
		if v.Name ~= "Format" then
			v.Position = UDim2.new(
				v.Position.X.Scale, v.Position.X.Offset,
				v.Position.Y.Scale + 0.018, v.Position.Y.Offset
			)
		end
	end

	local NewText        = Format:Clone()
	NewText.Font         = Enum.Font.SourceSans
	NewText.TextSize     = 49
	NewText.Text         = Text
	NewText.Visible      = true
	NewText.Name         = "NewText"
	NewText.TextTransparency = 1
	NewText.Parent       = ScreenUI

	local TweenIn  = TweenService:Create(NewText, TweenInfo.new(0.5), {TextTransparency = 0})
	local TweenOut = TweenService:Create(NewText, TweenInfo.new(0.5), {TextTransparency = 1})

	table.insert(ActivePms, NewText)
	TweenIn:Play()

	task.delay(Timer, function()
		TweenOut:Play()
		TweenOut.Completed:Wait()
		local idx = table.find(ActivePms, NewText)
		if idx then table.remove(ActivePms, idx) end
		if NewText and NewText.Parent then NewText:Destroy() end
	end)
end

return module
