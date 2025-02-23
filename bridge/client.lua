Framework = {}

if Config.Framework == "qbx" or Config.Framework == "qbcore" then
    local QBCore = exports['qb-core']:GetCoreObject()

    Framework.LOADED_EVENT = "QBCore:Client:OnPlayerLoaded"
    Framework.JOB_CHANGE_EVENT = "QBCore:Client:OnJobUpdate"

    Framework.GetPlayerJob = function()
        local playerData = QBCore.Functions.GetPlayerData()
        if playerData and playerData.job then
            return {
                name = playerData.job.name,
                grade = playerData.job.grade.level or playerData.job.grade,
                label = playerData.job.label
            }
        end
        return nil
    end

    Framework.IsPlayerLoaded = function() 
        return LocalPlayer.state.isLoggedIn
    end

elseif Config.Framework == "esx" then
    local ESX = exports.es_extended:getSharedObject()
    
    Framework.LOADED_EVENT = "esx:playerLoaded"
    Framework.JOB_CHANGE_EVENT = "esx:setJob"

    Framework.GetPlayerJob = function()
        local playerData = ESX.GetPlayerData()
        if playerData and playerData.job then
            return {
                name = playerData.job.name,
                grade = playerData.job.grade,
                label = playerData.job.label
            }
        end
        return nil
    end

    Framework.IsPlayerLoaded = function ()
        return ESX.IsPlayerLoaded and ESX.IsPlayerLoaded()
    end
else
    print("Unsupported framework. Change it in Config.Framework")
end
