local NotificationService = env:GetService("NotificationService")
NotificationService.OnNotificationEvent = env.signal.new()
local OldNew = NotificationService.new

NotificationService.new = newcclosure(function(Main)
    task.spawn(function()
        NotificationService.OnNotificationEvent:Fire(Main.Text, Main.Duration)
    end)
    return OldNew({Text = Main.Text, Duration = Main.Duration})
end)