-- Load Avantrix Library
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xenlua/Xens/refs/heads/main/ui/Avantrix.lua"))() 
local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/xenlua/Xens/refs/heads/main/ui/Flags"))()

local LPH_JIT_MAX = function(...) return(...) end
local LPH_NO_VIRTUALIZE = function(...) return(...) end
local LPH_CRASH = function(...) while task.wait() do game:GetService("ScriptContext"):SetTimeout(math.huge);while true do while true do while true do while true do while true do while true do while true do while true do print("noob") end end end end end end end end end end
local LRM_UserNote = "Owner"
local LRM_ScriptVersion = "v19"
local ClonedPrint = print

if LPH_OBFUSCATED then
    ClonedPrint = print
    print = function(...)end
    warn = function(...)end

    local PreventSkidsToMakeGayThings = loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/InfiniX/a40a158d22fd4f4733beb2f67379866ccb17906f/Library/Anti/AntiDebug/main.lua", true))()

    if not (type(PreventSkidsToMakeGayThings) == "table") then
        LPH_CRASH()
    end
end

repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Format version function
function formatVersion(version)
    local formattedVersion = "v" .. version:sub(2):gsub("。", "%0。")
    return formattedVersion:sub(1, #formattedVersion - 1)
end

-- Initialize main GUI
local main = lib:Load({
    Title = '99夜'..formatVersion(LRM_ScriptVersion)..' | ' .. gradient("Avantrix").. " | ",
    ToggleButton = "rbxassetid://100227182680708",
})

-- Create tabs
local tabs = {
    Welcome = main:AddTab("信息"),
    Main = main:AddTab("主要"),
    Teleport = main:AddTab("传送"),
    Bring = main:AddTab("物品召回"),
    Chest = main:AddTab("宝箱查找"),
    Hitbox = main:AddTab("碰撞箱"),
    Misc = main:AddTab("杂项"),
    Settings = main:AddTab("设置"),
}

main:SelectTab()

-- Create sections
local sections = {
    Welcome = tabs.Welcome:AddSection({Defualt = true, Locked = true}),
    MainFarm = tabs.Main:AddSection({Title = "刷取控制", Description = "主要农业特征", Defualt = true, Locked = false}),
    AutoEat = tabs.Main:AddSection({Title = "自动进食系统", Description = "自动管理饥饿值", Defualt = false, Locked = false}),
    TeleportControls = tabs.Teleport:AddSection({Title = "传送控制", Description = "快捷传送选项", Defualt = true, Locked = false}),
    BringItems = tabs.Bring:AddSection({Title = "物品收集", Description = "将物品拉到你的位置", Defualt = true, Locked = false}),
    AutoDetectItems = tabs.Bring:AddSection({Title = "全部物品", Description = "自动检测并从工作区拉取物品", Defualt = false, Locked = false}),
    ScrapItems = tabs.Bring:AddSection({Title = "可回收物品", Description = "管理可回收物品", Defualt = false, Locked = false}),
    FuelItems = tabs.Bring:AddSection({Title = "燃料物品", Description = "管理燃料物品", Defualt = false, Locked = false}),
    ChestFinder = tabs.Chest:AddSection({Title = "宝箱检测", Description = "查找并传送到宝箱", Defualt = true, Locked = false}),
    HitboxControls = tabs.Hitbox:AddSection({Title = "碰撞箱 扩展", Description = "扩大敌人碰撞箱", Defualt = true, Locked = false}),
    MiscFeatures = tabs.Misc:AddSection({Title = "杂项", Description = "各种实用功能", Defualt = true, Locked = false}),
    Performance = tabs.Misc:AddSection({Title = "性能", Description = "帧率与性能工具", Defualt = false, Locked = false}),
}

-- Variables
local var = {}
local selectedItemToBring = {}
local selectedPosition = {}
local selectedChestToTeleport = {}
local selectedScrapItem = {}
local selectedScrapPosition = {}
local selectedFuelItem = {}
local selectedFuelPosition = {}
local selectedFoodItem = {}

-- Auto Eat Variables
local autoEatActive = false
local autoEatThreshold = 30
local maxHunger = 200

-- Auto Drag Variables
local autoDragActive = false
local autoDragScrapActive = false
local autoDragFuelActive = false

-- Initialize welcome paragraph
var.WelcomeParagraph = sections.Welcome:AddParagraph({
    Title = gradient("加载中。。。"), 
    Description = "请稍候。。\n如果长时间卡在这里，请加入我们的 Discord 反馈。\n你也可以尝试：\n- 重新执行\n- 重新加入"
})

var.WelcomeParagraph:SetTitle(gradient("欢迎使用 Avantrix 脚本！"))
var.WelcomeParagraph:SetDesc([[<font color="rgb(255,255,255)">NEWS:</font>
[+] Auto Eat System Added
[+] Chest Finder System Added
[+] Teleport to Chest Locations
[+] Scrappable Items Management

<b><font color='rgb(255, 255, 255)'>----------------------------------------[Features]--------------------------------------</font></b>

<font color="rgb(255,255,255)">Version:</font> ]] .. formatVersion(LRM_ScriptVersion) .. [[

<font color="rgb(255,255,255)">Features:</font>
• Kill aura (attacks all mobs simultaneously with minimal delay)
• Auto Eat System (continues until max hunger)
• Teleportation System
• Item Bringing/Collection to Multiple Destinations
• Auto Detect Items from workspace
• Auto Drag Items LooG to Multiple Destinations
• Scrappable Items Bgement
• Auto Drag Scrap ItemY Loop to Multiple Destinations
• Fuel Items Management
• Auto Drag Fuel ItemN Loop to Multiple Destinations
• Chest Finder & Teleport System
• Hitbox Expansion
• Speed HackM
• FPS/Ping DisplayS
• Performance Optimization L

<font color="rgb(255,255,255)">Instructions:</font>
1. Configure your preferences in each tab
2. Enable desired features
3. Use Auto Eat to manage hunger automatically until max
4. Use Auto Detect Items to find and drag items in workspace
5. Use Scrap Items to manage and drag scrappable items
6. Use Fuel Items to manage and drag fuel items
7. Use Chest Finder to locate and teleport to chests
8. Use responsibly to avoid detection

<font color="rgb(255,255,255)">Discord:</font> discord.gg/cF8YeDPt2G]])

-- Add Discord button
sections.Welcome:AddButton({
    Title = "复制 Discord 链接",
    Callback = function()
        setclipboard("https://discord。gg/cF8YeDPt2G")
        lib:Dialog({
            Title = "成功",
            Content = "Discord 链接已复制到剪贴板！",
            Buttons = {
                {
                    Title = "确定",
                    Variant = "Primary",
                    Callback = function() end,
                }
            }
        })
    end,
})

-- Game Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local infHungerActive = false
local ToolDamageObject = ReplicatedStorage.RemoteEvents.ToolDamageObject
local RequestConsumeItem = ReplicatedStorage.RemoteEvents.RequestConsumeItem
local RequestStartDraggingItem = ReplicatedStorage.RemoteEvents.RequestStartDraggingItem
local StopDraggingItem = ReplicatedStorage.RemoteEvents.StopDraggingItem
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local itemsFolder = workspace:WaitForChild("Items")
local remoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

-- Main Farm Section - IMPROVED KILL AURA
local killAuraActive = false
local killAuraRange = 100
local killAuraSpeed = 0.5

local safezoneBaseplates = {}
local baseplateSize = Vector3.new(2048, 5, 2048)
local baseY = 130
local centerPos = Vector3.new(0, baseY, 0) -- original center

for dx = -1, 1 do
    for dz = -1, 1 do
        local pos = centerPos + Vector3.new(dx * baseplateSize.X, 0, dz * baseplateSize.Z)
        local baseplate = Instance.new("Part")
        baseplate.Name = "SafeZoneBaseplate"
        baseplate.Size = baseplateSize
        baseplate.Position = pos
        baseplate.Anchored = true
        baseplate.CanCollide = true
        baseplate.Transparency = 1
        baseplate.Color = Color3.fromRGB(255, 255, 255)
        baseplate.Parent = workspace
        table.insert(safezoneBaseplates, baseplate)
    end
end

local function teleportToTarget(cf, duration)
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if duration and duration > 0 then
        local ts = game:GetService("TweenService")
        local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local goal = { CFrame = cf }
        local tween = ts:Create(hrp, info, goal)
        tween:Play()
    else
        hrp.CFrame = cf
    end
end

local function stringToCFrame(str)
    local x, y, z = str:match("([^,]+),%s*([^,]+),%s*([^,]+)")
    return CFrame.new(tonumber(x), tonumber(y), tonumber(z))
end

local storyCoords = {
    { "[campsite] camp site", "0, 8, -0"},
    { "[safezone] safe zone", "0, 140, -0" }
}

local toolsDamageIDs = {
    ["Old Axe"] = "1_8982038982",
    ["Good Axe"] = "112_8982038982",
    ["Strong Axe"] = "116_8982038982",
    ["Chainsaw"] = "647_8992824875",
    ["Spear"] = "196_8999010016"
}

local function getAnyToolWithDamageID()
    for toolName, damageID in pairs(toolsDamageIDs) do
        local tool = player.Inventory:FindFirstChild(toolName)
        if tool then
            return tool, damageID
        end
    end
    return nil, nil
end

local function getEquippedWeapon()
    local character = LocalPlayer.Character
    if character then
        for _, child in pairs(character:GetChildren()) do
            if child:IsA("Tool") and child:GetAttribute("WeaponDamage") then
                return child
            end
        end
    end
    return nil
end

local function getAllWeapons()
    local weapons = {}
    local player = Players.LocalPlayer
    local inventory = player:FindFirstChild("Inventory")
    if inventory then
        for _, item in pairs(inventory:GetChildren()) do
            if item:GetAttribute("WeaponDamage") then
                table.insert(weapons, item)
            end
        end
    end
    return weapons
end

-- Auto Eat Functions
local function getCurrentHunger()
    local player = LocalPlayer
    local hunger = player:GetAttribute("Hunger") or 0
    return hunger
end

local function getFoodItems()
    local foodItems = {"Apple","Carrot", "Berry", "Cooked Morsel", "Cooked Steak"}
    table.sort(foodItems)
    return foodItems
end

local function findFoodItem(foodName)
    if not foodName then return {} end
    local itemsFolder = workspace:FindFirstChild("Items")
    local foundItems = {}
    if itemsFolder then
        for _, item in pairs(itemsFolder:GetChildren()) do
            if item.Name == foodName then
                table.insert(foundItems, item)
            end
        end
    end
    return foundItems
end

local function autoEatLoop()
    task.spawn(function()
        while autoEatActive do
            local currentHunger = getCurrentHunger()
            
            if currentHunger <= autoEatThreshold and #selectedFoodItem > 0 then
                while currentHunger < maxHunger and autoEatActive do
                    local ateSomething = false
                    for _, foodName in ipairs(selectedFoodItem) do
                        local foodItems = findFoodItem(foodName)
                        for _, food in ipairs(foodItems) do
                            if food and food.Parent then
                                pcall(function()
                                    RequestConsumeItem:InvokeServer(food)
                                    ateSomething = true
                                end)
                                task.wait(0.0000005)
                                currentHunger = getCurrentHunger()
                                if currentHunger >= maxHunger then
                                    break
                                end
                            end
                        end
                        if currentHunger >= maxHunger then
                            break
                        end
                    end
                    if not ateSomething then
                        break
                    end
                    task.wait(0.000001)
                end
            end
            task.wait(0.000001)
        end
    end)
end

-- Function to get all items from workspace.Items
local function getAllItemsFromWorkspace()
    local items = {}
    local itemsFolder = workspace:FindFirstChild("Items")
    if itemsFolder then
        for _, item in pairs(itemsFolder:GetChildren()) do
            if not table.find(items, item.Name) then
                table.insert(items, item.Name)
            end
        end
    end
    table.sort(items)
    return items
end



-- Function to get scrappable items
local function getScrappableItems()
    local scrapItems = {"UFO Junk", "UFO Component", "Old Car Engine", "Broken Fan", "Old Microwave", "Bolt", "Log", "Cultist Gem", "Sheet Metal", "Old Radio","Tyre","Washing Machine", "Cultist Experiment", "Cultist Component", "Gem of the Forest Fragment", "Broken Microwave"}
    table.sort(scrapItems)
    return scrapItems
end



-- Function to get fuel items
local function getFuelItems()
    local fuelItems = {"Log", "Coal", "Fuel Canister", "Oil Barrel", "Biofuel"}
    table.sort(fuelItems)
    return fuelItems
end

-- Function to get all chests from workspace
local function getAllChestsFromWorkspace()
    local chests = {}
    local chestsData = {}
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("chest") or obj.Name:lower():find("crate") or obj.Name:lower():find("box")) then
            local position = nil
            local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
            
            if rootPart then
                position = rootPart.Position
                local displayName = obj.Name .. " (" .. math.floor(position.X) .. ", " .. math.floor(position.Y) .. ", " .. math.floor(position.Z) .. ")"
                
                if not table.find(chests, displayName) then
                    table.insert(chests, displayName)
                    chestsData[displayName] = {
                        model = obj,
                        position = position,
                        name = obj.Name
                    }
                end
            end
        end
    end
    
    table.sort(chests)
    return chests, chestsData
