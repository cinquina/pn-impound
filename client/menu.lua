function OpenComputerMainMenu(filter)
    local database = lib.callback.await("pn-impound:getImpoundedVehicles", false)
    local translation = Config.Translation
    local options = {
        {
            title = filter and translation["filter_title_current"]:format(filter) or translation["filter_title"],
            description = filter and translation["filter_description_remove"] or translation["filter_description_add"],
            icon = filter and "xmark" or "fa-solid fa-magnifying-glass",
            onSelect = function()
                if filter then
                    return OpenComputerMainMenu()
                end
                local input = lib.inputDialog(translation["filter_input"], {
                    { type = 'input', label = translation["filter_input_label"], description = translation["filter_input_description"], required = true, icon = "fa-solid fa-magnifying-glass" },
                })
                if input and input[1] then
                    OpenComputerMainMenu(input[1])
                end
            end
        }
    }

    local storedPlayerNames = {}

    DebugPrint(("Got %s vehicles"):format(#database))

    for _, data in pairs(database) do
        if not storedPlayerNames[data.owner] then
            storedPlayerNames[data.owner] = lib.callback.await("pn-impound:getPlayerName", false, data.owner)
        end

        if filter then DebugPrint(("Filtering with filter ^5'%s'^7"):format(filter)) end

        local loweredFilter = filter and filter:lower()
        if not filter or (data.plate:lower():find(loweredFilter) or storedPlayerNames[data.owner]:lower():find(loweredFilter)) then
            local props = json.decode(data.props or data.vehicle)
            local vehicleHash = props.model or data.hash
            options[#options + 1] = {
                title = ("%s - %s"):format(GetDisplayNameFromVehicleModel(vehicleHash), data.plate),
                description = translation["unimpound_selection"],
                icon = "car",
                arrow = true,
                onSelect = function()
                    TriggerServerEvent("pn-impound:server:unimpoundVehicle", data.plate, props)
                end,
                metadata = {
                    { label = translation["owner"], value = storedPlayerNames[data.owner] },
                    { label = translation["date"],  value = data.last_impounded }
                }
            }
        end
    end

    lib.registerContext({
        id = 'manage_impounded_vehs',
        title = translation["manage_impounded_vehs"],
        options = options
    })
    lib.showContext("manage_impounded_vehs")
end
