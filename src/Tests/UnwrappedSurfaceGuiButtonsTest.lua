--[[
TheNexusAvenger

Test for SurfaceGuis containing unwrapped buttons.
--]]

local BaseTest = require(script.Parent:WaitForChild("BaseTest"))
local ProblemHighlights = require(script.Parent:WaitForChild("Common"):WaitForChild("ProblemHighlights"))

local UnwrappedSurfaceGuiButtonsTest = BaseTest:Extend()
UnwrappedSurfaceGuiButtonsTest:SetClassName("UnwrappedSurfaceGuiButtonsTest")



--[[
Creates the test.
--]]
function UnwrappedSurfaceGuiButtonsTest:__new()
    self:InitializeSuper()

    --Set up the initial state.
    self.Name = "Unwrapped SurfaceGui Buttons"
    self.Icon = "NONE"
    self.Status = "Not Detected"
    self.ProblemText = "Buttons in SurfaceGuis can be very difficult to interact with in VR. Sometimes user interfaces become unusable in VR."
    self.SolutionText = "Wrapping buttons with Nexus VR Core is recommended for button integration."
    self.SurfaceGuiEvents = {}
    self.SurfaceGuiProblems = {}
    self.Highlights = ProblemHighlights.new(self)

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
end

--[[
Connects a SurfaceGui.
--]]
function UnwrappedSurfaceGuiButtonsTest:ConnectSurfaceGui(SurfaceGui)
    --Use a pcall to determine the type. game exposes non-usable instances.
    local Worked,Return = pcall(function()
        return SurfaceGui:IsA("SurfaceGui")
    end)
    if not Worked or not Return then return end

    --Connect the events.
    self.SurfaceGuiEvents[SurfaceGui] = {}
    self.SurfaceGuiProblems[SurfaceGui] = {}
    table.insert(self.SurfaceGuiEvents[SurfaceGui],SurfaceGui.DescendantAdded:Connect(function(Ins)
        if not Ins:IsA("GuiButton") then return end
        self.SurfaceGuiProblems[SurfaceGui][Ins] = true
        self:UpdateState()
    end))
    table.insert(self.SurfaceGuiEvents[SurfaceGui],SurfaceGui.DescendantRemoving:Connect(function(Ins)
        if not Ins:IsA("GuiButton") then return end
        self.SurfaceGuiProblems[SurfaceGui][Ins] = nil
        self:UpdateState()
    end))

    --Connect the existing instances.
    for _,Ins in pairs(SurfaceGui:GetDescendants()) do
        if Ins:IsA("GuiButton") then
            self.SurfaceGuiProblems[SurfaceGui][Ins] = true
            self:UpdateState()
        end
    end

    --Occasionally update the ClickDetectors.
    coroutine.wrap(function()
       while true do
           self:UpdateState()
           wait(0.25)
       end
   end)()
end

--[[
Updates the state.
--]]
function UnwrappedSurfaceGuiButtonsTest:UpdateState()
    --Determine the problematic SurfaceGuis.
    local SurfaceGuis = {}
    local NexusVRCore = self:GetNexusVRCore()
    local NexusWrappedInstance = NexusVRCore and NexusVRCore:GetResource("NexusWrappedInstance")
    for SurfaceGui,FrameProblemsMap in pairs(self.SurfaceGuiProblems) do
        for Frame,_ in pairs(FrameProblemsMap) do
            if (not NexusWrappedInstance or not NexusWrappedInstance.CachedInstances[Frame]) then
                table.insert(SurfaceGuis,SurfaceGui)
                break
            end
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
    self.Highlights.Objects = AdornParts
end



return UnwrappedSurfaceGuiButtonsTest