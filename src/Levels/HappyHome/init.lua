-- Happy Home
-- MrAsync
-- July 18, 2020



local HappyHome = {}
HappyHome.__index = HappyHome

--//Api
local CharacterApi

--//Services

--//Classes
local Scheduler
local Promise
local Maid

--//Controllers

--//Locals
local ObjectiveIndex


function HappyHome.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,
        House = playerProfile.House.Object,

        Objectives = 

    }, HappyHome)

    return self
end


function HappyHome:Initialize()
    CharacterApi:Get(self.Player):Then(function(character)
        
    end, function()
        warn("Character not found!")
    end)
end


function HappyHome:Cleanup()

end


function HappyHome:Init()
    --//Api
    CharacterApi = self.Shared.Character

    --//Services

    --//Classes
    Scheduler = self.Shared.Scheduler
    Promise = self.Shared.Proimise
    Maid = self.Shared.Maid

    --//Controllers

    --//Locals
    ObjectiveIndex = require(script:WaitForChild("Objectives"))

end

return HappyHome