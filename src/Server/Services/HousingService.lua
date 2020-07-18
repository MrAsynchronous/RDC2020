-- Housing Service
-- MrAsync
-- July 18, 2020



local HousingService = {Client = {}}

--//Api

--//Services
local Workspace = game:GetService("Workspace")

--//Classes
local House

--//Controllers

--//Locals
local AvailableHouses = {}
local TakenHouses = {}


function HousingService:GiveHouseToPlayer(player)
    local houseObject = table.remove(AvailableHouses, #AvailableHouses)
    table.insert(TakenHouses, houseObject)

    houseObject:SetOwner(player)

    return houseObject
end


function HousingService:Start()
    local Houses = Workspace.Houses:GetChildren()
    for _, houseModel in pairs(Houses) do
        local houseObject = House.new(houseModel)
        table.insert(AvailableHouses, houseObject)
    end
end


function HousingService:Init()
	--//Api
    
    --//Services
    
    --//Classes
    House = self.Modules.Classes.House

    --//Controllers
    
    --//Locals
    
end


return HousingService