-- Prop Controller
-- MrAsync
-- July 18, 2020



local PropController = {}


--//Api

--//Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerService

--//Classes

--//Controllers

--//Locals
local PropIconTemplate


function PropController:Start()

    PlayerService.SendPropList:Connect(function(propList)
        for _, propObject in pairs(propList) do
            print(propObject.Name)
        end
    end)
end


function PropController:Init()
    --//Api

    --//Services
    PlayerService = self.Services.PlayerService

    --//Classes

    --//Controllers

    --//Locals
    PropIconTemplate = ReplicatedStorage:WaitForChild("PropGui")

end


return PropController