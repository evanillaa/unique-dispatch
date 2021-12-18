Config = {}

Config["AuthJobs"] = {
    "police"
}

Config["CoreSettings"] = {
    ["Core"] = "qbcore", -- Your core | qbcore, esx, npbase
    ["ESX"] = {
        ["ESXTrigger"] = "esx:getSharedObject"
    },
    ["QBCore"] = {
        ["QBCoreVersion"] = "new", -- new = using exports | old = using events
        ["QBCoreExport"] = exports['lg-core']:GetCoreObject(), -- If you are using old qbcore version just remove this line
        ["QBUSTrigger"] = "QBCore:GetObject",
        ["Players_Table"] = "players",
        ["OwnedVehicles_Table"] = "player_vehicles"
    },
    ["NPBase"] = {
        ["CoreName"] = "iconic-fw"
    }
}