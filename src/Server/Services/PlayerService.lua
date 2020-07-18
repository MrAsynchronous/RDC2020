-- Player Service
-- MrAsync
-- July 18, 2020

--[[
	
	Server:
		
	


	Client:
		
	

--]]



local PlayerService = {Client = {}}

--//Api
local CharacterApi

--//Service
local Players = game:GetService("Players")

local HousingService

--//Classes
local PlayerProfile
local LevelHandler

--//Controllers

--//Locals


function PlayerService:Start()
	Players.PlayerAdded:Connect(function(player)
		print(player.Name, "has joined!")
		
		local Profile = PlayerProfile.new(player)
		Profile.House = HousingService:GiveHouseToPlayer(Profile)
		Profile.LevelHandler = LevelHandler.new(Profile)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		print(player.Name, "has left")
		
		local Profile = PlayerProfile:Get(player)
		Profile:Unload()
	end)
end


function PlayerService:Init()
	--//Api
	CharacterApi = self.Shared.Character

	--//Service
	HousingService = self.Services.HousingService
	
	--//Classes
	PlayerProfile = self.Modules.Classes.PlayerProfile
	LevelHandler = self.Modules.Classes.LevelHandler
	
	--//Controllers
	
	--//Locals
	self:RegisterClientEvent("MovePlayer")
	self:RegisterClientEvent("SendPropList")
	
end


return PlayerService