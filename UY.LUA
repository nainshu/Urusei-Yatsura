repeat task.wait() until game:IsLoaded()

local soundId = 109465969478488
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://" .. soundId
sound.Volume = 30
sound.Parent = workspace
sound:Play()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/no/main/UI.lua"))()

local window = library.new(library, "Urusei Yatsura", "Urusei Yatsura")

local mainTab = window:Tab("主页面", "rbxassetid://139972859056573")
local mainSection = mainTab:section("主要功能", true)

mainSection:Button("倒计时", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LX318/LX/main/time.lua"))()
    end)
end)

mainSection:Button("MP3[只有忍者才能用]", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/mp3/main/MP3.lua"))()
    end)
end)

mainSection:Button("Cobalt", function()
    pcall(function()
        loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
    end)
end)

mainSection:Button("LALOL后门脚本", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/its-LALOL/LALOL-Hub/main/Backdoor-Scanner/script"))()
    end)
end)

mainSection:Button("自然灾害重力控制", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/no/main/NaturalDisasterSimulatorGravityControlScript.lua"))()
    end)
end)

mainSection:Button("科创云端", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/no/main/TechInnovationCloud.lua"))()
    end)
end)

mainSection:Button("创世纪FE移动端", function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/nainshu/no/main/Genesismobile.lua'))()
    end)
end)

mainSection:Button("创世纪FE移动端黑龙", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/no/main/Dragon.lua"))()
    end)
end)

mainSection:Button("墨水游戏", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/inkgames.github.io/refs/heads/main/ringta.lua"))()
    end)
end)

mainSection:Button("DOORS Figure头", function()
    pcall(function()
    
        local Tool = game:GetObjects("rbxassetid://101804599415530")[1]
print(Tool, typeof(Tool)) -- just a debug
Tool.Parent = game.Players.LocalPlayer.Backpack

    end)
end)

mainSection:Button("DOORS 萝卜怪抱枕", function()
    pcall(function()
    
    local Tool = game:GetObjects("rbxassetid://112332310004804")[1]
print(Tool, typeof(Tool)) -- just a debug
Tool.Parent = game.Players.LocalPlayer.Backpack

    end)
end)

mainSection:Button("跑路中心", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/RunawayHUB/main/RunawayHUB.lua"))()
    end)
end)

mainSection:Button("Real HUB", function()
    pcall(function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/Laelmano24/Rael-Hub/main/main.txt")()
    end)
end)

mainSection:Button("欢迎语", function()
    pcall(function()
    
        local soundId = 109465969478488
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://" .. soundId
sound.Volume = 30
sound.Parent = workspace
sound:Play()

    end)
end)

mainSection:Button("蛋糕发射器", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RedTree1222/scripts/refs/heads/main/Protected_4021534790564889.lua",true))()
    end)
end)

mainSection:Button("皮划艇锦标赛脚本", function()
    pcall(function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/SETHHHX/.../refs/heads/main/%5BNEW%5D%20Kayak%20Racing"))() 
    end)
end)

mainSection:Button("自瞄", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fcsdsss/games/refs/heads/main/Silent%20aim/1.2"))()
    end)
end)

mainSection:Button("动作中心", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/Urusei-Yatsura/refs/heads/main/dancehub.lua",true))()
    end)
end)

mainSection:Button("无标题标签游戏", function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/nAlwspa/Into/refs/heads/main/Loader'))()
    end)
end)

mainSection:Button("在墙上走", function()
    pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
    end)
end)

mainSection:Button("重置人物", function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.Health=0
    end)
end)

mainSection:Button("飞车", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/Urusei-Yatsura/refs/heads/main/CarFly.lua",true))()
    end)
end)