end

local function moveItemToPos(item, position)
    if not item or not item:IsDescendantOf(workspace) then return end

    local part = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart") or item:FindFirstChild("Handle")
    if not part then return end

    -- Pastikan PrimaryPart diset
    if not item.PrimaryPart then
        pcall(function() item.PrimaryPart = part end)
    end

    -- Tunggu sampai item benar-benar ready
    local function waitForPhysics()
        local start = tick()
        repeat
            task.wait()
        until part:IsDescendantOf(workspace) and part:IsA("BasePart") and part:IsDescendantOf(item) or tick() - start > 3
    end

    waitForPhysics()

    -- Coba ambil ownership
    pcall(function()
        remoteEvents.RequestStartDraggingItem:FireServer(item)
    end)

    task.wait(0.1)

    -- Coba set posisi
    pcall(function()
        if item.PrimaryPart then
            item:SetPrimaryPartCFrame(CFrame.new(position))
        end
    end)

    task.wait(0.1)

    -- Hentikan dragging
    pcall(function()
        remoteEvents.StopDraggingItem:FireServer(item)
    end)
end


-- Modified function for bringing items using moveItemToPos
local function bringItemsByName(names, positions)
    local count = 0
    if not names or #names == 0 or not positions or #positions == 0 then
        return 0
    end

    local itemsFolder = workspace:FindFirstChild("Items")
    if not itemsFolder then
        return 0
    end

    for _, item in ipairs(itemsFolder:GetChildren()) do
        for _, name in ipairs(names) do
            if item.Name == name then
                for _, position in ipairs(positions) do
                    local targetPosition
                    if position == "玩家身边" then
                        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            return 0
                        end
                        targetPosition = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
                    elseif position == "营火" then
                        targetPosition = Vector3.new(0, 19, 0)
                    elseif position == "回收机" then
                        local scrapper = workspace.Map.Campground.Scrapper
                        if scrapper and scrapper:FindFirstChild("GlowEffect") then
                            targetPosition = scrapper.GlowEffect.Position + Vector3.new(0, 19, 0)
                        else
                            return 0
                        end
                    elseif position == "冷冻柜" then
                        local freezer = workspace:FindFirstChild("Structures") and workspace.Structures:FindFirstChild("冷冻柜")
                        if freezer and freezer:IsA("Model") then
                            local autoStack = freezer:FindFirstChild("AutoStack")
                            if autoStack then
                                local touchZone = autoStack:FindFirstChild("TouchZone")
                                if touchZone and touchZone:IsA("BasePart") then
                                    targetPosition = touchZone.Position + Vector3.new(0, 3, 0)
                                else
                                    return 0
                                end
                            else
                                return 0
                            end
                        else
                            return 0
                        end
                    else
                        return 0
                    end
                    moveItemToPos(item, targetPosition)
                    count = count + 1
                    task.wait(0.1)
                end
            end
        end
    end
    return count
