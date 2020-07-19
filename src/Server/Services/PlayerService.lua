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


function PlayerService:ForwardLevel(player)
	local Profile = PlayerProfile:Get(player)
	Profile.LevelHandler:ForwardLevel()
end


function PlayerService.Client:RequestObjectiveForward(player, objective)
	local Profile = PlayerProfile:Get(player)
	local CurrentLevel = Profile.LevelHandler.CurrentLevel

	local currentObjective = CurrentLevel.CurrentObjective
	if (objective.Title == CurrentLevel.Objectives[currentObjective].Title) then
		Profile.LevelHandler.CurrentLevel:ForwardObjective()
	else
		print("Invalid level")
	end
end


function PlayerService.Client:MarkAsReady(player, gender)
	local Profile = PlayerProfile:Get(player)
	Profile.Ready = true

	Profile.LevelHandler:Start(gender)
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
	self:RegisterClientEvent("GameCompleted")
	self:RegisterClientEvent("SendObjectives")
	self:RegisterClientEvent("SetCurrentObjective")

end


return PlayerService