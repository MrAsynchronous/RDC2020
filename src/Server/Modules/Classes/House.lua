-- House
-- MrAsync
-- July 18, 2020

--[[
	
	local house = House.new()
	

--]]



local House = {}
House.__index = House


--//Api

--//Service

--//Classes

--//Controllers

--//Locals

function House.new(houseObject)
	local self = setmetatable({
		Object = houseObject
	}, House)
	
	return self
end


function House:SetOwner(player)
	self.Owner = player
end


function House:Reset(player)
	self.Owner = nil
end


function House:Init()
	--//Api
	
	--//Service
	
	--//Classes
	
	--//Controllers
	
	--//Locals

end


return House