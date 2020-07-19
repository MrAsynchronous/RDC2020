-- Intro Controller
-- MrAsync
-- July 18, 2020



local IntroController = {}


--//Api
local CharacterApi

--//Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local PlayerService
local PlayerGui

--//Classes

--//Controllers
local FadeController

--//Locals
local Camera
local CoreGui
local IntroGui
local LoadingCameraPosition


function IntroController:Start()
    CharacterApi:Get():Then(function()
        Camera.CameraType = Enum.CameraType.Scriptable
        Camera.CFrame = LoadingCameraPosition.Value
    end):Finally(function()
        IntroGui.Play.MouseButton1Click:Connect(function()
            FadeController:SetBackgroundColor(Color3.fromRGB(255,255,255))
            FadeController:Out(1)

            local blurEffect = Instance.new("BlurEffect")
            blurEffect.Size = 12
            blurEffect.Parent = Camera

            CoreGui.Objectives.Visible = true
            CoreGui.Timer.Visible = true

            IntroGui:Destroy()
            PlayerService:MarkAsReady()
            Camera.CameraType = Enum.CameraType.Custom
        end)
    end)
end


function IntroController:Init()
    --//Api
    CharacterApi = self.Shared.Character

    --//Services
    PlayerGui = self.Player:WaitForChild("PlayerGui")

    PlayerService = self.Services.PlayerService

    --//Classes

    --//Controllers
    FadeController = self.Controllers.Fade

    --//Locals
    Camera = Workspace.CurrentCamera
    CoreGui = PlayerGui:WaitForChild("CoreGui")
    IntroGui = CoreGui.IntroGui
    LoadingCameraPosition = ReplicatedStorage:WaitForChild("LoadingCameraPosition")

end


return IntroController