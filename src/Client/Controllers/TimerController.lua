-- Timer Controller
-- MrAsync
-- July 19, 2020



local TimerController = {}

--//Api

--//Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local PlayerGui

--//Classes

--//Controllers

--//Locals
local CoreGui
local TimerGui

local Camera
local TimerContainer


function TimerController:Start()
    TimerContainer.Timer.Changed:Connect(function(newValue)
        TimerGui.Title.Text = newValue
    end)
end


function TimerController:Init()
    --//Api

    --//Services
    PlayerGui = self.Player:WaitForChild("PlayerGui")

    --//Classes

    --//Controllers

    --//Locals
    CoreGui = PlayerGui:WaitForChild("CoreGui")
    TimerGui = CoreGui.Timer
    Camera = Workspace.CurrentCamera
    TimerContainer = ReplicatedStorage.Timers:WaitForChild(self.Player.UserId)

end


return TimerController