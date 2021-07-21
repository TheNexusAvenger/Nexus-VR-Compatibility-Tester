--[[
TheNexusAvenger

Data for a manual test for using Camera:GetRenderCFrame().
--]]

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

return {
    Name = "Camera.CFrame Reading",
    ProblemText = "Camera.CFrame may point to a CFrame that does not match the rendered CFrame while in VR. This can result in local effects not moving with the camera as expected.",
    SolutionText = "Instead of reading Camera.CFrame, use Camera:GetRenderCFrame() to ensure the CFrame matches where it rendered.",
    OnInfoViewChanged = function(self,InfoView)
        --Create or hide the parts.
        if InfoView ~= "NONE" then
            if not self.DemoCFramePart then
                local TestPart = Instance.new("Part")
                TestPart.Transparency = 0.5
                TestPart.BrickColor = BrickColor.new("Really red")
                TestPart.Size = Vector3.new(1,1,1)
                TestPart.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position) * CFrame.new(0,0,-10)
                TestPart.Anchored = true
                TestPart.CanCollide = false
                TestPart.Parent = Workspace.CurrentCamera
                self.DemoCFramePart = TestPart
            end
            if not self.DemoGetRenderCFramePart then
                local TestPart = Instance.new("Part")
                TestPart.Transparency = 0.5
                TestPart.BrickColor = BrickColor.new("Lime green")
                TestPart.Size = Vector3.new(1,1,1)
                TestPart.Anchored = true
                TestPart.CanCollide = false
                TestPart.Parent = Workspace.CurrentCamera
                self.DemoGetRenderCFramePart = TestPart

                coroutine.wrap(function()
                    while TestPart.Parent do
                        TestPart.CFrame = Workspace.CurrentCamera.CFrame * CFrame.new(0,0,-10)
                        RunService.RenderStepped:Wait()
                    end
                end)()
            end
        else
            if self.DemoCFramePart then
                self.DemoCFramePart:Destroy()
                self.DemoCFramePart = nil
            end
            if self.DemoGetRenderCFramePart then
                self.DemoGetRenderCFramePart:Destroy()
                self.DemoGetRenderCFramePart = nil
            end
        end
    end,
}