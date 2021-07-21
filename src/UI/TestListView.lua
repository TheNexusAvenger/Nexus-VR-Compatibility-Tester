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

    local InfoContainer = Instance.new("Frame")
    InfoContainer.BackgroundTransparency = 0.5
    InfoContainer.BackgroundColor3 = Color3.new(0,0,0)
    InfoContainer.AnchorPoint = Vector2.new(0.5,0)
    InfoContainer.Position = UDim2.new(0.5,0,1,0)
    InfoContainer.Size = UDim2.new(0.6,0,0.3,0)
    InfoContainer.SizeConstraint = Enum.SizeConstraint.RelativeYY
    InfoContainer.Parent = ScreenGui
    self.InfoContainer = InfoContainer

    local InfoContainerUICorner = Instance.new("UICorner")
    InfoContainerUICorner.CornerRadius = UDim.new(0.05,0)
    InfoContainerUICorner.Parent = InfoContainer

    local InfoHeaderText = Instance.new("TextLabel")
    InfoHeaderText.BackgroundTransparency = 1
    InfoHeaderText.Size = UDim2.new(0.94,0,0.175,0)
    InfoHeaderText.Position = UDim2.new(0.03,0,0,0)
    InfoHeaderText.Name = "InfoHeaderText"
    InfoHeaderText.Font = Enum.Font.SourceSansBold
    InfoHeaderText.TextColor3 = Color3.new(1,1,1)
    InfoHeaderText.TextStrokeColor3 = Color3.new(0,0,0)
    InfoHeaderText.TextStrokeTransparency = 0
    InfoHeaderText.TextScaled = true
    InfoHeaderText.TextXAlignment = Enum.TextXAlignment.Left
    InfoHeaderText.TextTruncate = Enum.TextTruncate.AtEnd
    InfoHeaderText.Parent = InfoContainer
    self.InfoHeaderText = InfoHeaderText

    local InfoMainText = Instance.new("TextLabel")
    InfoMainText.BackgroundTransparency = 1
    InfoMainText.Size = UDim2.new(0.96,0,0.825,0)
    InfoMainText.Position = UDim2.new(0.02,0,0.175,0)
    InfoMainText.Name = "InfoMainText"
    InfoMainText.Font = Enum.Font.SourceSansBold
    InfoMainText.TextColor3 = Color3.new(0.9,0.9,0.9)
    InfoMainText.TextStrokeColor3 = Color3.new(0,0,0)
    InfoMainText.TextStrokeTransparency = 0
    InfoMainText.TextSize = InfoContainer.AbsoluteSize.Y * 0.1
    InfoMainText.TextWrapped = true
    InfoMainText.TextXAlignment = Enum.TextXAlignment.Left
    InfoMainText.TextYAlignment = Enum.TextYAlignment.Top
    InfoMainText.Parent = InfoContainer
    self.InfoMainText = InfoMainText

    InfoContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        InfoMainText.TextSize = InfoContainer.AbsoluteSize.Y * 0.1
    end)

    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.AnchorPoint = Vector2.new(1,0)
    ButtonContainer.Size = UDim2.new(0.175,0,0.175,0)
    ButtonContainer.Position = UDim2.new(1,0,0,0)
    ButtonContainer.SizeConstraint = Enum.SizeConstraint.RelativeYY
    ButtonContainer.Parent = InfoContainer

    local ToggleInfoViewButton = Instance.new("TextButton")
    ToggleInfoViewButton.BackgroundColor3 = Color3.new(0,170/255,255/255)
    ToggleInfoViewButton.Name = "ToggleView"
    ToggleInfoViewButton.Size = UDim2.new(0.8,0,0.8,0)
    ToggleInfoViewButton.Position = UDim2.new(-0.8,0,0.1,0)
    ToggleInfoViewButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    ToggleInfoViewButton.Text = ">"
    ToggleInfoViewButton.Font = Enum.Font.SourceSansBold
    ToggleInfoViewButton.TextColor3 = Color3.new(1,1,1)
    ToggleInfoViewButton.TextStrokeColor3 = Color3.new(0,0,0)
    ToggleInfoViewButton.TextStrokeTransparency = 0
    ToggleInfoViewButton.TextScaled = true
    ToggleInfoViewButton.Parent = ButtonContainer
    self.ToggleInfoViewButton = ToggleInfoViewButton

    local ToggleInfoViewButtonUICorner = Instance.new("UICorner")
    ToggleInfoViewButtonUICorner.CornerRadius = UDim.new(0.2,0)
    ToggleInfoViewButtonUICorner.Parent = ToggleInfoViewButton

    local CloseInfoViewButton = Instance.new("TextButton")
    CloseInfoViewButton.BackgroundColor3 = Color3.new(170/255,0,0)
    CloseInfoViewButton.Name = "ToggleView"
    CloseInfoViewButton.Size = UDim2.new(0.8,0,0.8,0)
    CloseInfoViewButton.Position = UDim2.new(0.1,0,0.1,0)
    CloseInfoViewButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    CloseInfoViewButton.Text = "X"
    CloseInfoViewButton.Font = Enum.Font.SourceSansBold
    CloseInfoViewButton.TextColor3 = Color3.new(1,1,1)
    CloseInfoViewButton.TextStrokeColor3 = Color3.new(0,0,0)
    CloseInfoViewButton.TextStrokeTransparency = 0
    CloseInfoViewButton.TextScaled = true
    CloseInfoViewButton.Parent = ButtonContainer
    self.CloseInfoViewButton = CloseInfoViewButton

    local CloseInfoViewButtonUICorner = Instance.new("UICorner")
    CloseInfoViewButtonUICorner.CornerRadius = UDim.new(0.2,0)
    CloseInfoViewButtonUICorner.Parent = CloseInfoViewButton

    --Connect the buttons.
    local DB = true
    ToggleInfoViewButton.MouseButton1Down:Connect(function()
        if not DB or not self.CurrentInfoTest then return end
        DB = false
        if self.CurrentInfoTest.InfoView == "PROBLEM" then
            self.CurrentInfoTest.InfoView = "SOLUTION"
            self.InfoMainText.Text = self.CurrentInfoTest.SolutionText
            self.ToggleInfoViewButton.Text = "<"
        elseif self.CurrentInfoTest.InfoView == "SOLUTION" then
            self.CurrentInfoTest.InfoView = "PROBLEM"
            self.InfoMainText.Text = self.CurrentInfoTest.ProblemText
            self.ToggleInfoViewButton.Text = ">"
        end
        DB = true
    end)
    CloseInfoViewButton.MouseButton1Down:Connect(function()
        if not DB or not self.CurrentInfoTest then return end
        DB = false
        self:ShowTestInfo(nil)
        DB = true
    end)

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
        local View = TestView.new(Test,ScrollingFrame)
        View.InfoButton.MouseButton1Down:Connect(function()
            if not DB then return end
            DB = false
            if self.CurrentInfoTest ~= Test then
                self:ShowTestInfo(Test)
            else
                self:ShowTestInfo(nil)
            end
            DB = true
        end)
    end
end

function TestListView:ShowTestInfo(Test)
    --Hide the current test.
    if self.CurrentInfoTest then
        self.CurrentInfoTest.Icon = "NONE"
    end
    self.CurrentInfoTest = Test
    if not Test then
        self.InfoContainer:TweenPosition(UDim2.new(0.5,0,1,0),"InOut","Quad",0.25,true)
        return
    end

    --Set the initial info of the test.
    self.InfoContainer:TweenPosition(UDim2.new(0.5,0,0.675,0),"InOut","Quad",0.25,true)
    self.InfoHeaderText.Text = "Why is this a problem?"
    self.InfoMainText.Text = Test.ProblemText
    self.ToggleInfoViewButton.Text = ">"
    self.ToggleInfoViewButton.Visible = (Test.SolutionText ~= "")
    Test.InfoView = "PROBLEM"
end



return TestListView