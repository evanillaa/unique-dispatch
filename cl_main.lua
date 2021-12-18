local callID = 0
local playerPed, playerCoords = PlayerPedId(), vec3(0, 0, 0)
local currentVehicle, inVehicle, currentlyArmed, currentWeapon = nil, false, false, `WEAPON_UNARMED`
local QBCore = nil
local ESX = nil
local disableNotis, disableNotifSounds = false, false

local colors = {
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark Silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "Hunter Green",
    [145] = "Metallic Purple",
    [146] = "Metallic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Unknown",
}

local whitelisted = {
    [`WEAPON_STUNGUN`] = true,
    [`WEAPON_SNOWBALL`] = true
}

CreateThread(function()
	while true do
		playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        currentVehicle = GetVehiclePedIsIn(playerPed, false)
        currentWeapon = GetSelectedPedWeapon(playerPed)
        currentlyArmed = IsPedArmed(playerPed, 7) and not whitelisted[currentWeapon]
        if currentVehicle ~= 0 then inVehicle = true elseif inVehicle then inVehicle = false end
		Wait(1000)
	end
end)

local function getCardinalDirectionFromHeading()
    local heading = GetEntityHeading(playerPed)
    if heading >= 315 or heading < 45 then return "North Bound"
    elseif heading >= 45 and heading < 135 then return "West Bound"
    elseif heading >=135 and heading < 225 then return "South Bound"
    elseif heading >= 225 and heading < 315 then return "East Bound" end
end

function GetStreetAndZone()
    local coords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end

local function GetClosestNPC(sentPos, sentDistance, sentType, sentIgnoredPed)
    if sentType == 'combat' then
        local allPeds = GetGamePool('CPed')
        for i = 1, #allPeds do
            local ped = allPeds[i]
            if DoesEntityExist(ped) then
                if ped ~= sentIgnoredPed then
                    local dist = #(GetEntityCoords(ped) - sentPos)
                    if dist < sentDistance then
                        return ped
                    end
                end 
            end
        end
    elseif sentType == 'gunshot' then
        local allPeds = GetGamePool('CPed')
        for i = 1, #allPeds do
            local ped = allPeds[i]
            if DoesEntityExist(ped) then
                local dist = #(GetEntityCoords(ped) - sentPos)
                if dist < sentDistance then
                    if (GetPedAlertness(ped) > 0) and not IsPedAimingFromCover(ped) and not IsPedBeingStunned(ped, 0) and not IsPedDeadOrDying(ped, 1) and IsPedHuman(ped) and not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) and not IsPedShooting(ped) and not IsPedAPlayer(ped) then
                        TaskUseMobilePhoneTimed(ped, 5000)
                        return ped
                    end
                end
            end
        end
    elseif sentType == 'armed' then
        local allPeds = GetGamePool('CPed')
        for i = 1, #allPeds do
            local ped = allPeds[i]
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                local dist = #(GetEntityCoords(ped) - sentPos)
                if dist < 50.0 and math.random(10) > 4 then
                    if not IsPedAimingFromCover(ped) and not IsPedBeingStunned(ped, 0) and not IsPedDeadOrDying(ped, 1) and IsPedHuman(ped) and not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) and not IsPedShooting(ped) then
                        TaskUseMobilePhoneTimed(ped, 5000)
                        return ped
                    end
                end
            end
        end
    else
        local allPeds = GetGamePool('CPed')
        for i = 1, #allPeds do
            local ped = allPeds[i]
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                local dist = #(GetEntityCoords(ped) - sentPos)
                if dist < sentDistance then
                    return ped
                end
            end
        end
    end
end

local function GetPedInFront()	
	local plyPed = playerPed
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

local function GetVehicleDescription(sentVehicle)
    if not sentVehicle or sentVehicle == nil then
        local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not DoesEntityExist(currentVehicle) then
            return
        end
    elseif sentVehicle then
        currentVehicle = sentVehicle
    end
    plate = GetVehicleNumberPlateText(currentVehicle)
    make = GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle))
    color1, color2 = GetVehicleColours(currentVehicle)
    if color1 == 0 then color1 = 1 end
    if color2 == 0 then color2 = 2 end
    if color1 == -1 then color1 = 158 end
    if color2 == -1 then color2 = 158 end 
    if math.random(1, 2) == math.random(1, 2) then
        plate = "Unknown"
    end
    local dir = getCardinalDirectionFromHeading()
    local vehicleData  = {
        model = make,
        plate = plate,
        firstColor = colors[color1],
        secondColor = colors[color2],
        heading = dir
    }
    return vehicleData
end

local function canPedBeUsed(ped,isGunshot,isSpeeder)
    if math.random(100) > 15 then
        return false
    end
    if ped == nil then
        return false
    end
    if isSpeeder == nil then
        isSpeeder = false
    end
    if ped == PlayerPedId() then
        return false
    end
    if GetEntityHealth(ped) < GetEntityMaxHealth(ped) then
        return false
    end
    if isSpeeder then
        if not IsPedInAnyVehicle(ped, false) then
            return false
        end
    end
    if `mp_f_deadhooker` == GetEntityModel(ped) then
        return false
    end
    local curcoords = GetEntityCoords(PlayerPedId())
    local startcoords = GetEntityCoords(ped)
    if #(curcoords - startcoords) < 10.0 then
        return false
    end    
    if #(curcoords - vector3( 1088.76, -3187.51, -38.99)) < 15.0 then
        return false
    end  
    if not HasEntityClearLosToEntity(PlayerPedId(), ped, 17) and not isGunshot then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    if IsPedAPlayer(ped) then
        return false
    end
    if IsPedFatallyInjured(ped) then
        return false
    end
    if IsPedArmed(ped, 7) then
        return false
    end
    if IsPedInMeleeCombat(ped) then
        return false
    end
    if IsPedShooting(ped) then
        return false
    end
    if IsPedDucking(ped) then
        return false
    end
    if IsPedBeingJacked(ped) then
        return false
    end
    if IsPedSwimming(ped) then
        return false
    end
    if IsPedJumpingOutOfVehicle(ped) or IsPedBeingJacked(ped) then
        return false
    end
    local pedType = GetPedType(ped)
    if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then
        return false
    end
    return true
end

local NulledAreas = { 
    [1] = vector3(102.09, -1938.74, 20.79),
    [2] = vector3(-221.78, -1667.06, 34.45),
    [3] = vector3(-23.24, -1462.26, 30.8),
    [4] = vector3(-9.77, -1842.7, 26.15),
    [5] = vector3(16.54, -1548.8, 30.75),
    [6] = vector3(-120.32, -1522.75, 34.89)
}

tasksIdle = {
    [1] = "CODE_HUMAN_MEDIC_KNEEL",
    [2] = "WORLD_HUMAN_STAND_MOBILE",
}

