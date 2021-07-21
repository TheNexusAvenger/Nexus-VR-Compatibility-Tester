--[[
TheNexusAvenger

Data for a manual test for testing gamepads.
--]]

return {
    Name = "Gamepad Support",
    ProblemText = "Gamepads use different buttons compared to other inputs. Some developers only support keyboard inputs and ignore gamepad inputs.",
    SolutionText = "For prompts, use ProximityPrompts instead of custom prompts. For 2D UIs, make sure they can be interacted with mouse inputs or gamepad inputs.",
}