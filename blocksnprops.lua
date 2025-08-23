local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "方块与道具脚本",
   LoadingTitle = "加载中...",
   LoadingSubtitle = "请稍候...",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("主要功能", 4483362458)

MainTab:CreateButton({
   Name = "移除死亡方块",
   Callback = function()
      local killbrick = game.Workspace:FindFirstChild("Map"):FindFirstChild("Classic"):FindFirstChild("KillBrick")
      if killbrick then
         killbrick:Destroy()
         Rayfield:Notify({
            Title = "已移除",
            Content = "死亡方块已移除！",
            Duration = 3
         })
      else
         Rayfield:Notify({
            Title = "错误",
            Content = "未找到死亡方块！",
            Duration = 3
         })
      end
   end,
})

MainTab:CreateButton({
   Name = "瞬间胜利",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local hrp = character:WaitForChild("HumanoidRootPart")
      local buttonPart = game.Workspace:FindFirstChild("Map"):FindFirstChild("Classic"):FindFirstChild("Button")

      if buttonPart then
         hrp.CFrame = buttonPart.CFrame + Vector3.new(0, 3, 0)
      else
         Rayfield:Notify({
            Title = "错误",
            Content = "未找到胜利按钮",
            Duration = 3
         })
      end
   end,
})

local noclipEnabled = false
MainTab:CreateToggle({
   Name = "穿墙模式",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      noclipEnabled = Value
   end,
})

game:GetService("RunService").Stepped:Connect(function()
   if noclipEnabled then
      for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
         if part:IsA("BasePart") then
            part.CanCollide = false
         end
      end
   end
end)