end

-- Modified function for drag and drop
local function dragAndDropItem(itemNames, positions)
    if not itemNames or #itemNames == 0 or not positions or #positions == 0 then
        return
    end

    local itemsFolder = workspace:FindFirstChild("Items")
    if not itemsFolder then
        return
    end

    for _, item in ipairs(itemsFolder:GetChildren()) do
        for _, itemName in ipairs(itemNames) do
            if item.Name == itemName then
                for _, position in ipairs(positions) do
                    local targetPosition
                    if position == "玩家身边" then
                        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            return
                        end
                        targetPosition = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
                    elseif position == "营火" then
                        targetPosition = Vector3.new(0, 19, 0)
                    elseif position == "回收机" then
                        local scrapper = workspace.Map.Campground.Scrapper
                        if scrapper and scrapper:FindFirstChild("GlowEffect") then
                            targetPosition = scrapper.GlowEffect.Position + Vector3.new(0, 19, 0)
                        else
                            return
                        end
                    elseif position == "冷冻柜" then
                        local freezer = workspace:FindFirstChild("Structures") and workspace.Structures:FindFirstChild("冷冻柜")
                        if freezer and freezer:IsA("Model") then
                            local autoStack = freezer:FindFirstChild("AutoStack")
                            if autoStack then
                                local touchZone = autoStack:FindFirstChild("TouchZone")
                                if touchZone and touchZone:IsA("BasePart") then
                                    targetPosition = touchZone.Position + Vector3.new(0, 3, 0)
                                else
                                    return
                                end
                            else
                                return
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                    moveItemToPos(item, targetPosition)
                    task.wait(0.1)
                end
            end
        end
    end
end

-- Auto drag loop for all items
local function autoDragLoop()
    task.spawn(function()
        while autoDragActive do
            if #selectedItemToBring > 0 and #selectedPosition > 0 then
                dragAndDropItem(selectedItemToBring, selectedPosition)
            else
                autoDragActive = false
                sections.AutoDetectItems:GetToggle("AutoDragItems"):Set(false)
                break
            end
            task.wait(0.1)
        end
    end)
end

-- Auto drag loop for scrap items
local function autoDragScrapLoop()
    task.spawn(function()
        while autoDragScrapActive do
            if #selectedScrapItem > 0 and #selectedScrapPosition > 0 then
                dragAndDropItem(selectedScrapItem, selectedScrapPosition)
            else
                autoDragScrapActive = false
                sections.ScrapItems:GetToggle("AutoDragScrapItems"):Set(false)
                break
            end
            task.wait(0.1)
        end
    end)
end

