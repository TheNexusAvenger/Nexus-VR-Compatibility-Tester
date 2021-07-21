--[[
TheNexusAvenger

Displays the results of a test.
--]]

local VIEW_ASPECT_RATIO = 8
local ICON_TO_POSITION = {
    NONE = Vector2.new(512,0),
    INFO = Vector2.new(0,512),
    WARNING = Vector2.new(512,512),
    ERROR = Vector2.new(512,512),
}
local ICON_TO_COLOR = {
    ERROR = Color3.new(255/255,0,0),
    WARNING = Color3.new(255/255,170/255,0),
    INFO = Color3.new(0,170/255,255/255),
    NONE = Color3.new(0,170/255,0),
}



local NexusInstance = require(script.Parent.Parent:WaitForChild("NexusInstance"):WaitForChild("NexusInstance"))

local TestView = NexusInstance:Extend()
TestView:SetClassName("TestView")



--[[
Creates the view.
--]]
function TestView:__new(Test,Parent)
    self:InitializeSuper()
    self.Test = Test

    --Create the frames.
    local Container = Instance.new("Frame")
    Container.BackgroundTransparency = 0.5
    Container.BackgroundColor3 = Color3.new(0,0,0)
    Container.Size = UDim2.new(1,-12,1/VIEW_ASPECT_RATIO,0)
    Container.SizeConstraint = Enum.SizeConstraint.RelativeXX
    Container.Parent = Parent
    self.Container = Container

    local ContainerUICorner = Instance.new("UICorner")
    ContainerUICorner.CornerRadius = UDim.new(0.1,0)
    ContainerUICorner.Parent = Container

    local Icon = Instance.new("ImageLabel")
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0.1/VIEW_ASPECT_RATIO,0,0.1,0)
    Icon.Size = UDim2.new(0.8,0,0.8,0)
    Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Icon.Name = "Icon"
    Icon.Image = "http://www.roblox.com/asset/?id=7131587590"
    Icon.ImageRectSize = Vector2.new(512,512)
    Icon.Parent = Container
    self.Icon = Icon

    local IssueText = Instance.new("TextLabel")
    IssueText.BackgroundTransparency = 1
    IssueText.Size = UDim2.new(1 - (2.1/VIEW_ASPECT_RATIO),0,0.6,0)
    IssueText.Position = UDim2.new(1.05/VIEW_ASPECT_RATIO,0,0.05,0)
    IssueText.Name = "IssueText"
    IssueText.Font = Enum.Font.SourceSansBold
    IssueText.TextColor3 = Color3.new(1,1,1)
    IssueText.TextStrokeColor3 = Color3.new(0,0,0)
    IssueText.TextStrokeTransparency = 0
    IssueText.TextScaled = true
    IssueText.TextXAlignment = Enum.TextXAlignment.Left
    IssueText.TextTruncate = Enum.TextTruncate.AtEnd
    IssueText.Parent = Container
    self.IssueText = IssueText

    local StatusText = Instance.new("TextLabel")
    StatusText.BackgroundTransparency = 1
    StatusText.Size = UDim2.new(1 - (2.1/VIEW_ASPECT_RATIO),0,0.4,0)
    StatusText.Position = UDim2.new(1.05/VIEW_ASPECT_RATIO,0,0.55,0)
    StatusText.Name = "IssueText"
    StatusText.Font = Enum.Font.SourceSansBold
    StatusText.TextColor3 = Color3.new(1,1,1)
    StatusText.TextStrokeColor3 = Color3.new(0,0,0)
    StatusText.TextStrokeTransparency = 0
    StatusText.TextScaled = true
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.TextTruncate = Enum.TextTruncate.AtEnd
    StatusText.Parent = Container
    self.StatusText = StatusText

    local InfoButton = Instance.new("TextButton")
    InfoButton.BackgroundColor3 = Color3.new(0,170/255,255/255)
    InfoButton.Name = "Info"
    InfoButton.Size = UDim2.new(0.7,0,0.7,0)
    InfoButton.Position = UDim2.new(1 - (0.85/VIEW_ASPECT_RATIO),0,0.15,0)
    InfoButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    InfoButton.Text = "?"
    InfoButton.Font = Enum.Font.SourceSansBold
    InfoButton.TextColor3 = Color3.new(1,1,1)
    InfoButton.TextStrokeColor3 = Color3.new(0,0,0)
    InfoButton.TextStrokeTransparency = 0
    InfoButton.TextScaled = true
    InfoButton.Parent = Container
    self.InfoButton = InfoButton

    local InfoButtonUICorner = Instance.new("UICorner")
    InfoButtonUICorner.CornerRadius = UDim.new(0.2,0)
    InfoButtonUICorner.Parent = InfoButton

    --Update the test information.
    self.Test.Changed:Connect(function()
        self:Update()
    end)
    self:Update()
end

--[[
Updates the view.
--]]
function TestView:Update()
    self.Icon.ImageRectOffset = ICON_TO_POSITION[self.Test.Icon] or Vector2.new(0,0)
    self.Icon.ImageColor3 = ICON_TO_COLOR[self.Test.Icon] or Color3.new(0.8,0.8,0.8)
    self.IssueText.Name = self.Test.Name
    self.IssueText.Text = self.Test.Name
    self.StatusText.Text = self.Test.Status
    self.StatusText.TextColor3 = ICON_TO_COLOR[self.Test.Icon] or Color3.new(0.8,0.8,0.8)
end



return TestView