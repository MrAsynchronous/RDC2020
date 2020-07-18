-- Character
-- MrAsync
-- July 18, 2020



local Character = {}

local PromiseClass

function Character:Get(player)
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