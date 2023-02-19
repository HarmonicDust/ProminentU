local ProximityPromptService = game:GetService("ProximityPromptService")
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

getgenv().env = nil
getgenv().import = import

if game.PlaceId == 606849621 then
    getgenv().env = import("Modules/Services/Handler.lua")
    print("[ProminentU]: Environment loaded")

    import("Modules/Hooks/Notification.lua")
    import("Modules/Hooks/Spec.lua")
    print("[ProminentU]: Hooks loaded")
end
if not next(env) or not env then
    getgenv().env.loaded = false
    warn("[ProminentU]: There was an error while loading the environment.")
end

setreadonly(env,true)