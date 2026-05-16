-- modules/Commands.lua

local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local Lighting     = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local CoreGui      = game:GetService("CoreGui")
local LocalPlayer  = Players.LocalPlayer

local Notify = _G.__ZeroNotify
local function toast(msg, timer)
	if Notify then Notify.send(msg, LocalPlayer, timer or 4) end
end

-- ── Helpers ───────────────────────────────────────────────────────────────────
local function getChar()  return LocalPlayer.Character end
local function getHRP()   local c = getChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function getHuman() local c = getChar() return c and c:FindFirstChildOfClass("Humanoid") end

local function findPlayer(name)
	if not name or name == "" then return nil end
	name = name:lower()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1, #name) == name then return p end
	end
	return nil
end

local function round(n, d)
	local m = 10^(d or 0)
	return math.floor(n * m + 0.5) / m
end

-- active connection store
local _conns = {}
local function addConn(key, conn)
	if _conns[key] then _conns[key]:Disconnect() end
	_conns[key] = conn
end
local function removeConn(key)
	if _conns[key] then _conns[key]:Disconnect() _conns[key] = nil end
end

local Commands = {}
Commands.list  = {}

-- ── ESP ───────────────────────────────────────────────────────────────────────
-- Fully client-sided: BoxHandleAdornment chams + BillboardGui name/health/dist
-- Stored in CoreGui folder per player so it survives character reloads

local ESP = {}
ESP.enabled    = false
ESP.teamColor  = false
ESP.holders    = {} -- [player] = Folder in CoreGui
ESP.transparency = 0.5

local ESPColor = Color3.fromRGB(255, 50, 50) -- default red

local function espColorFor(player)
	if ESP.teamColor then
		return player.TeamColor == LocalPlayer.TeamColor
			and Color3.fromRGB(50, 220, 80)
			or  Color3.fromRGB(220, 50, 50)
	end
	return player.TeamColor.Color
end

local function espRemove(player)
	local h = ESP.holders[player]
	if h then h:Destroy() ESP.holders[player] = nil end
end

local function espBuild(player)
	if player == LocalPlayer then return end
	espRemove(player)

	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local head = char:FindFirstChild("Head")
	local hum  = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not head or not hum then return end

	local folder = Instance.new("Folder")
	folder.Name  = player.Name .. "_ESP"
	folder.Parent = CoreGui
	ESP.holders[player] = folder

	local color = espColorFor(player)

	-- box adornments on every part
	for _, part in ipairs(char:GetChildren()) do
		if part:IsA("BasePart") then
			local box          = Instance.new("BoxHandleAdornment")
			box.Name           = "ESPBox"
			box.Adornee        = part
			box.AlwaysOnTop    = true
			box.ZIndex         = 10
			box.Size           = part.Size
			box.Transparency   = ESP.transparency
			box.Color3         = color
			box.Parent         = folder
		end
	end

	-- billboard: name / health / distance
	local bb = Instance.new("BillboardGui")
	bb.Name          = "ESPBillboard"
	bb.Adornee       = head
	bb.AlwaysOnTop   = true
	bb.Size          = UDim2.new(0, 120, 0, 60)
	bb.StudsOffset   = Vector3.new(0, 2.5, 0)
	bb.Parent        = folder

	local nameLbl = Instance.new("TextLabel", bb)
	nameLbl.Name               = "NameLabel"
	nameLbl.Size               = UDim2.fromScale(1, 0.5)
	nameLbl.BackgroundTransparency = 1
	nameLbl.TextColor3         = Color3.new(1,1,1)
	nameLbl.TextStrokeTransparency = 0
	nameLbl.TextScaled         = true
	nameLbl.Font               = Enum.Font.GothamBold
	nameLbl.Text               = player.Name
	nameLbl.ZIndex             = 10

	local infoLbl = Instance.new("TextLabel", bb)
	infoLbl.Name               = "InfoLabel"
	infoLbl.Size               = UDim2.fromScale(1, 0.5)
	infoLbl.Position           = UDim2.fromScale(0, 0.5)
	infoLbl.BackgroundTransparency = 1
	infoLbl.TextColor3         = Color3.new(1,1,1)
	infoLbl.TextStrokeTransparency = 0
	infoLbl.TextScaled         = true
	infoLbl.Font               = Enum.Font.Gotham
	infoLbl.Text               = ""
	infoLbl.ZIndex             = 10

	-- update loop
	local loopConn
	loopConn = RunService.RenderStepped:Connect(function()
		if not folder.Parent or not char.Parent then
			loopConn:Disconnect()
			return
		end
		local myHRP = getHRP()
		if myHRP and hrp and hrp.Parent then
			local dist = round((myHRP.Position - hrp.Position).Magnitude)
			infoLbl.Text = string.format("HP: %d | %d studs", round(hum.Health), dist)
		end
	end)

	-- rebuild on respawn
	player.CharacterAdded:Connect(function()
		task.wait(1)
		if ESP.enabled then espBuild(player) end
	end)
