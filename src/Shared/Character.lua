-- Character
-- MrAsync
-- July 18, 2020



local Character = {}

local RunService = game:GetService("RunService")

local PromiseClass

function Character:Get(player)
    if (not RunService:IsServer()) then player = self.Player end

    return PromiseClass.Async(function(resolve, reject)
        if (not player) then reject() end

        if (player.Character) then
            resolve(player.Character)
        else
            local character = player.CharacterAdded:Wait()
            while (character.PrimaryPart == nil) do wait() end

            resolve(character)
        end
    end)
end

function Character:Init()
    PromiseClass = self.Shared.Promise
end

return Character