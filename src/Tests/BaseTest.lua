--[[
TheNexusAvenger

Base class for a VR test.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NexusInstance = require(script.Parent.Parent:WaitForChild("NexusInstance"):WaitForChild("NexusInstance"))

local BaseTest = NexusInstance:Extend()
BaseTest:SetClassName("BaseTest")



--[[
Creates the test.
--]]
function BaseTest:__new()
    self:InitializeSuper()

    self.Name = "UNDEFINED"
    self.Icon = "UNKNOWN"
    self.Status = "Manual Test Only"
    self.ProblemText = ""
    self.SolutionText = ""
    self.InfoView = "NONE"
end

--[[
Returns the Nexus VR Core module.
--]]
function BaseTest:GetNexusVRCore()
    local NexusVRCore = ReplicatedStorage:FindFirstChild("NexusVRCore")
    return NexusVRCore and require(NexusVRCore)
end



return BaseTest