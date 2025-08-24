local player = game.Players.LocalPlayer

-- 创建GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TOH菜单"

local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleBtn.Text = "≡"
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextSize = 20
toggleBtn.Draggable = true
toggleBtn.Active = true

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 200, 0, 160)
mainFrame.Position = UDim2.new(0, 80, 0.5, -80)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

local layout = Instance.new("UIListLayout", mainFrame)
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

-- 自动胜利按钮
local autoWinBtn = Instance.new("TextButton", mainFrame)
autoWinBtn.Size = UDim2.new(1, -10, 0, 40)
autoWinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoWinBtn.TextColor3 = Color3.new(1,1,1)
autoWinBtn.Text = "🏁 自动胜利"

autoWinBtn.MouseButton1Click:Connect(function()
    spawn(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local finish = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("finish") or obj.Name:lower():find("win")) then
                finish = obj
                break
            end
        end

        if finish then
            hrp.CFrame = finish.CFrame + Vector3.new(0, 3, 0)
        else
            warn("未找到终点。")
        end
    end)
end)

-- 上帝模式按钮
local godBtn = Instance.new("TextButton", mainFrame)
godBtn.Size = UDim2.new(1, -10, 0, 40)
godBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
godBtn.TextColor3 = Color3.new(1,1,1)
godBtn.Text = "🛡️ 上帝模式"

local godModeEnabled = false
local healthConnection = nil

local function activateGodMode()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    humanoid.Health = humanoid.MaxHealth

    healthConnection = humanoid.HealthChanged:Connect(function()
        if godModeEnabled and humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)

    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name:lower():find("kill") then
            part.CanTouch = false
            local touch = part:FindFirstChildWhichIsA("TouchTransmitter", true)
            if touch then touch:Destroy() end
        end
    end
end

local function deactivateGodMode()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and healthConnection then
        healthConnection:Disconnect()
        healthConnection = nil
    end

    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name:lower():find("kill") then
            part.CanTouch = true
        end
    end
end

godBtn.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    if godModeEnabled then
        activateGodMode()
        godBtn.Text = "🛡️ 上帝模式 [开]"
    else
        deactivateGodMode()
        godBtn.Text = "🛡️ 上帝模式 [关]"
    end
end)

-- 切换菜单按钮
toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)