-- Intro Controller
-- MrAsync
-- July 18, 2020



local IntroController = {}


--//Api
local CharacterApi

--//Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local PlayerService
local PlayerGui

--//Classes

--//Controllers
local FadeController

--//Locals
local Sounds
local Camera
local CoreGui
local IntroGui
local InfoGui
local GenderSelection
local LoadingCameraPosition


local function Cleanup(gender)
    FadeController:SetBackgroundColor(Color3.fromRGB(255,255,255))
    FadeController:Out(1)

    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 12
    blurEffect.Parent = Camera

    GenderSelection.Visible = false
    CoreGui.Objectives.Visible = true
    CoreGui.Timer.Visible = true

    Sounds.InGame.Volume = 0
    Sounds.InGame:Play()
    TweenService:Create(Sounds.Theme, TweenInfo.new(1), {Volume = 0}):Play()
    TweenService:Create(Sounds.InGame, TweenInfo.new(1), {Volume = 0.5}):Play()

    IntroGui:Destroy()
    PlayerService:MarkAsReady(gender)
    Camera.CameraType = Enum.CameraType.Custom
end


function IntroController:Start()
    Sounds.Theme:Play()

    PlayerService.GameCompleted:Connect(function()
        Camera.Blur.Enabled = false
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
            IntroGui.Visible = false
            GenderSelection.Visible = true

            GenderSelection.Male.MouseButton1Click:Connect(function()
                Cleanup("Male")
            end)

            GenderSelection.Female.MouseButton1Click:Connect(function()
                Cleanup("Female")
            end)

            GenderSelection.Binary.MouseButton1Click:Connect(function()
                Cleanup("Binary")
            end)
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
    Sounds = PlayerGui:WaitForChild("Sounds")
    Camera = Workspace.CurrentCamera
    CoreGui = PlayerGui:WaitForChild("CoreGui")
    IntroGui = CoreGui.IntroGui
    InfoGui = CoreGui.InfoGui
    GenderSelection = CoreGui.GenderSelection
    LoadingCameraPosition = ReplicatedStorage:WaitForChild("LoadingCameraPosition")

end


return IntroController