-- Auto drag loop for fuel items
local function autoDragFuelLoop()
    task.spawn(function()
        while autoDragFuelActive do
            if #selectedFuelItem > 0 and #selectedFuelPosition > 0 then
                dragAndDropItem(selectedFuelItem, selectedFuelPosition)
            else
                autoDragFuelActive = false
                sections.FuelItems:GetToggle("AutoDragFuelItems"):Set(false)
                break
            end
            task.wait(0.1)
        end
    end)
end

local function equipTool(tool)
    if tool then
        RemoteEvents.EquipItemHandle:FireServer("FireAllClients", tool)
    end
end

local function unequipTool(tool)
    if tool then
        RemoteEvents.UnequipItemHandle:FireServer("FireAllClients", tool)
    end
end

-- Modified Kill Aura to attack all mobs simultaneously with minimal delay
local function killAuraLoop()
    while killAuraActive do
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local tool, damageID = getAnyToolWithDamageID()
            if tool and damageID then
                equipTool(tool)
                local mobs = Workspace.Characters:GetChildren()
                for _, mob in ipairs(mobs) do
                    if mob:IsA("Model") then
                        local part = mob:FindFirstChildWhichIsA("BasePart")
                        if part and (part.Position - hrp.Position).Magnitude <= killAuraRange then
                            pcall(function()
                                RemoteEvents.ToolDamageObject:InvokeServer(
                                    mob,
                                    tool,
                                    damageID,
                                    CFrame.new(part.Position)
                                )
                            end)
                        end
                    end
                end
            else
                warn("No supported tool found in inventory")
                task.wait(0.03)
            end
        else
            task.wait(0.05)
        end
        task.wait(0.03) -- Minimal delay for next loop iteration
    end
end

local originalTreeCFrames = {}
local treesBrought = false

local function getAllSmallTrees()
    local trees = {}
    local function scan(folder)
        for _, obj in ipairs(folder:GetChildren()) do
            if obj:IsA("Model") and obj.Name == "Small Tree" then
                table.insert(trees, obj)
            end
        end
    end

    local map = Workspace:FindFirstChild("Map")
    if map then
        if map:FindFirstChild("Foliage") then scan(map.Foliage) end
        if map:FindFirstChild("Landmarks") then scan(map.Landmarks) end
    end
    return trees
end

