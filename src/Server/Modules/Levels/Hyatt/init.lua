-- Happy Home
-- MrAsync
-- July 18, 2020



local Hyatt = {}
Hyatt.__aeroPreventStart = true
Hyatt.__index = Hyatt

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


function Hyatt.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,
        Hyatt = Workspace.HyattHotel,
       
        Objectives = TableUtil.Copy(ObjectiveIndex),
        CompletedObjectives = {},
        CurrentObjective = 0,

        Timer = Scheduler.new(120),

        _Maid = Maid.new()
    }, Hyatt)

    --Add objective props to list
    for _, objective in pairs(self.Objectives) do
        local prop = self.Hyatt:FindFirstChild(objective.Name)
        if (not prop) then continue end

        objective.Prop = prop
    end

    return self
end


--//Forwards objective
function Hyatt:ForwardObjective()
    table.insert(self.CompletedObjectives, self.Objectives[self.CurrentObjective])
    self.CurrentObjective = self.CurrentObjective + 1

    if (self.CurrentObjective > #self.Objectives) then
        return self:Cleanup()
    else
        PlayerService:FireClient("SetCurrentObjective", self.Player, "Hyatt", self.Objectives[self.CurrentObjective])
    end
end


--//Initialize props, map etc
function Hyatt:Initialize()
    PlayerService:FireClient("MovePlayer", self.Player, self.Hyatt.Spawn.CFrame)
    PlayerService:FireClient("SendObjectives", self.Player, self.Objectives)

    self:ForwardObjective()
    self.Timer:Start()
    self.Timer.Tick:Connect(function(elapsed)
        ReplicatedStorage.Timers:FindFirstChild(self.Player.UserId).Timer.Value = 60 - elapsed
    end)
end


--//Start the round
function Hyatt:Start()

end


--//Cleanup props, map etc
function Hyatt:Cleanup()
    PlayerService:ForwardLevel(self.Player)
end


function Hyatt:Init()
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

return Hyatt