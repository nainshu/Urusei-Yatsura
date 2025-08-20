local StarterGui = game:GetService("StarterGui")

-- Instances
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InnerFrame = Instance.new("Frame")
local SpeedTextBox = Instance.new("TextBox")
local DecreaseButton = Instance.new("TextButton")
local IncreaseButton = Instance.new("TextButton")
local FlyButton = Instance.new("TextButton")
local DestroyButton = Instance.new("TextButton")
local UIGradient = Instance.new("UIGradient")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

-- 添加更多立体效果
local DropShadow = Instance.new("ImageLabel")
local InnerShadow = Instance.new("ImageLabel")

-- ScreenGui properties
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 创建投影效果
DropShadow.Parent = MainFrame
DropShadow.Name = "DropShadow"
DropShadow.BackgroundTransparency = 1
DropShadow.Size = UDim2.new(1, 10, 1, 10)
DropShadow.Position = UDim2.new(0, -5, 0, -5)
DropShadow.Image = "rbxassetid://1316045217"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.8
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(10, 10, 118, 118)
DropShadow.ZIndex = 0

-- MainFrame properties
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 0, 45)  -- 紫色调
MainFrame.Position = UDim2.new(0.3, 0, 0.5, -100)
MainFrame.Size = UDim2.new(0, 200, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true

-- UIStroke properties for MainFrame
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(100, 0, 100)  -- 紫色边框
UIStroke.Thickness = 2

-- Title properties
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "载具飞行控制"  -- 汉化
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

-- InnerFrame properties
InnerFrame.Parent = MainFrame
InnerFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 30)  -- 深紫色
InnerFrame.Size = UDim2.new(1, 0, 0.6, 0)
InnerFrame.Position = UDim2.new(0, 0, 0.2, 0)

-- SpeedTextBox properties
SpeedTextBox.Parent = InnerFrame
SpeedTextBox.BackgroundColor3 = Color3.fromRGB(60, 0, 60)  -- 紫色
SpeedTextBox.Position = UDim2.new(0.5, -25, 0.1, 0)
SpeedTextBox.Size = UDim2.new(0, 50, 0, 30)
SpeedTextBox.Font = Enum.Font.Gotham
SpeedTextBox.Text = "1"
SpeedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedTextBox.TextScaled = true
SpeedTextBox.PlaceholderText = "速度"  -- 汉化

-- DecreaseButton properties
DecreaseButton.Parent = InnerFrame
DecreaseButton.BackgroundColor3 = Color3.fromRGB(60, 0, 60)  -- 紫色
DecreaseButton.Size = UDim2.new(0, 50, 0, 30)
DecreaseButton.Position = UDim2.new(0.1, 0, 0.1, 0)
DecreaseButton.Font = Enum.Font.Gotham
DecreaseButton.Text = "-"
DecreaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DecreaseButton.TextScaled = true

-- IncreaseButton properties
IncreaseButton.Parent = InnerFrame
IncreaseButton.BackgroundColor3 = Color3.fromRGB(60, 0, 60)  -- 紫色
IncreaseButton.Size = UDim2.new(0, 50, 0, 30)
IncreaseButton.Position = UDim2.new(0.8, -30, 0.1, 0)
IncreaseButton.Font = Enum.Font.Gotham
IncreaseButton.Text = "+"
IncreaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
IncreaseButton.TextScaled = true

-- FlyButton properties
FlyButton.Parent = InnerFrame
FlyButton.BackgroundColor3 = Color3.fromRGB(60, 0, 60)  -- 紫色
FlyButton.Size = UDim2.new(0.8, 0, 0.2, 0)
FlyButton.Position = UDim2.new(0.1, 0, 0.40, 0)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.Text = "飞行"  -- 汉化
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextScaled = true

-- DestroyButton properties
DestroyButton.Parent = InnerFrame
DestroyButton.BackgroundColor3 = Color3.fromRGB(60, 0, 60)  -- 紫色
DestroyButton.Size = UDim2.new(0.8, 0, 0.2, 0)
DestroyButton.Position = UDim2.new(0.1, 0, 0.65, 0)
DestroyButton.Font = Enum.Font.GothamBold
DestroyButton.Text = "关闭"  -- 汉化
DestroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyButton.TextScaled = true

-- UICorner properties (增加圆角效果)
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0.15, 0)
mainCorner.Parent = MainFrame

local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0.1, 0)
innerCorner.Parent = InnerFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0.2, 0)
buttonCorner.Parent = SpeedTextBox

local buttonCorner2 = Instance.new("UICorner")
buttonCorner2.CornerRadius = UDim.new(0.2, 0)
buttonCorner2.Parent = DecreaseButton

local buttonCorner3 = Instance.new("UICorner")
buttonCorner3.CornerRadius = UDim.new(0.2, 0)
buttonCorner3.Parent = IncreaseButton

local buttonCorner4 = Instance.new("UICorner")
buttonCorner4.CornerRadius = UDim.new(0.2, 0)
buttonCorner4.Parent = FlyButton

