local Signal = import("Modules/Std/Signal.lua")
local Loaded = Signal.new()
local LoadingFailed = Signal.new()
if game.PlaceId == 606849621 then
    getgenv().env = import("Modules/Services/Handler.lua")
    print("[ProminentU]: Environment loaded")

    import("Modules/Hooks/Notification.lua")
    print("[ProminentU]: Hooks loaded")
end
if not next(env) or not env then
    getgenv().env.loaded = false
    LoadingFailed:Fire()
else
    Loaded:Fire()
end