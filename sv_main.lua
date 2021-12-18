local QBCore = nil
local ESX = nil

local function isAuth(pJob)
    for idx, job in pairs(Config["AuthJobs"]) do
        if pJob == job then
            return true
        end
    end
    return false
end

LoadQBCoreVersion = function()
    RegisterServerEvent("dispatch:svNotify", function(data)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("dispatch:clNotify", xPlayer.PlayerData.source, data, data.dispatchCode, source)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:combatAlert", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:combatAlert", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:gunshotAlert", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:gunshotAlert", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:drugsale", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:drugsale", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:vehiclecrash", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:vehiclecrash", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:vehicletheft", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:vehicletheft", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:houserobbery", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:houserobbery", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jewel", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:jewel", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:blip:jailbreak", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:blip:jailbreak", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:bankwobbewy", function(currentPos)
        for index, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) then
                TriggerClientEvent("un-dispatch:bankwobbewy", xPlayer.PlayerData.source, currentPos)
            end
        end
    end)
end

LoadESXVersion = function()
    RegisterServerEvent("dispatch:svNotify", function(data)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("dispatch:clNotify", xPlayer.source, data, data.dispatchCode, source)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:combatAlert", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:combatAlert", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:gunshotAlert", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:gunshotAlert", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:drugsale", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:drugsale", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:vehiclecrash", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:vehiclecrash", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:vehicletheft", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:vehicletheft", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:houserobbery", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:houserobbery", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jewel", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:jewel", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:blip:jailbreak", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:blip:jailbreak", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:bankwobbewy", function(currentPos)
        for index, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:bankwobbewy", xPlayer.source, currentPos)
            end
        end
    end)
end

LoadNopixelVersion = function()
    RegisterServerEvent("dispatch:svNotify", function(data)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("dispatch:clNotify", xPlayer.source, data, data.dispatchCode, source)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:combatAlert", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:combatAlert", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:gunshotAlert", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:gunshotAlert", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:drugsale", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:drugsale", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:vehiclecrash", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:vehiclecrash", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:vehicletheft", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:vehicletheft", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:houserobbery", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:houserobbery", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jewel", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:jewel", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:blip:jailbreak", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:blip:jailbreak", xPlayer.source, currentPos)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:bankwobbewy", function(currentPos)
        for index, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:bankwobbewy", xPlayer.source, currentPos)
            end
        end
    end)
end

Citizen.CreateThread(function()
    if Config["CoreSettings"]["Core"] == "qbcore" then
        if Config["CoreSettings"]["QBCore"]["QBCoreVersion"] == "new" then
            QBCore = Config["CoreSettings"]["QBCore"]["QBCoreExport"]
        elseif Config["CoreSettings"]["QBCore"]["QBCoreVersion"] == "old" then
            TriggerEvent(Config["CoreSettings"]["QBCore"]["QBUSTrigger"], function(obj) QBCore = obj end)
        end
        LoadQBCoreVersion()
    elseif Config["CoreSettings"]["Core"] == "esx" then
        TriggerEvent(Config["CoreSettings"]["ESX"]["ESXTrigger"], function(obj) ESX = obj end)
        LoadESXVersion()
    elseif Config["CoreSettings"]["Core"] == "npbase" then
        LoadNopixelVersion()
    end
end)