local KnownWeapons = {
    [`weapon_pistol`] = {['weaponName'] = 'Pistol', ['isAuto'] = false},
    [`weapon_pistol_mk2`] = {['weaponName'] = 'Pistol Mk II', ['isAuto'] = false},
    [`weapon_combatpistol`] = {['weaponName'] = 'Combat Pistol', ['isAuto'] = false},
    [`weapon_appistol`] = {['weaponName'] = 'AP Pistol', ['isAuto'] = false},
    [`weapon_stungun`] = {['weaponName'] = 'Stun Gun (?)', ['isAuto'] = false},
    [`weapon_pistol50`] = {['weaponName'] = 'Pistol .50', ['isAuto'] = false},
    [`weapon_snspistol`] = {['weaponName'] = 'SNS Pistol', ['isAuto'] = false},
    [`weapon_snspistol_mk2`] = {['weaponName'] = 'SNS Pistol Mk II', ['isAuto'] = false},
    [`weapon_heavypistol`] = {['weaponName'] = 'Heavy Pistol', ['isAuto'] = false},
    [`weapon_vintagepistol`] = {['weaponName'] = 'Vintage Pistol', ['isAuto'] = false},
    [`weapon_flaregun`] = {['weaponName'] = 'Flare Gun', ['isAuto'] = false},
    [`weapon_marksmanpistol`] = {['weaponName'] = 'Marksman Pistol', ['isAuto'] = false},
    [`weapon_revolver`] = {['weaponName'] = 'Heavy Revolver', ['isAuto'] = false},
    [`weapon_revolver_mk2`] = {['weaponName'] = 'Heavy Revolver Mk II', ['isAuto'] = false},
    [`weapon_doubleaction`] = {['weaponName'] = 'Double Action Revolver', ['isAuto'] = false},
    [`weapon_raypistol`] = {['weaponName'] = 'Up-n-Atomizer', ['isAuto'] = false},
    [`weapon_ceramicpistol`] = {['weaponName'] = 'Ceramic Pistol', ['isAuto'] = false},
    [`weapon_navyrevolver`] = {['weaponName'] = 'Navy Revolver', ['isAuto'] = false},
    [`weapon_microsmg`] = {['weaponName'] = 'Micro SMG', ['isAuto'] = true},
    [`weapon_smg`] = {['weaponName'] = 'SMG', ['isAuto'] = true},
    [`weapon_smg_mk2`] = {['weaponName'] = 'SMG Mk II', ['isAuto'] = true},
    [`weapon_assaultsmg`] = {['weaponName'] = 'Assault SMG', ['isAuto'] = true},
    [`weapon_combatpdw`] = {['weaponName'] = 'Combat PDW', ['isAuto'] = true},
    [`weapon_machinepistol`] = {['weaponName'] = 'Machine Pistol', ['isAuto'] = true},
    [`weapon_minismg`] = {['weaponName'] = 'Mini SMG', ['isAuto'] = true},
    [`weapon_raycarbine`] = {['weaponName'] = 'Unholy Hellbringer', ['isAuto'] = true},
    [`weapon_pumpshotgun`] = {['weaponName'] = 'Pump Shotgun', ['isAuto'] = false},
    [`weapon_pumpshotgun_mk2`] = {['weaponName'] = 'Pump Shotgun Mk II', ['isAuto'] = false},
    [`weapon_sawnoffshotgun`] = {['weaponName'] = 'Sawed-Off Shotgun', ['isAuto'] = false},
    [`weapon_assaultshotgun`] = {['weaponName'] = 'Assault Shotgun', ['isAuto'] = true},
    [`weapon_bullpupshotgun`] = {['weaponName'] = 'Bullpup Shotgun', ['isAuto'] = true},
    [`weapon_musket`] = {['weaponName'] = 'Musket', ['isAuto'] = false},
    [`weapon_heavyshotgun`] = {['weaponName'] = 'Heavy Shotgun', ['isAuto'] = true},
    [`weapon_dbshotgun`] = {['weaponName'] = 'Double Barrel Shotgun', ['isAuto'] = false},
    [`weapon_autoshotgun`] = {['weaponName'] = 'Sweeper Shotgun', ['isAuto'] = true},
    [`weapon_assaultrifle`] = {['weaponName'] = 'Assault Rifle', ['isAuto'] = true},
    [`weapon_assaultrifle_mk2`] = {['weaponName'] = 'Assault Rifle Mk II', ['isAuto'] = true},
    [`weapon_carbinerifle`] = {['weaponName'] = 'Carbine Rifle', ['isAuto'] = true},
    [`weapon_carbinerifle_mk2`] = {['weaponName'] = 'Carbine Rifle Mk II', ['isAuto'] =true},
    [`weapon_advancedrifle`] = {['weaponName'] = 'Advanced Rifle', ['isAuto'] =true},
    [`weapon_specialcarbine`] = {['weaponName'] = 'Special Carbine', ['isAuto'] =true},
    [`weapon_specialcarbine_mk2`] = {['weaponName'] = 'Special Carbine Mk II', ['isAuto'] =true},
    [`weapon_bullpuprifle`] = {['weaponName'] = 'Bullpup Rifle', ['isAuto'] =true},
    [`weapon_bullpuprifle_mk2`] = {['weaponName'] = 'Bullpup Rifle Mk II', ['isAuto'] =true},
    [`weapon_compactrifle`] = {['weaponName'] = 'Compact Rifle', ['isAuto'] =true},
    [`weapon_mg`] = {['weaponName'] = 'MG', ['isAuto'] =true},
    [`weapon_combatmg`] = {['weaponName'] = 'Combat MG', ['isAuto'] =true},
    [`weapon_combatmg_mk2`] = {['weaponName'] = 'Combat MG Mk II', ['isAuto'] =true},
    [`weapon_gusenberg`] = {['weaponName'] = 'Gusenberg Sweeper', ['isAuto'] =true},
    [`weapon_sniperrifle`] = {['weaponName'] = 'Sniper Rifle', ['isAuto'] =false},
    [`weapon_heavysniper`] = {['weaponName'] = 'Heavy Rifle', ['isAuto'] =false},
    [`weapon_heavysniper_mk2`] = {['weaponName'] = 'Heavy Sniper Mk II', ['isAuto'] =false},
    [`weapon_marksmanrifle`] = {['weaponName'] = 'Marksman Rifle', ['isAuto'] =true},
    [`weapon_marksmanrifle_mk2`] = {['weaponName'] = 'Marksman Rifle Mk II', ['isAuto'] =true},
}

CreateThread(function()
    local isBusyGunShots, armed, cooldownGS, cooldownSMD = false, false, 0, 0
    while true do
        Wait(0)
        if not isBusyGunShots then
            armed = currentlyArmed
            if armed and KnownWeapons[currentWeapon] then
                if IsPedShooting(playerPed) and ((cooldownGS == 0) or cooldownGS - GetGameTimer() < 0) then
                    isBusyGunShots = true
                    if IsPedCurrentWeaponSilenced(playerPed) then
                        cooldownGS = GetGameTimer() + math.random(25000,30000)
                        TriggerEvent("civilian:alertPolice",15.0,"gunshot",0,true,inHuntingZone,currentWeapon)
                    elseif inVehicle then
                        cooldownGS = GetGameTimer() + math.random(20000,25000)
                        TriggerEvent("civilian:alertPolice",150.0,"gunshotvehicle",0,true,inHuntingZone,currentWeapon)
                    else
                        cooldownGS = GetGameTimer() + math.random(15000,20000)
                        TriggerEvent("civilian:alertPolice",550.0,"gunshot",0,true,inHuntingZone,currentWeapon)
                    end
                    isBusyGunShots = false
                elseif (cooldownSMD == 0 and math.random(10) > 7) or ((cooldownSMD - GetGameTimer() < 0) and math.random(10) > 7) then
                    local shouldAlert = true
                    local myPos = GetEntityCoords(playerPed)
                    for i = 1, #NulledAreas do
                        local dist = #(NulledAreas[i] - myPos)
                        if dist <= math.random(75, 100) then
                            shouldAlert = false
                            break 
                        end
                    end
                end
            else
                Wait(1000)
            end 
        else
            Wait(250)
        end
    end
end)

