--[[
TheNexusAvenger

Displays a list of tests.
--]]

local Players = game:GetService("Players")

local NexusInstance = require(script.Parent.Parent:WaitForChild("NexusInstance"):WaitForChild("NexusInstance"))
local TestView = require(script.Parent:WaitForChild("TestView"))
local Tests = script.Parent.Parent:WaitForChild("Tests")

local TestListView = NexusInstance:Extend()
TestListView:SetClassName("TestListView")



--[[
Creates the list view.
--]]
function TestListView:__new()
    self:InitializeSuper()

    --Create the frames.
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NexusVRCompatibilityTester"
    ScreenGui.ResetOnSpawn = true
    ScreenGui.DisplayOrder = 1000
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    self.ScreenGui = ScreenGui

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.BackgroundColor3 = Color3.new(0,0,0)
    ScrollingFrame.Name = "TestsList"
    ScrollingFrame.Size = UDim2.new(0.5,0,1,0)
    ScrollingFrame.Position = UDim2.new(1,0,0,0)
    ScrollingFrame.AnchorPoint = Vector2.new(1,0)
    ScrollingFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.Parent = ScreenGui
    self.Container = ScrollingFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0,5)
    UIListLayout.SortOrder = Enum.SortOrder.Name
    UIListLayout.Parent = ScrollingFrame

    --Create and sort the tests.
    local TestInstances = {}
    for _,TestModule in pairs(Tests:GetChildren()) do
        if TestModule:IsA("ModuleScript") and TestModule.Name ~= "BaseTest" then
            table.insert(TestInstances,require(TestModule).new())
        end
    end
    table.sort(TestInstances,function(a,b)
        return a.Name < b.Name
    end)

    --Create the views.
    for _,Test in pairs(TestInstances) do
        TestView.new(Test,ScrollingFrame)
    end
end



return TestListView