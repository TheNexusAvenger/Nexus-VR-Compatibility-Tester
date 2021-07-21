--[[
TheNexusAvenger

Loads Nexus VR Compatibility Tester.
--]]

local OPEN_PREFIX = ":"
local OPEN_COMMAND = "vrcheck"



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TestListView = require(script:WaitForChild("UI"):WaitForChild("TestListView"))

local CmdrSetUp = false

--Create the list view.
local Tests = TestListView.new()
if script.Parent.Name == "PlayerGui" then
    script.Parent = Tests.ScreenGui
end



--[[
Sets up the open command with Cmdr.
--]]
local function SetUpCmdr()
    if CmdrSetUp then return end

    --Return if Cmdr is not detected.
    local CmdrClient = ReplicatedStorage:FindFirstChild("CmdrClient")
    if not CmdrClient then return end

    --Load the command.
    local Cmdr = require(CmdrClient)
    Cmdr.Registry:RegisterCommandObject({
        Name = OPEN_COMMAND,
        Description = "Opens Nexus VR Compatibility Tester.",
        Group = "Debug",
        Args = {},
        ClientRun = function()
            Tests.Visible = not Tests.Visible
            return "Nexus VR Compatibility Tester "..(Tests.Visible and "opened" or "closed").."."
        end,
    })
end



--Connect a player chatting the open command.
Players.LocalPlayer.Chatted:Connect(function(Message)
    if string.gsub(string.lower(Message),"%s","") ~= OPEN_PREFIX..OPEN_COMMAND then return end
    Tests.Visible = not Tests.Visible
end)

--Set up Cmdr.
ReplicatedStorage.ChildAdded:Connect(SetUpCmdr)
SetUpCmdr()