local buttonCorner5 = Instance.new("UICorner")
buttonCorner5.CornerRadius = UDim.new(0.2, 0)
buttonCorner5.Parent = DestroyButton

-- UIGradient properties (紫黑渐变)
UIGradient.Parent = MainFrame
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 0, 45)),  -- 深紫色
    ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 0, 90))   -- 亮紫色
}

-- 为内部元素添加渐变效果
local innerGradient = Instance.new("UIGradient")
innerGradient.Parent = InnerFrame
innerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 0, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 50))
}

-- 按钮悬停效果
local function addButtonHoverEffect(button)
    local originalColor = button.BackgroundColor3
    local originalSize = button.Size
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(
            math.min(originalColor.R * 255 + 20, 255),
            math.min(originalColor.G * 255 + 20, 255),
            math.min(originalColor.B * 255 + 20, 255)
        )
        button.Size = originalSize - UDim2.new(0, 2, 0, 2)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
        button.Size = originalSize
    end)
    
    button.MouseButton1Down:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(
            math.max(originalColor.R * 255 - 20, 0),
            math.max(originalColor.G * 255 - 20, 0),
            math.max(originalColor.B * 255 - 20, 0)
        )
    end)
    
    button.MouseButton1Up:Connect(function()
        button.BackgroundColor3 = originalColor
    end)
end

-- 应用按钮效果
addButtonHoverEffect(DecreaseButton)
addButtonHoverEffect(IncreaseButton)
addButtonHoverEffect(FlyButton)
addButtonHoverEffect(DestroyButton)

-- Button functionalities
DecreaseButton.MouseButton1Click:Connect(function()
    local speed = tonumber(SpeedTextBox.Text) or 1
    SpeedTextBox.Text = tostring(math.max(speed - 1, 1))
end)

IncreaseButton.MouseButton1Click:Connect(function()
    local speed = tonumber(SpeedTextBox.Text) or 1
    SpeedTextBox.Text = tostring(speed + 1)
end)

--Enable Fly Function
local velocityHandlerName
local gyroHandlerName
local camera
local v3none
local v3zero
local v3inf
local controlModule
local bv
local bg
local mfly1
local mfly2

local function EnableFly()
    velocityHandlerName = 32
    gyroHandlerName = 64
    camera = workspace.CurrentCamera
    v3none = Vector3.new()
    v3zero = Vector3.new(0, 0, 0)
    v3inf = Vector3.new(9e9, 9e9, 9e9)
    controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

    bv = Instance.new("BodyVelocity")
    bv.Name = velocityHandlerName
    bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    bv.MaxForce = v3zero
    bv.Velocity = v3zero

    bg = Instance.new("BodyGyro")
    bg.Name = gyroHandlerName
    bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    bg.MaxTorque = v3inf
    bg.P = 1000
    bg.D = 50

    mfly1 = game.Players.LocalPlayer.CharacterAdded:Connect(function()
        local bv = Instance.new("BodyVelocity")
        bv.Name = velocityHandlerName
        bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        bv.MaxForce = v3zero
        bv.Velocity = v3zero

        bg = Instance.new("BodyGyro")
        bg.Name = gyroHandlerName
        bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        bg.MaxTorque = v3inf
        bg.P = 1000
        bg.D = 50
    end)

    mfly2 = game:GetService('RunService').RenderStepped:Connect(function()
        camera = workspace.CurrentCamera
        local speed = tonumber(SpeedTextBox.Text) or 1 -- Default to 1 if input is invalid

        if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") 
            and game.Players.LocalPlayer.Character.HumanoidRootPart 
            and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(velocityHandlerName) 
            and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(gyroHandlerName) then

            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            local VelocityHandler = game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(velocityHandlerName)
            local GyroHandler = game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(gyroHandlerName)

            VelocityHandler.MaxForce = v3inf
            GyroHandler.MaxTorque = v3inf
            GyroHandler.CFrame = camera.CFrame

            local direction = controlModule:GetMoveVector()
            local calculatedVelocity = v3none

            -- Apply movement based on direction and speed
            calculatedVelocity = calculatedVelocity 
                                 + camera.CFrame.RightVector * direction.X * speed * 50
                                 - camera.CFrame.LookVector * direction.Z * speed * 50

            VelocityHandler.Velocity = calculatedVelocity
        end
    end)
end
--


--Disable Fly Function
local function DisableFly()
	if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(velocityHandlerName) and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(gyroHandlerName) then
		game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(velocityHandlerName):Destroy()
		game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild(gyroHandlerName):Destroy()
	end
	game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
    if mfly1 then
        mfly1:Disconnect()
    end
    if mfly2 then
        mfly2:Disconnect()
    end
end
--


FlyButton.MouseButton1Click:Connect(function()
    if FlyButton.Text == "飞行" then
        FlyButton.Text = "停止飞行"
        EnableFly()
    else
        FlyButton.Text = "飞行"
        DisableFly()
    end
end)

DestroyButton.MouseButton1Click:Connect(function()
    DisableFly() -- Disconnect fly functions
    ScreenGui:Destroy()
end)
