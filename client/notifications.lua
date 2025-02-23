function Notify(message, type)
    lib.notify({
        description = message,
        type = type or "info"
    })
    -- You can also use your notification, if you need help for integration join our discord
    -- EXAMPLES:
    -- ESX.ShowNotification(message, type)
    -- QBCore.Functions.Notify(messages, type, 5000)
end

RegisterNetEvent('pn-impound:notify', Notify)