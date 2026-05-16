-- modules/Commands.lua
-- Each command is a function(localPlayer, args) where args is a table of strings.
-- Commands here are purely client-sided. Anything that needs server authority
-- falls back through the CommandBar RemoteEvent in main.lua.

local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local RS           = game:GetService("ReplicatedStorage")
local Lighting     = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer  = Players.LocalPlayer

-- Lazy-load Notify so Commands can emit toasts
local Notify
task.defer(function()
	-- will be set by the time any command runs (loaded after Notify in main.lua)
	Notify = _G.__AdminNotify
end)
local function toast(kind, msg)
	if Notify then Notify[kind](msg) end
end

local Commands = {}

-- ── Utility ───────────────────────────────────────────────────────────────────

local function findPlayer(name)
	if not name then return nil end
	name = name:lower()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1, #name) == name then
			return p
		end
	end
	return nil
end

local function getCharacter(player)
	return player and player.Character
end

local function getHRP(player)
	local c = getCharacter(player)
	return c and c:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid(player)
	local c = getCharacter(player)
	return c and c:FindFirstChildOfClass("Humanoid")
end

-- ── Command table ─────────────────────────────────────────────────────────────
-- Keys are lowercase command names. Values are functions(sender, args).

Commands.list = {}

-- help — prints all available commands
Commands.list["help"] = function(sender, args)
	local names = {}
	for k in pairs(Commands.list) do table.insert(names, k) end
	table.sort(names)
	toast("info", "Commands: " .. table.concat(names, ", "))
end

-- unload — handled in main.lua but listed here so autocomplete shows it
Commands.list["unload"] = function() end

-- ── Client-visual commands ────────────────────────────────────────────────────

-- noclip — toggles noclip on the local character
Commands.list["noclip"] = function(sender, args)
	local char = LocalPlayer.Character
	if not char then return end

	if char:FindFirstChild("__noclip") then
		char.__noclip:Destroy()
		toast("info", "Noclip off.")
	else
		local tag = Instance.new("BoolValue")
		tag.Name   = "__noclip"
		tag.Parent = char

		local conn
		conn = game:GetService("RunService").Stepped:Connect(function()
			if not tag.Parent then conn:Disconnect() return end
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end)
		toast("info", "Noclip on.")
	end
end