end

local function espEnable(teamColor)
	ESP.enabled   = true
	ESP.teamColor = teamColor or false
	for _, p in ipairs(Players:GetPlayers()) do
		espBuild(p)
	end
end

local function espDisable()
	ESP.enabled = false
	for p, _ in pairs(ESP.holders) do espRemove(p) end
end

-- auto-handle joining players while ESP is on
Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		task.wait(1)
		if ESP.enabled then espBuild(p) end
	end)
end)

Players.PlayerRemoving:Connect(function(p)
	espRemove(p)
end)

-- ── Commands ──────────────────────────────────────────────────────────────────

Commands.list["help"] = function(sender, args)
	local names = {}
	for k in pairs(Commands.list) do table.insert(names, k) end
	table.sort(names)
	toast(table.concat(names, ", "), 7)
end

Commands.list["unload"] = function() end -- handled in main

-- ESP
Commands.list["esp"] = function(sender, args)
	if ESP.enabled then
		espDisable()
		toast("ESP off.")
	else
		espEnable(false)
		toast("ESP on.")
	end
end

Commands.list["espteam"] = function(sender, args)
	if ESP.enabled and ESP.teamColor then
		espDisable()
		toast("Team ESP off.")
	else
		espDisable()
		espEnable(true)
		toast("Team ESP on — green = ally, red = enemy.")
	end
end

Commands.list["noesp"] = function(sender, args)
	espDisable()
	toast("ESP off.")
end

