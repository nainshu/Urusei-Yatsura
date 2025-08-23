local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not success or not WindUI then
    warn("加载 WindUI 库失败！")
    warn("错误：", WindUI)
    return
end

print("WindUI 库加载成功！")

-- Add custom themes first
WindUI:AddTheme({
    Name = "Dark",
    Accent = "#18181b",
    Dialog = "#18181b", 
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#999999",
    Background = "#0e0e10",
    Button = "#52525b",
    Icon = "#a1a1aa",
})

WindUI:AddTheme({
    Name = "Light",
    Accent = "#f4f4f5",
    Dialog = "#f4f4f5",
    Outline = "#000000", 
    Text = "#000000",
    Placeholder = "#666666",
    Background = "#ffffff",
    Button = "#e4e4e7",
    Icon = "#52525b",
})

WindUI:AddTheme({
    Name = "Gray",
    Accent = "#374151",
    Dialog = "#374151",
    Outline = "#d1d5db", 
    Text = "#f9fafb",
    Placeholder = "#9ca3af",
    Background = "#1f2937",
    Button = "#4b5563",
    Icon = "#d1d5db",
})

WindUI:AddTheme({
    Name = "Blue",
    Accent = "#1e40af",
    Dialog = "#1e3a8a",
    Outline = "#93c5fd", 
    Text = "#f0f9ff",
    Placeholder = "#60a5fa",
    Background = "#1e293b",
    Button = "#3b82f6",
    Icon = "#93c5fd",
})

WindUI:AddTheme({
    Name = "Green",
    Accent = "#059669",
    Dialog = "#047857",
    Outline = "#6ee7b7", 
    Text = "#ecfdf5",
    Placeholder = "#34d399",
    Background = "#064e3b",
    Button = "#10b981",
    Icon = "#6ee7b7",
})

WindUI:AddTheme({
    Name = "Purple",
    Accent = "#7c3aed",
    Dialog = "#6d28d9",
    Outline = "#c4b5fd", 
    Text = "#faf5ff",
    Placeholder = "#a78bfa",
    Background = "#581c87",
    Button = "#8b5cf6",
    Icon = "#c4b5fd",
})

WindUI:SetNotificationLower(true)

local themes = {"Dark", "Light", "Gray", "Blue", "Green", "Purple"}
local currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = false
end

local Window = WindUI:CreateWindow({
    Title = "某些不好的事情将会发生",
    Icon = "zap", 
    Author = "Axiora | Viper",
    Folder = "AxioraViperHub",
    Size = UDim2.fromOffset(610, 410),
    Transparent = getgenv().TransparencyEnabled,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 150,
    BackgroundImageTransparency = 0.8,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            currentThemeIndex = currentThemeIndex + 1
            if currentThemeIndex > #themes then
                currentThemeIndex = 1
            end
            
            local newTheme = themes[currentThemeIndex]
            WindUI:SetTheme(newTheme)
           
            WindUI:Notify({
                Title = "主题已更改",
                Content = "切换至 " .. newTheme .. " theme!",
                Duration = 2,
                Icon = "palette"
            })
            print("切换至 " .. newTheme .. " theme")
        end,
    },
    
})

Window:SetToggleKey(Enum.KeyCode.V)

pcall(function()
    Window:CreateTopbarButton("TransparencyToggle", "eye", function()
        if getgenv().TransparencyEnabled then
            getgenv().TransparencyEnabled = false
            pcall(function() Window:ToggleTransparency(false) end)
            
            WindUI:Notify({
                Title = "透明度", 
                Content = "透明度已禁用",
                Duration = 3,
                Icon = "eye"
            })
            print("Transparency = false")
        else
            getgenv().TransparencyEnabled = true
            pcall(function() Window:ToggleTransparency(true) end)
            
            WindUI:Notify({
                Title = "透明度",
                Content = "透明度已启用", 
                Duration = 3,
                Icon = "eye-off"
            })
            print(" Transparency = true")
        end
        
        -- Debug: Print current state
        print("Debug - Current Transparency state:", getgenv().TransparencyEnabled)
    end, 990)
end)

pcall(function()
    Window:EditOpenButton({
        Title = "切换 Sewh 脚本",
        Icon = "zap",
        CornerRadius = UDim.new(0, 16),
        StrokeThickness = 2,
        Color = ColorSequence.new(
            Color3.fromHex("00FF87"), 
            Color3.fromHex("60EFFF")
        ),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })
end)

