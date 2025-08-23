local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

if CoreGui:FindFirstChild("StellarHubUI") then
    CoreGui:FindFirstChild("StellarHubUI"):Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "StellarHubUI"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0,400,0,250)
frame.BackgroundColor3 = Color3.fromRGB(34,34,34)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "星辰中心"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(0, 200, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Text = "由 Stellar 制作"
madeByLabel.Font = Enum.Font.SourceSans
madeByLabel.TextSize = 12
madeByLabel.TextColor3 = Color3.fromRGB(150,150,150)
madeByLabel.BackgroundTransparency = 1
madeByLabel.Size = UDim2.new(0, 200, 0, 20)
madeByLabel.Position = UDim2.new(0, 10, 1, -25)
madeByLabel.TextXAlignment = Enum.TextXAlignment.Left
madeByLabel.Parent = frame

local gearIcon = Instance.new("ImageButton")
gearIcon.Size = UDim2.new(0,24,0,24)
gearIcon.Position = UDim2.new(0, title.Position.X.Offset + title.Size.X.Offset + 5, 0, 3)
gearIcon.AnchorPoint = Vector2.new(0, 0)
gearIcon.Image = "rbxassetid://6726110621"
gearIcon.BackgroundTransparency = 1
gearIcon.Parent = frame

local gravityButton = Instance.new("TextButton")
gravityButton.Text = "月球重力"
gravityButton.Font = Enum.Font.SourceSans
gravityButton.TextSize = 16
gravityButton.TextColor3 = Color3.fromRGB(255,255,255)
gravityButton.BackgroundColor3 = Color3.fromRGB(51,51,51)
gravityButton.BorderSizePixel = 0
gravityButton.Size = UDim2.new(0,130,0,30)
gravityButton.Position = UDim2.new(0,10,0,35)
gravityButton.Parent = frame

local stateLabel = Instance.new("TextLabel")
stateLabel.Text = "关闭"
stateLabel.Font = Enum.Font.SourceSans
stateLabel.TextSize = 14
stateLabel.TextColor3 = Color3.fromRGB(200,200,200)
stateLabel.BackgroundTransparency = 1
stateLabel.Size = UDim2.new(0,40,0,30)
stateLabel.Position = UDim2.new(0,150,0,35)
stateLabel.TextXAlignment = Enum.TextXAlignment.Left
stateLabel.Parent = frame

local teleportButton = Instance.new("TextButton")
teleportButton.Text = "向上传送"
teleportButton.Font = Enum.Font.SourceSans
teleportButton.TextSize = 16
teleportButton.TextColor3 = Color3.fromRGB(255,255,255)
teleportButton.BackgroundColor3 = Color3.fromRGB(51,51,51)
teleportButton.BorderSizePixel = 0
teleportButton.Size = UDim2.new(0,130,0,30)
teleportButton.Position = UDim2.new(0,10,0,75)
teleportButton.Parent = frame

local speedButton = Instance.new("TextButton")
speedButton.Text = "速度提升"
speedButton.Font = Enum.Font.SourceSans
speedButton.TextSize = 16
speedButton.TextColor3 = Color3.fromRGB(255,255,255)
speedButton.BackgroundColor3 = Color3.fromRGB(51,51,51)
speedButton.BorderSizePixel = 0
speedButton.Size = UDim2.new(0,130,0,30)
speedButton.Position = UDim2.new(0,10,0,115)
speedButton.Parent = frame

local dragging = false
local dragInput, dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        gearIcon.Position = UDim2.new(0, frame.Position.X.Offset + title.Size.X.Offset + 5, 0, frame.Position.Y.Offset + 3)
        madeByLabel.Position = UDim2.new(0, 10, 1, -25)
    end
end)

local moonGravityEnabled = false
local gravityConnection

local function resetGravity()
    local character = Players.LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        local root = character:FindFirstChild("HumanoidRootPart")
        if humanoid and root then
            humanoid.JumpPower = 50
            root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
        end
    end
end

gravityButton.MouseButton1Click:Connect(function()
    moonGravityEnabled = not moonGravityEnabled
    if moonGravityEnabled then
        gravityButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
        stateLabel.Text = "开启"
        local character = Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            local root = character:FindFirstChild("HumanoidRootPart")
            if humanoid and root then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = 96
                if gravityConnection then gravityConnection:Disconnect() end
                gravityConnection = RunService.Stepped:Connect(function()
                    if not moonGravityEnabled then
                        gravityConnection:Disconnect()
                        resetGravity()
                        return
                    end
                    if root.Velocity.Y < 0 then
                        root.Velocity = Vector3.new(root.Velocity.X, root.Velocity.Y * 0.9, root.Velocity.Z)
                    end
                end)
            end
        end
    else
        gravityButton.BackgroundColor3 = Color3.fromRGB(51,51,51)
        stateLabel.Text = "关闭"
        if gravityConnection then
            gravityConnection:Disconnect()
            gravityConnection = nil
        end
        resetGravity()
    end
end)

local teleportUp = true

teleportButton.MouseButton1Click:Connect(function()
    local character = Players.LocalPlayer.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            if teleportUp then
                root.CFrame = root.CFrame + Vector3.new(0,150,0)
                teleportButton.Text = "向下传送"
            else
                root.CFrame = root.CFrame - Vector3.new(0,189,0)
                teleportButton.Text = "向上传送"
            end
            teleportUp = not teleportUp
        end
    end
end)

local speedEnabled = false
local speedConnection

speedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        speedButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
        local SpeedValue = 50
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        if speedConnection then speedConnection:Disconnect() end
        speedConnection = RunService.RenderStepped:Connect(function()
            if not speedEnabled then
                speedConnection:Disconnect()
                speedConnection = nil
                return
            end
            local moveVector = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveVector += camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveVector -= camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveVector -= camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveVector += camera.CFrame.RightVector
            end
            if moveVector.Magnitude > 0 then
                moveVector = moveVector.Unit * SpeedValue
            end
            root.AssemblyLinearVelocity = Vector3.new(moveVector.X, root.AssemblyLinearVelocity.Y, moveVector.Z)
        end)
    else
        speedButton.BackgroundColor3 = Color3.fromRGB(51,51,51)
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
    end
end)

local uiVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        if uiVisible then
            if moonGravityEnabled then
                moonGravityEnabled = false
                gravityButton.BackgroundColor3 = Color3.fromRGB(51,51,51)
                stateLabel.Text = "关闭"
                if gravityConnection then
                    gravityConnection:Disconnect()
                    gravityConnection = nil
                end
                resetGravity()
            end
            if speedEnabled then
                speedEnabled = false
                speedButton.BackgroundColor3 = Color3.fromRGB(51,51,51)
                if speedConnection then
                    speedConnection:Disconnect()
                    speedConnection = nil
                end
            end
            frame.Visible = false
            uiVisible = false
        else
            frame.Visible = true
            uiVisible = true
        end
    end
end)
