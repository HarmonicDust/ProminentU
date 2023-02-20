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