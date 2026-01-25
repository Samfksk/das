local ESX = nil

local function loadESX()
    if ESX then
        return
    end

    if GetResourceState("es_extended") == "started" and exports["es_extended"] then
        ESX = exports["es_extended"]:getSharedObject()
        return
    end

    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
end

local function isAllowedGroup(group)
    for _, allowed in ipairs(Config.AllowedGroups) do
        if allowed == group then
            return true
        end
    end

    return false
end

local function notifyStaff(playerName)
    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer and isAllowedGroup(xPlayer.getGroup()) then
            TriggerClientEvent("discord-waiting-room:notify", playerId, playerName)
        end
    end
end

RegisterNetEvent("discord-waiting-room:waitingRoomJoin", function(playerName)
    if source ~= 0 then
        return
    end

    loadESX()

    if not ESX then
        print("[discord-waiting-room] ESX not found, cannot notify staff.")
        return
    end

    local name = playerName
    if type(name) ~= "string" or name == "" then
        name = "Okänd spelare"
    end

    notifyStaff(name)
end)

RegisterCommand("waitingroom", function(source, args)
    if source ~= 0 then
        return
    end

    local name = table.concat(args, " ")
    TriggerEvent("discord-waiting-room:waitingRoomJoin", name)
end, true)
