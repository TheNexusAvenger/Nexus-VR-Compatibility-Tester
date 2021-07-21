--[[
TheNexusAvenger

Test for SurfaceGuis containing ScrollingFrames.
--]]

local RunService = game:GetService("RunService")

local BaseTest = require(script.Parent:WaitForChild("BaseTest"))

local SurfaceGuiScrollingFrameTest = BaseTest:Extend()
SurfaceGuiScrollingFrameTest:SetClassName("SurfaceGuiScrollingFrameTest")



--[[
Creates the test.
--]]
function SurfaceGuiScrollingFrameTest:__new()
    self:InitializeSuper()

    --Set up the initial state.
    self.Name = "SurfaceGui ScrollingFrames"
    self.Icon = "NONE"
    self.Status = "Not Detected"
    self.ProblemText = "ScrollingFrames in SurfaceGuis are difficult to use in VR, and are also problematic for console and mobile users."
    self.SolutionText = "Not using ScrollingFrames is the recommended approach. Using pages or using auto-scrolling is recommended instead."
    self.SurfaceGuiEvents = {}
    self.SurfaceGuiProblems = {}
    self.Adorns = {}

    --Connect SurfaceGuis in the game.
    game.DescendantRemoving:Connect(function(Ins)
        if not self.SurfaceGuiEvents[Ins] then return end
        for _,Event in pairs(self.SurfaceGuiEvents[Ins]) do
            Event:Disconnect()
        end
        self.SurfaceGuiEvents[Ins] = nil
        self.SurfaceGuiProblems[Ins] = nil
        self:UpdateState()
    end)
    game.DescendantAdded:Connect(function(Ins)
        if self.SurfaceGuiEvents[Ins] then return end
        self:ConnectSurfaceGui(Ins)
    end)
    for _,Ins in pairs(game:GetDescendants()) do
        self:ConnectSurfaceGui(Ins)
    end

    --Connect updating the adorn transparencies.
    RunService.RenderStepped:Connect(function()
        for _,Adorn in pairs(self.Adorns) do
            if Adorn.Adornee then
                Adorn.Size = Adorn.Adornee.Size
                Adorn.Transparency = (self.InfoView == "NONE" and 1 or (math.sin((tick() * 2) % (math.pi * 2)) * 0.5) + 0.5)
            end
        end
    end)
end

--[[
Connects a SurfaceGui.
--]]
function SurfaceGuiScrollingFrameTest:ConnectSurfaceGui(SurfaceGui)
    --Use a pcall to determine the type. game exposes non-usable instances.
    local Worked,Return = pcall(function()
        return SurfaceGui:IsA("SurfaceGui")
    end)
    if not Worked or not Return then return end

    --Connect the events.
    self.SurfaceGuiEvents[SurfaceGui] = {}
    self.SurfaceGuiProblems[SurfaceGui] = {}
    table.insert(self.SurfaceGuiEvents[SurfaceGui],SurfaceGui.DescendantAdded:Connect(function(Ins)
        if not Ins:IsA("ScrollingFrame") then return end
        self.SurfaceGuiProblems[SurfaceGui][Ins] = true
        self:UpdateState()
    end))
    table.insert(self.SurfaceGuiEvents[SurfaceGui],SurfaceGui.DescendantRemoving:Connect(function(Ins)
        if not Ins:IsA("ScrollingFrame") then return end
        self.SurfaceGuiProblems[SurfaceGui][Ins] = nil
        self:UpdateState()
    end))

    --Connect the existing instances.
    for _,Ins in pairs(SurfaceGui:GetDescendants()) do
        if Ins:IsA("ScrollingFrame") then
            self.SurfaceGuiProblems[SurfaceGui][Ins] = true
            self:UpdateState()
        end
    end
end

--[[
Updates the state.
--]]
function SurfaceGuiScrollingFrameTest:UpdateState()
    --Determine the problematic SurfaceGuis.
    local SurfaceGuis = {}
    for SurfaceGui,FrameProblemsMap in pairs(self.SurfaceGuiProblems) do
        for _,_ in pairs(FrameProblemsMap) do
            table.insert(SurfaceGuis,SurfaceGui)
            break
        end
    end

    --Set the state if there is a problematic SurfaceGui and it wasn't set already.
    if #SurfaceGuis > 0 then
        self.Icon = "WARNING"
        self.Status = "Problem Detected"
    else
        self.Icon = "NONE"
        self.Status = "Not Detected"
    end

    --Get the parts to adorn.
    local AdornParts = {}
    local AdornPartsMap = {}
    for _,SurfaceGui in pairs(SurfaceGuis) do
        local Adornee = SurfaceGui.Adornee or (SurfaceGui.Parent and SurfaceGui.Parent:IsA("BasePart") and SurfaceGui.Parent)
        if Adornee and not AdornPartsMap[Adornee] then
            AdornPartsMap[Adornee] = true
            table.insert(AdornParts,Adornee)
        end
    end

    --Create the adorn boxes.
    for _ = #self.Adorns + 1,#AdornParts do
        local BoxAdorn = Instance.new("BoxHandleAdornment")
        BoxAdorn.ZIndex = 0
        BoxAdorn.AlwaysOnTop = true
        BoxAdorn.Color3 = Color3.new(1,0,0)
        BoxAdorn.Parent = script
        table.insert(self.Adorns,BoxAdorn)
    end
    for i,Part in pairs(AdornParts) do
        self.Adorns[i].Adornee = Part
    end
end



return SurfaceGuiScrollingFrameTest