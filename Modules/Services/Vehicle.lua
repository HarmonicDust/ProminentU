local Main = require(game:GetService("ReplicatedStorage").Game.Vehicle)
Main.Packet = function()
    local Packet = require(game:GetService("ReplicatedStorage").Game.Vehicle).GetLocalVehiclePacket()
    if Packet then
        return Packet
    end
end

return Main