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
        Props = {},

        _Props = {},
        _Maid = Maid.new()
    }, HappyHome)


    --Add objective props to list
    for _, objective in pairs(self.Objectives) do
        local prop = self.House.Props:FindFirstChild(objective.Title)
        if (not prop) then continue end

        table.insert(self.Props, Prop.new(prop))
        table.insert(self._Props, prop)
    end

    return self
end


--//Initialize props, map, etc
function HappyHome:Initialize()
    --Move character
    PlayerService:FireClient("MovePlayer", self.Player, self.House.Props.Bed.CFrame * CFrame.Angles(0, math.rad(90), 0), true)
    PlayerService:FireClient("SendPropList", self.Player, self._Props)
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