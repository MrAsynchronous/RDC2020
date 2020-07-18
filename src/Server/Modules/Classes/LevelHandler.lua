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

        Levels = {},
        CompletedLevels = {}
    }, LevelHandler)

    --Cache level objects
    for i=1, #LevelIndex do
        local class = require(LevelIndex[i])
        table.insert(self.Levels, class.new(playerProfile))
    end

    --Set current level, should be happy home
    self:ChangeLevel(1)
    self.CurrentLevel:Initialize()

    return self
end


function LevelHandler:ChangeLevel(newLevel)
    if (self.CurrentLevel) then
        table.insert(CompletedLevels, self.CurrentLevel)
    end

    self.CurrentLevel = self.Levels[newLevel]
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