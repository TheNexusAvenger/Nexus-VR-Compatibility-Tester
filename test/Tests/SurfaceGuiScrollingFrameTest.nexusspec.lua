--[[
TheNexusAvenger

Tests the SurfaceGuiScrollingFramesTest class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")

local SurfaceGuiScrollingFramesTest = require(game:GetService("StarterGui"):WaitForChild("NexusVRCompatibilityTester"):WaitForChild("Tests"):WaitForChild("SurfaceGuiScrollingFramesTest"))
local SurfaceGuiScrollingFramesTestTest = NexusUnitTesting.UnitTest:Extend()



--[[
Sets up the test.
--]]
function SurfaceGuiScrollingFramesTestTest:Setup()
    self.CuT = SurfaceGuiScrollingFramesTest.new()
end

--[[
Tears down the test.
--]]
function SurfaceGuiScrollingFramesTestTest:Teardown()
    if self.SurfaceGui then
        self.SurfaceGui:Destroy()
    end
end

--[[
Tests the state updating.
--]]
NexusUnitTesting:RegisterUnitTest(SurfaceGuiScrollingFramesTestTest.new("StateUpdates"):SetRun(function(self)
    --Create a SurfaceGui and make sure the state didn't change.
    local SurfaceGui = Instance.new("SurfaceGui")
    SurfaceGui.Parent = game:GetService("Workspace")
    self.SurfaceGui = SurfaceGui

    --Add a frame and assert the state doesn't change.
    local Frame = Instance.new("Frame")
    Frame.Parent = SurfaceGui
    wait()
    self:AssertEquals(self.CuT.Icon,"NONE")

    --Add a ScrollingFrame and assert the state changes.
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Parent = SurfaceGui
    wait()
    self:AssertEquals(self.CuT.Icon,"WARNING")

    --Remove the ScrollingFrame and assert the state changes.
    ScrollingFrame:Destroy()
    wait()
    self:AssertEquals(self.CuT.Icon,"NONE")
end))



return true