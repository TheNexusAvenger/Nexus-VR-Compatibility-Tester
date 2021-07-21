--[[
TheNexusAvenger

Highlights problematic parts.
--]]

local RunService = game:GetService("RunService")

local NexusInstance = require(script.Parent.Parent.Parent:WaitForChild("NexusInstance"):WaitForChild("NexusInstance"))

local ProblemHighlights = NexusInstance:Extend()
ProblemHighlights:SetClassName("ProblemHighlights")



--[[
Creates the highlights.
--]]
function ProblemHighlights:__new(Test)
    self:InitializeSuper()
    self.Objects = {}
    self.Adorns = {}
    self.Active = false

    --Connect updating the adorns.
    self:GetPropertyChangedSignal("Objects"):Connect(function()
        for _ = #self.Adorns + 1,#self.Objects do
            local BoxAdorn = Instance.new("BoxHandleAdornment")
            BoxAdorn.ZIndex = 0
            BoxAdorn.AlwaysOnTop = true
            BoxAdorn.Color3 = Color3.new(1,0,0)
            BoxAdorn.Parent = script
            table.insert(self.Adorns,BoxAdorn)
        end
        for i,Part in pairs(self.Objects) do
            self.Adorns[i].Adornee = Part
        end
    end)
    RunService.RenderStepped:Connect(function()
        for _,Adorn in pairs(self.Adorns) do
            if Adorn.Adornee then
                Adorn.Size = Adorn.Adornee.Size
                Adorn.Transparency = (self.Active and (math.sin((tick() * 2) % (math.pi * 2)) * 0.5) + 0.5 or 1)
            end
        end
    end)

    --Connect setting the adorns as active.
    if not Test then return end
    Test:GetPropertyChangedSignal("InfoView"):Connect(function()
        self.Active = (Test.InfoView ~= "NONE")
    end)
end



return ProblemHighlights