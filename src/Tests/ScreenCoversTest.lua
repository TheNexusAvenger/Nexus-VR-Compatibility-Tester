--[[
TheNexusAvenger

Test for ScreenGuis covering the screen.
--]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local BaseTest = require(script.Parent:WaitForChild("BaseTest"))

local ScreenCoversTest = BaseTest:Extend()
ScreenCoversTest:SetClassName("ScreenCoversTest")



--[[
Creates the test.
--]]
function ScreenCoversTest:__new()
    self:InitializeSuper()

    --Set up the initial state.
    self.Name = "Screen Covers"
    self.Icon = "NONE"
    self.Status = "Not Detected"
    self.ProblemText = "Covering the screen isn't effective for VR users because ScreenGuis appear in front of the user. They just appear as a random square in front."
    self.SolutionText = "Remove the main cover and use either a BlurEffect or ColorCorrectionEffect to mask the content."
    self.Events = {}

    --Connect ScreenGuis in PlayerGui.
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    PlayerGui.DescendantRemoving:Connect(function(Ins)
        if not self.Events[Ins] then return end
        for _,Event in pairs(self.Events[Ins]) do
            Event:Disconnect()
        end
        self.Events[Ins] = nil
    end)
    PlayerGui.DescendantAdded:Connect(function(Ins)
        if self.Events[Ins] then return end
        self:ConnectScreenGui(Ins)
    end)
    for _,Ins in pairs(PlayerGui:GetDescendants()) do
        self:ConnectScreenGui(Ins)
    end

    --Connect showing the demo.
    self:GetPropertyChangedSignal("InfoView"):Connect(function()
        if self.InfoView == "PROBLEM" or self.InfoView == "SOLUTION" then
            if not self.DemoPart then
                local DemoPart = Instance.new("Part")
                DemoPart.Transparency = 1
                DemoPart.CanCollide = false
                DemoPart.Anchored = true
                DemoPart.CFrame = Workspace.CurrentCamera.CFrame * CFrame.new(0,0,-15) * CFrame.Angles(0,math.pi,0)
                DemoPart.Size = Vector3.new(10,10,0)
                DemoPart.Parent = Workspace.CurrentCamera
                self.DemoPart = DemoPart

                local DemoSurfaceGui = Instance.new("SurfaceGui")
                DemoSurfaceGui.CanvasSize = Vector2.new(500,500)
                DemoSurfaceGui.Adornee = DemoPart
                DemoSurfaceGui.AlwaysOnTop = true
                DemoSurfaceGui.Parent = DemoPart

                local DemoCover = Instance.new("Frame")
                DemoCover.BackgroundColor3 = Color3.new(0,0,0)
                DemoCover.BackgroundTransparency = 0
                DemoCover.BorderSizePixel = 0
                DemoCover.Size = UDim2.new(1,0,1,0)
                DemoCover.Parent = DemoSurfaceGui
                self.DemoCover = DemoCover

                local DemoLogo = Instance.new("ImageLabel")
                DemoLogo.BackgroundTransparency = 1
                DemoLogo.Size = UDim2.new(0.5,0,0.5,0)
                DemoLogo.Position = UDim2.new(0.25,0,0.25,0)
                DemoLogo.Image = "http://www.roblox.com/asset/?id=5221022956"
                DemoLogo.Parent = DemoSurfaceGui
            end
            self.DemoCover.Visible = (self.InfoView == "PROBLEM")
        else
            if self.DemoPart then
                self.DemoPart:Destroy()
                self.DemoPart = nil
            end
        end

        if self.InfoView == "SOLUTION" then
            if not self.DemoBlur then
                local DemoBlur = Instance.new("BlurEffect")
                DemoBlur.Parent = Lighting
                self.DemoBlur = DemoBlur
            end
        else
            if self.DemoBlur then
                self.DemoBlur:Destroy()
                self.DemoBlur = nil
            end
        end
    end)
end

--[[
Connects a ScreenGui.
--]]
function ScreenCoversTest:ConnectScreenGui(ScreenGui)
    if not ScreenGui:IsA("ScreenGui") then return end

    --[[
    Checks the ScreenGui.
    --]]
    local function CheckScreenGui()
        --Return if the state is already set.
        if self.Icon == "INFO" then return end

        --Check if a frame covers the screen and set the state if one does.
        local AbsoluteSize = ScreenGui.AbsoluteSize
        for _,Frame in pairs(ScreenGui:GetDescendants()) do
            if Frame:IsA("GuiObject") then
                local FrameAbsoluteSize,FrameAbsolutePosition = Frame.AbsoluteSize,Frame.AbsolutePosition
                if Frame.BackgroundTransparency < 1 and FrameAbsolutePosition.X <= 0 and FrameAbsolutePosition.Y <= 0 and FrameAbsolutePosition.X + FrameAbsoluteSize.X >= AbsoluteSize.X and FrameAbsolutePosition.Y + FrameAbsoluteSize.Y >= AbsoluteSize.Y then
                    self.Icon = "INFO"
                    self.Status = "Problem Detected"
                    break
                end
            end
        end
    end

    --Connect the events.
    self.Events[ScreenGui] = {}
    table.insert(self.Events[ScreenGui],ScreenGui.DescendantAdded:Connect(function(Ins)
        if not Ins:IsA("GuiObject") then return end
        table.insert(self.Events[ScreenGui],Ins:GetPropertyChangedSignal("AbsoluteSize"):Connect(CheckScreenGui))
        CheckScreenGui()
    end))
    CheckScreenGui()
end



return ScreenCoversTest