pcall(function()
    Window:Tag({
        Title = "AXS",
        Color = Color3.fromHex("#0066ff") -- Blue color
    })
end)

pcall(function()
    Window:Tag({
        Title = "VIPER",
        Color = Color3.fromHex("#30ff6a")
    })
end)

pcall(function()
    local TimeTag = Window:Tag({
        Title = "00:00",
        Color = Color3.fromHex("#000000")
    })

    local hue = 0

    task.spawn(function()
        while true do
            local now = os.date("*t")
            local hours = string.format("%02d", now.hour)
            local minutes = string.format("%02d", now.min)

            hue = (hue + 0.01) % 1
            local color = Color3.fromHSV(hue, 1, 1)

            TimeTag:SetTitle(hours .. ":" .. minutes)
            TimeTag:SetColor(color)

            task.wait(0.06)
        end
    end)
end) -- <== you were missing this

local HomeTab = Window:Tab({
    Title = "主页",
    Icon = "house",
    Locked = false,
})

local PlayerTab = Window:Tab({
    Title = "玩家设置",
    Icon = "user",
    Locked = false,
})

local AutoTab = Window:Tab({
    Title = "自动",
    Icon = "repeat",
    Locked = false,
})

local FeaturesTab = Window:Tab({
    Title = "特别",
    Icon = "bluetooth",
    Locked = false,
})

Window:SelectTab(1) -- Number of Tab

local HomeSection = HomeTab:Section({
    Title = "AXS",
    Icon = "zap",
})

 HomeTab:Paragraph({
    Title = "关于",
    Desc = "关于Axiora就是我们制作脚本，所以制作。Op Scripts 您可以在我的Discord社区中找到这些脚本 ",
    Color = "Grey",
})

HomeTab:Paragraph({
    Title = "变更日志. 0.2",
    Desc = "Sewh Recode By Viper\n添加了AntiRagdoll禁用Ragdoll和falldamge",
    Color = "Grey",
})

HomeTab:Paragraph({
    Title = "Axiora支持的游戏",
    Desc = "排球传奇\n邪恶的东西。会发生的\n从现在开始，那是两个。游戏Axiora制作，我们将继续制作脚本并爱你们\n在我的Discord服务器上自由建议！",
    Color = "Grey",
})

local Button = HomeTab:Button({
    Title = "复制邀请链接！",
    Desc = "",
    Locked = false,
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/38M6yaJRek")
            WindUI:Notify({
                Title = "Axiora",
                Content = "Discord 邀请链接已复制到剪贴板！",
                Duration = 2,
                Icon = "check"
            })
        else
            WindUI:Notify({
                Title = "错误",
                Content = "此执行器不支持剪贴板",
                Duration = 3,
                Icon = "x"
            })
        end
    end
})

-- Adonis Bypass (runs first!)
task.spawn(function()
local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}
local Detected, Kill
if setthreadidentity then setthreadidentity(2) end
for i, v in getgc(true) do
if typeof(v) == "table" then
local DetectFunc = rawget(v, "Detected")
local KillFunc = rawget(v, "Kill")
if typeof(DetectFunc) == "function" and not Detected then
Detected = DetectFunc
local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
if Action ~= "_" then
if DEBUG then
warn(("Adonis AntiCheat flagged\nMethod: %s\nInfo: %s"):format(tostring(Action), tostring(Info)))
end
end
return true
end)
table.insert(Hooked, Detected)
end
if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
Kill = KillFunc
local Old; Old = hookfunction(Kill, function(Info)
if DEBUG then
warn(("Adonis AntiCheat tried to kill (fallback): %s"):format(tostring(Info)))
end
end)
table.insert(Hooked, Kill)
end
end
end
local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
local LevelOrFunc, Info = ...
if Detected and LevelOrFunc == Detected then
if DEBUG then
warn("Viper Adonis bypassed")
end
return coroutine.yield(coroutine.running())
end
return Old(...)
end))
if setthreadidentity then setthreadidentity(7) end
end)

if not getgenv().CustomWalkSpeed then
    getgenv().CustomWalkSpeed = 16 -- Default Roblox walkspeed
end

-- Get player and character references
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Variables to track state
local applySpeedEnabled = false
local walkspeedConnection

-- FIXED: Function to apply custom walkspeed
local function applyCustomWalkspeed()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = getgenv().CustomWalkSpeed -- FIXED variable name
    end
end

-- Function to reset to default walkspeed
local function resetToDefaultWalkspeed()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16 -- Default Roblox walkspeed
    end
end

