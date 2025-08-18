-- GUI 内容
AnimButtons = {78195344190486, "狗狗模式", 115417853064013, "直升机模式", 85588129788692, "网格舞", 79757971761739, "破碎舞", 83265734904502, "认输舞",
	129764254213842, "江南Style", 114400428765989, "180°翻转", 128334204821841, "马桶舞", 138433137191760, "天上天下唯我独尊", 110146282544198, "橙子正义", 
	10714340543, "牙线舞", 77984841414450, "三角符文舞蹈", 109873544976020, "圣经准确动作", 90333292347820, "蠕虫舞", 88130117312312, "假死", 111251252458517, "呃呃呃",
	84623954062978, "彼得不要", 124756446017361, "变身敞篷车", 93014787120483, "加里舞蹈", 92618727772186, "IShowSpeed舞", 99499783161907, "光环农场",
	80177289449617, "雪天使", 70432904702322, "皮肤行者", 123916423751437, "老鼠舞", 129537633250603, "花生酱果冻时间", 99158928535706, "默认舞蹈", 94915612757079, "坦克模式",
	130059214239749, "撒尿狗", 91047682123297, "玛卡雷纳", 130019914905925, "严肃全能侠", 133612047483255, "翻滚", 79075971527754, "你懂的...", 99637983789946, "恐怖月份!!",
	82135680487389, "飞机模式", 88971195093161, "怪物混搭", 118592095684994, "无人机模式", 95894948496521, "植物大战僵尸向日葵", 137969542385356, "鱼模式", 132399051509976, "拉屎", 122583653807009, "足球杂耍",
	107355541549056, "工程师舞蹈", 126960077574956, "小鸡舞", 78347793265211, "他掏出了鸡鸡!", 122770336163563, "加州女孩", 97148848007002, "俄罗斯舞", 114687548971893, "爬行者模式",
	106389948045296, "灭霸舞蹈", 108313130500811, "俯卧撑", 106022089542174, "云端漂浮", 114140630538674, "椅子模式2", 108865839239307, "AI猫舞", 84352128203419, "蔬菜舞", 82293338535013, "DJ Khaled",
	}


-- 通用变量
CursedMode = false
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
HeaderSize = 25
PlayingId = 0
Red = Color3.new(0.9, 0, 0)
Green = Color3.new(0.26, 0.85, 0)
Grey = Color3.new(0.6, 0.6, 0.6)
Blue = Color3.new(0.26, 0.53, 0.95)
Purple = Color3.new(0.5, 0, 0.8) -- 新增紫色

-- 设置UI
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "我的动画中心"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function CreateFrame(Name)
	local Frame = Instance.new("ScrollingFrame")
	Frame.Visible = false
	-- 缩小尺寸适应手机
	Frame.Size = UDim2.new(0,180,0,250)
	Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- 深黑色背景
	Frame.CanvasSize = UDim2.new(0,0,0,0)
	Frame.Name = Name
	Frame.Parent = ScreenGui
	Instance.new("UICorner", Frame)
	return Frame
end

AnimationsFrame = CreateFrame("AnimationsTabFrame")
AnimationsFrame.Visible = true
StolenAnimationsFrame = CreateFrame("StolenAnimationsTabFrame")

TabsFrame = Instance.new("Frame")
-- 调整标签栏大小
TabsFrame.Size = UDim2.new(0,20,0,250)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Position = UDim2.new(0, 180,0, 0)
TabsFrame.Parent = ScreenGui

RenameBox = Instance.new("TextBox",ScreenGui)
RenameBox.Size = UDim2.new(0.3,0,0.15,0)
RenameBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- 深黑色背景
RenameBox.TextColor3 = Purple -- 紫色文字
RenameBox.PlaceholderText = "输入新名称"
RenameBox.AnchorPoint = Vector2.new(0.5,0.5)
RenameBox.Position = UDim2.new(0.5,0,0.5,0)
RenameBox.Text = ""
RenameBox.TextScaled = true
RenameBox.RichText = true
RenameBox.Visible = false

DragBar = Instance.new("TextButton")
DragBar.Text = ""
DragBar.AutoButtonColor = false
DragBar.Position = UDim2.new(0,AnimationsFrame.AbsolutePosition.X-7.5,0, AnimationsFrame.AbsolutePosition.Y)
DragBar.Size = UDim2.new(0,195,0,25)
DragBar.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05) -- 更深的黑色
Instance.new("UICorner").Parent = DragBar
DragBar.Position -= UDim2.new(0,0,0,25)
DragBar.Parent = ScreenGui

