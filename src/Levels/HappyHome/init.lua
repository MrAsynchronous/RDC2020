-- Happy Home
-- MrAsync
-- July 18, 2020



local HappyHome = {}
HappyHome.__aeroPreventStart
HappyHome.__index = HappyHome

--//Api
local CharacterApi
local TableUtil

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

        Objectives = TableUtil.Copy(ObjectiveIndex),

        _Maid = Maid.new()
    }, HappyHome)

    return self
end


--//Initialize props, map, etc
function HappyHome:Initialize()

    --Move player to bed
    CharacterApi:Get(self.Player):Then(function(character)
        character.PrimaryPart.Anchored = true
        character:SetPrimaryPartCFrame(CFrame.new(self.House.Props.Bed.Position) * CFrame.Angles(0, math.rad(90), 0))   
    end, function()
        warn("Character not found!")
    end)
end


--//Start the round
function HappyHome:Start()

end


--//Cleanup connections
function HappyHome:Cleanup()

end


function HappyHome:Init()
    --//Api
    CharacterApi = self.Shared.Character
    TableUtil = self.Shared.TableUtil

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