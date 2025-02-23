Config = {}

Config.Framework = "esx" -- esx, qbx, qbcore

Config.Debug = false

-- use target
Config.Target = true -- ox_target, qtarget is available, do not change since ox_target already doesnt the work

-- for undriveable vehicles, if true checks if it is on impound zone(s) before giving the option
Config.TargetOnImpoundZone = true

-- jobs that have access to impound markers
Config.CanImpoundVehicle = {
    ["unemployed"] = true
}

-- if player can impound non-owned vehicles
Config.CanImpoundUnownedVehicles = true

-- jobs that have access to the computer to unimpound vehicles
Config.CanUseComputer = {
    ["unemployed"] = true
}

-- impound zones
Config.ImpoundZones = {
    {
        vec3(497.0, -1323.0, 29.0),
        vec3(490.0, -1324.0, 29.0),
        vec3(491.0, -1336.0, 29.0),
        vec3(500.0, -1335.0, 29.0),
    }, 
}

-- computers
Config.Computers = {
    {
        coords = vec3(471.4666, -1310.9898, 29.2375),
        radius = 0.5,
    }
}

-- spawn vehicles zone, set Config.SpawnVehicle = nil to disable.
Config.SpawnVehicle = vec4(479.9035, -1317.9496, 29.2036, 294.5013)

-- time formatting, see https://www.lua.org/pil/22.1.html for reference.
Config.TimeFormat = "%d/%m/%y %H:%M"

-- translation
Config.Translation = {
    ["impound_vehicle_textui"] = "[E] - Impound Vehicle",
    ["access_to_computer"] = "Access to the computer",
    ["unimpound_selection"] = "Click here to unimpound this vehicle",
    ["manage_impounded_vehs"] = "Manage Impounded Vehicles",
    ["owner"] = "Owner",
    ["date"] = "Date",
    ["filter_title"] = "Search with filter",
    ["filter_title_current"] = "Current filter: '%s'",
    ["filter_description_remove"] = "Click here to remove filter",
    ["filter_description_add"] = "Click here to filter for owner's name or plate",
    ["filter_input"] = "Filter",
    ["filter_input_label"] = "Plate/Name",
    ["filter_input_description"] = "Filter for plate or owner's name",
    ["vehicle_unimpounded_successfully"] = "You successfully unimpounded vehicle with plate %s.",
    ["vehicle_unimpounded_error"] = "Error while unimpounding vehicle with plate %s.",
    ["vehicle_impounded_successfully"] = "You successfully impounded this vehicle",
    ["cannot_impound_unowned_vehicles"] = "You cannot impound unowned vehicles"
}
