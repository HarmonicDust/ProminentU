ProminentU = {Modules = {
Hooks = {
Notification = function()
local NotificationService = env:GetService("NotificationService")
NotificationService.OnNotificationEvent = env.signal.new()
local OldNew = NotificationService.new

NotificationService.new = newcclosure(function(Main)
    task.spawn(function()
        NotificationService.OnNotificationEvent:Fire(Main.Text, Main.Duration)
    end)
    return OldNew({Text = Main.Text, Duration = Main.Duration})
end)
end,
Spec = function()
local Specs = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction
local OldAdd = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Add
local OldRemove = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Remove
Specs.Added = env.signal.new()
Specs.Removed = env.signal.new()

require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Add = newcclosure(function(Info)
    task.spawn(function()
        Specs.Added:Fire(Info)
    end)
    OldAdd(Info)
end)

require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Remove = newcclosure(function(Part)
    task.spawn(function()
        Specs.Removed:Fire(Part)
    end)
    OldRemove(Part)
end)

return Specs
end,
},
Services = {
Confirmation = function()
return require(game:GetService("ReplicatedStorage").Module.Confirmation)
end,
Handler = function()
local env = {
    AvailableServices = {
        NotificationService = import("Modules/Services/Notification.lua"),
        SpecService = import("Modules/Services/Spec.lua"),
        VehicleService = import("Modules/Services/Vehicle.lua"),
		ConfirmationService = import("Modules/Services/Confirmation.lua"),
        NilService = {}
    },
	signal = import("Modules/Std/Signal.lua"),
	_loaded = true,
}

env.GetService = function(self,Service)
	return self.AvailableServices[Service] or self.AvailableServices.NilService
end

setmetatable(env, {
	__index = function(self,i)
		return self:GetService("NilService")
	end,
})

setmetatable(env.AvailableServices.NilService, {
	__index = function(self,i)
		return print(string.format("Attempted to index %s with NilService"), type(self))
	end,
})

env.IsLoaded = function(self)
	return self._loaded
end

env.Loaded = env.signal.new()
env.LoadingFailed = env.signal.new()

return env
end,
Notification = function()
return require(game:GetService("ReplicatedStorage").Game.Notification)
end,
Spec = function()
return require(game:GetService("ReplicatedStorage").Module.UI).CircleAction
end,
Vehicle = function()
local Main = require(game:GetService("ReplicatedStorage").Game.Vehicle)
Main.Packet = function()
    local Packet = require(game:GetService("ReplicatedStorage").Game.Vehicle).GetLocalVehiclePacket()
    if Packet then
        return Packet
    end
end

return Main
end,
},
Std = {
Signal = function()
return require(game:GetService("ReplicatedStorage").Std.Signal)
end,
},
},
Resources = {
},
}
local Loaded = {}

import = function(dir)
    local Split = string.split(dir, "/")
    local Data = ProminentU

    Split[#Split] = string.split(Split[#Split], ".")[1]

    for i = 1 , #Split  do
        Data = Data[Split[i]]
    end

    if not Loaded[dir] and typeof(Data) == "function" then
        Loaded[dir] = Data()
    elseif typeof(Data) == "table" then
        Loaded[dir] = {}
        for i, v in next, Data do
            Loaded[dir][i] = import(dir .. "/" .. i)
        end
    end

    return Loaded[dir]
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

getgenv().env = {}
getgenv().import = import

if game.PlaceId == 606849621 then
    getgenv().env = import("Modules/Services/Handler.lua")
    print("[ProminentU]: Environment loaded")

    import("Modules/Hooks/Notification.lua")
    import("Modules/Hooks/Spec.lua")
    print("[ProminentU]: Hooks loaded")
end
if not next(env) or not env then
    getgenv().env._loaded = false
    getgenv().env.LoadingFailed:Fire()
else
    env._loaded = true
    env.Loaded:Fire()
end

setreadonly(env,true)