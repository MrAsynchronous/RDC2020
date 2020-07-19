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
local VisionGui

local Camera
local TimerContainer


function TimerController:Start()
    local connection
    connection = TimerContainer.Timer.Changed:Connect(function(newValue)
        if (not CoreGui.Objectives.Visible and not CoreGui:FindFirstChild("IntroGui")) then
            connection:Disconnect()
        end

        local totalTime = TimerContainer.TotalTime.Value
        local vision = math.clamp(20 - (math.abs(totalTime - newValue) / 4), 0, 20)

        TimerGui.Title.Text = newValue
        VisionGui.Label.Text = vision .. "/" .. vision
        Camera.Blur.Size = 20 - vision
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
    VisionGui = CoreGui.VisionGui
    Camera = Workspace.CurrentCamera
    TimerContainer = ReplicatedStorage.Timers:WaitForChild(self.Player.UserId)

end


return TimerController