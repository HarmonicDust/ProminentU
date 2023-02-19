local env = {
    AvailableServices = {
        NotificationService = import("Modules/Services/Notification.lua"),
        SpecService = import("Modules/Services/Spec.lua"),
        VehicleService = import("Modules/Services/Vehicle.lua"),
		ConfirmationService = import("Modules/Services/Confirmation.lua"),
        NilService = {}
    },
	signal = import("Modules/Std/Signal.lua"),
	loaded = true
}

env.GetService = function(self,Service)
	return self.AvailableServices[Service] or self.AvailableServices.NilService
end

setmetatable(env.AvailableServices.NilService, {
	__index = function(t,i)
		return print(string.format("Attempted to index %s with NilService"), type(i))
	end,
})

setmetatable(env, {
	__index = function(t,i)
		return env:GetService("NilService")
	end,
})

return env