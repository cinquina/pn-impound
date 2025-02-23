Framework = {}

if Config.Framework == "qbx" or Config.Framework == "qbcore" then
    Framework.FULLNAME_QUERY = 'SELECT `firstname`, `lastname` FROM `players` WHERE `citizenid` = ? LIMIT 1'
    Framework.IMPOUNDED_VEHICLES_QUERY = 'SELECT * FROM `player_vehicles` WHERE `state = 2`'
    Framework.IMPOUND_VEHICLE_QUERY = 'UPDATE `player_vehicles` SET `state` = 2 WHERE `plate` = ?'
    Framework.UNIMPOUND_VEHICLE_QUERY = 'UPDATE `player_vehicles` SET `state` = 0 WHERE `plate` = ?'
elseif Config.Framework == "esx" then
    Framework.FULLNAME_QUERY = 'SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = ? LIMIT 1'
    Framework.IMPOUNDED_VEHICLES_QUERY = 'SELECT * FROM `owned_vehicles` WHERE `stored` = 2'
    Framework.IMPOUND_VEHICLE_QUERY = 'UPDATE `owned_vehicles` SET `stored` = 2 WHERE `plate` = ?'
    Framework.UNIMPOUND_VEHICLE_QUERY = 'UPDATE `owned_vehicles` SET `stored` = 0 WHERE `plate` = ?'
else
    print("Unsupported framework. Change it in Config.Framework")
end