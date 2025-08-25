```lua
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "哔哩JaPaQ",
    LoadingTitle = "Outdoor脚本",
    LoadingSubtitle = "OutDoors脚本",
    ConfigurationSaving = {
        Enabled = false,
    },
})

local Tab1 = Window:CreateTab("视觉类")
local Tab2 = Window:CreateTab("功能类")
local Tab3 = Window:CreateTab("人物类")
local Tab6 = Window:CreateTab("未来想更新(will update)")

local ToggleExample = Tab1:CreateToggle({
    Name = "护林员esp",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local function findGroundskeeper()
            local groundskeeperObjects = Workspace:GetDescendants()
            local result = {}
            for _, obj in pairs(groundskeeperObjects) do
                if obj.Name == "Groundskeeper" then
                    table.insert(result, obj)
                end
            end
            return result
        end
        local function createHighlight(target)
            local highlight = Instance.new("Highlight")
            highlight.Adornee = target
            highlight.Parent = target
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop  
            highlight.FillColor = Color3.fromRGB(255, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
            return highlight
        end
        while wait(1) do 
            local groundskeepers = findGroundskeeper()
            for _, groundskeeper in pairs(groundskeepers) do
                if not groundskeeper:FindFirstChild("Highlight") then
                    createHighlight(groundskeeper)
                end
            end
        end
    end
})

local ToggleExample = Tab1:CreateToggle({
    Name = "变异萝卜怪esp",
    CurrentValue = false,
    Flag = "Toggle2",
    Callback = function(Value)
        local mandrakes = workspace:WaitForChild("CurrentRooms"):GetDescendants()
        local function esp(obj)
            local h = Instance.new("Highlight", obj)
            h.FillColor = Color3.fromRGB(255,0,0)
            h.OutlineColor = Color3.fromRGB(255,0,0)
            local b = Instance.new("BillboardGui", obj)
            b.StudsOffset = Vector3.new(0,2,0)
            local t = Instance.new("TextLabel", b)
            t.Size = UDim2.new(0,200,0,50)
            t.TextColor3 = Color3.fromRGB(255,255,255)
            t.TextStrokeTransparency = 0
            t.Text = obj.Name.." [ESP]"
            game:GetService("RunService").RenderStepped:Connect(function()
                if obj.Parent then
                    local dist = (workspace.CurrentCamera.CFrame.Position - obj.Position).magnitude
                    t.Text = obj.Name.." ["..math.floor(dist).." studs]"
                else
                    h:Destroy()
                    b:Destroy()
                end
            end)
        end
        for _,v in pairs(mandrakes) do
            if v:IsA("Model") and v.Name == "Mandrakes" then
                esp(v)
            end
        end
        workspace.CurrentRooms.DescendantAdded:Connect(function(child)
            if child:IsA("Model") and child.Name == "Mandrakes" then
                esp(child)
            end
        end)
    end
})

local ToggleExample = Tab1:CreateToggle({
    Name = "门esp",
    CurrentValue = false,
    Flag = "Toggle3",
    Callback = function(Value)
        local ROOT = workspace:FindFirstChild("CurrentRooms")
        local MIN_FOLDER_NUM = 0
        local MAX_FOLDER_NUM = 100
        local TARGET_NAME = "Door"
        local function findTargetDoors()
            local doors = {}
            if not ROOT then return doors end
            for folderNum = MIN_FOLDER_NUM, MAX_FOLDER_NUM do
                local numFolder = ROOT:FindFirstChild(tostring(folderNum))
                if numFolder then
                    local door = numFolder:FindFirstChild(TARGET_NAME)
                    if door then
                        table.insert(doors, door)
                    end
                end
            end
            return doors
        end
        local function markDoor(door)
            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = door.PrimaryPart or door:FindFirstChildOfClass("BasePart")
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.Parent = door
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 80, 0, 30)
            label.Text = "Door"
            label.TextColor3 = Color3.fromRGB(128, 128, 128)
            label.Parent = billboard
            local highlight = Instance.new("Highlight")
            highlight.Adornee = door
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.FillColor = Color3.fromRGB(128, 128, 128)
            highlight.Parent = door
        end
        local targetDoors = findTargetDoors()
        for _, door in pairs(targetDoors) do
            markDoor(door)
        end
        if ROOT then
            ROOT.ChildAdded:Connect(function(child)
                local folderNum = tonumber(child.Name)
                if folderNum and folderNum >= MIN_FOLDER_NUM and folderNum <= MAX_FOLDER_NUM then
                    child.ChildAdded:Connect(function(subChild)
                        if subChild.Name == TARGET_NAME then
                            markDoor(subChild)
                        end
                    end)
                end
            end)
        end
    end
})

local ToggleExample = Tab1:CreateToggle({
    Name = "钥匙esp",
    CurrentValue = false,
    Flag = "Toggle4",
    Callback = function(Value)
        local function createESP(target)
            if target:FindFirstChild("IronKeyForCryptLabel") then return end
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "IronKeyForCryptLabel"
            billboard.Parent = target
            billboard.Adornee = target
            billboard.Size = UDim2.new(0, 60, 0, 20)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.AlwaysOnTop = true
            local textLabel = Instance.new("TextLabel")
            textLabel.Parent = billboard
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Text = "IronKeyForCrypt"
            textLabel.TextColor3 = Color3.fromRGB(150, 75, 0)
            textLabel.TextScaled = true
            textLabel.BackgroundTransparency = 1
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextSize = 14
        end
        local function setupRoomMonitoring(room)
            if not room then return end
            local function searchAndLabel(parent)
                for _, child in ipairs(parent:GetChildren()) do
                    if child.Name == "IronKeyForCrypt" then
                        createESP(child)
                    end
                    searchAndLabel(child)
                end
            end
            searchAndLabel(room)
            local function setupDeepMonitoring(parent)
                parent.ChildAdded:Connect(function(child)
                    if child.Name == "IronKeyForCrypt" then
                        createESP(child)
                    end
                    setupDeepMonitoring(child)
                end)
            end
            setupDeepMonitoring(room)
        end
        local function main()
            local workspace = game:GetService("Workspace")
            local currentRooms = workspace:FindFirstChild("CurrentRooms")
            if not currentRooms then
                return
            end
            for i = 0, 35 do
                local roomName = tostring(i)
                local room = currentRooms:FindFirstChild(roomName)
                if room then
                    setupRoomMonitoring(room)
                else
                    local connection
                    connection = currentRooms.ChildAdded:Connect(function(child)
                        if child.Name == roomName then
                            setupRoomMonitoring(child)
                            connection:Disconnect()
                        end
                    end)
                end
            end
            currentRooms.ChildAdded:Connect(function(child)
                if tonumber(child.Name) then
                    setupRoomMonitoring(child)
                end
            end)
        end
        main()
    end
})

local ToggleExample = Tab1:CreateToggle({
    Name = "莲花瓣esp",
    CurrentValue = false,
    Flag = "Toggle5",
    Callback = function(Value)
        local function createESP(target)
            if target:FindFirstChild("LotusPetalESP") then return end
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "LotusPetalESP"
            billboard.Parent = target
            billboard.Adornee = target
            billboard.Size = UDim2.new(0, 40, 0, 15)
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.AlwaysOnTop = true
            billboard.Enabled = true
            local textLabel = Instance.new("TextLabel")
            textLabel.Parent = billboard
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Text = "Lotus Petal"
            textLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
            textLabel.BackgroundTransparency = 1
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextSize = 12
        end
        local monitoredParents = {}
        local function setupDeepMonitoring(parent)
            if monitoredParents[parent] then return end
            monitoredParents[parent] = true
            parent.ChildAdded:Connect(function(child)
                if child.Name == "LotusPetalPickup" then
                    task.spawn(createESP, child)
                end
                if child:IsA("Model") or child:IsA("Folder") then
                    task.spawn(setupDeepMonitoring, child)
                end
            end)
        end
        local function searchAndLabel(parent)
            for _, child in ipairs(parent:GetChildren()) do
                if child.Name == "LotusPetalPickup" then
                    task.spawn(createESP, child)
                end
                if child:IsA("Model") or child:IsA("Folder") then
                    task.spawn(searchAndLabel, child)
                end
            end
        end
        local function setupRoomMonitoring(room)
            if not room then return end
            task.spawn(searchAndLabel, room)
            task.spawn(setupDeepMonitoring, room)
        end
        local function main()
            local currentRooms = workspace:FindFirstChild("CurrentRooms")
            if not currentRooms then
                currentRooms = workspace:WaitForChild("CurrentRooms")
            end
            task.spawn(setupDeepMonitoring, currentRooms)
            for i = 0, 35 do
                local roomName = tostring(i)
                local room = currentRooms:FindFirstChild(roomName)
                if room then
                    task.spawn(setupRoomMonitoring, room)
                else
                    local connection
                    connection = currentRooms.ChildAdded:Connect(function(child)
                        if child.Name == roomName then
                            task.spawn(setupRoomMonitoring, child)
                            connection:Disconnect()
                        end
                    end)
                end
                task.wait(0.1)
            end
            currentRooms.ChildAdded:Connect(function(child)
                if tonumber(child.Name) then
                    task.spawn(setupRoomMonitoring, child)
                end
            end)
        end
        task.wait(2)
        coroutine.wrap(main)()
    end
})

local ToggleExample = Tab1:CreateToggle({
    Name = "金币esp",
    CurrentValue = false,
    Flag = "Toggle6",
    Callback = function(Value)
        local monitoredParents = {}
        local function createESP(target)
            if target:FindFirstChild("GoldPileESP") then return end
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "GoldPileESP"
            billboard.Parent = target
            billboard.Adornee = target
            billboard.Size = UDim2.new(0, 40, 0, 15)
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.AlwaysOnTop = true
            billboard.Enabled = true
            local textLabel = Instance.new("TextLabel")
            textLabel.Parent = billboard
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Text = "Gold Pile"
            textLabel.BackgroundTransparency = 1
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextSize = 12
            local time = 0
            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if not billboard.Parent then
                    connection:Disconnect()
                    return
                end
                time = time + 0.05
                local r = 0.8 + 0.2 * math.sin(time)
                local g = 0.6 + 0.2 * math.sin(time + 1)
                local b = 0.1 + 0.1 * math.sin(time + 2)
                textLabel.TextColor3 = Color3.new(r, g, b)
            end)
        end
        local function searchAndLabel(parent)
            for _, child in ipairs(parent:GetChildren()) do
                if child.Name == "GoldPile" then
                    createESP(child)
                end
                if #child:GetChildren() > 0 then
                    searchAndLabel(child)
                end
            end
        end
        local function setupDeepMonitoring(parent)
            if monitoredParents[parent] then return end
            monitoredParents[parent] = true
            parent.ChildAdded:Connect(function(child)
                if child.Name == "GoldPile" then
                    task.spawn(createESP, child)
                end
                if child:IsA("Model") or child:IsA("Folder") then
                    task.spawn(setupDeepMonitoring, child)
                end
            end)
        end
        local function setupRoomMonitoring(room)
            if not room then return end
            searchAndLabel(room)
            setupDeepMonitoring(room)
        end
        local function main()
            local currentRooms = workspace:FindFirstChild("CurrentRooms")
            if not currentRooms then
                currentRooms = workspace:WaitForChild("CurrentRooms")
            end
            setupDeepMonitoring(currentRooms)
            for i = 0, 35 do
                local roomName = tostring(i)
                local room = currentRooms:FindFirstChild(roomName)
                if room then
                    setupRoomMonitoring(room)
                else
                    local connection
                    connection = currentRooms.ChildAdded:Connect(function(child)
                        if child.Name == roomName then
                            setupRoomMonitoring(child)
                            connection:Disconnect()
                        end
                    end)
                end
                task.wait(0.05)
            end
            currentRooms.ChildAdded:Connect(function(child)
                if tonumber(child.Name) then
                    setupRoomMonitoring(child)
                end
            end)
        end
        task.wait(1)
        coroutine.wrap(main)()
    end
})

local ButtonExample = Tab2:CreateButton({
    Name = "AntiSnare(防地刺)就是删除",
    Callback = function()
        local deletedSnares = {}
        local function deleteSnare(snare)
            if deletedSnares[snare] or not snare:IsDescendantOf(workspace) then
                return
            end
            deletedSnares[snare] = true
            snare:Destroy()
        end
        local function scanAndDeleteExisting()
            local allObjects = workspace:GetDescendants()
            for _, obj in pairs(allObjects) do
                if obj.Name == "Snare" then
                    deleteSnare(obj)
                end
            end
        end
        local function listenForNewSnares()
            workspace.DescendantAdded:Connect(function(child)
                if child.Name == "Snare" then
                    deleteSnare(child)
                end
            end)
        end
        scanAndDeleteExisting()
        listenForNewSnares()
    end,
})

local ButtonExample = Tab2:CreateButton({
    Name = "AntiSurge(防黄色闪电)不是删除",
    Callback = function()
        local RepStorage = game:GetService("ReplicatedStorage")
        local SurgeCheck = require(RepStorage.ModulesShared.SurgeCheck)
        SurgeCheck.GetUncoveredPosition = function() return nil end
    end,
})

local ButtonExample = Tab3:CreateButton({
    Name = "iy(输入tpwalk 0.5,追逐战关了,输入untpwalk)",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-31802"))()
    end,
})

local ButtonExample = Tab6:CreateButton({
    Name = "esp monument(纪念碑)",
    Callback = function()
    end,
})

local ButtonExample = Tab6:CreateButton({
    Name = "esp断头台",
    Callback = function()
    end,
})

local ButtonExample = Tab6:CreateButton({
    Name = "esp Bramble(又聋又瞎的那个)",
    Callback = function()
    end,
})