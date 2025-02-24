Framework = {}

if Config.Framework == "qbx" or Config.Framework == "qbcore" then
    local QBCore = exports['qb-core']:GetCoreObject()

    Framework.FULLNAME_QUERY = 'SELECT `firstname`, `lastname` FROM `players` WHERE `citizenid` = ? LIMIT 1'
    Framework.IMPOUNDED_VEHICLES_QUERY = 'SELECT * FROM `player_vehicles` WHERE `state = 2`'
    Framework.IMPOUND_VEHICLE_QUERY = 'UPDATE `player_vehicles` SET `state` = 2 WHERE `plate` = ?'
    Framework.UNIMPOUND_VEHICLE_QUERY = 'UPDATE `player_vehicles` SET `state` = 0 WHERE `plate` = ?'

    Framework.GetPlayerJobName = function(source)
        local player = QBCore.Functions.GetPlayer(source)
        if player and player.PlayerData and player.PlayerData.job then
            return player.PlayerData.job.name
        end
        return nil
    end
elseif Config.Framework == "esx" then
    local ESX = exports.es_extended:getSharedObject()

    Framework.FULLNAME_QUERY = 'SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = ? LIMIT 1'
    Framework.IMPOUNDED_VEHICLES_QUERY = 'SELECT * FROM `owned_vehicles` WHERE `stored` = 2'
    Framework.IMPOUND_VEHICLE_QUERY = 'UPDATE `owned_vehicles` SET `stored` = 2 WHERE `plate` = ?'
    Framework.UNIMPOUND_VEHICLE_QUERY = 'UPDATE `owned_vehicles` SET `stored` = 0 WHERE `plate` = ?'

    Framework.GetPlayerJobName = function(source)
        local player = ESX.GetPlayerFromId(source)
        if player and player.job then
            return player.job.name
        end
        return nil
    end
else
    print("Unsupported framework. Change it in Config.Framework")
end
