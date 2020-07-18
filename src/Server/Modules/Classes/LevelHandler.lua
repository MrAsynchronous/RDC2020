-- Level Handler
-- MrAsync
-- July 18, 2020



local LevelHandler = {}
LevelHandler.__index = LevelHandler

--//Api

--//Services
local ServerStorage = game:GetService("ServerStorage")

--//Classes

--//Controllers

--//Locals  
local LevelIndex


function LevelHandler.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,

        Levels = {}
    }, LevelHandler)

    --Cache level objects
    for i=1, #LevelIndex do
        local class = require(LevelIndex[i])
        table.insert(self.Levels, class.new(playerProfile))
    end

    --Set current level, should be happy home
    self.CurrentLevel = self.Levels[1]
    self.CurrentLevel:Initialize()

    return self
end


function LevelHandler:Init()
    --//Api
    
    --//Services
    
    --//Classes

    --//Controllers
    
    --//Locals
    LevelIndex = ServerStorage:WaitForChild("Levels"):GetChildren()
    
    
end


return LevelHandler