CloseButton = Instance.new("TextButton")
CloseButton.Text = "关闭"
CloseButton.TextColor3 = Color3.new(1,1,1) -- 白色文字
CloseButton.Position = UDim2.new(0,AnimationsFrame.AbsolutePosition.X-7.5,0, AnimationsFrame.AbsolutePosition.Y)
CloseButton.Size = UDim2.new(0,25,0,25)
CloseButton.BackgroundColor3 = Red
Instance.new("UICorner",CloseButton)
CloseButton.Position -= UDim2.new(0,0,0,25)
CloseButton.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Position = UDim2.new(0,0,0,-125)
Title.Size = UDim2.new(0,180,0,40) -- 缩小标题尺寸
Title.Name = "Title"
Title.BorderSizePixel = 0
Title.BackgroundTransparency = 1
Title.TextScaled = true
Title.TextColor3 = Purple -- 紫色文字
Title.Text = "8greatgrandfather的超赞动画中心(R15专用)"
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.new(0.3,0,0.5) -- 紫色描边
stroke.Thickness = 2
stroke.Parent = Title
Title.Position = UDim2.new(0,AnimationsFrame.AbsolutePosition.X,0, AnimationsFrame.AbsolutePosition.Y - Title.Size.Y.Offset*1.5)
Title.Parent = ScreenGui

-- 创建动画实例
Anim = Instance.new("Animation", script)

-- 通用函数

function Layout(Frame)
	local Layout = Instance.new("UIListLayout", Frame)
	Layout.FillDirection = Enum.FillDirection.Horizontal
	Layout.Wraps = true
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
end

function NiceButtons(Button)
	Instance.new("UICorner").Parent = Button
	local Grad = Instance.new("UIGradient")
	Grad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.new(0.7,0,1)), -- 紫色渐变
		ColorSequenceKeypoint.new(1, Color3.new(0.4,0,0.7)),
	}
	Grad.Parent = Button
	Button.TextColor3 = Color3.new(1,1,1) -- 白色文字
end

function CreateInteractable(Size, Name, Text, Color, X, Button, Class, Tab)
	local Element = Instance.new(Class,Tab)
	if Button then
		Element.Name = Name.. "Button"
	else
		Element.Name = Name.. "Box"
	end
	if Button then
		Element.Text = Text
	else
		Element.Text = ""
		Element.PlaceholderText = Text
	end
	Element.Size = Size
	Element.TextScaled = true
	Element.RichText = true
	Element.BackgroundColor3 = Color
	NiceButtons(Element)
	return Element
end

function MassUnToggle(Button)
	for Num, Frame in ScreenGui:GetChildren() do
		if Frame:IsA("ScrollingFrame") then
			for Num, Butn in Frame:GetChildren() do
				if Butn:IsA("TextButton") and Butn ~= Button then
					Butn:SetAttribute("Toggled", false)
					Butn.BackgroundColor3 = Red
				end
			end
		end
	end
end

function CreateButton(Size,Color,Text, Name,ID, Frame, ConnectingBox, Toggled)
	local Button = CreateInteractable(Size, Name, Text, Color, 100, true, "TextButton", Frame)
	Button:SetAttribute("Toggled", Toggled)
	Button:SetAttribute("AnimId", ID)
	Frame.CanvasSize += UDim2.new(0,0,0,Size.Y.Offset)
	Button.MouseButton1Click:Connect(function()
		Button:SetAttribute("Toggled", not Button:GetAttribute("Toggled"))
		if Track and not CursedMode then
			Track:Stop()
		end
		if Button:GetAttribute("Toggled") then
			MassUnToggle(Button)
			PlayingId = ID
			Button.BackgroundColor3 = Green
			PlayAnimation(ID, ConnectingBox.Text)
		else
			Button.BackgroundColor3 = Red
			PlayingId = 0
		end
	end)
	Button.MouseButton2Click:Connect(function()
		RenameBox.Text = ""
		RenameBox.Visible = true
		RenameBox:CaptureFocus()
		local function Rename()
			Button.Text = RenameBox.Text
			RenameBox.Visible = false
			Rename:Disconnect()
		end
		Rename = RenameBox.FocusLost:Connect(Rename)
	end)
	if Button.Parent == StolenAnimationsFrame then
		Button.MouseEnter:Connect(function()
			HoveringButton = Button
			HoveringBox = ConnectingBox
		end)
		Button.MouseLeave:Connect(function()
			HoveringButton = nil
			HoveringBox = ConnectingBox
		end)
	end
end

function TextboxSpeedAdjust(Box,ID)
	Box.FocusLost:Connect(function()
		if not (PlayingId == ID or PlayingId == 0 or PlayingId == StealId) and not CursedMode then return end
		if tonumber(Box.Text) == nil then
			Track:AdjustSpeed(1)
		else
			Track:AdjustSpeed(tonumber(Box.Text))
		end
	end)
