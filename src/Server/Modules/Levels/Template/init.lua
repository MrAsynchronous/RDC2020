-- Happy Home
-- MrAsync
-- July 18, 2020



local Template = {}
Template.__aeroPreventStart = true
Template.__index = Template

--//Api
local CharacterApi
local TableUtil

--//Services
local PlayerService

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
        CompletedObjectives = {},

        _Maid = Maid.new()
    }, Template)

    return self
end


--//Forwards objective
function Airport:ForwardObjective()
    table.insert(self.CompletedObjectives, self.Objectives[self.CurrentObjective])
    self.CurrentObjective = self.CurrentObjective + 1

    if (self.CurrentObjective > #self.Objectives) then
        return self:Cleanup()
    else
        PlayerService:FireClient("SetCurrentObjective", self.Player, self.Objectives[self.CurrentObjective])
    end
end


--//Initialize props, map etc
function Template:Initialize()
    PlayerService:FireClient("MovePlayer", self.Player, self.Airport.Spawn.CFrame)
    PlayerService:FireClient("SendObjectives", self.Player, self.Objectives)

    self:ForwardObjective()
end


--//Start the round
function Template:Start()

end


--//Cleanup props, map etc
function Template:Cleanup()
    PlayerService:ForwardLevel(self.Player)
end


function Template:Init()
    --//Api
    CharacterApi = self.Shared.Character
    TableUtil = self.Shared.TableUtil

    --//Services
    PlayerService = self.Services.PlayerService

    --//Classes
    Scheduler = self.Shared.Scheduler
    Promise = self.Shared.Promise
    Maid = self.Shared.Maid

    --//Controllers

    --//Locals
    ObjectiveIndex = require(script:WaitForChild("Objectives"))

end

return Template