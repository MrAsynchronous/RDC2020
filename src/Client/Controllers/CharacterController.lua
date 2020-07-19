-- Character Controller
-- MrAsync
-- July 18, 2020



local CharacterController = {}

--//Api
local CharacterApi

--//Services
local PlayerService

--//Classes

--//Controllers

--//Locals


function CharacterController:Start()

    PlayerService.MovePlayer:Connect(function(newCFrame, isAnchored)
    	CharacterApi:Get():Then(function(character)
    		character:SetPrimaryPartCFrame(newCFrame)

    	end, function()
    		warn("Character not found!")
    	end)
    end)

end


function CharacterController:Init()
    --//Api
    CharacterApi = self.Shared.Character

    --//Services
    PlayerService = self.Services.PlayerService

    --//Classes

    --//Controllers

    --//Locals

end


return CharacterController