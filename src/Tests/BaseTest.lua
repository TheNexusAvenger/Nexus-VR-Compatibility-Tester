--[[
TheNexusAvenger

Base class for a VR test.
--]]

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
    self.Status = "Manual"
    self.ProblemText = ""
    self.SolutionText = ""
    self.InfoView = "NONE"
end

--[[
Returns the Nexus VR Core module.
--]]
function BaseTest:GetNexusVRCore()
    --TODO: Implement.
end



return BaseTest