-- Function to start applying custom walkspeed
local function startApplyingSpeed()
    if walkspeedConnection then
        walkspeedConnection:Disconnect()
    end
    
    -- Apply speed immediately
    applyCustomWalkspeed()
    
    -- Keep applying speed every frame to prevent resets
    walkspeedConnection = RunService.Heartbeat:Connect(function()
        if applySpeedEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.WalkSpeed ~= getgenv().CustomWalkSpeed then -- FIXED variable name
                player.Character.Humanoid.WalkSpeed = getgenv().CustomWalkSpeed -- FIXED variable name
            end
        end
    end)
end

-- Function to stop applying custom walkspeed
local function stopApplyingSpeed()
    if walkspeedConnection then
        walkspeedConnection:Disconnect()
        walkspeedConnection = nil
    end
    resetToDefaultWalkspeed()
end

-- Handle character respawning
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    if applySpeedEnabled then
        wait(0.1) -- Small delay to ensure character is fully loaded
        applyCustomWalkspeed()
    end
end)


getgenv().CustomJumpPower = 50 -- Default Roblox jump power

-- Get player and character references
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Variables to track state
local applyJumpEnabled = false
local jumpConnection

-- Function to apply custom jump power
local function applyCustomJumpPower()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = getgenv().CustomJumpPower
    end
end

-- Function to reset to default jump power
local function resetToDefaultJumpPower()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 50 -- Default Roblox jump power
    end
end

-- Function to start applying custom jump power
local function startApplyingJump()
    if jumpConnection then
        jumpConnection:Disconnect()
    end
    
    -- Apply jump power immediately
    applyCustomJumpPower()
    
    -- Keep applying jump power every frame to prevent resets
    jumpConnection = RunService.Heartbeat:Connect(function()
        if applyJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.JumpPower ~= getgenv().CustomJumpPower then
                player.Character.Humanoid.JumpPower = getgenv().CustomJumpPower
            end
        end
    end)
end

-- Function to stop applying custom jump power
local function stopApplyingJump()
    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    resetToDefaultJumpPower()
end

-- Handle character respawning
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    if applyJumpEnabled then
        wait(0.1) -- Small delay to ensure character is fully loaded
        applyCustomJumpPower()
    end
end)


local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ohaux.lua"))()

-- Get the script path for sprint handler
local scriptPath = game:GetService("ReplicatedStorage").Resources.Client.SprintHandler

-- Search for closures related to sprint functionality
local closure1 = aux.searchClosure(scriptPath, "startSprint", 10, {
    [1] = "MoveDirection", [2] = "Magnitude", [3] = 0.2, [4] = "Play",
    [5] = "DestroyIdentifier", [6] = "BaseRegen"
})

local closure2 = aux.searchClosure(scriptPath, "startSprint", 4, {
    [1] = "MoveDirection", [2] = "Magnitude", [3] = 0.2, [4] = "Play",
    [5] = "DestroyIdentifier", [6] = "BaseRegen"
})

local PlayerSection = PlayerTab:Section({
    Title = "普通",
    Icon = "zap",
})

-- Speed Input
local SpeedInput = PlayerTab:Input({
    Title = "设置移动速度",
    Desc = "",
    Value = "20",
    InputIcon = "zap",
    Type = "Input",
    Placeholder = "Enter Speed here",
    Callback = function(input) 
        local speed = tonumber(input)
        if speed and speed >= 1 and speed <= 1000 then -- Reasonable limits
            getgenv().CustomWalkSpeed = speed -- FIXED variable name
            WindUI:Notify({
                Title = "移动速度已更新",
                Content = "Custom walkspeed set to: " .. speed,
                Duration = 1.5,
                Icon = "zap",
            })
            
            -- If speed is currently being applied, update it immediately
            if applySpeedEnabled then
                applyCustomWalkspeed()
            end
        else
            WindUI:Notify({
                Title = "输入无效",
                Content = "请输入 1 到 1000 之间的数字！",
                Duration = 4,
                Icon = "alert-triangle",
            })
        end
    end
})

-- FIXED: Apply Speed Toggle
local ApplySpeedToggle = PlayerTab:Toggle({
    Title = "应用移动速度",
    Desc = "",
    Icon = "zap",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        applySpeedEnabled = state
        
        if state then
            startApplyingSpeed()
            WindUI:Notify({
                Title = "移动速度已启用",
                Content = "启用自定义移动速度: " .. getgenv().CustomWalkSpeed, -- FIXED variable name
                Duration = 3,
                Icon = "zap",
            })
        else
            stopApplyingSpeed()
            WindUI:Notify({
                Title = "移动速度已禁用",
                Content = "移动速度重置为默认值(16)",
                Duration = 3,
                Icon = "square",
            })
        end
    end
})

