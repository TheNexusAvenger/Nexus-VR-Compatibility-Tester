--[[
TheNexusAvenger

Displays a close button for the bottom of the list.
--]]

local VIEW_ASPECT_RATIO = 8

local NexusInstance = require(script.Parent.Parent:WaitForChild("NexusInstance"):WaitForChild("NexusInstance"))

local CloseButtonView = NexusInstance:Extend()
CloseButtonView:SetClassName("CloseButtonView")



--[[
Creates the view.
--]]
function CloseButtonView:__new(Parent)
    self:InitializeSuper()

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

    local CloseButton = Instance.new("TextButton")
    CloseButton.AnchorPoint = Vector2.new(0.5,0.5)
    CloseButton.BackgroundColor3 = Color3.new(170/255,0,0)
    CloseButton.Size = UDim2.new(2,0,0.7,0)
    CloseButton.Position = UDim2.new(0.5,0,0.5,0)
    CloseButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    CloseButton.Name = "Close"
    CloseButton.Text = "Close"
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextColor3 = Color3.new(1,1,1)
    CloseButton.TextStrokeColor3 = Color3.new(0,0,0)
    CloseButton.TextStrokeTransparency = 0
    CloseButton.TextScaled = true
    CloseButton.Parent = Container
    self.CloseButton = CloseButton

    local CloseButtonUICorner = Instance.new("UICorner")
    CloseButtonUICorner.CornerRadius = UDim.new(0.2,0)
    CloseButtonUICorner.Parent = CloseButton
end



return CloseButtonView