end

function CreateTextbox(Size,Color,X,Name,ID, Frame)
	local Box = CreateInteractable(Size, Name, "播放速度(默认1)", Color, 0, false, "TextBox", Frame)
	TextBoxRn = Box
	TextboxSpeedAdjust(Box,"rbxassetid://"..ID)
end

function CreateTab(Size, Name, Text, Frame)
	local Tab = CreateInteractable(Size, Name, Text, Grey, 0, true, "TextButton", TabsFrame)
	if Text == "动画" then
		Tab.BackgroundColor3 = Purple -- 紫色标签
	end
	Tab.MouseButton1Click:Connect(function()
		for Num, Tab in TabsFrame:GetChildren() do
			if Tab:IsA("TextButton") then
				Tab.BackgroundColor3 = Grey
			end
		end
		Tab.BackgroundColor3 = Purple -- 紫色标签
		for Num, Frame in ScreenGui:GetChildren() do
			if Frame:IsA("ScrollingFrame") then
				Frame.Visible = false
			end
		end
		Frame.Visible = true
	end)
end

function PlayAnimation(ID,Speed)
	local Character = game.Players.LocalPlayer.Character

	Anim.AnimationId = ID

	Track = Character:WaitForChild("Humanoid"):LoadAnimation(Anim)
	Track:Play()
	Track.Looped = true
	
	if tonumber(Speed) == nil then
		Track:AdjustSpeed(1)
	else
		Track:AdjustSpeed(Speed)
	end
	Track.Priority = Enum.AnimationPriority.Action
end

function CreateSearchbar(Frame)
	-- 搜索栏
	local Searchbar = CreateInteractable(UDim2.new(0.95,0,0,35), "Searchbar", "搜索动画", Grey, 0, false, "TextBox", Frame) -- 缩小搜索栏高度
	Frame.CanvasSize += UDim2.new(0,0,0,Searchbar.Size.Y.Offset)

	-- 搜索功能
	Searchbar.Changed:Connect(function()
		local Search = string.lower(Searchbar.Text)
		for _, Button in Frame:GetChildren() do
			if (Button:IsA("TextButton") or Button:IsA("TextBox")) and Button.Name ~= "SearchbarBox" then
				if string.find(string.lower(Button.Name), Search) then
					Button.Visible = true
				else
					Button.Visible = false
				end
			end
		end
	end)
end

function CFOAMeat(ID)
	if Track then
		Track:Stop()
	end
	PlayAnimation(ID,1)
	MassUnToggle(nil)
	StealStage = 0
	PlayingId = "Steal"
	StealId = ID
	StealButton.BackgroundColor3 = Red
end

function CheckForOwnedAnimations(ID, PlayIt)
	for Num, Frame in ScreenGui:GetChildren() do
		if Frame:IsA("ScrollingFrame") then
			for Num, Button in StolenAnimationsFrame:GetChildren() do
				if Button:GetAttribute("AnimId") == ID then
					if PlayIt then
						CFOAMeat(ID)
						Button:SetAttribute("Toggled", true)
						Button.BackgroundColor3 = Green
						return true
					else
						return true
					end
				end
			end
		end
	end
	if PlayIt then
		CFOAMeat(ID)
	end
	return false
end

-- 布局设置
Layout(AnimationsFrame)
Layout(StolenAnimationsFrame)
Layout(TabsFrame)

-- 创建标签
NumOfTabs = 2
CreateTab(UDim2.new(0,30,0,250/NumOfTabs), "AnimationsTab", "动画", AnimationsFrame)
CreateTab(UDim2.new(0,30,0,250/NumOfTabs), "StolenAnimationsTab", "偷来的动画", StolenAnimationsFrame)

-- 添加搜索栏
CreateSearchbar(AnimationsFrame)
CreateSearchbar(StolenAnimationsFrame)

-- 拖动条功能
DragBar.MouseButton1Down:Connect(function()
	local Offset = game.Players.LocalPlayer:GetMouse().X - AnimationsFrame.AbsolutePosition.X
	while game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
		task.wait(0.01)
		AnimationsFrame.Position = UDim2.new(0,game.Players.LocalPlayer:GetMouse().X - Offset,0,game.Players.LocalPlayer:GetMouse().Y)
		StolenAnimationsFrame.Position = AnimationsFrame.Position
		Title.Position = UDim2.new(0,AnimationsFrame.AbsolutePosition.X,0, AnimationsFrame.AbsolutePosition.Y - Title.Size.Y.Offset*1.5)
		TabsFrame.Position = AnimationsFrame.Position + UDim2.new(0, 180,0, 0)
		DragBar.Position = UDim2.new(0,AnimationsFrame.AbsolutePosition.X-7.5,0, AnimationsFrame.AbsolutePosition.Y-HeaderSize)
		CloseButton.Position = UDim2.new(0,AnimationsFrame.AbsolutePosition.X-7.5,0, AnimationsFrame.AbsolutePosition.Y-HeaderSize)
	end
end)

