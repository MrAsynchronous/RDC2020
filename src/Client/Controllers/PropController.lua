-- Prop Controller
-- MrAsync
-- July 18, 2020



local PropController = {}


--//Api

--//Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local PlayerService
local PlayerGui

--//Classes
local Maid

--//Controllers
local FadeController

--//Locals
local CoreGui
local ObjectiveGui

local PropIconTemplate
local ObjectiveList = {}
local PropIcons = {}

local _Maid


function PropController:Start()
    PlayerService.SendObjectives:Connect(function(objectives)
        for _, ui in pairs(ObjectiveList) do
            ui:Destroy()
        end
        for _, ui in pairs(PropIcons) do
            ui:Destroy()
        end

        for _, objective in pairs(objectives) do
            local objectiveText = ObjectiveGui.Container.Template:Clone()
            objectiveText.Text = objective.Title
            objectiveText.Parent = ObjectiveGui.Container
            objectiveText.Visible = true
            objectiveText.Name = objective.Name

            local propGui = PropIconTemplate:Clone()
            propGui.Adornee = objective.Prop.PrimaryPart
            propGui.Parent = self.Player.PlayerGui

            table.insert(ObjectiveList, objectiveText)
            table.insert(PropIcons, propGui)
        end

        FadeController:In(1)
    end)

    PlayerService.SetCurrentObjective:Connect(function(levelName, objective)
        local icon = PropIcons[1]
        while (not icon:FindFirstChild("Container")) do wait() end

        icon.Enabled = true
        icon.Container.Button.MouseButton1Click:Connect(function()
            if ((objective.Prop.PrimaryPart.Position - self.Player.Character.PrimaryPart.Position).magnitude > 10) then return end

            icon.Enabled = false
            table.remove(PropIcons, 1):Destroy()
            table.remove(ObjectiveList, 1):Destroy()

            if (self.Modules.Levels[levelName][objective.Name] ~= nil) then
                self.Modules.Levels[levelName][objective.Name](objective)
            end

            PlayerService:RequestObjectiveForward(objective)
        end)
    end)

end


function PropController:Init()
    --//Api

    --//Services
    PlayerService = self.Services.PlayerService

    PlayerGui = self.Player:WaitForChild("PlayerGui")

    --//Classes
    Maid = self.Shared.Maid

    --//Controllers
    FadeController = self.Controllers.Fade

    --//Locals
    CoreGui = PlayerGui:WaitForChild("CoreGui")
    ObjectiveGui = CoreGui.Objectives

    PropIconTemplate = ReplicatedStorage:WaitForChild("PropGui")
    _Maid = Maid.new()

end


return PropController