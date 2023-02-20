local Specs = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction
local OldAdd = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Add
local OldRemove = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Remove
Specs.Added = env.signal.new()
Specs.Removed = env.signal.new()

require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Add = newcclosure(function(Info, Tag)
    task.spawn(function()
        Specs.Added:Fire(Info, Tag)
    end)
    OldAdd(Info, Tag)
end)

require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Remove = newcclosure(function(Part)
    task.spawn(function()
        Specs.Removed:Fire(Part)
    end)
    OldRemove(Part)
end)