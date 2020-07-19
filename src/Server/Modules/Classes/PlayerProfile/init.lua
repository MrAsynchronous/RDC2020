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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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

	local timerContainer = Instance.new("Folder")
	timerContainer.Name = player.UserId
	timerContainer.Parent = ReplicatedStorage.Timers

	local timer = Instance.new("NumberValue")
	timer.Name = "Timer"
	timer.Parent = timerContainer

	local totalTime = Instance.new("NumberValue")
	totalTime.Name = "TotalTime"
	totalTime.Parent = timerContainer

	self.timerContainer = timerContainer
	self._Maid:GiveTask(timerContainer)
	self._Maid:GiveTask(timer)
	self._Maid:GiveTask(totalTime)

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