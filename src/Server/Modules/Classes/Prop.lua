-- Prop
-- MrAsync
-- July 18, 2020



local Prop = {}
Prop.__index = Prop

--//Api

--//Services

--//Classes
local Promise
local Event
local Maid

--//Controllers

--//Lcals


function Prop.new(object)
    local self = setmetatable({
        Object = object,

        Activated = Event.new(),

        _Maid = Maid.new()
    }, Prop)

    return self
end


function Prop:Init()
    --//Api

    --//Services

    --//Classes
    Promise = self.Shared.Promise
    Event = self.Shared.Event
    Maid = self.Shared.Maid

    --//Controllers

    --//Locals

end


return Prop