--关闭按钮功能
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	script:Destroy()
end)

-- 偷取按钮
StealId = 0
StealButton = CreateInteractable(UDim2.new(0.95,0,0,35), "StealButton", "偷取动画", Purple, 100, true, "TextButton", StolenAnimationsFrame) -- 紫色按钮
StolenAnimationsFrame.CanvasSize += UDim2.new(0,0,0,StealButton.Size.Y.Offset)

-- 偷取按钮功能
StealStage = 0
StealButton.MouseButton1Click:Connect(function()
	if StealStage == 0 then
		StealStage = 1
		StealButton.BackgroundColor3 = Blue
		local Highlight = Instance.new("Highlight",workspace.Terrain)
		Highlight.FillColor = Blue
		while StealStage == 1 do
			task.wait(0.01)
			if Mouse.Target and Mouse.Target:FindFirstAncestorWhichIsA("Model"):FindFirstChildOfClass("Humanoid") then
				Highlight.Adornee = Mouse.Target:FindFirstAncestorWhichIsA("Model")
			else
				Highlight.Adornee = nil
			end
		end
		Highlight:Destroy()
	elseif StealStage == 1 then
		StealStage = 0
		StealButton.BackgroundColor3 = Purple -- 恢复为紫色
	end
end)

-- 紧急停止按钮
EStopButton = CreateInteractable(UDim2.new(0.95,0,0,35), "EStopButton", "紧急停止", Grey, 100, true, "TextButton", AnimationsFrame)
AnimationsFrame.CanvasSize += UDim2.new(0,0,0,StealButton.Size.Y.Offset)

-- 紧急停止按钮功能
EStopButton.MouseButton1Click:Connect(function()
	for Num, LocalTrack in Player.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks() do
		LocalTrack:Stop()
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input)
	if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and StealStage == 1 then
		local Target = Mouse.Target
		if Target and Mouse.Target:FindFirstAncestorWhichIsA("Model"):FindFirstChildOfClass("Humanoid") then
			local Humanoid = Mouse.Target:FindFirstAncestorWhichIsA("Model"):FindFirstChildOfClass("Humanoid")
			for Num, TheirTrack in Humanoid:GetPlayingAnimationTracks() do
				local ID = TheirTrack.Animation.AnimationId
				if TheirTrack.Length ~= 0 and not CheckForOwnedAnimations(ID, true) then
					StealStage = 0
					PlayingId = "Steal"
					StealId = ID
					StealButton.BackgroundColor3 = Purple -- 恢复为紫色
					local animId = ID:match("%d+")
					local Name = "动画"
					if animId then
						local info = game:GetService("MarketplaceService"):GetProductInfo(tonumber(animId))
						Name = info.Name
					else
						warn("未找到有效的动画ID")
					end
					CreateTextbox(UDim2.new(0.45,0,0,35), Grey, 0, Name, ID, StolenAnimationsFrame)
					CreateButton(UDim2.new(0.45,0,0,35),Purple, Name, Name, ID, StolenAnimationsFrame, TextBoxRn, true) -- 紫色按钮
					break
				end
			end
		end
	end
	if Input.UserInputType == Enum.UserInputType.MouseButton3 and HoveringButton ~= nil then
		if StealId == HoveringButton:GetAttribute("AnimId") and Track ~= nil then
			Track:Stop()
		end
		StolenAnimationsFrame.CanvasSize -= UDim2.new(0,0,0,HoveringButton.Size.Y.Offset)
		HoveringBox:Destroy()
		HoveringButton:Destroy()
	end
end)

-- 创建按钮
Counter = 0

for i=1, #AnimButtons/2 do
	CreateTextbox(UDim2.new(0.45,0,0,35), Grey, 0, AnimButtons[Counter+2], AnimButtons[Counter+1], AnimationsFrame)
	CreateButton(UDim2.new(0.45,0,0,35),Purple, AnimButtons[Counter+2], AnimButtons[Counter+2], "rbxassetid://".. AnimButtons[Counter+1], AnimationsFrame, TextBoxRn, false) -- 紫色按钮
	Counter += 2
end