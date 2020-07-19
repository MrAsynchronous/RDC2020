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
    ["Glasses"] = function(objective)
        Sounds.Glasses:Play()

        --Clone glasses to put on player
        local newGlasses = objective.Prop:Clone()
        newGlasses.Parent = Players.LocalPlayer.Character
        newGlasses.PrimaryPart.Anchored = false
        newGlasses.PrimaryPart.CanCollide = false
        newGlasses.PrimaryPart.Size = newGlasses.PrimaryPart.Size * 2
        newGlasses:SetPrimaryPartCFrame(Players.LocalPlayer.Character.Head.CFrame)

        --Create weld
        local weld = Instance.new("WeldConstraint")
        weld.Parent = newGlasses.PrimaryPart
        weld.Part0 = newGlasses.PrimaryPart
        weld.Part1 = Players.LocalPlayer.Character.Head

        --Remove other glasses, remove blur
        objective.Prop:Destroy()
        Camera.Blur.Size = 0
    end,
    ["Shower"] = function(objective)
        Sounds.Shower:Play()
        ChangeProgress(2)
        AnchorPlayer()

        --Enable particle
        objective.Prop.Particle.ParticleEmitter.Enabled = true
        wait(2)
        objective.Prop.Particle.ParticleEmitter.Enabled = false
        UnanchorPlayer()
        Sounds.Shower:Stop()
    end,
    ["Toothbrush"] = function(objective)
        Sounds.Toothbrush:Play()
        ChangeProgress(2)
        AnchorPlayer()

        --Enable Particle
        objective.Prop.Particle.ParticleEmitter.Enabled = true
        wait(2)
        objective.Prop.Particle.ParticleEmitter.Enabled = false
        UnanchorPlayer()
        Sounds.Toothbrush:Stop()
    end,
    ["CerealBowl"] = function(objective)
        Sounds.Cereal:Play()
        ChangeProgress(1)
        AnchorPlayer()

        --Tween milk
        TweenService:Create(objective.Prop.Milk, TweenInfo.new(1), {Transparency = 1}):Play()
        wait(1)
        UnanchorPlayer()
        Sounds.Cereal:Stop()
    end,
    ["DrawerA"] = function(objective)
        Sounds.Drawer:Play()
        ChangeProgress(2)
        AnchorPlayer()

        --Move drawer
        local initialPosition = objective.Prop.PrimaryPart.CFrame
        local openPosition = initialPosition + (initialPosition.LookVector * 1.5)
        TweenService:Create(objective.Prop.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CFrame = openPosition}):Play()
        wait(1.5)
        TweenService:Create(objective.Prop.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CFrame = initialPosition}):Play()        
        wait(0.5)

        UnanchorPlayer()
    end,
    ["DrawerB"] = function(objective)
        Sounds.Drawer:Play()
        ChangeProgress(2)
        AnchorPlayer()

        --Move drawer
        local initialPosition = objective.Prop.PrimaryPart.CFrame
        local openPosition = initialPosition + (initialPosition.LookVector * 1.5)
        TweenService:Create(objective.Prop.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CFrame = openPosition}):Play()
        wait(1.5)
        TweenService:Create(objective.Prop.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CFrame = initialPosition}):Play()        
        wait(0.5)

        UnanchorPlayer()
    end,
    ["DrawerC"] = function(objective)
        Sounds.Drawer:Play()
        ChangeProgress(2)
        AnchorPlayer()

        --Move drawer
        local initialPosition = objective.Prop.PrimaryPart.CFrame
        local openPosition = initialPosition + (initialPosition.LookVector * 1.5)
        TweenService:Create(objective.Prop.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CFrame = openPosition}):Play()
        wait(1.5)
        TweenService:Create(objective.Prop.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CFrame = initialPosition}):Play()        
        wait(0.5)

        UnanchorPlayer()
    end,

}