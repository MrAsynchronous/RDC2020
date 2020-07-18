-- Level Handler
-- MrAsync
-- July 18, 2020



local LevelHandler = {}
LevelHandler.__index = LevelHandler

--//Api

--//Services
local PlayerService

--//Classes

--//Controllers

--//Locals
local HappyHome


function LevelHandler.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,

        Levels = {
            HappyHome.new(playerProfile)
        },

        CompletedLevels = {}
    }, LevelHandler)

    --Set current level, should be happy home
    self:ChangeLevel(1)

    return self
end


--//Updates currentLevel
function LevelHandler:ChangeLevel(newLevel)
    if (self.CurrentLevel) then
        table.insert(self.CompletedLevels, self.CurrentLevel)
    end

    self.CurrentLevel = self.Levels[newLevel]
    self.CurrentLevel:Initialize()
end


function LevelHandler:Init()
    --//Api

    --//Services
    PlayerService = self.Services.PlayerService

    --//Classes

    --//Controllers

    --//Locals
    HappyHome = self.Modules.Levels.HappyHome

end


return LevelHandler