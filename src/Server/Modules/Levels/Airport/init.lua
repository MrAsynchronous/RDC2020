-- Happy Home
-- MrAsync
-- July 18, 2020



local Airport = {}
Airport.__aeroPreventStart = true
Airport.__index = Airport

--//Api
local CharacterApi
local TableUtil

--//Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local PlayerService

--//Classes
local Scheduler
local Promise
local Maid

--//Controllers

--//Locals
local ObjectiveIndex


function Airport.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,
        Airport = Workspace.Airport,
       
        Objectives = TableUtil.Copy(ObjectiveIndex),
        CompletedObjectives = {},
        CurrentObjective = 0,

        Timer = Scheduler.new(60),

        _Maid = Maid.new()
    }, Airport)

    --Add objective props to list
    for _, objective in pairs(self.Objectives) do
        local prop = self.Airport:FindFirstChild(objective.Name)
        if (not prop) then continue end

        objective.Prop = prop
    end

    return self
end


--//Forwards objective
function Airport:ForwardObjective()
    table.insert(self.CompletedObjectives, self.Objectives[self.CurrentObjective])
    self.CurrentObjective = self.CurrentObjective + 1

    if (self.CurrentObjective > #self.Objectives) then
        return self:Cleanup()
    else
        PlayerService:FireClient("SetCurrentObjective", self.Player, "Airport", self.Objectives[self.CurrentObjective])
    end
end


--//Initialize props, map etc
function Airport:Initialize()
    PlayerService:FireClient("MovePlayer", self.Player, self.Airport.Spawn.CFrame)
    PlayerService:FireClient("SendObjectives", self.Player, self.Objectives)

    self:ForwardObjective()

    ReplicatedStorage.Timers:FindFirstChild(self.Player.UserId).TotalTime.Value = 60

    self.Timer:Start()
    self.Timer.Tick:Connect(function(elapsed)
        ReplicatedStorage.Timers:FindFirstChild(self.Player.UserId).Timer.Value = 60 - elapsed
    end)
end


--//Start the round
function Airport:Start()

end


--//Cleanup props, map etc
function Airport:Cleanup()
    PlayerService:ForwardLevel(self.Player)
    self.Timer:Stop()
end


function Airport:Init()
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

return Airport