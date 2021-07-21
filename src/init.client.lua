--[[
TheNexusAvenger

Loads Nexus VR Compatibility Tester.
--]]

local TestListView = require(script:WaitForChild("UI"):WaitForChild("TestListView"))



--Create the list view.
local Tests = TestListView.new()
if script.Parent.Name == "PlayerGui" then
    script.Parent = Tests.ScreenGui
end