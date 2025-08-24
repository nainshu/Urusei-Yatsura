local suc, res = pcall(function ()
    local blocksutil = require(game:GetService("ReplicatedStorage").Modules.Utilities.BlocksUtil)
    local function setblock(block, key, value)
        blocksutil.BlockInfo[block][key] = 999
    end

    local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/twitch-stremaer/Neptuneeeeeee/refs/heads/main/funny.lua"))()
    local window = lib.Window()
    local blocktab = window.Tab("方块")
    local credits = window.Tab("关于")

    local mainsection = blocktab.Section("方块")
    mainsection.Toggle("无限燃料", function(call)
        if call == false then
            setblock("fuel_1", "Fuel", 5)
            setblock("fuel_2", "Fuel", 10)
            setblock("fuel_3", "Fuel", 15)
        else
            setblock("fuel_1", "Fuel", 9e9)
            setblock("fuel_2", "Fuel", 9e9)
            setblock("fuel_3", "Fuel", 9e9)
        end
    end, false)
    mainsection.Toggle("超级机翼", function(call)
        if call == false then
            setblock("wing_1", "Lift", 4)
            setblock("wing_2", "Lift", 8)
            setblock("wing_3", "Lift", 10)
        else
            setblock("wing_1", "Lift", 20)
            setblock("wing_2", "Lift", 20)
            setblock("wing_blood", "Lift", 20)
        end
    end, false)
    mainsection.Toggle("更好的螺旋桨", function(call)
        if call == false then
            setblock("propeller_0", "Force", 4)
            setblock("propeller_1", "Force", 20)
            setblock("propeller_2", "Force", 35)
            setblock("propeller_3", "Force", 42)
            setblock("propeller_blood", "Force", 50)
        else
            setblock("propeller_0", "Force", 150)
            setblock("propeller_1", "Force", 150)
            setblock("propeller_2", "Force", 150)
            setblock("propeller_3", "Force", 150)
            setblock("propeller_blood", "Force", 150)
        end
    end, false)

    local credssection = credits.Section("制作人员")
    credssection.Button("由 NeptX (曾用名 name hub) 制作", function () end)
    credssection.Button("Rscripts 上的 @namehubscript", function () end)
end)

if not suc then
    game.StarterGui:SetCore("SendNotification", {Title = "你的执行器可能不太行，请检查控制台", Text = ":3", Duration = 10})
    print("错误信息: ", res)
end