local JumpInput = PlayerTab:Input({
    Title = "设置跳跃高度",
    Desc = "",
    Value = "50",
    InputIcon = "zap",
    Type = "Input",
    Placeholder = "Enter Jump Power here",
    Callback = function(input) 
        local jumpPower = tonumber(input)
        if jumpPower and jumpPower >= 1 and jumpPower <= 1000 then -- Reasonable limits
            getgenv().CustomJumpPower = jumpPower
            WindUI:Notify({
                Title = "跳跃高度已更新",
                Content = "自定义跳跃高度设置为: " .. jumpPower,
                Duration = 3,
                Icon = "zap",
            })
            
            -- If jump power is currently being applied, update it immediately
            if applyJumpEnabled then
                applyCustomJumpPower()
            end
        else
            WindUI:Notify({
                Title = "无效",
                Content = "请输入 1 到 1000 之间的数字！",
                Duration = 4,
                Icon = "alert-triangle",
            })
        end
    end
})

-- Apply Jump Power Toggle
local ApplyJumpToggle = PlayerTab:Toggle({
    Title = "应用跳跃高度",
    Desc = "",
    Icon = "zap",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        applyJumpEnabled = state
        
        if state then
            startApplyingJump()
            WindUI:Notify({
                Title = "跳跃已启用！",
                Content = "启用自定义跳跃高度: " .. getgenv().CustomJumpPower,
                Duration = 3,
                Icon = "zap",
            })
        else
            stopApplyingJump()
            WindUI:Notify({
                Title = "跳跃已禁用",
                Content = "将跳跃高度重置为默认值",
                Duration = 3,
                Icon = "square",
            })
        end
    end
})

local InfiniteSprintToggle = PlayerTab:Toggle({
    Title = "无限体力",
    Desc = "",
    Icon = "infinity",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        pcall(function()
            -- Apply infinite stamina if closures are found
            if closure1 then 
                debug.getupvalue(closure1, 10)["MaxStamina"] = state and 1e308 or 100 
            end
            if closure2 then 
                debug.setupvalue(closure2, 4, state and 1e308 or 100) 
            end
            
            -- Show notification based on state
            if state then
                WindUI:Notify({
                    Title = "无限体力已启用",
                    Content = "你现在可以无限冲刺了！",
                    Duration = 3,
                    Icon = "infinity",
                })
            else
                WindUI:Notify({
                    Title = "无限体力已禁用",
                    Content = "冲刺耐力重置为正常",
                    Duration = 3,
                    Icon = "infinity",
                })
            end
        end)
    end
})



local GodModeToggle = PlayerTab:Toggle({
    Title = "半无敌模式",
    Desc = "只有Godmode在Fall Damage中",
    Icon = "shield-ellipsis",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
    if state and not semiGodActive then
if hookmetamethod then
semiGodHook = hookmetamethod(game, "__namecall", function(self, ...)
local args = {...}
local method = getnamecallmethod()
if method == "FireServer" and self.Name == "Asynchronous" then
if args[1] == "HurtSelf" then
args[3] = 0.001
elseif args[1] == "CharHit" then
args[4] = "Humanoid"
end
return semiGodHook(self, unpack(args))
end
return semiGodHook(self, ...)
end)
semiGodActive = true
else
game.Players.LocalPlayer:Kick("Exploit not supported!")
end
elseif not state and semiGodActive then
print("-)+.")
semiGodActive = false
end
end
})

local InfiniteSprintToggle = PlayerTab:Toggle({
    Title = "无限跳",
    Desc = "",
    Icon = "infinity",
    Type = "Checkbox",
    Default = false,
    Callback = function(enabled)
    if enabled then
_G.InfiniteJumpEnabled = true
if not _G.InfiniteJumpConnection then
_G.InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
if _G.InfiniteJumpEnabled then
local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if hum then hum:ChangeState("Jumping") end
end
end)
end
else
_G.InfiniteJumpEnabled = false
if _G.InfiniteJumpConnection then
_G.InfiniteJumpConnection:Disconnect()
_G.InfiniteJumpConnection = nil
end
end
end
})

