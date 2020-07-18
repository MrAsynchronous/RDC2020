-- Happy Home
-- MrAsync
-- July 18, 2020



local Template = {}
Template.__aeroPreventStart
Template.__index = Template

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


function Template.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,
       
        Objectives = TableUtil.Copy(ObjectiveIndex),

        _Maid = Maid.new()
    }, Template)

    return self
end


--//Initialize props, map etc
function Template:Initialize()

end


--//Start the round
function Template:Start()

end


--//Cleanup props, map etc
function Template:Cleanup()

end


function Template:Init()
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

return Template