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
local Houses = {}


function House.new(houseObject)
	local self = setmetatable({
		Object = houseObject
	}, House)
	
	table.insert(Houses, houseObject)
	
	return self
end


function House:GiveOwner(player)
	self.Owner = player
end


function House:Unload()
	for i, house in pairs(Houses) do
		if (house.Object == self.Object) then
			table.remove(Houses, i)
		end
	end
end


function House:Init()
	--//Api
	
	--//Service
	
	--//Classes
	
	--//Controllers
	
	--//Locals

end


return House