CreateThread(function()
    local isBusy, cooldown = false, 0
    while true do 
        Wait(0)
        if not inVehicle and not isBusy and (cooldown - GetGameTimer() < 0) then
            local pedinfront = GetPedInFront()
            if pedinfront > 0 then
                if IsPedInMeleeCombat(playerPed) and IsPedInCombat(pedinfront, playerPed) and GetClosestNPC(playerCoords, 25.0, 'combat', pedinfront) then
                    TriggerEvent("civilian:alertPolice", 15.0, "fight", 0)
                    cooldown = GetGameTimer() + math.random(20000,25000)
                else
                    Wait(1000)
                end
            else
                Wait(1000)
            end
        else 
            Wait(1000)
        end 
    end 
end)
    
local function ResetMathRandom()
    math.randomseed(GetCloudTimeAsInt())
end

local function randomizeBlipLocation(pOrigin)
    local x = pOrigin.x
    local y = pOrigin.y
    local z = pOrigin.z
    ResetMathRandom()
    local luck = math.random(1, 2)
    ResetMathRandom()
    y = math.random(25) + y
    ResetMathRandom()
    if luck == math.random(1, 2) then
        ResetMathRandom()
        x = math.random(25) + x
    end
    return vec3(x, y, z)
end

function AlertFight()
    local locationInfo = GetStreetAndZone()
    local gender, armed = IsPedMale(playerPed), IsPedArmed(playerPed, 7)
    local currentPos = GetEntityCoords(playerPed)
    local dispatchCode = "10-15"
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Disturbance",
        blipSprite = 458,
        blipColor = 25
    })
    TriggerServerEvent('un-dispatch:combatAlert', currentPos)
    if math.random(10) > 5 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(5000, 10000))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarEvading',
                    relatedCode = dispatchCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 3,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Car fleeing 10-15"
                })
                TriggerServerEvent('un-dispatch:combatAlert', newPos)
            end
            return
        end)
    end
end

function AlertGunShot(isHunting, sentWeapon)
    if KnownWeapons[sentWeapon] then
        local locationInfo = GetStreetAndZone()
        local gender = IsPedMale(playerPed)
        local currentPos = GetEntityCoords(playerPed)
        local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local vehicleData = GetVehicleDescription() or {}
        local initialTenCode = "10-60"
        TriggerServerEvent('un-dispatch:gunshotAlert', currentPos)
        TriggerServerEvent('dispatch:svNotify', {
            dispatchCode = initialTenCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 2,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            automaticGunfire = KnownWeapons[sentWeapon]['isAuto'],
            origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
            dispatchMessage = "Shots Fired"
        })
        if math.random(1, 10) > 3 and not isInVehicle then
            CreateThread(function()
                Wait(math.random(5000, 10000))
                if IsPedInAnyVehicle(PlayerPedId()) then
                    local vehicleData = GetVehicleDescription() or {}
                    local newPos = GetEntityCoords(PlayerPedId())
                    local locationInfo = GetStreetAndZone()
                    TriggerServerEvent('dispatch:svNotify', {
                        dispatchCode = 'CarEvading',
                        relatedCode = initialTenCode,
                        firstStreet = locationInfo,
                        gender = gender,
                        model = vehicleData.model,
                        plate = vehicleData.plate,
                        priority = 2,
                        firstColor = vehicleData.firstColor,
                        secondColor = vehicleData.secondColor,
                        heading = vehicleData.heading,
                        origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                        dispatchMessage = "Car fleeing 10-60"
                    })
                    TriggerServerEvent('un-dispatch:gunshotAlert', newPos)
                end
                return
            end)
        end
    end
end

RegisterNetEvent('rs-dispatch:drugsale')
AddEventHandler("rs-dispatch:drugsale",function()
    DrugSale()
end)

function DrugSale()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local initialTenCode = "10-99"
    TriggerServerEvent('un-dispatch:drugsale', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = initialTenCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Suspicious Hand-off"
    })
    if math.random(10) > 5 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(7500, 12500))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarEvading',
                    relatedCode = initialTenCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 2,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Car Fleeing 10-99"
                })
                TriggerServerEvent('un-dispatch:drugsale', newPos)
            end
            return
        end)
    end
end

function CarCrash()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if currentVeh == 0 or GetVehicleNumberPlateText(currentVeh) == nil then currentVeh = GetVehiclePedIsIn(PlayerPedId(), true) end
    local vehicleData = GetVehicleDescription(currentVeh) or {}
    local dispatchCode = "10-50"
    TriggerServerEvent('un-dispatch:vehiclecrash', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        model = vehicleData.model,
        plate = vehicleData.plate,
        priority = 3,
        firstColor = vehicleData.firstColor,
        secondColor = vehicleData.secondColor,
        heading = vehicleData.heading,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Vehicle Crash"
    })
end

function AlertCheckLockpick(object)
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    local vehicleData = GetVehicleDescription(currentVeh) or {}
    local dispatchCode = "10-90"
    TriggerServerEvent('un-dispatch:vehicletheft', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        model = vehicleData.model,
        plate = vehicleData.plate,
        firstColor = vehicleData.firstColor,
        secondColor = vehicleData.secondColor,
        heading = vehicleData.heading,
        priority = 3,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Vehicle Theft"
    })
end

RegisterNetEvent('un-dispatch:houserob')
AddEventHandler("un-dispatch:houserob",function()
    print('Nigger')
    AlertCheckRobbery2()
end)

function AlertCheckRobbery2()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    local dispatchCode = "10-33"
    TriggerServerEvent('un-dispatch:houserobbery', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Breaking and entering"
    })
    if math.random(10) > 3 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(12500, 15000))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarEvading',
                    relatedCode = dispatchCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 1,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Car fleeing 10-90"
                })
                TriggerServerEvent('un-dispatch:houserobbery', newPos)
            end
            return
        end)
    end
end

function AlertJewelRob()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    local dispatchCode = "10-90"
    TriggerServerEvent('un-dispatch:jewel', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Vangelico Robbery"
    })
    if math.random(10) > 2 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(12500, 15000))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarEvading',
                    relatedCode = dispatchCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 1,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Evading 10-90"
                })
                TriggerServerEvent('un-dispatch:jewel', newPos)
            end
            return
        end)
    end
end

function AlertJailBreak()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local dispatchCode = "10-98"
    TriggerServerEvent('un-dispatch:blip:jailbreak', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Jail Break in Progress"
    })
    if math.random(10) > 2 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(17500, 25000))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarFleeing',
                    relatedCode = dispatchCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 1,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Evading 10-98"
                })
                TriggerServerEvent('un-dispatch:blip:jailbreak', newPos)
            end
            return
        end)
    end
end

function AlertFleecaRobbery()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    local dispatchCode = "10-90"
    TriggerServerEvent('un-dispatch:bankwobbewy', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Fleeca Robbery"
    })
    if math.random(10) > 2 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(17500, 25000))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarEvading',
                    relatedCode = dispatchCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 1,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Evading 10-90"
                })
                TriggerServerEvent('un-dispatch:bankwobbewy', newPos)
            end
            return
        end)
    end
end

RegisterNetEvent('un-dispatch:bankrobbery')
AddEventHandler("un-dispatch:bankrobbery",function()
    AlertFleecaRobbery()
end)

