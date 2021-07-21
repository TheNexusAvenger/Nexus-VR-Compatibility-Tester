--[[
TheNexusAvenger

Test for camera animations.
--]]

local Workspace = game:GetService("Workspace")

local BaseTest = require(script.Parent:WaitForChild("BaseTest"))

local CameraTweensTest = BaseTest:Extend()
CameraTweensTest:SetClassName("CameraTweensTest")



--[[
Creates the test.
--]]
function CameraTweensTest:__new()
    self:InitializeSuper()

    --Set up the initial state.
    self.Name = "Camera Animations"
    self.Icon = "NONE"
    self.Status = "Not Detected"
    self.ProblemText = "Camera animations can cause motion sickness while playing in VR since it moves the player's view without the player moving."
    self.SolutionText = "Disable camera animations in VR."

    --Connect camera changes.
    local Camera = Workspace.CurrentCamera
    Camera:GetPropertyChangedSignal("CameraType"):Connect(function()
        self.LastScriptableTime = (Camera.CameraType == Enum.CameraType.Scriptable and tick() or 0)
    end)
    Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
        if self.LastScriptableTime and tick() - self.LastScriptableTime > 1/60 then
            self.Icon = "WARNING"
            self.Status = "Problem Detected"
        end
    end)
end



return CameraTweensTest