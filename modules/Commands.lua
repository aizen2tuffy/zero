local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local module = { list = {} }
local L = module.list
local _savedPos = nil
local _loops = {}

local function notify(msg) if _G.__ZeroNotify then _G.__ZeroNotify.send(msg, LocalPlayer, 4) end end
local function char() return LocalPlayer.Character end
local function hum() return char() and char():FindFirstChildOfClass("Humanoid") end
local function root() return char() and char():FindFirstChild("HumanoidRootPart") end
local function stopLoop(k) if _loops[k] then _loops[k]:Disconnect() _loops[k] = nil end end

-- ── Movement ─────────────────────────────────────────────────────────────────
L["speed"] = function(_, a) local h=hum() if h then h.WalkSpeed=tonumber(a[1]) or 16 notify("Speed: "..(a[1] or "16")) end end
L["jump"] = function(_, a) local h=hum() if h then h.JumpPower=tonumber(a[1]) or 50 notify("JumpPower: "..(a[1] or "50")) end end
L["gravity"] = function(_, a) workspace.Gravity=tonumber(a[1]) or 196.2 notify("Gravity: "..(a[1] or "196.2")) end
L["moongravity"] = function() workspace.Gravity=50 notify("Moon gravity on") end

L["noclip"] = function()
    if _loops["noclip"] then stopLoop("noclip") notify("Noclip off") return end
    _loops["noclip"] = RunService.Stepped:Connect(function()
        if char() then for _,v in pairs(char():GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
    end)
    notify("Noclip on")
end

L["fly"] = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yeahblxr/-Midnight-hub/refs/heads/main/Midnighthub_Fly.lua"))()
end

L["infinitejump"] = function()
    if _loops["ijump"] then stopLoop("ijump") notify("Infinite jump off") return end
    _loops["ijump"] = UIS.JumpRequest:Connect(function()
        local h=hum() if h and h.Health>0 then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
    notify("Infinite jump on")
end

L["freeze"] = function()
    local r=root() if r then r.Anchored=true notify("Frozen") end
end
L["unfreeze"] = function()
    local r=root() if r then r.Anchored=false notify("Unfrozen") end
end

L["respawn"] = function()
    local h=hum() if h then h.Health=0 end
end

L["invisible"] = function()
    if char() then for _,v in pairs(char():GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency=1 end end notify("Invisible") end
end
L["visible"] = function()
    if char() then for _,v in pairs(char():GetDescendants()) do if v:IsA("BasePart") then v.Transparency=0 end end notify("Visible") end
end

L["platform"] = function()
    local r=root() if not r then return end
    local p=Instance.new("Part")
    p.Size=Vector3.new(10,1,10) p.Anchored=true p.CanCollide=true
    p.Transparency=0.5 p.Position=r.Position-Vector3.new(0,3,0)
    p.Parent=workspace notify("Platform spawned")
end

L["spin"] = function(_, a)
    if _loops["spin"] then stopLoop("spin") notify("Spin off") return end
    local spd=tonumber(a[1]) or 10
    _loops["spin"] = RunService.Heartbeat:Connect(function()
        local r=root() if r then r.CFrame=r.CFrame*CFrame.Angles(0,math.rad(spd),0) end
    end)
    notify("Spinning at "..spd)
end

L["hipheight"] = function(_, a) local h=hum() if h then h.HipHeight=tonumber(a[1]) or 0 notify("HipHeight: "..(a[1] or "0")) end end

L["size"] = function(_, a)
    local s=tonumber(a[1]) or 1
    if char() then
        for _,v in pairs(char():GetDescendants()) do
            if v:IsA("BasePart") then v.Size=v.Size*s end
        end
        notify("Size: "..s)
    end
end

L["headless"] = function()
    if char() then local h=char():FindFirstChild("Head") if h then h.Transparency=1 notify("Headless") end end
end
L["bighead"] = function()
    if char() then local h=char():FindFirstChild("Head") if h then h.Size=Vector3.new(4,4,4) notify("Big head") end end
end
L["nolimbs"] = function()
    local limbs={"LeftUpperArm","RightUpperArm","LeftUpperLeg","RightUpperLeg","LeftLowerArm","RightLowerArm","LeftLowerLeg","RightLowerLeg","LeftHand","RightHand","LeftFoot","RightFoot","Left Arm","Right Arm","Left Leg","Right Leg"}
    if char() then for _,n in pairs(limbs) do local p=char():FindFirstChild(n) if p then p.Transparency=1 end end notify("No limbs") end
end

L["trail"] = function()
    local r=root() if not r then return end
    local a0=Instance.new("Attachment",r) local a1=Instance.new("Attachment",r)
    a1.Position=Vector3.new(0,2,0)
    local t=Instance.new("Trail",r) t.Attachment0=a0 t.Attachment1=a1
    t.Lifetime=1 t.Color=ColorSequence.new(Color3.fromRGB(150,100,255))
    notify("Trail on")
end

L["color"] = function(_, a)
    -- color <partname> <r> <g> <b>
    local partName=a[1] local r2,g,b=tonumber(a[2]),tonumber(a[3]),tonumber(a[4])
    if char() and partName and r2 and g and b then
        local p=char():FindFirstChild(partName)
        if p and p:IsA("BasePart") then p.Color=Color3.fromRGB(r2,g,b) notify("Colored "..partName) end
    end
end

-- ── Teleport ──────────────────────────────────────────────────────────────────
L["tp"] = function(_, a)
    local t=Players:FindFirstChild(a[1])
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
        local r=root() if r then r.CFrame=t.Character.HumanoidRootPart.CFrame notify("TP to "..a[1]) end
    else notify("Player not found") end
end

L["tpcoords"] = function(_, a)
    local x,y,z=tonumber(a[1]),tonumber(a[2]),tonumber(a[3])
    if x and y and z then local r=root() if r then r.CFrame=CFrame.new(x,y,z) notify(("TP to %d,%d,%d"):format(x,y,z)) end
    else notify("Usage: tpcoords x y z") end
end

L["savepos"] = function()
    local r=root() if r then _savedPos=r.CFrame notify("Position saved") end
end
L["loadpos"] = function()
    local r=root() if r and _savedPos then r.CFrame=_savedPos notify("Position loaded") end
end

-- ── Spectate ─────────────────────────────────────────────────────────────────
L["spectate"] = function(_, a)
    local t=Players:FindFirstChild(a[1])
    if t and t.Character and t.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject=t.Character.Humanoid
        notify("Spectating "..a[1])
    else notify("Player not found") end
end
L["unspectate"] = function()
    local h=hum() if h then Camera.CameraSubject=h notify("Unspectated") end
end

-- ── Camera ────────────────────────────────────────────────────────────────────
L["fov"] = function(_, a) Camera.FieldOfView=tonumber(a[1]) or 70 notify("FOV: "..(a[1] or "70")) end
L["zoomout"] = function()
    local p=require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
    pcall(function() p:GetControls() end)
    local cam=require(Players.LocalPlayer.PlayerScripts.PlayerModule:WaitForChild("CameraModule"))
    pcall(function() cam.MaxZoomDistance=500 end)
    notify("Zoom unlocked")
end
L["firstperson"] = function() Camera.CameraType=Enum.CameraType.Custom notify("First person") end
L["thirdperson"] = function() Camera.CameraType=Enum.CameraType.Custom notify("Third person") end

-- ── Tools ─────────────────────────────────────────────────────────────────────
L["droptool"] = function()
    local c=char() if not c then return end
    for _,t in pairs(c:GetChildren()) do if t:IsA("Tool") then t.Parent=workspace end end
    notify("Tools dropped")
end
L["cleartools"] = function()
    local bp=LocalPlayer.Backpack
    for _,t in pairs(bp:GetChildren()) do t:Destroy() end
    local c=char() if c then for _,t in pairs(c:GetChildren()) do if t:IsA("Tool") then t:Destroy() end end end
    notify("Tools cleared")
end

-- ── Visual / World ────────────────────────────────────────────────────────────
L["fullbright"] = function()
    Lighting.Brightness=2 Lighting.ClockTime=14
    Lighting.FogEnd=1e9 Lighting.GlobalShadows=false
    Lighting.Ambient=Color3.fromRGB(255,255,255)
    notify("Fullbright on")
end
L["removefog"] = function()
    Lighting.FogEnd=1e10 Lighting.FogStart=1e10 notify("Fog removed")
end
L["fog"] = function(_, a)
    local d=tonumber(a[1]) or 1000
    Lighting.FogEnd=d Lighting.FogStart=0 notify("Fog density: "..d)
end
L["time"] = function(_, a) Lighting.ClockTime=tonumber(a[1]) or 14 notify("Time: "..(a[1] or "14")) end
L["brightness"] = function(_, a) Lighting.Brightness=tonumber(a[1]) or 1 notify("Brightness: "..(a[1] or "1")) end
L["ambient"] = function(_, a)
    local r2,g,b=tonumber(a[1]),tonumber(a[2]),tonumber(a[3])
    if r2 and g and b then Lighting.Ambient=Color3.fromRGB(r2,g,b) notify("Ambient set") end
end
L["shadowsoff"] = function() Lighting.GlobalShadows=false notify("Shadows off") end
L["shadowson"] = function() Lighting.GlobalShadows=true notify("Shadows on") end
L["skybox"] = function(_, a)
    local sky=Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky",Lighting)
    local id="rbxassetid://"..(a[1] or "")
    sky.SkyboxBk=id sky.SkyboxDn=id sky.SkyboxFt=id
    sky.SkyboxLf=id sky.SkyboxRt=id sky.SkyboxUp=id
    notify("Skybox set")
end

-- ── Utility ───────────────────────────────────────────────────────────────────
L["rejoin"] = function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end
L["serverhop"] = function()
    local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    local data=HttpService:JSONDecode(game:HttpGet(url))
    for _,s in pairs(data.data) do
        if s.id~=game.JobId and s.playing<s.maxPlayers then
            TeleportService:TeleportToPlaceInstance(game.PlaceId,s.id,LocalPlayer) return
        end
    end
    notify("No servers found")
end
L["fpscap"] = function(_, a)
    local n=tonumber(a[1]) if n then setfpscap(n) notify("FPS cap: "..n) end
end
L["unlockfps"] = function() setfpscap(0) notify("FPS unlocked") end
L["console"] = function()
    game:GetService("StarterGui"):SetCore("DevConsoleVisible",true)
end
L["unc"] = function()
    loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/UNC%20test?raw=true"))()
end
L["antiafk"] = function()
    if _loops["antiafk"] then stopLoop("antiafk") notify("Anti-AFK off") return end
    _loops["antiafk"] = LocalPlayer.Idled:Connect(function()
        local VU=game:GetService("VirtualUser")
        VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    notify("Anti-AFK on")
end
L["instantinteract"] = function()
    for _,p in ipairs(game:GetDescendants()) do
        if p:IsA("ProximityPrompt") then p.HoldDuration=0 end
    end
    game.DescendantAdded:Connect(function(o)
        if o:IsA("ProximityPrompt") then o.HoldDuration=0 end
    end)
    notify("Instant interact on")
end
L["copyjobid"] = function()
    if setclipboard then setclipboard(game.JobId) notify("Job ID copied") end
end
L["players"] = function()
    local names={}
    for _,p in pairs(Players:GetPlayers()) do table.insert(names,p.Name) end
    notify(table.concat(names,", "))
end
L["ping"] = function()
    notify("Ping: "..math.floor(LocalPlayer:GetNetworkPing()*1000).."ms")
end

-- ── Antifling / Defense ───────────────────────────────────────────────────────
L["antifling"] = function()
    if _loops["antifling"] then stopLoop("antifling") notify("Antifling off") return end
    _loops["antifling"] = RunService.Heartbeat:Connect(function()
        local r=root()
        if r and r.Velocity.Magnitude > 200 then
            r.Velocity=Vector3.new(0,0,0)
            r.RotVelocity=Vector3.new(0,0,0)
        end
    end)
    notify("Antifling on")
end
L["antiragdoll"] = function()
    if _loops["antiragdoll"] then stopLoop("antiragdoll") notify("Antiragdoll off") return end
    _loops["antiragdoll"] = RunService.Heartbeat:Connect(function()
        local h=hum()
        if h then
            h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
            h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        end
    end)
    notify("Antiragdoll on")
end
L["resetvelocity"] = function()
    local r=root()
    if r then r.Velocity=Vector3.new(0,0,0) r.RotVelocity=Vector3.new(0,0,0) notify("Velocity reset") end
end

-- ── Fun ───────────────────────────────────────────────────────────────────────
L["snake"] = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Avtor1zaTion/NO-FE-SNAKE/refs/heads/main/NO-FE-Snake.txt"))()
end
L["fakelag"] = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Biem6ondo/FAKELAG/refs/heads/main/Fakelag"))()
end
L["shiftlock"] = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MiniNoobie/ShiftLockx/main/Shiftlock-MiniNoobie",true))()
end

-- ── Game-specific command registry ───────────────────────────────────────────
-- To add more: { placeId = 12345, name = "cmdname", url = "https://..." }
_G.ZeroGameCmds = _G.ZeroGameCmds or {
    { placeId = 16472538603, name = "thebronx", url = "https://raw.githubusercontent.com/aizen2tuffy/zero/main/games/ThaBronx.lua" },
}

for _, entry in ipairs(_G.ZeroGameCmds) do
    if game.PlaceId == entry.placeId then
        L[entry.name] = function()
            loadstring(game:HttpGet(entry.url))()
            notify("Loaded "..entry.name)
        end
    end
end

return module