RegisterNetEvent('un-dispatch:bankrobbery:pacific')
AddEventHandler("un-dispatch:bankrobbery:pacific",function()
    AlertPacificRobbery()
end)

function AlertPacificRobbery()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    local dispatchCode = "10-90"
    TriggerServerEvent('un-dispatch:bankwobbewy', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Pacific Standard Heist"
    })
    if math.random(10) > 2 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(17500, 25000))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarEvading',
                    relatedCode = dispatchCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 1,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Evading 10-90"
                })
                TriggerServerEvent('un-dispatch:bankwobbewy', newPos)
            end
            return
        end)
    end
end
function AlertPowerplant()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    local dispatchCode = "10-90"
    TriggerServerEvent('un-dispatch:bankwobbewy', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = "Senora Way, Palmer-Taylor Power Station",
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Powerplant Hit"
    })
    if math.random(10) > 2 and not isInVehicle then
        CreateThread(function()
            Wait(math.random(17500, 25000))
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicleData = GetVehicleDescription() or {}
                local newPos = GetEntityCoords(PlayerPedId())
                local locationInfo = GetStreetAndZone()
                TriggerServerEvent('dispatch:svNotify', {
                    dispatchCode = 'CarEvading',
                    relatedCode = dispatchCode,
                    firstStreet = locationInfo,
                    gender = gender,
                    model = vehicleData.model,
                    plate = vehicleData.plate,
                    priority = 1,
                    firstColor = vehicleData.firstColor,
                    secondColor = vehicleData.secondColor,
                    heading = vehicleData.heading,
                    origin = {x = newPos.x, y = newPos.y, z = newPos.z},
                    dispatchMessage = "Evading 10-90"
                })
                TriggerServerEvent('un-dispatch:bankwobbewy', newPos)
            end
            return
        end)
    end
end

function AlertDeath()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(playerPed)
    local currentPos = GetEntityCoords(playerPed)
    local dispatchCode = "10-50"
    TriggerServerEvent('un-dispatch:death', currentPos)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Dead Body"
    })
end

RegisterNetEvent('un-dispatch:jailbreak')
AddEventHandler("un-dispatch:jailbreak",function()
    AlertJailBreak()
end)

RegisterNetEvent('un-dispatch:jewelrobbery')
AddEventHandler("un-dispatch:jewelrobbery",function()
    AlertJewelRob()
end)

RegisterNetEvent('un-dispatch:carjacking')
AddEventHandler("un-dispatch:carjacking",function()
    AlertCheckLockpick()
end)

RegisterNetEvent('un-dispatch:downplayer')
AddEventHandler("un-dispatch:downplayer",function()
    AlertDeath()
end)

