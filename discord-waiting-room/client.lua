local function showNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end

RegisterNetEvent("discord-waiting-room:notify", function(playerName)
    local name = playerName or "Okänd spelare"
    local message = Config.NotificationText

    if name ~= "" then
        message = string.format("%s (%s)", Config.NotificationText, name)
    end

    showNotification(message)
end)
