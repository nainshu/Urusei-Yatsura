--// King Crimson 完整脚本
--// 时间删除 + 墓志铭(预测) + 时间跳跃 + 移动端支持 + 音效

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local timeErased = false
local activeSeat, activeWeld
local buttonGui
local mobileButtons = {}

--// 冻结其他玩家 (客户端)
local function freezeOthers(freeze)
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			for _, part in ipairs(p.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Anchored = freeze
				end
			end
		end
	end
end

--// 延迟开关座椅技巧
local function activateLagSwitch(character)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
	if not hrp or not torso then return end

	local seat = Instance.new("Seat")
	seat.Name = "隐形座椅"
	seat.Transparency = 1
	seat.Anchored = false
	seat.CanCollide = false
	seat.CFrame = hrp.CFrame
	seat.Parent = workspace
	activeSeat = seat

	local weld = Instance.new("Weld")
	weld.Part0 = seat
	weld.Part1 = torso
	weld.Parent = seat
	activeWeld = weld
end

local function deactivateLagSwitch()
	if activeWeld then activeWeld:Destroy() activeWeld=nil end
	if activeSeat then activeSeat:Destroy() activeSeat=nil end
end

--// 结束时间删除
local function endTimeErase()
	if not timeErased then return end
	timeErased = false
	deactivateLagSwitch()
	freezeOthers(false)

	for _, e in pairs(Lighting:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("ColorCorrectionEffect") then
			e:Destroy()
		end
	end
	
	-- 更新移动端按钮文本
	if mobileButtons["Erase"] then
		mobileButtons["Erase"].Text = "时间删除"
	end
end

--// 开始时间删除
local function startTimeErase(character)
	if timeErased then return end
	timeErased = true

	-- 更新移动端按钮文本
	if mobileButtons["Erase"] then
		mobileButtons["Erase"].Text = "结束删除"
	end

	activateLagSwitch(character)
	freezeOthers(true)

	local blur = Instance.new("BlurEffect")
	blur.Size = 1
	blur.Parent = Lighting

	local cc = Instance.new("ColorCorrectionEffect")
	cc.TintColor = Color3.fromRGB(255,70,70)
	cc.Saturation = -0.5
	cc.Parent = Lighting

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://7308966748"
		sound.Volume = 2
		sound.Parent = hrp
		sound:Play()
	end

	task.delay(10, function()
		if timeErased then endTimeErase() end
	end)
end

--// 墓志铭 (预测)
local function useEpitaph()
	local duration = 9
	local predictionDistance = 100 -- 预测距离(单位: studs)

	-- 屏幕覆盖效果
	local cc = Instance.new("ColorCorrectionEffect")
	cc.TintColor = Color3.fromRGB(255,120,120)
	cc.Contrast = 0.2
	cc.Saturation = -0.3
	cc.Parent = Lighting

	local blur = Instance.new("BlurEffect")
	blur.Size = 10
	blur.Parent = Lighting

	-- 音效
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://1837635061"
	sound.Volume = 1.5
	sound.Parent = workspace
	sound:Play()

	-- 预测克隆体
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = p.Character.HumanoidRootPart
			local clone = hrp:Clone()
			clone.Anchored = true
			clone.CanCollide = false
			clone.Transparency = 0.5
			clone.BrickColor = BrickColor.new("Really red")
			clone.Material = Enum.Material.Neon
			clone.Parent = workspace

			-- 沿面向方向预测
			local lookVector = hrp.CFrame.LookVector
			local targetPos = hrp.Position + (lookVector * predictionDistance)

			local tween = TweenService:Create(clone, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
			tween:Play()
			Debris:AddItem(clone, duration)
		end
	end

	task.delay(duration, function()
		cc:Destroy()
		blur:Destroy()
	end)
end

--// 时间跳跃 (短距离冲刺)
local function useTimeSkip(character)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local goalCFrame = hrp.CFrame * CFrame.new(0,0,-15)
	local tween = TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {CFrame = goalCFrame})
	tween:Play()

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://5824064627"
	sound.Volume = 2
	sound.Parent = hrp
	sound:Play()
end

--// 为角色设置控制
local function setupControls(character)
	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.E then
			if not timeErased then startTimeErase(character) else endTimeErase() end
		elseif input.KeyCode == Enum.KeyCode.R then
			useEpitaph()
		elseif input.KeyCode == Enum.KeyCode.Q then
			useTimeSkip(character)
		end
	end)

	-- 移动端按钮 (垂直堆叠)
	if UserInputService.TouchEnabled and not buttonGui then
		buttonGui = Instance.new("ScreenGui")
		buttonGui.Name = "KC按钮界面"
		buttonGui.ResetOnSpawn = false
		buttonGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		buttonGui.Parent = player:WaitForChild("PlayerGui")

		local function makeBtn(text, pos, callback)
			local b = Instance.new("TextButton")
			b.Size = UDim2.new(0, 100, 0, 50)
			b.Position = pos
			b.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			b.TextColor3 = Color3.new(1, 1, 1)
			b.Font = Enum.Font.GothamBold
			b.TextSize = 16
			b.Text = text
			b.AutoButtonColor = true
			b.BorderSizePixel = 0
			b.ZIndex = 10
			
			-- 添加圆角
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 8)
			corner.Parent = b
			
			-- 添加阴影效果
			b.MouseEnter:Connect(function()
				TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}):Play()
			end)
			
			b.MouseLeave:Connect(function()
				TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(170, 0, 0)}):Play()
			end)
			
			b.Parent = buttonGui
			b.MouseButton1Click:Connect(callback)
			
			mobileButtons[text] = b
			return b
		end

		local startY = 0.7
		local gap = 0.08

		makeBtn("时间删除", UDim2.new(0.85, -50, startY, 0), function()
			if not timeErased then 
				startTimeErase(player.Character or character) 
			else 
				endTimeErase() 
			end
		end)
		
		makeBtn("墓志铭", UDim2.new(0.85, -50, startY + gap, 0), function()
			useEpitaph()
		end)
		
		makeBtn("时间跳跃", UDim2.new(0.85, -50, startY + gap * 2, 0), function()
			useTimeSkip(player.Character or character)
		end)
		
		-- 添加标题
		local title = Instance.new("TextLabel")
		title.Size = UDim2.new(0, 120, 0, 30)
		title.Position = UDim2.new(0.85, -60, startY - 0.06, 0)
		title.BackgroundTransparency = 1
		title.Text = "King Crimson"
		title.TextColor3 = Color3.new(1, 1, 1)
		title.Font = Enum.Font.GothamBold
		title.TextSize = 18
		title.Parent = buttonGui
	end
end

player.CharacterAdded:Connect(setupControls)
if player.Character then setupControls(player.Character) end

print("⚡ King Crimson 完整脚本已加载: 时间删除 (E), 墓志铭 (R), 时间跳跃 (Q)")
