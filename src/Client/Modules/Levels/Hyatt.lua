-- Happy Home
-- MrAsync
-- July 19, 2020


local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

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
    ["Doorway"] = function(objective)
        ChangeProgress(3)
        AnchorPlayer()

        wait(3)

        UnanchorPlayer()
    end
}