LoadQBCoreVersion = function()
    RegisterNetEvent('un-dispatch:gunshotAlert')
    AddEventHandler('un-dispatch:gunshotAlert', function(sentCoords)
        if sentCoords then
            if (QBCore.Functions.GetPlayerData().job.name == "police") then
                local blipAlpha = 250
                local gunshotBlip = AddBlipForCoord(sentCoords)
                SetBlipScale(gunshotBlip, 1.3)
                SetBlipSprite(gunshotBlip, 432)
                SetBlipColour(gunshotBlip, 1)
                SetBlipAlpha(gunshotBlip, blipAlpha)
                SetBlipAsShortRange(gunshotBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('10-60 Shots Fired')
                EndTextCommandSetBlipName(gunshotBlip)
                SetBlipAsShortRange(gunshotBlip, 1)
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                CreateThread(function()
                    while blipAlpha ~= 0 and DoesBlipExist(gunshotBlip) do
                        Citizen.Wait(120 * 4)
                        blipAlpha = blipAlpha - 1
                        SetBlipAlpha(gunshotBlip, blipAlpha)
                        if blipAlpha == 0 then
                            RemoveBlip(gunshotBlip)
                            return
                        end
                    end
                    return
                end)
            end 
        end 
    end)
    RegisterNetEvent('un-dispatch:combatAlert')
    AddEventHandler('un-dispatch:combatAlert', function(sentCoords)
        if sentCoords then
            if (QBCore.Functions.GetPlayerData().job.name == "police") then
                local alpha = 250
                local combatBlip = AddBlipForCoord(sentCoords)
                SetBlipScale(combatBlip, 1.3)
                SetBlipSprite(combatBlip, 437)
                SetBlipColour(combatBlip, 1)
                SetBlipAlpha(combatBlip, alpha)
                SetBlipAsShortRange(combatBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('10-11 Fight In Progress')
                EndTextCommandSetBlipName(combatBlip)
                SetBlipAsShortRange(combatBlip,  1)
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                CreateThread(function()
                    while alpha ~= 0 and DoesBlipExist(combatBlip) do
                        Citizen.Wait(90 * 4)
                        alpha = alpha - 1
                        SetBlipAlpha(combatBlip, alpha)
                        if alpha == 0 then
                            RemoveBlip(combatBlip)
                            return
                        end
                    end
                    return
                end)
            end
        end 
    end)
    RegisterNetEvent('civilian:alertPolice')
    AddEventHandler("civilian:alertPolice",function(basedistance, alertType, objPassed, isGunshot, isHunting, sentWeapon)
        if QBCore.Functions.GetPlayerData().job == nil then return end;
        local isPolice = QBCore.Functions.GetPlayerData().job.name == "police"
        local object = objPassed
        if not daytime then
            basedistance = basedistance * 8.2
        else
            basedistance = basedistance * 3.45
        end
        if isGunshot == nil then 
            isGunshot = false 
        end
        local plyCoords = GetEntityCoords(PlayerPedId())
        if isGunshot then
            shittypefuckyou = 'gunshot'
        end
        local nearNPC
        if alertType == 'drugsale' then
            nearNPC = GetClosestNPC(plyCoords, basedistance, 'combat', object)
        else
            nearNPC = GetClosestNPC(plyCoords, basedistance, shittypefuckyou)
        end 
        local dst = 0
        if nearNPC then
            dst = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearNPC))
        end
        if nearNPC and DoesEntityExist(nearNPC) then
            if not isSpeeder and alertType ~= "robberyhouse" then
                RequestAnimDict("amb@code_human_wander_texting@male@base")
                while not HasAnimDictLoaded("amb@code_human_wander_texting@male@base") do
                    Wait(0)
                end
                Wait(1000)
                if GetEntityHealth(nearNPC) < GetEntityMaxHealth(nearNPC) then
                    return
                end
                if not DoesEntityExist(nearNPC) then
                    return
                end
                if IsPedFatallyInjured(nearNPC) then
                    return
                end
                if IsPedInMeleeCombat(nearNPC) then
                    return
                end
                ClearPedTasks(nearNPC)
                TaskPlayAnim(nearNPC, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
            end
        end
        local isUnderground = false
        if plyCoords.z <= -25 then isUnderground = true end
        if alertType == "drugsale" and not underground then
            if dst > 50.5 and dst < 75.0 then
                DrugSale()
            end
        elseif alertType == "druguse" and not underground and not pd then
            if dst > 12.0 and dst < 18.0 then
                DrugUse()
            end
        elseif alertType == "carcrash" then
            CarCrash()
        elseif alertType == "death" then
            AlertDeath()
            local roadtest2 = IsPointOnRoad(GetEntityCoords(PlayerPedId()), PlayerPedId())
            if roadtest2 then return end
        elseif alertType == "Suspicious" then
            AlertSuspicious()
        elseif alertType == "fight" and not underground then
            AlertFight()
        elseif (alertType == "gunshot" or alertType == "gunshotvehicle") then
            AlertGunShot(isHunting, sentWeapon)
        elseif alertType == "lockpick" then
            if dst > 5.0 and dst < 85.0 then
                if math.random(100) >= 25 then
                    AlertCheckLockpick(object)
                end
            end
        elseif alertType == "robberyhouse" and not QBCore.Functions.GetPlayerData().job.name == "police" then
            AlertCheckRobbery2()
        end
    end)
    RegisterNetEvent('un-dispatch:vehiclecrash')
    AddEventHandler('un-dispatch:vehiclecrash', function(targetCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(injured,  488)
            SetBlipColour(injured,  1)
            SetBlipScale(injured, 1.5)
            SetBlipAsShortRange(injured,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-50 Vehicle Crash')
            EndTextCommandSetBlipName(injured)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(injured, alpha)
                if alpha == 0 then
                    RemoveBlip(injured)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:vehicletheft')
    AddEventHandler('un-dispatch:vehicletheft', function(targetCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local thiefBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(thiefBlip,  488)
            SetBlipColour(thiefBlip,  1)
            SetBlipScale(thiefBlip, 1.5)
            SetBlipAsShortRange(thiefBlip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Vehicle Theft')
            EndTextCommandSetBlipName(thiefBlip)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(thiefBlip, alpha)
                if alpha == 0 then
                    RemoveBlip(thiefBlip)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:storerobbery')
    AddEventHandler('un-dispatch:storerobbery', function(targetCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local store = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipHighDetail(store, true)
            SetBlipSprite(store,  52)
            SetBlipColour(store,  1)
            SetBlipScale(store, 1.3)
            SetBlipAsShortRange(store,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Robbery In Progress')
            EndTextCommandSetBlipName(store)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(store, alpha)
                if alpha == 0 then
                    RemoveBlip(store)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:houserobbery')
    AddEventHandler('un-dispatch:houserobbery', function(targetCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local burglary = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipHighDetail(burglary, true)
            SetBlipSprite(burglary,  411)
            SetBlipColour(burglary,  1)
            SetBlipScale(burglary, 1.3)
            SetBlipAsShortRange(burglary,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Burglary')
            EndTextCommandSetBlipName(burglary)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(burglary, alpha)
                if alpha == 0 then
                    RemoveBlip(burglary)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:jewel')
    AddEventHandler('un-dispatch:jewel', function(targetCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local truck = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(truck,  434)
            SetBlipColour(truck,  66)
            SetBlipScale(truck, 1.5)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Vangelico Robbery In Progress')
            EndTextCommandSetBlipName(truck)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(truck, alpha)
                if alpha == 0 then
                    RemoveBlip(truck)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:bankwobbewy')
    AddEventHandler('un-dispatch:bankwobbewy', function(targetCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local bankwobbewy = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(bankwobbewy,  161)
            SetBlipColour(bankwobbewy,  46)
            SetBlipScale(bankwobbewy, 1.5)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Bank Robbery In Progress')
            EndTextCommandSetBlipName(bankwobbewy)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(bankwobbewy, alpha)
                if alpha == 0 then
                    RemoveBlip(bankwobbewy)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:drugsale')
    AddEventHandler('un-dispatch:drugsale', function(sentCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local drugsale = AddBlipForCoord(sentCoords)
            SetBlipSprite(drugsale,  487)
            SetBlipColour(drugsale,  4)
            SetBlipScale(drugsale, 1.2)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-99 In Progress')
            EndTextCommandSetBlipName(drugsale)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(drugsale, alpha)
                if alpha == 0 then
                    RemoveBlip(drugsale)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:blip:jailbreak')
    AddEventHandler('un-dispatch:blip:jailbreak', function(targetCoords)
        if (QBCore.Functions.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local jail = AddBlipForCoord(1779.65, 2590.39, 50.49)
            SetBlipSprite(jail,  487)
            SetBlipColour(jail,  4)
            SetBlipScale(jail, 1.4)
            SetBlipAsShortRange(jail,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-98 Jail Break')
            EndTextCommandSetBlipName(jail)
            TriggerServerEvent('erp-sounds:PlayOnSource', 'bankalarm', 0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(jail, alpha)
                if alpha == 0 then
                    RemoveBlip(jail)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('dispatch:clNotify')
    AddEventHandler('dispatch:clNotify', function(sNotificationData, sNotificationId, sender)
        if sNotificationData ~= nil then
            if sender == GetPlayerServerId(PlayerId()) and sNotificationData['dispatchCode'] == '911' then
                SendNUIMessage({
                    update = "newCall",
                    callID = sNotificationId + math.random(1000, 9999),
                    data = {
                        dispatchCode = '911',
                        priority = 1,
                        dispatchMessage = "Sent 911 call",
                        information = "Thank you for sending a 911 call in, it has been received and is being processed."
                    },
                    timer = 5000,
                    isPolice = true
                })
            end
            local shouldAlert = true
            if shouldAlert then 
                if not disableNotis then
                    if sNotificationData.origin ~= nil then
                        if sNotificationData.originStatic == nil or not sNotificationData.originStatic then
                            sNotificationData.origin = randomizeBlipLocation(sNotificationData.origin)
                        else
                            sNotificationData.origin = sNotificationData.origin
                        end
                    end
                    SendNUIMessage({
                        update = "newCall",
                        callID = sNotificationId,
                        data = sNotificationData,
                        timer = 5000,
                        isPolice = QBCore.Functions.GetPlayerData().job.name == "police"
                    })
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:setBlip')
    AddEventHandler('un-dispatch:setBlip', function(type, pos, id)
        if (QBCore.Functions.GetPlayerData().job.name == "police" or QBCore.Functions.GetPlayerData().job.name == 'ambulance') then	
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
            if type == '911' then
                local alpha = 250
                local call = AddBlipForCoord(pos)
                SetBlipSprite (call, 480)
                SetBlipDisplay(call, 4)
                SetBlipScale  (call, 1.2)
                SetBlipAsShortRange(call, true)
                SetBlipAlpha(call, alpha)
                SetBlipHighDetail(call, true)
                SetBlipAsShortRange(call, true)
                SetBlipColour (call, 1)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString('['..id..'] 911 Call')
                EndTextCommandSetBlipName(call)
                while alpha ~= 0 do
                    Citizen.Wait(240 * 4)
                    alpha = alpha - 1
                    SetBlipAlpha(call, alpha)
                    if alpha == 0 then
                        RemoveBlip(call)
                        return
                    end
                end
            end
        end
    end)
end

LoadESXVersion = function()
    RegisterNetEvent('un-dispatch:gunshotAlert')
    AddEventHandler('un-dispatch:gunshotAlert', function(sentCoords)
        if sentCoords then
            if (ESX.GetPlayerData().job.name == "police") then
                local blipAlpha = 250
                local gunshotBlip = AddBlipForCoord(sentCoords)
                SetBlipScale(gunshotBlip, 1.3)
                SetBlipSprite(gunshotBlip, 432)
                SetBlipColour(gunshotBlip, 1)
                SetBlipAlpha(gunshotBlip, blipAlpha)
                SetBlipAsShortRange(gunshotBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('10-60 Shots Fired')
                EndTextCommandSetBlipName(gunshotBlip)
                SetBlipAsShortRange(gunshotBlip, 1)
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                CreateThread(function()
                    while blipAlpha ~= 0 and DoesBlipExist(gunshotBlip) do
                        Citizen.Wait(120 * 4)
                        blipAlpha = blipAlpha - 1
                        SetBlipAlpha(gunshotBlip, blipAlpha)
                        if blipAlpha == 0 then
                            RemoveBlip(gunshotBlip)
                            return
                        end
                    end
                    return
                end)
            end 
        end 
    end)
    RegisterNetEvent('un-dispatch:combatAlert')
    AddEventHandler('un-dispatch:combatAlert', function(sentCoords)
        if sentCoords then
            if (ESX.GetPlayerData().job.name == "police") then
                local alpha = 250
                local combatBlip = AddBlipForCoord(sentCoords)
                SetBlipScale(combatBlip, 1.3)
                SetBlipSprite(combatBlip, 437)
                SetBlipColour(combatBlip, 1)
                SetBlipAlpha(combatBlip, alpha)
                SetBlipAsShortRange(combatBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('10-11 Fight In Progress')
                EndTextCommandSetBlipName(combatBlip)
                SetBlipAsShortRange(combatBlip,  1)
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                CreateThread(function()
                    while alpha ~= 0 and DoesBlipExist(combatBlip) do
                        Citizen.Wait(90 * 4)
                        alpha = alpha - 1
                        SetBlipAlpha(combatBlip, alpha)
                        if alpha == 0 then
                            RemoveBlip(combatBlip)
                            return
                        end
                    end
                    return
                end)
            end
        end 
    end)
    RegisterNetEvent('civilian:alertPolice')
    AddEventHandler("civilian:alertPolice",function(basedistance, alertType, objPassed, isGunshot, isHunting, sentWeapon)
        if ESX.GetPlayerData().job.name == nil then return end;
        local isPolice = ESX.GetPlayerData().job.name == "police"
        local object = objPassed
        if not daytime then
            basedistance = basedistance * 8.2
        else
            basedistance = basedistance * 3.45
        end
        if isGunshot == nil then 
            isGunshot = false 
        end
        local plyCoords = GetEntityCoords(PlayerPedId())
        if isGunshot then
            shittypefuckyou = 'gunshot'
        end
        local nearNPC
        if alertType == 'drugsale' then
            nearNPC = GetClosestNPC(plyCoords, basedistance, 'combat', object)
        else
            nearNPC = GetClosestNPC(plyCoords, basedistance, shittypefuckyou)
        end 
        local dst = 0
        if nearNPC then
            dst = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearNPC))
        end
        if nearNPC and DoesEntityExist(nearNPC) then
            if not isSpeeder and alertType ~= "robberyhouse" then
                RequestAnimDict("amb@code_human_wander_texting@male@base")
                while not HasAnimDictLoaded("amb@code_human_wander_texting@male@base") do
                    Wait(0)
                end
                Wait(1000)
                if GetEntityHealth(nearNPC) < GetEntityMaxHealth(nearNPC) then
                    return
                end
                if not DoesEntityExist(nearNPC) then
                    return
                end
                if IsPedFatallyInjured(nearNPC) then
                    return
                end
                if IsPedInMeleeCombat(nearNPC) then
                    return
                end
                ClearPedTasks(nearNPC)
                TaskPlayAnim(nearNPC, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
            end
        end
        local isUnderground = false
        if plyCoords.z <= -25 then isUnderground = true end
        if alertType == "drugsale" and not underground then
            if dst > 50.5 and dst < 75.0 then
                DrugSale()
            end
        elseif alertType == "druguse" and not underground and not pd then
            if dst > 12.0 and dst < 18.0 then
                DrugUse()
            end
        elseif alertType == "carcrash" then
            CarCrash()
        elseif alertType == "death" then
            AlertDeath()
            local roadtest2 = IsPointOnRoad(GetEntityCoords(PlayerPedId()), PlayerPedId())
            if roadtest2 then return end
        elseif alertType == "Suspicious" then
            AlertSuspicious()
        elseif alertType == "fight" and not underground then
            AlertFight()
        elseif (alertType == "gunshot" or alertType == "gunshotvehicle") then
            AlertGunShot(isHunting, sentWeapon)
        elseif alertType == "lockpick" then
            if dst > 5.0 and dst < 85.0 then
                if math.random(100) >= 25 then
                    AlertCheckLockpick(object)
                end
            end
        elseif alertType == "robberyhouse" and not ESX.GetPlayerData().job.name == "police" then
            AlertCheckRobbery2()
        end
    end)
    RegisterNetEvent('un-dispatch:vehiclecrash')
    AddEventHandler('un-dispatch:vehiclecrash', function(targetCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(injured,  488)
            SetBlipColour(injured,  1)
            SetBlipScale(injured, 1.5)
            SetBlipAsShortRange(injured,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-50 Vehicle Crash')
            EndTextCommandSetBlipName(injured)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(injured, alpha)
                if alpha == 0 then
                    RemoveBlip(injured)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:vehicletheft')
    AddEventHandler('un-dispatch:vehicletheft', function(targetCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local thiefBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(thiefBlip,  488)
            SetBlipColour(thiefBlip,  1)
            SetBlipScale(thiefBlip, 1.5)
            SetBlipAsShortRange(thiefBlip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Vehicle Theft')
            EndTextCommandSetBlipName(thiefBlip)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(thiefBlip, alpha)
                if alpha == 0 then
                    RemoveBlip(thiefBlip)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:storerobbery')
    AddEventHandler('un-dispatch:storerobbery', function(targetCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local store = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipHighDetail(store, true)
            SetBlipSprite(store,  52)
            SetBlipColour(store,  1)
            SetBlipScale(store, 1.3)
            SetBlipAsShortRange(store,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Robbery In Progress')
            EndTextCommandSetBlipName(store)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(store, alpha)
                if alpha == 0 then
                    RemoveBlip(store)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:houserobbery')
    AddEventHandler('un-dispatch:houserobbery', function(targetCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local burglary = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipHighDetail(burglary, true)
            SetBlipSprite(burglary,  411)
            SetBlipColour(burglary,  1)
            SetBlipScale(burglary, 1.3)
            SetBlipAsShortRange(burglary,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Burglary')
            EndTextCommandSetBlipName(burglary)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(burglary, alpha)
                if alpha == 0 then
                    RemoveBlip(burglary)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:jewel')
    AddEventHandler('un-dispatch:jewel', function(targetCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local truck = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(truck,  434)
            SetBlipColour(truck,  66)
            SetBlipScale(truck, 1.5)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Vangelico Robbery In Progress')
            EndTextCommandSetBlipName(truck)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(truck, alpha)
                if alpha == 0 then
                    RemoveBlip(truck)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:bankwobbewy')
    AddEventHandler('un-dispatch:bankwobbewy', function(targetCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local bankwobbewy = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(bankwobbewy,  161)
            SetBlipColour(bankwobbewy,  46)
            SetBlipScale(bankwobbewy, 1.5)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Bank Robbery In Progress')
            EndTextCommandSetBlipName(bankwobbewy)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(bankwobbewy, alpha)
                if alpha == 0 then
                    RemoveBlip(bankwobbewy)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:drugsale')
    AddEventHandler('un-dispatch:drugsale', function(sentCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local drugsale = AddBlipForCoord(sentCoords)
            SetBlipSprite(drugsale,  487)
            SetBlipColour(drugsale,  4)
            SetBlipScale(drugsale, 1.2)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-99 In Progress')
            EndTextCommandSetBlipName(drugsale)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(drugsale, alpha)
                if alpha == 0 then
                    RemoveBlip(drugsale)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:blip:jailbreak')
    AddEventHandler('un-dispatch:blip:jailbreak', function(targetCoords)
        if (ESX.GetPlayerData().job.name == "police") then	
            local alpha = 250
            local jail = AddBlipForCoord(1779.65, 2590.39, 50.49)
            SetBlipSprite(jail,  487)
            SetBlipColour(jail,  4)
            SetBlipScale(jail, 1.4)
            SetBlipAsShortRange(jail,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-98 Jail Break')
            EndTextCommandSetBlipName(jail)
            TriggerServerEvent('erp-sounds:PlayOnSource', 'bankalarm', 0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(jail, alpha)
                if alpha == 0 then
                    RemoveBlip(jail)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('dispatch:clNotify')
    AddEventHandler('dispatch:clNotify', function(sNotificationData, sNotificationId, sender)
        if sNotificationData ~= nil then
            if sender == GetPlayerServerId(PlayerId()) and sNotificationData['dispatchCode'] == '911' then
                SendNUIMessage({
                    update = "newCall",
                    callID = sNotificationId + math.random(1000, 9999),
                    data = {
                        dispatchCode = '911',
                        priority = 1,
                        dispatchMessage = "Sent 911 call",
                        information = "Thank you for sending a 911 call in, it has been received and is being processed."
                    },
                    timer = 5000,
                    isPolice = true
                })
            end
            local shouldAlert = true
            if shouldAlert then 
                if not disableNotis then
                    if sNotificationData.origin ~= nil then
                        if sNotificationData.originStatic == nil or not sNotificationData.originStatic then
                            sNotificationData.origin = randomizeBlipLocation(sNotificationData.origin)
                        else
                            sNotificationData.origin = sNotificationData.origin
                        end
                    end
                    SendNUIMessage({
                        update = "newCall",
                        callID = sNotificationId,
                        data = sNotificationData,
                        timer = 5000,
                        isPolice = ESX.GetPlayerData().job.name == "police"
                    })
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:setBlip')
    AddEventHandler('un-dispatch:setBlip', function(type, pos, id)
        if (ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == 'ambulance') then	
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
            if type == '911' then
                local alpha = 250
                local call = AddBlipForCoord(pos)
                SetBlipSprite (call, 480)
                SetBlipDisplay(call, 4)
                SetBlipScale  (call, 1.2)
                SetBlipAsShortRange(call, true)
                SetBlipAlpha(call, alpha)
                SetBlipHighDetail(call, true)
                SetBlipAsShortRange(call, true)
                SetBlipColour (call, 1)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString('['..id..'] 911 Call')
                EndTextCommandSetBlipName(call)
                while alpha ~= 0 do
                    Citizen.Wait(240 * 4)
                    alpha = alpha - 1
                    SetBlipAlpha(call, alpha)
                    if alpha == 0 then
                        RemoveBlip(call)
                        return
                    end
                end
            end
        end
    end)
end

LoadNopixelVersion = function()
    RegisterNetEvent('un-dispatch:gunshotAlert')
    AddEventHandler('un-dispatch:gunshotAlert', function(sentCoords)
        if sentCoords then
            if (exports['isPed']:isPed("myjob") == "police") then
                local blipAlpha = 250
                local gunshotBlip = AddBlipForCoord(sentCoords)
                SetBlipScale(gunshotBlip, 1.3)
                SetBlipSprite(gunshotBlip, 432)
                SetBlipColour(gunshotBlip, 1)
                SetBlipAlpha(gunshotBlip, blipAlpha)
                SetBlipAsShortRange(gunshotBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('10-60 Shots Fired')
                EndTextCommandSetBlipName(gunshotBlip)
                SetBlipAsShortRange(gunshotBlip, 1)
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                CreateThread(function()
                    while blipAlpha ~= 0 and DoesBlipExist(gunshotBlip) do
                        Citizen.Wait(120 * 4)
                        blipAlpha = blipAlpha - 1
                        SetBlipAlpha(gunshotBlip, blipAlpha)
                        if blipAlpha == 0 then
                            RemoveBlip(gunshotBlip)
                            return
                        end
                    end
                    return
                end)
            end 
        end 
    end)
    RegisterNetEvent('un-dispatch:combatAlert')
    AddEventHandler('un-dispatch:combatAlert', function(sentCoords)
        if sentCoords then
            if (exports['isPed']:isPed("myjob") == "police") then
                local alpha = 250
                local combatBlip = AddBlipForCoord(sentCoords)
                SetBlipScale(combatBlip, 1.3)
                SetBlipSprite(combatBlip, 437)
                SetBlipColour(combatBlip, 1)
                SetBlipAlpha(combatBlip, alpha)
                SetBlipAsShortRange(combatBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('10-11 Fight In Progress')
                EndTextCommandSetBlipName(combatBlip)
                SetBlipAsShortRange(combatBlip,  1)
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                CreateThread(function()
                    while alpha ~= 0 and DoesBlipExist(combatBlip) do
                        Citizen.Wait(90 * 4)
                        alpha = alpha - 1
                        SetBlipAlpha(combatBlip, alpha)
                        if alpha == 0 then
                            RemoveBlip(combatBlip)
                            return
                        end
                    end
                    return
                end)
            end
        end 
    end)
    RegisterNetEvent('civilian:alertPolice')
    AddEventHandler("civilian:alertPolice",function(basedistance, alertType, objPassed, isGunshot, isHunting, sentWeapon)
        if exports['isPed']:isPed("myjob") == nil then return end;
        local isPolice = exports['isPed']:isPed("myjob") == "police"
        local object = objPassed
        if not daytime then
            basedistance = basedistance * 8.2
        else
            basedistance = basedistance * 3.45
        end
        if isGunshot == nil then 
            isGunshot = false 
        end
        local plyCoords = GetEntityCoords(PlayerPedId())
        if isGunshot then
            shittypefuckyou = 'gunshot'
        end
        local nearNPC
        if alertType == 'drugsale' then
            nearNPC = GetClosestNPC(plyCoords, basedistance, 'combat', object)
        else
            nearNPC = GetClosestNPC(plyCoords, basedistance, shittypefuckyou)
        end 
        local dst = 0
        if nearNPC then
            dst = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearNPC))
        end
        if nearNPC and DoesEntityExist(nearNPC) then
            if not isSpeeder and alertType ~= "robberyhouse" then
                RequestAnimDict("amb@code_human_wander_texting@male@base")
                while not HasAnimDictLoaded("amb@code_human_wander_texting@male@base") do
                    Wait(0)
                end
                Wait(1000)
                if GetEntityHealth(nearNPC) < GetEntityMaxHealth(nearNPC) then
                    return
                end
                if not DoesEntityExist(nearNPC) then
                    return
                end
                if IsPedFatallyInjured(nearNPC) then
                    return
                end
                if IsPedInMeleeCombat(nearNPC) then
                    return
                end
                ClearPedTasks(nearNPC)
                TaskPlayAnim(nearNPC, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
            end
        end
        local isUnderground = false
        if plyCoords.z <= -25 then isUnderground = true end
        if alertType == "drugsale" and not underground then
            if dst > 50.5 and dst < 75.0 then
                DrugSale()
            end
        elseif alertType == "druguse" and not underground and not pd then
            if dst > 12.0 and dst < 18.0 then
                DrugUse()
            end
        elseif alertType == "carcrash" then
            CarCrash()
        elseif alertType == "death" then
            AlertDeath()
            local roadtest2 = IsPointOnRoad(GetEntityCoords(PlayerPedId()), PlayerPedId())
            if roadtest2 then return end
        elseif alertType == "Suspicious" then
            AlertSuspicious()
        elseif alertType == "fight" and not underground then
            AlertFight()
        elseif (alertType == "gunshot" or alertType == "gunshotvehicle") then
            AlertGunShot(isHunting, sentWeapon)
        elseif alertType == "lockpick" then
            if dst > 5.0 and dst < 85.0 then
                if math.random(100) >= 25 then
                    AlertCheckLockpick(object)
                end
            end
        elseif alertType == "robberyhouse" and not exports['isPed']:isPed("myjob") == "police" then
            AlertCheckRobbery2()
        end
    end)
    RegisterNetEvent('un-dispatch:vehiclecrash')
    AddEventHandler('un-dispatch:vehiclecrash', function(targetCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(injured,  488)
            SetBlipColour(injured,  1)
            SetBlipScale(injured, 1.5)
            SetBlipAsShortRange(injured,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-50 Vehicle Crash')
            EndTextCommandSetBlipName(injured)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(injured, alpha)
                if alpha == 0 then
                    RemoveBlip(injured)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:vehicletheft')
    AddEventHandler('un-dispatch:vehicletheft', function(targetCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local thiefBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(thiefBlip,  488)
            SetBlipColour(thiefBlip,  1)
            SetBlipScale(thiefBlip, 1.5)
            SetBlipAsShortRange(thiefBlip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Vehicle Theft')
            EndTextCommandSetBlipName(thiefBlip)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(thiefBlip, alpha)
                if alpha == 0 then
                    RemoveBlip(thiefBlip)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:storerobbery')
    AddEventHandler('un-dispatch:storerobbery', function(targetCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local store = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipHighDetail(store, true)
            SetBlipSprite(store,  52)
            SetBlipColour(store,  1)
            SetBlipScale(store, 1.3)
            SetBlipAsShortRange(store,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Robbery In Progress')
            EndTextCommandSetBlipName(store)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(store, alpha)
                if alpha == 0 then
                    RemoveBlip(store)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:houserobbery')
    AddEventHandler('un-dispatch:houserobbery', function(targetCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local burglary = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipHighDetail(burglary, true)
            SetBlipSprite(burglary,  411)
            SetBlipColour(burglary,  1)
            SetBlipScale(burglary, 1.3)
            SetBlipAsShortRange(burglary,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Burglary')
            EndTextCommandSetBlipName(burglary)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(burglary, alpha)
                if alpha == 0 then
                    RemoveBlip(burglary)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:jewel')
    AddEventHandler('un-dispatch:jewel', function(targetCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local truck = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(truck,  434)
            SetBlipColour(truck,  66)
            SetBlipScale(truck, 1.5)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Vangelico Robbery In Progress')
            EndTextCommandSetBlipName(truck)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(truck, alpha)
                if alpha == 0 then
                    RemoveBlip(truck)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:bankwobbewy')
    AddEventHandler('un-dispatch:bankwobbewy', function(targetCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local bankwobbewy = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
            SetBlipSprite(bankwobbewy,  161)
            SetBlipColour(bankwobbewy,  46)
            SetBlipScale(bankwobbewy, 1.5)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-90 Bank Robbery In Progress')
            EndTextCommandSetBlipName(bankwobbewy)
            TriggerEvent("erp-sounds:PlayOnOne","metaldetected",0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(bankwobbewy, alpha)
                if alpha == 0 then
                    RemoveBlip(bankwobbewy)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:drugsale')
    AddEventHandler('un-dispatch:drugsale', function(sentCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local drugsale = AddBlipForCoord(sentCoords)
            SetBlipSprite(drugsale,  487)
            SetBlipColour(drugsale,  4)
            SetBlipScale(drugsale, 1.2)
            SetBlipAsShortRange(Blip,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-99 In Progress')
            EndTextCommandSetBlipName(drugsale)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(drugsale, alpha)
                if alpha == 0 then
                    RemoveBlip(drugsale)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:blip:jailbreak')
    AddEventHandler('un-dispatch:blip:jailbreak', function(targetCoords)
        if (exports['isPed']:isPed("myjob") == "police") then	
            local alpha = 250
            local jail = AddBlipForCoord(1779.65, 2590.39, 50.49)
            SetBlipSprite(jail,  487)
            SetBlipColour(jail,  4)
            SetBlipScale(jail, 1.4)
            SetBlipAsShortRange(jail,  1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('10-98 Jail Break')
            EndTextCommandSetBlipName(jail)
            TriggerServerEvent('erp-sounds:PlayOnSource', 'bankalarm', 0.1)
            while alpha ~= 0 do
                Citizen.Wait(120 * 4)
                alpha = alpha - 1
                SetBlipAlpha(jail, alpha)
                if alpha == 0 then
                    RemoveBlip(jail)
                    return
                end
            end
        end
    end)
    RegisterNetEvent('dispatch:clNotify')
    AddEventHandler('dispatch:clNotify', function(sNotificationData, sNotificationId, sender)
        if sNotificationData ~= nil then
            if sender == GetPlayerServerId(PlayerId()) and sNotificationData['dispatchCode'] == '911' then
                SendNUIMessage({
                    update = "newCall",
                    callID = sNotificationId + math.random(1000, 9999),
                    data = {
                        dispatchCode = '911',
                        priority = 1,
                        dispatchMessage = "Sent 911 call",
                        information = "Thank you for sending a 911 call in, it has been received and is being processed."
                    },
                    timer = 5000,
                    isPolice = true
                })
            end
            local shouldAlert = true
            if shouldAlert then 
                if not disableNotis then
                    if sNotificationData.origin ~= nil then
                        if sNotificationData.originStatic == nil or not sNotificationData.originStatic then
                            sNotificationData.origin = randomizeBlipLocation(sNotificationData.origin)
                        else
                            sNotificationData.origin = sNotificationData.origin
                        end
                    end
                    SendNUIMessage({
                        update = "newCall",
                        callID = sNotificationId,
                        data = sNotificationData,
                        timer = 5000,
                        isPolice = exports['isPed']:isPed("myjob") == "police"
                    })
                end
            end
        end
    end)
    RegisterNetEvent('un-dispatch:setBlip')
    AddEventHandler('un-dispatch:setBlip', function(type, pos, id)
        if (exports['isPed']:isPed("myjob") == "police" or exports['isPed']:isPed("myjob") == 'ambulance') then	
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
            if type == '911' then
                local alpha = 250
                local call = AddBlipForCoord(pos)
                SetBlipSprite (call, 480)
                SetBlipDisplay(call, 4)
                SetBlipScale  (call, 1.2)
                SetBlipAsShortRange(call, true)
                SetBlipAlpha(call, alpha)
                SetBlipHighDetail(call, true)
                SetBlipAsShortRange(call, true)
                SetBlipColour (call, 1)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString('['..id..'] 911 Call')
                EndTextCommandSetBlipName(call)
                while alpha ~= 0 do
                    Citizen.Wait(240 * 4)
                    alpha = alpha - 1
                    SetBlipAlpha(call, alpha)
                    if alpha == 0 then
                        RemoveBlip(call)
                        return
                    end
                end
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