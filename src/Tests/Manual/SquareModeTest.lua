--[[
TheNexusAvenger

Data for a manual test for square UIs.
--]]

local Players = game:GetService("Players")

return {
    Name = "Square View Support",
    ProblemText = "ScreenGuis in VR are displayed as a square in front of the player. User interfaces sometimes get clipped or scale incorrectly.",
    SolutionText = "Testing with square user interfaces as well as portrait user interfaces is recommended.",
    OnInfoViewChanged = function(self,InfoView)
        --Create or hide the black bars.
        if InfoView ~= "NONE" then
            if not self.DemoBlackBars then
                local DemoBlackBars = Instance.new("ScreenGui")
                DemoBlackBars.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
                self.DemoBlackBars = DemoBlackBars

                local OpenViewFrame = Instance.new("Frame")
                OpenViewFrame.BackgroundTransparency = 1
                OpenViewFrame.AnchorPoint = Vector2.new(0.5,0.5)
                OpenViewFrame.Position = UDim2.new(0.5,0,0.5,0)
                OpenViewFrame.Size = UDim2.new(1,0,1,0)
                OpenViewFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
                OpenViewFrame.Parent = DemoBlackBars

                local LeftBlackBarFrame = Instance.new("Frame")
                LeftBlackBarFrame.BorderSizePixel = 0
                LeftBlackBarFrame.BackgroundColor3 = Color3.new(0,0,0)
                LeftBlackBarFrame.AnchorPoint = Vector2.new(1,0)
                LeftBlackBarFrame.Size = UDim2.new(1,0,1,0)
                LeftBlackBarFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
                LeftBlackBarFrame.Parent = OpenViewFrame

                local RightBlackBarFrame = Instance.new("Frame")
                RightBlackBarFrame.BorderSizePixel = 0
                RightBlackBarFrame.BackgroundColor3 = Color3.new(0,0,0)
                RightBlackBarFrame.Position = UDim2.new(1,0,0,0)
                RightBlackBarFrame.Size = UDim2.new(1,0,1,0)
                RightBlackBarFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
                RightBlackBarFrame.Parent = OpenViewFrame
            end
        else
            if self.DemoBlackBars then
                self.DemoBlackBars:Destroy()
                self.DemoBlackBars = nil
            end
        end
    end,
}