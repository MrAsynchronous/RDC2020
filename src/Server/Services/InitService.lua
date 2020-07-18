-- Init Service
-- MrAsync
-- July 18, 2020

--[[
	
	Server:
		
	


	Client:
		
	

--]]



local InitService = {Client = {}}
InitService.__aeroOrder = 1

--//Api

--//Service
local Workspace = game:GetService("Workspace")

--//Classes
local House

--//Controllers

--//Locals


function InitService:Start()
	--Initialize houses
	local houses = Workspace:WaitForChild("Houses"):GetChildren()
	for _, house in next, houses do
		House.new(house)
	end
end


function InitService:Init()
	--//Api
	--//Service
	
	
	--//Classes
	House = self.Modules.Classes.House
	
	--//Controllers
	
	--//Locals

end


return InitService