![ProminentU!](Resources/LogoHorizontal.png)
# ProminentU is a package that looks like LuaU, for jailbreak. It uses an existing module called signal that does all the magic. Made by Harms#0001
Here are prime examples of the usage
# Example of when entering & leaving a vehicle:
```lua
-- Data: Packet
env:GetService("VehicleService").OnVehicleEntered:Connect(function(Data)
    print(Data.Model)
    if not Data.Passenger then
        print("Previous driver of this vehicle was: " .. tostring(Data.LastDriver))
    end
end)
-- Data: Packet
env:GetService("VehicleService").OnVehicleJumpExited:Connect(function(Data)
    print("Exited " .. Data.Model.Name .. ".")
end)
```
# Example of the player trying to escape, but keeps dying as soon as they do (rude):
```lua
-- Text: Notification text
-- Duration: Duration of notification
env:GetService("NotificationService").OnNotificationEvent:Connect(function(Text, Duration)
    if Text:lower():find("you escaped!") then
        game:GetService("Players").LocalPlayer.Character:BreakJoints()
        env:GetService("NotificationService").new({Text = "You're not escaping today!!", Duration = 2})
    end
end)
```
# Example of the player encountering another player with the arrest spec
```lua
-- Info: { ... }
-- Tag: Part
env:GetService("SpecService").Added:Connect(function(Info, Tag)
    if Info.Name == "Arrest" then
        print("Player tried arresting " .. tostring(Info.Part.Parent))
    end
end)
-- Part: Instance
env:GetService("SpecService").Removed:Connect(function(Part)
    print("A circle action / e circle was removed from " .. Part:GetFullName())
end)
```

# How do I use this?
Well, you can use this 2 different ways.
1.) Using HazeI#0001's Modular Compilar plugin & import this entire package in. Here's a simulation of what your mod would look like.
```lua
if game.PlaceId == 606849621 then
    import("Gui/Tabs/VehicleStats.lua")
    import("Gui/Tabs/VehicleData.lua")
    import("Gui/Tabs/BuiltInImporter.lua")
end
import("Packages/ProminentU.lua")
```
2.) Using a loadstring to the `ProminentU/Compiled.lua` file.
```lua
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/HarmonicDust/ProminentU/master/Compiled.lua"))() -- No, you don't have to assign a variable to it.
if not env:IsLoaded() then
    env.Loaded:Wait()
end
local ConfirmationService = env:GetService("ConfirmationService")
local Poll = ConfirmationService.new("Do you like hashbrowns? :3")
Poll.OnYes:Connect(function()
    print("Wooo!!")
end)
Poll.OnNo:Connect(function()
    print(":(((")
end)
```
**Note: There miiiiiight be bugs here & there, dunno tbh I haven't tested much**
Yeah ig that's all there really is to say for devs who would like to use my module, feel free :>