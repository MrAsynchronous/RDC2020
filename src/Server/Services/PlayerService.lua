-- Player Service
-- MrAsync
-- July 18, 2020

--[[
	
	Server:
		
	


	Client:
		
	

--]]



local PlayerService = {Client = {}}

--//Api

--//Service
local Players = game:GetService("Players")

--//Classes
local PlayerProfile

--//Controllers

--//Locals


function PlayerService:Start()
	Players.PlayerAdded:Connect(function(player)
		print(player.Name, "has joined!")
		
		local Profile = PlayerProfile.new(player)
		
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		print(player.Name, "has left")
		
		local Profile = PlayerProfile:Get(player)
		Profile:Unload()
	end)
end


function PlayerService:Init()
	--//Api

	--//Service
	
	--//Classes
	PlayerProfile = self.Modules.Classes.PlayerProfile
	
	--//Controllers
	
	--//Locals

end


return PlayerService