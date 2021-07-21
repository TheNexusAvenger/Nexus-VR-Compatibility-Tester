--[[
TheNexusAvenger

Tests the SurfaceGuiCrashTest class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")

local SurfaceGuiCrashTest = require(game:GetService("StarterGui"):WaitForChild("NexusVRCompatibilityTester"):WaitForChild("Tests"):WaitForChild("SurfaceGuiCrashTest"))
local SurfaceGuiCrashTestTest = NexusUnitTesting.UnitTest:Extend()



--[[
Sets up the test.
--]]
function SurfaceGuiCrashTestTest:Setup()
    self.CuT = SurfaceGuiCrashTest.new()
end

--[[
Tears down the test.
--]]
function SurfaceGuiCrashTestTest:Teardown()
    if self.SurfaceGui then
        self.SurfaceGui:Destroy()
    end
end

--[[
Tests the state updating.
--]]
NexusUnitTesting:RegisterUnitTest(SurfaceGuiCrashTestTest.new("StateUpdates"):SetRun(function(self)
    --Create a SurfaceGui and make sure the state didn't change.
    local SurfaceGui = Instance.new("SurfaceGui")
    SurfaceGui.Parent = game:GetService("Workspace")
    self.SurfaceGui = SurfaceGui

    --Add a frame and assert the state doesn't change.
    local Frame = Instance.new("Frame")
    Frame.Parent = SurfaceGui
    wait()
    self:AssertEquals(self.CuT.Icon,"NONE")

    --Add a button and assert the state changes.
    local Button = Instance.new("TextButton")
    Button.Parent = SurfaceGui
    wait()
    self:AssertEquals(self.CuT.Icon,"ERROR")

    --Reset the state, remove the button, make the frame selectable, and assert the state changes.
    Button:Destroy()
    self.CuT.Icon = "NONE"
    Frame.Selectable = true
    wait()
    self:AssertEquals(self.CuT.Icon,"ERROR")
end))



return true