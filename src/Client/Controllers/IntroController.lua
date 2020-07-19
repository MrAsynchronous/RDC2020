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
local InfoGui
local LoadingCameraPosition


function IntroController:Start()
    PlayerService.GameCompleted:Connect(function()
        Camera.Blur.Size = 0
        CoreGui.Objectives.Visible = false
        CoreGui.ProgressBar.Visible = false
        CoreGui.Timer.Visible = false
        CoreGui.CompletedGui.Visible = true
        CoreGui.CompletedGui.Exit.MouseButton1Click:Connect(function()
            CoreGui.CompletedGui.Visible = false
        end)
    end)

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

        IntroGui.Info.MouseButton1Click:Connect(function()
            IntroGui.Visible = false
            InfoGui.Visible = true
        end)

        InfoGui.Exit.MouseButton1Click:Connect(function()
            InfoGui.Visible = false
            IntroGui.Visible = true
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
    InfoGui = CoreGui.InfoGui
    LoadingCameraPosition = ReplicatedStorage:WaitForChild("LoadingCameraPosition")

end


return IntroController