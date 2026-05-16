-- OPEN SOURCED 
-- ORIGINAL: https://raw.githubusercontent.com/guidrycarter1-collab/VALARY.GG-SOURCE-LEAK/refs/heads/main/The%20Bronx.txt

if LPH_OBFUSCATED == nil then
    local assert = assert
    local type = type
    local setfenv = setfenv
    LPH_ENCNUM = function(toEncrypt, ...)
        assert(type(toEncrypt) == "number" and #{...} == 0, "LPH_ENCNUM only accepts a single constant double or integer as an argument.")
        return toEncrypt
    end
    LPH_NUMENC = LPH_ENCNUM
    LPH_ENCSTR = function(toEncrypt, ...)
        assert(type(toEncrypt) == "string" and #{...} == 0, "LPH_ENCSTR only accepts a single constant string as an argument.")
        return toEncrypt
    end
    LPH_STRENC = LPH_ENCSTR
    LPH_ENCFUNC = function(toEncrypt, encKey, decKey, ...)
        
        assert(type(toEncrypt) == "function" and type(encKey) == "string" and #{...} == 0, "LPH_ENCFUNC accepts a constant function, constant string, and string variable as arguments.")
        return toEncrypt
    end
    LPH_FUNCENC = LPH_ENCFUNC
    LPH_JIT = function(f, ...)
        assert(type(f) == "function" and #{...} == 0, "LPH_JIT only accepts a single constant function as an argument.")
        return f
    end
    LPH_JIT_MAX = LPH_JIT
    LPH_NO_VIRTUALIZE = function(f, ...)
        assert(type(f) == "function" and #{...} == 0, "LPH_NO_VIRTUALIZE only accepts a single constant function as an argument.")
        return f
    end
    LPH_NO_UPVALUES = function(f, ...)
        assert(type(setfenv) == "function", "LPH_NO_UPVALUES can only be used on Lua versions with getfenv & setfenv")
        assert(type(f) == "function" and #{...} == 0, "LPH_NO_UPVALUES only accepts a single constant function as an argument.")
        local env = getrenv()
        return setfenv(
            LPH_NO_VIRTUALIZE(function(...)
                return func(...)
            end),
            setmetatable(
                {
                    func = f
                },
                {
                    __index = env,
                    __newindex = env
                }
            )
        )
    end
    LPH_CRASH = function(...)
        assert(#{...} == 0, "LPH_CRASH does not accept any arguments.")
        game:Shutdown()
        while true do end
    end
    LRM_IsUserPremium = false
    LRM_LinkedDiscordID = "1096603799159832636"
    LRM_ScriptName = "valary"
    LRM_TotalExecutions = 0
    LRM_SecondsLeft = math.huge
    LRM_UserNote = "Developer";
end;

local Window, Watermark;

if getgenv().valary_loaded then
    return
end

getgenv().valary_loaded = true

local LoadingTick = os.clock()

local gethui = gethui or function()
    return game.CoreGui
end

hookfunction(isfunctionhooked, function()
    return false
end)

local Library = {Friendly_Players = {}, Priority_Players = {}, Selected_Player = nil}

local Volcano = string.find(getexecutorname():lower(), "volcano") ~= nil

local Services = setmetatable({}, {
    __index = LPH_NO_VIRTUALIZE(function(self, service, key) 
        return (cloneref ~= nil) and cloneref(game:GetService(service)) or game:GetService(service)
    end)
})

for Index, Value in getconnections(gethui().ChildRemoved) do
    Value:Disable()
end

local Config = {
    ["Gun_Handle"] = nil;
    ["Valary_Users"] = {};

    Tracers = {
        Enabled = false;
        Duration = 3;
        StartColor = Color3.fromRGB(255, 85, 0);
        EndColor = Color3.fromRGB(0, 0, 0);
        Rainbow = false;
    };

    Hit_Sounds = {
        Neverlose = "rbxassetid://8726881116",
        Hitmarker = "rbxassetid://160432334",
        Gamesense = "rbxassetid://4817809188",
        Rust = "rbxassetid://1255040462",
        TF2 = "rbxassetid://2868331684",
        ["Among Us"] = "rbxassetid://5700183626",
        Minecraft = "rbxassetid://4018616850",
        ["CS:GO"] = "rbxassetid://6937353691",
        ["Call Of Duty"] = "rbxassetid://5952120301",
        Pop = "rbxassetid://198598793",
        Bruh = "rbxassetid://4275842574",
        Bamboo = "rbxassetid://3769434519",
        Steve = "rbxassetid://4965083997"
    };

    Hit_Sounds_Settings = {
        Enabled = false;
        Volume = 5;
        Selected = "Neverlose";
        HideNormalSounds = false;
    };

    ["WorldVisuals"] = {
        ["SaturationEnabled"] = false;
        ["Saturation_Value"] = 1;

        ["StretchEnabled"] = false;
        ["StretchValue"] = 0.7;

        ["FogColorEnabled"] = false;
        ["FogColor"] = Color3.new(1,1,1);

        ["AmbientEnabled"] = false;
        ["AmbientColor"] = Color3.new(1,1,1);

        ["FieldOfViewEnabled"] = false;
        ["FieldOfViewValue"] = 70;

        ["Fullbright"] = false;
    };

    ["Gun_Held"] = false;

    ["VehicleModifications"] = {
        ["SpeedEnabled"] = false;
        ["SpeedValue"] = 10/1000;
        ["BreakEnabled"] = false;
        ["BreakValue"] = 50/1000;
        ["InstantStop"] = false;
        ["InstantStopBind"] = Enum.KeyCode.V;
    };

    ["MiscSettings"] = {
        ["ModifySpeed"] = {
            ["Enabled"] = false;
            ["Value"] = 16;
        };
        
        ["ClickTeleport_Enabled"] = false;
        ["ClickTeleport_Key"] = Enum.KeyCode.LeftControl;

        ["ModifyJump"] = {
            ["Enabled"] = false;
            ["Infinity"] = false;
            ["Value"] = 50;
        };

        ["Fly"] = {
            ["Enabled"] = false;
            ["Type"] = "CFrame";
            ["Speed"] = 50;
        };

        ["SpinBot"] = {
            ["Enabled"] = false;
            ["Speed"] = 35;
        };
    };


    ["Connections"] = {};

    ["The_Bronx"] = {
        ["Guns"] = {};

        ["KillAura"] = false;
        ["KillAuraRange"] = 300;
        ["KillAuraWhitelist"] = {};
    
        ["PlayerModifications"] = {
            ["InfiniteSleep"] = false;
            ["InfiniteStamina"] = false;
            ["InfiniteHunger"] = false;
            ["InstantInteract"] = false;
            ["InstantRevive"] = false;
            ["AutoPickupCash"] = false;
            ["AutoPickupBags"] = false;
            ["DisableCameraBobbing"] = false;
            ["DisableCameras"] = false;
            ["BypassLockedCars"] = false;
            ["DisableBloodEffects"] = false;
            ["NoJumpCooldown"] = false;
            ["NoRentPay"] = false;
            ["NoFallDamage"] = false;
            ["FasterRespawn"] = false;
            ["NoKnockback"] = false;
            ["InfiniteHealth"] = false;
            ["RespawnWhereYouDied"] = false;
        };

        ["PlayerUtilities"] = {
            ["SelectedPlayer"] = "...";
            ["BringingPlayer"] = false;
            ["SpectatePlayer"] = false;
            ["AutoKill"] = false;
            ["AutoRagdoll"] = false;
            ["BugPlayer"] = false;
        };

        ["Farms"] = {
            ["CollectDroppedMoney"] = false;

            ["CollectDroppedLoot"] = false;
            ["OnlyCollectGuns"] = false;

            ["AFKCheck"] = false;
            ["FarmConstructionJob"] = false;
            ["FarmBank"] = false;
            ["FarmHouses"] = false;
            ["FarmStudio"] = false;
            ["FarmTrash"] = false;
            ["AutoSellTrash"] = false;
        };

        ["_Modifications"] = {
            ["DisableJamming"] = false;
            ["ModifySpreadValue"] = false;
            ["ModifyRecoilValue"] = false;
            ["Automatic"] = false;
            ["ModifyFireRate"] = false;
            ["InstantReload"] = false;
            ["InstantEquip"] = false;
            ["InfiniteAmmo"] = false;
            ["InfiniteClips"] = false;
            ["InfiniteDamage"] = false;

            ["FireRateSpeed"] = 50;
            ["SpreadPercentage"] = 50;
            ["RecoilPercentage"] = 50;
        };

        ["Modifications"] = newproxy(true);
    };

    ["TargetSelector"] = {
        ["Targetting"] = false;
        ["UseFOV"] = false;
        ["HealthCheck"] = false;
        ["Health"] = 5;
        ["VisibleCheck"] = false;
        ["LimitDistance"] = false;
        ["MaxDistance"] = 500;
        ["FriendCheck"] = false;
        ["ProtectedCheck"] = false;
        ["GangCheck"] = false;
        ["Gangs"] = {};
    };

    ["FieldOfView"] = {
        ["Draw"] = false;
        ["Radius"] = 100;
        ["Transparency"] = 1;
        ["FieldOfViewColor"] = Color3.new(1,1,1);
        ["FilledDraw"] = false;
        ["FilledTransparency"] = 0.25;
        ["FilledColor"] = Color3.new(1,1,1);
        ["DrawSnapline"] = false;
        ["SnaplineColor"] = Color3.new(1,1,1);
        ["HightlightTarget"] = false;
        ["HightlightFillColor"] = Color3.new(1,1,1);
        ["HightlightFillTransparency"] = 0.75;
        ["HightlightOutlineColor"] = Color3.new(1,1,1);
        ["HightlightOutlineTransparency"] = 0.25;
    };
    
    ["Silent"] = {
        ["Enabled"] = false;
        ["WallBang"] = false;
        ["HitChance"] = 100;
        ["HitParts"] = {"Head"};
        ["Spread"] = nil;
    };
}

local Players = Services.Players;
local ReplicatedStorage = Services.ReplicatedStorage;
local UserInputService = Services.UserInputService;
local Workspace = Services.Workspace;
local RunService = Services.RunService;
local ProximityPromptService = Services.ProximityPromptService;
local MarketplaceService = Services.MarketplaceService;
local StarterGui = Services.StarterGui
local VirtualInputManager = Services.VirtualInputManager;
local Lighting = Services.Lighting
local Debris = Services.Debris
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Stats = Services.Stats

local Device_Mobile = UserInputService.TouchEnabled or false

local Game_Name_MarketPlaceService = "Tha Bronx 3 🐍"

local Mouse = LocalPlayer:GetMouse()
local Move_Mouse_Function = mousemoverel

local Player_Collide_Data = {}

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

for Index, Value in LocalPlayer.Character:GetDescendants() do
    pcall(function()
        if Value.CanCollide == true then
            Player_Collide_Data[Value.Name] = Value.CanCollide
        end
    end)
end

local Target_Highlight = Instance.new("Highlight", Services.CoreGui)

Target_Highlight.FillColor = Config.FieldOfView.HightlightFillColor
Target_Highlight.OutlineColor = Color3.new(1,1,1)
Target_Highlight.FillTransparency = Config.FieldOfView.HightlightFillTransparency
Target_Highlight.OutlineTransparency = 1
Target_Highlight.Enabled = true

local RootPart = nil;

if LocalPlayer.Character then
    RootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
end

LocalPlayer.CharacterAdded:Connect(LPH_NO_VIRTUALIZE(function(Character)
    RootPart = Character:WaitForChild("HumanoidRootPart")
end))

local FireServer, InvokeServer, UnreliableFireServer = Instance.new("RemoteEvent").FireServer, Instance.new("RemoteFunction").InvokeServer, Instance.new("UnreliableRemoteEvent").FireServer

if isfunctionhooked then
    if isfunctionhooked(FireServer) or isfunctionhooked(UnreliableFireServer) or isfunctionhooked(InvokeServer) and LPH_OBFUSCATED then
        return Services.Players.LocalPlayer:Kick("Valary.gg | Security : You are running another script, please disable it and execute again")
    end
end

do -- FrameWork
    -- Load In Assets
        local Black_UI = nil;
        
        for Index, Value in getconnections(LocalPlayer.Idled) do
            if Value["Disable"] then
                Value["Disable"](Value)
            end

            if Value["Disconnect"] then
                Value["Disconnect"](Value)
            end
        end
    --

    Config.HideScreen = LPH_JIT_MAX(function(Self, Title)
        Black_UI = Instance.new("ScreenGui")
        Black_UI.Name = getexecutorname().."____{_____"
        Black_UI.Parent = gethui and gethui() or Services.CoreGui
    
        local frame = Instance.new("Frame")
        frame.Name = "BlackFrame"
        frame.Size = UDim2.new(2, 0, 2, 0) 
        frame.Position = UDim2.new(0, -155, 0, -155) 
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
        frame.BackgroundTransparency = 0
        frame.Parent = Black_UI
    
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "\nhideuivalary"
        textLabel.Size = UDim2.new(0, 400, 0, 100)
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.RichText = true
        local accent = Library.Theme.Accent
        local accentString = string.format("rgb(%d,%d,%d)", accent.R * 255, accent.G * 255, accent.B * 255)

        textLabel.Text = '<font color="' .. accentString .. '">valary</font>\n' .. Title
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.BackgroundTransparency = 1
        textLabel.TextSize = 36
        textLabel.TextStrokeTransparency = 0.8 
        textLabel.TextXAlignment = Enum.TextXAlignment.Center
        textLabel.TextYAlignment = Enum.TextYAlignment.Center
        textLabel.TextWrapped = true
        textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        textLabel.Parent = Black_UI
    
        return textLabel
    end)

    Config.SetText = LPH_JIT_MAX(function(Self, Text)
        if Black_UI then
            local accent = Library.Theme.Accent
            local accentString = string.format("rgb(%d,%d,%d)", accent.R * 255, accent.G * 255, accent.B * 255)

            Black_UI["\nhideuivalary"].Text = '<font color="' .. accentString .. '">valary</font>\n' .. Text
        end
    end)

    local AllowedToDelete = false

    Config.DeleteHiddenScreen = LPH_JIT_MAX(function()
        AllowedToDelete = true

        if Black_UI then
            Black_UI:Destroy()
            Black_UI = nil
        end

        pcall(function()
            for Index, Value in gethui():GetChildren() do
                if Value.Name == getexecutorname().."____{_____" then
                    Value:Destroy()
                end
            end
        end)

        task.delay(.1, function()
            AllowedToDelete = false
        end)
    end)

    Config.Teleport = LPH_JIT_MAX(function(Self, CFrame)
        if not LocalPlayer.Character then return end
        if not LocalPlayer.Character:FindFirstChild("Humanoid") then return end

        --LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame
        
        LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(0)

        local Num = 1
        repeat task.wait() Num+=1 until Num >= 40 and not LocalPlayer:GetAttribute("LastACPos")
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame

        task.wait()
        LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(2)

        return true
    end)

    Config.GunRemote = LPH_JIT_MAX(function(self, target, hpart, damage) 
        if not hpart then
            hpart = "head"
        end

        if not damage then
            damage = math.huge
        end

        local data = {
            ["tool"] = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
            ["target"] = Players[target],
            ["hitpos"] = Players[target].Character[hpart].Position,
        }

        if not rawget(data, "tool") then
            return
        end

        require(rawget(data, "tool").Setting).Range = 10000

        ReplicatedStorage.VisualizeMuzzle:FireServer(table.unpack({
            rawget(data, "tool").Handle,
            true,
            {
                false,
                7,
                Color3.new(1, 1.1098039150238, 0),
                15,
                true,
                0.02
            },
            rawget(data, "tool").GunScript_Local.MuzzleEffect
        }))

        ReplicatedStorage.VisualizeBullet:FireServer(table.unpack({
            rawget(data, "tool"),
            rawget(data, "tool").Handle,
            Vector3.new(-0.17746905982494, 0.088731124997139, 0.98011803627014),
            rawget(data, "tool").Handle.GunFirePoint,
            {
                true,
                {
                    112139677907600,
                    92977228204408,
                    112139677907600,
                    92977228204408
                },
                1,
                1,
                10,
                rawget(data, "tool").GunScript_Local.HitEffect,
                true
            },
            {
                true,
                {
                    0,
                    0,
                    0,
                    0,
                    0,
                    0
                },
                1,
                1,
                1,
                rawget(data, "tool").GunScript_Local.BloodEffect
            },
            {
                true,
                0.2,
                {
                    3696144972
                },
                true,
                7,
                1
            },
            {
                false,
                8,
                true,
                {
                    163064102
                },
                1,
                1.5,
                1,
                false,
                rawget(data, "tool").GunScript_Local.ExplosionEffect
            },
            {
                false,
                Vector3.new(0.10000000149012, 0, 0),
                Vector3.new(-0.10000000149012, 0, 0),
                rawget(data, "tool").GunScript_Local.TracerEffect,
                nil,
                rawget(data, "tool").GunScript_Local.ParticleEffect,
                300,
                526,
                0,
                Vector3.zero,
                Vector3.new(0.40000000596046, 0.40000000596046, 0.40000000596046),
                Color3.new(0.63921570777893, 0.63529413938522, 0.61176472902298),
                1,
                Enum.Material.Neon,
                Enum.PartType.Cylinder,
                false,
                6696543809,
                0,
                Vector3.new(0.0070000002160668, 0.0070000002160668, 0.0070000002160668)
            },
            {
                true,
                {
                    269514869,
                    269514887,
                    269514807,
                    269514817
                },
                0.5,
                1,
                1.5,
                100
            },
            {
                false,
                3,
                Color3.new(1, 0.64705884456635, 0.60000002384186),
                6,  
                true
            }
        }))

        ReplicatedStorage.InflictTarget:FireServer(table.unpack({
            rawget(data, "tool"),
            LocalPlayer,
            rawget(data, "target").Character.Humanoid,
            rawget(data, "target").Character[hpart],
            damage,
            {
                0,
                0,
                false,
                false,
                rawget(data, "tool").GunScript_Server.IgniteScript,
                rawget(data, "tool").GunScript_Server.IcifyScript,
                100,
                100
            },
            {
                false,
                5,
                3
            },
            rawget(data, "target").Character[hpart],
            {
                false,
                {
                    1930359546
                },
                1,
                1.5,
                1
            },
            rawget(data, "hitpos"),
            Vector3.new(0.074456036090851, -0.099775791168213, -0.99222022294998),
            true
        }))
    end)

    Config.GetWorkingSafe = LPH_NO_VIRTUALIZE(function(Self)        
        for Index, Value in Workspace["1# Map"]:GetChildren() do
            if Value.Name == "Safe" and Value.WorldPivot == CFrame.new(-133.97406, 300.476318, -916.198181, 0, 1, 0, 0, 0, -1, -1, 0, 0) then
                return Value
            end
        end
    end)

    gethui().ChildRemoved:Connect(function(Value)
        if Value.Name == getexecutorname().."____{_____" and not AllowedToDelete then
            game:Shutdown()
            while true do end
        end
    end)

    local Draw = LPH_NO_VIRTUALIZE(function(Class, Properties)
        local Drawing = Drawing.new(Class)

        for Index, Value in Properties do
            Drawing[Index] = Value
        end

        return Drawing
    end)

    local Center_Of_Screen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    RunService:BindToRenderStep("Center_Of_Screen", 0, LPH_NO_VIRTUALIZE(function()
        Center_Of_Screen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end))

    local Target = nil;

    FieldOfViewOutline = Draw("Circle", {Visible = true, Color = Color3.new(0, 0, 0), Radius = 100, NumSides = 100, Thickness = 4});
    FieldOfView = Draw("Circle", {Visible = true, Color = Color3.new(1, 1, 1), Radius = 100, NumSides = 100, Thickness = 2});
    FieldOfViewFill = Draw("Circle", {Visible = true, Color = Color3.new(1, 1, 1), Radius = 100, NumSides = 100, Thickness = 2, Filled = true, Transparency = 1});

    SnaplineOutline = Draw("Line", {Visible = false, Color = Color3.new(0, 0, 0), Thickness = 3});
    Snapline = Draw("Line", {Visible = false, Color = Color3.new(1, 1, 1), Thickness = 1});

    local WallCheck = LPH_NO_VIRTUALIZE(function(Character)
        local Origin = Camera.CFrame.Position;
        local Position = Character.Head.Position;
        local Parameters = RaycastParams.new();
    
        Parameters.FilterDescendantsInstances = { LocalPlayer.Character, Camera, Character };
        Parameters.FilterType = Enum.RaycastFilterType.Blacklist;
        Parameters.IgnoreWater = true;
    
        return not Workspace:Raycast(Origin, Position - Origin, Parameters)
    end)

    local DistanceCheck = LPH_NO_VIRTUALIZE(function(Player, Distance)
        if not Player then
            return false
        end

        if not Player.Character or not LocalPlayer.Character then
            return false
        end

        local TargetRootPart, LocalRootPart = Player.Character:FindFirstChild("HumanoidRootPart"), LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if Player.Character and LocalPlayer.Character and LocalRootPart and TargetRootPart then
            local Magnitude = (LocalRootPart.Position - TargetRootPart.Position).Magnitude;

            return Distance > Magnitude
        end;

        return false
    end);

    local Friends = {}

    local CheckPlayer = LPH_NO_VIRTUALIZE(function(Plr)
        if Plr == LocalPlayer then return end

        if LocalPlayer:IsFriendsWith(Plr.UserId) and not table.find(Friends, Plr.Name) then
            table.insert(Friends, Plr.Name)
        end
    end)

    Config.Connections["PlayerAdded_FriendCheck"] = Players.PlayerAdded:Connect(CheckPlayer)

    for Index, Value in Players:GetPlayers() do
        CheckPlayer(Value)
    end
    
    local GetSelectedTarget = LPH_NO_VIRTUALIZE(function()
        if Device_Mobile then
            Config.TargetSelector.Targetting = Config.Silent.Enabled
        end

        if not Config.TargetSelector.Targetting then
            Target = nil
            return nil
        end
    
        local PlayersList = Players:GetPlayers()
        local MouseLocation = Device_Mobile and Center_Of_Screen or Vector2.new(Mouse.X, Mouse.Y)
        local Radius = Config.TargetSelector.UseFOV and Config.FieldOfView.Radius or math.huge
    
        local ClosestPlayer = nil
        local ClosestDistance = math.huge
    
        for _, Player in ipairs(PlayersList) do
            if Player == LocalPlayer then continue end
            if table.find(Library.Friendly_Players, Player.Name) then continue end
    
            local Character = Player.Character
            if not Character then continue end
    
            local Humanoid = Character:FindFirstChild("Humanoid")
            local Head = Character:FindFirstChild("Head")
    
            if not Humanoid or not Head then continue end
    
            local ScreenPos, OnScreen = Camera:WorldToScreenPoint(Head.Position)
            if not OnScreen then continue end
    
            local Distance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MouseLocation).Magnitude
            if Distance > Radius then continue end

            local IsVisible = true
            if Config.TargetSelector.VisibleCheck and not Config.Silent.WallBang then
                IsVisible = WallCheck(Character)
                if not IsVisible then continue end
            end

            if Config.TargetSelector.HealthCheck and Humanoid.Health < Config.TargetSelector.Health then continue end
            if Config.TargetSelector.FriendCheck and table.find(Friends, Player.Name) then continue end
            if Config.TargetSelector.LimitDistance and not DistanceCheck(Player, Config.TargetSelector.MaxDistance) then continue end
            --if library.get_priority(Player) == "Friendly" then continue end
    
            if Distance < ClosestDistance then
                ClosestDistance = Distance
                ClosestPlayer = Player
            end
        end
    
        Target = ClosestPlayer
        return Target
    end)

    local FindFirstChild = Workspace.FindFirstChild
    local Tracer_Delay = false

    Config.PlaySound = LPH_NO_VIRTUALIZE(function()
        if not Config.Hit_Sounds_Settings.Enabled then return end

        local sound = Instance.new("Sound")
        sound.SoundId = Config.Hit_Sounds[Config.Hit_Sounds_Settings.Selected]
        sound.Volume = Config.Hit_Sounds_Settings.Volume
        sound.Looped = false
        sound.Parent = Workspace
        sound.RollOffMode = Enum.RollOffMode.Linear
        sound.EmitterSize = 2
        sound.MaxDistance = 10

        sound:Play()
    end)

    Config.Tracer = LPH_NO_VIRTUALIZE(function(EndPos)
        if Tracer_Delay then return end

        Tracer_Delay = true

        pcall(function()
            local StartPart = Instance.new("Part")
            StartPart.Anchored = true
            StartPart.Transparency = 1
            StartPart.Position = Config.Gun_Handle.GunMuzzlePoint.WorldCFrame.Position
            StartPart.Parent = workspace
            StartPart.CanCollide = false
            StartPart.CanQuery = false
            StartPart.CanTouch = false

            local EndPart = Instance.new("Part")
            EndPart.Anchored = true
            EndPart.CanCollide = false
            EndPart.Transparency = 1
            EndPart.Position = EndPos -- (Config.Silent.Enabled == true and TargetPart~=nil) and TargetPart.Position or Mouse.Hit.Position
            EndPart.Parent = workspace
            EndPart.CanQuery = false
            EndPart.CanTouch = false

            local Attachment0 = Instance.new("Attachment", StartPart)
            local Attachment1 = Instance.new("Attachment", EndPart)

            local Beam = Instance.new("Beam")
            Beam.Attachment0 = Attachment0
            Beam.Attachment1 = Attachment1
            Beam.FaceCamera = true
            Beam.LightEmission = 1
            Beam.Width0 = 0.1
            Beam.Width1 = 0.05
            Beam.Parent = StartPart

            if Config.Tracers.Rainbow then
                task.spawn(function()
                    while Beam and Beam.Parent do
                        local Hue = tick() % 5 / 5
                        local NextHue = (Hue + 0.1) % 1

                        Beam.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromHSV(Hue, 1, 1)),
                            ColorSequenceKeypoint.new(1, Color3.fromHSV(NextHue, 1, 1))
                        })

                        task.wait(0.05)
                    end
                end)
            else
                Beam.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Config.Tracers.StartColor),
                    ColorSequenceKeypoint.new(1, Config.Tracers.EndColor)
                })
            end

            task.delay(Config.Tracers.Duration, function()
                StartPart:Destroy()
                EndPart:Destroy()
            end)
        end)

        task.spawn(function()
            task.wait()
            Tracer_Delay = false;
        end)
    end)

    __namecall_hook = nil; __namecall_hook = hookmetamethod(Workspace, "__namecall", LPH_NO_VIRTUALIZE(function(Self, ...)
        local Arguments = {...}
        local Method = getnamecallmethod()
        
        if Method == "FireServer" then
            if Self == ReplicatedStorage.InflictTarget and not checkcaller() then
                task.spawn(Config.PlaySound)
            end 
        end 

        if string.find(string.lower(Method), 'findpartonray') then
            local cs = getcallingscript()

            if checkcaller() or string.find(cs.Name, "CameraModule") then
                return __namecall_hook(Self, unpack(Arguments))
            end

            if Config.Silent.Enabled then
                if not (math.random(0, 100) <= Config.Silent.HitChance) then
                    return __namecall_hook(Self, ...)
                end

                if Target and Target.Character then
                    local TargetPart = FindFirstChild(Target.Character, Config.Silent.HitParts[1] and Config.Silent.HitParts[math.random(1, #Config.Silent.HitParts)] or "Head")
                    if TargetPart then
                        local Origin = Arguments[1].Origin;

                        local Direction = (TargetPart.Position - Origin).Unit * 9e17;

                        Arguments[1] = Ray.new(Origin, Direction)

                        if Config.Silent.WallBang then
                            if Config.Tracers.Enabled then
                                task.spawn(Config.Tracer, TargetPart.Position)
                            end

                            return TargetPart, TargetPart.Position, Vector3.new(0,0,0)
                        end
                    end
                end
            end

            if Config.Tracers.Enabled then
                task.spawn(Config.Tracer, Arguments[1].Origin + Arguments[1].Direction)
            end
        end

        return __namecall_hook(Self, unpack(Arguments))
    end))

    local OldLightingSettings = {}

    OldLightingSettings["Brightness"] = Lighting.Brightness
    OldLightingSettings["ClockTime"] = Lighting.ClockTime
    OldLightingSettings["FogEnd"] = Lighting.FogEnd
    OldLightingSettings["GlobalShadows"] = Lighting.GlobalShadows
    OldLightingSettings["OutdoorAmbient"] = Lighting.OutdoorAmbient

    local Tint = Instance.new("ColorCorrectionEffect", Lighting)
    local OldSaturation = Lighting.ColorCorrection.Saturation
    local OldFogColor = Lighting.FogColor
    local Set_Fog, Set_Fov, Set_FullBright = false, false, false
    RunService:BindToRenderStep("World_Visuals", Enum.RenderPriority.Camera.Value, LPH_NO_VIRTUALIZE(function()
        if Config.WorldVisuals.StretchEnabled then
            Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, Config.WorldVisuals.StretchValue, 0, 0, 0, 1)
        end 

        if Config.WorldVisuals.FieldOfViewEnabled then
            Set_Fov = false
            Camera.FieldOfView = Config.WorldVisuals.FieldOfViewValue
        else
            if not Set_Fov then 
                Set_Fov = true
                Camera.FieldOfView = 70
            end
        end

        if Config.WorldVisuals.SaturationEnabled then
            Lighting.ColorCorrection.Saturation = Config.WorldVisuals.Saturation_Value
        else
            Lighting.ColorCorrection.Saturation = OldSaturation
        end

        if Config.WorldVisuals.Fullbright then
            Set_FullBright = false
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            if not Set_FullBright then
                Set_FullBright = true
                
                Lighting.Brightness = OldLightingSettings.Brightness
                Lighting.FogEnd = OldLightingSettings.FogEnd
                Lighting.GlobalShadows = OldLightingSettings.GlobalShadows
                Lighting.OutdoorAmbient = OldLightingSettings.OutdoorAmbient
            end
        end

        if Config.WorldVisuals.AmbientEnabled then
            Tint.TintColor = Config.WorldVisuals.AmbientColor
        else
            Tint.TintColor = Color3.new(1,1,1)
        end

        if Config.WorldVisuals.FogColorEnabled then
            Set_Fog = false
            Lighting.FogColor = Config.WorldVisuals.FogColor
        else
            if not Set_Fog then
                Set_Fog = true

                Lighting.FogColor = OldFogColor
            end
        end
    end))

    TargetFetcherConnection = RunService.RenderStepped:Connect(GetSelectedTarget)

    RunService:BindToRenderStep("FieldOfViewConnection", 0, LPH_NO_VIRTUALIZE(function()
        local ClientPosition = Device_Mobile and Center_Of_Screen or UserInputService:GetMouseLocation()

        FieldOfView.Position = ClientPosition
        FieldOfViewOutline.Position = FieldOfView.Position
        FieldOfView.Visible = Config.FieldOfView.Draw
        FieldOfViewOutline.Visible = FieldOfView.Visible
        FieldOfViewFill.Position = FieldOfView.Position
        FieldOfViewFill.Visible = FieldOfView.Visible and Config.FieldOfView.FilledDraw

        if Target and Target.Character and Target.Character:FindFirstChild("Head") then
            local PlayerPosition, OnScreen = Camera:WorldToViewportPoint(Target.Character:FindFirstChild("Head").Position)

            Snapline.Visible = (Config.FieldOfView.DrawSnapline and Target and OnScreen)
            SnaplineOutline.Visible = Snapline.Visible

            if (Snapline.Visible and OnScreen) then
                Snapline.From = ClientPosition
                SnaplineOutline.From = Snapline.From

                Snapline.To = Vector2.new(PlayerPosition.X, PlayerPosition.Y)
                SnaplineOutline.To = Snapline.To
            end;

            if Config.FieldOfView.HightlightTarget then
                Target_Highlight.Adornee = Target.Character
            else
                Target_Highlight.Adornee = nil
            end
        else
            Snapline.Visible = false
            SnaplineOutline.Visible = false
            Target_Highlight.Adornee = nil
        end
    end))

    if Workspace:FindFirstChild(("Guns"):upper()) then
        for Index, Value in Workspace:FindFirstChild(("Guns"):upper()):GetChildren() do
            if not Value:IsA("Model") then continue end;
            local Price = Value:FindFirstChild("Price", true).Value;
            if Price == 0 then continue end;
            if Price > 100000 then continue end;
            if Price < 10 then continue end;
            
            if not table.find(Config.The_Bronx.Guns, Value.Name.." - $"..tostring(Price)) then
                table.insert(Config.The_Bronx.Guns, Value.Name.." - $"..tostring(Price));
            end;
        end
    end

    -- Auto Farms
        Config.CollectDroppedMoney = LPH_NO_VIRTUALIZE(function()  
            if not Config.The_Bronx.Farms.CollectDroppedMoney then return end
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
            local OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

            for Index, Value in next, {Workspace.Dollas:GetChildren()} do
                for _Index, _Value in Value do
                    if not _Value:IsA("Part") then continue end

                    Config:Teleport(_Value.CFrame + Vector3.new(0, 3.5, 0))

                    task.wait(0.4)

                    fireproximityprompt(_Value.ProximityPrompt)

                    task.wait(_Value.ProximityPrompt.HoldDuration)
                end
            end

            Config:Teleport(OldCFrame)

            task.wait(0.4)

            return true
        end)

        Config.CollectLootBags = LPH_NO_VIRTUALIZE(function()  
            if not Config.The_Bronx.Farms.CollectDroppedLoot then return end
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
            local OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

            for Index, Value in next, {Workspace.Storage:GetChildren()} do
                for _Index, _Value in Value do
                    if not _Value:IsA("MeshPart") then continue end
                    if _Value:FindFirstChild("PlayerName").Value == LocalPlayer.Name then continue end

                    Config:Teleport(_Value.CFrame + Vector3.new(0, 3.5, 0))

                    task.wait(0.4)

                    fireproximityprompt(_Value.stealprompt)

                    task.wait(_Value.stealprompt.HoldDuration)
                end
            end

            return true
        end)

        Workspace.Storage.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function()
            task.spawn(Config.CollectLootBags)
        end))

        Workspace.Dollas.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function()
            task.spawn(Config.CollectDroppedMoney)
        end))

        local Get_Vehicle = LPH_NO_VIRTUALIZE(function()
            for Index, Value in Workspace.CivCars:GetChildren() do
                if not Value:FindFirstChild("DriveSeat") then continue end
                if not Value.DriveSeat.Occupant then
                    return Value
                end
            end
        end)

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while task.wait() do
                if not Config.The_Bronx.PlayerUtilities.BugPlayer then continue end
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not Players:FindFirstChild(Library.Selected_Player.Name) or not Players:FindFirstChild(Library.Selected_Player.Name).Character or not Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("HumanoidRootPart") then continue end                    

                local Car_To_Use = Get_Vehicle()

                if not Car_To_Use then continue end
                if not Car_To_Use:FindFirstChild("DriveSeat") then continue end
                if Car_To_Use:FindFirstChild("DriveSeat").Occupant then continue end

                if not Car_To_Use:GetAttribute("Usable") or Car_To_Use:GetAttribute("Usable") == false then
                    Car_To_Use.DriveSeat:Sit(LocalPlayer.Character.Humanoid)

                    Car_To_Use:SetAttribute("Usable", true)
                    task.wait(1)

                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

                    LocalPlayer.Character.Humanoid.Jump = true
                    LocalPlayer.Character.Humanoid.Sit = false
                end

                Car_To_Use.DriveSeat:GetPropertyChangedSignal("Occupant"):Connect(function()
                    task.wait()
                    
                    if Car_To_Use.DriveSeat.Occupant and Car_To_Use.DriveSeat.Occupant ~= LocalPlayer.Character.Humanoid then
                        Car_To_Use:SetAttribute("Usable", false)
                    end
                end)
                
                task.wait()

                if not Car_To_Use.PrimaryPart then
                    Car_To_Use.PrimaryPart = Car_To_Use.Body:FindFirstChild("#Weight", true)
                end

                if not Car_To_Use.PrimaryPart then
                    Car_To_Use.PrimaryPart = Car_To_Use.Body:FindFirstChildWhichIsA("Part", true)
                end

                Car_To_Use:SetPrimaryPartCFrame(Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("HumanoidRootPart").CFrame)
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while task.wait(1) do
                if not Config.The_Bronx.PlayerUtilities.AutoKill then continue end
                if not LocalPlayer.Character then continue end
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not Players:FindFirstChild(Library.Selected_Player.Name) or not Players:FindFirstChild(Library.Selected_Player.Name).Character or not Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("HumanoidRootPart") then continue end                    
                if not LocalPlayer.Character:FindFirstChildOfClass("Tool") then continue end
                if not LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript_Local") then continue end

                if Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("Humanoid").Health == 0 then continue end
                if Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChildOfClass("ForceField") then continue end

                Config:GunRemote(Library.Selected_Player.Name, 'Head', math.huge)
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while task.wait(2) do
                if not Config.The_Bronx.PlayerUtilities.AutoRagdoll then continue end
                if not LocalPlayer.Character then continue end
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not Players:FindFirstChild(Library.Selected_Player.Name) or not Players:FindFirstChild(Library.Selected_Player.Name).Character or not Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("HumanoidRootPart") then continue end                    
                if not LocalPlayer.Character:FindFirstChildOfClass("Tool") then continue end
                if not LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript_Local") then continue end

                if Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("Humanoid").Health == 0 then continue end
                if Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("Humanoid"):GetState() == Enum.HumanoidStateType.Physics then continue end

                Config:GunRemote(Library.Selected_Player.Name, 'RightUpperLeg', 0.01)
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while task.wait() do
                if not Config.The_Bronx.PlayerUtilities.BringingPlayer then continue end
                if tostring(Library.Selected_Player.Name) == tostring(LocalPlayer) then continue end
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not Players:FindFirstChild(Library.Selected_Player.Name) or not Players:FindFirstChild(Library.Selected_Player.Name).Character or not Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("HumanoidRootPart") then continue end
                Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("HumanoidRootPart").CFrame = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(2, 0, 0)
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while task.wait(1) do
                if not Config.The_Bronx.KillAura then continue end
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChildOfClass("Tool") or not LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Setting") then continue end
                for Index, Value in Players:GetPlayers() do
                    if table.find(Library.Friendly_Players, Value.Name) then continue end
                    if Value == LocalPlayer then continue end
                    if not Value.Character or not Value.Character:FindFirstChildOfClass("Humanoid") or not Value.Character:FindFirstChild("HumanoidRootPart") then continue end
                    if Value.Character:FindFirstChildOfClass("Humanoid").Health == 0 then continue end
                    if Value.Character:FindFirstChildOfClass("ForceField") then continue end

                    if not DistanceCheck(Value, Config.The_Bronx.KillAuraRange) then continue end

                    Config:GunRemote(Value.Name, 'Head', math.huge)
                end
            end
        end))

        local GetPlaceToPlaceWood = LPH_NO_VIRTUALIZE(function()
            for Index, Value in Workspace.ConstructionStuff:GetChildren() do
                if Value.Name:find("Wall") and Value:IsA("Part") and Value:FindFirstChild("Prompt") then
                    if Value:FindFirstChild("Prompt").Enabled then
                        return Value
                    end
                end
            end
        end)

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do task.wait()
                if not Config.The_Bronx.Farms.FarmConstructionJob then continue end

                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
                if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then continue end

                if not LocalPlayer:GetAttribute("WorkingJob") then
                    Config:Teleport(CFrame.new(-1729, 371, -1171))

                    task.wait(0.4)

                    fireproximityprompt(Workspace.ConstructionStuff["Start Job"].Prompt)

                    repeat task.wait() until LocalPlayer:GetAttribute("WorkingJob")
                end

                if not LocalPlayer.Backpack:FindFirstChild("PlyWood") and not LocalPlayer.Character:FindFirstChild("PlyWood") then
                    Config:Teleport(CFrame.new(-1728, 371, -1178))
                    
                    repeat task.wait() fireproximityprompt(Workspace.ConstructionStuff["Grab Wood"].Prompt) until LocalPlayer.Backpack:FindFirstChild("PlyWood") or LocalPlayer.Character:FindFirstChild("PlyWood")
                end

                repeat task.wait() until LocalPlayer.Backpack:FindFirstChild("PlyWood") or LocalPlayer.Character:FindFirstChild("PlyWood")

                if LocalPlayer.Backpack:FindFirstChild("PlyWood") then
                    LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("PlyWood"))
                end

                local PlaceToPlaceWood = GetPlaceToPlaceWood()

                if not PlaceToPlaceWood then continue end

                Config:Teleport(PlaceToPlaceWood.CFrame)

                repeat task.wait()
                    fireproximityprompt(PlaceToPlaceWood.Prompt)
                until not LocalPlayer.Character:FindFirstChild("PlyWood") or not PlaceToPlaceWood.Prompt.Enabled
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do task.wait()
                if not Config.The_Bronx.Farms.FarmBank then continue end

                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
                if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then continue end

                local Robbable = Workspace.vault.door.robPrompt.ProximityPrompt.Enabled

                if not Robbable then
                    if Config.The_Bronx.Farms.AFKCheck then
                        Config:Teleport(CFrame.new(-437, 33, 6653))
                    end

                    task.wait(0.4)

                    continue
                end

                if not LocalPlayer.Character:FindFirstChild("DuffelBag") then
                    Config:Teleport(CFrame.new(-414, 334, -549))

                    task.wait(0.4)

                    fireproximityprompt(Workspace.dufflebagequip:FindFirstChildWhichIsA("ProximityPrompt"))
                end

                if not LocalPlayer.Backpack:FindFirstChild("C4") and not LocalPlayer.Character:FindFirstChild("C4") then
                    Config:Teleport(CFrame.new(-412, 334, -562))

                    task.wait(0.4)

                    fireproximityprompt(Workspace.GUNS.C4.Handle.BuyPrompt)
                end

                repeat task.wait() until LocalPlayer.Backpack:FindFirstChild("C4") or LocalPlayer.Character:FindFirstChild("C4")

                LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("C4"))

                Config:Teleport(CFrame.new(-216, 374, -1216))

                task.wait(0.4)

                fireproximityprompt(Workspace.vault.door.robPrompt.ProximityPrompt)

                task.wait(2)

                local Number = LocalPlayer.Character.DuffelBag.display.SurfaceGui.Frame.TextLabel.Text

                Number = Number:gsub("0/", "")

                for Index = 1, tonumber(Number) do
                    local Cash = Workspace.BankItems.Cash:FindFirstChild("Cash")

                    if not Cash then
                        for i,v in Workspace:GetChildren() do
                            if v.Name == "Cash" and v:IsA("Model") and v:FindFirstChild("Model") then
                                Cash = v
                            end
                        end
                    end

                    Config:Teleport(Cash.Model.Cash.CFrame)
                    task.wait(0.4)
                    fireproximityprompt(Cash.Model:FindFirstChildWhichIsA("ProximityPrompt", true))
                    task.wait(.25)
                end

                Config:Teleport(Workspace.sellgold.CFrame)

                task.wait(0.4)

                fireclickdetector(Workspace.sellgold.ClickDetector)
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do task.wait()
                if not Config.The_Bronx.Farms.FarmHouses then continue end

                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
                if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then continue end

                local HardDoorEnabled = Workspace.HouseRobb.HardDoor.Door:FindFirstChildWhichIsA("ProximityPrompt", true).Enabled

                if not HardDoorEnabled and Config.The_Bronx.Farms.AFKCheck then
                    Config:Teleport(CFrame.new(-437, 33, 6653))
                    continue
                end

                if HardDoorEnabled then
                    Config:Teleport(Workspace.HouseRobb.HardDoor.Door:FindFirstChildWhichIsA("ProximityPrompt", true).Parent.CFrame)

                    repeat task.wait()
                    
                    fireproximityprompt(Workspace.HouseRobb.HardDoor.Door:FindFirstChildWhichIsA("ProximityPrompt", true))

                    until Workspace.HouseRobb.HardDoor:FindFirstChild("TakeMoney") and Workspace.HouseRobb.HardDoor:FindFirstChild("TakeMoney"):FindFirstChild("MoneyGrab"):FindFirstChildWhichIsA("ProximityPrompt", true).Enabled


                    for Index, Value in Workspace.HouseRobb.HardDoor.TakeMoney:GetChildren() do                            
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Value.CFrame
                        fireproximityprompt(Value.ProximityPrompt)
                        task.wait(0.025)
                    end

                    continue
                end
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do task.wait()
                if not Config.The_Bronx.Farms.FarmStudio then continue end

                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
                if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then continue end

                local Prompt1, Prompt2, Prompt3 = Workspace.StudioPay.Money.StudioPay1:FindFirstChild("Prompt", true), Workspace.StudioPay.Money.StudioPay2:FindFirstChild("Prompt", true), Workspace.StudioPay.Money.StudioPay3:FindFirstChild("Prompt", true)

                if Prompt1.Enabled then
                    Config:Teleport(Prompt1.Parent.CFrame)
                    task.wait(0.4)
                    fireproximityprompt(Prompt1)
                    task.wait(0.1)
                end

                if Prompt2.Enabled then
                    Config:Teleport(Prompt2.Parent.CFrame)
                    task.wait(0.4)
                    fireproximityprompt(Prompt2)
                    task.wait(0.1)
                end

                if Prompt3.Enabled then
                    Config:Teleport(Prompt3.Parent.CFrame)
                    task.wait(0.4)
                    fireproximityprompt(Prompt3)
                    task.wait(0.1)
                end
                
                if Config.The_Bronx.Farms.AFKCheck then
                    task.wait(0.4)
                    Config:Teleport(CFrame.new(-437, 33, 6653))
                    task.wait(0.4)
                    continue
                end
            end
        end))

        local PressKey = function(KeyCode, Duration)
            task.spawn(LPH_NO_VIRTUALIZE(function()
                Services.VirtualInputManager:SendKeyEvent(false, KeyCode, false, game)
                Services.VirtualInputManager:SendKeyEvent(true, KeyCode, false, game)
                task.wait(Duration)
                Services.VirtualInputManager:SendKeyEvent(false, KeyCode, false, game)
            end))
        end

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do task.wait()
                if not Config.The_Bronx.Farms.FarmTrash then continue end

                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
                if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then continue end

                for Index, Value in Workspace:GetChildren() do
                    if Value.Name == "DumpsterPromt" and Config.The_Bronx.Farms.FarmTrash then
                        if Value:FindFirstChild("ProximityPrompt") and Value:FindFirstChild("ProximityPrompt").Enabled then
                            Value:FindFirstChild("ProximityPrompt").HoldDuration = 0
                            Config:Teleport(CFrame.new(Value.Position.X, Value.Position.Y, Value.Position.Z))
                            task.wait(0.25)

                            xpcall(function()
                                replicatesignal(Value.ProximityPrompt.TriggeredActionReplicated, LocalPlayer)
                            end, function()
                                fireproximityprompt(Value:FindFirstChild("ProximityPrompt"))
                            end)

                            task.wait(0.1)
                            Value:FindFirstChild("ProximityPrompt").HoldDuration = 1
                        end
                    end 
                end

                if Config.The_Bronx.Farms.AutoSellTrash then
                    for Index, Value in LocalPlayer.Backpack:GetChildren() do
                        if Value:IsA("Tool") then
                            ReplicatedStorage:WaitForChild("PawnRemote"):FireServer(Value.Name)
                            task.wait()
                        end
                    end
                    
                    task.wait(1)
                end
            end
        end))

        Config.GetGoodCleaner = LPH_NO_VIRTUALIZE(function()
            local CounterInstance;

            for Index, Value in Workspace["1# Map"]:GetChildren() do
                if Value:FindFirstChild("CounterM") then
                    CounterInstance = Value
                end
            end

            for Index, Value in next, {{}, CounterInstance:GetChildren()} do
                for _Index, _Value in Value do
                    if _Value:FindFirstChild("CashPrompt", true) and _Value:FindFirstChild("CashPrompt", true).Enabled and _Value:FindFirstChild("CashPrompt", true).ObjectText == "Count Bread" and _Value:FindFirstChild("GrabPrompt", true) and not _Value:FindFirstChild("GrabPrompt", true).Enabled then
                        return _Value
                    end
                end
            end
        end)
    --

    -- Connections
        local DeathFrame;

        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character:FindFirstChild("Humanoid").Died:Connect(LPH_NO_VIRTUALIZE(function()
                DeathFrame = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
            end))

            LocalPlayer.Character.DescendantAdded:Connect(function(Descendant)
                if Descendant:IsA("BodyVelocity") or Descendant:IsA("LinearVelocity") or Descendant:IsA("VectorForce") and Config.The_Bronx.PlayerModifications.NoKnockback then
                    task.wait(); Descendant:Destroy()
                end
            end)
        end

        LocalPlayer.CharacterAdded:Connect(LPH_NO_VIRTUALIZE(function(Character)
            Character:WaitForChild("Humanoid"); Character:WaitForChild("HumanoidRootPart");

            Character.DescendantAdded:Connect(function(Descendant)
                if Descendant:IsA("BodyVelocity") or Descendant:IsA("LinearVelocity") or Descendant:IsA("VectorForce") and Config.The_Bronx.PlayerModifications.NoKnockback then
                    task.wait(); Descendant:Destroy()
                end
            end)

            Character:WaitForChild("Humanoid").Died:Connect(function()
                DeathFrame = Character:WaitForChild("HumanoidRootPart").CFrame
            end)

            if Config.The_Bronx.PlayerModifications.RespawnWhereYouDied and typeof(DeathFrame) == "CFrame" then
                Character:WaitForChild("HumanoidRootPart").CFrame = DeathFrame
            end
        end))
        
        task.spawn(LPH_NO_VIRTUALIZE(function()
            while task.wait(0.1) do
                if Config.The_Bronx.PlayerModifications.FasterRespawn then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("Humanoid"):GetState() == Enum.HumanoidStateType.Dead then
                        ReplicatedStorage:WaitForChild("LoadCharacter"):FireServer()
                    end
                end
            end
        end))

        local Set_Speed = false; local Set_Spectate = false; RunService:BindToRenderStep("WalkSpeed", 400, LPH_NO_VIRTUALIZE(function(Delta)
            if Config.MiscSettings.ModifySpeed.Enabled then
                Set_Speed = false
                
                LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = Config.MiscSettings.ModifySpeed.Value
            else
                if not Set_Speed then
                    Set_Speed = true;
                    LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 16 or 7
                end
            end

            if Config.The_Bronx.PlayerUtilities.SpectatePlayer then
                Set_Spectate = false
                local Subject = Players:FindFirstChild(Library.Selected_Player.Name) and Players:FindFirstChild(Library.Selected_Player.Name).Character and Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("Humanoid")

                if not Players:FindFirstChild(Library.Selected_Player.Name) or not Players:FindFirstChild(Library.Selected_Player.Name).Character or not Players:FindFirstChild(Library.Selected_Player.Name).Character:FindFirstChild("Humanoid") then
                    Subject = LocalPlayer.Character.Humanoid
                end

                Camera.CameraSubject = Subject
            else
                if not Set_Spectate then
                    Set_Spectate = true

                    Camera.CameraSubject = LocalPlayer.Character.Humanoid
                end
            end
        end))

        RunService:BindToRenderStep("PlayerFunctions", 400, LPH_NO_VIRTUALIZE(function()
            if LocalPlayer.PlayerGui:FindFirstChild("Run") and LocalPlayer.PlayerGui.Run:FindFirstChild("StaminaBarScript", true) then
                LocalPlayer.PlayerGui.Run:FindFirstChild("StaminaBarScript", true).Disabled = Config.The_Bronx.PlayerModifications.InfiniteStamina
            end

            if LocalPlayer.PlayerGui:FindFirstChild("Hunger") and LocalPlayer.PlayerGui.Hunger:FindFirstChild("HungerBarScript", true) then
                LocalPlayer.PlayerGui.Hunger:FindFirstChild("HungerBarScript", true).Disabled = Config.The_Bronx.PlayerModifications.InfiniteHunger
            end

            if LocalPlayer.PlayerGui:FindFirstChild("SleepGui") and LocalPlayer.PlayerGui.SleepGui:FindFirstChild("sleepScript", true) then
                LocalPlayer.PlayerGui.SleepGui:FindFirstChild("sleepScript", true).Disabled = Config.The_Bronx.PlayerModifications.InfiniteSleep
            end

            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("CameraBobbing") then
                LocalPlayer.Character:FindFirstChild("CameraBobbing").Disabled = Config.The_Bronx.PlayerModifications.DisableCameraBobbing
            end

            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("FallDamageRagdoll") then
                LocalPlayer.Character:FindFirstChild("FallDamageRagdoll").Disabled = Config.The_Bronx.PlayerModifications.NoFallDamage
            end

            if LocalPlayer.PlayerGui:FindFirstChild("BloodGui") then
                LocalPlayer.PlayerGui:FindFirstChild("BloodGui").Enabled = not Config.The_Bronx.PlayerModifications["DisableBloodEffects"]
            end

            if LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce") and LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce"):FindFirstChild("LocalScript") then
                LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce").LocalScript.Disabled = Config.The_Bronx.PlayerModifications.NoJumpCooldown
            end

            if LocalPlayer.PlayerGui:FindFirstChild("CameraTexts") and LocalPlayer.PlayerGui:FindFirstChild("CameraTexts"):FindFirstChild("LocalScript") then
                LocalPlayer.PlayerGui:FindFirstChild("CameraTexts").Enabled = not Config.The_Bronx.PlayerModifications.DisableCameras
                LocalPlayer.PlayerGui:FindFirstChild("CameraTexts").LocalScript.Disabled = Config.The_Bronx.PlayerModifications.DisableCameras
            end

            if LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce") and LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce"):FindFirstChild("LocalScript") then
                LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce").LocalScript.Disabled = Config.The_Bronx.PlayerModifications.NoJumpCooldown
            end

            if LocalPlayer.PlayerGui:FindFirstChild("RentGui") and LocalPlayer.PlayerGui:FindFirstChild("RentGui"):FindFirstChild("LocalScript") then
                LocalPlayer.PlayerGui:FindFirstChild("RentGui").LocalScript.Disabled = Config.The_Bronx.PlayerModifications.NoRentPay
            end

            if Config.The_Bronx.PlayerModifications.AutoPickupBags and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for Index, Value in next, Workspace.Storage:GetChildren() do
                    if not Value:IsA("MeshPart") then continue end
                    if Value:FindFirstChild("PlayerName") and Value:FindFirstChild("PlayerName").Value == LocalPlayer.Name then continue end
        
                    if (Value.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5 then
                        fireproximityprompt(Value.stealprompt)
                    end
                end
            end

            if Config.The_Bronx.PlayerModifications.AutoPickupCash and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for Index, Value in next, Workspace.Dollas:GetChildren() do
                    if not Value:IsA("Part") then continue end
        
                    if (Value.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5 then
                        fireproximityprompt(Value.ProximityPrompt)
                    end
                end
            end
        end))

        RunService.PreRender:Connect(LPH_NO_VIRTUALIZE(function()
            if not Config.The_Bronx.PlayerModifications.InstantRevive then return end
            if not LocalPlayer.Character then return end
            if not LocalPlayer.Character:FindFirstChild("Humanoid") then return end

            if LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Physics then
                FireServer(ReplicatedStorage.FSpamRemote)
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end

            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        end))

        ProximityPromptService.PromptButtonHoldBegan:Connect(LPH_NO_VIRTUALIZE(function(Prompt, Self)
            if Prompt and Self == LocalPlayer and fireproximityprompt then
                if Config.The_Bronx.PlayerModifications.InstantInteract then
                    fireproximityprompt(Prompt, true)
                end

                if Config.The_Bronx.PlayerModifications.BypassLockedCars then
                    if Self == LocalPlayer then
                        while true do
                            if Prompt.Parent:FindFirstChild("DriveSeat") then
                                if Prompt:IsA("VehicleSeat") then
                                    Prompt:Sit(LocalPlayer.Character.Humanoid)
                                else
                                    Prompt = Prompt.Parent
                                end

                                break
                            else
                                Prompt = Prompt.Parent
                            end
                
                            if not Prompt.Parent then
                                break
                            end
                        end
                    end
                end
            end 
        end))

        local Set_JumpPower = false; task.spawn(LPH_NO_VIRTUALIZE(function()
            while task.wait(.1) do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    if Config.MiscSettings.ModifyJump.Enabled then
                        Set_JumpPower = false
                        LocalPlayer.Character:FindFirstChild("Humanoid").JumpHeight = Config.MiscSettings.ModifyJump.Value
                    else
                        if not Set_JumpPower then
                            Set_JumpPower = true;
                            LocalPlayer.Character:FindFirstChild("Humanoid").JumpHeight = 7
                        end
                    end
                end
            end
        end))

        local Teleport_Debounce = false
        Config.Connections["InputBegan_ClickTeleport"] = UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input, Game_Event)
            if Game_Event then return end
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and Config.MiscSettings.ClickTeleport_Enabled and UserInputService:IsKeyDown(Config.MiscSettings.ClickTeleport_Key) then
                local MouseLocation = UserInputService:GetMouseLocation()
                local Ray = Camera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y)
                local RaycastParams = RaycastParams.new()
                RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                RaycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Workspace:FindFirstChild("Cameras"), Workspace:FindFirstChild("CameraLocations")}
                local Cast = Workspace:Raycast(Ray.Origin, Ray.Direction * 1000, RaycastParams)
                
                if Cast and not Teleport_Debounce then
                    Teleport_Debounce = true

                    Config:Teleport(CFrame.new(Cast.Position + Vector3.new(0,3,0)))

                    task.delay(.1, function()
                        Teleport_Debounce = false
                    end)
                end
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do
                task.wait(0)
                if Config.VehicleModifications.SpeedEnabled and UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        if LocalPlayer.Character and typeof(LocalPlayer.Character) == "Instance" then
                            local Humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                            if Humanoid and typeof(Humanoid) == "Instance" then
                                local SeatPart = Humanoid.SeatPart
                                if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                                    SeatPart.AssemblyLinearVelocity *= Vector3.new(1 + Config.VehicleModifications.SpeedValue, 1, 1 + Config.VehicleModifications.SpeedValue)
                                end
                            end
                        end
                    end
                end
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do
                task.wait(0)
                if Config.VehicleModifications.BreakEnabled and UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        if LocalPlayer.Character and typeof(LocalPlayer.Character) == "Instance" then
                            local Humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                            if Humanoid and typeof(Humanoid) == "Instance" then
                                local SeatPart = Humanoid.SeatPart
                                if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                                    SeatPart.AssemblyLinearVelocity *= Vector3.new(1 - Config.VehicleModifications.BreakValue, 1, 1 - Config.VehicleModifications.BreakValue)
                                end
                            end
                        end
                    end
                end
            end
        end))

        task.spawn(LPH_NO_VIRTUALIZE(function()
            while true do
                task.wait(0)
                if Config.VehicleModifications.InstantStop and UserInputService:IsKeyDown(Config.VehicleModifications.InstantStopBind) then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        if LocalPlayer.Character and typeof(LocalPlayer.Character) == "Instance" then
                            local Humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                            if Humanoid and typeof(Humanoid) == "Instance" then
                                local SeatPart = Humanoid.SeatPart
                                if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                                    SeatPart.AssemblyLinearVelocity *= Vector3.new(0, 0, 0)
                                    SeatPart.AssemblyAngularVelocity *= Vector3.new(0, 0, 0)
                                end
                            end
                        end
                    end
                end
            end
        end))
    --

    -- Weapon Modifications
        do
            local OldWeaponValues = {}

            local GetAllTools = LPH_NO_VIRTUALIZE(function(LocalToolsOnly)
                local Result = {}
    
                for _, Value in next, {not LocalToolsOnly and Lighting, LocalPlayer.Backpack, LocalPlayer.Character ~= nil and LocalPlayer.Character} do
                    if type(Value) == "userdata" then
                        for _, _Value in next, Value:GetChildren() do
                            --if _Value.Name == "TP9EliteTan" then continue end
                            Result[#Result + 1] = _Value
                        end
                    end
                end
    
                return Result
            end)

            local GetPercentage = LPH_NO_VIRTUALIZE(function(DefaultValue, NewValue)
                NewValue = math.max(0, math.min(100, NewValue))

                local newRecoil = DefaultValue * (NewValue / 100)
            
                return newRecoil
            end)

            local Ammo_Task = nil
            local Mag_Task = nil

            local ModWeapon = LPH_NO_VIRTUALIZE(function(Weapon)
                local Module = Weapon:FindFirstChildOfClass("ModuleScript")
                local OldConfig = OldWeaponValues[Weapon.Name]

                if not OldConfig then
                    return
                end
    
                if Module and Module.Name == "Setting" then
                    Module = require(Module)
                else
                    return
                end

                if SetInfiniteAmmo == nil then
                    SetInfiniteAmmo = true
                end

                if SetInfiniteClips == nil then
                    SetInfiniteClips = true
                end

                if Config.The_Bronx._Modifications.InfiniteClips then
                    if Mag_Task and coroutine.status(Mag_Task) == "suspended" then
                        task.cancel(Mag_Task)
                        Mag_Task = nil
                    end
                    
                    Mag_Task = task.spawn(function()
                        while true do
                            task.wait(0.01)

                            if Config.The_Bronx._Modifications.InfiniteClips and Weapon ~= nil and Weapon.Parent ~= nil and LocalPlayer.Character ~= nil and Weapon.Parent == LocalPlayer.Character then
                                debug.setupvalue(getsenv(Weapon:FindFirstChild("GunScript_Local")).Reload, 1, OldConfig.AmmoPerMag)
                            else
                                break
                            end
                        end
                    end)

                    SetInfiniteClips = false
                end

                if Config.The_Bronx._Modifications.InfiniteClips == false and SetInfiniteClips == false then
                    debug.setupvalue(getsenv(Weapon:FindFirstChild("GunScript_Local")).Reload, 1, OldConfig.AmmoPerMag)

                    SetInfiniteClips = true
                end

                if Config.The_Bronx._Modifications.InfiniteAmmo then
                    if Ammo_Task and coroutine.status(Ammo_Task) == "suspended" then
                        task.cancel(Ammo_Task)
                        Ammo_Task = nil
                    end
                    
                    Ammo_Task = task.spawn(function()
                        while true do
                            task.wait(0.01)

                            if Config.The_Bronx._Modifications.InfiniteAmmo and Weapon ~= nil and Weapon.Parent ~= nil and LocalPlayer.Character ~= nil and Weapon.Parent == LocalPlayer.Character then
                                debug.setupvalue(getsenv(Weapon:FindFirstChild("GunScript_Local")).Reload, 3, OldConfig.AmmoPerMag)
                            else
                                break
                            end
                        end
                    end)

                    SetInfiniteAmmo = false
                end

                if Config.The_Bronx._Modifications.InfiniteAmmo == false and SetInfiniteAmmo == false then
                    debug.setupvalue(getsenv(Weapon:FindFirstChild("GunScript_Local")).Reload, 3, OldConfig.AmmoPerMag)

                    SetInfiniteAmmo = true
                end

                --Module.LimitedAmmoEnabled = false

                Module.FireRate = Config.The_Bronx._Modifications.ModifyFireRate and GetPercentage(OldConfig.FireRate, Config.The_Bronx._Modifications.FireRateSpeed) or OldConfig.FireRate
                            
                Module.ReloadTime = Config.The_Bronx._Modifications.InstantReload and 0.01 or OldConfig.ReloadTime
                                
                if Module.SpreadXY then
                    Module.SpreadXY = Config.The_Bronx._Modifications.ModifySpreadValue and GetPercentage(OldConfig.SpreadXY, Config.The_Bronx._Modifications.SpreadPercentage) or OldConfig.SpreadXY
                end

                if Module.SpreadYX then
                    Module.SpreadYX = Config.The_Bronx._Modifications.ModifySpreadValue and GetPercentage(OldConfig.SpreadYX, Config.The_Bronx._Modifications.SpreadPercentage) or OldConfig.SpreadYX
                end

                if Module.Spread then
                    Module.Spread = Config.The_Bronx._Modifications.ModifySpreadValue and GetPercentage(OldConfig.Spread, Config.The_Bronx._Modifications.SpreadPercentage) or OldConfig.Spread
                end

                Module.SpreadX = Config.The_Bronx._Modifications.ModifySpreadValue and GetPercentage(OldConfig.SpreadX, Config.The_Bronx._Modifications.SpreadPercentage) or OldConfig.SpreadX
                Module.SpreadY = Config.The_Bronx._Modifications.ModifySpreadValue and GetPercentage(OldConfig.SpreadY, Config.The_Bronx._Modifications.SpreadPercentage) or OldConfig.SpreadY

                Module.Recoil = Config.The_Bronx._Modifications.ModifyRecoilValue and GetPercentage(OldConfig.Recoil, Config.The_Bronx._Modifications.RecoilPercentage) or OldConfig.Recoil

                Module.BaseDamage = Config.The_Bronx._Modifications.InfiniteDamage and math.huge or OldConfig.BaseDamage

                Module.Auto = Config.The_Bronx._Modifications.Automatic or OldConfig.Auto
            
                Module.JamChance = Config.The_Bronx._Modifications.DisableJamming and 0 or OldConfig.JamChance
    
                Module.Auto = Config.The_Bronx._Modifications.Automatic or OldConfig.Auto
        
                Module.EquipTime = Config.The_Bronx._Modifications.InstantEquip and 0.01 or OldConfig.EquipTime

                Module.JamChance = Config.The_Bronx._Modifications.NoJam and 0 or OldConfig.JamChance
            end)

            local ModWeapons = LPH_NO_VIRTUALIZE(function()
                for _, Weapon in next, GetAllTools(true) do
                    if Weapon:IsA("Tool") then
                        ModWeapon(Weapon)
                    end
                end
            end)

            local SetValues = LPH_NO_VIRTUALIZE(function()
                for _, Weapon in next, GetAllTools() do
                    if Weapon:IsA("Tool") then
                        local Module = Weapon:FindFirstChildOfClass("ModuleScript")

                        if Module and Module.Name == "Setting" then
                            Module = require(Module)
                        end

                        if type(Module) == "table" and not OldWeaponValues[Weapon.Name] then
                            OldWeaponValues[Weapon.Name] = {}

                            local OldConfig = OldWeaponValues[Weapon.Name]

                            for Index, Value in next, Module do
                                OldConfig[Index] = Value
                            end
                        end
                    end
                end
            end)

            if not LocalPlayer.Character then LocalPlayer.CharacterAdded:Wait() end

            LocalPlayer.Character.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Value)
                if not Value:IsA("Tool") then return end
                if Value:FindFirstChild("Setting") then
                    Config.Gun_Held = true
                    Config.Gun_Handle = Value:WaitForChild("Handle", 1)

                    if HideGunSoundsConnection then
                        HideGunSoundsConnection:Disconnect()
                        HideGunSoundsConnection = nil
                    end

                    HideGunSoundsConnection = Value:WaitForChild("Handle").ChildAdded:Connect(function(_Child)
                        task.wait();

                        if _Child:IsA("Sound") and Config.Hit_Sounds_Settings.HideNormalSounds then
                            _Child:Destroy()
                        end
                    end)
                end

                SetValues()

                ModWeapon(Value);
            end))

            LocalPlayer.Character.ChildRemoved:Connect(LPH_NO_VIRTUALIZE(function(Value)
                if not Value:IsA("Tool") then return end
                if Value:FindFirstChild("Setting") then
                    Config.Gun_Held = false
                    Config.Gun_Handle = nil
                end
            end))

            LocalPlayer.Backpack.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Value)
                if not Value:IsA("Tool") then return end
                
                SetValues()

                ModWeapon(Value);
            end))

            LocalPlayer.CharacterAdded:Connect(function(Character)
                Config.Gun_Held = false
                Character.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Value)
                    if not Value:IsA("Tool") then return end
                    if Value:FindFirstChild("Setting") then
                        Config.Gun_Held = true
                        Config.Gun_Handle = Value:WaitForChild("Handle", 1)
                    end

                    if HideGunSoundsConnection then
                        HideGunSoundsConnection:Disconnect()
                        HideGunSoundsConnection = nil
                    end

                    HideGunSoundsConnection = Value.Handle.ChildAdded:Connect(function(_Child)
                        task.wait();

                        if _Child:IsA("Sound") and Config.Hit_Sounds_Settings.HideNormalSounds then
                            _Child:Destroy()
                        end
                    end)
    
                    SetValues()

                    ModWeapon(Value);
                end))

                Character.ChildRemoved:Connect(LPH_NO_VIRTUALIZE(function(Value)
                    if not Value:IsA("Tool") then return end
                    if Value:FindFirstChild("Setting") then
                        Config.Gun_Held = false
                        Config.Gun_Handle = nil
                    end
                end))
    
                LocalPlayer.Backpack.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Value)
                    if not Value:IsA("Tool") then return end
                        
                    SetValues()

                    ModWeapon(Value);
                end))
            end)

            local ConfigMetatable = getmetatable(Config.The_Bronx.Modifications)

            ConfigMetatable.__index = LPH_NO_VIRTUALIZE(function(...)
                return Config.The_Bronx._Modifications[select(2, ...)]
            end)
    
            ConfigMetatable.__newindex = LPH_NO_VIRTUALIZE(function(...)
                local Index, Value = select(2, ...)
    
                Config.The_Bronx._Modifications[Index] = Value; ModWeapons()
            end)
        end
    --

    table.sort(Config.The_Bronx.Guns)
end

if getgenv().Library then
    getgenv().Library:Unload()
end

local ESPFonts = { }
local SelectedESPFont

local Options, MiscOptions do
    if getgenv().Esp then 
        getgenv().Esp.Unload()
    end 

    local Workspace = cloneref(game:GetService("Workspace"))
    local RunService = cloneref(game:GetService("RunService"))
    local HttpService = cloneref(game:GetService("HttpService"))
    local Players = cloneref(game:GetService("Players"))
    local TweenService = cloneref(game:GetService("TweenService"))

    local vec2 = Vector2.new
    local vec3 = Vector3.new
    local dim2 = UDim2.new
    local dim = UDim.new 
    local rect = Rect.new
    local cfr = CFrame.new
    local empty_cfr = cfr()
    local angle = CFrame.Angles
    local dim_offset = UDim2.fromOffset

    local rgb = Color3.fromRGB
    local hex = Color3.fromHex
    local hsv = Color3.fromHSV
    local rgbseq = ColorSequence.new
    local rgbkey = ColorSequenceKeypoint.new
    local numseq = NumberSequence.new
    local numkey = NumberSequenceKeypoint.new
    local camera = Workspace.CurrentCamera

    local Bones = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"UpperTorso", "LeftUpperArm"},
        {"UpperTorso", "RightUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"RightUpperArm", "RightLowerArm"},
        {"LowerTorso", "LeftUpperLeg"},
        {"LowerTorso", "RightUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"RightUpperLeg", "RightLowerLeg"},
    }

    -- Esp is mainly hardcoded because having to make a library for everything is very useless considering we're working with not more than 10 elements at once. 
    --[[
        PlayersTab.AddBar({Name = "Healthbar"})
        PlayersTab.AddText({Name = "Name"})
        PlayersTab.AddText({Name = "Distance"})
        PlayersTab.AddText({Name = "Weapon"})
        PlayersTab.AddText({Name = "Flags", Color1 = rgb(225, 255, 0)})
        PlayersTab.AddBox({Name = "Box"})

        Each element will have its own concat for their flag <-- this means that if you make a text called name itll make the flags
        ["Name"] = true; 
        ["Name_Color"] = { Color = rgb(255, 255, 255) };
        ["Name_Position"] = "Left";
        which will be overwritten in the table down below. 

        All elements will be updated with a metatable, look for the new index and there will be a refresh function.

        I labelled the main code with important tags because some people dont know how to find my code...
    ]]

    MiscOptions = {
        ["Enabled"] = false;
        ["Render_Distance"] = 500;

        -- Boxes
        ["Boxes"] = false;
        ["BoxType"] = "Corner";
        ["Box Gradient 1"] = { Color = rgb(236,23,23), Transparency = 0.9 };
        ["Box Gradient 2"] = { Color = rgb(0, 0, 0), Transparency = 0.4 };
        ["Box Gradient Rotation"] = 90;
        ["Box Fill"] = false; 
        ["Box Fill 1"] = { Color = rgb(255, 255, 255), Transparency = 0.9 };
        ["Box Fill 2"] = { Color = rgb(255, 255, 255), Transparency = 0.9 };
        ["Box Fill Rotation"] = 0;

        ["Healthbar"] = false;
        ["Healthbar_Position"] = "Left";
        ["Healthbar_Number"] = false;
        ["Healthbar_Low"] = { Color = rgb(255, 0, 0), Transparency = 1};
        ["Healthbar_Medium"] = { Color = rgb(255, 255, 0), Transparency = 1};
        ["Healthbar_Animations"] = false; 
        ["Healthbar_High"] = { Color = rgb(0, 255, 0), Transparency = 1};
        ["Healthbar_Font"] = "Verdana";
        ["Healthbar_Text_Size"] = 11;
        ["Healthbar_Thickness"] = 1;
        ["Healthbar_Tween"] = false;
        ["Healthbar_EasingStyle"] = "Circular";
        ["Healthbar_EasingDirection"] = "InOut";
        ["Healthbar_Easing_Speed"] = 1;

        -- Text Based Elements
        ["Name_Text"] = false; 
        ["Name_Text_Color"] = { Color = rgb(255, 255, 255) };
        ["Name_Text_Position"] = "Top";
        ["Name_Text_Font"] = "Verdana";
        ["Name_Text_Size"] = 11;
        
        ["Distance_Text"] = false; 
        ["Distance_Text_Color"] = { Color = rgb(255, 255, 255) };
        ["Distance_Text_Position"] = "Bottom";
        ["Distance_Text_Font"] = "Verdana";
        ["Distance_Text_Size"] = 11;

        ["Weapon_Text"] = false; 
        ["Weapon_Text_Color"] = { Color = rgb(255, 255, 255) };
        ["Weapon_Text_Position"] = "Bottom";
        ["Weapon_Text_Font"] = "Verdana";
        ["Weapon_Text_Size"] = 11;
    };  

    Options = setmetatable({}, {__index = MiscOptions, __newindex = function(self, key, value) Esp.RefreshElements(key, value) end});

    local Fonts = {}; do
        local function RegisterFont(Name, Weight, Style, Asset)
            writefile(Asset.Id, Asset.Font)

            local Data = {
                name = Name,
                faces = {
                    {
                        name = "Normal",
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Asset.Id),
                    },
                },
            }

            writefile(Name .. ".font", HttpService:JSONEncode(Data))

            return getcustomasset(Name .. ".font");
        end

        local FontNames = {
            ["ProggyClean"] = "ProggyClean.ttf",
            ["Tahoma"] = "fs-tahoma-8px.ttf",
            ["Verdana"] = "Verdana-Font.ttf",
            ["SmallestPixel"] = "smallest_pixel-7.ttf",
            ["ProggyTiny"] = "ProggyTiny.ttf",
            ["Minecraftia"] = "Minecraftia-Regular.ttf",
            ["Tahoma Bold"] = "tahoma_bold.ttf"
        }

        for name, suffix in FontNames do 
            local RegisteredFont = RegisterFont(name, 400, "Normal", {
                Id = suffix,
                Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/" .. suffix),
            }) 

            Fonts[name] = Font.new(RegisteredFont, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            ESPFonts[name] = Font.new(RegisteredFont, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        end
    end

    getgenv().Esp = { 
        Players = {}, 
        ScreenGui = Instance.new("ScreenGui", gethui()), 
        Cache = Instance.new("ScreenGui", gethui()), 
        Connections = {}, 
    }; do 
        Esp.ScreenGui.IgnoreGuiInset = true
        Esp.ScreenGui.Name = "EspObject"

        Esp.Cache.Enabled = false   

        function Esp:Create(instance, options)
            local Ins = Instance.new(instance) 
            
            for prop, value in options do 
                Ins[prop] = value
            end
            
            return Ins 
        end

        function Esp:Connection(signal, callback)
            local Connection = signal:Connect(callback)
            Esp.Connections[#Esp.Connections + 1] = Connection
            
            return Connection 
        end

        Esp.ConvertScreenPoint = LPH_NO_VIRTUALIZE(function(self, world_position)
            local ViewportSize = camera.ViewportSize
            local LocalPos = camera.CFrame:pointToObjectSpace(world_position) 

            local AspectRatio = ViewportSize.X / ViewportSize.Y
            local HalfY = -LocalPos.Z * math.tan(math.rad(camera.FieldOfView / 2))
            local HalfX = AspectRatio * HalfY
            
            local FarPlaneCorner = Vector3.new(-HalfX, HalfY, LocalPos.Z)
            local RelativePos = LocalPos - FarPlaneCorner
        
            local ScreenX = RelativePos.X / (HalfX * 2)
            local ScreenY = -RelativePos.Y / (HalfY * 2)
            
            local OnScreen = -LocalPos.Z > 0 and ScreenX >= 0 and ScreenX <= 1 and ScreenY >= 0 and ScreenY <= 1
            
            -- returns in pixels as opposed to scale
            return Vector3.new(ScreenX * ViewportSize.X, ScreenY * ViewportSize.Y, -LocalPos.Z), OnScreen
        end)

        Esp.BoxSolve = LPH_NO_VIRTUALIZE(function(self, torso)
            if not torso then
                return nil, nil, nil
            end 

            local ViewportTop = torso.Position + (torso.CFrame.UpVector * 1.8) + camera.CFrame.UpVector
            local ViewportBottom = torso.Position - (torso.CFrame.UpVector * 2.5) - camera.CFrame.UpVector
            local Distance = (torso.Position - camera.CFrame.p).Magnitude

            local Top, TopIsRendered = Esp:ConvertScreenPoint(ViewportTop)
            local Bottom, BottomIsRendered = Esp:ConvertScreenPoint(ViewportBottom)

            local Width = math.max(math.floor(math.abs(Top.X - Bottom.X)), 3)
            local Height = math.max(math.floor(math.max(math.abs(Bottom.Y - Top.Y), Width / 2)), 3)
            local BoxSize = Vector2.new(math.floor(math.max(Height / 1.5, Width)), Height)
            local BoxPosition = Vector2.new(math.floor(Top.X * 0.5 + Bottom.X * 0.5 - BoxSize.X * 0.5), math.floor(math.min(Top.Y, Bottom.Y)))
            
            return BoxSize, BoxPosition, TopIsRendered, Distance 
        end)

        function Esp:Lerp(start, finish, t)
            t = t or 1 / 8

            return start * (1 - t) + finish * t
        end

        function Esp:Tween(Object, Properties, Info)
            local tween = TweenService:Create(Object, Info, Properties)
            tween:Play()
            
            return tween
        end

        function Esp.CreateObject( player, typechar ) -- IMPORTANT!
            local Data = { 
                Items = { }, 
                Info = {Character; Humanoid; Health = 0}; 
                Drawings = { }, 
                Type = typechar or "player";
                Connections = {};
            } 

            function Data:Connection(signal, callback)
                local conn = signal:Connect(callback)
                table.insert(self.Connections, conn)
                return conn
            end

            local Items = Data.Items; do
                -- Holder
                    Items.Holder = Esp:Create( "Frame" , {
                        Parent = Esp.ScreenGui;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0.4332570433616638, 0, 0.3255814015865326, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 211, 0, 240);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.HolderGradient = Esp:Create( "UIGradient" , {
                        Rotation = 0;
                        Name = "\0";
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(255, 255, 255))};
                        Parent = Items.Holder;
                        Enabled = true
                    });

                    -- All directions have a set default parent of Items.Holder 

                    -- Directions 
                        Items.Left = Esp:Create( "Frame" , {
                            Parent = Items.Holder;
                            Size = dim2(0, 0, 1, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, -1, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Items.HealthbarTextsLeft = Esp:Create( "Frame", {
                            Visible = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Esp.Cache;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            LayoutOrder = -100;
                            BorderSizePixel = 0;
                            ZIndex = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            FillDirection = Enum.FillDirection.Horizontal;
                            HorizontalAlignment = Enum.HorizontalAlignment.Right;
                            VerticalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Left;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.LeftTexts = Esp:Create( "Frame" , {
                            LayoutOrder = -100;
                            Parent = Items.Left;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            Parent = Items.LeftTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.Bottom = Esp:Create( "Frame" , {
                            Parent = Items.Holder;
                            Size = dim2(1, 0, 0, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 0, 1, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            SortOrder = Enum.SortOrder.LayoutOrder;
                            HorizontalAlignment = Enum.HorizontalAlignment.Center;
                            HorizontalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Bottom;
                            Padding = dim(0, 1)
                        });

                        Items.BottomTexts = Esp:Create( "Frame", {
                            LayoutOrder = 1;
                            Parent = Items.Bottom;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout", {
                            Parent = Items.BottomTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.Top = Esp:Create( "Frame" , {
                            Parent = Items.Holder;
                            Size = dim2(1, 0, 0, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 0, 0, -1);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            VerticalAlignment = Enum.VerticalAlignment.Bottom;
                            SortOrder = Enum.SortOrder.LayoutOrder;
                            HorizontalAlignment = Enum.HorizontalAlignment.Center;
                            HorizontalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Top;
                            Padding = dim(0, 1)
                        });

                        Items.TopTexts = Esp:Create( "Frame", {
                            LayoutOrder = -100;
                            Parent = Items.Top;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout", {
                            Parent = Items.TopTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.Right = Esp:Create( "Frame" , {
                            Parent = Esp.Cache;
                            Size = dim2(0, 0, 1, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(1, 1, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            FillDirection = Enum.FillDirection.Horizontal;
                            VerticalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Right;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                        
                        Items.RightTexts = Esp:Create( "Frame" , {
                            LayoutOrder = 100;
                            Parent = Items.Right;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        Esp:Create( "UIListLayout" , {
                            Parent = Items.RightTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.HealthbarTextsRight = Esp:Create( "Frame", {
                            Visible = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Esp.Cache;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            LayoutOrder = 99;
                            BorderSizePixel = 0;
                            ZIndex = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                    --
                -- 

                -- Corner Boxes
                    Items.Corners = Esp:Create( "Frame", {
                        Parent = Esp.Cache; -- Items.Holder
                        Name = "\0";
                        BackgroundTransparency = 1;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.BottomLeftX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0.4, 0, 0, 3);
                        AnchorPoint = vec2(0, 1);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 1, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.BottomLeftX
                    });

                    Items.BottomLeftY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        AnchorPoint = vec2(0, 1);
                        Image = "rbxassetid://101715268403902";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 1, -2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 96))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = -90;
                        Parent = Items.BottomLeftY
                    });

                    Items.BottomRighX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0.4, 0, 0, 3);
                        AnchorPoint = vec2(1, 1);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 1, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.BottomRighX
                    });

                    Items.BottomLeftY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        AnchorPoint = vec2(1, 1);
                        Image = "rbxassetid://101715268403902";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 1, -2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 96))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = 90;
                        Parent = Items.BottomLeftY
                    });

                    Items.TopLeftY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Corners;
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        Image = "rbxassetid://102467475629368";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 98))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = 90;
                        Parent = Items.TopLeftY
                    });

                    Items.TopRightY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        AnchorPoint = vec2(1, 0);
                        Image = "rbxassetid://102467475629368";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 0, 2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 98))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = -90;
                        Parent = Items.TopRightY
                    });

                    Items.TopRightX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0.4, 0, 0, 3);
                        AnchorPoint = vec2(1, 0);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.TopRightX
                    });

                    Items.TopLeftX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Corners;
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Size = dim2(0.4, 0, 0, 3);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.TopLeftX
                    });
                -- 

                -- Normal Box 
                    Items.Box = Esp:Create( "Frame" , {
                        Parent = Esp.Cache; -- Items.Holder
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke" , {  
                        Parent = Items.Box;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Inner = Esp:Create( "Frame" , {
                        Parent = Items.Box;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.UIStroke = Esp:Create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.Inner
                    });

                    Items.BoxGradient = Esp:Create( "UIGradient" , {
                        Parent = Items.UIStroke
                    });

                    Items.Inner2 = Esp:Create( "Frame" , {
                        Parent = Items.Inner;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke" , {
                        Parent = Items.Inner2;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 
                
                -- Healthbar
                    Items.Healthbar = Esp:Create( "Frame" , {
                        Name = "Left";
                        Parent = Esp.Cache;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 3, 0, 3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });

                    Items.HealthbarAccent = Esp:Create( "Frame" , {
                        Parent = Items.Healthbar;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.HealthbarFade = Esp:Create( "Frame" , {
                        Parent = Items.Healthbar;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });

                    Items.HealthbarGradient = Esp:Create( "UIGradient" , {
                        Enabled = true;
                        Parent = Items.HealthbarAccent;
                        Rotation = 90;
                        Color = rgbseq{rgbkey(0, rgb(0, 255, 0)), rgbkey(0.5, rgb(255, 125, 0)), rgbkey(1, rgb(255, 0, 0))}
                    });

                    Items.HealthbarText = Esp:Create( "TextLabel", {
                        FontFace = Fonts.Verdana;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Esp.Cache; -- Items.HealthbarTextsLeft
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 11;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke", {
                        Parent = Items.HealthbarText;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 

                -- Texts
                    Items.Text = Esp:Create( "TextLabel", {
                        FontFace = Fonts.Verdana;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Esp.Cache;
                        Name = "Left";
                        Text = player.Name;
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 11;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke", {
                        Parent = Items.Text;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Distance = Esp:Create( "TextLabel", {
                        LayoutOrder = 5,
                        FontFace = Fonts.Verdana;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Esp.Cache;
                        Name = "Left";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 11;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke", {
                        Parent = Items.Distance;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Weapon = Esp:Create( "TextLabel", {
                        LayoutOrder = -5,
                        FontFace = Fonts.Verdana;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Esp.Cache;
                        Name = "Left";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 11;
                        Text = "[" .. tostring(Data.Info.Character and Data.Info.Character:FindFirstChildOfClass("Tool") or "None") .. "]",
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke", {
                        Parent = Items.Weapon;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 
            end
        
            Data.ToolAdded = LPH_NO_VIRTUALIZE(function(item)
                if not item or not item:IsA("Tool") then 
                    return 
                end 

                local exists = Data.Info.Character:FindFirstChild(item.Name) 
                if not exists then
                    exists = "None"
                end
                Items["Weapon"].Text = "[" .. tostring(exists) .. "]"

                --[[pcall(function()
                    Items["Weapon"].Parent = exists and Items["Holder"] or Esp.Cache
                end)]]

                -- Refresh
            end)

            Data.HealthChanged = LPH_NO_VIRTUALIZE(function(Value)
                if not MiscOptions.Healthbar then 
                    return 
                end 

                local Humanoid = Data.Info.Humanoid
                local Multiplier = Value / Data.Info.Humanoid.MaxHealth
                local isHorizontal = MiscOptions.Healthbar_Position == "Top" or MiscOptions.Healthbar_Position == "Bottom"

                local Color = MiscOptions.Healthbar_Low.Color:Lerp(MiscOptions.Healthbar_Medium.Color, Multiplier)
                local Color_2 = Color:Lerp(MiscOptions.Healthbar_High.Color, Multiplier)

                if MiscOptions.Healthbar_Number then 
                    if Items.HealthbarText.Parent == Esp.Cache then 
                        Options.Healthbar = MiscOptions.Healthbar_Position 
                        Options.Healthbar_Number = true
                    end
                end 

                if Multiplier>=1 then
                    Items.HealthbarFade.Visible = false
                else
                    Items.HealthbarFade.Visible = true
                end

                if MiscOptions.Healthbar_Tween then  
                    local Health = Data.Info.Health
                    
                    Esp:Tween(Items.HealthbarFade, {
                        Size = dim2(isHorizontal and 1 - Multiplier or 1, isHorizontal and -2 or -2, isHorizontal and 1 or 1 - Multiplier, -2),
                        Position = dim2(isHorizontal and Multiplier or 0, 1, 0, 1)
                    }, TweenInfo.new(MiscOptions.Healthbar_Easing_Speed, Enum.EasingStyle[MiscOptions.Healthbar_EasingStyle], Enum.EasingDirection[MiscOptions.Healthbar_EasingDirection], 0, false, 0))
                    Esp:Tween(Items.HealthbarText, {
                        Position = dim2(isHorizontal and Multiplier or 0, isHorizontal and -(Items.HealthbarText.TextBounds.X / 2) or 0, isHorizontal and 0 or 1 - Multiplier, 0), 
                        TextColor3 = Color_2
                    }, TweenInfo.new(MiscOptions.Healthbar_Easing_Speed, Enum.EasingStyle[MiscOptions.Healthbar_EasingStyle], Enum.EasingDirection[MiscOptions.Healthbar_EasingDirection], 0, false, 0))

                    task.spawn(function()
                        local Start = tick()
                        
                        while true do
                            if not Esp then 
                                break 
                            end 

                            local Elapsed = tick() - Start
                            local Alpha = math.clamp(Elapsed, 0, 1)

                            local Value = Esp:Lerp(
                                Data.Info.Health, 
                                Value, 
                                TweenService:GetValue(
                                    Alpha, 
                                    Enum.EasingStyle[MiscOptions.Healthbar_EasingStyle], 
                                    Enum.EasingDirection[MiscOptions.Healthbar_EasingDirection]
                                )
                            )   

                            Items.HealthbarText.Text = math.floor(Value)

                            if Elapsed >= MiscOptions.Healthbar_Easing_Speed then 
                                Data.Info.Health = Value 
                                break
                            end

                            task.wait()
                        end                            
                    end)
                else 
                    Items.HealthbarFade.Size = dim2(isHorizontal and 1 - Multiplier or 1, isHorizontal and -2 or -2, isHorizontal and 1 or 1 - Multiplier, -2)
                    Items.HealthbarFade.Position = dim2(isHorizontal and Multiplier or 0, 1, 0, 1)
                    
                    Items.HealthbarText.Text = math.floor(Value)
                    Items.HealthbarText.Position = dim2(isHorizontal and Multiplier or 0, isHorizontal and -(Items.HealthbarText.TextBounds.X / 2) or 0, isHorizontal and 0 or 1 - Multiplier, 0)
                    Items.HealthbarText.TextColor3 = Color_2
                end 
            end)

            Data.RefreshDescendants = LPH_NO_VIRTUALIZE(function() 
                local Character = (typechar and player) or player.Character or player.CharacterAdded:Wait()
                local Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild( "Humanoid" )
                
                Data.Info.Character = typechar and player or Character
                Data.Info.Humanoid = Humanoid
                Data.Info.rootpart = Humanoid.RootPart

                Data:Connection(Humanoid.HealthChanged, Data.HealthChanged)
                Data:Connection(Character.ChildAdded, Data.ToolAdded)
                Data:Connection(Character.ChildRemoved, Data.ToolAdded)

                Data.ToolAdded(Character:FindFirstChildOfClass("Tool"))
                Data.HealthChanged(Data.Info.Humanoid.Health)
            end)

            function Data:Destroy()
                if self.Connections then
                    for _, conn in ipairs(self.Connections) do
                        conn:Disconnect()
                    end
                    self.Connections = nil
                end

                pcall(function()
                    for i,v in self.Items do
                        v:Destroy()
                    end
                end)

                if Esp.Players[player] then 
                    Esp.Players[player] = nil
                end

                self.Info = nil
                self.Items = nil
                self.Drawings = nil
            end

            Data.RefreshDescendants()
            --[[Esp:Connection(Data.Info.Humanoid.HealthChanged, Data.HealthChanged)
            Data.HealthChanged(Data.Info.Humanoid.Health)
            Esp:Connection(Data.Info.Character.ChildAdded, Data.ToolAdded)
            Esp:Connection(Data.Info.Character.ChildRemoved, Data.ToolAdded)]]
            Data.CharacterAdded = Data:Connection(player.CharacterAdded, Data.RefreshDescendants)
            
            -- Recaching element holders that arent neccessary <- roblox calculates math for them even if they have no objects in them or invisible ;(
            for _,ItemParentor in {Items.Left, Items.Right, Items.Top, Items.Bottom} do  
                Data:Connection(ItemParentor.ChildAdded, function(child)
                    task.wait(0.1)

                    if ItemParentor.Parent == nil then 
                        return 
                    end

                    ItemParentor.Parent = Items.Holder
                end)

                Data:Connection(ItemParentor.ChildRemoved, function()
                    task.wait(.1)
                    if #ItemParentor:GetChildren() == 0 then
                        if ItemParentor.Parent == nil then 
                            return 
                        end 

                        ItemParentor.Parent = Esp.Cache
                    end 
                end)
            end     

            for _,HealthHolder in {"Right", "Left"} do
                local Parent = Items["HealthbarTexts" .. HealthHolder]

                Data:Connection(Parent.ChildAdded, function()
                    task.wait(.1)

                    if Parent.Parent == nil then 
                        return 
                    end

                    Parent.Parent = Items[HealthHolder]
                end)    

                Data:Connection(Parent.ChildRemoved, function()
                    task.wait(.1)
                    if #Parent:GetChildren() == 0 then
                        if Parent.Parent == nil then 
                            return 
                        end 

                        Parent.Parent = Esp.Cache
                    end 
                end)
            end 

            Esp.Players[ player.Name ] = Data

            return Data
        end

        Esp.Update = LPH_NO_VIRTUALIZE(function() -- IMPORTANT! 
            if not Esp then 
                return 
            end 

            if Options.Enabled == false then
                return 
            end 

            for _,Data in Esp.Players do
                if not Data.Info then
                    continue 
                end 
            
                local Character = Data.Info.Character

                if not Character then 
                    continue 
                end 

                local Humanoid = Data.Info.Humanoid 

                if not Humanoid then
                    continue 
                end 

                if not (Character or Humanoid) then 
                    continue 
                end 
                
                local Items = Data and Data.Items 

                if not Items then 
                    continue 
                end 

                local BoxSize, BoxPos, OnScreen, Distance = Esp:BoxSolve(Humanoid.RootPart)
                local Holder = Items["Holder"]

                if Holder.Visible ~= OnScreen then 
                    Holder.Visible = OnScreen
                end 

                if not OnScreen then
                    continue
                end 

                if Distance > MiscOptions["Render_Distance"] and Holder.Visible then 
                    Holder.Visible = false 
                    continue 
                end 

                local Pos = dim_offset(BoxPos.X, BoxPos.Y)
                if Pos ~= Holder.Position then 
                    Holder.Position = Pos
                end 
                
                local Size = dim2(0, BoxSize.X, 0, BoxSize.Y)
                if Size ~= Holder.Size then 
                    Holder.Size = Size
                end 

                local DistanceLabel = Items.Distance
                local Text = tostring( math.round(Distance) )  .. "m"
                if DistanceLabel.Text ~= Text then 
                    DistanceLabel.Text = Text
                end 
                
                -- if Options["Box Fill"] and Options["Box Spin"] then 
                --     Items["Holder_gradient"].Rotation += Options["Box Spin Speed"] / 100
                -- end

                -- if Options["Box Gradient"] and Options["Box Gradient Spin"] then 
                --     Items["box_outline_gradient"].Rotation += Options["Box Gradient Spin Speed"] / 100
                -- end
            end
        end)
        
        Esp.RefreshElements = LPH_NO_VIRTUALIZE(function(key, value) -- IMPORTANT!
            for _,Data in Esp.Players do
                local Items = Data and Data.Items 

                -- These checks are so annoying
                if not Items then 
                    continue  
                end 

                if not Items.Holder then 
                    continue 
                end 

                if Items.Holder.Parent == nil then 
                    continue 
                end 

                if key == "Enabled" then
                    Items.Holder.Visible = value
                end 

                -- Boxes
                    if key == "BoxType" then
                        if not (Items.Box.Parent == Items.Holder or Items.Corners.Parent == Items.Holder) then 
                            continue
                        end 

                        local isCorner = value == "Corner"
                        Items.Box.Parent = isCorner and Esp.Cache or Items.Holder
                        Items.Corners.Parent = isCorner and Items.Holder or Esp.Cache
                    end 

                    if key == "Boxes" then 
                        local isCorner = Items.Corners.Parent == Items.Holder and true or false
                        local Enabled = value and Items.Holder or Esp.Cache

                        if isCorner then 
                            Items.Corners.Parent = Enabled
                        else 
                            Items.Box.Parent = Enabled
                        end
                    end 

                    if key == "Box Gradient 1" then 
                        local Color = rgbseq{
                            Items.BoxGradient.Color.Keypoints[1], 
                            rgbkey(1, value.Color)
                        }

                        for _,corner in Items.Corners:GetChildren() do 
                            corner:FindFirstChildOfClass("UIGradient").Color = Color
                        end     

                        Items.BoxGradient.Color = Color
                    end 
                    
                    if key == "Box Gradient 2" then 
                        local Color = rgbseq{
                            rgbkey(0, value.Color), 
                            Items.BoxGradient.Color.Keypoints[2]
                        }
                        
                        for _,corner in Items.Corners:GetChildren() do 
                            corner:FindFirstChildOfClass("UIGradient").Color = Color
                        end

                        Items.BoxGradient.Color = Color
                    end 

                    if key == "Box Gradient Rotation" then 
                        Items.BoxGradient.Rotation = value
                    end 

                    if key == "Box Fill" then 
                        Items.Holder.BackgroundTransparency = value and 0 or 1
                    end

                    if key == "Box Fill 1" then 
                        local Path = Items.HolderGradient
                        Path.Transparency = numseq{
                            numkey(0, 1 - value.Transparency), 
                            Path.Transparency.Keypoints[2]
                        };

                        Path.Color = rgbseq{
                            rgbkey(0, value.Color), 
                            Path.Color.Keypoints[2]
                        }
                    end 

                    if key == "Box Fill 2" then 
                        local Path = Items.HolderGradient
                        Path.Transparency = numseq{
                            Path.Transparency.Keypoints[1],
                            numkey(1, 1 - value.Transparency)
                        };

                        Path.Color = rgbseq{
                            Path.Color.Keypoints[1],
                            rgbkey(1, value.Color)
                        };
                    end 

                    if key == "Box Fill Rotation" then 
                        Items.HolderGradient.Rotation = value
                    end 
                -- 

                -- Bars 
                    if key == "Healthbar" then 
                        if Items.Healthbar.Parent == nil then 
                            continue
                        end 

                        Items.Healthbar.Parent = value and Items[Items.Healthbar.Name] or Esp.Cache  
                        Items.HealthbarText.Parent = (Items.HealthbarText.Parent ~= Esp.Cache and value) and Items["HealthbarTexts" .. Items.Healthbar.Name] or Esp.Cache  
                    end 

                    if key == "Healthbar_Position" then 
                        local isEnabled = not (Items.Healthbar.Parent == Esp.Cache)

                        if Items.Healthbar.Parent == nil then 
                            return 
                        end 

                        Items.Healthbar.Parent = isEnabled and Items[value] or Esp.Cache
                        Items.Healthbar.Name = value -- This is super gay
                        Items.HealthbarText.Parent = isEnabled and value and Items.HealthbarText.Parent ~= Esp.Cache and Items["HealthbarTexts" .. Items.Healthbar.Name] or Esp.Cache

                        if value == "Bottom" or value == "Top" then 
                            Items.HealthbarGradient.Rotation = 0 
                        else 
                            Items.HealthbarGradient.Rotation = 90
                        end 

                        Data.HealthChanged(Data.Info.Humanoid.Health)
                    end 
                    
                    if key == "Healthbar_Number" then  
                        if Items.Healthbar.Parent == Esp.Cache then 
                            continue
                        end 

                        local Parent = Items["HealthbarTexts" .. Items.Healthbar.Name]
                        
                        Items.HealthbarText.Parent = value and Parent or Esp.Cache
                    end

                    if key == "Healthbar_Low" then 
                        local Color = rgbseq{
                            Items.HealthbarGradient.Color.Keypoints[1], 
                            Items.HealthbarGradient.Color.Keypoints[2], 
                            rgbkey(1, value.Color)
                        }

                        Items.HealthbarGradient.Color = Color
                    end 

                    if key == "Healthbar_Medium" then 
                        local Color = rgbseq{
                            Items.HealthbarGradient.Color.Keypoints[1], 
                            rgbkey(0.5, value.Color), 
                            Items.HealthbarGradient.Color.Keypoints[3]
                        }

                        Items.HealthbarGradient.Color = Color
                    end

                    if key == "Healthbar_High" then 
                        local Color = rgbseq{
                            rgbkey(0, value.Color), 
                            Items.HealthbarGradient.Color.Keypoints[2], 
                            Items.HealthbarGradient.Color.Keypoints[3]
                        }

                        Items.HealthbarGradient.Color = Color
                    end

                    if key == "Healthbar_Thickness" then 
                        local Bar = Items.Healthbar
                        local isHorizontal = Bar.Parent == Items.Bottom or Bar.Parent == Items.Top

                        Bar.Size = dim2(0, value + 2, 0, value + 2)
                    end

                    if key == "Healthbar_Text_Size" then 
                        Items.HealthbarText.TextSize = value
                    end

                    if key == "Healthbar_Font" then 
                        Items.HealthbarText.FontFace = ESPFonts[value]
                    end
                -- 
                
                -- Texts
                    local Text;
                    local Match;
                    if string.match(key, "Name") then 
                        Text = Items.Text
                        Match = "Name"
                    elseif string.match(key, "Distance") then 
                        Text = Items.Distance
                        Match = "Distance"
                    elseif string.match(key, "Weapon") then 
                        Text = Items.Weapon
                        Match = "Weapon"
                    end 

                    if Text then 
                        if key == Match .. "_Text" then  
                            if Text.Parent == nil then 
                                continue
                            end

                            Text.Parent = value and Items[Text.Name .. "Texts"] or Esp.Cache
                        end 

                        if key == Match .. "_Text_Position" then 
                            local isEnabled = not (Text.Parent == Esp.Cache)

                            if Text.Parent == nil then 
                                return 
                            end 

                            Text.Parent = isEnabled and Items[value .. "Texts"] or Esp.Cache
                            Text.Name = tostring(value) -- This is super gay

                            if value == "Top" or value == "Bottom" then 
                                Text.AutomaticSize = Enum.AutomaticSize.Y 
                                Text.TextXAlignment = Enum.TextXAlignment.Center
                            else 
                                Text.AutomaticSize = Enum.AutomaticSize.XY 
                                Text.TextXAlignment = Enum.TextXAlignment[value == "Right" and "Left" or "Right"]
                            end     
                        end 

                        if key == Match .. "_Text_Color" then 
                            Text.TextColor3 = value.Color
                        end 

                        if key == Match .. "_Text_Font" then 
                            Text.FontFace = ESPFonts[value]
                        end 

                        if key == Match .. "_Text_Size" then 
                            Text.TextSize = value
                        end
                    end 
                -- 
            end 
        end); 
        
        function Esp.Unload() 
            for _,player in Players:GetPlayers() do 
                Esp.RemovePlayer(player)
            end

            for _,connection in Esp.Connections do 
                connection:Disconnect() 
                connection = nil
            end 
            
            if Esp.Loop then 
                RunService:UnbindFromRenderStep("Run Loop")
                Esp.Loop = nil
            end 

            Esp.Cache:Destroy() 
            Esp.ScreenGui:Destroy()

            getgenv().Esp = nil
        end 

        function Esp.RemovePlayer(player)
            local Path = Esp.Players[player.Name]
            
            if Path then
                Path:Destroy()
            end
        end 
    end

    for _,player in Players:GetPlayers() do 
        if player == Players.LocalPlayer then continue end
        Esp.CreateObject(player)
    end 

    Esp:Connection(Players.PlayerRemoving, Esp.RemovePlayer)
    Esp:Connection(Players.PlayerAdded, function(player)
        Esp.CreateObject(player)
        for index,value in MiscOptions do 
            Options[index] = value -- gotta trigger that new index
        end 
    end)

    Esp.Loop = RunService:BindToRenderStep("Run Loop", 0, Esp.Update)

    for index,value in MiscOptions do 
        Options[index] = value -- gotta trigger that new index
    end
end

do -- Library
    -- Services
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local SoundService = cloneref and cloneref(game:GetService("SoundService")) or game:GetService("SoundService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

    -- Variables
    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()

    -- Globals
    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new

    local NumSequence = NumberSequence.new
    local NumSequenceKeypoint = NumberSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local UDim2FromScale = UDim2.fromScale
    local Vector2New = Vector2.new

    local InstanceNew = Instance.new

    local MathClamp = math.clamp
    local MathFloor = math.floor
    local MathAbs = math.abs
    local MathSin = math.sin
    local MathRad = math.rad
    local MathMax = math.max
    local MathMin = math.min

    local TableInsert = table.insert
    local TableFind = table.find
    local TableUnpack = table.unpack
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLower = string.lower

    local CFrameNew = CFrame.new
    local CFrameAngles = CFrame.Angles
    local Vector3New = Vector3.new

    local RectNew = Rect.new

    local IsMobile = UserInputService.TouchEnabled or false

    gethui = gethui or function()
        return CoreGui
    end

    getgenv().Options = { }

    -- Library
    Library = {
        Theme = nil,

        MenuKeybind = tostring(Enum.KeyCode.Z), 
        Flags = { },

        Tween = {
            Time = 0.3,
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out
        },

        Folders = {
            Directory = "valary",
            Configs = "valary/TheBronx3Configs",
            Assets = "valary/Assets",
            Themes = "valary/Themes"
        },

        Images = { -- you're welcome to reupload the images and replace it with your own links
            ["Saturation"] = {"Saturation.png", "https://github.com/sametexe001/images/blob/main/saturation.png?raw=true" },
            ["Value"] = { "Value.png", "https://github.com/sametexe001/images/blob/main/value.png?raw=true" },
            ["Hue"] = { "Hue.png", "https://github.com/sametexe001/images/blob/main/horizontalhue.png?raw=true" },
            ["Checkers"] = { "Checkers.png", "https://github.com/sametexe001/images/blob/main/checkers.png?raw=true" },
            ["Radar"] = {"Radar.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Radar.png?raw=true"},
            ["DiagonalLine"] = {"DiagonalLine.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/DiagonalLine.png?raw=true"},
            ["AdsClick"] = {"AdsClick.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/AdsClick.png?raw=true"},
            ["Forward"] = {"Forward.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Forward.png?raw=true"},
            ["Skull"] = {"Skull.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Skull.png?raw=true"},
            ["MultipleCogs"] = {"MultipleCogs.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/MultipleCogs.png?raw=true"},
            ["Tune"] = {"Tune.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Tune.png?raw=true"},
            ["Wrench"] = {"Wrench.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Wrench.png?raw=true"},
            ["IdCard"] = {"IdCard.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/IdCard.png?raw=true"},
            ["AccountCircle"] = {"AccountCircle.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/AccountCircle.png?raw=true"},
            ["GroupSearch"] = {"GroupSearch.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/GroupSearch.png?raw=true"},
            ["USDChip"] = {"USDChip.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/USDChip.png?raw=true"},
            ["Wrist"] = {"Wrist.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Wrist.png?raw=true"},
            ["PlayerUtilties"] = {"PlayerUtilties.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/PlayerUtilties.png?raw=true"},
            ["CreditCard"] = {"CreditCard.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/CreditCard.png?raw=true"},
            ["JumpToElement"] = {"JumpToElement.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/JumpToElement.png?raw=true"},
            ["Apartment"] = {"Apartment.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Apartment.png?raw=true"},
            ["MoneySymbol"] = {"MoneySymbol.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/MoneySymbol.png?raw=true"},
            ["TravelExplore"] = {"TravelExplore.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/TravelExplore.png?raw=true"},
            ["Scrambler"] = {"Scrambler.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Scrambler.png?raw=true"},
            ["Info"] = {"Info.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Info.png?raw=true"},
            ["CarInfo"] = {"CarInfo.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/CarInfo.png?raw=true"},
            ["AutoManifacturing"] = {"AutoManifacturing.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/AutoManifacturing.png?raw=true"},
            ["MoneyBag"] = {"MoneyBag.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/MoneyBag.png?raw=true"},
            ["Bolt"] = {"Bolt.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Bolt.png?raw=true"},
            ["RetroController"] = {"RetroController.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/RetroController.png?raw=true"},
            ["NewController30px"] = {"NewController30px.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/NewController30px.png?raw=true"},
            ["Home"] = {"Home.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Home.png?raw=true"},
            ["Lock"] = {"Lock.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Lock.png?raw=true"},
            ["EncryptedOff"] = {"EncryptedOff.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/EncryptedOff.png?raw=true"},
            ["DeployedCodeAccount"] = {"DeployedCodeAccount.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/DeployedCodeAccount.png?raw=true"},
            ["IdentityPlatform"] = {"IdentityPlatform.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/IdentityPlatform.png?raw=true"},
            ["DataLossPrevention"] = {"DataLossPrevention.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/DataLossPrevention.png?raw=true"},
            ["CarGear"] = {"CarGear.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/CarGear.png?raw=true"},
            ["Groups"] = {"Groups.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Groups.png?raw=true"},
            ["GlobePublic"] = {"GlobePublic.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/GlobePublic.png?raw=true"},
            ["LightBulb"] = {"LightBulb.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/LightBulb.png?raw=true"},
            ["Cloud"] = {"Cloud.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Cloud.png?raw=true"},
            ["Contrast"] = {"Contrast.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Contrast.png?raw=true"},
            ["TrailShort"] = {"TrailShort.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/TrailShort.png?raw=true"},
            ["EyeTracking"] = {"EyeTracking.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/EyeTracking.png?raw=true"},
            ["ScreenRotation"] = {"ScreenRotation.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/ScreenRotation.png?raw=true"},
            ["QueryStats"] = {"QueryStats.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/QueryStats.png?raw=true"},
            ["CellTower"] = {"CellTower.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/CellTower.png?raw=true"},
            ["Bomb"] = {"Bomb.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Bomb.png?raw=true"},
            ["Servers"] = {"Servers.png", "https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/Servers.png?raw=true"},
        },

        Friendly_Players = {}, Priority_Players = {}, Selected_Player = nil,

        -- Ignore below
        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        Themes = { },
        ThemeMap = { },
        ThemeItems = { },
        ThemeColorpickers = { },

        OpenFrames = { },

        CurrentPage = nil,

        SearchItems = { },

        SetFlags = { },

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        Holder = nil,
        NotifHolder = nil,
        UnusedHolder = nil,
        MainFrame = nil,
        Font = nil,
        KeyList = nil,
    }

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    Library.__index = Library

    Library.Sections.__index = Library.Sections
    Library.Pages.__index = Library.Pages

    for Index, Value in Library.Folders do 
        if not isfolder(Value) then
            makefolder(Value)
        end
    end

    for Index, Value in Library.Images do 
        local ImageData = Value

        local ImageName = ImageData[1]
        local ImageLink = ImageData[2]
        
        if not isfile(Library.Folders.Assets .. "/" .. ImageName) then
            writefile(Library.Folders.Assets .. "/" .. ImageName, game:HttpGet(ImageLink))
        end
    end

    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = LPH_NO_VIRTUALIZE(function(self, Item, Info, Goal, IsRawItem)
            Item = IsRawItem and Item or Item.Instance
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

            local NewTween = {
                Tween = TweenService:Create(Item, Info, Goal),
                Info = Info,
                Goal = Goal,
                Item = Item
            }

            NewTween.Tween:Play()

            setmetatable(NewTween, Tween)

            return NewTween
        end)

        Tween.GetProperty = LPH_NO_VIRTUALIZE(function(self, Item)
            Item = Item or self.Item 

            if Item:IsA("Frame") then
                return { "BackgroundTransparency" }
            elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
                return { "BackgroundTransparency", "ImageTransparency" }
            elseif Item:IsA("ScrollingFrame") then
                return { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif Item:IsA("TextBox") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("UIStroke") then 
                return { "Transparency" }
            end
        end)

        Tween.FadeItem = LPH_NO_VIRTUALIZE(function(self, Item, Property, Visibility, Speed)
            local Item = Item or self.Item 

            local OldTransparency = Item[Property]
            Item[Property] = Visibility and 1 or OldTransparency

            local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
                [Property] = Visibility and OldTransparency or 1
            }, true)

            Library:Connect(NewTween.Tween.Completed, function()
                if not Visibility then 
                    task.wait()
                    Item[Property] = OldTransparency
                end
            end)

            return NewTween
        end)

        Tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            Tween:Pause()
            self = nil
        end
    end

    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }

            setmetatable(NewItem, Instances)

            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end

            return NewItem
        end

        Instances.Border = function(self)
            if not self.Instance then 
                return
            end

            local Item = self.Instance
            local UIStroke = Instances:Create("UIStroke", {
                Parent = Item,
                Color = Library.Theme.Border,
                Thickness = 1,
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            UIStroke:AddToTheme({Color = "Border"})

            return UIStroke
        end

        Instances.FadeItem = LPH_NO_VIRTUALIZE(function(self, Visibility, Speed)
            local Item = self.Instance

            if Visibility == true then 
                Item.Visible = true
            end

            local Descendants = Item:GetDescendants()
            TableInsert(Descendants, Item)

            local NewTween

            for Index, Value in Descendants do 
                local TransparencyProperty = Tween:GetProperty(Value)

                if not TransparencyProperty then 
                    continue
                end

                if type(TransparencyProperty) == "table" then 
                    for _, Property in TransparencyProperty do 
                        NewTween = Tween:FadeItem(Value, Property, not Visibility, Speed)
                    end
                else
                    NewTween = Tween:FadeItem(Value, TransparencyProperty, not Visibility, Speed)
                end
            end
        end)

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then 
                return
            end

            if not self.Instance[Event] then 
                return
            end

            if Event == "MouseButton1Down" or Event == "MouseButton1Click" then 
                if IsMobile then 
                    Event = "TouchTap"
                end
            elseif Event == "MouseButton2Down" or Event == "MouseButton2Click" then 
                if IsMobile then
                    Event = "TouchLongPress"
                end
            end

            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then 
                return
            end

            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then 
                return
            end

            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            self.Instance:Destroy()
            self = nil
        end

        Instances.Tooltip = function(self, Text)
            if Text == nil or type(Text) ~= "string" then
                return
            end

            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local MouseLocation = UserInputService:GetMouseLocation()
            local RenderStepped

            local Newtooltip = Instances:Create("Frame", {
                Parent = Library.Holder.Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 38),
                BorderSizePixel = 0,
                ZIndex = 2,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = FromRGB(16, 18, 21)
            })  Newtooltip:AddToTheme({BackgroundColor3 = "Background"})

            local UIStroke = Instances:Create("UIStroke", {
                Parent = Newtooltip.Instance,
                Name = "\0",
                Color = FromRGB(32, 36, 42),
                Transparency = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  UIStroke:AddToTheme({Color = "Border"})

            Instances:Create("UIPadding", {
                Parent = Newtooltip.Instance,
                Name = "\0",
                PaddingTop = UDimNew(0, 5),
                PaddingBottom = UDimNew(0, 5),
                PaddingRight = UDimNew(0, 5),
                PaddingLeft = UDimNew(0, 5)
            })

            local TooltipText = Instances:Create("TextLabel", {
                Parent = Newtooltip.Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Text,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                ZIndex = 2,
                TextTransparency = 1,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            Instances:Create("UICorner", {
                Parent = Newtooltip.Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 5)
            })

            Library:Connect(Gui.MouseEnter, function()
                Newtooltip:Tween(nil, {BackgroundTransparency = 0.15})
                TooltipText:Tween(nil, {TextTransparency = 0})
                UIStroke:Tween(nil, {Transparency = 0.4})

                RenderStepped = RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
                    MouseLocation = UserInputService:GetMouseLocation()
                    Newtooltip:Tween(nil, {Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 38)})
                end))
            end)

            Library:Connect(Gui.MouseLeave, LPH_NO_VIRTUALIZE(function()
                Newtooltip:Tween(nil, {BackgroundTransparency = 1})
                TooltipText:Tween(nil, {TextTransparency = 1})
                UIStroke:Tween(nil, {Transparency = 1})

                if RenderStepped then 
                    RenderStepped:Disconnect()
                    RenderStepped = nil
                end
            end))
        end

        Instances.MakeDraggable = function(self)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Dragging = false 
            local DragStart
            local StartPosition 

            local InputChanged

            local Set = function(Input)
                local DragDelta = Input.Position - DragStart
                self:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(StartPosition.X.Scale, StartPosition.X.Offset + DragDelta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + DragDelta.Y)})
            end

            self:Connect("InputBegan", LPH_NO_VIRTUALIZE(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true

                    DragStart = Input.Position
                    StartPosition = Gui.Position

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Dragging = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end))

            Library:Connect(UserInputService.InputChanged, LPH_NO_VIRTUALIZE(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dragging then
                        Set(Input)
                    end
                end
            end))

            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Resizing = false 
            local Start = UDim2New()
            local Delta = UDim2New()
            local ResizeMax = Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

            local ResizeButton = Instances:Create("ImageButton", {
				Parent = Gui,
                Image = "rbxassetid://7368471234",
				AnchorPoint = Vector2New(1, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 9, 0, 9),
				Position = UDim2New(1, -4, 1, -4),
                Name = "\0",
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
                ZIndex = 5,
				AutoButtonColor = false,
                Visible = true,
			})  ResizeButton:AddToTheme({ImageColor3 = "Accent"})

            local InputChanged

            ResizeButton:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then

                    Resizing = true

                    Start = Gui.Size - UDim2New(0, Input.Position.X, 0, Input.Position.Y)

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Resizing = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Resizing then
                        ResizeMax = Maximum or Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

                        Delta = Start + UDim2New(0, Input.Position.X, 0, Input.Position.Y)
                        Delta = UDim2New(0, math.clamp(Delta.X.Offset, Minimum.X, ResizeMax.X), 0, math.clamp(Delta.Y.Offset, Minimum.Y, ResizeMax.Y))

                        Tween:Create(Gui, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Delta}, true)
                    end
                end
            end)

            return Resizing
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseLeave, Function)
        end
    end

    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            --[[if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end]]

            if not isfile(Library.Folders.Assets .. "/" .. Name .. ".ttf") then 
                writefile(Library.Folders.Assets .. "/" .. Name .. ".ttf", game:HttpGet(Data.Url))
            end

            local FontData = {
                name = Name,
                faces = { {
                    name = "Regular",
                    weight = Weight,
                    style = Style,
                    assetId = getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".ttf")
                } }
            }

            writefile(Library.Folders.Assets .. "/" .. Name .. ".json", HttpService:JSONEncode(FontData))
            return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
        end

        function CustomFont:Get(Name)
            if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end
        end

        CustomFont:New("Inter", 200, "Regular", {
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/InterSemibold.ttf"
        })

        Library.Font = CustomFont:Get("Inter")
    end

    local Themes = {
        ["Preset"] = {
            ["Background"] = FromRGB(14, 14, 16),       -- Darker background
            ["Inline"] = FromRGB(22, 22, 24),           -- Slightly lighter inline panels
            ["Shadow"] = FromRGB(0, 0, 0),              -- Keep strong shadow
            ["Text"] = FromRGB(255, 255, 255),          -- Bright white text
            ["Image"] = FromRGB(255, 255, 255),         -- White icons/images
            ["Dark Gradient"] = FromRGB(211, 211, 211),    -- Subtle dark gradient
            ["Inactive Text"] = FromRGB(150, 150, 150), -- Softer gray for inactive text
            ["Element"] = FromRGB(33, 32, 35),          -- Element background matches panel
            ["Accent"] = FromRGB(236,23,23),          -- Blue accent (like "bronx")
            ["Border"] = FromRGB(40, 44, 52)            -- Slightly lighter border for contrast
        },

        ["Bitch Bot"] = {
            ["Background"] = FromRGB(42, 42, 42),      -- from #2a2a2a
            ["Inline"] = FromRGB(30, 30, 30),          -- from #1e1e1e
            ["Shadow"] = FromRGB(20, 20, 20),          -- from #141414
            ["Text"] = FromRGB(255, 255, 255),         -- from #ffffff
            ["Image"] = FromRGB(255,255,255),         -- from #7e48a3
            ["Dark Gradient"] = FromRGB(195, 195, 195),-- from #c3c3c3
            ["Inactive Text"] = FromRGB(180, 180, 180),-- from #b4b4b4
            ["Element"] = FromRGB(52, 52, 52),         -- from #343434
            ["Accent"] = FromRGB(126, 72, 163),        -- from #7e48a3
            ["Border"] = FromRGB(20, 20, 20)           -- from #141414
        },

        ["Roobet"] = {
            ["Background"] = Color3.fromRGB(18, 20, 32),      -- Dark purple base
            ["Inline"] = Color3.fromRGB(32, 34, 54),          -- Slightly lighter panel purple
            ["Shadow"] = Color3.fromRGB(0, 0, 0),             -- Black shadow
            ["Text"] = Color3.fromRGB(255, 255, 255),         -- White text
            ["Image"] = Color3.fromRGB(255, 255, 255),        -- White icons
            ["Dark Gradient"] = Color3.fromRGB(211, 211, 211),   -- Deeper gradient shade
            ["Inactive Text"] = Color3.fromRGB(160, 160, 180),-- Muted gray-purple text
            ["Element"] = Color3.fromRGB(40, 42, 70),         -- Button/element background
            ["Accent"] = Color3.fromRGB(255, 204, 0),         -- Roobet yellow accent (#FFCC00)
            ["Border"] = Color3.fromRGB(50, 52, 80)           -- Subtle purple borders
        };

        ["Twitch"] = {
            ["Background"] = Color3.fromRGB(20, 20, 25),
            ["Inline"] = Color3.fromRGB(30, 30, 40),
            ["Shadow"] = Color3.fromRGB(0, 0, 0),
            ["Text"] = Color3.fromRGB(255, 255, 255),
            ["Image"] = Color3.fromRGB(255, 255, 255),
            ["Dark Gradient"] = Color3.fromRGB(211, 211, 211),
            ["Inactive Text"] = Color3.fromRGB(170, 170, 180),
            ["Element"] = Color3.fromRGB(40, 40, 60),
            ["Accent"] = Color3.fromRGB(142, 91, 218), -- Twitch purple
            ["Border"] = Color3.fromRGB(60, 60, 90)
        },

        ["Halloween"] = {
            ["Background"] = FromRGB(11, 10, 9),
            ["Inline"] = FromRGB(23, 18, 16),
            ["Shadow"] = FromRGB(253, 133, 21),
            ["Text"] = FromRGB(198, 198, 198),
            ["Image"] = FromRGB(201, 201, 201),
            ["Dark Gradient"] = FromRGB(211, 202, 195),
            ["Inactive Text"] = FromRGB(179, 179, 179),
            ["Element"] = FromRGB(42, 32, 26),
            ["Accent"] = FromRGB(253, 133, 21),
            ["Border"] = FromRGB(42, 35, 32)
        },

        ["Aqua"] = {
            ["Background"] = FromRGB(19, 21, 23),
            ["Inline"] = FromRGB(31, 35, 39),
            ["Shadow"] = FromRGB(0, 0, 0),
            ["Text"] = FromRGB(245, 245, 245),
            ["Image"] = FromRGB(255, 255, 255),
            ["Dark Gradient"] = FromRGB(211, 211, 211),
            ["Inactive Text"] = FromRGB(185, 185, 185),
            ["Element"] = FromRGB(58, 66, 77),
            ["Accent"] = FromRGB(31, 106, 181),
            ["Border"] = FromRGB(48, 56, 63)
        },

        ["One Tap"] = {
            ["Background"] = FromRGB(49, 49, 49),      -- from #313131
            ["Inline"] = FromRGB(30, 30, 30),          -- from #1e1e1e
            ["Shadow"] = FromRGB(0, 0, 0),             -- from #000000
            ["Text"] = FromRGB(245, 245, 245),         -- from #f5f5f5
            ["Image"] = FromRGB(255, 255, 255),        -- from #ffffff
            ["Dark Gradient"] = FromRGB(211, 211, 211),-- from #d3d3d3
            ["Inactive Text"] = FromRGB(185, 185, 185),-- from #b9b9b9
            ["Element"] = FromRGB(24, 24, 24),         -- from #181818
            ["Accent"] = FromRGB(237, 170, 0),         -- from #edaa00
            ["Border"] = FromRGB(62, 62, 62)           -- from #3e3e3e
        },
    }

    Library.Theme = TableClone(Themes["Preset"])
    Library.Themes = Themes

    if not isfile(Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json") then
        writefile(Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json", "")
    end

    if not isfile(Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json") then
        writefile(Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json", "")
    end

    Library.Holder = Instances:Create("ScreenGui", {
        Parent = game:GetService("CoreGui"),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        DisplayOrder = 2,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Enabled = false,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Instances:Create("Frame", {
        Parent = Library.Holder.Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2New(1, 0, 0, 0),
        Size = UDim2New(0, 0, 1, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = FromRGB(255, 255, 255)
    })

    Instances:Create("UIPadding", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        PaddingBottom = UDimNew(0, 15),
        PaddingTop = UDimNew(0, 15),
        PaddingRight = UDimNew(0, 15)
    })

    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDimNew(0, 10)
    })

    Library.Unload = function(self)
        for Index, Value in self.Connections do 
            Value.Connection:Disconnect()
        end

        for Index, Value in self.Threads do 
            coroutine.close(Value)
        end

        if self.Holder then 
            self.Holder:Clean()
        end

        Library = nil 
        getgenv().Library = nil
    end

    Library.GetImage = function(self, Image)
        local ImageData = self.Images[Image]

        if not ImageData then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return MathFloor(Number * Multiplier) / Multiplier
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        TableInsert(self.Threads, NewThread)

        return NewThread
    end
    
    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = false, nil

        task.spawn(function()
            Success, Result = pcall(Function, TableUnpack(Arguements))

            if not Success then
                Library:Notification({
                    Name = "Valary.gg | Error",
                    Description = "Error caught, please report it in the discord.\n"..Result,
                    Duration = 10,
                })

                return false
            end
        end)

        return Success
    end

    Library.Connect = function(self, Event, Callback, Name)
        Name = Name or StringFormat("Connection%s%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))

        local NewConnection = {
            Event = Event,
            Callback = Callback,
            Name = Name,
            Connection = nil
        }

        Library:Thread(function()
            NewConnection.Connection = Event:Connect(Callback)
        end)

        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do 
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        local FlagNumber = self.UnnamedFlags + 1
        return StringFormat("Flag Number %s %s", FlagNumber, HttpService:GenerateGUID(false))
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = Item.Instance or Item 

        local ThemeData = {
            Item = Item,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                Item[Property] = self.Theme[Value]
            else
                Item[Property] = Value()
            end
        end

        TableInsert(self.ThemeItems, ThemeData)
        self.ThemeMap[Item] = ThemeData
    end

    Library.GetConfig = function(self)
        local Config = { } 

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.Color, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)

        return Success, Result
    end

    Library.GetDarkerColor = function(self, Color)
        local Hue, Saturation, Value = Color:ToHSV()
        return FromHSV(Hue, Saturation, Value / 1.35)
    end

    Library.DeleteConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config) then 
            delfile(Library.Folders.Configs .. "/" .. Config)
            Library:Notification({
                Name = "Success",
                Description = "Succesfully deleted config: ".. Config .. ".json",
                Duration = 5,
                Icon = "116339777575852",
                IconColor = FromRGB(52, 255, 164)
            })
        end
    end

    Library.SaveConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config .. ".json") then
            writefile(Library.Folders.Configs .. "/" .. Config .. ".json", Library:GetConfig())
            Library:Notification({
                Name = "Success",
                Description = "Succesfully saved config: ".. Config .. ".json",
                Duration = 5,
                Icon = "116339777575852",
                IconColor = FromRGB(52, 255, 164)
            })
        end
    end

    Library.RefreshConfigsList = function(self, Element)
        local CurrentList = { }
        local List = { }

        local ConfigFolderName = StringGSub(Library.Folders.Configs, Library.Folders.Directory .. "/", "")

        for Index, Value in listfiles(Library.Folders.Configs) do
            local FileName = StringGSub(Value, Library.Folders.Directory .. "\\" .. ConfigFolderName .. "\\", "")
            List[Index] = FileName
        end

        local IsNew = #List ~= CurrentList

        if not IsNew then
            for Index = 1, #List do
                if List[Index] ~= CurrentList[Index] then
                    IsNew = true
                    break
                end
            end
        else
            CurrentList = List
            Element:Refresh(CurrentList)
        end
    end

    Library.ChangeItemTheme = LPH_NO_VIRTUALIZE(function(self, Item, Properties)
        Item = Item.Instance or Item

        if not self.ThemeMap[Item] then 
            return
        end

        self.ThemeMap[Item].Properties = Properties
        self.ThemeMap[Item] = self.ThemeMap[Item]
    end)

    Library.ChangeTheme = LPH_NO_VIRTUALIZE(function(self, Theme, Color)
        self.Theme[Theme] = Color

        if Theme == "Accent" and Window then
            Window:SetText(string.format(
                '<font color="rgb(255,255,255)">valary.</font><font color="rgb(%d,%d,%d)">gg</font> | %s',
                Color.R*255,
                Color.G*255,
                Color.B*255,
                Game_Name_MarketPlaceService
            ))

            Watermark:SetText(string.format('<font color="rgb(255,255,255)">valary.</font><font color="rgb(%d,%d,%d)">gg</font> - %s - %s',Color.R*255,Color.G*255,Color.B*255, Game_Name_MarketPlaceService, os.date("%b. %d %Y, %X")))
        end

        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
    end)

    Library.IsMouseOverFrame = LPH_NO_VIRTUALIZE(function(self, Frame, XOffset, YOffset)
        Frame = Frame.Instance
        XOffset = XOffset or 0 
        YOffset = YOffset or 0

        local MousePosition = Vector2New(Mouse.X + XOffset, Mouse.Y + YOffset)

        return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
        and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
    end)

    Library.GetTheme = LPH_NO_VIRTUALIZE(function(self)
        local Config = { } 

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Color and StringFind(Index, "Theme") then
                    Config[Index] = {Color = "#" .. Value.Color, Alpha = Value.Alpha}
                end
            end
        end)

        return HttpService:JSONEncode(Config)
    end)

    Library.LoadTheme = LPH_NO_VIRTUALIZE(function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Color and StringFind(Index, "Theme") then
                    SetFunction(Value.Color, Value.Alpha)
                end
            end
        end)

        return Success, Result
    end)

    Library.DeleteTheme = function(self, Config)
        if isfile(Library.Folders.Themes .. "/" .. Config) then 
            delfile(Library.Folders.Themes .. "/" .. Config)
            Library:Notification({
                Name = "Success",
                Description = "Succesfully deleted config: ".. Config .. ".json",
                Duration = 5,
                Icon = "116339777575852",
                IconColor = FromRGB(52, 255, 164)
            })
        end
    end

    Library.SaveTheme = function(self, Config)
        if isfile(Library.Folders.Themes .. "/" .. Config .. ".json") then
            writefile(Library.Folders.Themes .. "/" .. Config .. ".json", Library:GetTheme())
            Library:Notification({
                Name = "Success",
                Description = "Succesfully saved config: ".. Config .. ".json",
                Duration = 5,
                Icon = "116339777575852",
                IconColor = FromRGB(52, 255, 164)
            })
        end
    end

    Library.RefreshThemesList = function(self, Element)
        local CurrentList = { }
        local List = { }

        local ConfigFolderName = StringGSub(Library.Folders.Themes, Library.Folders.Directory .. "/", "")

        for Index, Value in listfiles(Library.Folders.Themes) do
            local FileName = StringGSub(Value, Library.Folders.Directory .. "\\" .. ConfigFolderName .. "\\", "")
            List[Index] = FileName
        end

        local IsNew = #List ~= CurrentList

        if not IsNew then
            for Index = 1, #List do
                if List[Index] ~= CurrentList[Index] then
                    IsNew = true
                    break
                end
            end
        else
            CurrentList = List
            Element:Refresh(CurrentList)
        end
    end

    Library.GetLighterColor = LPH_NO_VIRTUALIZE(function(self, Color, Increment)
        local Hue, Saturation, Value = Color:ToHSV()
        return FromHSV(Hue, Saturation, Value * Increment)
    end)

    local Components = { } do
        Components.Toggle = function(Data)
            local Toggle = { 
                Value = false,
                Flag = Data.Flag
            }

            local Items = { } do
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2New(1, 0, 0, 20),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                local Color = Data.Color or Color3.new(1,1,1)

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = Color,
                    TextTransparency = 0.5,
                    Text = Data.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  if not Data.Color then Items["Text"]:AddToTheme({TextColor3 = "Text"}) end

                Items["Indicator"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, 0, 0.5, 0),
                    Size = UDim2New(0, 20, 0, 20),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("UICorner", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, -4, 1, -4),
                    Position = UDim2New(0, 2, 0, 2),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["Check"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Visible = true,
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -2, 1, -2),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://116339777575852",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    ImageTransparency = 1,
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    ImageColor3 = FromRGB(0, 0, 0)
                })

                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -24, 0, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function Toggle:Get()
                return Toggle.Value
            end

            function Toggle:Set(Bool)
                Toggle.Value = Bool 
                Library.Flags[Toggle.Flag] = Bool

                if Bool then
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["Inline"]:ChangeItemTheme({BackgroundColor3 = "Accent"})

                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})

                    Items["Check"]:Tween(nil, {ImageTransparency = 0})
                    Items["Text"]:Tween(nil, {TextTransparency = 0})
                else
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                    Items["Inline"]:ChangeItemTheme({BackgroundColor3 = "Element"})

                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})

                    Items["Check"]:Tween(nil, {ImageTransparency = 1})
                    Items["Text"]:Tween(nil, {TextTransparency = 0.5})
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Bool)
                end
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool
            end

            Items["Toggle"]:OnHover(function()
                if not Toggle.Value then
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
                --[[else
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Accent, 1.45)})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Accent, 1.45)})]]
                end
            end)

            Items["Toggle"]:OnHoverLeave(function()
                if not Toggle.Value then
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                else
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                end
            end)

            getgenv().Options[Toggle.Flag] = Toggle

            local SearchData = {
                Name = Data.Name,
                Item = Items["Toggle"]
            }

            local PageSearchData = Library.SearchItems[Data.Page]

            if not PageSearchData then 
                return 
            end

            TableInsert(PageSearchData, SearchData)

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Toggle:Set(not Toggle.Value)
            end)

            if Data.Default then 
                Toggle:Set(Data.Default)
            end

            Library.SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            return Toggle, Items 
        end

        Components.Dropdown = function(Data)
            local Dropdown = {
                Value = { },
                Flag = Data.Flag,
                Type = "Dropdown",
                Name = Data.Name,
                IsOpen = false,
                Options = { }
            }

            local Items = { } do
                Items["Dropdown"] = Instances:Create("Frame", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 47),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Data.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Items["RealDropdown"] = Instances:Create("TextButton", {
                    Parent = Items["Dropdown"].Instance,
                    Text = "", 
                    AutoButtonColor = false,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 25),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("UIGradient", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Instances:Create("UICorner", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "--",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 8, 0.5, 0),
                    BackgroundTransparency = 1,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Value"]:AddToTheme({TextColor3 = "Text"})

                Items["OpenIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 20, 0, 20),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://114252321536924",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -3, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["OpenIcon"]:AddToTheme({ImageColor3 = "Accent"})

                Items["OptionHolder"] = Instances:Create("TextButton", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(1, 0, 0, 125),
                    AutomaticSize = Enum.AutomaticSize.None,
                    Position = UDim2New(0, 0, 0, 0),
                    Visible = false,
                    BorderSizePixel = 0,
                    ZIndex = 5,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UIGradient", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Instances:Create("UIStroke", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Instances:Create("UICorner", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["Holder"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -8, 1, -46),
                    CanvasSize = UDim2New(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 38),
                    BorderSizePixel = 0,
                    ScrollBarImageColor3 = Library.Theme.Border,
                    BottomImage = "rbxassetid://123813291349824",
                    TopImage = "rbxassetid://123813291349824",
                    MidImage = "rbxassetid://123813291349824",
                    ZIndex = 5,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Border"})

                Instances:Create("UIListLayout", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })

                Items["Search"] = Instances:Create("Frame", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, -16, 0, 25),
                    Position = UDim2New(0, 8, 0, 8),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Search"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UIGradient", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Instances:Create("UICorner", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIStroke", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Items["SearchIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    ScaleType = Enum.ScaleType.Fit,
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 20, 0, 20),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://71924825350727",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0.5, 0),
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SearchIcon"]:AddToTheme({ImageColor3 = "Image"})

                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    AnchorPoint = Vector2New(0, 0.5),
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    PlaceholderText = "search",
                    TextSize = 14,
                    Size = UDim2New(1, -45, 0, 15),
                    ClipsDescendants = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    ZIndex = 5,
                    Position = UDim2New(0, 35, 0.5, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextColor3 = FromRGB(255, 255, 255),
                    ClearTextOnFocus = false,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
            end

            Items["RealDropdown"]:OnHover(function()
                Items["RealDropdown"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
            end)

            Items["RealDropdown"]:OnHoverLeave(function()
                Items["RealDropdown"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            end)

            function Dropdown:Get()
                return Dropdown.Value
            end

            function Dropdown:Set(Option)
                if Data.Multi then
                    if type(Option) ~= "table" then
                        return
                    end

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Option do 
                        local OptionData = Dropdown.Options[Value]
                        
                        if not OptionData then 
                            return
                        end

                        OptionData.Selected = true
                        OptionData:Toggle("Active")
                    end

                    Items["Value"].Instance.Text = TableConcat(Option, ", ")
                else
                    if not Dropdown.Options[Option] then 
                        return
                    end

                    local OptionData = Dropdown.Options[Option]

                    Dropdown.Value = OptionData.Name
                    Library.Flags[Dropdown.Flag] = OptionData.Name

                    for Index, Value in Dropdown.Options do 
                        if Value ~= OptionData then
                            Value.Selected = false 
                            Value:Toggle("Inactive")
                        else
                            Value.Selected = true 
                            Value:Toggle("Active")
                        end
                    end

                    Items["Value"].Instance.Text = OptionData.Name
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Dropdown.Value)
                end
            end

            function Dropdown:AddOption(Option)
                local OptionButton = Instances:Create("TextButton", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2New(1, -5, 0, 25),
                    ZIndex = 5,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  OptionButton:AddToTheme({BackgroundColor3 = "Background"})

                local CheckImage = Instances:Create("ImageLabel", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 18, 0, 18),
                    Visible = true,
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://116339777575852",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 3, 0.5, 0),
                    ImageTransparency = 1,
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  CheckImage:AddToTheme({ImageColor3 = "Accent"})

                Instances:Create("UICorner", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                local OptionText = Instances:Create("TextLabel", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextTransparency = 0.5,
                    AnchorPoint = Vector2New(0, 0.5),
                    ZIndex = 5,
                    TextSize = 14,
                    Size = UDim2New(0, 0, 0, 15),
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Option,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Position = UDim2New(0, 7, 0.5, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  OptionText:AddToTheme({TextColor3 = "Text"})

                local OptionData = {
                    Selected = false,
                    Name = Option,
                    Text = OptionText,
                    RealName = Option,
                    Button = OptionButton,
                    Check = CheckImage
                }

                local DoesItAlreadyExists

                local ChildrenCount = 0
                
                for Index, Value in Items["Holder"].Instance:GetChildren() do
                    if Value:IsA("TextButton") then
                        ChildrenCount = ChildrenCount + 1
                    end
                end

                if Dropdown.Options[Option] then 
                    DoesItAlreadyExists = true
                    local NewName = Option .. " " .. ChildrenCount
                    OptionData.Name = NewName
                    --OptionText.Instance.Text = NewName
                end

                function OptionData:Toggle(Status)
                    if Status == "Active" then 
                        OptionData.Button:Tween(nil, {BackgroundTransparency = 0})
                        OptionData.Text:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 27, 0.5, 0)})
                        OptionData.Check:Tween(nil, {ImageTransparency = 0})
                    elseif Status == "Inactive" then
                        OptionData.Button:Tween(nil, {BackgroundTransparency = 1})
                        OptionData.Text:Tween(nil, {TextTransparency = 0.5, Position = UDim2New(0, 7, 0.5, 0)})
                        OptionData.Check:Tween(nil, {ImageTransparency = 1})
                    end
                end

                function OptionData:Set()
                    OptionData.Selected = not OptionData.Selected

                    if Data.Multi then 
                        local Index = TableFind(Dropdown.Value, OptionData.RealName)

                        if Index then 
                            TableRemove(Dropdown.Value, Index)
                        else
                            TableInsert(Dropdown.Value, OptionData.RealName)
                        end

                        Library.Flags[Dropdown.Flag] = Dropdown.Value

                        OptionData:Toggle(Index and "Inactive" or "Active")

                        local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "--"

                        Items["Value"].Instance.Text = TextFormat
                    else
                        if OptionData.Selected then 
                            Dropdown.Value = OptionData.RealName
                            Library.Flags[Dropdown.Flag] = OptionData.RealName

                            OptionData:Toggle("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData then
                                    Value.Selected = false 
                                    Value:Toggle("Inactive")
                                end
                            end

                            Items["Value"].Instance.Text = OptionData.RealName 
                        else
                            Dropdown.Value = nil
                            Library.Flags[Dropdown.Flag] = nil

                            OptionData:Toggle("Inactive")
                            Items["Value"].Instance.Text = "--"
                        end
                    end

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Dropdown.Value)
                    end
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData
                return OptionData
            end

            function Dropdown:RemoveOption(Name)
                if Dropdown.Options[Name] then
                    Dropdown.Options[Name].Button:Clean()
                    Dropdown.Options[Name] = nil
                end
            end

            function Dropdown:Refresh(List)
                for Index, Value in Dropdown.Options do 
                    Dropdown:RemoveOption(Value.Name)
                end

                for Index, Value in List do 
                    Dropdown:AddOption(Value)
                end
            end

            local Debounce = false 
            local RenderStepped 

            function Dropdown:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Dropdown.IsOpen = Bool
                Items["OptionHolder"].Instance.Parent = Bool and Library.Holder.Instance or Library.UnusedHolder.Instance

                Debounce = true

                if Bool then 
                    Items["OptionHolder"].Instance.Visible = true
                    Items["Holder"].Instance.ZIndex = 11

                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y + 30)
                        Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, Data.MaxSize or 165)
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value.Name ~= Data.Name then 
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Data.Name] = Dropdown
                else
                    if Library.OpenFrames[Data.Name] then 
                        Library.OpenFrames[Data.Name] = nil
                    end

                    if RenderStepped then
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                local Descendants = Items["OptionHolder"].Instance:GetDescendants()
                TableInsert(Descendants, Items["OptionHolder"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then 
                        continue
                    end

                    if StringFind(Value.ClassName, "UI") then
                        continue
                    end

                    Value.ZIndex = Bool and 10 or 0

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Data.Window.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Data.Window.FadeSpeed)
                    end
                end

                Library:Connect(NewTween.Tween.Completed, function()
                    Debounce = false
                    Items["OptionHolder"].Instance.Visible = Bool
                end)
            end

            function Dropdown:SetVisibility(Bool)
                Items["Dropdown"].Instance.Visible = Bool
            end

            getgenv().Options[Dropdown.Flag] = Dropdown

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Library:IsMouseOverFrame(Items["OptionHolder"]) then
                        return
                    end

                    if Debounce then 
                        return 
                    end

                    if not Dropdown.IsOpen then
                        return
                    end

                    Dropdown:SetOpen(false)
                end
            end)

            local SearchStepped

            Items["Input"]:Connect("Focused", function()
                if SearchStepped then
                    return
                end

                SearchStepped = RunService.RenderStepped:Connect(function()
                    for Index, Value in Dropdown.Options do 
                        if StringFind(Value.Name:lower(), Items["Input"].Instance.Text:lower()) then 
                            Value.Button.Instance.Visible = true
                        else
                            Value.Button.Instance.Visible = false
                        end
                    end
                end)
            end)

            Items["Input"]:Connect("FocusLost", function()
                if SearchStepped then
                    SearchStepped:Disconnect()
                    SearchStepped = nil
                end
            end)

            local SearchData = {
                Name = Data.Name,
                Item = Items["Dropdown"]
            }

            local PageSearchData = Library.SearchItems[Data.Page]

            if not PageSearchData then 
                return 
            end

            TableInsert(PageSearchData, SearchData)

            Items["RealDropdown"]:Connect("MouseButton1Down", function()
                Dropdown:SetOpen(not Dropdown.IsOpen)
            end)

            for Index, Value in Data.Items do 
                Dropdown:AddOption(Value)
            end

            if Data.Default then 
                Dropdown:Set(Data.Default)
            end

            Library.SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            return Dropdown, Items
        end

        Components.Colorpicker = function(Data)
            local Colorpicker = {
                IsOpen = false,
                
                Color = FromRGB(0, 0, 0),
                HexValue = "000000",
                Alpha = 0,

                Name = Data.Name,
                Type = "Colorpicker",

                Hue = 0,
                Saturation = 0,
                Value = 0,
            }

            local AnimationsDropdown 
            local AnimationsDropdownItems

            Library.Flags[Data.Flag] = { }

            local Items = { } do
                Items["ColorpickerButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    BorderSizePixel = 0,
                    Position = UDim2New(1, -25, 0, 0),
                    Size = UDim2New(0, 20, 0, 20),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 125, 32)
                })

                local CalculateCount = function(Index)
                    local MaxButtonsAdded = 5

                    local Column = Index % MaxButtonsAdded
                
                    local ButtonSize = Items["ColorpickerButton"].Instance.AbsoluteSize
                    local Spacing = 4
                
                    local XPosition = (ButtonSize.X + Spacing) * Column - Spacing - ButtonSize.X
                
                    Items["ColorpickerButton"].Instance.Position = UDim2New(1, Data.IsToggle and XPosition - 24 or -XPosition, 0.5, 0)
                end

                CalculateCount(Data.Count)

                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, -4, 1, -4),
                    Position = UDim2New(0, 2, 0, 2),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 125, 32)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["ColorpickerWindow"] = Instances:Create("TextButton", {
                    Parent = Library.UnusedHolder.Instance,
                    Text = "",
                    AutoButtonColor = false,
                    Name = "\0",
                    Active = false,
                    Selectable = false,
                    Size = UDim2New(0, 219, 0, 282),
                    Position = UDim2New(0, Items["ColorpickerButton"].Instance.AbsolutePosition.X, 0, Items["ColorpickerButton"].Instance.AbsolutePosition.Y + 25),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    Visible = false,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["ColorpickerWindow"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["ColorpickerWindow"]:MakeDraggable()
                Items["ColorpickerWindow"]:MakeResizeable(Vector2New(219, 282), Vector2New(9999, 9999))

                Instances:Create("UIStroke", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["Shadow"] = Instances:Create("ImageLabel", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(0, 0, 0),
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 25, 1, 25),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    SliceCenter = RectNew(Vector2New(21, 21), Vector2New(79, 79))
                })  Items["Shadow"]:AddToTheme({ImageColor3 = "Shadow"})

                Items["Palette"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    Position = UDim2New(0, 8, 0, 8),
                    Size = UDim2New(1, -16, 1, -125),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 125, 32)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["Saturation"] = Instances:Create("ImageLabel", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Image = Library:GetImage("Saturation"),
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Saturation"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["Value"] = Instances:Create("ImageLabel", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 2, 1, 0),
                    Image = Library:GetImage("Value"),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, -1, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Value"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["PaletteDragger"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 4, 0, 4),
                    Position = UDim2New(0, 5, 0, 5),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })

                Instances:Create("UIStroke", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    Thickness = 1.2000000476837158,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })

                Items["Hue"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -16, 0, 18),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 8, 1, -90),
                    Text = "",
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Hue"].Instance,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 0, 0)), RGBSequenceKeypoint(0.17, FromRGB(255, 255, 0)), RGBSequenceKeypoint(0.33, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(0, 255, 255)), RGBSequenceKeypoint(0.67, FromRGB(0, 0, 255)), RGBSequenceKeypoint(0.83, FromRGB(255, 0, 255)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
                }) 

                Items["HueDragger"] = Instances:Create("Frame", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 12, 0.5, 0),
                    Size = UDim2New(0, 3, 1, -8),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIStroke", {
                    Parent = Items["HueDragger"].Instance,
                    Name = "\0",
                    Thickness = 1.2000000476837158,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })

                Instances:Create("UICorner", {
                    Parent = Items["HueDragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })

                Items["Alpha"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    AutoButtonColor = false,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AnchorPoint = Vector2New(0, 1),
                    BorderSizePixel = 0,
                    Position = UDim2New(0, 8, 1, -63),
                    Size = UDim2New(1, -16, 0, 18),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 125, 32)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Alpha"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["AlphaDragger"] = Instances:Create("Frame", {
                    Parent = Items["Alpha"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 3, 0.5, 0),
                    Size = UDim2New(0, 3, 1, -8),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIStroke", {
                    Parent = Items["AlphaDragger"].Instance,
                    Name = "\0",
                    Thickness = 1.2000000476837158,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })

                Instances:Create("UICorner", {
                    Parent = Items["AlphaDragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })

                Items["Checkers"] = Instances:Create("ImageLabel", {
                    Parent = Items["Alpha"].Instance,
                    Name = "\0",
                    ScaleType = Enum.ScaleType.Tile,
                    BorderColor3 = FromRGB(0, 0, 0),
                    TileSize = UDim2New(0, 6, 0, 6),
                    Image = Library:GetImage("Checkers"),
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Checkers"].Instance,
                    Name = "\0",
                    Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(0.37, 0.5), NumSequenceKeypoint(1, 0)}
                })

                Instances:Create("UICorner", {
                    Parent = Items["Checkers"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                local DropdownItems = { } do
                    DropdownItems["Dropdown"] = Instances:Create("Frame", {
                        Parent = Items["ColorpickerWindow"].Instance,
                        Name = "\0",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0, 1),
                        Size = UDim2New(1, -16, 0, 47),
                        Position = UDim2New(0, 8, 1, -8),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })

                    DropdownItems["Text"] = Instances:Create("TextLabel", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "animations",
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 0, 0, 15),
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["Text"]:AddToTheme({TextColor3 = "Text"})

                    DropdownItems["RealDropdown"] = Instances:Create("TextButton", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Text = "", 
                        AutoButtonColor = false,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        Position = UDim2New(0, 0, 1, 0),
                        Size = UDim2New(1, 0, 0, 25),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(34, 39, 45)
                    })  DropdownItems["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})

                    Instances:Create("UIGradient", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        Rotation = 84,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                    end})

                    Instances:Create("UICorner", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })

                    DropdownItems["Value"] = Instances:Create("TextLabel", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "--",
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2New(0, 0, 0, 15),
                        AnchorPoint = Vector2New(0, 0.5),
                        Position = UDim2New(0, 8, 0.5, 0),
                        BackgroundTransparency = 1,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["Value"]:AddToTheme({TextColor3 = "Text"})

                    DropdownItems["OpenIcon"] = Instances:Create("ImageLabel", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(196, 231, 255),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 20, 0, 20),
                        AnchorPoint = Vector2New(1, 0.5),
                        Image = "rbxassetid://114252321536924",
                        BackgroundTransparency = 1,
                        Position = UDim2New(1, -3, 0.5, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["OpenIcon"]:AddToTheme({ImageColor3 = "Accent"})

                    DropdownItems["OptionHolder"] = Instances:Create("TextButton", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        Visible = false,
                        AutoButtonColor = false,
                        Size = UDim2New(1, 0, 0, 50),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Position = UDim2New(0, 0, 1, 5),
                        BorderSizePixel = 0,
                        ZIndex = 5,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(22, 25, 29)
                    })  DropdownItems["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})

                    Instances:Create("UIGradient", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Rotation = 84,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                    end})

                    Instances:Create("UIStroke", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Color = FromRGB(32, 36, 42),
                        Transparency = 0.4000000059604645,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):AddToTheme({Color = "Border"})

                    Instances:Create("UICorner", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 5)
                    })

                    Instances:Create("UIListLayout", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 2),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Instances:Create("UIPadding", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        PaddingTop = UDimNew(0, 8),
                        PaddingBottom = UDimNew(0, 8),
                        PaddingRight = UDimNew(0, 8),
                        PaddingLeft = UDimNew(0, 8)
                    })
                end

                local Dropdown = { 
                    IsOpen = false,
                    Value = { },
                    Options = { },
                    Flag = Data.Flag .. "AnimationDropdown",
                    Multi = true
                }

                function Dropdown:AddOption(Option)
                    local OptionButton = Instances:Create("TextButton", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2New(1, 0, 0, 25),
                        ZIndex = 5,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(16, 18, 21)
                    })  OptionButton:AddToTheme({BackgroundColor3 = "Background"})

                    local CheckImage = Instances:Create("ImageLabel", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(196, 231, 255),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 18, 0, 18),
                        Visible = true,
                        AnchorPoint = Vector2New(0, 0.5),
                        Image = "rbxassetid://116339777575852",
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 3, 0.5, 0),
                        ImageTransparency = 1,
                        ZIndex = 5,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  CheckImage:AddToTheme({ImageColor3 = "Accent"})

                    Instances:Create("UICorner", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 5)
                    })

                    local OptionText = Instances:Create("TextLabel", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextTransparency = 0.5,
                        AnchorPoint = Vector2New(0, 0.5),
                        ZIndex = 5,
                        TextSize = 14,
                        Size = UDim2New(0, 0, 0, 15),
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = Option,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Position = UDim2New(0, 7, 0.5, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  OptionText:AddToTheme({TextColor3 = "Text"})

                    local OptionData = {
                        Selected = false,
                        Name = Option,
                        Text = OptionText,
                        Button = OptionButton,
                        Check = CheckImage
                    }

                    function OptionData:Toggle(Status)
                        if Status == "Active" then 
                            OptionData.Button:Tween(nil, {BackgroundTransparency = 0})
                            OptionData.Text:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 27, 0.5, 0)})
                            OptionData.Check:Tween(nil, {ImageTransparency = 0})
                        elseif Status == "Inactive" then
                            OptionData.Button:Tween(nil, {BackgroundTransparency = 1})
                            OptionData.Text:Tween(nil, {TextTransparency = 0.5, Position = UDim2New(0, 7, 0.5, 0)})
                            OptionData.Check:Tween(nil, {ImageTransparency = 1})
                        end
                    end

                    function OptionData:Set()
                        OptionData.Selected = not OptionData.Selected

                        if Dropdown.Multi then 
                            local Index = TableFind(Dropdown.Value, OptionData.Name)

                            if Index then 
                                TableRemove(Dropdown.Value, Index)
                            else
                                TableInsert(Dropdown.Value, OptionData.Name)
                            end

                            Library.Flags[Dropdown.Flag] = Dropdown.Value

                            OptionData:Toggle(Index and "Inactive" or "Active")

                            local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "--"

                            DropdownItems["Value"].Instance.Text = TextFormat
                        else
                            if OptionData.Selected then 
                                Dropdown.Value = OptionData.Name
                                Library.Flags[Dropdown.Flag] = OptionData.Name

                                OptionData:Toggle("Active")

                                for Index, Value in Dropdown.Options do 
                                    if Value ~= OptionData then
                                        Value.Selected = false 
                                        Value:Toggle("Inactive")
                                    end
                                end

                                DropdownItems["Value"].Instance.Text = OptionData.Name 
                            else
                                Dropdown.Value = nil
                                Library.Flags[Dropdown.Flag] = nil

                                OptionData:Toggle("Inactive")
                                DropdownItems["Value"].Instance.Text = "--"
                            end
                        end

                        if Dropdown.Callback then 
                            Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                        end
                    end

                    OptionData.Button:Connect("MouseButton1Down", function()
                        OptionData:Set()
                    end)

                    Dropdown.Options[Option] = OptionData
                    return OptionData
                end

                local Debounce = false 

                function Dropdown:SetOpen(Bool)
                    if Debounce then 
                        return 
                    end

                    Dropdown.IsOpen = Bool
                    DropdownItems["OptionHolder"].Instance.Parent = Bool and Library.Holder.Instance or Library.UnusedHolder.Instance

                    Debounce = true

                    if Bool then 
                        DropdownItems["OptionHolder"].Instance.Visible = true

                        RenderStepped = RunService.RenderStepped:Connect(function()
                            DropdownItems["OptionHolder"].Instance.Position = UDim2New(0, DropdownItems["RealDropdown"].Instance.AbsolutePosition.X, 0,  DropdownItems["RealDropdown"].Instance.AbsolutePosition.Y + DropdownItems["RealDropdown"].Instance.AbsoluteSize.Y + 5)
                            DropdownItems["OptionHolder"].Instance.Size = UDim2New(0, DropdownItems["RealDropdown"].Instance.AbsoluteSize.X, 0, 85)
                        end)
                    else
                        if RenderStepped then
                            RenderStepped:Disconnect()
                            RenderStepped = nil
                        end
                    end

                    local Descendants = DropdownItems["OptionHolder"].Instance:GetDescendants()
                    TableInsert(Descendants, DropdownItems["OptionHolder"].Instance)

                    local NewTween

                    for Index, Value in Descendants do 
                        local TransparencyProperty = Tween:GetProperty(Value)

                        if not TransparencyProperty then 
                            continue
                        end

                        if StringFind(Value.ClassName, "UI") then
                            continue
                        end

                        Value.ZIndex = Bool and 10 or 0

                        if type(TransparencyProperty) == "table" then 
                            for _, Property in TransparencyProperty do 
                                NewTween = Tween:FadeItem(Value, Property, Bool, Data.Window.FadeSpeed)
                            end
                        else
                            NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Data.Window.FadeSpeed)
                        end
                    end

                    Library:Connect(NewTween.Tween.Completed, function()
                        Debounce = false
                        DropdownItems["OptionHolder"].Instance.Visible = Bool
                    end)
                end

                function Dropdown:Set(Option)
                    if Dropdown.Multi then
                        if type(Option) ~= "table" then
                            return
                        end

                        Dropdown.Value = Option
                        Library.Flags[Dropdown.Flag] = Option

                        for Index, Value in Option do 
                            local OptionData = Dropdown.Options[Value]
                                
                            if not OptionData then 
                                return
                            end

                            OptionData.Selected = true
                            OptionData:Toggle("Active")
                        end

                        DropdownItems["Value"].Instance.Text = TableConcat(Option, ", ")
                    else
                        if not Dropdown.Options[Option] then 
                            return
                        end

                        local OptionData = Dropdown.Options[Option]

                        Dropdown.Value = OptionData.Name
                        Library.Flags[Dropdown.Flag] = OptionData.Name

                        for Index, Value in Dropdown.Options do 
                            if Value ~= OptionData then
                                Value.Selected = false 
                                Value:Toggle("Inactive")
                            else
                                Value.Selected = true 
                                Value:Toggle("Active")
                            end
                        end

                        DropdownItems["Value"].Instance.Text = OptionData.Name
                    end

                    if Dropdown.Callback then 
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end
                end

                Library.SetFlags[Dropdown.Flag] = function(Value)
                    Dropdown:Set(Value)
                end

                DropdownItems["RealDropdown"]:Connect("MouseButton1Down", function()
                    Dropdown:SetOpen(not Dropdown.IsOpen)
                end)

                Dropdown:AddOption("rainbow")
                Dropdown:AddOption("breathing")

                local OldColor = Colorpicker.Color
                local OldAlpha = Colorpicker.Alpha
                
                Dropdown.Callback = function(Value)
                    if TableFind(Value, "rainbow") then 
                        OldColor = Colorpicker.Color

                        Library:Thread(function()
                            while task.wait() do 
                                local RainbowHue = MathAbs(MathSin(tick() * 0.32))
                                local Color = FromHSV(RainbowHue, 1, 1)

                                Colorpicker:Set(Color, Colorpicker.Alpha)

                                if not TableFind(Value, "rainbow") then
                                    Colorpicker:Set(OldColor, Colorpicker.Alpha)
                                    break
                                end
                            end
                        end)
                    end

                    if TableFind(Value, "breathing") then 
                        Library:Thread(function()
                            OldAlpha = Colorpicker.Alpha
                            while task.wait() do 
                                local AlphaValue = MathAbs(MathSin(tick() * 0.8))

                                Colorpicker:Set(Colorpicker.Color, AlphaValue)

                                if not TableFind(Value, "breathing") then
                                    Colorpicker:Set(Colorpicker.Color, OldAlpha)
                                    break
                                end
                            end
                        end)
                    end
                end

                getgenv().Options[Dropdown.Flag] = Dropdown

                AnimationsDropdown = Dropdown 
                AnimationsDropdownItems = DropdownItems
            end

            local Debounce = false 

            local SlidingPalette = false 
            local SlidingHue = false 
            local SlidingAlpha = false

            function Colorpicker:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Colorpicker.IsOpen = Bool

                Debounce = true
                Items["ColorpickerWindow"].Instance.Parent = Bool and Library.Holder.Instance or Library.UnusedHolder.Instance

                if Bool then 
                    Items["ColorpickerWindow"].Instance.Visible = true
                    Items["ColorpickerWindow"].Instance.Position = UDim2New(0, Items["ColorpickerButton"].Instance.AbsolutePosition.X, 0, Items["ColorpickerButton"].Instance.AbsolutePosition.Y + 25)
                    
                    for Index, Value in Library.OpenFrames do 
                        if Value.Type == "Colorpicker" then 
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Data.Name] = Colorpicker
                else
                    if Library.OpenFrames[Data.Name] then 
                        Library.OpenFrames[Data.Name] = nil
                    end
                end

                local Descendants = Items["ColorpickerWindow"].Instance:GetDescendants()
                TableInsert(Descendants, Items["ColorpickerWindow"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then 
                        continue
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Data.Window.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Data.Window.FadeSpeed)
                    end
                end

                Library:Connect(NewTween.Tween.Completed, function()
                    Debounce = false
                    Items["ColorpickerWindow"].Instance.Visible = Bool
                end)                
            end

            function Colorpicker:Get()
                return Colorpicker.Color, Colorpicker.Alpha
            end

            function Colorpicker:Update(IsFromAlpha)
                local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                local Color = FromHSV(Hue, Saturation, Value)

                Colorpicker.Color = Color
                Colorpicker.HexValue = Color:ToHex()

                Library.Flags[Data.Flag] = {
                    Alpha = Colorpicker.Alpha,
                    Color = Colorpicker.HexValue
                }

                Items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = Color})
                Items["Inline"]:Tween(nil, {BackgroundColor3 = Color})
                Items["Palette"]:Tween(nil, {BackgroundColor3 = FromHSV(Hue, 1, 1)})

                if not IsFromAlpha then 
                    Items["Alpha"]:Tween(nil, {BackgroundColor3 = Color})
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Color, Colorpicker.Alpha)
                end
            end

            function Colorpicker:SlidePalette(Input)
                if not SlidingPalette then 
                    return
                end

                if not Input then
                    return
                end

                local ValueX = MathClamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local ValueY = MathClamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                Colorpicker.Saturation = ValueX
                Colorpicker.Value = ValueY

                local SlideX = MathClamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.98)
                local SlideY = MathClamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.97)

                Items["PaletteDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, SlideY, 0)})
                Colorpicker:Update()
            end

            function Colorpicker:SlideHue(Input)
                if not SlidingHue then 
                    return
                end

                if not Input then
                    return
                end
                
                local ValueX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 1)
                
                Colorpicker.Hue = ValueX

                local SlideX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 0.98)

                Items["HueDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, 0.5, 0)})
                Colorpicker:Update()
            end

            function Colorpicker:SlideAlpha(Input)
                if not SlidingAlpha then 
                    return
                end

                if not Input then
                    return
                end
                
                local ValueX = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 1)
                
                Colorpicker.Alpha = ValueX

                local SlideX = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 0.98)

                Items["AlphaDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, 0.5, 0)})
                Colorpicker:Update(true)
            end

            function Colorpicker:Set(Color, Alpha)
                if type(Color) == "table" then
                    Color = FromRGB(Color[1], Color[2], Color[3])
                    Alpha = Color[4]
                elseif type(Color) == "string" then
                    Color = FromHex(Color)
                end 

                Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
                Colorpicker.Alpha = Alpha or 0

                local ColorPositionX = MathClamp(1 - Colorpicker.Saturation, 0, 0.98)
                local ColorPositionY = MathClamp(1 - Colorpicker.Value, 0, 0.97)

                local AlphaPositionX = MathClamp(Colorpicker.Alpha, 0, 0.98)

                local HuePositionX = MathClamp(Colorpicker.Hue, 0, 0.98)

                Items["PaletteDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(ColorPositionX, 0, ColorPositionY, 0)})
                Items["HueDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(HuePositionX, 0, 0.5, 0)})
                Items["AlphaDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(AlphaPositionX, 0, 0.5, 0)})
                Colorpicker:Update()
            end

            getgenv().Options[Data.Flag] = Colorpicker

            Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                Colorpicker:SetOpen(not Colorpicker.IsOpen)
            end)

            local InputChanged1

            Items["Palette"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                    SlidingPalette = true
                    Colorpicker:SlidePalette(Input)

                    if InputChanged1 then
                        return
                    end

                    InputChanged1 = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then 
                            SlidingPalette = false

                            InputChanged1:Disconnect()
                            InputChanged1 = nil
                        end
                    end)
                end
            end)

            local InputChanged2

            Items["Hue"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                    SlidingHue = true
                    Colorpicker:SlideHue(Input)
                    
                    if InputChanged2 then
                        return
                    end

                    InputChanged2 = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingHue = false

                            InputChanged2:Disconnect()
                            InputChanged2 = nil
                        end
                    end)
                end
            end)

            local InputChanged3

            Items["Alpha"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                    SlidingAlpha = true
                    Colorpicker:SlideAlpha(Input)

                    if InputChanged3 then
                        return
                    end

                    InputChanged3 = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingAlpha = false

                            InputChanged3:Disconnect()
                            InputChanged3 = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if SlidingPalette then
                        Colorpicker:SlidePalette(Input)
                    end

                    if SlidingHue then
                        Colorpicker:SlideHue(Input)
                    end

                    if SlidingAlpha then
                        Colorpicker:SlideAlpha(Input)
                    end
                end
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not Colorpicker.IsOpen then
                        return
                    end

                    if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) or Library:IsMouseOverFrame(AnimationsDropdownItems["OptionHolder"]) then
                        return 
                    end

                    if Debounce then 
                        return 
                    end

                    Colorpicker:SetOpen(false)
                end
            end)

            if Data.Default then
                Colorpicker:Set(Data.Default, Data.Alpha)
            end

            Library.SetFlags[Data.Flag] = function(Color, Alpha)
                Colorpicker:Set(Color, Alpha)
            end

            return Colorpicker, Items 
        end

        Components.Keybind = function(Data)
            local Keybind = {
                Type = "Keybind",
                IsOpen = false,

                Key = nil,
                Value = "",
                Mode = "",

                Toggled = false 
            }

            local Modes = { }
            Library.Flags[Data.Flag] = { }
            local ModesDropdown
            local ModesDropdownItems 
            local KeylistItem 

            if Library.KeyList and not Data.NoKeyBindList then 
                KeylistItem = Library.KeyList:Add("", "")
            end

            local Items = { } do
                Items["KeyButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = "None",
                    AutomaticSize = Enum.AutomaticSize.X,
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, Data.IsToggle and -25 or 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["KeyButton"]:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UIPadding", {
                    Parent = Items["KeyButton"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 2),
                    PaddingLeft = UDimNew(0, 2)
                })

                Items["KeybindWindow"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    Position = UDim2New(0, Items["KeyButton"].Instance.AbsolutePosition.X, 0, Items["KeyButton"].Instance.AbsolutePosition.Y + 25),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Visible = false,
                    Size = UDim2New(0, 195, 0, 93),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["KeybindWindow"]:AddToTheme({BackgroundColor3 = "Background"})

                Instances:Create("UIStroke", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Instances:Create("UICorner", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["KeybindWindow"]:MakeDraggable()
                Items["KeybindWindow"]:MakeResizeable(Vector2New(155, 93), Vector2New(9999, 9999))

                local DropdownItems = { } do
                    DropdownItems["Dropdown"] = Instances:Create("Frame", {
                        Parent = Items["KeybindWindow"].Instance,
                        Name = "\0",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0, 0),
                        Size = UDim2New(1, -16, 0, 47),
                        Position = UDim2New(0, 8, 0, 8),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })

                    DropdownItems["Text"] = Instances:Create("TextLabel", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "mode",
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 0, 0, 15),
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["Text"]:AddToTheme({TextColor3 = "Text"})

                    DropdownItems["RealDropdown"] = Instances:Create("TextButton", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Text = "", 
                        AutoButtonColor = false,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        Position = UDim2New(0, 0, 1, 0),
                        Size = UDim2New(1, 0, 0, 25),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(34, 39, 45)
                    })  DropdownItems["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})

                    Instances:Create("UIGradient", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        Rotation = 84,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                    end})

                    Instances:Create("UICorner", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })

                    DropdownItems["Value"] = Instances:Create("TextLabel", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "--",
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2New(0, 0, 0, 15),
                        AnchorPoint = Vector2New(0, 0.5),
                        Position = UDim2New(0, 8, 0.5, 0),
                        BackgroundTransparency = 1,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["Value"]:AddToTheme({TextColor3 = "Text"})

                    DropdownItems["OpenIcon"] = Instances:Create("ImageLabel", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(196, 231, 255),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 20, 0, 20),
                        AnchorPoint = Vector2New(1, 0.5),
                        Image = "rbxassetid://114252321536924",
                        BackgroundTransparency = 1,
                        Position = UDim2New(1, -3, 0.5, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["OpenIcon"]:AddToTheme({ImageColor3 = "Accent"})

                    DropdownItems["OptionHolder"] = Instances:Create("TextButton", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        Visible = false,
                        AutoButtonColor = false,
                        Size = UDim2New(1, 0, 0, 50),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Position = UDim2New(0, 0, 1, 5),
                        BorderSizePixel = 0,
                        ZIndex = 5,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(22, 25, 29)
                    })  DropdownItems["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})

                    Instances:Create("UIGradient", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Rotation = 84,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                    end})

                    Instances:Create("UIStroke", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Color = FromRGB(32, 36, 42),
                        Transparency = 0.4000000059604645,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):AddToTheme({Color = "Border"})

                    Instances:Create("UICorner", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 5)
                    })

                    Instances:Create("UIListLayout", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 2),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Instances:Create("UIPadding", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        PaddingTop = UDimNew(0, 8),
                        PaddingBottom = UDimNew(0, 8),
                        PaddingRight = UDimNew(0, 8),
                        PaddingLeft = UDimNew(0, 8)
                    })
                end

                local Dropdown = { 
                    IsOpen = false,
                    Value = { },
                    Options = { },
                    Flag = Data.Flag .. "ModeDropdown",
                    Multi = false
                }

                function Dropdown:AddOption(Option)
                    local OptionButton = Instances:Create("TextButton", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2New(1, 0, 0, 25),
                        ZIndex = 5,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(16, 18, 21)
                    })  OptionButton:AddToTheme({BackgroundColor3 = "Background"})

                    local CheckImage = Instances:Create("ImageLabel", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(196, 231, 255),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 18, 0, 18),
                        Visible = true,
                        AnchorPoint = Vector2New(0, 0.5),
                        Image = "rbxassetid://116339777575852",
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 3, 0.5, 0),
                        ImageTransparency = 1,
                        ZIndex = 5,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  CheckImage:AddToTheme({ImageColor3 = "Accent"})

                    Instances:Create("UICorner", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 5)
                    })

                    local OptionText = Instances:Create("TextLabel", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextTransparency = 0.5,
                        AnchorPoint = Vector2New(0, 0.5),
                        ZIndex = 5,
                        TextSize = 14,
                        Size = UDim2New(0, 0, 0, 15),
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = Option,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Position = UDim2New(0, 7, 0.5, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  OptionText:AddToTheme({TextColor3 = "Text"})

                    local OptionData = {
                        Selected = false,
                        Name = Option,
                        Text = OptionText,
                        Button = OptionButton,
                        Check = CheckImage
                    }

                    function OptionData:Toggle(Status)
                        if Status == "Active" then 
                            OptionData.Button:Tween(nil, {BackgroundTransparency = 0})
                            OptionData.Text:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 27, 0.5, 0)})
                            OptionData.Check:Tween(nil, {ImageTransparency = 0})
                        elseif Status == "Inactive" then
                            OptionData.Button:Tween(nil, {BackgroundTransparency = 1})
                            OptionData.Text:Tween(nil, {TextTransparency = 0.5, Position = UDim2New(0, 7, 0.5, 0)})
                            OptionData.Check:Tween(nil, {ImageTransparency = 1})
                        end
                    end

                    function OptionData:Set()
                        OptionData.Selected = not OptionData.Selected

                        if Dropdown.Multi then 
                            local Index = TableFind(Dropdown.Value, OptionData.Name)

                            if Index then 
                                TableRemove(Dropdown.Value, Index)
                            else
                                TableInsert(Dropdown.Value, OptionData.Name)
                            end

                            Library.Flags[Dropdown.Flag] = Dropdown.Value

                            OptionData:Toggle(Index and "Inactive" or "Active")

                            local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "--"

                            DropdownItems["Value"].Instance.Text = TextFormat
                        else
                            if OptionData.Selected then 
                                Dropdown.Value = OptionData.Name
                                Library.Flags[Dropdown.Flag] = OptionData.Name

                                OptionData:Toggle("Active")

                                for Index, Value in Dropdown.Options do 
                                    if Value ~= OptionData then
                                        Value.Selected = false 
                                        Value:Toggle("Inactive")
                                    end
                                end

                                DropdownItems["Value"].Instance.Text = OptionData.Name 
                            else
                                Dropdown.Value = nil
                                Library.Flags[Dropdown.Flag] = nil

                                OptionData:Toggle("Inactive")
                                DropdownItems["Value"].Instance.Text = "--"
                            end
                        end

                        if Dropdown.Callback then 
                            Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                        end
                    end

                    OptionData.Button:Connect("MouseButton1Down", function()
                        OptionData:Set()
                    end)

                    Dropdown.Options[Option] = OptionData
                    return OptionData
                end

                function Dropdown:Set(Option)
                    if Dropdown.Multi then
                        if type(Option) ~= "table" then
                            return
                        end

                        Dropdown.Value = Option
                        Library.Flags[Dropdown.Flag] = Option

                        for Index, Value in Option do 
                            local OptionData = Dropdown.Options[Value]
                            
                            if not OptionData then 
                                return
                            end

                            OptionData.Selected = true
                            OptionData:Toggle("Active")
                        end

                        DropdownItems["Value"].Instance.Text = TableConcat(Option, ", ")
                    else
                        if not Dropdown.Options[Option] then 
                            return
                        end

                        local OptionData = Dropdown.Options[Option]

                        Dropdown.Value = OptionData.Name
                        Library.Flags[Dropdown.Flag] = OptionData.Name

                        for Index, Value in Dropdown.Options do 
                            if Value ~= OptionData then
                                Value.Selected = false 
                                Value:Toggle("Inactive")
                            else
                                Value.Selected = true 
                                Value:Toggle("Active")
                            end
                        end

                        DropdownItems["Value"].Instance.Text = OptionData.Name
                    end

                    if Dropdown.Callback then 
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end

                    Library.SetFlags[Dropdown.Flag] = function(Value)
                        Dropdown:Set(Value)
                    end
                end

                local _1 = Dropdown:AddOption("toggle")
                local _2 = Dropdown:AddOption("hold")
                local _3 = Dropdown:AddOption("always")

                Modes = {
                    ["toggle"] = _1,
                    ["hold"] = _2,
                    ["always"] = _3
                }

                local Debounce = false 
                local RenderStepped

                function Dropdown:SetOpen(Bool)
                    if Debounce then 
                        return 
                    end

                    Dropdown.IsOpen = Bool
                    DropdownItems["OptionHolder"].Instance.Parent = Bool and Library.Holder.Instance or Library.UnusedHolder.Instance

                    Debounce = true

                    if Bool then 
                        DropdownItems["OptionHolder"].Instance.Visible = true

                        RenderStepped = RunService.RenderStepped:Connect(function()
                            DropdownItems["OptionHolder"].Instance.Position = UDim2New(0, DropdownItems["RealDropdown"].Instance.AbsolutePosition.X, 0,  DropdownItems["RealDropdown"].Instance.AbsolutePosition.Y + DropdownItems["RealDropdown"].Instance.AbsoluteSize.Y + 5)
                            DropdownItems["OptionHolder"].Instance.Size = UDim2New(0, DropdownItems["RealDropdown"].Instance.AbsoluteSize.X, 0, 85)
                        end)
                    else
                        if RenderStepped then
                            RenderStepped:Disconnect()
                            RenderStepped = nil
                        end
                    end

                    local Descendants = DropdownItems["OptionHolder"].Instance:GetDescendants()
                    TableInsert(Descendants, DropdownItems["OptionHolder"].Instance)

                    local NewTween

                    for Index, Value in Descendants do 
                        local TransparencyProperty = Tween:GetProperty(Value)

                        if not TransparencyProperty then 
                            continue
                        end

                        if StringFind(Value.ClassName, "UI") then
                            continue
                        end

                        Value.ZIndex = Bool and 10 or 0

                        if type(TransparencyProperty) == "table" then 
                            for _, Property in TransparencyProperty do 
                                NewTween = Tween:FadeItem(Value, Property, Bool, Data.Window.FadeSpeed)
                            end
                        else
                            NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Data.Window.FadeSpeed)
                        end
                    end

                    Library:Connect(NewTween.Tween.Completed, function()
                        Debounce = false
                        DropdownItems["OptionHolder"].Instance.Visible = Bool
                    end)
                end

                DropdownItems["RealDropdown"]:Connect("MouseButton1Down", function()
                    Dropdown:SetOpen(not Dropdown.IsOpen)
                end)

                ModesDropdown = Dropdown
                ModesDropdownItems = DropdownItems

                local ToggleItems = { } do
                    ToggleItems["Toggle"] = Instances:Create("TextButton", {
                        Parent = Items["KeybindWindow"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2New(0, 8, 0, 65),
                        Size = UDim2New(1, -16, 0, 20),
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })

                    ToggleItems["Text"] = Instances:Create("TextLabel", {
                        Parent = ToggleItems["Toggle"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(255, 255, 255),
                        TextTransparency = 0.5,
                        Text = "show in keybind list",
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2New(0, 0, 0, 15),
                        AnchorPoint = Vector2New(0, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 0, 0.5, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  ToggleItems["Text"]:AddToTheme({TextColor3 = "Text"})

                    ToggleItems["Indicator"] = Instances:Create("Frame", {
                        Parent = ToggleItems["Toggle"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(1, 0.5),
                        Position = UDim2New(1, 0, 0.5, 0),
                        Size = UDim2New(0, 20, 0, 20),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(34, 39, 45)
                    })  ToggleItems["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})

                    Instances:Create("UICorner", {
                        Parent = ToggleItems["Indicator"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })

                    ToggleItems["Inline"] = Instances:Create("Frame", {
                        Parent = ToggleItems["Indicator"].Instance,
                        Name = "\0",
                        Size = UDim2New(1, -4, 1, -4),
                        Position = UDim2New(0, 2, 0, 2),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(34, 39, 45)
                    })  ToggleItems["Inline"]:AddToTheme({BackgroundColor3 = "Element"})

                    Instances:Create("UICorner", {
                        Parent = ToggleItems["Inline"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })

                    Instances:Create("UIGradient", {
                        Parent = ToggleItems["Inline"].Instance,
                        Name = "\0",
                        Rotation = 84,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                    end})

                    ToggleItems["Check"] = Instances:Create("ImageLabel", {
                        Parent = ToggleItems["Inline"].Instance,
                        Name = "\0",
                        Visible = true,
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(1, -2, 1, -2),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Image = "rbxassetid://116339777575852",
                        BackgroundTransparency = 1,
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        ImageTransparency = 1,
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        ImageColor3 = FromRGB(0, 0, 0)
                    })
                end

                getgenv().Options[Dropdown.Flag] = Dropdown

                local Toggle = { 
                    Value = false,
                    Flag = Data.Flag .. "keybindToggle",
                    Callback = nil,
                }

                function Toggle:Set(Bool)
                    Toggle.Value = Bool 
                    Library.Flags[Toggle.Flag] = Bool

                    if Bool then
                        ToggleItems["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                        ToggleItems["Inline"]:ChangeItemTheme({BackgroundColor3 = "Accent"})

                        ToggleItems["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                        ToggleItems["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})

                        ToggleItems["Check"]:Tween(nil, {ImageTransparency = 0})
                        ToggleItems["Text"]:Tween(nil, {TextTransparency = 0})
                    else
                        ToggleItems["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                        ToggleItems["Inline"]:ChangeItemTheme({BackgroundColor3 = "Element"})

                        ToggleItems["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                        ToggleItems["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})

                        ToggleItems["Check"]:Tween(nil, {ImageTransparency = 1})
                        ToggleItems["Text"]:Tween(nil, {TextTransparency = 0.5})
                    end

                    if Toggle.Callback then 
                        Library:SafeCall(Toggle.Callback, Bool)
                    end
                end

                Toggle.Callback = function(Value)
                    if KeylistItem then 
                        KeylistItem:SetVisibility(Value)
                    end
                end

                ToggleItems["Toggle"]:Connect("MouseButton1Down", function()
                    Toggle:Set(not Toggle.Value)
                end)

                Toggle:Set(true)

                Dropdown.Callback = function(Value)
                    Keybind.Mode = Value

                    Library.Flags[Data.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }
                end 

                getgenv().Options[Toggle.Flag] = Toggle
            end

            local Update = function()
                if not KeylistItem then 
                    return 
                end

                KeylistItem:SetText(Keybind.Value, Data.Name)
                
                if Keybind.Mode == "hold" then 
                    KeylistItem:SetStatus(Keybind.Toggled and "holding" or "off")
                else
                    KeylistItem:SetStatus(Keybind.Toggled and "on" or "off")
                end

                KeylistItem:Set(Keybind.Toggled)
            end

            local Debounce = false

            function Keybind:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Keybind.IsOpen = Bool

                Debounce = true
                Items["KeybindWindow"].Instance.Parent = Bool and Library.Holder.Instance or Library.UnusedHolder.Instance

                if Bool then 
                    Items["KeybindWindow"].Instance.Visible = true
                    Items["KeybindWindow"].Instance.Position = UDim2New(0, Items["KeyButton"].Instance.AbsolutePosition.X, 0, Items["KeyButton"].Instance.AbsolutePosition.Y + 25)

                    for Index, Value in Library.OpenFrames do 
                        if Value.Type == "Keybind" then 
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Data.Name] = Keybind
                else
                    ModesDropdown:SetOpen(false)

                    if Library.OpenFrames[Data.Name] then 
                        Library.OpenFrames[Data.Name] = nil
                    end
                end

                local Descendants = Items["KeybindWindow"].Instance:GetDescendants()
                TableInsert(Descendants, Items["KeybindWindow"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then 
                        continue
                    end

                    if StringFind(Value.ClassName, "UI") then
                        continue
                    end

                    Value.ZIndex = Bool and 15 or 0

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Data.Window.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Data.Window.FadeSpeed)
                    end
                end

                Library:Connect(NewTween.Tween.Completed, function()
                    Debounce = false
                    Items["KeybindWindow"].Instance.Visible = Bool
                end)
            end

            function Keybind:SetMode(Mode)
                ModesDropdown:Set(Mode)
                
                Library.Flags[Data.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                Update()
            end

            function Keybind:Get()
                return Keybind.Toggled, Keybind.Key
            end

            function Keybind:Set(Key)
                if StringFind(tostring(Key), "Enum") then 
                    Keybind.Key = tostring(Key)

                    Key = Key.Name == "Backspace" and "None" or Key.Name

                    local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
                    local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    Library.Flags[Data.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                elseif type(Key) == "table" then
                    local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                    Keybind.Key = tostring(Key.Key)

                    if Key.Mode then
                        Keybind.Mode = Key.Mode
                        Keybind:SetMode(Key.Mode)
                    else
                        Keybind.Mode = "toggle"
                        Keybind:SetMode("toggle")
                    end

                    local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                    local TextToDisplay = KeyString and StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "")

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                elseif TableFind({"toggle", "hold", "always"}, Key) then
                    Keybind.Mode = Key
                    Keybind:SetMode(Keybind.Mode)

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                end

                Items["KeyButton"]:Tween(nil, {TextTransparency = 0.5})
                Keybind.Picking = false
            end

            function Keybind:Press(Bool)
                if Keybind.Mode == "toggle" then 
                    Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.Mode == "hold" then 
                    Keybind.Toggled = Bool
                elseif Keybind.Mode == "always" then 
                    Keybind.Toggled = true
                end

                Library.Flags[Data.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end

                Update()
            end

            getgenv().Options[Data.Flag] = Keybind

            Items["KeyButton"]:Connect("MouseButton1Click", function()
                if Keybind.Picking then 
                    return
                end

                Keybind.Picking = true

                Items["KeyButton"]:Tween(nil, {TextTransparency = 0})

                local InputBegan 
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then 
                        Keybind:Set(Input.KeyCode)
                    else
                        Keybind:Set(Input.UserInputType)
                    end

                    InputBegan:Disconnect()
                    InputBegan = nil
                end)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input, Typing)
                if Typing then return end

                if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key and not Keybind.Value == "None" then
                    if Keybind.Mode == "toggle" then 
                        Keybind:Press()
                    elseif Keybind.Mode == "hold" then 
                        Keybind:Press(true)
                    end
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
                    if Library:IsMouseOverFrame(Items["KeybindWindow"]) or Library:IsMouseOverFrame(ModesDropdownItems["OptionHolder"]) then 
                        return
                    end

                    if Debounce then 
                        return 
                    end

                    Keybind:SetOpen(false)
                end
            end)

            Library:Connect(UserInputService.InputEnded, function(Input, Typing)
                if Typing then return end

                if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key and not Keybind.Value == "None"  then
                    if Keybind.Mode == "hold" then 
                        Keybind:Press(false)
                    end
                end
            end)

            Items["KeyButton"]:Connect("MouseButton2Down", function()
                Keybind:SetOpen(not Keybind.IsOpen)
            end)

            if Data.Default then
               Keybind.Mode = Data.Mode or "toggle"
               Modes[Keybind.Mode]:Set()
               Keybind:Set({Key = Data.Default, Mode = Data.Mode})
            end

            Library.SetFlags[Data.Flag] = function(Value)
                Keybind:Set(Value)
            end

            return Keybind, Items 
        end
    end

    do -- Element functions
        Library.ESPPreview = function(self, Data)
            local ESPPreview = { 
                Player = nil,
                Items = { },
            }

            local Items = { } do
                Items["EspPreview"] = Instances:Create("TextButton", {
                    Parent = Data.MainFrame.Instance,
                    Name = "\0",
                    Position = UDim2New(1, 10, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(0, 265, 0, 355),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["EspPreview"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["EspPreview"]:MakeDraggable()

                Items["Topbar"] = Instances:Create("Frame", {
                    Parent = Items["EspPreview"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 35),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Topbar"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UIStroke", {
                    Parent = Items["EspPreview"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Instances:Create("UICorner", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 3),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                }):AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    BackgroundTransparency = 0.4000000059604645,
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(32, 36, 42)
                }):AddToTheme({BackgroundColor3 = "Border"})

                Instances:Create("UIGradient", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    AnchorPoint = Vector2New(0, 0.5),
                    ZIndex = 2,
                    TextSize = 14,
                    Size = UDim2New(0, 0, 0, 15),
                    RichText = true,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "ESP Preview",
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2New(0, 8, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

                Items["CloseButton"] = Instances:Create("ImageButton", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 17, 0, 17),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://76001605964586",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -7, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["CloseButton"]:AddToTheme({ImageColor3 = "Image"})

                Instances:Create("UICorner", {
                    Parent = Items["EspPreview"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["CharacterViewportBackground"] = Instances:Create("TextButton", {
                    Parent = Items["EspPreview"].Instance,
                    Text = "",
                    AutoButtonColor = false,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0, 45),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -14, 1, -50),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["CharacterViewport"] = Instances:Create("ViewportFrame", {
                    Parent = Items["EspPreview"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0, 45),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -16, 1, -53),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                -- Box
                    Items.Box = Instances:Create( "Frame" , {
                        BackgroundTransparency = 1;
                        Parent = Items.CharacterViewport.Instance;
                        BorderColor3 = FromRGB(0, 0, 0);
                        Name = "\0";
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Items.Left = Instances:Create( "Frame" , {
                        Parent = Items.Box.Instance;
                        Size = UDim2New(0, 100, 1, 0);
                        BackgroundTransparency = 1;
                        Name = "\0";
                        AnchorPoint = Vector2New(1, 0);
                        Position = UDim2New(0, -5, 0, 0);
                        BorderColor3 = FromRGB(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Instances:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Left.Instance;
                        Padding = UDimNew(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    Items.LeftTexts = Instances:Create( "Frame" , {
                        Parent = Items.Left.Instance;
                        Size = UDim2New(0, 0, 1, 0);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = UDim2New(1, 1, 0, 0);
                        BorderColor3 = FromRGB(0, 0, 0);
                        LayoutOrder = 9999;
                        ZIndex = 2;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Instances:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Vertical;
                        Parent = Items.LeftTexts.Instance;
                        Padding = UDimNew(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    Items.Top = Instances:Create( "Frame" , {
                        Parent = Items.Box.Instance;
                        Size = UDim2New(1, 0, 0, 100);
                        BackgroundTransparency = 1;
                        Name = "\0";
                        AnchorPoint = Vector2New(0, 1);
                        Position = UDim2New(0, 0, 0, -5);
                        BorderColor3 = FromRGB(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Items.TopTexts = Instances:Create( "Frame", {
                        LayoutOrder = -1;
                        Parent = Items.Top.Instance;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = FromRGB(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Instances:Create( "UIListLayout" , {
                        VerticalAlignment = Enum.VerticalAlignment.Bottom;
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        HorizontalAlignment = Enum.HorizontalAlignment.Center;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Top.Instance;
                        Padding = UDimNew(0, 1)
                    });

                    Items.Right = Instances:Create( "Frame" , {
                        Parent = Items.Box.Instance;
                        Size = UDim2New(0, 100, 1, 0);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = UDim2New(1, 5, 0, 0);
                        BorderColor3 = FromRGB(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Items.RightTexts = Instances:Create( "Frame" , {
                        Parent = Items.Right.Instance;
                        Size = UDim2New(0, 0, 1, 0);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = UDim2New(0, 0, 0, 0);
                        BorderColor3 = FromRGB(0, 0, 0);
                        LayoutOrder = 9999;
                        ZIndex = 2;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Instances:Create( "UIListLayout" , {
                        Parent = Items.RightTexts.Instance;
                        Padding = UDimNew(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    Instances:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Right.Instance;
                        Padding = UDimNew(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    Items.Bottom = Instances:Create( "Frame" , {
                        Parent = Items.Box.Instance;
                        Size = UDim2New(1, 0, 0, 100);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = UDim2New(0, 0, 1, 5);
                        BorderColor3 = FromRGB(0, 0, 0);
                        AutomaticSize = Enum.AutomaticSize.Y;
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });
                    
                    Items.BottomTexts = Instances:Create( "Frame", {
                        LayoutOrder = 1;
                        Parent = Items.Bottom.Instance;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = FromRGB(0, 0, 0);
                        Size = UDim2New(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Instances:Create( "UIListLayout", {
                        Parent = Items.BottomTexts.Instance;
                        Padding = UDimNew(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    });

                    Instances:Create( "UIListLayout" , {
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        HorizontalAlignment = Enum.HorizontalAlignment.Center;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Bottom.Instance;
                        Padding = UDimNew(0, 1)
                    });

                        Items.BoxHolder = Instances:Create( "Frame" , {
                            Visible = true;
                            Size = UDim2New(1, -2, 1, -2);
                            BorderColor3 = FromRGB(0, 0, 0);
                            Parent = Items.Box.Instance;
                            BackgroundTransparency = 0.8500000238418579;
                            Position = UDim2New(0, 1, 0, 1);
                            Name = "\0";
                            BorderSizePixel = 0;
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        });

                        Items.BoxHolderGradient = Instances:Create( "UIGradient" , {
                            Rotation = 0;
                            Name = "\0";
                            Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))};
                            Parent = Items.BoxHolder.Instance;
                            Enabled = true
                        }); 

                        Instances:Create( "UIStroke" , {
                            Parent = Items.BoxHolder.Instance;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });
                        
                        Items.Inner = Instances:Create( "Frame" , {
                            Parent = Items.BoxHolder.Instance;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = UDim2New(0, 1, 0, 1);
                            BorderColor3 = FromRGB(0, 0, 0);
                            Size = UDim2New(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        });

                        Items.UIStroke = Instances:Create( "UIStroke" , {
                            Color = FromRGB(255, 255, 255);
                            LineJoinMode = Enum.LineJoinMode.Miter;
                            Parent = Items.Inner.Instance
                        });
                        
                        Items.BoxGradient = Instances:Create( "UIGradient" , {
                            Rotation = 0;
                            Name = "\0";
                            Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))};
                            Parent = Items.UIStroke.Instance;
                            Enabled = true
                        });
                        
                        Items.Inner2 = Instances:Create( "Frame" , {
                            Parent = Items.BoxHolder.Instance;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = UDim2New(0, 2, 0, 2);
                            BorderColor3 = FromRGB(0, 0, 0);
                            Size = UDim2New(1, -4, 1, -4);
                            BorderSizePixel = 0;
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        });

                        Instances:Create( "UIStroke" , {
                            Parent = Items.Inner2.Instance;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });
                -- Healthbar
                    Items.HealthBar = Instances:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.Left.Instance;
                        BorderColor3 = FromRGB(0, 0, 0);
                        Size = UDim2New(0, 3, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(0, 0, 0)
                    });

                    Items.Bar = Instances:Create( "Frame" , {
                        Parent = Items.HealthBar.Instance;
                        Name = "\0";
                        Position = UDim2New(0, 1, 0, 1);
                        BorderColor3 = FromRGB(0, 0, 0);
                        Size = UDim2New(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    });

                    Items.BarGradient = Instances:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Bar.Instance;
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(255, 125, 0)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
                    });

                    Items.HealthBarText = Instances:Create( "TextLabel" , {
                        FontFace = ESPFonts["ProggyClean"];
                        Parent = Items.HealthBar.Instance;
                        TextColor3 = FromRGB(0, 255, 0);
                        Text = "100";
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Position = UDim2New(0, 1, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        AnchorPoint = Vector2New(1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderColor3 = FromRGB(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                    })

                    Instances:Create( "UIStroke", {
                        Parent = Items.HealthBarText.Instance;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                -- Name
                        Items.Name = Instances:Create( "TextLabel" , {
                            FontFace = ESPFonts["ProggyClean"];
                            Parent = Items.TopTexts.Instance;
                            TextColor3 = FromRGB(255, 255, 255);
                            TextStrokeColor3 = FromRGB(255, 255, 255);
                            Text = LocalPlayer.Name;
                            Name = "\0";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = UDim2New(0.5, 1, 0, 0);
                            BorderSizePixel = 0;
                            AnchorPoint = Vector2New(0.5, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Center;
                            BorderColor3 = FromRGB(0, 0, 0);
                            ZIndex = 2;
                            TextSize = 12;
                        });

                        Instances:Create( "UIStroke", {
                            Parent = Items.Name.Instance;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });

                        Items.WeaponText = Instances:Create( "TextLabel" , {
                            FontFace = ESPFonts["ProggyClean"];
                            Parent = Items.RightTexts.Instance;
                            TextColor3 = FromRGB(255, 255, 255);
                            TextStrokeColor3 = FromRGB(255, 255, 255);
                            Text = "Weapon";
                            Name = "\0";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = UDim2New(0, 1, 0, 0);
                            BorderSizePixel = 0;
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Center;
                            BorderColor3 = FromRGB(0, 0, 0);
                            ZIndex = 2;
                            TextSize = 12;
                        });

                        Instances:Create( "UIStroke", {
                            Parent = Items.WeaponText.Instance;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });

                        Items.Distance = Instances:Create( "TextLabel" , {
                            FontFace = ESPFonts["ProggyClean"];
                            Parent = Items.BottomTexts.Instance;
                            TextColor3 = FromRGB(255, 255, 255);
                            TextStrokeColor3 = FromRGB(255, 255, 255);
                            Text = "Distance";
                            Name = "\0";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = UDim2New(0, 1, 0, 0);
                            BorderSizePixel = 0;
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Center;
                            BorderColor3 = FromRGB(0, 0, 0);
                            ZIndex = 2;
                            TextSize = 12;
                        });

                        Instances:Create( "UIStroke", {
                            Parent = Items.Distance.Instance;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });

                -- Corner boxes
                        Items.Corners = Instances:Create( "Frame" , {
                            Parent = Items.Box.Instance;
                            Name = "\0";
                            ClipsDescendants = true;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Size = UDim2New(1, 0, 1, 0);
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0;
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        });

                        Items.CornersGradient = Instances:Create( "UIGradient" , {
                            Parent = Items.Corners.Instance;
                        });

                        Items.BottomLeftX = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Items.Corners.Instance;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Size = UDim2New(0.25, 0, 0, 3);
                            AnchorPoint = Vector2New(0, 1);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Position = UDim2New(0, 0, 1, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 1), Vector2New(99, 2))
                        });

                        Instances:Create( "UIGradient" , {
                            Parent = Items.BottomLeftX.Instance
                        });

                        Items.BottomLeftY = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Items.Corners.Instance;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Size = UDim2New(0, 3, 0.25, -9);
                            AnchorPoint = Vector2New(0, 1);
                            Image = "rbxassetid://101715268403902";
                            BackgroundTransparency = 1;
                            Position = UDim2New(0, 0, 1, -2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 0), Vector2New(2, 96))
                        });

                        Instances:Create( "UIGradient" , {
                            Rotation = -90;
                            Parent = Items.BottomLeftY.Instance
                        });

                        Items.BottomLeftX = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Items.Corners.Instance;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Size = UDim2New(0.25, 0, 0, 3);
                            AnchorPoint = Vector2New(1, 1);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Position = UDim2New(1, 0, 1, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 1), Vector2New(99, 2))
                        });

                        Instances:Create( "UIGradient" , {
                            Parent = Items.BottomLeftX.Instance
                        });

                        Items.BottomLeftY = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Items.Corners.Instance;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Size = UDim2New(0, 3, 0.25, -9);
                            AnchorPoint = Vector2New(1, 1);
                            Image = "rbxassetid://101715268403902";
                            BackgroundTransparency = 1;
                            Position = UDim2New(1, 0, 1, -2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 0), Vector2New(2, 96))
                        });

                        Instances:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Items.BottomLeftY.Instance
                        });

                        Items.TopLeftY = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Parent = Items.Corners.Instance;
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Size = UDim2New(0, 3, 0.25, -9);
                            Image = "rbxassetid://102467475629368";
                            BackgroundTransparency = 1;
                            Position = UDim2New(0, 0, 0, 2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 0), Vector2New(2, 98))
                        });

                        Instances:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Items.TopLeftY.Instance
                        });

                        Items.TopRightY = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Items.Corners.Instance;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Size = UDim2New(0, 3, 0.25, -9);
                            AnchorPoint = Vector2New(1, 0);
                            Image = "rbxassetid://102467475629368";
                            BackgroundTransparency = 1;
                            Position = UDim2New(1, 0, 0, 2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 0), Vector2New(2, 98))
                        });

                        Instances:Create( "UIGradient" , {
                            Rotation = -90;
                            Parent = Items.TopRightY.Instance
                        });

                        Items.TopRightX = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Items.Corners.Instance;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Size = UDim2New(0.25, 0, 0, 3);
                            AnchorPoint = Vector2New(1, 0);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Position = UDim2New(1, 0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 1), Vector2New(99, 2))
                        });

                        Instances:Create( "UIGradient" , {
                            Parent = Items.TopRightX.Instance
                        });

                        Items.TopLeftX = Instances:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            BorderColor3 = FromRGB(0, 0, 0);
                            Parent = Items.Corners.Instance;
                            Name = "\0";
                            BackgroundColor3 = FromRGB(255, 255, 255);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Size = UDim2New(0.25, 0, 0, 3);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = RectNew(Vector2New(1, 1), Vector2New(99, 2))
                        });

                        Instances:Create( "UIGradient" , {
                            Parent = Items.TopLeftX.Instance
                        });

                ESPPreview.Items = Items
            end

            function ESPPreview:Set(Item, Property, Value)
                Items[Item].Instance[Property] = Value
            end

            local Math = {} do
                local inf = math.huge
                local negative_inf = -math.huge

                Math.GetBoundingBox = LPH_NO_VIRTUALIZE(function(self, model, camera, ViewportFrame)
                    model = type(model) ~= 'table' and model:GetDescendants() or model
                    local Min, Max = Vector2New(inf, inf), Vector2New(negative_inf, negative_inf)
                    
                    for _,v in model do
                        if not v:IsA("BasePart") then
                            continue
                        end

                        local Size, cFrame = v.Size, v.CFrame

                        local Corners = {
                            Vector3New( 0.5,  0.5,  0.5),
                            Vector3New(-0.5,  0.5,  0.5),
                            Vector3New( 0.5, -0.5,  0.5),
                            Vector3New(-0.5, -0.5,  0.5),
                            Vector3New( 0.5,  0.5, -0.5),
                            Vector3New(-0.5,  0.5, -0.5),
                            Vector3New( 0.5, -0.5, -0.5),
                            Vector3New(-0.5, -0.5, -0.5),
                        }

                        for _,corner in Corners do
                            local Point = cFrame:PointToWorldSpace(Vector3New(
                                corner.X * Size.X,
                                corner.Y * Size.Y,
                                corner.Z * Size.Z
                            ))

                            local Viewport, Visible = camera:WorldToViewportPoint(Point)

                            if Visible then
                                Min = Vector2New(MathMin(Min.X, Viewport.X), MathMin(Min.Y, Viewport.Y))
                                Max = Vector2New(MathMax(Max.X, Viewport.X), MathMax(Max.Y, Viewport.Y))
                            end
                        end
                    end

                    local AbsoluteSize = ViewportFrame.AbsoluteSize

                    local Size2D = Max - Min

                    local Position = Vector2New(Min.X - 0.05, Min.Y)
                    local Size = Vector2New(Size2D.X + 0.1, Size2D.Y)

                    return UDim2FromScale(Position.X, Position.Y), UDim2FromScale(Size.X, Size.Y)
                end)
            end

            function ESPPreview:SetVisibility(Bool)
                Items["EspPreview"].Instance.Visible = Bool
            end
            
            Items["CloseButton"]:Connect("MouseButton1Down", function()
                ESPPreview:SetVisibility(false)
            end)

            local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

            local ViewportCamera = InstanceNew("Camera")
            Items["CharacterViewport"].Instance.CurrentCamera = ViewportCamera
            ViewportCamera.CameraType = Enum.CameraType.Track
            ViewportCamera.Focus = CFrameNew(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            ViewportCamera.CFrame = CFrameNew(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)

            Library:Connect(RunService.RenderStepped, LPH_NO_VIRTUALIZE(function()	
                local Pos, Size = Math:GetBoundingBox(ESPPreview.Player, ViewportCamera, Items.CharacterViewport.Instance)
                Items.Box.Instance.Position = Pos
                Items.Box.Instance.Size = Size
            end))

            local ViewportModel

            if LocalCharacter then
                LocalCharacter.Archivable = true
                ViewportModel = LocalCharacter:Clone()

                ViewportModel.PrimaryPart.Anchored = true
                ViewportModel.Parent = Items["CharacterViewport"].Instance

                for Index, Value in ViewportModel:GetDescendants() do
                    if Value:IsA("LocalScript") then
                        Value:Destroy()
                    end
                end

                local HumanoidRootPart = ViewportModel:FindFirstChild("HumanoidRootPart")

                if HumanoidRootPart then
                    if not ViewportModel.PrimaryPart then
                        ViewportModel.PrimaryPart = HumanoidRootPart
                    end

                    ViewportModel:SetPrimaryPartCFrame(CFrameAngles(0, MathRad(180), 0) + Vector3New(0, 1.5, 0))
                    ViewportCamera.CFrame = CFrameNew(Vector3New(0, 2, 6), Vector3New(0, 1, 0))
                end

                ESPPreview.Player = ViewportModel
            end

            ViewportCamera.CameraSubject = ViewportModel

            local LastPosition 
            local IsRotating = false

            local Sensitivity = 0.7

            local Yaw = MathRad(180)
            local Roll = 0
            local Pitch = 0

            local ClampPitch = function(PitchValue)
                return MathClamp(PitchValue, MathRad(-80), MathRad(80))
            end

            local ViewportInputChanged
            Items["CharacterViewport"]:Connect("InputBegan", LPH_NO_VIRTUALIZE(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    IsRotating = true
                    LastPosition = Input.Position

                    if ViewportInputChanged then 
                        return
                    end
                    
                    ViewportInputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            IsRotating = false

                            ViewportInputChanged:Disconnect()
                            ViewportInputChanged = nil
                        end
                    end)
                end
            end))

            Items["CharacterViewport"]:Connect("InputChanged", LPH_NO_VIRTUALIZE(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if not LastPosition then 
                        return
                    end

                    if not IsRotating then
                        return
                    end
                    
                    local RotationDelta = Input.Position - LastPosition

                    Yaw = Yaw - MathRad(RotationDelta.X * Sensitivity)
                    Pitch = ClampPitch(Pitch - MathRad(RotationDelta.Y * Sensitivity))

                    LastPosition = Input.Position

                    if ViewportModel and ViewportModel.PrimaryPart then
                        local Rotation = CFrameAngles(Pitch, Yaw, Roll)
                        ViewportModel:SetPrimaryPartCFrame(Rotation + Vector3.new(0, 1.5, 0))
                    end
                end
            end))

            return ESPPreview
        end
        
        Library.ChatSystem = function(self, Data)
            local GlobalChat = { }

            local Items = { } do 
                Items["Chat_System"] = Instances:Create("Frame", {
                    Parent = Data.MainFrame.Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(0, -15, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 378, 0, 511),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["Chat_System"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["Chat_System"]:MakeDraggable()

                Instances:Create("UICorner", {
                    Parent = Items["Chat_System"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIStroke", {
                    Parent = Items["Chat_System"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Items["Topbar"] = Instances:Create("Frame", {
                    Parent = Items["Chat_System"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 35),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Topbar"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 3),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                }):AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    BackgroundTransparency = 0.4000000059604645,
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(32, 36, 42)
                }):AddToTheme({BackgroundColor3 = "Border"})

                Instances:Create("UIGradient", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["Logo"] = Instances:Create("ImageLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://103982381939732",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Logo"]:AddToTheme({ImageColor3 = "Accent"})

                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    AnchorPoint = Vector2New(0, 0.5),
                    ZIndex = 2,
                    TextSize = 14,
                    Size = UDim2New(0, 0, 0, 15),
                    RichText = true,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Global Chat",
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2New(0, 37, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

                Items["CloseButton"] = Instances:Create("ImageButton", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 17, 0, 17),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://76001605964586",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -7, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["CloseButton"]:AddToTheme({ImageColor3 = "Image"})

                Items["StatusCircle"] = Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, -33, 0.5, 0),
                    Size = UDim2New(0, 12, 0, 12),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 210, 62)
                })

                Instances:Create("UICorner", {
                    Parent = Items["StatusCircle"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["StatusCircle"].Instance,
                    Name = "\0",
                    Rotation = 90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["StatusText"] = Instances:Create("TextLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 210, 62),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Connecting...",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, -50, 0.5, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Glow"] = Instances:Create("ImageLabel", {
                    Parent = Items["StatusCircle"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 210, 62),
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.30000001192092896,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    Size = UDim2New(1, 8, 1, 8),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = RectNew(Vector2New(21, 21), Vector2New(79, 79))
                })

                Items["SendMessage"] = Instances:Create("Frame", {
                    Parent = Items["Chat_System"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 1, -8),
                    Size = UDim2New(1, -16, 0, 35),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  

                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["SendMessage"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    MultiLine = true,
                    CursorPosition = -1,
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    PlaceholderText = "PLEASE WAIT, CURRENTLY LOADING...",
                    TextSize = 14,
                    Size = UDim2New(1, -45, 1, 0),
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ClearTextOnFocus = false,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["Input"]:AddToTheme({BackgroundColor3 = "Element"})

                getgenv().SendMessage_Input = Items["Input"]

                Instances:Create("UICorner", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 8)
                })

                Items["SendMessageButton"] = Instances:Create("TextButton", {
                    Parent = Items["SendMessage"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 35, 1, 0),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["SendMessageButton"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("UICorner", {
                    Parent = Items["SendMessageButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Items["SendImageLabel"] = Instances:Create("ImageLabel", {
                    Parent = Items["SendMessageButton"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://93681479181206",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SendImageLabel"]:AddToTheme({ImageColor3 = "Accent"})

                Items["Messages"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["Chat_System"].Instance,
                    Name = "\0",
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0),
                    ScrollBarImageColor3 = FromRGB(196, 231, 255),
                    MidImage = "rbxassetid://76010408336709",
                    BorderColor3 = FromRGB(0, 0, 0),
                    ScrollBarThickness = 2,
                    Size = UDim2New(1, 0, 1, -80),
                    Selectable = false,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 35),
                    BottomImage = "rbxassetid://76010408336709",
                    TopImage = "rbxassetid://76010408336709",
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Messages"]:AddToTheme({ScrollBarImageColor3 = "Accent"})

                Instances:Create("UIListLayout", {
                    Parent = Items["Messages"].Instance,
                    Name = "\0",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Archivable = false,
                    Padding = UDimNew(0, 8)
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Messages"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 12),
                    PaddingLeft = UDimNew(0, 8)
                })
            end

            function GlobalChat:SetVisibility(Bool)
                Items["Chat_System"].Instance.Visible = Bool
                
                pcall(function()
                    Items["Chat_System"].Instance.Parent = Bool and Data.MainFrame.Instance or Library.UnusedHolder
                end)
            end

            local Done = false

            function GlobalChat:SetStatusText(Text)
                if not Done then
                    Items["StatusText"].Instance.TextColor3 = FromRGB(62, 255, 91)
                    Items["Glow"].Instance.ImageColor3 = FromRGB(62, 255, 91)
                    Items["StatusCircle"].Instance.BackgroundColor3 = FromRGB(62, 255, 91)
                    Done = true
                end
                Items["StatusText"].Instance.Text = Text
            end

            local OnMessagePressed            

            function GlobalChat:OnMessageSendPressed(Func)
                OnMessagePressed = Func
            end

            function GlobalChat:GetTypedMessage()
                return Items["Input"].Instance.Text
            end

            function GlobalChat:ClearText()
                Items["Input"].Instance.Text = ""
            end

            function GlobalChat:SendMessage(Avatar, Username, Message, IsLocalPlayer)
                local SubItems = { } do
                    if not IsLocalPlayer then
                        SubItems["Message1"] = Instances:Create("Frame", {
                            Parent = Items["Messages"].Instance,
                            Name = "\0",
                            BackgroundTransparency = 1,
                            Size = UDim2New(1, 0, 0, 45),
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        SubItems["PlayerName"] = Instances:Create("TextLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(255, 255, 255),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Username,
                            Size = UDim2New(0, 0, 0, 15),
                            RichText = true,
                            BackgroundTransparency = 1,
                            Position = UDim2New(0, 38, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X,
                            TextSize = 14,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["PlayerName"]:AddToTheme({TextColor3 = "Text"})

                        SubItems["RealMessage"] = Instances:Create("Frame", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            Position = UDim2New(0, 38, 0, 20),
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            BackgroundColor3 = FromRGB(22, 25, 29)
                        })  SubItems["RealMessage"]:AddToTheme({BackgroundColor3 = "Inline"})

                        Instances:Create("UISizeConstraint", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            MaxSize = Vector2New(370, 75)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })

                        SubItems["MessageText"] = Instances:Create("TextLabel", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(255, 255, 255),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Message,
                            BackgroundTransparency = 1,
                            TextWrapped = true,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            BorderSizePixel = 0,
                            TextWrapped = true,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            TextSize = 14,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["MessageText"]:AddToTheme({TextColor3 = "Text"})

                        Instances:Create("UIPadding", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 8),
                            PaddingBottom = UDimNew(0, 8),
                            PaddingRight = UDimNew(0, 8),
                            PaddingLeft = UDimNew(0, 8)
                        })

                        SubItems["Avatar"] = Instances:Create("ImageLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            BorderColor3 = FromRGB(0, 0, 0),
                            AnchorPoint = Vector2New(0, 0.5),
                            Image = Avatar,
                            BackgroundTransparency = 1,
                            Position = UDim2New(0, 0, 0.5, 0),
                            Size = UDim2New(0, 30, 0, 30),
                            BorderSizePixel = 0,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["Avatar"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })
                    else
                        SubItems["Message1"] = Instances:Create("Frame", {
                            Parent = Items["Messages"].Instance,
                            Name = "\0",
                            BackgroundTransparency = 1,
                            Size = UDim2New(1, 0, 0, 45),
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        SubItems["PlayerName"] = Instances:Create("TextLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(255, 255, 255),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Username,
                            RichText = true,
                            AnchorPoint = Vector2New(1, 0),
                            Size = UDim2New(0, 0, 0, 15),
                            BackgroundTransparency = 1,
                            Position = UDim2New(1, -38, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X,
                            TextSize = 14,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["PlayerName"]:AddToTheme({TextColor3 = "Text"})

                        SubItems["RealMessage"] = Instances:Create("Frame", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            AnchorPoint = Vector2New(1, 0),
                            Position = UDim2New(1, -38, 0, 20),
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            BackgroundColor3 = FromRGB(22, 25, 29)
                        })  SubItems["RealMessage"]:AddToTheme({BackgroundColor3 = "Inline"})

                        Instances:Create("UISizeConstraint", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            MaxSize = Vector2New(370, 75)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })

                        SubItems["MessageText"] = Instances:Create("TextLabel", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(255, 255, 255),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Message,
                            BackgroundTransparency = 1,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            TextWrapped = true,
                            TextSize = 14,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["MessageText"]:AddToTheme({TextColor3 = "Text"})

                        Instances:Create("UIPadding", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 8),
                            PaddingBottom = UDimNew(0, 8),
                            PaddingRight = UDimNew(0, 8),
                            PaddingLeft = UDimNew(0, 8)
                        })

                        SubItems["Avatar"] = Instances:Create("ImageLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            BorderColor3 = FromRGB(0, 0, 0),
                            AnchorPoint = Vector2New(1, 0.5),
                            Image = Avatar,
                            BackgroundTransparency = 1,
                            Position = UDim2New(1, 0, 0.5, 0),
                            Size = UDim2New(0, 30, 0, 30),
                            BorderSizePixel = 0,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["Avatar"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })
                    end
                end
            end

            Items["CloseButton"]:Connect("MouseButton1Down", function()
                GlobalChat:SetVisibility(false)

                if GlobalChat_Toggle then
                    GlobalChat_Toggle:Set(false)
                end
            end)
            
            Items["SendMessageButton"]:Connect("MouseButton1Down", function()
                if GlobalChat:GetTypedMessage() == "" then
                    return
                end
                
                task.spawn(OnMessagePressed)
                Items["SendMessageButton"]:Tween(nil, {BackgroundColor3 = Library:GetDarkerColor(Library.Theme.Accent)})
                task.wait(0.1)
                Items["SendMessageButton"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            end)

            Items["SendMessageButton"]:Connect("MouseEnter", function()
                Items["SendMessageButton"]:Tween(nil, {BackgroundColor3 = Library:GetDarkerColor(Library.Theme.Element)})
            end)

            Items["SendMessageButton"]:Connect("MouseLeave", function()
                Items["SendMessageButton"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            end)

            Items["Input"]:Connect("MouseEnter", function()
                Items["Input"]:Tween(nil, {BackgroundColor3 = Library:GetDarkerColor(Library.Theme.Element)})
            end)

            Items["Input"]:Connect("MouseLeave", function()
                Items["Input"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            end)

            Items["Messages"]:Connect("ChildAdded", function()
                wait() -- wait so we ensure the child is added
                Items["Messages"]:Tween(nil, {CanvasPosition = Vector2New(0, Items["Messages"].Instance.AbsoluteCanvasSize.Y - Items["Messages"].Instance.AbsoluteSize.Y)})
            end)

            return GlobalChat 
        end
        
        Library.Notification = function(self, Data)
            Data = Data or { }

            local Notification = {
                Name = Data.Name or Data.name or "Title",
                Description = Data.Description or Data.description or "Description",
                Duration = Data.Duration or Data.duration or 5,
                Icon = Data.Icon or Data.icon or "9080568477801",
                IconColor = Data.IconColor or Data.iconcolor or FromRGB(255, 255, 255),
            }

            local Items = { } do
                Items["Notification"] = Instances:Create("Frame", {
                    Parent = Library.NotifHolder.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["Notification"]:AddToTheme({BackgroundColor3 = "Background"})

                Instances:Create("UIStroke", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Instances:Create("UICorner", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })

                if Notification.Icon then 
                    Items["Icon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        ImageColor3 = Notification.IconColor,
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(1, 0),
                        Image = "rbxassetid://"..Notification.Icon,
                        BackgroundTransparency = 1,
                        Position = UDim2New(1, 5, 0, 0),
                        Size = UDim2New(0, 22, 0, 22),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                end

                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Notification.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 2),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

                Items["Description"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = Notification.Description,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 24),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Description"]:AddToTheme({TextColor3 = "Inactive Text"})
            end

            local OldSize = Items["Notification"].Instance.AbsoluteSize
            Items["Notification"].Instance.BackgroundTransparency = 1
            Items["Notification"].Instance.Size = UDim2New(0, 0, 0, 0)

            for Index, Value in Items["Notification"].Instance:GetDescendants() do
                if Value:IsA("UIStroke") then 
                    Value.Transparency = 1
                elseif Value:IsA("TextLabel") then 
                    Value.TextTransparency = 1
                elseif Value:IsA("ImageLabel") then 
                    Value.ImageTransparency = 1
                elseif Value:IsA("Frame") then 
                    Value.BackgroundTransparency = 1
                end
            end
            
            task.wait(0.2)

            Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.None

            Library:Thread(function()
                Items["Notification"]:Tween(nil, {BackgroundTransparency = 0, Size = UDim2New(0,  OldSize.X, 0, OldSize.Y)})
                
                task.wait(0.06)

                for Index, Value in Items["Notification"].Instance:GetDescendants() do
                    if Value:IsA("UIStroke") then
                        Tween:Create(Value, nil, {Transparency = 0}, true)
                    elseif Value:IsA("TextLabel") then
                        Tween:Create(Value, nil, {TextTransparency = 0}, true)
                    elseif Value:IsA("ImageLabel") then
                        Tween:Create(Value, nil, {ImageTransparency = 0}, true)
                    elseif Value:IsA("Frame") then
                        Tween:Create(Value, nil, {BackgroundTransparency = 0}, true)
                    end
                end

                task.delay(Data.Duration, function()
                    for Index, Value in Items["Notification"].Instance:GetDescendants() do
                        if Value:IsA("UIStroke") then
                            Tween:Create(Value, nil, {Transparency = 1}, true)
                        elseif Value:IsA("TextLabel") then
                            Tween:Create(Value, nil, {TextTransparency = 1}, true)
                        elseif Value:IsA("ImageLabel") then
                            Tween:Create(Value, nil, {ImageTransparency = 1}, true)
                        elseif Value:IsA("Frame") then
                            Tween:Create(Value, nil, {BackgroundTransparency = 1}, true)
                        end
                    end

                    task.wait(0.06)

                    Items["Notification"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(0, 0, 0, 0)})

                    task.wait(0.5)
                    Items["Notification"]:Clean()
                end)
            end)

            return Notification
        end

        Library.Watermark = function(self, Text, Logo)
            local Watermark = { }

            local Items = { } do
                Items["Watermark"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0),
                    Position = UDim2New(0.5, 0, 0, 15),
                    Size = UDim2New(0, 100, 0, 35),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["Watermark"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["Watermark"]:MakeDraggable()

                Instances:Create("UIGradient", {
                    Parent = Items["Watermark"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Instances:Create("UICorner", {
                    Parent = Items["Watermark"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                --[[Items["Logo"] = Instances:Create("ImageLabel", {
                    Parent = Items["Watermark"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 22, 0, 22),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://"..Logo,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 7, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Logo"]:AddToTheme({ImageColor3 = "Accent"})]]

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Watermark"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Text,
                    RichText = true,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UIPadding", {
                    Parent = Items["Watermark"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 7)
                })
            end

            function Watermark:SetVisibility(Bool)
                Items["Watermark"].Instance.Visible = Bool
            end

            function Watermark:SetText(Text)
                Items["Text"].Instance.Text = Text
            end

            return Watermark 
        end

        Library.KeybindsList = function(self)
            local KeybindList = { }
            self.KeyList = KeybindList

            local Items = { } do
                Items["KeybindsList"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 15, 0.5, 85),
                    Size = UDim2New(0, 100, 0, 100),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["KeybindsList"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["KeybindsList"]:MakeDraggable()

                Instances:Create("UICorner", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Image = "rbxassetid://89224403789635",
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 22, 0, 22),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Accent"})  

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "keybinds",
                    Size = UDim2New(0, 0, 0, 15),
                    Position = UDim2New(0, 28, 0, 3),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UIPadding", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })

                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 28),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function KeybindList:Add(Key, Name)
                local NewKey = Instances:Create("TextLabel", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = "(" .. Key .. ") - ".. Name .. "",
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  NewKey:AddToTheme({TextColor3 = "Text"})

                local NewKeyStatus = Instances:Create("TextLabel", {
                    Parent = NewKey.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = "off",
                    Size = UDim2New(0, 0, 0, 20),
                    AnchorPoint = Vector2New(1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 50, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  NewKeyStatus:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UIPadding", {
                    Parent = NewKey.Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 50)
                })

                function NewKey:SetText(Key, Name)
                    NewKey.Instance.Text =  "(" .. Key .. ") - ".. Name .. ""
                end

                function NewKey:SetStatus(Status)
                    NewKeyStatus.Instance.Text = Status
                end

                function NewKey:Remove()
                    NewKey:Clean()
                end

                function NewKey:SetVisibility(Bool)
                    NewKey.Instance.Visible = Bool
                end

                function NewKey:Set(Bool)
                    if Bool then 
                        NewKey:Tween(nil, {TextTransparency = 0})
                        NewKeyStatus:Tween(nil, {TextTransparency = 0})
                    else 
                        NewKey:Tween(nil, {TextTransparency = 0.5})
                        NewKeyStatus:Tween(nil, {TextTransparency = 0.5})
                    end
                end

                return NewKey
            end

            function KeybindList:SetVisibility(Bool)
                Items["KeybindsList"].Instance.Visible = Bool
            end

            return KeybindList
        end 

        Library.Window = function(self, Data)
            Data = Data or { }

            local Window = {
                Name = Data.Name or Data.name or "kiwisense",
                Logo = Data.Logo or Data.logo or "135215559087473",
                FadeSpeed = Data.FadeSpeed or Data.fadespeed or 0.2,
                Version = Data.Version or Data.version or "v1.0.0 alpha",
                Size = not IsMobile and UDim2New(0, 659, 0, 511) or UDim2New(0, 511, 0, 459),

                Pages = { },
                SubPages = { },

                Items = { },
                IsOpen = false
            }

            local Items = { } do
                Items["MainFrame"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0),
                    Position = UDim2New(0, Camera.ViewportSize.X / 3.5, 0, Camera.ViewportSize.Y / 3.5),
                    Size = Window.Size,
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    Visible = false,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["MainFrame"]:MakeDraggable()
                Items["MainFrame"]:MakeResizeable(Vector2New(Window.Size.X.Offset, Window.Size.Y.Offset), Vector2New(9999, 9999))

                Instances:Create("UICorner", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["Pages"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0),
                    BorderSizePixel = 0,
                    Position = UDim2New(0.5, 0, 1, 8),
                    Size = UDim2New(0, 0, 0, 45),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["Pages"]:AddToTheme({BackgroundColor3 = "Background"})

                Instances:Create("UICorner", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })

                Items["Holder"] = Instances:Create("Frame", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items["Shadow"] = Instances:Create("ImageLabel", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(0, 0, 0),
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 25, 1, 25),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    SliceCenter = RectNew(Vector2New(21, 21), Vector2New(79, 79))
                })  Items["Shadow"]:AddToTheme({ImageColor3 = "Shadow"})

                Items["Topbar"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 35),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Topbar"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 3),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                }):AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    BackgroundTransparency = 0.4,
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(32, 36, 42)
                }):AddToTheme({BackgroundColor3 = "Border"})

                Instances:Create("UIGradient", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                --[[Items["Logo"] = Instances:Create("ImageLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 22, 0, 22),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://"..Window.Logo,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 7, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Logo"]:AddToTheme({ImageColor3 = "Accent"})]]

                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    AnchorPoint = Vector2New(0, 0.5),
                    ZIndex = 2,
                    TextSize = 14,
                    Size = UDim2New(0, 0, 0, 15),
                    RichText = true,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Window.Name,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2New(0, 10, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

                Items["Version"] = Instances:Create("Frame", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 0, 0, 15),
                    Position = UDim2New(1, 5, 0, 1),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["Version"]:AddToTheme({BackgroundColor3 = "Background"})

                Instances:Create("UIPadding", {
                    Parent = Items["Version"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 5),
                    PaddingLeft = UDimNew(0, 6)
                })

                Items["VersionText"] = Instances:Create("TextLabel", {
                    Parent = Items["Version"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = Window.Version,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    Position = UDim2New(0, -2, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["VersionText"]:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UICorner", {
                    Parent = Items["Version"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIStroke", {
                    Parent = Items["Version"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Instances:Create("UIPadding", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 0)
                })

                Items["CloseButton"] = Instances:Create("ImageButton", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 17, 0, 17),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://76001605964586",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -7, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["CloseButton"]:AddToTheme({ImageColor3 = "Image"})

                Items["MinimizeButton"] = Instances:Create("ImageButton", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 17, 0, 17),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://94817928404736",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -27, 0.5, -5),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["MinimizeButton"]:AddToTheme({ImageColor3 = "Image"})

                Items["UnMinimizeButton"] = Instances:Create("ImageButton", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 17, 0, 17),
                    ImageTransparency = 1,
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://77419631183448",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -27, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["UnMinimizeButton"]:AddToTheme({ImageColor3 = "Image"})

                Instances:Create("UIStroke", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 35),
                    Size = UDim2New(1, 0, 1, -35),
                    ClipsDescendants = true,
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Search"] = Instances:Create("Frame", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 250, 0, 32),
                    Position = UDim2New(0, 8, 0, 8),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Search"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UIGradient", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Instances:Create("UICorner", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIStroke", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    Color = FromRGB(32, 36, 42),
                    Transparency = 0.4000000059604645,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Items["SearchIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    ScaleType = Enum.ScaleType.Fit,
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 20, 0, 20),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://71924825350727",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SearchIcon"]:AddToTheme({ImageColor3 = "Image"})

                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    AnchorPoint = Vector2New(0, 0.5),
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    PlaceholderText = "search",
                    TextSize = 14,
                    Size = UDim2New(1, -45, 0, 15),
                    ClipsDescendants = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    ZIndex = 2,
                    Position = UDim2New(0, 35, 0.5, -2),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextColor3 = FromRGB(255, 255, 255),
                    ClearTextOnFocus = false,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Input"]:AddToTheme({TextColor3 = "Text", PlaceholderColor3 = "Inactive Text"})

                if IsMobile then 
                    Items["FloatingButton"] = Instances:Create("TextButton", {
                        Parent = Library.Holder.Instance,
                        Text = "",
                        AutoButtonColor = false,
                        Name = "\0",
                        Position = UDim2New(0, 125, 0, 125),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 50, 0, 50),
                        BorderSizePixel = 0,
                        ZIndex = 127,
                        BackgroundColor3 = Library.Theme.Background
                    })  Items["FloatingButton"]:AddToTheme({BackgroundColor3 = "Background"})

                    Items["FloatingButton"]:MakeDraggable()

                    Instances:Create("ImageLabel", {
                        Parent = Items["FloatingButton"].Instance,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Name = "\0",
                        Image = "rbxassetid://" .. Window.Logo,
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        ZIndex = 127,
                        Size = UDim2New(1, -25, 1, -25),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })

                    Instances:Create("UICorner", {
                        Parent = Items["FloatingButton"].Instance,
                        CornerRadius = UDimNew(1, 0)
                    }) 

                    Items["FloatingButton"]:Connect("InputBegan", function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            Window:SetOpen(not Window.IsOpen)
                        end
                    end)
                end
            end

            local Debounce = false 
            local OldSizes = { }

            function Window:AddToOldSizes(Item, Size)
                if not OldSizes[Item] then
                    OldSizes[Item] = Size
                end
            end

            function Window:GetOldSize(Item)
                if OldSizes[Item] then
                    return OldSizes[Item]
                end
            end

            Window.SetOpen = LPH_NO_VIRTUALIZE(function(Self, Bool)
                if Debounce then 
                    return 
                end

                Window.IsOpen = Bool

                Debounce = true

                if Bool then 
                    Items["MainFrame"].Instance.Visible = true
                end

                local Descendants = Items["MainFrame"].Instance:GetDescendants()
                TableInsert(Descendants, Items["MainFrame"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then 
                        continue
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Window.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Window.FadeSpeed)
                    end
                end

                Library:Connect(NewTween.Tween.Completed, function()
                    Debounce = false
                    Items["MainFrame"].Instance.Visible = Bool
                end)
            end)

            function Window:SetText(Text)
                Items["Title"].Instance.Text = Text
            end

            Library:Connect(UserInputService.InputBegan, LPH_NO_VIRTUALIZE(function(Input, GameProcessedEvent)
                if GameProcessedEvent then 
                    return 
                end

                if tostring(Input.KeyCode) == Library.MenuKeybind 
                or tostring(Input.UserInputType) == Library.MenuKeybind then
                    Window:SetOpen(not Window.IsOpen)
                end
            end))

            local RenderStepped

            Items["Input"]:Connect("Focused", LPH_NO_VIRTUALIZE(function()
                local PageSearchData = Library.SearchItems[Library.CurrentPage]

                if not PageSearchData then
                    return 
                end

                RenderStepped = RunService.RenderStepped:Connect(function()
                    for Index, Value in PageSearchData do 
                        local Name = Value.Name
                        local Element = Value.Item

                        if StringFind(StringLower(Name), StringLower(Items["Input"].Instance.Text)) then
                            if Items["Input"].Instance.Text ~= "" then 
                                Element.Instance.Visible  = true 
                                Element:Tween(nil, {Size = Window:GetOldSize(Element)})
                            else
                                Element.Instance.Visible  = true 
                                Element:Tween(nil, {Size = Window:GetOldSize(Element)})
                            end
                        else
                            Window:AddToOldSizes(Element, Element.Instance.Size)
                            Element:Tween(nil, {Size = UDim2New(Window:GetOldSize(Element).X.Scale, Window:GetOldSize(Element).X.Offset, 0, 0)})
                            task.wait(0.1)
                            Element.Instance.Visible = false
                        end
                    end
                end)
            end))

            Items["Input"]:Connect("FocusLost", LPH_NO_VIRTUALIZE(function()
                if RenderStepped then 
                    RenderStepped:Disconnect()
                    RenderStepped = nil
                end
            end))
            
            local IsMinimized = false
            local OldSize = Items["MainFrame"].Instance.AbsoluteSize

            Items["MinimizeButton"]:Connect("MouseButton1Down", LPH_NO_VIRTUALIZE(function()
                IsMinimized = not IsMinimized

                if IsMinimized then
                    OldSize = Items["MainFrame"].Instance.AbsoluteSize
                    Items["MainFrame"]:Tween(nil, {Size = UDim2New(0, Items["MainFrame"].Instance.Size.X.Offset, 0, 35)})
                    Items["MinimizeButton"]:Tween(nil, {ImageTransparency = 1})
                    Items["UnMinimizeButton"]:Tween(nil, {ImageTransparency = 0})
                else
                    Items["MainFrame"]:Tween(nil, {Size = UDim2New(0, Items["MainFrame"].Instance.Size.X.Offset, 0, OldSize.Y)})
                    Items["MinimizeButton"]:Tween(nil, {ImageTransparency = 0})
                    Items["UnMinimizeButton"]:Tween(nil, {ImageTransparency = 1})
                end
            end))

            Items["CloseButton"]:Connect("MouseButton1Down", function()
                Window:SetOpen(false)
                task.wait(0.1)
                Library:Unload()
            end)

            Window.Items = Items

            Window:SetOpen(true)
            return setmetatable(Window, self)
        end

        Library.Page = function(self, Data)
            Data = Data or { }

            local Page = {
                Window = self,

                Name = Data.Name or Data.name or "combat",
                Icon = Data.Icon or Data.icon or "111178525804834",
                Columns = Data.Columns or Data.columns or 2,
                SubPages = Data.SubPages or Data.subpages or false,

                Active = false,

                Items = { },
                ColumnsData =  { },

                SubPagesStack = { }
            }

            if type(Page.Icon) == "string" and not string.find(Page.Icon, not Volcano and ".png" or "rbxasset://") then
                Page.Icon = "rbxassetid://"..Page.Icon
            end

            Library.SearchItems[Page] = { }

            local Items = { } do
                Items["PageContent"] = Instances:Create("Frame", {
                    Parent = Page.Window.Items["Content"].Instance,
                    Name = "\0",
                    Visible = false,
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Columns"] = Instances:Create("Frame", {
                    Parent = Items["PageContent"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 7, 0, 48),
                    Size = UDim2New(1, -14, 1, -55),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Columns"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDimNew(0, 14),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })

                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Page.Window.Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 32),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(23, 26, 30)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })

                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 22, 0, 22),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = Page.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 5, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Image"})

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    Visible = false,
                    Active = true,
                    AnchorPoint = Vector2New(0, 0.5),
                    ZIndex = 2,
                    TextSize = 14,
                    Size = UDim2New(0, 0, 0, 15),
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Page.Name,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 32, 0.5, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UIPadding", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 7)
                })

                if not Page.SubPages then
                    for Index = 1, Page.Columns do 
                        local NewColumn = Instances:Create("ScrollingFrame", {
                            Parent = Items["Columns"].Instance,
                            Name = "\0",
                            ScrollBarImageColor3 = FromRGB(0, 0, 0),
                            Active = true,
                            AutomaticCanvasSize = Enum.AutomaticSize.Y,
                            ScrollBarThickness = 0,
                            BorderColor3 = FromRGB(0, 0, 0),
                            BackgroundTransparency = 1,
                            Size = UDim2New(0, 100, 0, 100),
                            BackgroundColor3 = FromRGB(255, 255, 255),
                            ZIndex = 2,
                            BorderSizePixel = 0,
                            CanvasSize = UDim2New(0, 0, 0, 0)
                        })

                        Instances:Create("UIPadding", {
                            Parent = NewColumn.Instance,
                            Name = "\0",
                            PaddingBottom = UDimNew(0, 8)
                        })

                        Instances:Create("UIListLayout", {
                            Parent = NewColumn.Instance,
                            Name = "\0",
                            Padding = UDimNew(0, 14),
                            SortOrder = Enum.SortOrder.LayoutOrder
                        })
                        
                        Page.ColumnsData[Index] = NewColumn
                    end
                end

                if Page.SubPages then 
                    Items["Columns"].Instance.Size = UDim2New(1, -14, 1, -108)

                    Items["SubPages"] = Instances:Create("Frame", {
                        Parent = Items["PageContent"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0.5, 1),
                        BorderSizePixel = 0,
                        Position = UDim2New(0.5, 0, 1, -8),
                        Size = UDim2New(0, 0, 0, 45),
                        ZIndex = 2,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = FromRGB(22, 25, 29)
                    })  Items["SubPages"]:AddToTheme({BackgroundColor3 = "Inline"})

                    Instances:Create("UICorner", {
                        Parent = Items["SubPages"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(1, 0)
                    })

                    Items["Holder"] = Instances:Create("Frame", {
                        Parent = Items["SubPages"].Instance,
                        Name = "\0",
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 0, 1, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })

                    Instances:Create("UIPadding", {
                        Parent = Items["Holder"].Instance,
                        Name = "\0",
                        PaddingRight = UDimNew(0, 8),
                        PaddingLeft = UDimNew(0, 8)
                    })

                    Instances:Create("UIListLayout", {
                        Parent = Items["Holder"].Instance,
                        Name = "\0",
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDimNew(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                end

                Items["Inactive"].Instance.Size = UDim2New(0, 25, 0, 32)
            end

            local Debounce = false

            Page.Switch = LPH_NO_VIRTUALIZE(function(Self, Bool)
                if Debounce then 
                    return 
                end

                Page.Active = Bool
                Items["PageContent"].Instance.Visible = Bool
                Items["PageContent"].Instance.Parent = Bool and Page.Window.Items["Content"].Instance or Library.UnusedHolder.Instance
                
                Debounce = true 

                if Bool then
                    Items["Text"].Instance.Visible = true 
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0, Size = UDim2New(0, Items["Text"].Instance.TextBounds.X + 38, 0, 32)})
                    Items["Icon"]:ChangeItemTheme({ImageColor3 = "Accent"})
                    Items["Icon"]:Tween(nil, {ImageColor3 = Library.Theme.Accent, ImageTransparency = 0})

                    Library.CurrentPage = Page
                else
                    Items["Text"].Instance.Visible = false 
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(0, 25, 0, 32)})
                    Items["Icon"]:ChangeItemTheme({ImageColor3 = "Image"})
                    Items["Icon"]:Tween(nil, {ImageColor3 = Library.Theme.Image, ImageTransparency = 0.5}) 
                end

                local Descendants = Items["PageContent"].Instance:GetDescendants()
                TableInsert(Descendants, Items["PageContent"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then 
                        continue
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Page.Window.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Page.Window.FadeSpeed)
                    end
                end

                Library:Connect(NewTween.Tween.Completed, function()
                    Debounce = false
                end)
            end)

            Items["Inactive"]:Connect("MouseButton1Down", LPH_NO_VIRTUALIZE(function()
                for Index, Value in Page.Window.Pages do
                    Value:Switch(Value == Page)
                end

                if Page.SubPages then
                    --[[for Index, Value in Page.SubPages do
                        Value:Switch(Value == SubPage)
                    end]]
                end
            end))

            if #Page.Window.Pages == 0 then 
                Page:Switch(true)
            end

            Page.Items = Items
            TableInsert(Page.Window.Pages, Page)
            return setmetatable(Page, Library.Pages)
        end

        Library.Pages.SubPage = function(self, Data)
            Data = Data or { }

            local SubPage = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "SubPage",
                Icon = Data.Icon or Data.icon or "9080568477801",
                Columns = Data.Columns or Data.columns or 2,
                
                Items = { },
                ColumnsData = { }
            }

            Library.SearchItems[SubPage] = { }

            if type(SubPage.Icon) == "string" and not string.find(SubPage.Icon, not Volcano and ".png" or "rbxasset://") then
                SubPage.Icon = "rbxassetid://"..SubPage.Icon
            end

            local Items = { } do
                Items["PageContent"] = Instances:Create("Frame", {
                    Parent = SubPage.Page.Items["Columns"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 2,
                    Size = UDim2New(1, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    Visible = false,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["PageContent"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDimNew(0, 14),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })

                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = SubPage.Page.Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 32),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Background"})

                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })

                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 22, 0, 22),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = SubPage.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 5, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Image"})

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    Visible = false,
                    Active = true,
                    AnchorPoint = Vector2New(0, 0.5),
                    ZIndex = 2,
                    TextSize = 14,
                    Size = UDim2New(0, 0, 0, 15),
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = SubPage.Name,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 32, 0.5, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UIPadding", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 7)
                })

                for Index = 1, SubPage.Columns do 
                    local NewColumn = Instances:Create("ScrollingFrame", {
                        Parent = Items["PageContent"].Instance,
                        Name = "\0",
                        ScrollBarImageColor3 = FromRGB(0, 0, 0),
                        Active = true,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ScrollBarThickness = 0,
                        BorderColor3 = FromRGB(0, 0, 0),
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 100, 0, 100),
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        CanvasSize = UDim2New(0, 0, 0, 0)
                    })

                    Instances:Create("UIPadding", {
                        Parent = NewColumn.Instance,
                        Name = "\0",
                        PaddingBottom = UDimNew(0, 8)
                    })

                    Instances:Create("UIListLayout", {
                        Parent = NewColumn.Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 14),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    
                    SubPage.ColumnsData[Index] = NewColumn
                end
            end

            local Debounce = false

            SubPage.Switch = LPH_NO_VIRTUALIZE(function(Self, Bool)
                if Debounce then 
                    return 
                end

                SubPage.Active = Bool
                Items["PageContent"].Instance.Visible = Bool
                Items["PageContent"].Instance.Parent = Bool and SubPage.Page.Items["Columns"].Instance or Library.UnusedHolder.Instance
                
                Debounce = true 

                if Bool then
                    Items["Text"].Instance.Visible = true 
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0, Size = UDim2New(0, Items["Text"].Instance.TextBounds.X + 38, 0, 32)})
                    Items["Icon"]:ChangeItemTheme({ImageColor3 = "Accent"})
                    Items["Icon"]:Tween(nil, {ImageColor3 = Library.Theme.Accent, ImageTransparency = 0}) 

                    Library.CurrentPage = SubPage
                else
                    Items["Text"].Instance.Visible = false 
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(0, 25, 0, 32)})
                    Items["Icon"]:ChangeItemTheme({ImageColor3 = "Image"})
                    Items["Icon"]:Tween(nil, {ImageColor3 = Library.Theme.Image, ImageTransparency = 0.5}) 
                end

                local Descendants = Items["PageContent"].Instance:GetDescendants()
                TableInsert(Descendants, Items["PageContent"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then 
                        continue
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, SubPage.Window.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, SubPage.Window.FadeSpeed)
                    end
                end

                Library:Connect(NewTween.Tween.Completed, function()
                    Debounce = false
                end)
            end)

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in SubPage.Page.SubPagesStack do
                    Value:Switch(Value == SubPage)
                end
            end)

            if #SubPage.Page.SubPagesStack == 0 then 
                SubPage:Switch(true)
            end

            SubPage.Items = Items
            TableInsert(SubPage.Page.SubPagesStack, SubPage)
            return setmetatable(SubPage, Library.Pages)
        end

        Library.Pages.Playerlist = function(self, Data)
            local Playerlist = {
                Window = self.Window,
                Page = self,

                CurrentPlayer = nil,

                Players = { }
            }

            local Dropdown

            local Items = { } do
                Playerlist.Page.Items.Columns.Instance:FindFirstChildOfClass("UIListLayout"):Destroy()

                Items["Playerlist"] = Instances:Create("Frame", {
                    Parent = Playerlist.Page.Items["PageContent"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Playerlist"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = Items["Playerlist"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["PlayerlistInline"] = Instances:Create("Frame", {
                    Parent = Items["Playerlist"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, -16, 1, -90),
                    Position = UDim2New(0, 8, 0, 8),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["PlayerlistInline"]:AddToTheme({BackgroundColor3 = "Background"})

                Instances:Create("UICorner", {
                    Parent = Items["PlayerlistInline"].Instance,
                    Name = "\0",    
                    CornerRadius = UDimNew(0, 5)
                })

                Items["PlayerHolder"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["PlayerlistInline"].Instance,
                    Name = "\0",
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0),
                    ScrollBarImageColor3 = FromRGB(32, 36, 42),
                    MidImage = "rbxassetid://107505658214891",
                    BorderColor3 = FromRGB(0, 0, 0),
                    ScrollBarThickness = 2,
                    Size = UDim2New(1, -8, 1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 4, 0, 4),
                    BottomImage = "rbxassetid://107505658214891",
                    TopImage = "rbxassetid://107505658214891",
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["PlayerHolder"]:AddToTheme({ScrollBarImageColor3 = "Border"})

                Instances:Create("UIListLayout", {
                    Parent = Items["PlayerHolder"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UIPadding", {
                    Parent = Items["PlayerHolder"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 4),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 4)
                })

                Items["PlayerAvatar"] = Instances:Create("ImageLabel", {
                    Parent = Items["Playerlist"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 50, 0, 50),
                    AnchorPoint = Vector2New(0, 1),
                    Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
                    Position = UDim2New(0, 8, 1, -15),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 21)
                })  Items["PlayerAvatar"]:AddToTheme({BackgroundColor3 = "Background"})

                Instances:Create("UICorner", {
                    Parent = Items["PlayerAvatar"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["PlayerUsername"] = Instances:Create("TextLabel", {
                    Parent = Items["Playerlist"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "?",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 65, 1, -65),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["PlayerUsername"]:AddToTheme({TextColor3 = "Text"})

                Items["PlayerUserID"] = Instances:Create("TextLabel", {
                    Parent = Items["Playerlist"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "?",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 65, 1, -50),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["PlayerUserID"]:AddToTheme({TextColor3 = "Text"})

                Items["PlayerAccountAge"] = Instances:Create("TextLabel", {
                    Parent = Items["Playerlist"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "?",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 65, 1, -35),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["PlayerAccountAge"]:AddToTheme({TextColor3 = "Text"})
            end

            do
                local DropdownItems = { } do
                    DropdownItems["Dropdown"] = Instances:Create("Frame", {
                        Parent = Items["Playerlist"].Instance,
                        Name = "\0",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(1, 1),
                        Size = UDim2New(0, 235, 0, 47),
                        Position = UDim2New(1, -8, 1, -20),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })

                    DropdownItems["Text"] = Instances:Create("TextLabel", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "Status",
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 0, 0, 15),
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["Text"]:AddToTheme({TextColor3 = "Text"})

                    DropdownItems["RealDropdown"] = Instances:Create("TextButton", {
                        Parent = DropdownItems["Dropdown"].Instance,
                        Text = "", 
                        AutoButtonColor = false,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        Position = UDim2New(0, 0, 1, 0),
                        Size = UDim2New(1, 0, 0, 25),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(34, 39, 45)
                    })  DropdownItems["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})

                    Instances:Create("UIGradient", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        Rotation = 84,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                    end})

                    Instances:Create("UICorner", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })

                    DropdownItems["Value"] = Instances:Create("TextLabel", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "--",
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2New(0, 0, 0, 15),
                        AnchorPoint = Vector2New(0, 0.5),
                        Position = UDim2New(0, 8, 0.5, 0),
                        BackgroundTransparency = 1,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["Value"]:AddToTheme({TextColor3 = "Text"})

                    DropdownItems["OpenIcon"] = Instances:Create("ImageLabel", {
                        Parent = DropdownItems["RealDropdown"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(196, 231, 255),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 20, 0, 20),
                        AnchorPoint = Vector2New(1, 0.5),
                        Image = "rbxassetid://114252321536924",
                        BackgroundTransparency = 1,
                        Position = UDim2New(1, -3, 0.5, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  DropdownItems["OpenIcon"]:AddToTheme({ImageColor3 = "Accent"})

                    DropdownItems["OptionHolder"] = Instances:Create("TextButton", {
                        Parent = Library.Holder.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        Visible = false,
                        AutoButtonColor = false,
                        Size = UDim2New(1, 0, 0, 50),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Position = UDim2New(0, 0, 1, 5),
                        BorderSizePixel = 0,
                        ZIndex = 5,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(22, 25, 29)
                    })  DropdownItems["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})

                    Instances:Create("UIGradient", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Rotation = 84,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                    end})

                    Instances:Create("UIStroke", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Color = FromRGB(32, 36, 42),
                        Transparency = 0.4000000059604645,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):AddToTheme({Color = "Border"})

                    Instances:Create("UICorner", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 5)
                    })

                    Instances:Create("UIListLayout", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 2),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Instances:Create("UIPadding", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        PaddingTop = UDimNew(0, 8),
                        PaddingBottom = UDimNew(0, 8),
                        PaddingRight = UDimNew(0, 8),
                        PaddingLeft = UDimNew(0, 8)
                    })

                    DropdownItems["RealDropdown"]:OnHover(function()
                        DropdownItems["RealDropdown"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
                    end)
        
                    DropdownItems["RealDropdown"]:OnHoverLeave(function()
                        DropdownItems["RealDropdown"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                    end)
                end

                Dropdown = { 
                    IsOpen = false,
                    Value = { },
                    Options = { },
                    Multi = false
                }

                function Dropdown:AddOption(Option)
                    local OptionButton = Instances:Create("TextButton", {
                        Parent = DropdownItems["OptionHolder"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2New(1, 0, 0, 25),
                        ZIndex = 5,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(16, 18, 21)
                    })  OptionButton:AddToTheme({BackgroundColor3 = "Background"})

                    local CheckImage = Instances:Create("ImageLabel", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(196, 231, 255),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 18, 0, 18),
                        Visible = true,
                        AnchorPoint = Vector2New(0, 0.5),
                        Image = "rbxassetid://116339777575852",
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 3, 0.5, 0),
                        ImageTransparency = 1,
                        ZIndex = 5,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  CheckImage:AddToTheme({ImageColor3 = "Accent"})

                    Instances:Create("UICorner", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 5)
                    })

                    local OptionText = Instances:Create("TextLabel", {
                        Parent = OptionButton.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextTransparency = 0.5,
                        AnchorPoint = Vector2New(0, 0.5),
                        ZIndex = 5,
                        TextSize = 14,
                        Size = UDim2New(0, 0, 0, 15),
                        TextColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = Option,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Position = UDim2New(0, 7, 0.5, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  OptionText:AddToTheme({TextColor3 = "Text"})

                    local OptionData = {
                        Selected = false,
                        Name = Option,
                        Text = OptionText,
                        Button = OptionButton,
                        Check = CheckImage
                    }

                    function OptionData:Toggle(Status)
                        if Status == "Active" then 
                            OptionData.Button:Tween(nil, {BackgroundTransparency = 0})
                            OptionData.Text:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 27, 0.5, 0)})
                            OptionData.Check:Tween(nil, {ImageTransparency = 0})
                        elseif Status == "Inactive" then
                            OptionData.Button:Tween(nil, {BackgroundTransparency = 1})
                            OptionData.Text:Tween(nil, {TextTransparency = 0.5, Position = UDim2New(0, 7, 0.5, 0)})
                            OptionData.Check:Tween(nil, {ImageTransparency = 1})
                        end
                    end

                    function OptionData:Set()
                        OptionData.Selected = not OptionData.Selected

                        if Dropdown.Multi then 
                            local Index = TableFind(Dropdown.Value, OptionData.Name)

                            if Index then 
                                TableRemove(Dropdown.Value, Index)
                            else
                                TableInsert(Dropdown.Value, OptionData.Name)
                            end

                            OptionData:Toggle(Index and "Inactive" or "Active")

                            local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "--"

                            DropdownItems["Value"].Instance.Text = TextFormat
                        else
                            if OptionData.Selected then 
                                Dropdown.Value = OptionData.Name

                                OptionData:Toggle("Active")

                                for Index, Value in Dropdown.Options do 
                                    if Value ~= OptionData then
                                        Value.Selected = false 
                                        Value:Toggle("Inactive")
                                    end
                                end

                                DropdownItems["Value"].Instance.Text = OptionData.Name 
                            else
                                Dropdown.Value = nil

                                OptionData:Toggle("Inactive")
                                DropdownItems["Value"].Instance.Text = "--"
                            end
                        end

                        if Dropdown.Callback then 
                            Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                        end
                    end

                    OptionData.Button:Connect("MouseButton1Down", function()
                        OptionData:Set()
                    end)

                    Dropdown.Options[Option] = OptionData
                    return OptionData
                end

                local Debounce = false 
                local RenderStepped

                function Dropdown:SetOpen(Bool)
                    if Debounce then 
                        return 
                    end

                    Dropdown.IsOpen = Bool

                    Debounce = true

                    if Bool then 
                        DropdownItems["OptionHolder"].Instance.Visible = true

                        RenderStepped = RunService.RenderStepped:Connect(function()
                            DropdownItems["OptionHolder"].Instance.Position = UDim2New(0, DropdownItems["RealDropdown"].Instance.AbsolutePosition.X, 0,  DropdownItems["RealDropdown"].Instance.AbsolutePosition.Y + DropdownItems["RealDropdown"].Instance.AbsoluteSize.Y + 5)
                            DropdownItems["OptionHolder"].Instance.Size = UDim2New(0, DropdownItems["RealDropdown"].Instance.AbsoluteSize.X, 0, 85)
                        end)
                    else
                        if RenderStepped then
                            RenderStepped:Disconnect()
                            RenderStepped = nil
                        end
                    end

                    local Descendants = DropdownItems["OptionHolder"].Instance:GetDescendants()
                    TableInsert(Descendants, DropdownItems["OptionHolder"].Instance)

                    local NewTween

                    for Index, Value in Descendants do 
                        local TransparencyProperty = Tween:GetProperty(Value)

                        if not TransparencyProperty then 
                            continue
                        end

                        if StringFind(Value.ClassName, "UI") then
                            continue
                        end

                        Value.ZIndex = Bool and 10 or 0

                        if type(TransparencyProperty) == "table" then 
                            for _, Property in TransparencyProperty do 
                                NewTween = Tween:FadeItem(Value, Property, Bool, Playerlist.Window.FadeSpeed)
                            end
                        else
                            NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Playerlist.Window.FadeSpeed)
                        end
                    end

                    Library:Connect(NewTween.Tween.Completed, function()
                        Debounce = false
                        DropdownItems["OptionHolder"].Instance.Visible = Bool
                    end)
                end

                function Dropdown:Set(Option)
                    if Dropdown.Multi then
                        if type(Option) ~= "table" then
                            return
                        end

                        Dropdown.Value = Option
                        Library.Flags[Dropdown.Flag] = Option

                        for Index, Value in Option do 
                            local OptionData = Dropdown.Options[Value]
                                
                            if not OptionData then 
                                return
                            end

                            OptionData.Selected = true
                            OptionData:Toggle("Active")
                        end

                        DropdownItems["Value"].Instance.Text = TableConcat(Option, ", ")
                    else
                        if not Dropdown.Options[Option] then 
                            return
                        end

                        local OptionData = Dropdown.Options[Option]

                        Dropdown.Value = OptionData.Name
                        Library.Flags[Dropdown.Flag] = OptionData.Name

                        for Index, Value in Dropdown.Options do 
                            if Value ~= OptionData then
                                Value.Selected = false 
                                Value:Toggle("Inactive")
                            else
                                Value.Selected = true 
                                Value:Toggle("Active")
                            end
                        end

                        DropdownItems["Value"].Instance.Text = OptionData.Name
                    end

                    if Dropdown.Callback then 
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end
                end

                DropdownItems["RealDropdown"]:Connect("MouseButton1Down", function()
                    Dropdown:SetOpen(not Dropdown.IsOpen)
                end)

                Dropdown:AddOption("Neutral")
                Dropdown:AddOption("Priority")
                Dropdown:AddOption("Friendly")
            end

            function Playerlist:Add(Player)
                local PlayerItems = { }

                PlayerItems["NewPlayer"] = Instances:Create("TextButton", {
                    Parent = Items["PlayerHolder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    ZIndex = 2,
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(22, 25, 24)
                })  PlayerItems["NewPlayer"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = PlayerItems["NewPlayer"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })

                PlayerItems["Name"] = Instances:Create("TextLabel", {
                    Parent = PlayerItems["NewPlayer"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.4000000059604645,
                                        ZIndex = 2,
                    Text = Player.Name,
                    Size = UDim2New(0.3499999940395355, 0, 0, 15),
                    Position = UDim2New(0, 10, 0.5, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                PlayerItems["Status"] = Instances:Create("TextLabel", {
                    Parent = PlayerItems["NewPlayer"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                                        ZIndex = 2,
                    TextTransparency = 0.4000000059604645,
                    Text = "Neutral",
                    Size = UDim2New(0.3499999940395355, 0, 0, 15),
                    Position = UDim2New(0.699999988079071, 10, 0.5, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                local Team = Player.Team ~= nil and Player.Team.Name or "None"
                local TeamColor = Player.TeamColor ~= nil and Player.TeamColor.Color or Color3.new(1, 1, 1)

                PlayerItems["Team"] = Instances:Create("TextLabel", {
                    Parent = PlayerItems["NewPlayer"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = TeamColor,
                    TextTransparency = 0.4000000059604645,
                    Text = Team,
                    Size = UDim2New(0.3499999940395355, 0, 0, 15),
                    Position = UDim2New(0.3499999940395355, 10, 0.5, 0),
                                        ZIndex = 2,
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                if Player == LocalPlayer then
                    PlayerItems["Status"].Instance.TextColor3 = Library.Theme.Accent
                    PlayerItems["Status"].Instance.Text = "LocalPlayer"
                    PlayerItems["Status"]:AddToTheme({TextColor3 = "Accent"})
                end

                local PlayerData = {
                    Name = Player.Name,
                    Selected = false,
                    PlayerButton = PlayerItems["NewPlayer"],
                    PlayerName = PlayerItems["Name"],
                    PlayerTeam = PlayerItems["Team"],
                    PlayerStatus = PlayerItems["Status"],
                    Player = Player
                }

                function PlayerData:Toggle(Status)
                    if Status == "Active" then
                        PlayerItems["Name"]:Tween(nil, {TextTransparency = 0})
                        PlayerItems["Status"]:Tween(nil, {TextTransparency = 0})
                        PlayerItems["Team"]:Tween(nil, {TextTransparency = 0})
                        PlayerItems["NewPlayer"]:Tween(nil, {BackgroundTransparency = 0})
                    else
                        PlayerItems["Name"]:Tween(nil, {TextTransparency = 0.4})
                        PlayerItems["Status"]:Tween(nil, {TextTransparency = 0.4})
                        PlayerItems["Team"]:Tween(nil, {TextTransparency = 0.4})
                        PlayerItems["NewPlayer"]:Tween(nil, {BackgroundTransparency = 1})
                    end
                end

                function PlayerData:Set()
                    PlayerData.Selected = not PlayerData.Selected

                    if PlayerData.Selected then
                        Playerlist.Player = PlayerData.Player

                        for Index, Value in Playerlist.Players do 
                            Value.Selected = false
                            Value:Toggle("Inactive")
                        end

                        PlayerData:Toggle("Active")

                        local PlayerAvatar = Players:GetUserThumbnailAsync(Playerlist.Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
                        Items["PlayerAvatar"].Instance.Image = PlayerAvatar
                        Items["PlayerUsername"].Instance.Text = Playerlist.Player.DisplayName .. " (@" .. Playerlist.Player.Name .. ")"
                        Items["PlayerUserID"].Instance.Text = tostring(Playerlist.Player.UserId)
                        Items["PlayerAccountAge"].Instance.Text = tostring(Playerlist.Player.AccountAge) .. " days old"
                    else
                        --print("this shit rigged")
                        Playerlist.Player = nil
                        PlayerData:Toggle("Inactive")
                        Items["PlayerAvatar"].Instance.Image = "rbxassetid://98200387761744"
                        Items["PlayerUsername"].Instance.Text = "None"
                        Items["PlayerUserID"].Instance.Text = "None"
                        Items["PlayerAccountAge"].Instance.Text = "None"
                    end

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Playerlist.Player, PlayerData.PlayerStatus.Instance.Text, PlayerData.PlayerTeam.Instance.Text)
                    end
                end

                PlayerItems["NewPlayer"]:Connect("MouseButton1Down", function()
                    PlayerData:Set()
                end)

                PlayerItems["NewPlayer"]:OnHover(function()
                end)

                Playerlist.Players[Player.Name] = PlayerData
                return PlayerData
            end

            function Playerlist:Remove(Name)
                if Playerlist.Players[Name] then
                    Playerlist.Players[Name].PlayerButton:Clean()
                end
                
                Playerlist.Players[Name] = nil
            end

            Dropdown.Callback = function(Value) -- horrible code ik
                if Playerlist.Player then
                    if Playerlist.Player == LocalPlayer then
                        return
                    end

                    if Value == "Neutral" then
                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                            TextColor3 = Library.Theme["Inactive Text"]
                        })

                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Neutral"
                        if table.find(Library.Friendly_Players, Playerlist.Player.Name) then
                            table.remove(Library.Friendly_Players, table.find(Library.Friendly_Players, Playerlist.Player.Name))
                        end
                    elseif Value == "Priority" then
                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                            TextColor3 = FromRGB(255, 50, 50)
                        })

                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Priority"
                        if table.find(Library.Friendly_Players, Playerlist.Player.Name) then
                            table.remove(Library.Friendly_Players, table.find(Library.Friendly_Players, Playerlist.Player.Name))
                        end
                    elseif Value == "Friendly" then
                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                            TextColor3 = FromRGB(83, 255, 83)
                        })

                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Friendly"
                        if not table.find(Library.Friendly_Players, Playerlist.Player.Name) then
                            table.insert(Library.Friendly_Players, Playerlist.Player.Name)
                        end
                    else
                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                            TextColor3 = Library.Theme["Inactive Text"]
                        })

                        Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Neutral"
                        if table.find(Library.Friendly_Players, Playerlist.Player.Name) then
                            table.remove(Library.Friendly_Players, table.find(Library.Friendly_Players, Playerlist.Player.Name))
                        end
                    end
                end
            end

            for Index, Value in Players:GetPlayers() do 
                Playerlist:Add(Value)
            end

            Library:Connect(Players.PlayerRemoving, function(Player)
                if Playerlist.Players[Player.Name] then 
                    Playerlist:Remove(Player.Name)
                end
            end)

            Library:Connect(Players.PlayerAdded, function(Player)
                Playerlist:Add(Player)
            end)

            return Playerlist
        end

        Library.Pages.Section = function(self, Data)
            Data = Data or { }

            local Section = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "Section",
                Side = Data.Side or Data.side or 1,
                Icon = Data.Icon or Data.icon or "9080568477801",

                Items = { }
            }

            if type(Section.Icon) == "string" and not string.find(Section.Icon, not Volcano and ".png" or "rbxasset://") then
                Section.Icon = "rbxassetid://"..Section.Icon
            end

            local Items = { } do
                Items["Section"] = Instances:Create("Frame", {
                    Parent = Section.Page.ColumnsData[Section.Side].Instance,
                    Name = "\0",
                    BorderSizePixel = 0,
                    Size = UDim2New(1, 0, 0, 55),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Section"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Items["Topbar"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 35),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                })  Items["Topbar"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 3),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 29)
                }):AddToTheme({BackgroundColor3 = "Inline"})

                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Section.Name,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(1, -125, 0, 15),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2New(0, 8, 0.5, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(196, 231, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 18, 0, 18),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = Section.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -7, 0.5, -1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Accent"})

                Instances:Create("Frame", {
                    Parent = Items["Topbar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    BackgroundTransparency = 0.4000000059604645,
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(32, 36, 42)
                }):AddToTheme({BackgroundColor3 = "Border"})

                Instances:Create("UIPadding", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 8)
                })

                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0, 45),
                    Size = UDim2New(1, -16, 0, 0),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            Section.Items = Items
            return setmetatable(Section, Library.Sections)
        end

        Library.Sections.Toggle = function(self, Data)
            Data = Data or { }

            local Toggle = {
                Window = self.Window,
                Page = self.Page,
                Section = self,
                
                Name = Data.Name or Data.name or "Toggle",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or false,
                Callback = Data.Callback or Data.callback or function() end,
                Color = Data.Color or nil,
                Tooltip = Data.Tooltip or Data.tooltip or nil,

                Count = 0
            }

            local NewToggle, ToggleItems = Components.Toggle({
                Name = Toggle.Name,
                Parent = Toggle.Section.Items["Content"],
                Flag = Toggle.Flag,
                Default = Toggle.Default,
                Page = Toggle.Page,
                Callback = Toggle.Callback,
                Color = Toggle.Color,
                Tooltip = Toggle.Tooltip,

            })

            ToggleItems["Toggle"]:Tooltip(Toggle.Tooltip)

            function Toggle:Set(Bool)
                NewToggle:Set(Bool)
            end

            function Toggle:Get()
                return NewToggle:Get()
            end

            function Toggle:SetVisibility(Bool)
                NewToggle:SetVisibility(Bool)
            end

            function Toggle:Colorpicker(Data)
                local Colorpicker = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = Data.Name or Data.name,
                    Default = Data.Default or Data.default,
                    Alpha = Data.Alpha or Data.alpha or 0,
                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Callback = Data.Callback or Data.callback or function() end,
                    
                    Count = Toggle.Count
                }
                
                Toggle.Count += 1
                Colorpicker.Count = Toggle.Count

                local NewColorpicker, ColorpickerItems = Components.Colorpicker({
                    Window = Colorpicker.Window,
                    Page = Colorpicker.Page,
                    Parent = ToggleItems["SubElements"],
                    Name = Colorpicker.Name,
                    Flag = Colorpicker.Flag,
                    IsToggle = true,
                    Default = Colorpicker.Default,
                    Alpha = Colorpicker.Alpha,
                    Callback = Colorpicker.Callback,
                    Count = Colorpicker.Count
                })

                return NewColorpicker
            end

            function Toggle:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = Data.Name or Data.name or "Keybind",
                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle",
                    NoKeyBindList = Data.NoKeyBindList or false;
                }

                local NewKeybind, KeybindItems = Components.Keybind({
                    Name = Keybind.Name,
                    Parent = ToggleItems["Toggle"],
                    Window = Toggle.Window,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    IsToggle = true,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback,
                    NoKeyBindList = Keybind.NoKeyBindList
                })

                return NewKeybind
            end

            return Toggle
        end

        Library.Sections.Button = function(self, Data)
            Data = Data or { }

            local Button = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Button",
                Callback = Data.Callback or Data.callback or function() end,
                Tooltip = Data.Tooltip or Data.tooltip or nil
            }

            local Items = { } do
                Items["Button"] = Instances:Create("TextButton", {
                    Parent = Button.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    Size = UDim2New(1, 0, 0, 30),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})

                Items["Button"]:Tooltip(Button.Tooltip)

                Items["Button"]:OnHover(function()
                    Items["Button"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
                end)
    
                Items["Button"]:OnHoverLeave(function()
                    Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                end)    

                Instances:Create("UICorner", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Button.Name,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2New(1, 0, 1, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
            end

            function Button:Press()
                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})

                task.wait(0.1)
                Library:SafeCall(Button.Callback)

                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            end

            function Button:SetVisibility(Bool)
                Items["Button"].Instance.Visible = Bool
            end

            local SearchData = {
                Name = Button.Name,
                Item = Items["Button"]
            }

            local PageSearchData = Library.SearchItems[Button.Page]

            if not PageSearchData then
                return
            end

            TableInsert(PageSearchData, SearchData)

            Items["Button"]:Connect("MouseButton1Down", function()
                Button:Press()
            end)

            return Button
        end

        Library.Sections.Slider = function(self, Data)
            local Slider = { 
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Slider",
                Min = Data.Min or Data.min or 0,
                Max = Data.Max or Data.max or 100,
                Suffix = Data.Suffix or Data.suffix or "",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or 0,
                Decimals = Data.Decimals or Data.decimals or 1,
                Tooltip = Data.Tooltip or Data.tooltip or nil,
                Callback = Data.Callback or Data.callback or function() end,

                Sliding = false,
                Value = 0
            }

            local Items = { } do
                Items["Slider"] = Instances:Create("Frame", {
                    Parent = Slider.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 38),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Slider"]:Tooltip(Slider.Tooltip)

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Slider.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Items["RealSlider"] = Instances:Create("TextButton", {
                    Parent = Items["Slider"].Instance,
                    AutoButtonColor = false,
                    Text = "",
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 15),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})

                Items["RealSlider"]:OnHover(function()
                    Items["RealSlider"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
                end)
    
                Items["RealSlider"]:OnHoverLeave(function()
                    Items["RealSlider"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                end)   

                Instances:Create("UICorner", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    Size = UDim2New(0.5, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(196, 231, 255)
                })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})

                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})

                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutomaticSize = Enum.AutomaticSize.X,
                    AnchorPoint = Vector2New(1, 0),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Value"]:AddToTheme({TextColor3 = "Text"})
            end

            function Slider:Get()
                return Slider.Value
            end

            function Slider:ChangeText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Slider:Set(Value)
                Slider.Value = Library:Round(MathClamp(Value, Slider.Min, Slider.Max), Slider.Decimals)

                Library.Flags[Slider.Flag] = Slider.Value

                Items["Accent"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)})
                Items["Value"].Instance.Text = StringFormat("%s%s", tostring(Slider.Value), Slider.Suffix)

                if Slider.Callback then 
                    Library:SafeCall(Slider.Callback, Slider.Value)
                end
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            getgenv().Options[Slider.Flag] = Slider

            local SearchData = {
                Name = Slider.Name,
                Item = Items["Slider"]
            }

            local PageSearchData = Library.SearchItems[Slider.Page]

            if not PageSearchData then 
                return 
            end

            TableInsert(PageSearchData, SearchData)

            local InputChanged

            Items["RealSlider"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true 

                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value)

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Slider.Sliding then
                        local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                        local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                        Slider:Set(Value)
                    end
                end
            end)

            if Slider.Default then 
                Slider:Set(Slider.Default)
            end

            Library.SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            return Slider
        end

        Library.Sections.Dropdown = function(self, Data)
            Data = Data or { }

            local Dropdown = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Dropdown",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or nil,
                Items = Data.Items or Data.items or { "One", "Two", "Three" },
                Callback = Data.Callback or Data.callback or function() end,
                Multi = Data.Multi or Data.multi or false,
                MaxSize = Data.MaxSize or Data.maxsize or 85,
                Tooltip = Data.Tooltip or Data.tooltip or nil
            }

            local NewDropdown, DropdownItems = Components.Dropdown({
                Window = Dropdown.Window,
                Page = Dropdown.Page,
                Parent = Dropdown.Section.Items["Content"],
                Callback = Dropdown.Callback,
                Name = Dropdown.Name,
                Flag = Dropdown.Flag,
                Items = Dropdown.Items,
                Default = Dropdown.Default,
                Multi = Dropdown.Multi,
                MaxSize = Dropdown.MaxSize or 65
            })  

            DropdownItems["Dropdown"]:Tooltip(Dropdown.Tooltip)

            function Dropdown:Set(Value)
                NewDropdown:Set(Value)
            end

            function Dropdown:Get()
                return NewDropdown:Get()
            end

            function Dropdown:AddOption(Option)
                return NewDropdown:AddOption(Option)
            end

            function Dropdown:RemoveOption(Option)
                return NewDropdown:RemoveOption(Option)
            end

            function Dropdown:Refresh(List)
                return NewDropdown:Refresh(List)
            end

            function Dropdown:SetVisibility(Bool)
                NewDropdown:SetVisibility(Bool)
            end

            return Dropdown
        end

        Library.Sections.Label = function(self, Text, Alignment, Tooltip)
            local Label = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Text or "Label",
                Alignment = Alignment or "Left", 
                
                Count = 0
            }

            local Items = { } do
                Items["Label"] = Instances:Create("Frame", {
                    Parent = Label.Section.Items["Content"].Instance,
                    BackgroundTransparency = 1,
                    ZIndex = 2,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 20),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                Items["Label"]:Tooltip(Tooltip)

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Label"].Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    Text = Label.Name,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(1, -16, 0, 15),
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment[Label.Alignment],
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Instances:Create("UIPadding", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                })

                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0.5, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function Label:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Label:SetVisibility(Bool)
                Items["Label"].Instance.Visible = Bool
            end

            function Label:Colorpicker(Data)
                local Colorpicker = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = Data.Name or Data.name,
                    Default = Data.Default or Data.default,
                    Alpha = Data.Alpha or Data.alpha or 0,
                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Callback = Data.Callback or Data.callback or function() end,
                    
                    Count = Label.Count
                }
                
                Label.Count += 1
                Colorpicker.Count = Label.Count

                local NewColorpicker, ColorpickerItems = Components.Colorpicker({
                    Window = Colorpicker.Window,
                    Page = Colorpicker.Page,
                    Parent = Items["SubElements"],
                    Name = Colorpicker.Name,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Alpha = Colorpicker.Alpha,
                    Callback = Colorpicker.Callback,
                    Count = Colorpicker.Count
                })

                return NewColorpicker
            end

            function Label:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = Data.Name or Data.name or "Keybind",
                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle",
                    NoKeyBindList = Data.NoKeyBindList or false;
                }

                local NewKeybind, KeybindItems = Components.Keybind({
                    Name = Keybind.Name,
                    Parent = Items["Label"],
                    Window = Label.Window,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback,
                    NoKeyBindList = Keybind.NoKeyBindList
                })

                return NewKeybind
            end

            local SearchData = {
                Name = Label.Name,
                Item = Items["Label"]
            }

            local PageSearchData = Library.SearchItems[Label.Page]

            if not PageSearchData then 
                return 
            end

            TableInsert(PageSearchData, SearchData)

            return Label 
        end

        Library.Sections.Textbox = function(self, Data)
            Data = Data or { }

            local Textbox = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Textbox",
                Placeholder = Data.Placeholder or Data.placeholder or "...",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or "",
                Callback = Data.Callback or Data.callback or function() end,
                Tooltip = Data.Tooltip or Data.tooltip or nil,

                Value = "",
            }

            local Items = { } do
                Items["Textbox"] = Instances:Create("Frame", {
                    Parent = Textbox.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 47),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Textbox"]:Tooltip(Textbox.Tooltip)

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Textbox"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Textbox.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Textbox"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 25),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34, 39, 45)
                })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})

                Items["Background"]:OnHover(function()
                    Items["Background"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
                end)
    
                Items["Background"]:OnHoverLeave(function()
                    Items["Background"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                end)   

                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(211, 211, 211))}
                })

                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    CursorPosition = -1,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    ZIndex = 2,
                    Size = UDim2New(1, 0, 1, 0),
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    PlaceholderText = Textbox.Placeholder,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Input"]:AddToTheme({TextColor3 = "Text", PlaceholderColor3 = "Inactive Text"})

                Instances:Create("UIPadding", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 8)
                })
            end

            function Textbox:Set(Value)
                Items["Input"].Instance.Text = tostring(Value)
                Textbox.Value = Value
                Library.Flags[Textbox.Flag] = Value

                Items["Input"]:ChangeItemTheme({TextColor3 = "Text", PlaceholderColor3 = "Text Inactive"})
                Items["Input"]:Tween(nil, {TextColor3 = Library.Theme.Text})

                if Textbox.Callback then
                    Library:SafeCall(Textbox.Callback, Value)
                end
            end

            function Textbox:Get()
                return Textbox.Value
            end

            function Textbox:SetVisibility(Bool)
                Items["Textbox"].Instance.Visible = Bool
            end

            getgenv().Options[Textbox.Flag] = Textbox

            local SearchData = {
                Name = Textbox.Name,
                Item = Items["Textbox"]
            }

            local PageSearchData = Library.SearchItems[Textbox.Page]

            if not PageSearchData then 
                return 
            end

            TableInsert(PageSearchData, SearchData)

            Items["Input"]:Connect("Focused", function()
                Items["Input"]:ChangeItemTheme({TextColor3 = "Accent", PlaceholderColor3 = "Text Inactive"})
                Items["Input"]:Tween(nil, {TextColor3 = Library.Theme.Accent})
            end)

            Items["Input"]:Connect("FocusLost", function()
                Textbox:Set(Items["Input"].Instance.Text)
            end)

            if Textbox.Default then 
                Textbox:Set(Textbox.Default)
            end

            Library.SetFlags[Textbox.Flag] = function(Value)
                Textbox:Set(Value)
            end

            return Textbox
        end
    end

    Library.Init = function(self)
        local AutoloadConfig = readfile(Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json")
        local AutoloadTheme = readfile(Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json")
        
        if AutoloadConfig ~= "" then
            local Success, Result = Library:LoadConfig(AutoloadConfig)

            if Success then 
                Library:Notification({
                    Name = "Success",
                    Description = "Successfully loaded autoload config",
                    Duration = 5,
                    Icon = "116339777575852",
                    IconColor = Color3.fromRGB(52, 255, 164)
                })
            else
                Library:Notification({
                    Name = "Error!",
                    Description = "Failed to load autoload config, error:\n" .. Result,
                    Duration = 5,
                    Icon = "97118059177470",
                    IconColor = Color3.fromRGB(255, 120, 120)
                })
            end
        end

        if AutoloadTheme ~= "" then
            local Success, Result = Library:LoadTheme(AutoloadTheme)

            if Success then 
                Library:Notification({
                    Name = "Success",
                    Description = "Successfully loaded autoload theme",
                    Duration = 5,
                    Icon = "116339777575852",
                    IconColor = Color3.fromRGB(52, 255, 164)
                })
            else
                Library:Notification({
                    Name = "Error!",
                    Description = "Failed to load autoload theme, error:\n" .. Result,
                    Duration = 5,
                    Icon = "97118059177470",
                    IconColor = Color3.fromRGB(255, 120, 120)
                })
            end
        end
    end
end

-- Example
do
    Window = Library:Window({
        Name = '<font color="rgb(255,255,255)">valary.</font><font color="rgb(236,23,23)">gg</font> | '..Game_Name_MarketPlaceService,
        Version = "v1.0.0",
        Logo = "135215559087473",
        FadeSpeed = 0.25,
        --Size = UDim2.new(0, 659, 0, 511)
    })

    local ESPPreview = Library:ESPPreview({
        MainFrame = Window.Items["MainFrame"] -- keep this
    })

    local ChatSystem = Library:ChatSystem({
        MainFrame = Window.Items["MainFrame"] -- keep this
    })

    local Chat_API = {}

    Chat_API.URL = "https://yellow-band-8a75.oblockjoycesohiorizz.workers.dev/"

    local HttpService = Services.HttpService

    function Chat_API.SendMessage(UserId, Message)
        local Response = game:HttpGet(string.format(
            "%s?format=json&event=chat&message=%s&userid=%s",
            Chat_API.URL,
            HttpService:UrlEncode(Message),
            HttpService:UrlEncode(UserId)
        ))

        return HttpService:JSONDecode(Response)
    end

    function Chat_API.Heartbeat(UserId)
        local Response = game:HttpGet(string.format(
            "%s?format=json&event=heartbeat&userid=%s",
            Chat_API.URL,
            HttpService:UrlEncode(UserId)
        ))
        return HttpService:JSONDecode(Response)
    end

    function Chat_API.GetMessages()
        local Response = game:HttpGet(Chat_API.URL.."?format=json")

        return HttpService:JSONDecode(Response)
    end

    local Cached_Data = {}

    local Special_DiscordIDS = {
        ["1096603799159832636"] = ' - <font color="#EC1717">Owner</font>'
    }
    
    if not isfolder("valary/Assets/Profiles") then
        makefolder("valary/Assets/Profiles")
    end

    function Chat_API.GetDiscordProfile(Discord_ID)
        if not Cached_Data[Discord_ID] then
            local Response = game:HttpGet("https://discord-lookup-api-neon.vercel.app/v1/user/" .. Discord_ID)
            repeat wait() until Response
            task.wait(0.1)
            Cached_Data[Discord_ID] = HttpService:JSONDecode(Response)
        end
            
        local avatar = Cached_Data[Discord_ID].avatar
        local ext = avatar.is_animated and ".gif" or ".png"

        if not isfile("valary/Assets/Profiles/"..Discord_ID..ext) then
            if not avatar.link then
                writefile("valary/Assets/Profiles/"..Discord_ID..ext, game:HttpGet('https://raw.githubusercontent.com/ValarySoftworks/Assets/refs/heads/main/download.png'))
            else
                writefile("valary/Assets/Profiles/"..Discord_ID..ext, game:HttpGet(avatar.link))
            end
        end

        local Name = Cached_Data[Discord_ID].global_name

        if Special_DiscordIDS[Discord_ID] then
            Name..=Special_DiscordIDS[Discord_ID]
        end

        return getcustomasset("valary/Assets/Profiles/"..Discord_ID..ext), Name
    end

    task.spawn(function()
        do -- Add User
            pcall(function()
                local encodedID = HttpService:UrlEncode(LRM_LinkedDiscordID)
                local base64_name = string.reverse(base64.encode(LocalPlayer.Name))

                local encodedName = HttpService:UrlEncode(base64_name)

                request({
                    Url = "https://yellow-band-8a75.oblockjoycesohiorizz.workers.dev/?event=add_user&userid=" 
                        .. encodedID .. "&username=" .. encodedName,
                    Method = "GET"
                })
            end)
        end

        -- Refresh hearbeat
            task.spawn(LPH_JIT_MAX(function()
                while task.wait(90) do
                    pcall(Chat_API.Heartbeat, LRM_LinkedDiscordID)
                    --local encodedID = HttpService:UrlEncode(LRM_LinkedDiscordID)
                    --request({Url = "https://yellow-band-8a75.oblockjoycesohiorizz.workers.dev/?event=heartbeat&userid="..encodedID, Method = "GET"})
                end
            end))
        --

        -- Refresh Status
            do
                pcall(function()
                    local Users = Chat_API.GetMessages().users.value

                    ChatSystem:SetStatusText(string.format('%s Active | Connected', tostring(Users)))
                end)
            end
        --
            
        ChatSystem:OnMessageSendPressed(function()
            local Profile, Username = Chat_API.GetDiscordProfile(LRM_LinkedDiscordID)

            local Text = ChatSystem:GetTypedMessage()

            ChatSystem:ClearText()
            
            ChatSystem:SendMessage(Profile, Username, Text, true)

            pcall(Chat_API.SendMessage, LRM_LinkedDiscordID, Text)
        end)

        task.spawn(LPH_JIT_MAX(function()
            local data_to_send = {}
            local Already_Sent = {}

            --[[pcall(function()
                for i,v in Chat_API.GetMessages().messages do
                    if not Already_Sent[v.message.."_"..v.userid.."_"..v.timestamp] then
                        Already_Sent[v.message.."_"..v.userid.."_"..v.timestamp] = true
                    end
                end
            end)]]

            local function formatNameWithTime(username, time)
                return string.format(
                    '%s <font color="#72767D"> %s</font>',
                    username,
                    os.date("%H:%M", time)
                )
            end

            while task.wait(1) do
                local Success, Error = pcall(function()
                    local Messages = Chat_API.GetMessages()

                    ChatSystem:SetStatusText(string.format('%s Active | Connected', tostring(Messages.users.value)))

                    if not Messages.users.stored[LRM_LinkedDiscordID] then
                        local encodedID = HttpService:UrlEncode(LRM_LinkedDiscordID)
                        local base64_name = string.reverse(base64.encode(LocalPlayer.Name))

                        local encodedName = HttpService:UrlEncode(base64_name)

                        request({
                            Url = "https://yellow-band-8a75.oblockjoycesohiorizz.workers.dev/?event=add_user&userid=" 
                                .. encodedID .. "&username=" .. encodedName,
                            Method = "GET"
                        })
                    end

                    for i,v in Messages.users.stored do
                        pcall(function()
                            local decoded_user = base64.decode(string.reverse(v.username))

                            if not Config.Valary_Users[decoded_user] then
                                Config.Valary_Users[decoded_user] = i
                            end
                        end)
                    end

                    local toRemove = {}

                    for username, id in Config.Valary_Users do
                        if not Messages.users.stored[id] then
                            table.insert(toRemove, username)
                        end
                    end

                    for _, username in toRemove do
                        Config.Valary_Users[username] = nil
                    end

                    for _, v in pairs(Messages.messages) do
                        --if v.userid ~= LRM_LinkedDiscordID then
                            if not Already_Sent[v.userid.."_"..v.timestamp.."_"..v.message] then
                                local Profile, Username = Chat_API.GetDiscordProfile(v.userid)

                                Username = tostring(Username or "Unknown")
                                local Timestamp = tonumber(v.timestamp) or os.time()

                                data_to_send[v.userid] = data_to_send[v.userid] or {}

                                table.insert(data_to_send[v.userid], {
                                    UserId = v.userid,
                                    Profile = Profile,
                                    Username = Username,
                                    Message = tostring(v.message or "ERROR"),
                                    Timestamp = Timestamp
                                })
                            end
                        --end
                    end

                    local flat = {}

                    for _, msgs in pairs(data_to_send) do
                        for _, msg in ipairs(msgs) do
                            table.insert(flat, msg)
                        end
                    end

                    table.sort(flat, function(a, b)
                        return a.Timestamp < b.Timestamp
                    end)

                    for _, v in ipairs(flat) do
                        local msgKey = v.UserId .. "_" .. v.Timestamp .. "_" .. v.Message

                        local Check = v.UserId ~= LRM_LinkedDiscordID

                        if not dfihjdsiufodsaiuojdfdsjauidfsdad then
                            Check = true
                        end

                        if not Already_Sent[msgKey] and Check then
                            ChatSystem:SendMessage(
                                v.Profile,
                                formatNameWithTime(v.Username, v.Timestamp),
                                v.Message,
                                v.UserId == LRM_LinkedDiscordID
                            )

                            Already_Sent[msgKey] = true
                        end
                    end

                    table.clear(data_to_send)

                    --[[for i,v in Messages.messages do
                        if v.userid ~= LRM_LinkedDiscordID and not Already_Sent[v.message.."_"..v.userid.."_"..v.timestamp] then
                            local Profile, Username = Chat_API.GetDiscordProfile(v.userid)

                            ChatSystem:SendMessage(Profile, formatNameWithTime(Username, v.timestamp), v.message, false)
                            Already_Sent[v.message.."_"..v.userid.."_"..v.timestamp] = true
                        end
                    end]]

                    if not dfihjdsiufodsaiuojdfdsjauidfsdad then
                        getgenv().SendMessage_Input.Instance.PlaceholderText = "Send message"
                        dfihjdsiufodsaiuojdfdsjauidfsdad = true
                    end
                end)

                if not Success then
                    warn("GLOBAL CHAT ERROR :",Error)
                end
            end
        end))
    end)

    Watermark = Library:Watermark("This is a watermark", "135215559087473")
    Watermark:SetVisibility(false)
    local KeybindList = Library:KeybindsList()
    KeybindList:SetVisibility(false)

    task.spawn(LPH_NO_VIRTUALIZE(function()
        while task.wait(1) do
            Watermark:SetText(string.format('<font color="rgb(255,255,255)">valary.</font><font color="rgb(%d,%d,%d)">gg</font> - %s - %s',Library.Theme.Accent.R*255,Library.Theme.Accent.G*255,Library.Theme.Accent.B*255, Game_Name_MarketPlaceService, os.date("%b. %d %Y, %X")))
        end
    end))

    do
        local Pages = {
            ["Combat"] = Window:Page({
                Name = "Combat", 
                Icon = "111386589037485",
                SubPages = true,
            }),
            
            ["Visuals"] = Window:Page({
                Name = "Visuals", 
                Icon = "115907015044719", 
                SubPages = true,
            }),

            ["Main"] = Window:Page({
                Name = "Main", 
                Icon = "136623465713368", 
                SubPages = true,
            }),

            ["Misc"] = Window:Page({
                Name = "Player List", 
                Icon = Library:GetImage("GroupSearch"), 
                Columns = 2
            }),

            ["Settings"] = Window:Page({
                Name = "Settings", 
                Icon = "137300573942266", 
                Columns = 2,
                SubPages = true
            })
        }

        do -- Misc
            local Playerlist = Pages["Misc"]:Playerlist({
                Callback = function(...)
                    local Args = {...}

                    Library.Selected_Player = Args[1]
                end
            })
        end

        do -- Combat
            local Subpages = {
                ["Selector"] = Pages["Combat"]:SubPage({
                    Name = "Selector", 
                    Icon = "126028986879491", 
                    Columns = 2
                }),
                ["Aimbot"] = Pages["Combat"]:SubPage({
                    Name = "Aimbot", 
                    Icon = Library:GetImage("Forward"), 
                    Columns = 2
                }),
                ["Weapon_Mods"] = Pages["Combat"]:SubPage({
                    Name = "Modifications", 
                    Icon = Library:GetImage("Tune"), 
                    Columns = 2
                }),
            }

            do -- Selector
                local Field_OfView_Section = Subpages["Selector"]:Section({Name = "Field Of View Settings", Icon = Library:GetImage("Radar"), Side = 1})
                
                local SelectedTarget_Settings = Subpages["Selector"]:Section({Name = "Selected Target Settings", Icon = Library:GetImage("DiagonalLine"), Side = 1})

                local TargetSelector_Section = Subpages["Selector"]:Section({Name = "Target Selector Settings", Icon = Library:GetImage("AdsClick"), Side = 2})

                --local GeneralSection2 = Subpages["Aimbot"]:Section({Name = "general2", Icon = "103174889897193", Side = 1})

                do
                    Field_OfView_Section:Toggle({Name="Use Field Of View",Flag="FieldOfView_Enabled",Default=false,Callback=function(State) Config.TargetSelector.UseFOV=State end})

                    Field_OfView_Section:Slider({Name="Field Of View Radius",Flag="FieldOfView_Radius",Default=25,Min=0,Max=100,Decimals=1,Callback=function(State)
                        Config.FieldOfView.Radius=State*10
                        FieldOfView.Radius=State*10
                        FieldOfViewOutline.Radius=State*10
                        FieldOfViewFill.Radius=State*10
                    end})

                    Field_OfView_Section:Slider({Name="Field Of View Sides",Flag="FieldOfView_Sides",Default=50,Min=3,Max=100,Callback=function(State)
                        FieldOfView.NumSides=State
                        FieldOfViewOutline.NumSides=State
                        FieldOfViewFill.NumSides=State
                    end})

                    Field_OfView_Section:Toggle({Name="Draw Field Of View",Flag="FieldOfView_Drawed",Default=false,Callback=function(State) Config.FieldOfView.Draw=State end}):Colorpicker({Name="Field Of View Color",Default=Color3.new(1,1,1),Alpha=0,Callback=function(Color,Transparency)
                        Config.FieldOfView.FieldOfViewColor=Color
                        FieldOfView.Color=Color
                        Config.FieldOfView.Transparency=1-Transparency
                        FieldOfView.Transparency=1-Transparency
                        FieldOfViewOutline.Transparency=1-Transparency
                    end})

                    SelectedTarget_Settings:Toggle({Name="Draw Snapline",Flag="Draw_Snapline",Default=false,Callback=function(State) Config.FieldOfView.DrawSnapline=State end}):Colorpicker({Name="Snapline Color",Default = Color3.new(1,1,1), Alpha=0,Callback=function(Color,Transparency)
                        Snapline.Color=Color
                        Snapline.Transparency=1-Transparency
                        SnaplineOutline.Transparency=1-Transparency
                    end})

                    SelectedTarget_Settings:Slider({Name="Snapline Thickness",Flag="Snapline_Thickness",Default=1,Min=1,Max=5,Callback=function(State)
                        SnaplineOutline.Thickness=State+2
                        Snapline.Thickness=State
                    end})

                    local _Toggle=SelectedTarget_Settings:Toggle({Name="Highlight Target",Flag="Highlight_Target",Callback=function(State) Config.FieldOfView.HightlightTarget=State end})
                    _Toggle:Colorpicker({Name="Highlight Filled Color", Default = Color3.fromRGB(255,0,0), Alpha=0.6,Callback=function(Color,Transparency)
                        Config.FieldOfView.HightlightFillColor=Color

                        Config.FieldOfView.HightlightFillTransparency=Transparency

                        Target_Highlight.FillColor = Config.FieldOfView.HightlightFillColor
                        Target_Highlight.FillTransparency = Config.FieldOfView.HightlightFillTransparency
                    end})
                    
                    TargetSelector_Section:Label("Select Player Keybind","Left"):Keybind({Name="Select Player",Flag="selectplayerbind",Default=Enum.KeyCode.Q,Mode="toggle",Callback=function(State) Config.TargetSelector.Targetting=State end})

                    TargetSelector_Section:Toggle({Name="Health Check",Flag="Target_Health_Check", Default=false,Callback=function(value) Config.TargetSelector.HealthCheck=value end})

                    TargetSelector_Section:Slider({Name="Minimum Health",Flag="Target_Minimum_Health",Default=5,Min=0,Max=100,Decimals=1,Suffix="%",Callback=function(value) Config.TargetSelector.Health=value end})

                    TargetSelector_Section:Toggle({Name="Distance Check",Flag="Target_Distance_Check",Default=false,Callback=function(value) Config.TargetSelector.LimitDistance=value end})

                    TargetSelector_Section:Slider({Name="Maximum Distance",Flag="Target_Max_Distance",Default=500,Min=0,Max=2000,Decimals=1,Suffix="m",Callback=function(value) Config.TargetSelector.MaxDistance=value end})

                    TargetSelector_Section:Toggle({Name="Visible Check",Flag="Target_Visible_Check",Default=false,Callback=function(value) Config.TargetSelector.VisibleCheck=value end})

                    TargetSelector_Section:Toggle({Name="Friend Check",Flag="Target_Friend_Check",Default=false,Callback=function(value) Config.TargetSelector.FriendCheck=value end})

                    TargetSelector_Section:Toggle({Name="Safe Check",Flag="Target_Safe_Check",Default=false,Callback=function(value) Config.TargetSelector.ProtectedCheck=value end})
                end
            end

            do -- Aimbot
                local SilentAim_Section = Subpages["Aimbot"]:Section({Name = "Silent Aimbot", Icon = Library:GetImage("Bolt"), Side = 1})
            
                SilentAim_Section:Toggle({Name = "Enabled", Flag = "SilentAim_Enabled", Default = false, Callback = function(State)
                    Config.Silent.Enabled = State
                end})
                            
                SilentAim_Section:Toggle({Name = "Wall Bang", Flag = "SilentAim_Wallbang", Default = false, Callback = function(State)
                    Config.Silent.WallBang = State
                end})

                SilentAim_Section:Slider({Name="Silent Aim Hit Chance",Suffix = "%",Flag="SilentAim_HitChance",Default=100,Min=0,Max=100,Callback=function(State)
                    Config.Silent.HitChance = State
                end})

                SilentAim_Section:Dropdown({
                    Name = "Select Hit Parts",
                    Flag = "SilentAim_HitParts",
                    Items = {
                        "Head",
                        "UpperTorso",
                        "LowerTorso",
                        "LeftUpperArm",
                        "LeftLowerArm",
                        "RightUpperArm",
                        "RightLowerArm",
                        "LeftUpperLeg",
                        "LeftLowerLeg",
                        "RightUpperLeg",
                        "RightLowerLeg",
                        "HumanoidRootPart"
                    },
                    Default = {"Head", "HumanoidRootPart", "LeftUpperLeg", "RightUpperLeg"},
                    Multi = true,
                    MaxSize = 200,
                    Callback = function(State)
                        table.clear(Config.Silent.HitParts)
                        
                        for Index, Value in State do
                            table.insert(Config.Silent.HitParts, Value)
                        end
                    end
                })

                local HitSound_Section = Subpages["Aimbot"]:Section({Name = "Hit Sounds", Icon = Library:GetImage("Bomb"), Side = 2})

                local Sound_Names = {}

                for Index, Value in Config.Hit_Sounds do
                    table.insert(Sound_Names, Index)
                end

                table.sort(Sound_Names)

                HitSound_Section:Toggle({Name = "Enabled", Flag = "ThaBronx3/Silent/HitSoundsEnabled", Callback = function(State)
                    Config.Hit_Sounds_Settings.Enabled = State
                end})

                HitSound_Section:Toggle({Name = "Hide Normal Gun Sound", Tooltip = "If enabled, this will make the normal gunshot sound silent.", Flag = "ThaBronx3/Silent/HideNormalGunSound", Callback = function(State)
                    Config.Hit_Sounds_Settings.HideNormalSounds = State
                end})

                HitSound_Section:Dropdown({Name = "Select Sound", Items = Sound_Names, MaxSize = 175, Default = "Neverlose", Flag = "ThaBronx3/Silent/SelectHitSound", Callback = function(State)
                    if Config.Hit_Sounds[State] then
                        Config.Hit_Sounds_Settings.Selected = State

                        local sound = Instance.new("Sound")
                        sound.SoundId = Config.Hit_Sounds[State]
                        sound.Volume = Config.Hit_Sounds_Settings.Volume
                        sound.Looped = false
                        sound.Parent = Workspace
                        sound.RollOffMode = Enum.RollOffMode.Linear
                        sound.EmitterSize = 2
                        sound.MaxDistance = 10

                        sound:Play()
                    end
                end})

                HitSound_Section:Slider({Name = "Select Volume", Flag = "ThaBronx3/Silent/SelectVolume", Max = 10, Min = 1, Default = 5, Decimals = 1, Callback = function(State)
                    Config.Hit_Sounds_Settings.Volume = State
                end})
            end

            do -- Modifications
                local Weapon_Modifications_Enabled = Subpages["Weapon_Mods"]:Section({Name = "Weapon Modifications", Icon = Library:GetImage("Wrench"), Side = 1})

                local Modifications = {
                    "Infinite Ammo";
                    "Infinite Clips";
                    "Infinite Damage";
                    "Instant Reload";
                    "Instant Equip";
                    "Fully Automatic";
                    "Disable Jamming";
                    "Modify Recoil Value";
                    "Modify Spread Value";
                    "Modify Fire Rate";
                }

                for _, Index in Modifications do
                    Weapon_Modifications_Enabled:Toggle({Name = Index, Flag = 'TheBronx3/WeaponModifications/'..Index, Default = false, Callback = function(State)
                        if Index == "Fully Automatic" then Index = "Automatic" end
                        Config.The_Bronx.Modifications[Index:gsub(" ", "")] = State
                    end})
                end

                Weapon_Modifications_Enabled = Subpages["Weapon_Mods"]:Section({Name = "Weapon Modification Settings", Icon = Library:GetImage("MultipleCogs"), Side = 2})

                Weapon_Modifications_Enabled:Label("100% is the default percentage.")

                Weapon_Modifications_Enabled:Slider({
                    Name = "Fire-Rate Percentage",
                    Default = 50,
                    Max = 100,
                    Minimum = 1,
                    Decimals = 1,
                    Suffix = "%",
                    Flag = "Fire_Rate_Percentage",
                    Callback = function(Value)
                        Config.The_Bronx.Modifications.FireRateSpeed = Value
                    end
                })

                Weapon_Modifications_Enabled:Slider({
                    Name = "Spread Percentage",
                    Default = 50,
                    Max = 100,
                    Minimum = 1,
                    Decimals = 1,
                    Suffix = "%",
                    Flag = "Spread_Percentage",
                    Callback = function(Value)
                        Config.The_Bronx.Modifications.SpreadPercentage = Value
                    end
                })

                Weapon_Modifications_Enabled:Slider({
                    Name = "Recoil Percentage",
                    Default = 50,
                    Max = 100,
                    Minimum = 1,
                    Decimals = 1,
                    Suffix = "%",
                    Flag = "Recoil_Percentage",
                    Callback = function(Value)
                        Config.The_Bronx.Modifications.RecoilPercentage = Value
                    end
                })

                Weapon_Modifications_Enabled = Subpages["Weapon_Mods"]:Section({Name = "Kill Aura Settings", Icon = Library:GetImage("Skull"), Side = 2})

                Weapon_Modifications_Enabled:Toggle({Name='Enabled - Need Gun', Flag="KillAura_Enabled",Tooltip = "You need to hold the gun for this to work.",Default=false,Callback=function(State) 
                    Config.The_Bronx.KillAura = State
                end})

                Weapon_Modifications_Enabled:Slider({
                    Name = "Kill Aura Range",
                    Default = 500,
                    Max = 2000,
                    Minimum = 1,
                    Decimals = 1,
                    Suffix = "m",
                    Flag = "Kill_Aura_Range",
                    Callback = function(Value)
                        Config.The_Bronx.KillAuraRange = Value
                    end
                })
            end
        end

        do -- Visuals
            local Subpages = {
                ["Player ESP"] = Pages["Visuals"]:SubPage({
                    Name = "Players", 
                    Icon = "111178525804834", 
                    Columns = 2
                }),
                ["World"] = Pages["Visuals"]:SubPage({
                    Name = "World", 
                    Icon = Library:GetImage("GlobePublic"), 
                    Columns = 2
                }),
            }


            local PlayersSection = Subpages["Player ESP"]:Section({Name = "Players - Main Settings", Side = 1, Icon = "135799335731002"})

            ESPPreview:SetVisibility(false)

            ESPPreview:Set("BoxHolder", "BackgroundTransparency", 1)
            ESPPreview:Set("BoxHolder", "Visible", false)
            ESPPreview:Set("Corners", "Visible", false)
            ESPPreview:Set("WeaponText", "Visible", false)
            ESPPreview:Set("Distance", "Visible", false)
            ESPPreview:Set("Name", "Visible", false)
            ESPPreview:Set("HealthBar", "Visible", false)
            ESPPreview:Set("HealthBarText", "Visible", false)
            ESPPreview:Set("HealthBarText", "Position", UDim2.new(0, -5, 0, 0))

            PlayersSection:Toggle({
                Name = "Enabled",
                Flag = "Visuals/ESP/MasterSwitch",
                Default = false,
                Callback = function(Value)
                    Options["Enabled"] = Value
                    MiscOptions["Enabled"] = Value

                    ESPPreview:SetVisibility(Value)
                end
            })

            local BoxesToggle = PlayersSection:Toggle({
                Name = "Boxes",
                Flag = "Visuals/ESP/Boxes",
                Default = false,
                Callback = function(Value)
                    MiscOptions["Boxes"] = Value
                    Options["Boxes"] = Value

                    ESPPreview:Set("BoxHolder", "Visible", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 

                    if Options["BoxType"] == "Corner" then
                        if Options["Boxes"] then
                            ESPPreview:Set("BoxHolder", "Visible", false)
                            ESPPreview:Set("Corners", "Visible", true)
                        else
                            ESPPreview:Set("BoxHolder", "Visible", false)
                            ESPPreview:Set("Corners", "Visible", Value)
                        end
                    else
                        if Options["Boxes"] then
                            ESPPreview:Set("BoxHolder", "Visible", true)
                            ESPPreview:Set("Corners", "Visible", false)
                        else
                            ESPPreview:Set("BoxHolder", "Visible", Value)
                            ESPPreview:Set("Corners", "Visible", false)
                        end
                    end
                end
            })

            BoxesToggle:Colorpicker({
                Name = "Gradient 1",
                Flag = "Visuals/ESP/Boxes/Gradient 1",
                Default = Options["Box Gradient 1"].Color,
                Alpha = 0,
                Callback = function(Value)
                    Options["Box Gradient 1"] = {Color = Value, Transparency = Alpha}
                    MiscOptions["Box Gradient 1"] = {Color = Value, Transparency = Alpha}
                    ESPPreview:Set("BoxGradient", "Color", ColorSequence.new{ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Options["Box Gradient 2"]["Color"])})
                    
                    if Options["BoxType"] == "Corner" then
                        for _, descendant in ESPPreview.Items.Corners.Instance:GetDescendants() do
                            if descendant:IsA("UIGradient") then
                                descendant.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Options["Box Gradient 2"]["Color"])}
                            end
                        end
                    end
                end
            })

            BoxesToggle:Colorpicker({
                Name = "Gradient 2",
                Flag = "Visuals/ESP/Boxes/Gradient 2",
                Default = Options["Box Gradient 2"].Color,
                Alpha = 0,
                Callback = function(Value, Alpha)
                    Options["Box Gradient 2"] = {Color = Value, Transparency = Alpha}
                    MiscOptions["Box Gradient 2"] = {Color = Value, Transparency = Alpha}
                    ESPPreview:Set("BoxGradient", "Color", ColorSequence.new{ColorSequenceKeypoint.new(0, Options["Box Gradient 1"]["Color"]), ColorSequenceKeypoint.new(1, Value)})
                
                    if Options["BoxType"] == "Corner" then
                        for _, descendant in ESPPreview.Items.Corners.Instance:GetDescendants() do
                            if descendant:IsA("UIGradient") then
                                descendant.Color =  ColorSequence.new{ColorSequenceKeypoint.new(0, Options["Box Gradient 1"]["Color"]), ColorSequenceKeypoint.new(1, Value)}
                            end
                        end
                    end
                end
            })

            PlayersSection:Dropdown({
                Name = "Type",
                Flag = "Visuals/ESP/BoxType",
                Items = {"Normal", "Corner"},
                Default = "Corner",
                MaxSize = 100,
                Callback = function(Value)
                    MiscOptions["BoxType"] = Value
                    Options["BoxType"] = Value

                    --if not Options["Boxes"] then return end
                    
                    if Options["Boxes"] then
                        if Value == "Corner" then
                            ESPPreview:Set("BoxHolder", "Visible", false)
                            ESPPreview:Set("Corners", "Visible", true)
                        else
                            ESPPreview:Set("BoxHolder", "Visible", true)
                            ESPPreview:Set("Corners", "Visible", false)
                        end
                    end

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })
            
            PlayersSection:Slider({
                Name = "Rotation",
                Flag = "Visuals/ESP/BoxGradientRotation",
                Default = 90,
                Suffix = "°",
                Min = -180,
                Max = 180,
                Decimals = 1,
                Callback = function(Value)
                    Options["Box Gradient Rotation"] = Value
                    MiscOptions["Box Gradient Rotation"] = Value

                    ESPPreview:Set("BoxGradient", "Rotation", Value)
                end
            })

            local BoxesFilledToggle = PlayersSection:Toggle({
                Name = "Filled",
                Flag = "Visuals/ESP/BoxesFilled",
                Default = false,
                Callback = function(Value)
                    Options["Box Fill"] = Value
                    MiscOptions["Box Fill"] = Value

                    ESPPreview:Set("BoxHolder", "BackgroundTransparency", Value and 0 or 1)
                end
            })

            BoxesFilledToggle:Colorpicker({
                Name = "Gradient 1",
                Flag = "Visuals/ESP/Boxes/FilledGradient 1",
                Default = Options["Box Fill 1"].Color,
                Alpha = 0.3,
                Callback = function(Value, Alpha)
                    Options["Box Fill 1"] = {Color = Value, Transparency = Alpha}
                    MiscOptions["Box Fill 1"] = {Color = Value, Transparency = Alpha}

                    local Path = ESPPreview.Items.CornersGradient.Instance
                    Path.Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 1 - Alpha), 
                        Path.Transparency.Keypoints[2]
                    }

                    Path.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Value), 
                        Path.Color.Keypoints[2]
                    }

                    local Path = ESPPreview.Items.BoxHolderGradient.Instance
                    Path.Transparency = NumberSequence.new{
                        Path.Transparency.Keypoints[1],
                            NumberSequenceKeypoint.new(1, 1 - Alpha)
                        }

                    Path.Color = ColorSequence.new{
                        Path.Color.Keypoints[1],
                            ColorSequenceKeypoint.new(1, Value)
                        }
                end
            })

            BoxesFilledToggle:Colorpicker({
                Name = "Gradient 2",
                Flag = "Visuals/ESP/Boxes/FilledGradient 2",
                Default = Options["Box Fill 2"].Color,
                Alpha = 0.3,
                Callback = function(Value, Alpha)
                    Options["Box Fill 2"] = {Color = Value, Transparency = Alpha}
                    MiscOptions["Box Fill 2"] = {Color = Value, Transparency = Alpha}

                    local Path = ESPPreview.Items.CornersGradient.Instance
                    Path.Transparency = NumberSequence.new{
                        Path.Transparency.Keypoints[1],
                        NumberSequenceKeypoint.new(1, Alpha)
                    };

                    Path.Color = ColorSequence.new{
                        Path.Color.Keypoints[1],
                        ColorSequenceKeypoint.new(1, Value)
                    };

                    local Path = ESPPreview.Items.BoxHolderGradient.Instance
                    Path.Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, Alpha), 
                        Path.Transparency.Keypoints[2]
                    }

                    Path.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Value), 
                        Path.Color.Keypoints[2]
                    }
                end
            })

            PlayersSection:Slider({
                Name = "Rotation",
                Flag = "Visuals/ESP/BoxFillGradientRotation",
                Default = 90,
                Suffix = "°",
                Min = -180,
                Max = 180,
                Decimals = 1,
                Callback = function(Value)
                    MiscOptions["Box Fill Rotation"] = Value
                    Options["Box Fill Rotation"] = Value

                    ESPPreview:Set("BoxHolderGradient", "Rotation", Value)
                    ESPPreview:Set("CornersGradient", "Rotation", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            local HealthBarToggle = PlayersSection:Toggle({
                Name = "Healthbar",
                Flag = "Visuals/ESP/Healthbar",
                Default = false,
                Callback = function(Value)
                    MiscOptions["Healthbar"] = Value
                    Options["Healthbar"] = Value

                    ESPPreview:Set("HealthBar", "Visible", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Dropdown({
                Name = "Healthbar side",
                Flag = "Visuals/ESP/HealthbarSide",
                MaxSize = 145,
                Default = "Left",
                Items = {"Left", "Bottom", "Top", "Right"},
                Callback = function(Value)
                    Value = Value or "Left"
                    MiscOptions["Healthbar_Position"] = Value
                    Options["Healthbar_Position"] = Value

                    ESPPreview:Set("HealthBar", "Parent", ESPPreview.Items[Value].Instance or ESPPreview.Items.Left.Instance)

                    if Options["Healthbar_Position"] == "Right" then
                        ESPPreview:Set("HealthBarText", "Visible", Options["Healthbar_Number"])
                        ESPPreview:Set("HealthBarText", "AnchorPoint", Vector2.new(0, 0))
                        ESPPreview:Set("HealthBarText", "Position", UDim2.new(1, 5, 0, 0))
                    else
                        ESPPreview:Set("HealthBarText", "Visible", Options["Healthbar_Number"])
                        ESPPreview:Set("HealthBarText", "AnchorPoint", Vector2.new(1, 0))
                        ESPPreview:Set("HealthBarText", "Position", UDim2.new(0, -5, 0, 0))
                    end

                    if Options["Healthbar_Position"] == "Top" or Options["Healthbar_Position"] == "Bottom" then
                        ESPPreview:Set("HealthBarText", "Visible", false)
                    end

                    for _,newparent in {ESPPreview.Items.Left, ESPPreview.Items.Top, ESPPreview.Items.Right, ESPPreview.Items.Bottom} do 
                        if newparent.Instance == ESPPreview.Items.HealthBar.Instance.Parent then 
                            local isVertical =  _ % 2 == 1
                            ESPPreview.Items.HealthBar.Instance.Size = isVertical and UDim2.new(0, Options["Healthbar_Thickness"], 1, 0) or UDim2.new(1, 0, 0, Options["Healthbar_Thickness"])
                            ESPPreview.Items.Bar.Instance.Position = isVertical and UDim2.new(0, 1, 0, 1) or UDim2.new(0, 1, 0, 1)
                            ESPPreview.Items.Bar.Instance.Size = isVertical and UDim2.new(0, Options["Healthbar_Thickness"], 1, -2) or UDim2.new(1, -2, 0, Options["Healthbar_Thickness"])
                            ESPPreview.Items.BarGradient.Instance.Rotation = isVertical and -90 or 180
                             
                            return
                        end
                    end

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end
                end
            })

            HealthBarToggle:Colorpicker({
                Name = "Low",
                Default = Options["Healthbar_Low"].Color,
                Flag = "Visuals/ESP/HealthbarLow",
                Alpha = 0,
                Callback = function(Value, Alpha)
                    MiscOptions["Healthbar_Low"] = {Color = Value, Transparency = Alpha}

                    Options["Healthbar_Low"] = {Color = Value, Transparency = Alpha}

                    ESPPreview:Set("BarGradient", "Color", ColorSequence.new{ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(0.5, Options["Healthbar_Medium"].Color), ColorSequenceKeypoint.new(1, Options["Healthbar_High"].Color)})
                end
            })

            HealthBarToggle:Colorpicker({
                Name = "Medium",
                Default = Options["Healthbar_Medium"].Color,
                Flag = "Visuals/ESP/HealthbarMedium",
                Alpha = 0,
                Callback = function(Value, Alpha)
                    MiscOptions["Healthbar_Medium"] = {Color = Value, Transparency = Alpha}
                    Options["Healthbar_Medium"] = {Color = Value, Transparency = Alpha}
                    ESPPreview:Set("BarGradient", "Color", ColorSequence.new{ColorSequenceKeypoint.new(0, Options["Healthbar_Low"].Color), ColorSequenceKeypoint.new(0.5, Value), ColorSequenceKeypoint.new(1, Options["Healthbar_High"].Color)})
                end
            })

            HealthBarToggle:Colorpicker({
                Name = "High",
                Default = Options["Healthbar_High"].Color,
                Flag = "Visuals/ESP/HealthbarHigh",
                Alpha = 0,
                Callback = function(Value, Alpha)
                    MiscOptions["Healthbar_High"] = {Color = Value, Transparency = Alpha}
                    Options["Healthbar_High"] = {Color = Value, Transparency = Alpha}
                    ESPPreview:Set("BarGradient", "Color", ColorSequence.new{ColorSequenceKeypoint.new(0, Options["Healthbar_Low"].Color), ColorSequenceKeypoint.new(0.5, Options["Healthbar_Medium"].Color), ColorSequenceKeypoint.new(1, Value)})
                end
            })

            PlayersSection:Toggle({
                Name = "Healthbar Tween",
                Flag = "Visuals/ESP/HealthbarTween",
                Default = false,
                Callback = function(Value)
                    MiscOptions["Healthbar_Tween"] = Value
                    Options["Healthbar_Tween"] = Value
                end
            })

            PlayersSection:Dropdown({
                Name = "Tweening style",
                Flag = "Visuals/ESP/HealthbarTweenStyle",
                Default = "Linear",
                Items = {"Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential", "Circular", "Back", "Elastic", "Bounce"},
                MaxSize = 150,
                Callback = function(Value)
                    MiscOptions["Healthbar_EasingStyle"] = Value
                    Options["Healthbar_EasingStyle"] = Value
                end
            })

            PlayersSection:Dropdown({
                Name = "Tweening direction",
                Flag = "Visuals/ESP/HealthbarTweenDirection",
                MaxSize = 55,
                Default = "Out",
                Items = {"In", "Out", "InOut"},
                Callback = function(Value)
                    MiscOptions["Healthbar_EasingDirection"] = Value
                    Options["Healthbar_EasingDirection"] = Value
                end
            })

            PlayersSection:Slider({
                Name = "Tweening speed",
                Default = 1,
                Max = 10,
                Minimum = 0,
                Decimals = 0.01,
                Suffix = "s",
                Flag = "Visuals/ESP/HealthbarTweenSpeed",
                Callback = function(Value)
                    MiscOptions["Healthbar_Easing_Speed"] = Value
                    Options["Healthbar_Easing_Speed"] = Value
                end
            })

            PlayersSection:Toggle({
                Name = "Healthbar Number",
                Flag = "Visuals/ESP/HealthbarNumber",
                Default = false,
                Callback = function(Value)
                    MiscOptions["Healthbar_Number"] = Value

                    Options["Healthbar_Number"] = Value

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 

                    ESPPreview:Set("HealthBarText", "Visible", Value)
                end
            })

            PlayersSection:Slider({
                Name = "Healthbar Text Size",
                Flag = "Visuals/ESP/HealthbarTextSize",
                Max = 14,
                Min = 1,
                Default = 11,
                Suffix = "px",
                Decimals = 1,
                Callback = function(Value)
                    MiscOptions["Healthbar_Text_Size"] = Value

                    Options["Healthbar_Text_Size"] = Value

                    ESPPreview:Set("HealthBarText", "TextSize", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end
                end
            })

            PlayersSection:Slider({
                Name = "Healthbar Thickness",
                Flag = "Visuals/ESP/HealthbarThickness",
                Max = 10,
                Min = 1,
                Default = 1,
                Suffix = "px",
                Decimals = 1,
                Callback = function(Value)
                    MiscOptions["Healthbar_Thickness"] = Value

                    Options["Healthbar_Thickness"] = Value

                    ESPPreview:Set("HealthBar", "Size", UDim2.new(0, Value, 1, 0))

                    for _,newparent in {ESPPreview.Items.Left, ESPPreview.Items.Top, ESPPreview.Items.Right, ESPPreview.Items.Bottom} do 
                        if newparent.Instance == ESPPreview.Items.HealthBar.Instance.Parent then 
                            local isVertical =  _ % 2 == 1
                            ESPPreview.Items.HealthBar.Instance.Size = isVertical and UDim2.new(0, Options["Healthbar_Thickness"], 1, 0) or UDim2.new(1, 0, 0, Options["Healthbar_Thickness"])
                            ESPPreview.Items.Bar.Instance.Position = isVertical and UDim2.new(0, 1, 0, 1) or UDim2.new(0, 1, 0, 1)
                            ESPPreview.Items.Bar.Instance.Size = isVertical and UDim2.new(0, Options["Healthbar_Thickness"], 1, -2) or UDim2.new(1, -2, 0, Options["Healthbar_Thickness"])
                            ESPPreview.Items.BarGradient.Instance.Rotation = isVertical and -90 or 180
                             
                            return
                        end
                    end

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Dropdown({
                Name = "Healthbar Text Font",
                Items = {"ProggyClean", "Tahoma", "Verdana", "SmallestPixel", "ProggyTiny", "Minecraftia", "Tahoma Bold"},
                MaxSize = 200,
                Flag = "Visuals/ESP/HealthbarTextFont",
                Default = "Verdana",
                Multi = false,
                Callback = function(Value)
                    if not Value then Value = "ProggyClean" end
                    MiscOptions["Healthbar_Font"] = Value

                    Options["Healthbar_Font"] = Value

                    ESPPreview:Set("HealthBarText", "FontFace", ESPFonts[Value])

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection = Subpages["Player ESP"]:Section({Name = "Players - Info Labels", Side = 2, Icon = Library:GetImage("IdCard")})

            PlayersSection:Toggle({
                Name = "Name",
                Flag = "Visuals/ESP/NameText",
                Default = false,
                Callback = function(Value)
                    MiscOptions["Name_Text"] = Value

                    Options["Name_Text"] = Value

                    ESPPreview:Set("Name", "Visible", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            }):Colorpicker({
                Name = "Name Color",
                Flag = "Visuals/ESP/NameTextColor",
                Default = Color3.fromRGB(255, 255, 255),
                Alpha = 0,
                Callback = function(Value)
                    MiscOptions["Name_Text_Color"] = {Color = Value}
                    Options["Name_Text_Color"] = {Color = Value}

                    ESPPreview:Set("Name", "TextColor3", Value)

                     for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Dropdown({
                Name = "Name Text Font",
                Items = {"ProggyClean", "Tahoma", "Verdana", "SmallestPixel", "ProggyTiny", "Minecraftia", "Tahoma Bold"},
                MaxSize = 200,
                Flag = "Visuals/ESP/NameTextFont",
                Default = "Verdana",
                Multi = false,
                Callback = function(Value)
                    if not Value then Value = "ProggyClean" end

                    MiscOptions["Name_Text_Font"] = Value
                    Options["Name_Text_Font"] = Value

                    ESPPreview:Set("Name", "FontFace", ESPFonts[Value])

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Slider({
                Name = "Name Text Size",
                Flag = "Visuals/ESP/NameTextSize",
                Max = 14,
                Min = 1,
                Default = 11,
                Suffix = "px",
                Decimals = 1,
                Callback = function(Value)
                    MiscOptions["Name_Text_Size"] = Value

                    Options["Name_Text_Size"] = Value

                    ESPPreview:Set("Name", "TextSize", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Toggle({
                Name = 'Weapon',
                Flag = 'Visuals/ESP/WeaponText',
                Default = false,
                Callback = function(Value)
                    MiscOptions['Weapon_Text'] = Value

                    Options['Weapon_Text'] = Value

                    ESPPreview:Set('WeaponText', 'Visible', Value)

                    for index, value in MiscOptions do
                        Options[index] = value -- gotta trigger that new index
                    end
                end,
            }):Colorpicker({
                Name = 'Weapon Color',
                Flag = 'Visuals/ESP/WeaponTextColor',
                Default = Color3.fromRGB(255, 255, 255),
                Alpha = 0,
                Callback = function(Value)
                    MiscOptions['Weapon_Text_Color'] = { Color = Value }

                    Options['Weapon_Text_Color'] = { Color = Value }

                    ESPPreview:Set('WeaponText', 'TextColor3', Value)
                end,
            })

            PlayersSection:Dropdown({
                Name = 'Weapon Text Font',
                Items = {
                    'ProggyClean',
                    'Tahoma',
                    'Verdana',
                    'SmallestPixel',
                    'ProggyTiny',
                    'Minecraftia',
                    'Tahoma Bold',
                },
                MaxSize = 200,
                Flag = 'Visuals/ESP/WeaponTextFont',
                Default = 'Verdana',
                Multi = false,
                Callback = function(Value)
                    if not Value then
                        Value = 'ProggyClean'
                    end

                    MiscOptions['Weapon_Text_Font'] = Value

                    Options['Weapon_Text_Font'] = Value

                    ESPPreview:Set('WeaponText', 'FontFace', ESPFonts[Value])

                    for index, value in MiscOptions do
                        Options[index] = value -- gotta trigger that new index
                    end
                end,
            })

            PlayersSection:Slider({
                Name = 'Weapon Text Size',
                Flag = 'Visuals/ESP/WeaponTextSize',
                Max = 14,
                Min = 1,
                Default = 11,
                Suffix = 'px',
                Decimals = 1,
                Callback = function(Value)
                    MiscOptions['Weapon_Text_Size'] = Value

                    Options['Weapon_Text_Size'] = Value

                    ESPPreview:Set('WeaponText', 'TextSize', Value)

                    for index, value in MiscOptions do
                        Options[index] = value -- gotta trigger that new index
                    end
                end,
            })

            PlayersSection:Dropdown({
                Name = 'Weapon Side',
                Items = { 'Top', 'Bottom', 'Left', 'Right' },
                MaxSize = 200,
                Flag = 'Visuals/ESP/WeaponTextSide',
                Default = 'Bottom',
                Multi = false,
                Callback = function(Value)
                    if not Value then
                        Value = 'Left'
                    end

                    MiscOptions['Weapon_Text_Position'] = Value
                    Options['Weapon_Text_Position'] = Value

                    ESPPreview:Set('WeaponText', 'Parent', ESPPreview.Items[Value].Instance)

                    for index, value in MiscOptions do
                        Options[index] = value -- gotta trigger that new index
                    end
                end,
            })

            PlayersSection:Toggle({
                Name = "Distance",
                Flag = "Visuals/ESP/DistanceText",
                Default = false,
                Callback = function(Value)
                    MiscOptions["Distance_Text"] = Value

                    Options["Distance_Text"] = Value

                    ESPPreview:Set("Distance", "Visible", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            }):Colorpicker({
                Name = "Distance Color",
                Flag = "Visuals/ESP/DistanceTextColor",
                Default = Color3.fromRGB(255, 255, 255),
                Alpha = 0,
                Callback = function(Value)
                    MiscOptions["Distance_Text_Color"] = {Color = Value}

                    Options["Distance_Text_Color"] = {Color = Value}

                    ESPPreview:Set("Distance", "TextColor3", Value)
                end
            })

            PlayersSection:Dropdown({
                Name = "Distance Text Font",
                Items = {"ProggyClean", "Tahoma", "Verdana", "SmallestPixel", "ProggyTiny", "Minecraftia", "Tahoma Bold"},
                MaxSize = 200,
                Flag = "Visuals/ESP/DistanceTextFont",
                Default = "Verdana",
                Multi = false,
                Callback = function(Value)
                    if not Value then Value = "ProggyClean" end

                    MiscOptions["Distance_Text_Font"] = Value

                    Options["Distance_Text_Font"] = Value

                    ESPPreview:Set("Distance", "FontFace", ESPFonts[Value])

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Slider({
                Name = "Distance Text Size",
                Flag = "Visuals/ESP/DistanceTextSize",
                Max = 14,
                Min = 1,
                Default = 11,
                Suffix = "px",
                Decimals = 1,
                Callback = function(Value)
                    MiscOptions["Distance_Text_Size"] = Value

                    Options["Distance_Text_Size"] = Value

                    ESPPreview:Set("Distance", "TextSize", Value)

                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Dropdown({
                Name = "Distance Side",
                Items = {"Top", "Bottom", "Left", "Right"},
                MaxSize = 200,
                Flag = "Visuals/ESP/DistanceTextSide",
                Default = "Bottom",
                Multi = false,
                Callback = function(Value)
                    if not Value then Value = "Left" end

                    MiscOptions["Distance_Text_Position"] = Value
                    Options["Distance_Text_Position"] = Value

                    ESPPreview:Set("Distance", "Parent", ESPPreview.Items[Value].Instance)
                    
                    for index,value in MiscOptions do 
                        Options[index] = value -- gotta trigger that new index
                    end 
                end
            })

            PlayersSection:Slider({
                Name = "Max Render Distance",
                Flag = "Visuals/ESP/MaxRenderDistance",
                Max = 5000,
                Min = 50,
                Default = 500,
                Suffix = "m",
                Decimals = 1,
                Callback = function(Value)
                    MiscOptions["Render_Distance"] = Value
                end
            })

            local Ambient_Section = Subpages["World"]:Section({Name = "Ambient Utilities", Side = 1, Icon = Library:GetImage("Cloud")})

            Ambient_Section:Toggle({Name = "Enabled", Flag = "ThaBronx3/Visuals/Ambient/Enabled", Callback = function(State)
                Config.WorldVisuals.AmbientEnabled = State
            end})

            Ambient_Section:Label("Color"):Colorpicker({
                Name = "Ambient Color",
                Flag = "ThaBronx3/Visuals/Ambient/Color",
                Default = Color3.fromRGB(255, 255, 255),
                Alpha = 0,
                Callback = function(Value)
                    Config.WorldVisuals.AmbientColor = Value
                end
            })

            local Saturation_Section = Subpages["World"]:Section({Name = "Saturation Utilities", Side = 1, Icon = Library:GetImage("Contrast")})

            Saturation_Section:Toggle({Name = "Enabled", Flag = "ThaBronx3/Visuals/Saturation/Enabled", Callback = function(State)
                Config.WorldVisuals.SaturationEnabled = State
            end})
            
            Saturation_Section:Slider({
                Name = "Saturation Increase Value",
                Flag = "ThaBronx3/Visuals/Saturation/Value",
                Max = 200,
                Min = 0,
                Default = 50,
                Suffix = "%",
                Decimals = 1,
                Callback = function(Value)
                    Config.WorldVisuals.Saturation_Value = Value/100
                end
            })
    
            local FieldOfView_Section = Subpages["World"]:Section({Name = "Field Of View Utilities", Side = 1, Icon = Library:GetImage("EyeTracking")})

            FieldOfView_Section:Toggle({Name = "Enabled", Flag = "ThaBronx3/Visuals/FieldOfView/Enabled", Callback = function(State)
                Config.WorldVisuals.FieldOfViewEnabled = State
            end})
            
            FieldOfView_Section:Slider({
                Name = "Field Of View Value",
                Flag = "ThaBronx3/Visuals/FieldOfView/Value",
                Max = 120,
                Min = 0,
                Default = 70,
                Suffix = "°",
                Decimals = 1,
                Callback = function(Value)
                    Config.WorldVisuals.FieldOfViewValue = Value
                end
            })

            local Tracers_Section = Subpages["World"]:Section({Name = "Tracer Utilities", Side = 2, Icon = Library:GetImage("TrailShort")})

            Tracers_Section:Toggle({Name = "Enabled", Flag = "ThaBronx3/Tracers/Enabled", Callback = function(State)
                Config.Tracers.Enabled = State
            end})

            local Tracer_Label = Tracers_Section:Label("Tracer Colors")

            Tracer_Label:Colorpicker({
                Name = "Start Color",
                Flag = "Visuals/Tracers/Color1",
                Default = Color3.fromRGB(236,23,23),
                Alpha = 0,
                Callback = function(Value)
                    Config.Tracers.StartColor = Value
                end
            })

            Tracer_Label:Colorpicker({
                Name = "End Color",
                Flag = "Visuals/Tracers/Color2",
                Default = Color3.fromRGB(0, 0, 0),
                Alpha = 0,
                Callback = function(Value)
                    Config.Tracers.EndColor = Value
                end
            })

            Tracers_Section:Slider({
                Name = "Tracer Duration",
                Flag = "Visuals/Tracers/Duration",
                Max = 10,
                Min = 0,
                Default = 3,
                Suffix = "s",
                Decimals = 0.1,
                Callback = function(Value)
                    Config.Tracers.Duration = Value
                end
            })

            Tracers_Section:Toggle({Name = "Rainbow", Flag = "ThaBronx3/Tracers/Rainbow", Callback = function(State)
                Config.Tracers.Rainbow = State
            end})

            local Stretched_Res_Section = Subpages["World"]:Section({Name = "Stretched Resolution Utilities", Side = 2, Icon = Library:GetImage("ScreenRotation")})

            Stretched_Res_Section:Toggle({Name = "Enabled", Flag = "ThaBronx3/Stretch/Enabled", Tooltip = "This will mess with tha bronx 3's aiming system.", Callback = function(State)
                Config.WorldVisuals.StretchEnabled = State
            end})

            Stretched_Res_Section:Slider({
                Name = "Stretch Value",
                Flag = "Visuals/Stretch/Value",
                Max = 1,
                Min = 0,
                Default = 0.7,
                Suffix = "",
                Decimals = 0.01,
                Callback = function(Value)
                    Config.WorldVisuals.StretchValue = Value
                end
            })

            local Fullbright_Section = Subpages["World"]:Section({Name = "Fullbright Utilities", Side = 2, Icon = Library:GetImage("LightBulb")})

            Fullbright_Section:Toggle({Name = "Enabled", Flag = "ThaBronx3/Fullbright/Enabled", Callback = function(State)
                Config.WorldVisuals.Fullbright = State
            end})
        end

        do -- Main
            local Subpages = {
                ["Player"] = Pages["Main"]:SubPage({
                    Name = "Local Player", 
                    Icon = Library:GetImage("AccountCircle"), 
                    Columns = 2
                }),
                ["Players"] = Pages["Main"]:SubPage({
                    Name = "Other Players", 
                    Icon = Library:GetImage("DeployedCodeAccount"), 
                    Columns = 2
                }),
                ["Teleports"] = Pages["Main"]:SubPage({
                    Name = "Teleports", 
                    Icon = Library:GetImage("TravelExplore"), 
                    Columns = 2
                }),
                ["Money"] = Pages["Main"]:SubPage({
                    Name = "Money", 
                    Icon = Library:GetImage("MoneySymbol"), 
                    Columns = 2
                }),
                ["Vehicles"] = Pages["Main"]:SubPage({
                    Name = "Vehicles", 
                    Icon = Library:GetImage("Scrambler"), 
                    Columns = 2
                }),
            }

            do -- Player
                local LocalPlayer_Modification_Section = Subpages["Player"]:Section({Name = "Local Player Modifications", Icon = Library:GetImage("NewController30px"), Side = 1})

                local __Modifications = {
                    "Infinite Sleep";
                    "Infinite Hunger";
                    "Infinite Stamina";
                    "Instant Interact";
                    "Instant Revive";
                    "Auto Pickup Cash";
                    "Auto Pickup Bags";
                    "Disable Camera Bobbing";
                    --"Disable Cameras";
                    "Disable Blood Effects";
                    "Bypass Locked Cars";
                    "No Jump Cooldown";
                    "No Rent Pay";
                    "No Fall Damage";
                    "No Knockback";
                    "Faster Respawn";
                    "Respawn Where You Died";
                }

                for _, Index in __Modifications do
                    LocalPlayer_Modification_Section:Toggle({
                        Name = Index,
                        Flag = "TheBronx3/LocalPlayerModifications/"..Index,
                        Default = false,
                        Callback = function(Value)
                            Config.The_Bronx.PlayerModifications[Index:gsub(" ", "")] = Value
                        end
                    })
                end

                local UI_Modification_Section = Subpages["Player"]:Section({Name = "User Interface Utilities", Icon = Library:GetImage("IdCard"), Side = 2})
                
                local _UINames, BlacklistedNames = {'ATM GUI'}, {"Dead", "Settings1", "Controls", "FirstShopGUI", "Freecam", "ThaShop2", "WATCH GUI", "NYPD Cars", "CONSTRUCTION LEVEL", "RobPlayerUI", "Bronx LOCKER", 'MobileBeam', 'Settings', 'Flash', 'Enter', 'CopSirens'}

                for Index, Value in LocalPlayer.PlayerGui:GetChildren() do
                    if Value:IsA("ScreenGui") and not Value.Enabled then
                        if table.find(BlacklistedNames, Value.Name) then continue end
                        table.insert(_UINames, Value.Name)
                    end
                end 

                UI_Modification_Section:Dropdown({Name = "Select Interface", Items = _UINames, Flag = "TheBronx3/UserInterfaces/Value", MaxSize = 175, Multi = false})

                ToggleInterface_Toggle = nil;
                ToggleInterface_Toggle = UI_Modification_Section:Toggle({Name = "Toggle Interface", Flag = "TheBronx3/UserInterfaces/Enabled", Default = false, Callback = LPH_NO_VIRTUALIZE(function(State)
                    if not Library.Flags["TheBronx3/UserInterfaces/Value"] then return end

                    if Library.Flags["TheBronx3/UserInterfaces/Value"] == "ATM GUI" then
                        local SelectedUI = LocalPlayer.PlayerGui:FindFirstChild("ATMGui")

                        if not SelectedUI and State then
                            local _Clone = Lighting.Assets.GUI.ATMGui:Clone()
                            _Clone.Parent = LocalPlayer.PlayerGui
                            SelectedUI = _Clone
                            _Clone.Frame.closeBtn.MouseButton1Click:Connect(function()
                                ToggleInterface_Toggle:Set(false)
                                --_Clone:Destroy()
                            end)
                        end

                        if not State and SelectedUI then
                            SelectedUI:Destroy()
                        end

                        local Old_UI_Value = Library.Flags["TheBronx3/UserInterfaces/Value"]

                        repeat task.wait() until Library.Flags["TheBronx3/UserInterfaces/Value"] ~= Old_UI_Value

                        if SelectedUI then
                            SelectedUI:Destroy()
                        end

                        if ToggleInterface_Toggle then
                            ToggleInterface_Toggle:Set(false)
                        end

                        return
                    end

                    local SelectedUI = LocalPlayer.PlayerGui:FindFirstChild(Library.Flags["TheBronx3/UserInterfaces/Value"])

                    if SelectedUI then
                        SelectedUI.Enabled = State

                        local Old_UI_Value = Library.Flags["TheBronx3/UserInterfaces/Value"]

                        repeat RunService.Heartbeat:Wait() until Library.Flags["TheBronx3/UserInterfaces/Value"] ~= Old_UI_Value or not SelectedUI.Enabled or not LocalPlayer.PlayerGui:FindFirstChild(Old_UI_Value)

                        SelectedUI.Enabled = false
                        if ToggleInterface_Toggle then
                            ToggleInterface_Toggle:Set(false)
                        end
                    end 
                end)})

                local LocalCharacter_Modification_Section = Subpages["Player"]:Section({Name = "Local Character Modifications", Icon = Library:GetImage("PlayerUtilties"), Side = 2})

                local Connection_1, Connection_2 = nil, nil

                local SpeedBind = nil;
                local SpeedToggle = LocalCharacter_Modification_Section:Toggle({Name = "Modify WalkSpeed", Flag = "ModifyWalkSpeed/TheBronx", Default = false, Callback = function(State)
                    Config.MiscSettings.ModifySpeed.Enabled = State

                    if State then
                        if not Connection_1 then
                            Connection_1 = RunService.PreSimulation:Connect(LPH_JIT_MAX(function()
                                RootPart.Anchored = false;
                            end))
                        end

                        if not Connection_2 then
                            Connection_2 = RunService.PostSimulation:Connect(LPH_JIT_MAX(function()
                                RootPart.Anchored = true;
                            end))
                        end
                    else
                        task.delay(1.5, function()
                            RootPart.Anchored = false;

                            if Connection_1 then
                                Connection_1:Disconnect()
                                Connection_1 = nil
                            end

                            if Connection_2 then
                                Connection_2:Disconnect()
                                Connection_2 = nil
                            end

                            RootPart.Anchored = false;
                        end)
                    end

                    if State and SpeedBind and SpeedBind.Toggled == false then
                        SpeedBind:Press(true)
                    end

                    if not State and SpeedBind and SpeedBind.Toggled == true then
                        SpeedBind:Press(false)
                    end
                end})

                SpeedBind = SpeedToggle:Keybind({Name = "Modify WalkSpeed", Flag="SpeedBind",Default=Enum.KeyCode.X,Mode="toggle",Callback=function(State)
                    SpeedToggle:Set(State)
                end})

                LocalCharacter_Modification_Section:Toggle({Name = "Modify JumpPower", Flag = "ModifyJumpPower/TheBronx", Default = false, Callback = function(State)
                    Config.MiscSettings.ModifyJump.Enabled = State
                end})

                LocalCharacter_Modification_Section:Toggle({Name = "Click Teleport Enabled", Flag = "ClickTeleportEnabled/TheBronx", Default = false, Callback = function(State)
                    Config.MiscSettings.ClickTeleport_Enabled = State
                end})

                local Actively_NoClipping = false;
                local _NoClipBind = nil;
                local _NoClipToggle = LocalCharacter_Modification_Section:Toggle({Name = "No-Clip", Flag = "No_Clip", Default = false, Callback = function(State)
                    if State and _NoClipBind and _NoClipBind.Toggled == false then
                        _NoClipBind:Press(true)
                    end

                    if not State and _NoClipBind and _NoClipBind.Toggled == true then
                        _NoClipBind:Press(false)
                    end

                    if State then
                        if not Actively_NoClipping then
                            Actively_NoClipping = true
                            RunService:BindToRenderStep("No_Clip", 400, LPH_NO_VIRTUALIZE(function()
                                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                                    if LocalPlayer.Character.Humanoid.Health ~= 0 then
                                        for Index, Value in LocalPlayer.Character:GetDescendants() do
                                            if Player_Collide_Data[Value.Name] then
                                                pcall(function()
                                                    Value.CanCollide = false
                                                end)
                                            end
                                        end
                                    else
                                        for Index, Value in LocalPlayer.Character:GetDescendants() do
                                            if Player_Collide_Data[Value.Name] then
                                                pcall(function()
                                                    Value.CanCollide = true
                                                end)
                                            end
                                        end
                                    end
                                end
                            end))
                        end
                    else
                        RunService:UnbindFromRenderStep("No_Clip")
                        Actively_NoClipping = false

                        for Index, Value in LocalPlayer.Character:GetDescendants() do
                            if Player_Collide_Data[Value.Name] then
                                pcall(function()
                                    Value.CanCollide = true
                                end)
                            end
                        end
                    end
                end})
                
                _NoClipBind = _NoClipToggle:Keybind({Name = "No-Clip", Flag="NoClipBind",Default=Enum.KeyCode.N,Mode="toggle",Callback=function(State)
                    _NoClipToggle:Set(State)
                end})

                LocalCharacter_Modification_Section = Subpages["Player"]:Section({Name = "Local Character Modification Settings", Icon = Library:GetImage("Tune"), Side = 2})

                local ClickKeyLabel = LocalCharacter_Modification_Section:Label("Click Teleport Key")

                local Key; Key = ClickKeyLabel:Keybind({Name = "Click Teleport Bind", Flag="ClickTeleport_Bind",Default=Enum.KeyCode.LeftControl,Mode="hold",Callback=function(State)
                    if Key then 
                        Config.MiscSettings.ClickTeleport_Key = Enum.KeyCode[tostring(select(2, Key:Get()):gsub("Enum.KeyCode.", ""))]
                    end
                end})

                LocalCharacter_Modification_Section:Slider({
                    Name = "WalkSpeed Value",
                    Flag = "TheBronx3/WalkSpeedValue",
                    Default = 50,
                    Min = 16,
                    Max = 150,
                    Decimals = 1,
                    Callback = function(Value)
                        Config.MiscSettings.ModifySpeed.Value = Value
                    end
                })

                LocalCharacter_Modification_Section:Slider({
                    Name = "JumpPower Value",
                    Flag = "TheBronx3/JumpPowerValue",
                    Default = 7,
                    Min = 0,
                    Max = 100,
                    Decimals = 1,
                    Callback = function(Value)
                        Config.MiscSettings.ModifyJump.Value = Value
                    end
                })
            end

            do -- Other Players
                do -- Player Info
                    local Format_Money = LPH_NO_VIRTUALIZE(function(amount)
                        local formatted = tostring(amount)
                        local k
                        while true do  
                            formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
                            if k == 0 then break end
                        end
                        return "$" .. formatted
                    end)

                    local SelectedPlayer_Section = Subpages["Players"]:Section({Name = "Selected Player Info", Icon = Library:GetImage("DataLossPrevention"), Side = 2})
                    
                    local NameLabel = SelectedPlayer_Section:Label("Selected Player : None")
                    local UserId_Label = SelectedPlayer_Section:Label("User Id : None")
                    local CleanMoney_Label = SelectedPlayer_Section:Label("Clean Money : None")
                    local DirtyMoney_Label = SelectedPlayer_Section:Label("Dirty Money : None")

                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        while task.wait(.1) do
                            if Library.Selected_Player then
                                NameLabel:SetText(string.format("Selected Player : @%s", Library.Selected_Player.Name))
                                UserId_Label:SetText(string.format("User Id : %s", Library.Selected_Player.UserId))
                            else
                                NameLabel:SetText("Selected Player : None")
                                UserId_Label:SetText("User Id : None")
                            end

                            if Library.Selected_Player and Library.Selected_Player:FindFirstChild("stored") and Library.Selected_Player:FindFirstChild("stored"):FindFirstChild("Money") and Library.Selected_Player:FindFirstChild("stored"):FindFirstChild("FilthyStack") then
                                CleanMoney_Label:SetText("Clean Money : "..Format_Money(Library.Selected_Player:FindFirstChild("stored"):FindFirstChild("Money").Value))
                                DirtyMoney_Label:SetText("Dirty Money : "..Format_Money(Library.Selected_Player:FindFirstChild("stored"):FindFirstChild("FilthyStack").Value))
                            else
                                CleanMoney_Label:SetText("Clean Money : None")
                                DirtyMoney_Label:SetText("Dirty Money : None")
                            end
                        end
                    end))
                end

                do -- Player Options
                    local SelectedPlayer_Section = Subpages["Players"]:Section({Name = "Selected Player Utilities", Icon = Library:GetImage("IdentityPlatform"), Side = 1})

                    SelectedPlayer_Section:Toggle({
                        Name = "Spectate Player",
                        Flag = "SpectatePlayer/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.PlayerUtilities.SpectatePlayer = State
                        end
                    })

                    SelectedPlayer_Section:Toggle({
                        Name = "Bring Player",
                        Flag = "BringPlayer/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.PlayerUtilities.BringingPlayer = State
                        end
                    })

                    SelectedPlayer_Section:Toggle({
                        Name = "Bug / Kill Player - Car",
                        Flag = "BugPlayer/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.PlayerUtilities.BugPlayer = State
                        end
                    })

                    SelectedPlayer_Section:Toggle({
                        Name = "Auto Kill Player - Gun",
                        Flag = "AutoKillPlayer/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.PlayerUtilities.AutoKill = State
                        end
                    })

                    SelectedPlayer_Section:Toggle({
                        Name = "Auto Ragdoll Player - Gun",
                        Flag = "AutoRagdollPlayer/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.PlayerUtilities.AutoRagdoll = State
                        end
                    })

                    SelectedPlayer_Section:Button({
                        Name = "Teleport To Player",
                        Callback = function()
                            if Players:FindFirstChild(Library.Selected_Player.Name) and Players:FindFirstChild(Library.Selected_Player.Name).Character then
                                Config:Teleport(Players[Library.Selected_Player.Name].Character.HumanoidRootPart.CFrame)
                            end
                        end
                    })

                    SelectedPlayer_Section:Button({
                        Name = "Down Player - Hold Gun",
                        Callback = function()
                            Config:GunRemote(Library.Selected_Player.Name, "HumanoidRootPart", (Players[Library.Selected_Player.Name].Character.Humanoid.Health - 5))
                        end
                    })

                    SelectedPlayer_Section:Button({
                        Name = "Kill Player - Hold Gun",
                        Callback = function()
                            Config:GunRemote(Library.Selected_Player.Name, "HumanoidRootPart", math.huge)
                        end
                    })

                    SelectedPlayer_Section:Button({
                        Name = "God Player - Hold Gun",
                        Tooltip = "This will break the player's gun system and movement systems.",
                        Callback = function()
                            Config:GunRemote(Library.Selected_Player.Name, "HumanoidRootPart", math.sqrt(-1))
                        end
                    })

                    SelectedPlayer_Section = Subpages["Players"]:Section({Name = "Global Player Utilities", Icon = Library:GetImage("Groups"), Side = 2})

                    SelectedPlayer_Section:Button({
                        Name = "God All Players - Hold Gun",
                        Tooltip = "This will break their gun systems and movement systems.",
                        Callback = function()
                            for Index, Value in Players:GetPlayers() do
                                if Value ~= LocalPlayer and Value.Character and Value.Character:FindFirstChild("Humanoid") and Value.Character:FindFirstChild("Humanoid").Health ~= 0 and not Value.Character:FindFirstChildOfClass("ForceField") and Value.Character:FindFirstChild("HumanoidRootPart") then
                                    if Players:FindFirstChild(Value.Name) then
                                        Config:GunRemote(Value.Name, "HumanoidRootPart", math.sqrt(-1))
                                        task.wait(0.01)
                                    end
                                end
                            end
                        end
                    })

                    SelectedPlayer_Section:Button({
                        Name = "Kill All Players - Hold Gun",
                        Callback = function()
                            for Index, Value in Players:GetPlayers() do
                                if Value ~= LocalPlayer and Value.Character and Value.Character:FindFirstChild("Humanoid") and Value.Character:FindFirstChild("Humanoid").Health ~= 0 and not Value.Character:FindFirstChildOfClass("ForceField") and Value.Character:FindFirstChild("HumanoidRootPart") then
                                    if Players:FindFirstChild(Value.Name) then
                                        Config:GunRemote(Value.Name, "HumanoidRootPart", math.huge)
                                        task.wait(0.01)
                                    end
                                end
                            end
                        end
                    })
                end
            end

            do -- Money
                do -- Auto Farms
                    local AutoFarm_Section = Subpages["Money"]:Section({Name = "Auto-Farm Utilities", Icon = Library:GetImage("MoneyBag"), Side = 1})

                    AutoFarm_Section:Toggle({
                        Name = "Auto Farm Construction",
                        Flag = "FarmConstruction/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.FarmConstructionJob = State
                        end
                    })

                    AutoFarm_Section:Toggle({
                        Name = "Auto Farm Bank Robbery",
                        Flag = "FarmBank/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.FarmBank = State
                        end
                    })

                    AutoFarm_Section:Toggle({
                        Name = "Auto Farm House Robbery",
                        Flag = "FarmHouses/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.FarmHouses = State
                        end
                    })

                    AutoFarm_Section:Toggle({
                        Name = "Auto Farm Studio Robbery",
                        Flag = "FarmStudio/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.FarmStudio = State
                        end
                    })

                    AutoFarm_Section:Toggle({
                        Name = "Auto Farm Dumpsters",
                        Flag = "FarmDumpsters/TheBronx",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.FarmTrash = State
                        end
                    })

                    AutoFarm_Section = Subpages["Money"]:Section({Name = "Auto-Farm Settings", Icon = Library:GetImage("Wrench"), Side = 1})

                    AutoFarm_Section:Toggle({
                        Name = "Idle Safety Teleport",
                        Flag = "TheBronx3/AFKSafetyTeleport",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.AFKCheck = State
                        end
                    })
                    
                    AutoFarm_Section:Toggle({
                        Name = "Auto Sell Trash",
                        Flag = "TheBronx3/AutoSellTrash",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.AutoSellTrash = State
                        end
                    })

                    local ManualFarm_Section = Subpages["Money"]:Section({Name = "Manual Utilities", Icon = Library:GetImage("AutoManifacturing"), Side = 2})

                    ManualFarm_Section:Toggle({
                        Name = "Auto Collect Dropped Cash",
                        Flag = "TheBronx3/CollectDroppedCash",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.CollectDroppedMoney = State
                        end
                    })

                    ManualFarm_Section:Toggle({
                        Name = "Auto Collect Dropped Loot",
                        Flag = "TheBronx3/CollectDroppedLoot",
                        Tooltip = "You need the looting gamepass for this!",
                        Default = false,
                        Callback = function(State)
                            Config.The_Bronx.Farms.CollectDroppedLoot = State
                        end
                    })

                    ManualFarm_Section:Button({Name = "Clean All Filthy Money", Callback = function()
                        if LocalPlayer.stored.FilthyStack.Value == 0 then 
                            return Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "You don't have any filthy cash!",
                                Duration = 5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end

                        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
                        if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then return end
            
                        local Cleaner = Config:GetGoodCleaner()
                        
                        if not Cleaner then
                            return Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "Couldn't find a good cleaner!",
                                Duration = 5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end
            
                        Config:Teleport(Cleaner.WorldPivot)
            
                        task.wait(0.4)
            
                        fireproximityprompt(Cleaner:FindFirstChild("CashPrompt", true))
            
                        repeat task.wait() until Cleaner:FindFirstChild("On", true).Color == Color3.fromRGB(74, 156, 69)
            
                        task.wait(0.5)
            
                        fireproximityprompt(Cleaner:FindFirstChild("CashPrompt", true))
                        
                        task.wait(0.25)
            
                        Config:Teleport(Cleaner.WorldPivot)
            
                        task.wait(0.4)
            
                        repeat task.wait() until LocalPlayer.Backpack:FindFirstChild("MoneyReady")
            
                        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack["MoneyReady"])
            
                        repeat task.wait(1) fireproximityprompt(Cleaner:FindFirstChild("GrabPrompt", true)) until not LocalPlayer.Character:FindFirstChild("MoneyReady")
                        
                        repeat task.wait()
                        until LocalPlayer.Backpack:FindFirstChild("BagOfMoney")
            
                        Config:Teleport(CFrame.new(-222, 284, -1201))
            
                        task.wait(0.4)
            
                        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack["BagOfMoney"])
            
                        task.wait(1)
            
                        fireproximityprompt(Workspace.ATMMoney.Prompt)
                    end})
                end 

                do -- Vulns
                    local Vuln_Section = Subpages["Money"]:Section({Name = "Vulnerabilities", Icon = Library:GetImage("EncryptedOff"), Side = 2})

                    local GetFruitCup = LPH_NO_VIRTUALIZE(function()
                        local Found, Cup = false, nil;

                        for Index, Value in next, {LocalPlayer.Backpack:GetChildren(), LocalPlayer.Character:GetChildren()} do
                            for _Index, _Value in Value do
                                if _Value:IsA("Tool") and _Value.Name == "Ice-Fruit Cupz" then
                                    if _Value["IceFruit Cup"]["IceFruit PunchMedium"].Transparency ~= 1 then
                                        Found = true
                                        Cup = _Value
                                        break
                                    end
                                end
                            end
                        end 

                        return Found, Cup
                    end)

                    Vuln_Section:Button({Name = "Generate Max Illegal Money", Tooltip = "You will need around $5,000 to do this.\nIt might take around 2-3 minutes.", Callback = function()
                        local Found, Cup = GetFruitCup()

                        if Cup and Found then
                            Config:HideScreen("generating illegal cash 💷\n please wait.")

                            local OLDCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

                            if Cup.Parent == LocalPlayer.Backpack then
                                LocalPlayer.Character.Humanoid:EquipTool(Cup)
                                task.wait(1)
                            end 

                            Config:Teleport(Workspace["IceFruit Sell"].CFrame)

                            task.wait(.5)

                            for Index=1, 4000 do
                                task.spawn(function()
                                    fireproximityprompt(Workspace["IceFruit Sell"].ProximityPrompt)
                                end)
                            end

                            Config:Teleport(OLDCFrame)

                            return
                        end

                        Config:HideScreen("buying products 🍉\nif you are stuck here, PLEASE WAIT!!")

                        local OLDCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

                        local Itemz = {"FijiWater", "FreshWater", "Ice-Fruit Bag", "Ice-Fruit Cupz"}
                        local Stove;

                        for Index, Value in Workspace.CookingPots:GetChildren() do
                            if Value:IsA("Model") then
                                if Value:FindFirstChildWhichIsA("ProximityPrompt", true).ActionText == "Turn On" and Value:FindFirstChildWhichIsA("ProximityPrompt", true).Enabled then
                                    Stove = Value

                                    break
                                end
                            end
                        end

                        for Index, Value in Itemz do
                            if not LocalPlayer.Backpack:FindFirstChild(Value) then
                                ReplicatedStorage:WaitForChild("ExoticShopRemote"):InvokeServer(Value)
                                task.wait(1)
                            end
                        end

                        local Check = false;

                        for Index, Value in Itemz do
                            if not LocalPlayer.Backpack:FindFirstChild(Value) then
                                Check = true
                            end
                        end

                        if Check then
                            Config:DeleteHiddenScreen()
                            Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "Couldn't find the items! Please make sure you have more than $5,000",
                                Duration = 10,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                            return
                        end

                        Config:SetText("generating illegal cash 💷\n this takes around 1-2 minutes.\n please wait.")

                        Config:Teleport(Stove.CookPart.CFrame)

                        task.wait(1)

                        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                        LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        task.wait(1.5)

                        fireproximityprompt(Stove:FindFirstChildWhichIsA("ProximityPrompt", true))

                        task.wait(2)

                        for Index, Value in {"FijiWater", "FreshWater", "Ice-Fruit Bag"} do
                            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack[Value])
                            task.wait(1)
                            fireproximityprompt(Stove:FindFirstChildWhichIsA("ProximityPrompt", true))
                            task.wait(3)
                        end

                        repeat wait() until 
                        Stove.CookPart.Steam.LoadUI.Enabled == false

                        if not LocalPlayer.Character:FindFirstChild("Ice-Fruit Cupz") then
                            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack['Ice-Fruit Cupz'])
                            task.wait(1)
                        end
                        
                        task.wait(1)

                        fireproximityprompt(Stove:FindFirstChildWhichIsA("ProximityPrompt", true))

                        task.wait(3)

                        LocalPlayer.Character.HumanoidRootPart.Anchored = false

                        Config:Teleport(Workspace["IceFruit Sell"].CFrame)

                        task.wait(1)

                        LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        task.wait(1.5)

                        if not LocalPlayer.Character:FindFirstChild("Ice-Fruit Cupz") then
                            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack['Ice-Fruit Cupz'])
                            task.wait(1)
                        end

                        Workspace["IceFruit Sell"].ProximityPrompt.HoldDuration = 0

                        for Index=1, 4000 do
                            task.spawn(function()
                                fireproximityprompt(Workspace["IceFruit Sell"].ProximityPrompt)
                            end)
                        end

                        LocalPlayer.Character.HumanoidRootPart.Anchored = false
                        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

                        task.wait(0.5)

                        Config:Teleport(OLDCFrame)

                        task.wait(2)

                        Config:DeleteHiddenScreen()
                    end})

                    local Cooldown = false; Vuln_Section:Button({Name = "Duplicate Current Item", Tooltip = "You need to hold the gun you're trying to dupe.\nIf it doesn't work, retry.", Callback = function()
                        if Cooldown then
                            Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "Cooldown! Please wait.",
                                Duration = 5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                            return
                        end

                        Cooldown = true
                        local Player = Players.LocalPlayer
                        local Backpack = Player.Backpack

                        local Tool = Player.Character:FindFirstChildOfClass("Tool")

                        if not Tool then
                            Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "Couldn't find your tool! Please make sure you're holding one.",
                                Duration = 10,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                            return
                        end

                        Player.Character.Humanoid:UnequipTools()

                        local ToolName = Tool.Name
                        local ToolId

                        local Connection = ReplicatedStorage.MarketItems.ChildAdded:Connect(
                            function(item)

                                if item.Name == ToolName then
                                    if item:WaitForChild('owner').Value == Player.Name then
                                        ToolId = item:GetAttribute('SpecialId')
                                    end
                                end
                            end
                        )

                        spawn(function()
                            ReplicatedStorage.ListWeaponRemote:FireServer(ToolName, 99999)
                        end)

                        task.wait(.26)

                        spawn(function()
                            ReplicatedStorage.BackpackRemote:InvokeServer('Store', ToolName)
                        end)

                        task.wait(3)

                        spawn(function()
                            ReplicatedStorage.BuyItemRemote:FireServer(ToolName, 'Remove', ToolId)
                        end)

                        spawn(function()
                            ReplicatedStorage.BackpackRemote:InvokeServer("Grab", ToolName)
                        end)

                        Connection:Disconnect()

                        task.wait(3)

                        Cooldown = false
                    end})

                    local ToolName;
                    Vuln_Section:Toggle({Name = "Automatically Dupe Current Item",  Tooltip = "You need to hold the gun you're trying to dupe.", Flag = "TheBronx3/AutoDupe", Callback = function(State)
                        local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")

                        if not Tool and State then
                            Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "Couldn't find your tool! Please make sure you're holding one.",
                                Duration = 10,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                            return
                        end

                        if Tool and State then
                            ToolName = Tool.Name    
                        end
                    end})
                    
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        while true do task.wait(.1)
                            if not Library.Flags["TheBronx3/AutoDupe"] then continue end
                            if tostring(ToolName) == "nil" then continue end
                            LocalPlayer.Character.Humanoid:UnequipTools()

                            task.wait(.25)
                            local ToolId

                            local Connection = ReplicatedStorage.MarketItems.ChildAdded:Connect(
                                function(item)

                                    if item.Name == ToolName then
                                        if item:WaitForChild('owner').Value == LocalPlayer.Name then
                                            ToolId = item:GetAttribute('SpecialId')
                                        end
                                    end
                                end
                            )
                            
                            spawn(function()
                                ReplicatedStorage.ListWeaponRemote:FireServer(ToolName, 99999)
                            end)

                            task.wait(.26)

                            spawn(function()
                                ReplicatedStorage.BackpackRemote:InvokeServer('Store', ToolName)
                            end)

                            task.wait(3)

                            spawn(function()
                                ReplicatedStorage.BuyItemRemote:FireServer(ToolName, 'Remove', ToolId)
                            end)

                            spawn(function()
                                ReplicatedStorage.BackpackRemote:InvokeServer("Grab", ToolName)
                            end)

                            Connection:Disconnect()

                            task.wait(3.5)
                        end
                    end))
                end
            end

            do -- Teleports
                do -- Location Teleports
                    local Teleport_Section = Subpages["Teleports"]:Section({Name = "Teleportation Utilities", Icon = Library:GetImage("JumpToElement"), Side = 1})

                    local Locations = {
                        ["Deli Market 🥪"] = CFrame.new(-769, 255, -686);
                        ["Capital One Bank 🏦"] = CFrame.new(-225, 284, -1223);
                        ["Ice Box 🧊"] = CFrame.new(-198.8927001953125, 283.8486633300781, -1170.4500732421875);
                        ["Hotel 🏨"] = CFrame.new(-973, 254, -939);
                        ["Drip Store 👓"] = CFrame.new(67462.6953125, 10489.0322265625, 546.6762084960938);
                        ["Gun Shop 🔫"] = CFrame.new(92974, 122099, 17233);
                        ["Car Dealer 🚗"] = CFrame.new(-378.6668701171875, 253.2564697265625, -1245.4259033203125);
                        ["Laundromat 💷"] = CFrame.new(-979.4635620117188, 253.65318298339844, -689.3339233398438);
                        ["Studio 🎙"] = CFrame.new(93408.453125, 14484.7158203125, 570.139404296875);
                        ["Basketball Court 🏀"] = CFrame.new(-942, 254, -409);
                        ["Robbable Ice Box 🧊"] = CFrame.new(-232, 284, -1265);
                        ["Exotic Dealer / Grass House 🍃"] = CFrame.new(-1521.943115234375, 272.5462646484375, -984.3020629882812);
                        ["Safe 🔒"] = CFrame.new(-137, 303, -915);
                        ["Roof Top / Bank Tools 🛠"] = CFrame.new(-409, 334, -556);
                        ["Second Gun Shop 🔫"] = CFrame.new(66202, 123615.7109375, 5749.81689453125);
                        ["Construction Job 🔨"] = CFrame.new(-1729, 371, -1171);
                        ["Backpack Shop 🎒"] = CFrame.new(-694, 254, -684);
                        ["Hospital 🏥"] = CFrame.new(-1592, 254, 23);
                    };

                    local Location_Names = {}

                    for Index, Value in Locations do
                        table.insert(Location_Names, Index)
                    end; table.sort(Location_Names)

                    Teleport_Section:Dropdown({Name = "Select Location", Flag = "TheBronx3/SelectLocationToTeleport", MaxSize = 200, Items = Location_Names, Multi = false})

                    Teleport_Section:Button({Name = "Teleport To Selected Location", Callback = function()
                        if Library.Flags["TheBronx3/SelectLocationToTeleport"] and Locations[Library.Flags["TheBronx3/SelectLocationToTeleport"]] then
                            Config:Teleport(Locations[Library.Flags["TheBronx3/SelectLocationToTeleport"]])
                        end
                    end})
                end 

                do -- Safe Teleports
                    local SafeTeleportSection = Subpages["Teleports"]:Section({Name = "Safe Utilities", Icon = Library:GetImage("Lock"), Side = 1})

                    local _SafeDropdown = SafeTeleportSection:Dropdown({Name = "Select Item (In Safe)", Options = {}, Flag = "TheBronx3/SelectItem/Safe", Default = nil, MaxSize = 175, Multi = false})

                    SafeTeleportSection:Button({Name = "Take Item From Safe", Tooltip = "Takes out selected item from your safe.", Callback = function()
                        local Safe, OldCFrame = Config:GetWorkingSafe(), LocalPlayer.Character.HumanoidRootPart.CFrame

                        local ToolName = Library.Flags["TheBronx3/SelectItem/Safe"]
                        if not ToolName then return end

                        Config:Teleport(Safe.ChestClicker.CFrame + Vector3.new(0,3,0))

                        local RECIEVED = false
                        local FORCED = false
                        
                        local Backpack_ChildAdded; Backpack_ChildAdded = LocalPlayer.Backpack.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Child)
                            if Child.Name == ToolName then
                                RECIEVED = true
                                Backpack_ChildAdded:Disconnect()
                            end
                        end))

                        task.delay(3, LPH_NO_VIRTUALIZE(function()
                            RECIEVED = true
                            FORCED = true
                        end))

                        task.wait(0.3)

                        ReplicatedStorage.Inventory:FireServer("Change", ToolName, "Inv", Safe)

                        repeat RunService.Heartbeat:Wait() until RECIEVED

                        local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                        local LookVector = HumanoidRootPart.CFrame.LookVector
                        Config:Teleport(CFrame.new(OldCFrame.Position, OldCFrame.Position + LookVector))

                        if not FORCED then
                            Library:Notification({
                                Name = "Valary.gg | Success",
                                Description = string.format("Successfully took %s out of your safe!", ToolName),
                                Duration = 5,
                                Icon = "116339777575852",
                                IconColor = Color3.fromRGB(52, 255, 164)
                            })
                        else
                            Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = string.format("Couldn't get %s from your safe!", ToolName),
                                Duration = 5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end
                    end})

                    SafeTeleportSection:Button({Name = "Store Item In Safe", Tooltip = "Hold the item you want to safe.", Callback = function()
                        local Safe, OldCFrame = Config:GetWorkingSafe(), LocalPlayer.Character.HumanoidRootPart.CFrame

                        local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if not Tool then return end

                        Tool = Tool.Name
                        LocalPlayer.Character.Humanoid:UnequipTools()

                        Config:Teleport(Safe.ChestClicker.CFrame + Vector3.new(0,3,0))

                        local SAFED = false
                        local FORCED = false
                        
                        local Backpack_ChildRemoved; Backpack_ChildRemoved = LocalPlayer.Backpack.ChildRemoved:Connect(LPH_NO_VIRTUALIZE(function(Child)
                            if Child.Name == Tool then
                                SAFED = true
                                Backpack_ChildRemoved:Disconnect()
                            end
                        end))

                        task.delay(3, LPH_NO_VIRTUALIZE(function()
                            SAFED = true
                            FORCED = true
                        end))

                        task.wait(0.3)

                        ReplicatedStorage.Inventory:FireServer("Change", Tool, "Backpack", Safe)

                        repeat RunService.Heartbeat:Wait() until SAFED

                        local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                        local LookVector = HumanoidRootPart.CFrame.LookVector
                        Config:Teleport(CFrame.new(OldCFrame.Position, OldCFrame.Position + LookVector))

                        if not FORCED then
                            Library:Notification({
                                Name = "Valary.gg | Success",
                                Description = string.format("Successfully safed your %s!", Tool),
                                Duration = 5,
                                Icon = "116339777575852",
                                IconColor = Color3.fromRGB(52, 255, 164)
                            })
                        else
                            Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = string.format("Couldn't safe your %s!", Tool),
                                Duration = 5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end
                    end})

                    -- Refresh Safe Items
                        local Items = {}

                        for Index, Value in LocalPlayer:WaitForChild("InvData"):GetChildren() do
                            table.insert(Items, Value.Name)
                        end; table.sort(Items)

                        _SafeDropdown:Refresh(Items)

                        LocalPlayer:WaitForChild("InvData").ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Child)
                            _SafeDropdown:AddOption(Child.Name)
                        end))

                        LocalPlayer:WaitForChild("InvData").ChildRemoved:Connect(LPH_NO_VIRTUALIZE(function(Child)
                            _SafeDropdown:RemoveOption(Child.Name)
                        end))
                    --end
                end
                
                do -- Purchase Items
                    local PurchaseSection_Item = Subpages.Teleports:Section({Name = "Purchasing Utilities", Icon = Library:GetImage("CreditCard"), Side = 2})

                    PurchaseSection_Item:Dropdown({Name = "Select Item", Items = Config.The_Bronx.Guns, MaxSize = 200, Flag = "TheBronx3/SelectItemToPurchase", Multi = false})

                    PurchaseSection_Item:Button({Name = "Purchase Selected Item", Callback = LPH_NO_VIRTUALIZE(function()
                        local self = string.match(Library.Flags["TheBronx3/SelectItemToPurchase"], "^(.*) %-");

                        self = self:match("^%s*(.-)%s*$");
                        local OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame;
                        local Prompt = Workspace:FindFirstChild("GUNS")[self]:FindFirstChildWhichIsA("ProximityPrompt",true);
                        if (Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("GamepassID", true) and not MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("GamepassID",true).Value)) then 
                            return Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "You do not own this gamepass!",
                                Duration = 7.5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end
                        
                        local Part = Prompt.Parent:IsA("Part") and Prompt.Parent.CFrame or Prompt.Parent:IsA("MeshPart") and Prompt.Parent.CFrame or Prompt.Parent:IsA("UnionOperation") and Prompt.Parent.CFrame;
                        if LocalPlayer.stored.Money.Value < Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("Price",true).Value then
                            return Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = string.format("You are $%s short!", Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("Price",true).Value - LocalPlayer.stored.Money.Value),
                                Duration = 7.5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end;
                        
                        Config:Teleport(Part)

                        task.wait(.3)

                        local ItemReceieved = false;
                        local Check ; Check = LocalPlayer.Backpack.ChildAdded:Connect(function(Child)
                            if tostring(Child) == tostring(self) then
                                ItemReceieved = true
                                Check:Disconnect()
                            end
                        end)

                        task.spawn(function()
                            task.wait(1.5)
                            ItemReceieved = true
                        end)

                        repeat task.wait(); fireproximityprompt(Prompt); until ItemReceieved == true;
                        
                        Library:Notification({
                            Name = "Valary.gg | Success",
                            Description = "Successfully purchased "..Library.Flags["TheBronx3/SelectItemToPurchase"],
                            Duration = 5,
                            Icon = "116339777575852",
                            IconColor = Color3.fromRGB(52, 255, 164)
                        })

                        local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                        local LookVector = HumanoidRootPart.CFrame.LookVector

                        Config:Teleport(CFrame.new(OldCFrame.Position, OldCFrame.Position + LookVector))
                    end)})
                end

                do -- House
                    local HouseTeleportSection = Subpages["Teleports"]:Section({Name = "House Teleports", Icon = Library:GetImage("Home"), Side = 2})

                    local ____Dropdown = HouseTeleportSection:Dropdown({Name = "Select House", Options = {}, Flag = "TheBronx3/SelectHouse", Default = nil, MaxSize = 175, Multi = false})

                    HouseTeleportSection:Button({Name = "Teleport To House", Callback = function()
                        for Index, Value in Workspace.HomeDoorSS:GetChildren() do
                            if Value:FindFirstChild("Owner") and Value.Owner.Value == tostring(Library.Flags["TheBronx3/SelectHouse"]:gsub("'s House", "")) then
                                Config:Teleport(Value.HouseArrestTeleport.CFrame)

                                break
                            end
                        end
                    end})

                    do -- refresh houses
                        local Houses = {};

                        for Index, Value in Workspace.HomeDoorSS:GetChildren() do
                            if Value:FindFirstChild("Owner") and Value.Owner.Value ~= "None" then
                                table.insert(Houses, Value.Owner.Value.."'s House")
                            end
                        end

                        ____Dropdown:Refresh(Houses)
                    end

                    HouseTeleportSection:Button({Name = "Refresh List", Callback = function()
                        local Houses = {};

                        for Index, Value in Workspace.HomeDoorSS:GetChildren() do
                            if Value:FindFirstChild("Owner") and Value.Owner.Value ~= "None" then
                                table.insert(Houses, Value.Owner.Value.."'s House")
                            end
                        end

                        ____Dropdown:Refresh(Houses)
                    end})
                end
            end

            do -- Vehicles
                do -- Modifications
                    local Information_Section = Subpages.Vehicles:Section({Name = "Information", Icon = Library:GetImage("Info"), Side = 1})

                    Information_Section:Label("These mods can be VERY powerful and make your car break / go through the map.")

                    local VehicleSection = Subpages.Vehicles:Section({Name = "Vehicle Modifications", Icon = Library:GetImage("Tune"), Side = 1})

                    VehicleSection:Toggle({Name = "Velocity Speed Enabled", Flag = "VelocitySpeed_Enabled", Default = false, Callback = function(State)
                        Config.VehicleModifications.SpeedEnabled = State
                    end})

                    VehicleSection:Slider({Name = "Speed Value", Min = 1, Max = 25, Default = 5, Flag = "VelocitySpeed_Value", Suffix = "s/ps", Decimals = 1, Callback = function(State)
                        Config.VehicleModifications.SpeedValue = State/1000
                    end})

                    VehicleSection:Toggle({Name = "Break Velocity Enabled", Flag = "BreakVelocity_Enabled", Default = false, Callback = function(State)
                        Config.VehicleModifications.BreakEnabled = State
                    end})

                    VehicleSection:Slider({Name = "Break Value", Min = 10, Max = 300, Default = 50, Suffix = "s/ps", Flag = "BreakVelocity_Value", Decimals = 1, Callback = function(State)
                        Config.VehicleModifications.BreakValue = State/1000
                    end})

                    VehicleSection:Toggle({Name = "Instant Break Enabled", Flag = "InstantBreak_Enabled", Default = false, Callback = function(State)
                        Config.VehicleModifications.InstantStop = State
                    end})

                    local Label = VehicleSection:Label("Instant Break Key")
                    
                    local Key; Key = Label:Keybind({Name = "Instant Break", Flag = "InstantBreak_Bind", Default = Enum.KeyCode.V, Mode = "hold", Callback = LPH_NO_VIRTUALIZE(function()
                        if Key then 
                            Config.VehicleModifications.InstantStopBind = Enum.KeyCode[tostring(select(2, Key:Get()):gsub("Enum.KeyCode.", ""))]
                        end
                    end)})
                end

                do -- Spawner
                    local Vehicle_Spawner = Subpages["Vehicles"]:Section({Name = "Vehicle Spawner", Icon = Library:GetImage("CarInfo"), Side = 2})

                    local Cars = {"1500CHEV", "2020 Mercedes E63s AMG", "2023CTahoe", "C63 S AMG", "Lambo", "2023BMW", "WideBody Demon", "Escalade", "Kia 5K GT", "2023Urus", "MayBach Truck", "Chevrolet Caprice", "MR BLACKWING CTS", "2003 TrailBZ", "Impala BigWheel", "2017SuburbanChev", "Bronco", "1999Toyota", "DirtBike", "GT500", "2003 Chevrolet Suburban", "2014 C7 Sti", "Claren", "BulletProofTahoe", "DA BIG GMCEE", "ATV", "2005 Dodge Magnum R/T", "Chevrolet Tahoe", "2005Mitsubishi", "Blazer", "Bentley SS", "Lincoln W Donks", "HondaCivic", "1990Tahoe", "Van", "2023 RAM® 1500 TRX", "392 CHALLY", "Q50S", "BigWheel Cadillac DTS", "X6M BMW", "2022CadeeLac Escalade", "C8 ZR1", "2022Porsche", "2500HD DodgeRam", "BMW M3", "2020 Rolls-Royce", "DodgeChargerSRT", "Scat", "DA G8", "LTZ HQ", "Range Rover Velar", "Hellcat Jeep", "Monte Carlo SS", "1994 Chevrolet Impala SS", "2010Escalade", "Q60", "2017Camaro", "Hunda Brr", "Sideshow Chevy", "M8 CS", "BansheeYamaha", "2013 Charger SRT8", "1970 Plymouth Roadrunner", "RaptorF150", "DodgeDurang SRT", "NissanGTR", "1969 Camaro Z/28", "MR PublicBus", "C63 E AMG", "TrackHawk", "Nissan Skyline", "Maserati Ghibli", "BIG 4WHEELER", "DodgeChallenger", "Rolls Royce", "Chrysler 300 Hellcat", "Camaro", "Gle 53", "G65 AMG", "MR 4Runner", "Mercedes Sprinter Bus", "Hellcat", "Chevrolet Silvardo", "CTS-V"}
                    table.sort(Cars)
                    
                    Vehicle_Spawner:Dropdown({Name = "Select Vehicle", Flag = "TheBronx3/VehicleSpawner/SelectVehicle", Items = Cars, MaxSize = 200})
                
                    Vehicle_Spawner:Button({Name = "Spawn Vehicle", Tooltip = "This will spawn your vehicle, you must own it!", Callback = function()
                        if not Library.Flags["TheBronx3/VehicleSpawner/SelectVehicle"] then return end
                        if not replicatesignal then
                            return Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "Your executor doesnt support 'replicatesignal' , get a better executor!",
                                Duration = 10,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end

                        local Old_CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

                        Config:Teleport(Workspace.CARDealerP.CFrame)

                        repeat RunService.Heartbeat:Wait() until LocalPlayer.PlayerGui:FindFirstChild("GunGui")
                        task.wait(1)

                        replicatesignal(LocalPlayer.PlayerGui.GunGui.Holder.ScrollingFrame[Library.Flags["TheBronx3/VehicleSpawner/SelectVehicle"]].MouseButton1Down,1,1)

                        task.wait(0.5)

                        if LocalPlayer.PlayerGui.GunGui.Holder.Buy.Text:lower() == "buy" then
                            return Library:Notification({
                                Name = "Valary.gg | Error!",
                                Description = "You don't own this car!",
                                Duration = 5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })
                        end

                        replicatesignal(LocalPlayer.PlayerGui.GunGui.Holder.Buy.MouseButton1Down, 1, 1)

                        local MyCar;

                        if Library.Flags["TheBronx3/VehicleSpawner/GetIntoVehicle"] then
                            local CivCars_ChildAdded; CivCars_ChildAdded = Workspace.CivCars.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Child)
                                repeat RunService.Heartbeat:Wait() until Child:FindFirstChild("Owner")
                                task.wait(.1)
                                if Child:FindFirstChild("Owner").Value == LocalPlayer.Name then
                                    Child:WaitForChild("DriveSeat");task.wait(.5)
                                    Child:WaitForChild("DriveSeat"):Sit(LocalPlayer.Character.Humanoid)
                                    MyCar = Child
                                    CivCars_ChildAdded:Disconnect()
                                    CivCars_ChildAdded = nil
                                end
                            end))
                        end

                        if Library.Flags["TheBronx3/VehicleSpawner/GetIntoVehicle"] and Library.Flags["TheBronx3/VehicleSpawner/BringVehicle"] then
                            repeat RunService.Heartbeat:Wait() until LocalPlayer.Character.Humanoid.SeatPart and MyCar

                            if not MyCar.PrimaryPart then
                                MyCar.PrimaryPart = MyCar.Body:FindFirstChild("#Weight", true)
                            end

                            if not MyCar.PrimaryPart then
                                MyCar.PrimaryPart = MyCar.Body:FindFirstChildWhichIsA("Part", true)
                            end

                            MyCar:SetPrimaryPartCFrame(Old_CFrame+Vector3.new(0,5,0))
                        end
                    end})

                    Vehicle_Spawner:Toggle({Name = "Automatically Get Into Vehicle", Flag = "TheBronx3/VehicleSpawner/GetIntoVehicle", Tooltip = "This make you automatically get in the driver seat."})

                    Vehicle_Spawner:Toggle({Name = "Automatically Bring Vehicle", Flag = "TheBronx3/VehicleSpawner/BringVehicle", Tooltip = "You must have get into vehicle enabled for this to work."})
                end

                do -- Mobile Garage
                    local Mobile_Garage = Subpages["Vehicles"]:Section({Name = "Mobile Garage", Icon = Library:GetImage("CarGear"), Side = 2})
                    if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 1061802329) then
                        Mobile_Garage:Label("Select Color"):Colorpicker({
                            Name = "Select Car Color",
                            Flag = "TheBronx3/SelectCustomCarColor",
                            Default = Color3.fromRGB(255,255,255),
                            Alpha = 0
                        })

                        Mobile_Garage:Button({Name = "Apply Color", Tooltip = "Your car must be spawned, it will cost $100.", Callback = function()
                            if Library.Flags["TheBronx3/SelectCustomCarColor"] then
                                ReplicatedStorage:WaitForChild("Garage"):InvokeServer(Library.Flags["TheBronx3/SelectCustomCarColor"], "Body")
                            end
                        end})
                    else
                        local colors = {
                            ["Pink"] = Color3.fromRGB(250,124,153),
                            ["Orange"] = Color3.fromRGB(220,115,10),
                            ["Gray"] = Color3.fromRGB(74,74,74),
                            ["Dark Red"] = Color3.fromRGB(86,36,36),
                            ["Blue"] = Color3.fromRGB(18,26,149),
                            ["Black"] = Color3.fromRGB(0,0,0),
                            ["Green"] = Color3.fromRGB(64,152,78),
                            ["Red"] = Color3.fromRGB(194,0,0),
                            ["Purple"] = Color3.fromRGB(39,21,66),
                            ["Yellow"] = Color3.fromRGB(255,191,0),
                            ["Lime"] = Color3.fromRGB(139,190,0),
                            ["Brown"] = Color3.fromRGB(86,36,36),
                        } local color_names = {};

                        for Index, Value in colors do
                            table.insert(color_names, Index)
                        end; table.sort(color_names)

                        Mobile_Garage:Dropdown({Name = "Select Color", Items = color_names, Flag = "TheBronx3/SelectColorGarage", MaxSize = 175})

                        Mobile_Garage:Button({Name = "Apply Color", Tooltip = "Your car must be spawned, it will cost $100.", Callback = function()
                            if Library.Flags["TheBronx3/SelectColorGarage"] and colors[Library.Flags["TheBronx3/SelectColorGarage"]] then
                                ReplicatedStorage:WaitForChild("Garage"):InvokeServer(colors[Library.Flags["TheBronx3/SelectColorGarage"]], "Body")
                            end
                        end})
                    end
                end
            end
        end

        do -- Settings
            local Subpages = {
                ["Configs"] = Pages["Settings"]:SubPage({
                    Name = "Configs", 
                    Icon = "96491224522405", 
                    Columns = 2
                }),

                ["Theming"] = Pages["Settings"]:SubPage({
                    Name = "Theming", 
                    Icon = "103863157706913", 
                    Columns = 2
                }),

                ["Configuration"] = Pages["Settings"]:SubPage({
                    Name = "Configuration", 
                    Icon = "137300573942266", 
                    Columns = 2
                })
            }

            do -- Theming
                local ThemingSection = Subpages["Theming"]:Section({Name = "theming", Icon = "103863157706913", Side = 1})
                local ThemingProfiles = Subpages["Theming"]:Section({Name = "profiles", Icon = "96491224522405", Side = 2})
                local AutoloadSection = Subpages["Theming"]:Section({Name = "autoload", Icon = "137623872962804", Side = 2})

                for Index, Value in Library.Theme do 
                    Library.ThemeColorpickers[Index] = ThemingSection:Label(Index, "Left"):Colorpicker({
                        Name = "Colorpicker",
                        Flag = "ColorpickerTheme" .. Index,
                        Default = Value,
                        Alpha = 0,
                        Callback = function(Color, Alpha)
                            Library.Theme[Index] = Color
                            Library:ChangeTheme(Index, Color)
                        end
                    })
                end

                local ThemeData = {}

                for Index, Value in Library.Themes do
                    table.insert(ThemeData, Index)
                end

                ThemingProfiles:Dropdown({
                    Name = "preset themes",
                    Items = ThemeData,
                    MaxSize = 200,
                    Default = "Preset",
                    Multi = false,
                    Callback = function(Value)
                        local ThemeData = Library.Themes[Value]

                        if not ThemeData then 
                            return
                        end

                        for Index, Value in Library.Theme do 
                            Library.Theme[Index] = ThemeData[Index]
                            Library:ChangeTheme(Index, ThemeData[Index])

                            Library.ThemeColorpickers[Index]:Set(ThemeData[Index])
                        end

                        task.wait(0.3)

                        Library:Thread(function() -- i do this because sometimes the themes dont update
                            for Index, Value in Library.Theme do 
                                Library.Theme[Index] = Library.Flags["ColorpickerTheme" .. Index].Color
                                Library:ChangeTheme(Index, Library.Flags["ColorpickerTheme" .. Index].Color)
                            end    
                        end)
                    end
                })

                local ThemeSelected 
                local ThemeName

                do
                    local ThemesDropdown = ThemingProfiles:Dropdown({
                        Name = "themes", 
                        Flag = "ThemesList", 
                        Items = { }, 
                        Multi = false,
                        Callback = function(Value)
                            ThemeSelected = Value
                        end
                    })

                    ThemingProfiles:Textbox({
                        Name = "theme name", 
                        Default = "", 
                        Flag = "ThemeName", 
                        Placeholder = "enter text", 
                        Callback = function(Value)
                            ThemeName = Value
                        end
                    })

                    ThemingProfiles:Button({
                        Name = "save",
                        Callback = function()
                            if ThemeName and ThemeName ~= "" then
                                writefile(Library.Folders.Themes .. "/" .. ThemeName .. ".json", Library:GetTheme())
                                Library:RefreshThemesList(ThemesDropdown)
                            end
                        end
                    })

                    ThemingProfiles:Button({
                        Name = "load",
                        Callback = function()
                            if ThemeSelected then
                                local Success, Result = Library:LoadTheme(readfile(Library.Folders.Themes .. "/" .. ThemeSelected))

                                if Success then 
                                    Library:Notification({
                                        Name = "Success",
                                        Description = "Succesfully loaded theme: ".. ThemeSelected,
                                        Duration = 5,
                                        Icon = "116339777575852",
                                        IconColor = Color3.fromRGB(52, 255, 164)
                                    })

                                    task.wait(0.3)

                                    Library:Thread(function() -- i do this because sometimes the themes dont update
                                        for Index, Value in Library.Theme do 
                                            Library.Theme[Index] = Library.Flags["ColorpickerTheme" .. Index].Color
                                            Library:ChangeTheme(Index, Library.Flags["ColorpickerTheme" .. Index].Color)
                                        end    
                                    end)
                                else
                                    Library:Notification({
                                        Name = "Error!",
                                        Description = "Failed to load theme, error:\n",
                                        Duration = 5,
                                        Icon = "97118059177470",
                                        IconColor = Color3.fromRGB(255, 120, 120)
                                    })
                                end
                            end
                        end
                    })

                    AutoloadSection:Button({
                        Name = "set selected theme as autoload",
                        Callback = function()
                            if ThemeSelected then 
                                writefile(Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json", readfile(Library.Folders.Themes .. "/" .. ThemeSelected))
                            end
                        end
                    })

                    AutoloadSection:Button({
                        Name = "set current theme as autoload",
                        Callback = function()
                            if ThemeSelected then 
                                writefile(Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json", Library:GetTheme())
                            end
                        end
                    })

                    AutoloadSection:Button({
                        Name = "remove autoload theme",
                        Callback = function()
                            writefile(Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json", "")
                        end
                    })

                    Library:RefreshThemesList(ThemesDropdown)
                end
            end

            do -- Configs
                local ConfigsSection = Subpages["Configs"]:Section({Name = "profiles", Icon = "96491224522405", Side = 1})
                local AutoloadSection = Subpages["Configs"]:Section({Name = "autoload", Icon = "137623872962804", Side = 2})
                local ServerSection = Subpages["Configs"]:Section({Name = "servers", Icon = Library:GetImage("Servers"), Side = 2})

                local ConfigSelected 
                local ConfigName

                do
                    local ConfigsDropdown = ConfigsSection:Dropdown({
                        Name = "configs", 
                        Flag = "ConfigsList", 
                        Items = { }, 
                        Multi = false,
                        Callback = function(Value)
                            ConfigSelected = Value
                        end
                    })

                    ConfigsSection:Textbox({
                        Name = "config name", 
                        Default = "", 
                        Flag = "ConfigName", 
                        Placeholder = "enter text", 
                        Callback = function(Value)
                            ConfigName = Value
                        end
                    })

                    ConfigsSection:Button({
                        Name = "create",
                        Callback = function()
                            if ConfigName and ConfigName ~= "" then
                                writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
                                Library:RefreshConfigsList(ConfigsDropdown)
                            end
                        end
                    })

                    ConfigsSection:Button({
                        Name = "delete",
                        Callback = function()
                            if ConfigSelected then
                                Library:DeleteConfig(ConfigSelected)
                                Library:RefreshConfigsList(ConfigsDropdown)
                            end
                        end
                    })

                    ConfigsSection:Button({
                        Name = "load",
                        Callback = function()
                            if ConfigSelected then
                                local Success, Result = Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected))

                                if Success then 
                                    Library:Notification({
                                        Name = "Success",
                                        Description = "Succesfully loaded config: ".. ConfigSelected,
                                        Duration = 5,
                                        Icon = "116339777575852",
                                        IconColor = Color3.fromRGB(52, 255, 164)
                                    })

                                    task.wait(0.3)

                                    Library:Thread(function() -- i do this because sometimes the themes dont update
                                        for Index, Value in Library.Theme do 
                                            Library.Theme[Index] = Library.Flags["ColorpickerTheme" .. Index].Color
                                            Library:ChangeTheme(Index, Library.Flags["ColorpickerTheme" .. Index].Color)
                                        end    
                                    end)
                                else
                                    Library:Notification({
                                        Name = "Error!",
                                        Description = "Failed to load config, error:\n",
                                        Duration = 5,
                                        Icon = "97118059177470",
                                        IconColor = Color3.fromRGB(255, 120, 120)
                                    })
                                end
                            end
                        end
                    })

                    ConfigsSection:Button({
                        Name = "save",
                        Callback = function()
                            if ConfigSelected then
                                Library:SaveConfig(ConfigSelected)
                            end
                        end
                    })

                    ConfigsSection:Button({
                        Name = "refresh list",
                        Callback = function()
                            Library:RefreshConfigsList(ConfigsDropdown)
                        end
                    })

                    Library:RefreshConfigsList(ConfigsDropdown)
                end

                do
                    AutoloadSection:Button({
                        Name = "set selected config as autoload",
                        Callback = function()
                            if ConfigSelected then 
                                writefile(Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json", readfile(Library.Folders.Configs .. "/" .. ConfigSelected))
                            end
                        end
                    })

                    AutoloadSection:Button({
                        Name = "set current config as autoload",
                        Callback = function()
                            if ConfigSelected then 
                                writefile(Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json", Library:GetConfig())
                            end
                        end
                    })

                    AutoloadSection:Button({
                        Name = "remove autoload config",
                        Callback = function()
                            writefile(Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json", "")
                        end
                    })
                end
                
                do
                    ServerSection:Button({Name = "rejoin server", Callback = function()
                        Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
                    end})

                    ServerSection:Button({Name = "server hop", Callback = function()
                        local Servers = {}
                        local Request = request({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", tostring(game.PlaceId))})
                        local Body = Services.HttpService:JSONDecode(Request.Body)
                
                        if Body and Body.data then
                            for _, Value in next, Body.data do
                                if type(Value) == "table" and tonumber(Value.playing) and tonumber(Value.maxPlayers) and Value.playing < Value.maxPlayers and Value.id ~= game.JobId then
                                    table.insert(Servers, 1, Value.id)
                                end
                            end
                        end
                
                        Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1, #Servers)])
                    end})

                    ServerSection:Button({Name = "join lowest server", Callback = function()
                        local Servers = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", tostring(game.PlaceId))
                
                        local ListServers = function(cursor)
                            local Raw = game:HttpGet(Servers .. ((cursor and "&cursor="..cursor) or ""))
                            return Services.HttpService:JSONDecode(Raw)
                        end
                
                        local Server, Next; repeat
                            local Servers = ListServers(Next)
                            Server = Servers.data[1]
                            Next = Servers.nextPageCursor
                        until Server
                
                        if Server.id == game.JobId then
                            Library:Notification({
                                Name = "Valary.gg | Servers",
                                Description = "You are currently in the smallest server!",
                                Duration = 5,
                                Icon = "97118059177470",
                                IconColor = Color3.fromRGB(255, 120, 120)
                            })

                            return  
                        end 
                        
                        Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id)
                    end})
                end
            end

            do -- Configuration
                local MenuSection = Subpages["Configuration"]:Section({Name = "menu", Icon = "93007870315593", Side = 1})
                local TweeningSection = Subpages["Configuration"]:Section({Name = "tweening", Icon = "130045183204879", Side = 2})

                do
                    MenuSection:Label("menu keybind", "Left"):Keybind({
                        Name = "MenuKeybind",
                        Flag = "MenuKeybind",
                        NoKeyBindList = true,
                        Mode = "toggle",
                        Default = Library.MenuKeybind,
                        HideKeyFromUI = true,
                        Callback = function()
                            Library.MenuKeybind = Library.Flags["MenuKeybind"].Key
                        end
                    })

                    MenuSection:Toggle({
                        Name = "keybind list",
                        Flag = "keybind list",
                        Default = true,
                        Callback = function(Value)
                            KeybindList:SetVisibility(Value)
                        end
                    })
                    
                    MenuSection:Toggle({
                        Name = "watermark",
                        Flag = "watermark",
                        Default = false,
                        Callback = function(Value)
                            Watermark:SetVisibility(Value)
                        end
                    })

                    GlobalChat_Toggle = MenuSection:Toggle({
                        Name = "global chat",
                        Flag = "global chat",
                        Default = true,
                        Callback = function(Value)
                            ChatSystem:SetVisibility(Value)
                        end
                    })

                    MenuSection:Button({
                        Name = "unload",
                        Callback = function()
                            Library:Unload()
                            Esp.Unload()
                        end
                    })
                end

                do
                    TweeningSection:Slider({
                        Name = "time",
                        Flag = "TweenTime",
                        Default = Library.Tween.Time,
                        Min = 0,
                        Max = 5,
                        Decimals = 0.01,
                        Callback = function(Value)
                            Library.Tween.Time = Value
                        end
                    })

                    TweeningSection:Dropdown({
                        Name = "style",
                        Flag = "TweenStyle",
                        Default = "Cubic",
                        Items = {"Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential", "Circular", "Back", "Elastic", "Bounce"},
                        MaxSize = 150,
                        Callback = function(Value)
                            Library.Tween.Style = Enum.EasingStyle[Value]
                        end
                    })

                    TweeningSection:Dropdown({
                        Name = "direction",
                        Flag = "TweenDirection",
                        MaxSize = 55,
                        Default = "Out",
                        Items = {"In", "Out", "InOut"},
                        Callback = function(Value)
                            Library.Tween.Direction = Enum.EasingDirection[Value]
                        end
                    })
                end
            end
        end
    end
end

if hookfunction and LPH_OBFUSCATED then
    --[[local _FireServer;
    local _Function;

    _FireServer = hookfunction(Instance.new("RemoteEvent", nil).FireServer, LPH_NO_UPVALUES(function(self, ...)
        local Arguments = {...}

        if tostring(self) == "Lights_FE" then
            local f, s = debug.getinfo(2, "fs")
            if not _Function then
                _Function = f.func
            end

            if _Function ~= f.func then
                while true do end
                return
            end
        end

        return _FireServer(self, ...)
    end))]]
end

if LPH_OBFUSCATED then
    task.spawn(LPH_JIT_MAX(function()
        while true do
            task.wait(.1)
            if getgenv().SimpleSpyExecuted ~= nil then
                LocalPlayer:Destroy()
                game:Shutdown()
                LocalPlayer:Kick()
                while true do end
            end
        end
    end))
end

if not UserInputService.TouchEnabled then
    RunService:BindToRenderStep("UI_Mouse_Fixer", 400, LPH_NO_VIRTUALIZE(function()
        if Window.IsOpen and not UserInputService.MouseIconEnabled then
            UserInputService.MouseIconEnabled = true
        end

        if not Window.IsOpen and Config.Gun_Held and UserInputService.MouseIconEnabled then
            UserInputService.MouseIconEnabled = false
        end
    end))
end

Library:Notification({
    Name = "Valary.gg | Loader",
    Description = "loaded in: " .. string.sub(tostring(os.clock() - LoadingTick), 1, 4).. "s",
    Duration = 10
})

Library:Init() -- put this at the end of ur script or the autoload will not work

getgenv().Library = Library
return Library  