local NoclipToggle = PlayerTab:Toggle({
    Title = "穿墙",
    Desc = "",
    Icon = "ghost",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
    if state then
_G.NoclipLoop = game:GetService("RunService").Stepped:Connect(function()
local char = game.Players.LocalPlayer.Character
if char then
for _, part in pairs(char:GetDescendants()) do
if part:IsA("BasePart") then part.CanCollide = false end
end
end
end)
else
if _G.NoclipLoop then _G.NoclipLoop:Disconnect() end
end
end
})

local AutoSection = AutoTab:Section({
    Title = "自动农场",
    Icon = "repeat",
})

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Variables
local player = Players.LocalPlayer
local baseplateEnabled = false
local customBaseplate = nil
local teleportConnection = nil
local antiAfkConnection = nil

-- Settings
local baseplatePosition = Vector3.new(-36, 80 - 460, -473)
local baseplateSize = Vector3.new(50, 4, 50)
local spawnLocation = Vector3.new(0, 50, 0) -- Default spawn location

-- Functions
local function createBaseplate()
    customBaseplate = Instance.new("Part")
    customBaseplate.Name = "ViperBaseplate"
    customBaseplate.Size = baseplateSize
    customBaseplate.Position = baseplatePosition
    customBaseplate.Anchored = true
    customBaseplate.CanCollide = true
    customBaseplate.Material = Enum.Material.Neon
    customBaseplate.Color = Color3.fromRGB(0, 255, 0)
    customBaseplate.Transparency = 0.5
    customBaseplate.Parent = Workspace
end

local function teleportToBaseplate()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local newPosition = Vector3.new(baseplatePosition.X, baseplatePosition.Y + 10, baseplatePosition.Z)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(newPosition)
    end
end

local function teleportToSpawn()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(spawnLocation)
    end
end

local function startTeleportLoop()
    teleportConnection = task.spawn(function()
        while baseplateEnabled do
            teleportToBaseplate()
            task.wait(15) -- 30 seconds
        end
    end)
end

local AutoFarmToggle = AutoTab:Toggle({
    Title = "自动刷胜利",
    Desc = "需要防挂机",
    Icon = "arrow-right-left",
    Type = "Checkbox",
    Default = false,
    Callback = function(Value)
    baseplateEnabled = Value
       
       if baseplateEnabled then
           -- Toggle ON: Create baseplate and start teleporting
           createBaseplate()
           teleportToBaseplate()
           startTeleportLoop()
       else
           -- Toggle OFF: Remove baseplate and teleport to spawn
           if customBaseplate then
               customBaseplate:Destroy()
               customBaseplate = nil
           end
           if teleportConnection then
               task.cancel(teleportConnection)
               teleportConnection = nil
           end
           teleportToSpawn()
       end
   end,
})

