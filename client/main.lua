CreateThread(function()
    while not Framework.IsPlayerLoaded() do
        Wait(500)
    end
    LoadMarkers(Framework.GetPlayerJob().name)
end)

AddEventHandler(Framework.LOADED_EVENT, function()
    local job = Framework.GetPlayerJob()
    if job then
        LoadMarkers(job.name)
    end
end)

RegisterNetEvent(Framework.JOB_CHANGE_EVENT, function()
    local job = Framework.GetPlayerJob()
    if job then
        LoadMarkers(job.name)
    end
end)

RegisterNetEvent('pn-impound:client:setProperties', function(vehicle, props)
    while not DoesEntityExist(NetworkGetEntityFromNetworkId(vehicle)) do
        Wait(500)
    end
    lib.setVehicleProperties(NetworkGetEntityFromNetworkId(vehicle), props)
end)
