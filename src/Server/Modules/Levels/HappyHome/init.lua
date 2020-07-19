-- Happy Home
-- MrAsync
-- July 18, 2020



local HappyHome = {}
HappyHome.__aeroPreventStart = true
HappyHome.__index = HappyHome

--//Api
local CharacterApi
local TableUtil

--//Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerService

--//Classes
local Scheduler
local Promise
local Prop
local Maid

--//Controllers

--//Locals
local ObjectiveIndex


function HappyHome.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,
        House = playerProfile.House.Object,

        Objectives = TableUtil.Copy(ObjectiveIndex),
        CompletedObjectives = {},

        Timer = Scheduler.new(60),

        _Maid = Maid.new()
    }, HappyHome)

    self.CurrentObjective = 0

    --Add objective props to list
    for _, objective in pairs(self.Objectives) do
        local prop = self.House.Props:FindFirstChild(objective.Name)
        if (not prop) then continue end

        objective.Prop = prop
    end

    return self
end


--//Forwards objective
function HappyHome:ForwardObjective()
    table.insert(self.CompletedObjectives, self.Objectives[self.CurrentObjective])
    self.CurrentObjective = self.CurrentObjective + 1

    if (self.CurrentObjective > #self.Objectives) then
        return self:Cleanup()
    else
        PlayerService:FireClient("SetCurrentObjective", self.Player, "HappyHome", self.Objectives[self.CurrentObjective])
    end
end


--//Initialize props, map, etc
function HappyHome:Initialize(gender)
    local bedCFrame = self.House.Props.Bed.CFrame
    local position = bedCFrame + (-bedCFrame.RightVector * 5) + Vector3.new(0, 2, 0)

    if (gender) then
        self.Objectives[4].Gender = gender
    end

    --Move character
    PlayerService:FireClient("MovePlayer", self.Player, position, true)
    PlayerService:FireClient("SendObjectives", self.Player, self.Objectives)

    self:ForwardObjective()

    self.Timer:Start()
    self.Timer.Tick:Connect(function(elapsed)
        ReplicatedStorage.Timers:FindFirstChild(self.Player.UserId).Timer.Value = 60 - elapsed
    end)
end


--//Cleanup connections
function HappyHome:Cleanup()
    PlayerService:ForwardLevel(self.Player)
    self.Timer:Stop()
end


function HappyHome:Init()
    --//Api
    CharacterApi = self.Shared.Character
    TableUtil = self.Shared.TableUtil

    --//Services
    PlayerService = self.Services.PlayerService

    --//Classes
    Scheduler = self.Shared.Scheduler
    Promise = self.Shared.Promise
    Prop = self.Modules.Classes.Prop
    Maid = self.Shared.Maid

    --//Controllers

    --//Locals
    ObjectiveIndex = require(script:WaitForChild("Objectives"))

end


return HappyHome