-- speed [number] — sets WalkSpeed of local character
Commands.list["speed"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("warn", "Usage: speed <number>") return end
	local h = getHumanoid(LocalPlayer)
	if h then
		h.WalkSpeed = val
		toast("success", "Speed set to " .. val)
	end
end

-- jump [number] — sets JumpPower / JumpHeight
Commands.list["jump"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("warn", "Usage: jump <number>") return end
	local h = getHumanoid(LocalPlayer)
	if h then
		if h.UseJumpPower then
			h.JumpPower = val
		else
			h.JumpHeight = val
		end
		toast("success", "Jump set to " .. val)
	end
end

-- fly — basic client-side fly toggle using BodyVelocity + BodyGyro
Commands.list["fly"] = function(sender, args)
	local char = LocalPlayer.Character
	local hrp  = getHRP(LocalPlayer)
	if not char or not hrp then return end

	if char:FindFirstChild("__flyActive") then
		char.__flyActive:Destroy()
		toast("info", "Fly off.")
		return
	end

	local tag = Instance.new("BoolValue")
	tag.Name   = "__flyActive"
	tag.Parent = char

	local bv = Instance.new("BodyVelocity")
	bv.Velocity        = Vector3.zero
	bv.MaxForce        = Vector3.new(1e5, 1e5, 1e5)
	bv.Parent          = hrp

	local bg = Instance.new("BodyGyro")
	bg.MaxTorque       = Vector3.new(1e5, 1e5, 1e5)
	bg.CFrame          = hrp.CFrame
	bg.Parent          = hrp

	local speed = tonumber(args[1]) or 50
	local cam   = workspace.CurrentCamera

	local conn = game:GetService("RunService").Heartbeat:Connect(function()
		if not tag.Parent then
			bv:Destroy()
			bg:Destroy()
			conn:Disconnect()
			return
		end
		local dir = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end

		bv.Velocity = dir.Magnitude > 0 and dir.Unit * speed or Vector3.zero
		bg.CFrame   = cam.CFrame
	end)

	toast("info", "Fly on (speed " .. speed .. "). Run `fly` again to disable.")
end

-- goto [player] — teleport to a player's position
Commands.list["goto"] = function(sender, args)
	local target = findPlayer(args[1])
	if not target then toast("warn", "Player not found.") return end
	local hrp    = getHRP(LocalPlayer)
	local tHRP   = getHRP(target)
	if hrp and tHRP then
		hrp.CFrame = tHRP.CFrame * CFrame.new(0, 4, 0)
		toast("success", "Teleported to " .. target.Name)
	end
end

-- esp [player|all] — basic highlight box on character
Commands.list["esp"] = function(sender, args)
	local function applyESP(p)
		if not p.Character then return end
		if p.Character:FindFirstChild("__esp") then
			p.Character.__esp:Destroy()
			return
		end
		local hl = Instance.new("SelectionBox")
		hl.Name        = "__esp"
		hl.Adornee     = p.Character
		hl.Color3      = Color3.fromRGB(255, 60, 60)
		hl.LineThickness = 0.05
		hl.SurfaceTransparency = 0.8
		hl.SurfaceColor3 = Color3.fromRGB(255, 60, 60)
		hl.Parent      = workspace.CurrentCamera
	end

	if args[1] and args[1]:lower() == "all" then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then applyESP(p) end
		end
		toast("info", "ESP toggled for all.")
	else
		local target = findPlayer(args[1])
		if not target then toast("warn", "Player not found.") return end
		applyESP(target)
		toast("info", "ESP toggled for " .. target.Name)
	end
end

-- time [0-24] — client-side lighting time change
Commands.list["time"] = function(sender, args)
	local val = tonumber(args[1])
	if not val or val < 0 or val > 24 then
		toast("warn", "Usage: time <0-24>")
		return
	end
	Lighting.ClockTime = val
	toast("success", "Time set to " .. val)
end

-- fullbright — toggles max ambient/brightness
Commands.list["fullbright"] = function(sender, args)
	if Lighting:GetAttribute("__fbActive") then
		Lighting:SetAttribute("__fbActive", nil)
		Lighting.Brightness      = Lighting:GetAttribute("__fbOrigBrightness") or 1
		Lighting.Ambient         = Lighting:GetAttribute("__fbOrigAmbient") or Color3.fromRGB(0,0,0)
		Lighting.OutdoorAmbient  = Lighting:GetAttribute("__fbOrigOutdoor") or Color3.fromRGB(128,128,128)
		toast("info", "Fullbright off.")
	else
		Lighting:SetAttribute("__fbActive",        true)
		Lighting:SetAttribute("__fbOrigBrightness", Lighting.Brightness)
		Lighting:SetAttribute("__fbOrigAmbient",    Lighting.Ambient)
		Lighting:SetAttribute("__fbOrigOutdoor",    Lighting.OutdoorAmbient)
		Lighting.Brightness     = 2
		Lighting.Ambient        = Color3.fromRGB(255, 255, 255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		toast("success", "Fullbright on.")
	end
end

-- fov [number] — changes camera FieldOfView
Commands.list["fov"] = function(sender, args)
	local val = tonumber(args[1])
	if not val then toast("warn", "Usage: fov <number>") return end
	workspace.CurrentCamera.FieldOfView = math.clamp(val, 1, 120)
	toast("success", "FOV set to " .. math.clamp(val, 1, 120))
end

-- heal — heals the local character
Commands.list["heal"] = function(sender, args)
	local h = getHumanoid(LocalPlayer)
	if h then
		h.Health = h.MaxHealth
		toast("success", "Healed.")
	end
end

-- god — sets MaxHealth + Health to huge number (client visual only)
Commands.list["god"] = function(sender, args)
	local h = getHumanoid(LocalPlayer)
	if not h then return end
	if h:GetAttribute("__godActive") then
		h:SetAttribute("__godActive", nil)
		h.MaxHealth = 100
		h.Health    = 100
		toast("info", "God mode off.")
	else
		h:SetAttribute("__godActive", true)
		h.MaxHealth = 1e9
		h.Health    = 1e9
		toast("success", "God mode on.")
	end
end

-- annoy [player] — teleports target to you every second (client-side, only works if you have char control)
Commands.list["annoy"] = function(sender, args)
	local target = findPlayer(args[1])
	if not target then toast("warn", "Player not found.") return end
	if LocalPlayer.Character:FindFirstChild("__annoyConn_" .. target.UserId) then
		LocalPlayer.Character["__annoyConn_" .. target.UserId]:Destroy()
		toast("info", "Stopped annoying " .. target.Name)
		return
	end
	local tag = Instance.new("BoolValue")
	tag.Name   = "__annoyConn_" .. target.UserId
	tag.Parent = LocalPlayer.Character
	local conn
	conn = game:GetService("RunService").Heartbeat:Connect(function()
		if not tag.Parent then conn:Disconnect() return end
		local myHRP  = getHRP(LocalPlayer)
		local tgtHRP = getHRP(target)
		if myHRP and tgtHRP then
			-- only visual on the client, won't replicate unless server allows
			tgtHRP.CFrame = myHRP.CFrame * CFrame.new(2, 0, 0)
		end
	end)
	toast("warn", "Annoying " .. target.Name .. ". Run annoy again to stop.")
end

-- resetcam — resets the camera to default
Commands.list["resetcam"] = function(sender, args)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	workspace.CurrentCamera.FieldOfView = 70
	toast("success", "Camera reset.")
end

-- printplayers — lists all current players
Commands.list["printplayers"] = function(sender, args)
	local names = {}
	for _, p in ipairs(Players:GetPlayers()) do
		table.insert(names, p.Name .. " (" .. p.UserId .. ")")
	end
	toast("info", table.concat(names, ", "))
end

-- ── Server-passthrough stubs (for autocomplete) ───────────────────────────────
-- These exist so the bar suggests them, but they all fall through to the server.

local serverPassthrough = {
	"kick","heal","rank","re","setbranch","shutdown","redtext","giveitem",
	"devplace","addtalent","removetalent","firstname","lastname","wipe",
	"makeshifter","giveshifts","addhand","addpoints","eyes","mouth",
	"eyebrows","addtag","yell","pd","createslot","loadslot","checkslot",
	"checkslots","chatbypass","freeze","shirt","pants","team","rejoin",
	"damage","settime","dodge","bring","yellperms","sethealth","unfly",
	"restore","scare","attribute","countdown","sm","explode","nuke",
}

for _, name in ipairs(serverPassthrough) do
	if not Commands.list[name] then
		Commands.list[name] = nil -- exists as key via the loop below
	end
end

-- Build a complete set for autocomplete (including server cmds)
for _, name in ipairs(serverPassthrough) do
	if not Commands.list[name] then
		Commands.list[name] = function(sender, args)
			-- falls through to server in main.lua
		end
	end
end

return Commands
