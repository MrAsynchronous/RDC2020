-- Level Handler
-- MrAsync
-- July 18, 2020



local LevelHandler = {}
LevelHandler.__aeroPreventStart = true
LevelHandler.__index = LevelHandler

--//Api

--//Services
local PlayerService

--//Classes

--//Controllers

--//Locals
local HappyHome
local Airport


function LevelHandler.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,

        Levels = {
            HappyHome.new(playerProfile),
            Airport.new(playerProfile)
        },

        _CurrentLevel = 0,
        CompletedLevels = {},
    }, LevelHandler)

    --Set current level, should be happy home
    self:ForwardLevel(true)

    return self
end


--//Called when the player clicks play
function LevelHandler:Start()
    self.CurrentLevel:Initialize()
end


--//Updates currentLevel
function LevelHandler:ForwardLevel(isInitial)
    self._CurrentLevel = self._CurrentLevel + 1
    self.CurrentLevel = self.Levels[self._CurrentLevel]

    if (not self.CurrentLevel) then
        return print("GAME OVER!")
    end

    if (not isInitial) then
        self.CurrentLevel:Initialize()
    end
end


function LevelHandler:Init()
    --//Api

    --//Services
    PlayerService = self.Services.PlayerService

    --//Classes

    --//Controllers

    --//Locals
    HappyHome = self.Modules.Levels.HappyHome
    Airport = self.Modules.Levels.Airport

end


return LevelHandler