-- Player Profile
-- MrAsync
-- July 18, 2020

--[[
	
	local playerProfile = PlayerProfile.new()

--]]



local PlayerProfile = {}
PlayerProfile.__index = PlayerProfile


--//Api
local DataStore2
local TableUtil

--//Services
local ServerStorage = game:GetService("ServerStorage")

--//Classes
local Maid

--//Controllers

--//Locals
local DefaultPlayerData
local Profiles = {}


function PlayerProfile.new(player)
	local self = setmetatable({
		Player = player,
		
		
		_Maid = Maid.new()
	}, PlayerProfile)
	
	Profiles[player] = self
	
	--//Data
	for key, value in pairs(TableUtil.Copy(DefaultPlayerData)) do
	--	self[key] = DataStore2(key, player)
	--	print(key, self[key]:Get(value))
	end
	
	return self
end


function PlayerProfile:Unload()
	Profiles[self.Player] = nil
end


function PlayerProfile:Get(player)
	return Profiles[player]
end


function PlayerProfile:Init()
	--//Api
	DataStore2 = require(ServerStorage:WaitForChild("DataStore2"))
	TableUtil = self.Shared.TableUtil
	
	--//Services
	
	--//Classes
	Maid = self.Shared.Maid
	
	--//Controllers
	
	--//Locals
	DefaultPlayerData = require(script:WaitForChild("DefaultPlayerData"))
	
end


return PlayerProfile