--[[
TheNexusAvenger

Test for SurfaceGuis under Workspace that have Selectable
frames. See:
https://devforum.roblox.com/t/vr-immediately-crashes-when-you-try-to-interact-with-any-surface-gui/498889
https://github.com/Elttob/roblox-vr-tracker/issues/2
--]]

local Workspace = game:GetService("Workspace")

local BaseTest = require(script.Parent:WaitForChild("BaseTest"))
local ProblemHighlights = require(script.Parent:WaitForChild("Common"):WaitForChild("ProblemHighlights"))

local SurfaceGuiCrashTest = BaseTest:Extend()
SurfaceGuiCrashTest:SetClassName("SurfaceGuiCrashTest")



--[[
Creates the test.
--]]
function SurfaceGuiCrashTest:__new()
    self:InitializeSuper()

    --Set up the initial state.
    self.Name = "SurfaceGui Crashing"
    self.Icon = "NONE"
    self.Status = "Not Detected"
    self.ProblemText = "SurfaceGuis under Workspace with Selectable GuiObjects cause VR players to crash when looked at."
    self.SolutionText = "There are 3 workarounds:\n1. Move the SurfaceGui under PlayerGui.\n2. Make the GuiObjects unselectable (set Selectable to false).\n3. Use Nexus VR Core with the SurfaceGui."
    self.SurfaceGuiEvents = {}
    self.SurfaceGuiProblems = {}
    self.Adorns = {}
    self.Highlights = ProblemHighlights.new(self)

    --Connect SurfaceGuis in Workspace.
    Workspace.DescendantRemoving:Connect(function(Ins)
        if not self.SurfaceGuiEvents[Ins] then return end
        for _,Event in pairs(self.SurfaceGuiEvents[Ins]) do
            Event:Disconnect()
        end
        self.SurfaceGuiEvents[Ins] = nil
        self.SurfaceGuiProblems[Ins] = nil
        self:UpdateState()
    end)
    Workspace.DescendantAdded:Connect(function(Ins)
        if self.SurfaceGuiEvents[Ins] then return end
        self:ConnectSurfaceGui(Ins)
    end)
    for _,Ins in pairs(Workspace:GetDescendants()) do
        self:ConnectSurfaceGui(Ins)
    end
end

--[[
Connects a SurfaceGui.
--]]
function SurfaceGuiCrashTest:ConnectSurfaceGui(SurfaceGui)
    if not SurfaceGui:IsA("SurfaceGui") then return end

    --Connect the events.
    self.SurfaceGuiEvents[SurfaceGui] = {}
    self.SurfaceGuiProblems[SurfaceGui] = {}
    table.insert(self.SurfaceGuiEvents[SurfaceGui],SurfaceGui.DescendantAdded:Connect(function(Ins)
        if not Ins:IsA("GuiObject") or not self.SurfaceGuiProblems[SurfaceGui] then return end
        if Ins.Selectable then
            self.SurfaceGuiProblems[SurfaceGui][Ins] = true
            self:UpdateState()
        else
            table.insert(self.SurfaceGuiEvents[SurfaceGui],Ins:GetPropertyChangedSignal("Selectable"):Connect(function()
                if Ins.Selectable then
                    self.SurfaceGuiProblems[SurfaceGui][Ins] = true
                    self:UpdateState()
                end
            end))
        end
    end))
    table.insert(self.SurfaceGuiEvents[SurfaceGui],SurfaceGui.DescendantRemoving:Connect(function(Ins)
        if not Ins:IsA("GuiObject") or not self.SurfaceGuiProblems[SurfaceGui] then return end
        self.SurfaceGuiProblems[SurfaceGui][Ins] = nil
        self:UpdateState()
    end))

    --Connect the existing instances.
    for _,Ins in pairs(SurfaceGui:GetDescendants()) do
        if Ins:IsA("GuiObject") then
            if Ins.Selectable then
                self.SurfaceGuiProblems[SurfaceGui][Ins] = true
                self:UpdateState()
            else
                table.insert(self.SurfaceGuiEvents[SurfaceGui],Ins:GetPropertyChangedSignal("Selectable"):Connect(function()
                    if Ins.Selectable then
                        self.SurfaceGuiProblems[SurfaceGui][Ins] = true
                        self:UpdateState()
                    end
                end))
            end
        end
    end
end

--[[
Updates the state.
--]]
function SurfaceGuiCrashTest:UpdateState()
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
        self.Icon = "ERROR"
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



return SurfaceGuiCrashTest