local AntiAfkToggle = AutoTab:Toggle({
    Title = "防挂机",
    Desc = "",
    Icon = "shield-ellipsis",
    Type = "Checkbox",
    Default = false,
    Callback = function(Value)
           if Value then
           -- Start Anti-AFK with input simulation
           antiAfkConnection = task.spawn(function()
               while Value do
                   -- Wait 2 minutes (120 seconds)
                   task.wait(40)
                   
                   -- Simulate random input to prevent AFK
                   local success, err = pcall(function()
                       local VirtualInputManager = game:GetService("VirtualInputManager")
                       local keys = {"W", "A", "S", "D", "Space"}
                       local randomKey = keys[math.random(1, #keys)]
                       
                       -- Send key press and release
                       VirtualInputManager:SendKeyEvent(true, randomKey, false, game)
                       task.wait(0.1)
                       VirtualInputManager:SendKeyEvent(false, randomKey, false, game)
                       
                       print("AntiAFK: Simulated " .. randomKey .. " key press")
                   end)
                   
                   if not success then
                       warn("Anti-AFK Error: " .. tostring(err))
                   end
               end
           end)
       else
           -- Stop Anti-AFK
           if antiAfkConnection then
               task.cancel(antiAfkConnection)
               antiAfkConnection = nil
           end
       end
   end,
})

local AutoSection = AutoTab:Section({
    Title = "自动一次",
    Icon = "repeat",
})

local AntiVoidToggle = AutoTab:Toggle({
    Title = "防溺水与防虚空",
    Desc = "",
    Icon = "check",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
    if state then
            -- Create AntiVoid Baseplate
            AntiVoid = Instance.new("Part")
            AntiVoid.Size = Vector3.new(1000, 1, 1000)
            AntiVoid.Position = Vector3.new(0, -10, 0)
            AntiVoid.Anchored = true
            AntiVoid.CanCollide = true
            AntiVoid.Transparency = 0.4
            AntiVoid.BrickColor = BrickColor.new("Lime green")
            AntiVoid.Name = "AntiVoid"
            AntiVoid.Parent = workspace
        else
            -- Remove AntiVoid if exists
            if AntiVoid and AntiVoid.Parent then
                AntiVoid:Destroy()
                AntiVoid = nil
            end
        end
    end
})

local CampButton = AutoTab:Button({
    Title = "地图下方安营",
    Desc = "",
    Icon = "map",
    Type = "Checkbox",
    Default = false,
    Callback = function()
    local platform = Instance.new("Part")
platform.Size = Vector3.new(500, 1, 500)
platform.Position = Vector3.new(0, -500, 0)
platform.Anchored = true
platform.CanCollide = true
platform.Transparency = 0.7
platform.Color = Color3.fromRGB(0, 255, 0)
platform.Name = "AutoWinPlatform"
platform.Parent = workspace
local char = game.Players.LocalPlayer.Character
if char then char:MoveTo(Vector3.new(0, -498, 0)) end
end
})

local lobbyPos = Vector3.new(0, 10, 0)
local sideBaseplatePos = nil
local sideBaseplateSize = Vector3.new(80, 2, 80)

local BaseplateButton = AutoTab:Button({
    Title = "创建平台",
    Desc = "",
    Icon = "check",
    Type = "Checkbox",
    Default = false,
    Callback = function()
    local ws = game:GetService("Workspace")
local found = false
for _, obj in ipairs(ws:GetDescendants()) do
if obj:IsA("SpawnLocation") and (obj.Name:lower():find("lobby") or obj.Name:lower():find("spawn")) then
lobbyPos = obj.Position
found = true
break
end
end
sideBaseplatePos = lobbyPos + Vector3.new(120, 5, 0)
local part = Instance.new("Part")
part.Size = sideBaseplateSize
part.Position = sideBaseplatePos
part.Anchored = true
part.CanCollide = true
part.Transparency = 0.2
part.BrickColor = BrickColor.new("Bright blue")
part.Name = "AutoWinSideBaseplate"
part.Parent = workspace
WindUI:Notify({
    Title = "Created Baseplate",
    Content = "Use tp to baseplate to Survive once",
    Duration = 3, -- 3 seconds
    Icon = "check",
})
end
})

local tptobaseButton = AutoTab:Button({
    Title = "传送到平台",
    Desc = "",
    Icon = "check",
    Type = "Checkbox",
    Default = false,
    Callback = function()
    if sideBaseplatePos then
local char = game.Players.LocalPlayer.Character
if char then char:MoveTo(sideBaseplatePos + Vector3.new(0, 5, 0)) end
else
warn("Create a Baseplate First")
WindUI:Notify({
    Title = "错误",
    Content = "Create a Baseplate First",
    Duration = 3, -- 3 seconds
    Icon = "x",
})
end
end
})

local FeaturesSection = FeaturesTab:Section({
    Title = "Others",
    Icon = "zap",
})

local TpLobbyButton = FeaturesTab:Button({
    Title = "传送到大厅",
    Desc = "不计算胜利",
    Locked = false,
    Callback = function()
        local ws = game:GetService("Workspace")
local found = false
for _, obj in ipairs(ws:GetDescendants()) do
if obj:IsA("SpawnLocation") and (obj.Name:lower():find("lobby") or obj.Name:lower():find("spawn")) then
lobbyPos = obj.Position
found = true
break
end
end
local char = game.Players.LocalPlayer.Character
if char then char:MoveTo(lobbyPos) end
if not found then
warn("Failed toTp")
WindUI:Notify({
    Title = "错误",
    Content = "如果您发现错误，Tp报告未能在我的Discord社区",
    Duration = 3, -- 3 seconds
    Icon = "x",
})
end
end
})

local TpMapButton = FeaturesTab:Button({
    Title = "传送到地图",
    Desc = "",
    Locked = false,
    Callback = function()
        local ws = workspace:FindFirstChild("Map")
        if ws and ws:FindFirstChild("Other") and ws.Other:FindFirstChild("Spawns") then
            local spawnsFolder = ws.Other.Spawns
            for _, spawn in ipairs(spawnsFolder:GetChildren()) do
                if spawn:IsA("SpawnLocation") or spawn:IsA("Part") then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
                        break -- stop after first teleport
                    end
                end
            end
        else
            warn("Failed to Tp Map Spawns not found")
        end
    end
}) 