Commands.list["esptransparency"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("Usage: esptransparency <0-1>") return end
	ESP.transparency = math.clamp(val, 0, 1)
	if ESP.enabled then espDisable() espEnable(ESP.teamColor) end
	toast("ESP transparency → " .. ESP.transparency)
end

-- Noclip
Commands.list["noclip"] = function(sender, args)
	local char = getChar()
	if not char then return end
	if _conns["noclip"] then
		removeConn("noclip")
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = true end
		end
		toast("Noclip off.")
		return
	end
	addConn("noclip", RunService.Stepped:Connect(function()
		local c = getChar()
		if not c then removeConn("noclip") return end
		for _, p in ipairs(c:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = false end
		end
	end))
	toast("Noclip on.")
end

Commands.list["clip"] = function(sender, args)
	removeConn("noclip")
	local c = getChar()
	if c then
		for _, p in ipairs(c:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = true end
		end
	end
	toast("Clip restored.")
end

-- Fly
Commands.list["fly"] = function(sender, args)
	local char = getChar()
	local hrp  = getHRP()
	if not char or not hrp then return end

	if _conns["fly"] then
		removeConn("fly")
		local bv = hrp:FindFirstChild("__ZeroBV")
		local bg = hrp:FindFirstChild("__ZeroBG")
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
		local h = getHuman()
		if h then h.PlatformStand = false end
		toast("Fly off.")
		return
	end

	local speed = tonumber(args[1]) or 60

	local bv      = Instance.new("BodyVelocity", hrp)
	bv.Name       = "__ZeroBV"
	bv.Velocity   = Vector3.zero
	bv.MaxForce   = Vector3.new(1e5, 1e5, 1e5)

	local bg      = Instance.new("BodyGyro", hrp)
	bg.Name       = "__ZeroBG"
	bg.MaxTorque  = Vector3.new(1e5, 1e5, 1e5)
	bg.CFrame     = hrp.CFrame

	local cam = workspace.CurrentCamera
	local h   = getHuman()
	if h then h.PlatformStand = true end

	addConn("fly", RunService.Heartbeat:Connect(function()
		local r = getHRP()
		if not r or not _conns["fly"] then return end
		local dir = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector  end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector  end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space)       then dir += Vector3.yAxis end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
		bv.Velocity = dir.Magnitude > 0 and dir.Unit * speed or Vector3.zero
		bg.CFrame   = cam.CFrame
	end))
	toast("Fly on — speed " .. speed .. ". Run `fly` again to stop.")
end

Commands.list["flyspeed"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("Usage: flyspeed <number>") return end
	-- rebuild fly with new speed
	if _conns["fly"] then
		Commands.list["fly"](sender, {})
		task.wait(0.1)
		Commands.list["fly"](sender, {tostring(val)})
	end
	toast("Fly speed → " .. val)
end

Commands.list["unfly"] = function(sender, args)
	if _conns["fly"] then Commands.list["fly"](sender, args) end
end

-- Speed / Jump
Commands.list["speed"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("Usage: speed <number>") return end
	local h = getHuman()
	if h then h.WalkSpeed = val toast("Speed → " .. val) end
end

Commands.list["jump"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("Usage: jump <number>") return end
	local h = getHuman()
	if not h then return end
	if h.UseJumpPower then h.JumpPower = val else h.JumpHeight = val end
	toast("Jump → " .. val)
end

-- Infinite jump
Commands.list["infjump"] = function(sender, args)
	if _conns["infjump"] then
		removeConn("infjump")
		toast("Infinite jump off.")
		return
	end
	addConn("infjump", UIS.JumpRequest:Connect(function()
		local h = getHuman()
		if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
	end))
	toast("Infinite jump on.")
end

-- Teleport
Commands.list["goto"] = function(sender, args)
	local target = findPlayer(args[1])
	if not target then toast("Player not found.") return end
	local hrp  = getHRP()
	local tHRP = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
	if hrp and tHRP then
		hrp.CFrame = tHRP.CFrame * CFrame.new(0, 4, 0)
		toast("→ " .. target.Name)
	end
end

Commands.list["bring"] = function(sender, args)
	local target = findPlayer(args[1])
	if not target then toast("Player not found.") return end
	local myHRP = getHRP()
	local tHRP  = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
	if myHRP and tHRP then
		tHRP.CFrame = myHRP.CFrame * CFrame.new(4, 0, 0)
		toast("Brought " .. target.Name)
	end
end

Commands.list["tppos"] = function(sender, args)
	local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
	if not (x and y and z) then toast("Usage: tppos <x> <y> <z>") return end
	local hrp = getHRP()
	if hrp then hrp.CFrame = CFrame.new(x, y, z) toast("Teleported.") end
end

-- Heal / God
Commands.list["heal"] = function(sender, args)
	local h = getHuman()
	if h then h.Health = h.MaxHealth toast("Healed.") end
end

Commands.list["god"] = function(sender, args)
	local h = getHuman()
	if not h then return end
	if h:GetAttribute("__zero_god") then
		h:SetAttribute("__zero_god", nil)
		h.MaxHealth = 100 h.Health = 100
		toast("God off.")
	else
		h:SetAttribute("__zero_god", true)
		h.MaxHealth = 1e9 h.Health = 1e9
		toast("God on.")
	end
end

-- Freeze (anchor self)
Commands.list["freeze"] = function(sender, args)
	local hrp = getHRP()
	if not hrp then return end
	if hrp.Anchored then
		hrp.Anchored = false toast("Unfrozen.")
	else
		hrp.Anchored = true toast("Frozen.")
	end
end

-- Invisible (LocalTransparencyModifier)
Commands.list["invisible"] = function(sender, args)
	local char = getChar()
	if not char then return end
	local active = char:GetAttribute("__zero_invis")
	for _, p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") or p:IsA("Decal") then
			p.LocalTransparencyModifier = active and 0 or 1
		end
	end
	char:SetAttribute("__zero_invis", not active or nil)
	toast(active and "Visible." or "Invisible (client-side).")
end

Commands.list["visible"] = function(sender, args)
	local char = getChar()
	if not char then return end
	for _, p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") or p:IsA("Decal") then
			p.LocalTransparencyModifier = 0
		end
	end
	char:SetAttribute("__zero_invis", nil)
	toast("Visible.")
end

-- Lighting
Commands.list["fullbright"] = function(sender, args)
	if Lighting:GetAttribute("__zero_fb") then
		Lighting:SetAttribute("__zero_fb", nil)
		Lighting.Brightness     = Lighting:GetAttribute("__zero_fbB") or 1
		Lighting.Ambient        = Lighting:GetAttribute("__zero_fbA") or Color3.new()
		Lighting.OutdoorAmbient = Lighting:GetAttribute("__zero_fbO") or Color3.fromRGB(128,128,128)
		Lighting.GlobalShadows  = true
		toast("Fullbright off.")
	else
		Lighting:SetAttribute("__zero_fb",  true)
		Lighting:SetAttribute("__zero_fbB", Lighting.Brightness)
		Lighting:SetAttribute("__zero_fbA", Lighting.Ambient)
		Lighting:SetAttribute("__zero_fbO", Lighting.OutdoorAmbient)
		Lighting.Brightness     = 2
		Lighting.Ambient        = Color3.fromRGB(255,255,255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
		Lighting.GlobalShadows  = false
		toast("Fullbright on.")
	end
end

Commands.list["time"] = function(sender, args)
	local val = tonumber(args[1])
	if not val or val < 0 or val > 24 then toast("Usage: time <0-24>") return end
	Lighting.ClockTime = val
	toast("Time → " .. val)
end

Commands.list["settime"] = function(sender, args)
	local target = tonumber(args[1])
	local dur    = tonumber(args[2]) or 3
	if not target then toast("Usage: settime <0-24> [seconds]") return end
	local tv = Instance.new("NumberValue")
	tv.Value = Lighting.ClockTime
	local t = TweenService:Create(tv, TweenInfo.new(dur, Enum.EasingStyle.Linear), {Value = target})
	tv.Changed:Connect(function(v) Lighting.ClockTime = v end)
	t:Play()
	t.Completed:Connect(function() tv:Destroy() end)
	toast("Tweening time → " .. target)
end

Commands.list["nofog"] = function(sender, args)
	Lighting.FogEnd = 1e9
	for _, v in ipairs(Lighting:GetDescendants()) do
		if v:IsA("Atmosphere") then v:Destroy() end
	end
	toast("Fog removed.")
end

Commands.list["day"]   = function() Lighting.ClockTime = 14 toast("Day.") end
Commands.list["night"] = function() Lighting.ClockTime = 0  toast("Night.") end

-- Camera
Commands.list["fov"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("Usage: fov <number>") return end
	workspace.CurrentCamera.FieldOfView = math.clamp(val, 1, 120)
	toast("FOV → " .. math.clamp(val, 1, 120))
end

Commands.list["resetcam"] = function(sender, args)
	workspace.CurrentCamera.CameraType  = Enum.CameraType.Custom
	workspace.CurrentCamera.FieldOfView = 70
	toast("Camera reset.")
end

Commands.list["freecam"] = function(sender, args)
	local cam   = workspace.CurrentCamera
	local speed = tonumber(args[1]) or 1

	if _conns["freecam"] then
		removeConn("freecam")
		cam.CameraType = Enum.CameraType.Custom
		toast("Freecam off.")
		return
	end

	cam.CameraType = Enum.CameraType.Scriptable
	local rot = Vector2.new()
	local pos = cam.CFrame.Position

	addConn("freecam_mouse", UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			rot = Vector2.new(
				math.clamp(rot.X - input.Delta.Y * 0.3, -89, 89),
				rot.Y - input.Delta.X * 0.3
			)
		end
	end))

	addConn("freecam", RunService.RenderStepped:Connect(function(dt)
		local cf  = CFrame.new(pos) * CFrame.fromEulerAnglesYXZ(math.rad(rot.X), math.rad(rot.Y), 0)
		local vel = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then vel += cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then vel -= cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then vel -= cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then vel += cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.E) or UIS:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.yAxis end
		if UIS:IsKeyDown(Enum.KeyCode.Q) or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vel -= Vector3.yAxis end
		local spd = speed * (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 3 or 1)
		pos = pos + vel * spd * 60 * dt
		cam.CFrame = CFrame.new(pos) * CFrame.fromEulerAnglesYXZ(math.rad(rot.X), math.rad(rot.Y), 0)
	end))
	toast("Freecam on — WASD/QE to move, run `freecam` again to stop.")
end

-- Character
Commands.list["re"] = function(sender, args)
	local hrp = getHRP()
	local cf  = hrp and hrp.CFrame
	LocalPlayer:LoadCharacter()
	if cf then
		task.wait(1)
		local newHRP = getHRP()
		if newHRP then newHRP.CFrame = cf end
	end
	toast("Respawned.")
end

Commands.list["reset"] = function(sender, args)
	local h = getHuman()
	if h then h:ChangeState(Enum.HumanoidStateType.Dead) end
end

Commands.list["rejoin"] = function(sender, args)
	local TS = game:GetService("TeleportService")
	toast("Rejoining...", 2)
	task.delay(1.5, function() TS:Teleport(game.PlaceId, LocalPlayer) end)
end

-- X-Ray
Commands.list["xray"] = function(sender, args)
	if _conns["xray"] then
		removeConn("xray")
		-- restore
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and not v.Parent:FindFirstChildOfClass("Humanoid") then
				v.LocalTransparencyModifier = 0
			end
		end
		toast("Xray off.")
		return
	end
	addConn("xray", RunService.RenderStepped:Connect(function()
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart")
				and not v.Parent:FindFirstChildOfClass("Humanoid")
				and not v.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				v.LocalTransparencyModifier = 0.6
			end
		end
	end))
	toast("Xray on.")
end

-- Anti-idle
Commands.list["antiafk"] = function(sender, args)
	LocalPlayer.Idled:Connect(function()
		game:GetService("VirtualUser"):CaptureController()
		game:GetService("VirtualUser"):ClickButton2(Vector2.new())
	end)
	toast("Anti-AFK on.")
end

-- Info
Commands.list["players"] = function(sender, args)
	local names = {}
	for _, p in ipairs(Players:GetPlayers()) do
		table.insert(names, p.Name)
	end
	toast(table.concat(names, ", "), 6)
end

Commands.list["ping"] = function(sender, args)
	toast("Ping: " .. math.round(LocalPlayer:GetNetworkPing() * 1000) .. "ms")
end

Commands.list["pos"] = function(sender, args)
	local hrp = getHRP()
	if hrp then
		local p = hrp.Position
		toast(string.format("%.1f, %.1f, %.1f", p.X, p.Y, p.Z))
	end
end

-- Gravity
Commands.list["gravity"] = function(sender, args)
	local val = tonumber(args[1]) or 196.2
	workspace.Gravity = val
	toast("Gravity → " .. val)
end

-- Spin
Commands.list["spin"] = function(sender, args)
	local hrp = getHRP()
	if not hrp then return end
	if hrp:FindFirstChild("__ZeroSpin") then
		hrp:FindFirstChild("__ZeroSpin"):Destroy()
		toast("Spin off.")
		return
	end
	local bav = Instance.new("BodyAngularVelocity", hrp)
	bav.Name           = "__ZeroSpin"
	bav.MaxTorque      = Vector3.new(0, 1e9, 0)
	bav.AngularVelocity = Vector3.new(0, tonumber(args[1]) or 20, 0)
	toast("Spin on.")
end

-- Nohats
Commands.list["nohats"] = function(sender, args)
	local h = getHuman()
	if h then h:RemoveAccessories() toast("Hats removed.") end
end

-- Reach
Commands.list["reach"] = function(sender, args)
	local size = tonumber(args[1]) or 20
	local char = getChar()
	if not char then return end
	for _, v in ipairs(char:GetDescendants()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			v.Handle.Size = Vector3.new(0.2, 0.2, size)
			v.GripPos = Vector3.zero
			toast("Reach set to " .. size)
		end
	end
end

Commands.list["unreach"] = function(sender, args)
	local char = getChar()
	if not char then return end
	for _, v in ipairs(char:GetDescendants()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			v.Handle.Size = Vector3.new(1, 1, 1)
			toast("Reach removed.")
		end
	end
end

-- No-billboard guis (name tags etc)
Commands.list["nobgui"] = function(sender, args)
	local char = getChar()
	if not char then return end
	for _, v in ipairs(char:GetDescendants()) do
		if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then v:Destroy() end
	end
	toast("Billboard GUIs removed.")
end

-- Walkspeed aliases
Commands.list["ws"]        = Commands.list["speed"]
Commands.list["walkspeed"] = Commands.list["speed"]
Commands.list["jp"]        = Commands.list["jump"]
Commands.list["jumppower"] = Commands.list["jump"]
Commands.list["fc"]        = Commands.list["freecam"]
Commands.list["fb"]        = Commands.list["fullbright"]
Commands.list["nc"]        = Commands.list["noclip"]
Commands.list["invis"]     = Commands.list["invisible"]
Commands.list["vis"]       = Commands.list["visible"]
Commands.list["refresh"]   = Commands.list["re"]

return Commands
