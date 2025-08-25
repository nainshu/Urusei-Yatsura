local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local netRoot = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")
local RF_ChargeFishingRod = netRoot:WaitForChild("RF/ChargeFishingRod")
local RF_RequestFishingMinigameStarted = netRoot:WaitForChild("RF/RequestFishingMinigameStarted")
local RE_FishingCompleted = netRoot:WaitForChild("RE/FishingCompleted")
local RE_EquipToolFromHotbar = netRoot:WaitForChild("RE/EquipToolFromHotbar")

local AutoFish = true --修改这里来开关

task.spawn(function()
    while AutoFish do
        pcall(function() RE_EquipToolFromHotbar:FireServer(1) end)
        task.wait(0.2)
        pcall(function() RF_ChargeFishingRod:InvokeServer(9999999999) end)
        task.wait(0.2)
        pcall(function() RF_RequestFishingMinigameStarted:InvokeServer(-1.238, 0.969) end)
        task.wait(0.5)
        pcall(function() RE_FishingCompleted:FireServer() end)
        task.wait(0.1)
    end
end)