local function findTrunk(tree)
    for _, part in ipairs(tree:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "Trunk" then return part end
    end
end

local function bringAllTrees()
    local target = CFrame.new(rootPart.Position + rootPart.CFrame.LookVector * 10)
    for _, tree in ipairs(getAllSmallTrees()) do
        local trunk = findTrunk(tree)
        if trunk then
            if not originalTreeCFrames[tree] then originalTreeCFrames[tree] = trunk.CFrame end
            tree.PrimaryPart = trunk
            trunk.Anchored = false
            trunk.CanCollide = false
            task.wait()
            tree:SetPrimaryPartCFrame(target + Vector3.new(math.random(-5,5), 0, math.random(-5,5)))
            trunk.Anchored = true
        end
    end
    treesBrought = true
end

local function restoreTrees()
    for tree, cframe in pairs(originalTreeCFrames) do
        local trunk = findTrunk(tree)
        if trunk then
            tree.PrimaryPart = trunk
            tree:SetPrimaryPartCFrame(cframe)
            trunk.Anchored = true
            trunk.CanCollide = true
        end
    end
    originalTreeCFrames = {}
    treesBrought = false
end

sections.MainFarm:AddToggle("KillAura", {
    Title = "杀戮光环",
    Default = false,
    Description = "使用已装备武器同时攻击附近所有动物",
    Callback = function(state)
        killAuraActive = state
        if state then
            task.spawn(killAuraLoop)
        else
            local tool, _ = getAnyToolWithDamageID()
            unequipTool(tool)
        end
    end,
})

sections.MainFarm:AddSlider("KillAuraRange", {
    Title = "杀戮光环范围",
    Description = "检测并攻击动物的范围",
    Default = killAuraRange,
    Min = 5,
    Max = 500,
    Increment = 1,
    Callback = function(value)
        killAuraRange = value
    end,
})

sections.MainFarm:AddButton({
    Title = "显示所有武器",
    Description = "显示检测到的全部武器信息",
    Callback = function()
        local weapons = getAllWeapons()
        local equippedWeapon = getEquippedWeapon()
        if #weapons > 0 then
            local weaponInfo = "找到 " .. #weapons .. " 把武器：\n\n"
            for i, weapon in pairs(weapons) do
                local damage = weapon:GetAttribute("WeaponDamage") or "Unknown"
                local equippedStatus = equippedWeapon and equippedWeapon == weapon and "（已装备）" or ""
                weaponInfo = weaponInfo .. i .. "。 " .. weapon.Name .. " (Damage: " .. tostring(damage) .. ")" .. equippedStatus .. "\n"
            end
            lib:Dialog({
                Title = "全部武器",
                Content = weaponInfo,
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            lib:Dialog({
                Title = "没有武器",
                Content = "背包中未找到带 WeaponDamage 属性的武器！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end,
})
autoBreakEnabled = false

sections.MainFarm:AddToggle("KillAura", {
    Title = "拉来所有小树",
    Default = false,
    Description = "同时把所有小树拉到你身边",
    Callback = function(state)
    autoBreakEnabled = state
    if state and not treesBrought then
        bringAllTrees()
    elseif not state and treesBrought then
        restoreTrees()
    end
    end,
})




local toggleActive = false

sections.MainFarm:AddToggle("TweenToBoundaries", {
    Title = "沿边界部件传送玩家",
    Default = false,
    Description = "依次将本地玩家传送到 边界 中的每个部件。",
    Callback = function(state)
        toggleActive = state

        if state then
            task.spawn(function()
                local boundaries = workspace:WaitForChild("Map"):WaitForChild("Boundaries")
                for _, part in ipairs(boundaries:GetDescendants()) do
                    if not toggleActive then break end
                    if part:IsA("BasePart") then
                        teleportToTarget(CFrame.new(part.Position + Vector3.new(0, 5, 0)), 0.4)
                        task.wait(0.5)
                    end
                end
            end)
        end
    end,
})

-- Auto Eat Section
local foodDropdown = sections.AutoEat:AddDropdown("FoodSelect", {
    Title = "选择要食用的食物",
    Description = "选择用于自动进食的食物",
    Options = getFoodItems(),
    Default = {},
    PlaceHolder = "选择食物",
    Multiple = true,
    Callback = function(selected)
        selectedFoodItem = selected or {}
    end
})

sections.AutoEat:AddButton({
    Title = "刷新食物列表",
    Description = "用当前可用食物更新下拉框",
    Callback = function()
        local foodItems = getFoodItems()
        selectedFoodItem = {}
        if #foodItems > 0 then
            foodDropdown:Refresh(foodItems, true)
            lib:Dialog({
                Title = "食物列表已刷新",
                Content = "成功fully refreshed。 找到 " .. #foodItems .. " 个食物。\n请在下拉框中重新选择食物。",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            foodDropdown:Refresh({}, true)
            lib:Dialog({
                Title = "没有食物",
                Content = "工作区未找到任何食物！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end
})

sections.AutoEat:AddToggle("AutoEat", {
    Title = "自动进食",
    Default = false,
    Description = "当饥饿值较低时自动食用所选食物直到满值",
    Callback = function(value)
        autoEatActive = value
        if value then
            if #selectedFoodItem == 0 then
                autoEatActive = false
                sections.AutoEat:GetToggle("AutoEat"):Set(false)
                lib:Dialog({
                    Title = "错误",
                    Content = "请先至少选择一种食物！",
                    Buttons = {
                        {
                            Title = "确定",
                            Variant = "Primary",
                            Callback = function() end,
                        }
                    }
                })
                return
            end
            autoEatLoop()
            lib:Dialog({
                Title = "自动进食 Enabled",
                Content = "当饥饿值降到 " .. autoEatThreshold .. " 或更低时将自动进食。\n将持续进食直到饥饿值达到 " .. maxHunger .. "。",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end,
})

sections.AutoEat:AddSlider("EatThreshold", {
    Title = "自动进食 Threshold",
    Description = "开始自动进食的饥饿值阈值",
    Default = 30,
    Min = 0,
    Max = maxHunger,
    Increment = 5,
    Callback = function(value)
        autoEatThreshold = math.clamp(value, 0, maxHunger)
    end,
})

sections.AutoEat:AddButton({
    Title = "查看当前饥饿值",
    Description = "显示当前饥饿值",
    Callback = function()
        local currentHunger = getCurrentHunger()
        local status = ""
        if currentHunger <= autoEatThreshold then
            status = "（将自动吃到满）"
        elseif currentHunger >= maxHunger then
            status = "（已满）"
        else
            status = "（正常）"
        end
        lib:Dialog({
            Title = "饥饿状态",
            Content = "当前饥饿值：" .. currentHunger .. "/" .. maxHunger .. status .. "\n\n自动进食 Threshold: " .. autoEatThreshold .. "\n已选食物：" .. table.concat(selectedFoodItem, ", "),
            Buttons = {
                {
                    Title = "确定",
                    Variant = "Primary",
                    Callback = function() end,
                }
            }
        })
    end,
})


sections.TeleportControls:AddButton({
    Title = "安全区",
    Description = "传送到安全区",
    Callback = function()
        for _, entry in ipairs(storyCoords) do
            local name, coord = entry[1], entry[2]
            if name:lower():find("safezone") then
                teleportToTarget(stringToCFrame(coord), 0.1)
                break -- stop setelah teleport
            end
        end
    end,
})
-- Teleport Controls Section
sections.TeleportControls:AddButton({
    Title = "传送到夏令营",
    Description = "传送到夏令营",
    Callback = function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(
                13.287363052368164, 3.999999761581421, 0.36212217807769775,
                0.6022269129753113, -2.275036159460342e-08, 0.7983249425888062,
                6.430457055728311e-09, 1, 2.364672191390582e-08,
                -0.7983249425888062, -9.1070981866892e-09, 0.6022269129753113
            )
        end
    end,
})

sections.TeleportControls:AddButton({
    Title = "传送到交易员",
    Description = "传送到交易员",
    Callback = function()
        local pos = Vector3.new(-37.08, 3.98, -16.33)
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(pos)
    end,
})

sections.TeleportControls:AddButton({
    Title = "传送到随机小树",
    Description = "传送到一棵随机的树",
    Callback = function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart", 3)
        if not hrp then return end

        local map = workspace:FindFirstChild("Map")
        if not map then return end
        local foliage = map:FindFirstChild("Foliage") or map:FindFirstChild("Landmarks")
        if not foliage then return end

        local trees = {}
        for _, obj in ipairs(foliage:GetChildren()) do
            if obj.Name == "Small Tree" and obj:IsA("Model") then
                local trunk = obj:FindFirstChild("Trunk") or obj.PrimaryPart
                if trunk then
                    table.insert(trees, trunk)
                end
            end
        end

        if #trees > 0 then
            local trunk = trees[math.random(1, #trees)]
            local treeCFrame = trunk.CFrame
            local rightVector = treeCFrame.RightVector
            local targetPosition = treeCFrame.Position + rightVector * 3
            hrp.CFrame = CFrame.new(targetPosition)
        end
    end,
})

-- Bring Items Section
sections.BringItems:AddButton({
    Title = "拉取全部物品",
    Description = "将所有物品拉到你身边",
    Callback = function()
        local count = 0
        for _, item in ipairs(workspace.Items:GetChildren()) do
            local targetPosition = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
            moveItemToPos(item, targetPosition)
            count = count + 1
            task.wait(0.1)
        end
        lib:Dialog({
            Title = "成功",
            Content = "已拉取 " .. count .. " 个物品到你的位置！",
            Buttons = {
                {
                    Title = "确定",
                    Variant = "Primary",
                    Callback = function() end,
                }
            }
        })
    end,
})

sections.BringItems:AddButton({
    Title = "自动烤肉",
    Description = "把肉类拉到营火处烤制",
    Callback = function()
        local campfirePos = Vector3.new(1.87, 4.33, -3.67)
        local count = 0
        for _, item in pairs(workspace.Items:GetChildren()) do
            if item:IsA("Model") or item:IsA("BasePart") then
                local name = item.Name:lower()
                if name:find("meat") then
                    local targetPosition = campfirePos + Vector3.new(math.random(-2, 2), 0.5, math.random(-2, 2))
                    moveItemToPos(item, targetPosition)
                    count = count + 1
                    task.wait(0.1)
                end
            end
        end
        lib:Dialog({
            Title = "成功",
            Content = "已拉取 " .. count .. " 份肉类到营火！",
            Buttons = {
                {
                    Title = "确定",
                    Variant = "Primary",
                    Callback = function() end,
                }
            }
        })
    end,
})

sections.BringItems:AddButton({
    Title = "拉来迷路的孩子",
    Description = "把迷路的小孩 NPC 拉过来",
    Callback = function()
        local count = 0
        for _, model in ipairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model.Name:lower():find("lost") and model:FindFirstChild("HumanoidRootPart") then
                local targetPosition = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                moveItemToPos(model, targetPosition)
                count = count + 1
                task.wait(0.1)
            end
        end
    end,
})

-- Auto Detect Items Section
local itemDropdown = sections.AutoDetectItems:AddDropdown("ItemSelect", {
    Title = "选择要拉取的物品",
    Description = "从工作区中选择物品",
    Options = getAllItemsFromWorkspace(),
    Default = {},
    PlaceHolder = "选择物品",
    Multiple = true,
    Callback = function(selected)
        selectedItemToBring = selected or {}
    end
})

local positionDropdown = sections.AutoDetectItems:AddDropdown("PositionSelect", {
    Title = "选择目标位置",
    Description = "选择要把所选物品拉到哪里",
    Options = {"玩家身边", "营火", "回收机", "冷冻柜"},
    Default = {"玩家身边"},
    PlaceHolder = "选择位置",
    Multiple = true,
    Callback = function(selected)
        selectedPosition = selected or {"玩家身边"}
    end
})

sections.AutoDetectItems:AddToggle("AutoDragItems", {
    Title = "自动拖动物品",
    Default = false,
    Description = "自动把所选物品拖到所选位置",
    Callback = function(value)
        autoDragActive = value
        if value then
            if #selectedItemToBring == 0 or #selectedPosition == 0 then
                autoDragActive = false
                sections.AutoDetectItems:GetToggle("AutoDragItems"):Set(false)
                lib:Dialog({
                    Title = "错误",
                    Content = "请先至少选择一种物品和一个位置！",
                    Buttons = {
                        {
                            Title = "确定",
                            Variant = "Primary",
                            Callback = function() end,
                        }
                    }
                })
                return
            end
            autoDragLoop()
        end
    end,
})

sections.AutoDetectItems:AddButton({
    Title = "刷新物品列表",
    Description = "使用工作区中的当前物品更新下拉菜单",
    Callback = function()
        local items = getAllItemsFromWorkspace()
        selectedItemToBring = {}
        if #items > 0 then
            itemDropdown:Refresh(items, true)
            lib:Dialog({
                Title = "物品列表已刷新",
                Content = "成功完全刷新。 找到 " .. #items .. " 物品\n请从下拉菜单中重新选择物品",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            itemDropdown:Refresh({}, true)
            lib:Dialog({
                Title = "没有物品",
                Content = "未找到任何物品！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end
})

sections.AutoDetectItems:AddButton({
    Title = "拉取所选物品",
    Description = "将所选物品的所有实例带到所选位置",
    Callback = function()
        if #selectedItemToBring > 0 and #selectedPosition > 0 then
            local count = bringItemsByName(selectedItemToBring, selectedPosition)
            lib:Dialog({
                Title = "成功",
                Content = "已拉取 " .. count .. " 个物品（" .. table.concat(selectedItemToBring, ", ") .. "）到 " .. table.concat(selectedPosition, ", ") .. "！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            lib:Dialog({
                Title = "错误",
                Content = "请先至少选择一种物品和一个位置！\nCurrent items: " .. table.concat(selectedItemToBring, ", ") .. "\n当前位置：" .. table.concat(selectedPosition, ", "),
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end,
})

-- Scrap Items Section
local scrapDropdown = sections.ScrapItems:AddDropdown("ScrapSelect", {
    Title = "选择可回收物品",
    Description = "从工作区中选择可回收的物品",
    Options = getScrappableItems(),
    Default = {},
    PlaceHolder = "选择可回收物品",
    Multiple = true,
    Callback = function(selected)
        selectedScrapItem = selected or {}
    end
})

local scrapPositionDropdown = sections.ScrapItems:AddDropdown("ScrapPositionSelect", {
    Title = "选择目标位置",
    Description = "选择要把可回收物品拉到哪里",
    Options = {"回收机"},
    Default = {"回收机"},
    PlaceHolder = "选择位置",
    Multiple = true,
    Callback = function(selected)
        selectedScrapPosition = selected or {"回收机"}
    end
})

sections.ScrapItems:AddToggle("AutoDragScrapItems", {
    Title = "自动拖动 可回收物品",
    Default = false,
    Description = "自动把所选回收物品拖到所选位置",
    Callback = function(value)
        autoDragScrapActive = value
        if value then
            if #selectedScrapItem == 0 or #selectedScrapPosition == 0 then
                autoDragScrapActive = false
                sections.ScrapItems:GetToggle("AutoDragScrapItems"):Set(false)
                lib:Dialog({
                    Title = "错误",
                    Content = "请先至少选择一个废品和位置！",
                    Buttons = {
                        {
                            Title = "确定",
                            Variant = "Primary",
                            Callback = function() end,
                        }
                    }
                })
                return
            end
            autoDragScrapLoop()
        end
    end,
})

local scrapItems = getScrappableItems()
selectedScrapItem = {}
if #scrapItems > 0 then
    scrapDropdown:Refresh(scrapItems, true)
    else
    scrapDropdown:Refresh({}, true)
end
sections.ScrapItems:AddButton({
    Title = "带来选定的可回收物品",
    Description = "带来所选可报废物品的所有实例",
    Callback = function()
        if #selectedScrapItem > 0 and #selectedScrapPosition > 0 then
            local count = bringItemsByName(selectedScrapItem, selectedScrapPosition)
            lib:Dialog({
                Title = "成功",
                Content = "已拉取 " .. count .. " scrappable 个物品（" .. table.concat(selectedScrapItem, ", ") .. "）到 " .. table.concat(selectedScrapPosition, ", ") .. "！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            lib:Dialog({
                Title = "错误",
                Content = "请先选择至少一个可报废的物品和位置！\n当前物品： " .. table.concat(selectedScrapItem, ", ") .. "\n当前位置：" .. table.concat(selectedScrapPosition, ", "),
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end,
})

-- Fuel Items Section
local fuelDropdown = sections.FuelItems:AddDropdown("FuelSelect", {
    Title = "挑选 燃料物品",
    Description = "从工作区选择燃料物品",
    Options = getFuelItems(),
    Default = {},
    PlaceHolder = "选择燃料物品",
    Multiple = true,
    Callback = function(selected)
        selectedFuelItem = selected or {}
    end
})

local fuelPositionDropdown = sections.FuelItems:AddDropdown("FuelPositionSelect", {
    Title = "选择目标位置",
    Description = "选择要把燃料物品拉到哪里",
    Options = {"营火", "回收机"},
    Default = {"营火"},
    PlaceHolder = "选择位置",
    Multiple = true,
    Callback = function(selected)
        selectedFuelPosition = selected or {"营火"}
    end
})

sections.FuelItems:AddToggle("AutoDragFuelItems", {
    Title = "自动拖拽燃料物品",
    Default = false,
    Description = "自动把所选燃料物品拖到所选位置",
    Callback = function(value)
        autoDragFuelActive = value
        if value then
            if #selectedFuelItem == 0 or #selectedFuelPosition == 0 then
                autoDragFuelActive = false
                sections.FuelItems:GetToggle("AutoDragFuelItems"):Set(false)
                lib:Dialog({
                    Title = "错误",
                    Content = "请先选择至少一个燃料物品和目标位置！",
                    Buttons = {
                        {
                            Title = "确定",
                            Variant = "Primary",
                            Callback = function() end,
                        }
                    }
                })
                return
            end
            autoDragFuelLoop()
        end
    end,
})
local fuelItems = getFuelItems()
selectedFuelItem = {}
if #fuelItems > 0 then
 fuelDropdown:Refresh(fuelItems, true)
else
 fuelDropdown:Refresh({}, true)
end


sections.FuelItems:AddButton({
    Title = "拉取所选燃料物品",
    Description = "拉取所有选中的燃料物品实例",
    Callback = function()
        if #selectedFuelItem > 0 and #selectedFuelPosition > 0 then
            local count = bringItemsByName(selectedFuelItem, selectedFuelPosition)
            lib:Dialog({
                Title = "成功",
                Content = "已拉取 " .. count .. " 个燃料物品（" .. table.concat(selectedFuelItem, ", ") .. "）到 " .. table.concat(selectedFuelPosition, ", ") .. "！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            lib:Dialog({
                Title = "错误",
                Content = "请先选择至少一个燃料物品和目标位置！\n当前物品: " .. table.concat(selectedFuelItem, ", ") .. "\n当前位置: " .. table.concat(selectedFuelPosition, ", "),
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end,
})

-- 箱子查找器部分
local chestDropdown
local chestsData = {}

chestDropdown = sections.ChestFinder:AddDropdown("ChestSelect", {
    Title = "选择要传送的箱子",
    Description = "从工作区选择要传送的箱子",
    Options = {},
    Default = {},
    PlaceHolder = "选择箱子",
    Multiple = true,
    Callback = function(selected)
        selectedChestToTeleport = selected or {}
    end
})

sections.ChestFinder:AddButton({
    Title = "刷新箱子列表",
    Description = "用当前可用的箱子更新下拉框",
    Callback = function()
        local chests, chestData = getAllChestsFromWorkspace()
        chestsData = chestData
        selectedChestToTeleport = {}
        if #chests > 0 then
            chestDropdown:Refresh(chests, true)
            lib:Dialog({
                Title = "箱子列表已刷新",
                Content = "刷新成功。找到 " .. #chests .. " 个箱子。\n请从下拉框中选择箱子。",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            chestDropdown:Refresh({}, true)
            lib:Dialog({
                Title = "没有找到箱子",
                Content = "在工作区中没有找到箱子！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end
})

sections.ChestFinder:AddButton({
    Title = "传送到选中的箱子",
    Description = "传送到选中的箱子位置",
    Callback = function()
        if #selectedChestToTeleport > 0 and chestsData[selectedChestToTeleport[1]] then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, chestName in ipairs(selectedChestToTeleport) do
                    local chestData = chestsData[chestName]
                    if chestData and chestData.position then
                        local teleportPosition = chestData.position + Vector3.new(0, 2, 3)
                        character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
                        task.wait(0.5)
                    end
                end
                lib:Dialog({
                    Title = "成功",
                    Content = "已传送到选中的箱子！",
                    Buttons = {
                        {
                            Title = "确定",
                            Variant = "Primary",
                            Callback = function() end,
                        }
                    }
                })
            else
                lib:Dialog({
                    Title = "错误",
                    Content = "无法传送到箱子。找不到角色！",
                    Buttons = {
                        {
                            Title = "确定",
                            Variant = "Primary",
                            Callback = function() end,
                        }
                    }
                })
            end
        else
            lib:Dialog({
                Title = "错误",
                Content = "请先选择至少一个箱子！\n当前选择: " .. table.concat(selectedChestToTeleport, ", "),
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end,
})

sections.ChestFinder:AddButton({
    Title = "传送到最近的箱子",
    Description = "自动传送到最近的箱子",
    Callback = function()
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            lib:Dialog({
                Title = "错误",
                Content = "找不到角色！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
            return
        end

        local playerPosition = character.HumanoidRootPart.Position
        local nearestChest = nil
        local nearestDistance = math.huge

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find("chest") or obj.Name:lower():find("crate") or obj.Name:lower():find("box")) then
                local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                if rootPart then
                    local distance = (rootPart.Position - playerPosition).Magnitude
                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearestChest = {
                            model = obj,
                            position = rootPart.Position,
                            name = obj.Name
                        }
                    end
                end
            end
        end

        if nearestChest then
            local teleportPosition = nearestChest.position + Vector3.new(0, 2, 3)
            character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
            lib:Dialog({
                Title = "成功",
                Content = "已传送到最近的箱子: " .. nearestChest.name .. "\n距离: " .. math.floor(nearestDistance) .. " 单位",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        else
            lib:Dialog({
                Title = "错误",
                Content = "在工作区中没有找到箱子！",
                Buttons = {
                    {
                        Title = "确定",
                        Variant = "Primary",
                        Callback = function() end,
                    }
                }
            })
        end
    end,
})

-- 碰撞箱控制部分
local hitboxSettings = {Wolf=false, Bunny=false, Cultist=false, Show=false, Size=10}

local function updateHitboxForModel(model)
    local root = model:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local name = model.Name:lower()
    local shouldResize =
        (hitboxSettings.Wolf and (name:find("wolf") or name:find("alpha"))) or
        (hitboxSettings.Bunny and name:find("bunny")) or
        (hitboxSettings.Cultist and (name:find("cultist") or name:find("cross")))
    if shouldResize then
        root.Size = Vector3.new(hitboxSettings.Size, hitboxSettings.Size, hitboxSettings.Size)
        root.Transparency = hitboxSettings.Show and 0.5 or 1
        root.Color = Color3.fromRGB(255, 255, 255)
        root.Material = Enum.Material.Neon
        root.CanCollide = false
    end
end

task.spawn(function()
    while true do
        for _, model in ipairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
                updateHitboxForModel(model)
            end
        end
        task.wait(2)
    end
end)

sections.HitboxControls:AddToggle("Wolf碰撞箱", {
    Title = "扩大狼类碰撞箱",
    Default = false,
    Description = "扩大狼类敌人的碰撞箱",
    Callback = function(value)
        hitboxSettings.Wolf = value
    end,
})

sections.HitboxControls:AddToggle("Bunny碰撞箱", {
    Title = "扩大兔类碰撞箱",
    Default = false,
    Description = "扩大兔类敌人的碰撞箱",
    Callback = function(value)
        hitboxSettings.Bunny = value
    end,
})

sections.HitboxControls:AddToggle("Cultist碰撞箱", {
    Title = "扩大教徒碰撞箱",
    Default = false,
    Description = "扩大教徒敌人的碰撞箱",
    Callback = function(value)
        hitboxSettings.Cultist = value
    end,
})

sections.HitboxControls:AddSlider("碰撞箱大小", {
    Title = "碰撞箱大小",
    Description = "扩大后碰撞箱的大小",
    Default = 10,
    Min = 2,
    Max = 30,
    Increment = 1,
    Callback = function(value)
        hitboxSettings.Size = value
    end,
})

sections.HitboxControls:AddToggle("显示碰撞箱", {
    Title = "显示碰撞箱 (透明度)",
    Default = false,
    Description = "让碰撞箱可见",
    Callback = function(value)
        hitboxSettings.Show = value
    end,
})

-- 杂项功能部分
getgenv().speedEnabled = false
getgenv().speedValue = 28

sections.MiscFeatures:AddToggle("SpeedHack", {
    Title = "速度修改",
    Default = false,
    Description = "提高移动速度",
    Callback = function(value)
        getgenv().speedEnabled = value
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum = char:FindFirstChild("Humanoid")
        if hum then 
            hum.WalkSpeed = value and getgenv().speedValue or 16 
        end
    end,
})

sections.MiscFeatures:AddSlider("SpeedValue", {
    Title = "速度数值",
    Description = "速度数值",
    Default = 28,
    Min = 16,
    Max = 600,
    Increment = 1,
    Callback = function(value)
        getgenv().speedValue = value
        if getgenv().speedEnabled then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then 
                hum.WalkSpeed = value 
            end
        end
    end,
})

-- 性能部分
local showFPS, showPing = true, true
local fpsText, msText = Drawing.new("Text"), Drawing.new("Text")
fpsText.Size, fpsText.Position, fpsText.Color, fpsText.Center, fpsText.Outline, fpsText.Visible =
    16, Vector2.new(Camera.ViewportSize.X-100, 10), Color3.fromRGB(0,255,0), false, true, showFPS
msText.Size, msText.Position, msText.Color, msText.Center, msText.Outline, msText.Visible =
    16, Vector2.new(Camera.ViewportSize.X-100, 30), Color3.fromRGB(0,255,0), false, true, showPing
local fpsCounter, fpsLastUpdate = 0, tick()

RunService.RenderStepped:Connect(function()
    fpsCounter += 1
    if tick() - fpsLastUpdate >= 1 then
        if showFPS then
            fpsText.Text = "帧率: " .. tostring(fpsCounter)
            fpsText.Visible = true
        else
            fpsText.Visible = false
        end
        if showPing then
            local pingStat = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
            local ping = pingStat and math.floor(pingStat:GetValue()) or 0
            msText.Text = "延迟: " .. ping .. " 毫秒"
            if ping <= 60 then
                msText.Color = Color3.fromRGB(0, 255, 0)
            elseif ping <= 120 then
                msText.Color = Color3.fromRGB(255, 165, 0)
            else
                msText.Color = Color3.fromRGB(255, 0, 0)
            end
            msText.Visible = true
        else
            msText.Visible = false
        end
        fpsCounter = 0
        fpsLastUpdate = tick()
    end
end)

sections.Performance:AddToggle("ShowFPS", {
    Title = "显示帧率",
    Default = true,
    Description = "显示帧率计数",
    Callback = function(value)
        showFPS = value
        fpsText.Visible = value
    end,
})

sections.Performance:AddToggle("ShowPing", {
    Title = "显示延迟（毫秒）",
    Default = true,
    Description = "显示延迟计数",
    Callback = function(value)
        showPing = value
        msText.Visible = value
    end,
})

sections.Performance:AddButton({
    Title = "帧率提升",
    Description = "应用性能优化",
    Callback = function()
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            local lighting = game:GetService("Lighting")
            lighting.Brightness = 0
            lighting.FogEnd = 100
            lighting.GlobalShadows = false
            lighting.EnvironmentDiffuseScale = 0
            lighting.EnvironmentSpecularScale = 0
            lighting.ClockTime = 14
            lighting.OutdoorAmbient = Color3.new(0, 0, 0)
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 1
            end
            for _, obj in ipairs(lighting:GetDescendants()) do
                if obj:IsA("PostEffect") or obj:IsA("BloomEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("SunRaysEffect") or obj:IsA("BlurEffect") then
                    obj.Enabled = false
                end
            end
            for _, obj in ipairs(game:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj.Enabled = false
                elseif obj:IsA("Texture") or obj:IsA("Decal") then
                    obj.Transparency = 1
                end
            end
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CastShadow = false
                end
            end
        end)
        lib:Dialog({
            Title = "成功",
            Content = "帧率提升已成功应用！",
            Buttons = {
                {
                    Title = "确定",
                    Variant = "Primary",
                    Callback = function() end,
                }
            }
        })
    end,
})

-- 配置系统
FlagsManager:SetLibrary(lib)
FlagsManager:SetIgnoreIndexes({})
FlagsManager:SetFolder("Avantrix/99NF")
FlagsManager:InitSaveSystem(tabs.Settings)
