local storedPlayerNames = {}

RegisterNetEvent('pn-impound:server:impoundVehicle', function(netId, plate)
    local src = source
    local playerJob = Framework.GetPlayerJobName(src)
    print(Config.CanImpoundVehicle[playerJob])
    if not Config.CanImpoundVehicle[playerJob] then return DropPlayer(src, "cheater!") end

    local rows = MySQL.update.await(Framework.IMPOUND_VEHICLE_QUERY, { plate })
    if not Config.CanImpoundUnownedVehicles and rows == 0 then
        return TriggerClientEvent('pn-impound:notify', src, Config.Translation["cannot_impound_unowned_vehicles"],
            "error")
    end

    local entity = NetworkGetEntityFromNetworkId(netId)
    DeleteEntity(entity)
    TriggerClientEvent('pn-impound:notify', src, Config.Translation["vehicle_impounded_successfully"], "success")
end)

RegisterNetEvent("pn-impound:server:unimpoundVehicle", function(plate, props)
    local src = source
    local rows = MySQL.update.await(Framework.UNIMPOUND_VEHICLE_QUERY, { plate })
    
    if rows > 0 then
        if Config.SpawnVehicle then
            local model = type(props.model) == "string" and GetHashKey(props.model) or props.model
            local vehicle = CreateVehicleServerSetter(model, "automobile", Config.SpawnVehicle)
            local netId = NetworkGetNetworkIdFromEntity(vehicle)
            TriggerClientEvent("pn-impound:client:setProperties", src, netId, props)
        end
        return TriggerClientEvent('pn-impound:notify', src,
            Config.Translation["vehicle_unimpounded_successfully"]:format(plate), "success")
    end

    return TriggerClientEvent('pn-impound:notify', src, Config.Translation["vehicle_unimpounded_error"]:format(plate),
        "error")
end)

lib.callback.register("pn-impound:getImpoundedVehicles", function()
    local vehicles = MySQL.rawExecute.await(Framework.IMPOUNDED_VEHICLES_QUERY, {})
    DebugPrint(("Formatting dates for %s vehicles"):format(#vehicles))
    for _, data in pairs(vehicles) do
        data.last_impounded = data.last_impounded and os.date(Config.TimeFormat, data.last_impounded / 1000) or "N/A"
    end
    return vehicles
end)

lib.callback.register("pn-impound:getPlayerName", function(source, identifier)
    if storedPlayerNames[identifier] then
        DebugPrint("Player's name already cached")
        return storedPlayerNames[identifier]
    end

    DebugPrint("Player's name not cached, executing db query")
    local query = MySQL.single.await(Framework.FULLNAME_QUERY, {
        identifier
    })
    if not query then return nil end

    local name = ("%s %s"):format(query.firstname, query.lastname)
    storedPlayerNames[identifier] = name
    return name
end)
