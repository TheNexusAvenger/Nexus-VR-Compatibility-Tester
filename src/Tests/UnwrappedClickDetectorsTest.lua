--[[
TheNexusAvenger

Test for ClickDetectors not wrapped by Nexus VR Core.
--]]

local Workspace = game:GetService("Workspace")

local BaseTest = require(script.Parent:WaitForChild("BaseTest"))
local ProblemHighlights = require(script.Parent:WaitForChild("Common"):WaitForChild("ProblemHighlights"))

local SurfaceGuiCrashTest = BaseTest:Extend()
SurfaceGuiCrashTest:SetClassName("SurfaceGuiCrashTest")



--[[
Creates the test.
--]]
function SurfaceGuiCrashTest:__new()
    self:InitializeSuper()

    --Set up the initial state.
    self.Name = "Unwrapped ClickDetectors"
    self.Icon = "NONE"
    self.Status = "Not Detected"
    self.ProblemText = "ClickDetectors can be hard to interact with in VR. They also can't be interacted with gamepads and can be difficult to identify for mobile users."
    self.SolutionText = "When possible, ProximityPrompts should be used. If it isn't possible, such as several buttons being close to each other, use Nexus VR Core to wrap them."
    self.ClickDetectors = {}
    self.Highlights = ProblemHighlights.new(self)

    --Connect ClickDetectors in Workspace.
    Workspace.DescendantRemoving:Connect(function(Ins)
        if not Ins:IsA("ClickDetector") then return end
        self.ClickDetectors[Ins] = nil
        self:UpdateState()
    end)
    Workspace.DescendantAdded:Connect(function(Ins)
        if not Ins:IsA("ClickDetector") then return end
        self.ClickDetectors[Ins] = true
        self:UpdateState()
    end)
    for _,Ins in pairs(Workspace:GetDescendants()) do
        if Ins:IsA("ClickDetector") then
            self.ClickDetectors[Ins] = true
            self:UpdateState()
        end
    end

    --Occasionally update the ClickDetectors.
    coroutine.wrap(function()
        while true do
            self:UpdateState()
            wait(0.25)
        end
    end)()
end

--[[
Updates the state.
--]]
function SurfaceGuiCrashTest:UpdateState()
    --Determine the problematic ClickDetectors.
    local NexusVRCore = self:GetNexusVRCore()
    local NexusWrappedInstance = NexusVRCore and NexusVRCore:GetResource("NexusWrappedInstance")
    local ClickDetectors,ClickDetectorParts = {},{}
    for ClickDetector,_ in pairs(self.ClickDetectors) do
        if ClickDetector.Parent and ClickDetector.Parent:IsA("BasePart") and (not NexusWrappedInstance or not NexusWrappedInstance.CachedInstances[ClickDetector]) then
            table.insert(ClickDetectors,ClickDetector)
            table.insert(ClickDetectorParts,ClickDetector.Parent)
        end
    end

    --Set the state.
    if #ClickDetectors > 0 then
        self.Icon = "WARNING"
        self.Status = "Problem Detected"
    else
        self.Icon = "NONE"
        self.Status = "Not Detected"
    end
    self.Highlights.Objects = ClickDetectorParts
end



return SurfaceGuiCrashTest