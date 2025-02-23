local cachedZones = {}
local cachedTargets = {}

local function ImpoundVehicle(handle)
    DebugPrint("Getting vehicle's properties")
    local vehicle = lib.getVehicleProperties(handle)
    local netId = VehToNet(handle)
    DebugPrint(("Impounding vehicle with plate %s and netid %s.."):format(vehicle.plate, netId))
    TriggerServerEvent("pn-impound:server:impoundVehicle", netId, string.gsub(vehicle.plate, "^%s*(.-)%s*$", "%1"))
end

local function UnloadMarkers()
    for _, point in pairs(cachedZones) do
        point:remove()
    end
    for _, id in pairs(cachedTargets) do
        exports.ox_target:removeZone(id)
    end
    cachedZones = {}
    cachedTargets = {}
end

function LoadMarkers(jobName)
    UnloadMarkers()

    if Config.CanImpoundVehicle[jobName] then
        for _, points in pairs(Config.ImpoundZones) do
            cachedZones[#cachedZones + 1] = lib.zones.poly({
                points = points,
                debug = Config.Debug,
                onEnter = function()
                    if cache.vehicle then lib.showTextUI(Config.Translation["impound_vehicle_textui"]) end
                end,
                onExit = lib.hideTextUI,
                inside = function()
                    if IsControlJustPressed(0, 38) and cache.vehicle then
                        ImpoundVehicle(cache.vehicle)
                    end
                end
            })
        end
    end

    if Config.CanUseComputer[jobName] then
        for _, sphereData in pairs(Config.Computers) do
            sphereData.debug = Config.Debug
            sphereData.options = {
                {
                    name = "access_computer",
                    label = Config.Translation["access_to_computer"],
                    icon = "fa-solid fa-database",
                    onSelect = function()
                        OpenComputerMainMenu()
                    end
                }
            }
            cachedTargets[#cachedTargets + 1] = exports.ox_target:addSphereZone(sphereData)
        end
    end
end

if not Config.Target then return end

local function CheckZones(coords)
    for _, zone in pairs(cachedZones) do
        if zone:contains(coords) then
            return true
        end
    end
    return false
end

exports.ox_target:addGlobalVehicle({
    {
        name = "impound_vehicle",
        label = "Impound Vehicle",
        icon = "fas fa-car-side",
        canInteract = function(handle)
            if Config.TargetOnImpoundZone then
                return CheckZones(GetEntityCoords(handle))
            end
            return true
        end,
        onSelect = function(data)
            ImpoundVehicle(data.entity)
        end
    }
})
