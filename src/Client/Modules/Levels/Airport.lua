-- Happy Home
-- MrAsync
-- July 19, 2020


local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local Sounds = PlayerGui.Sounds
local Camera = Workspace.CurrentCamera
local CoreGui = PlayerGui:WaitForChild("CoreGui")
local ProgressBar = CoreGui.ProgressBar

local function ShowProgressBar()
    ProgressBar.Position = UDim2.new(0.5, 0, 1.1, 0)
    ProgressBar.Visible = true
    ProgressBar:TweenPosition(UDim2.new(0.5, 0, 0.9, 0), "Out", "Quint", .25, true)
end


local function HideProgressBar()
    ProgressBar:TweenPosition(UDim2.new(0.5, 0, 1.1, 0), "Out", "Quint", .25, true, function()
        ProgressBar.Visible = false
        ProgressBar.Container.Bar.Size = UDim2.new(1, 0, 1, 0)
    end)
end


local function ChangeProgress(time)
    ShowProgressBar()

    ProgressBar.Container.Bar:TweenSize(UDim2.new(0.188, 0, 1, 0), "Out", "Linear", time, true, function()
        HideProgressBar()
    end)
end


local function AnchorPlayer()
    Players.LocalPlayer.Character.PrimaryPart.Anchored = true
end


local function UnanchorPlayer()
    Players.LocalPlayer.Character.PrimaryPart.Anchored = false
end


return {
    ["Checkin"] = function(objective)
        Sounds.Checkin:Play()
        ChangeProgress(3)
        AnchorPlayer()

        wait(3)

        UnanchorPlayer()
        Sounds.Checkin:Stop()
    end,
    ["BagXRAY"] = function(objective)
        Sounds.Bagcheck:Play()
        ChangeProgress(1)
        AnchorPlayer()

        wait(1)

        UnanchorPlayer()
    end,
    ["BodyXRAY"] = function(objective)
        Sounds.Xray:Play()
        ChangeProgress(1)
        AnchorPlayer()

        wait(1)

        UnanchorPlayer()
        Sounds.Xray:Stop()
    end,
    ["BagPickup"] = function(objective)
        Sounds.Pickup:Play()
        ChangeProgress(1)
        AnchorPlayer()

        wait(1)

        UnanchorPlayer()
    end,
    ["WaitForPlane"] = function(objective)
        ChangeProgress(7)
        AnchorPlayer()

        wait(7)

        UnanchorPlayer()
    end,
    ["Airplane"] = function(objective)
        Sounds.Airplane:Play()
        ChangeProgress(5)
        AnchorPlayer()

        wait(4)

        local plane = ReplicatedStorage.Airplane:Clone()
        plane.Parent = Workspace

        Camera.CameraType = Enum.CameraType.Scriptable
        Camera.CFrame = ReplicatedStorage.RunwayPosition.Value

        Camera.Blur.Enabled = false

        Sounds.Airplane:Play()
        for node = 1, #ReplicatedStorage.PlaneNodes:GetChildren(), 1 do
            local node = ReplicatedStorage.PlaneNodes:FindFirstChild(node)
            local tween = TweenService:Create(plane.PrimaryPart, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = node.CFrame})
            tween:Play()
            tween.Completed:Wait()
        end

        UnanchorPlayer()
        Camera.Blur.Enabled = true
        Camera.CameraType = Enum.CameraType.Custom
        Sounds.Airplane:Stop()
    end
}