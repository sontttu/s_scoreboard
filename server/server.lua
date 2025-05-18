local Framework = nil
local isQBCore = false

if GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
    isQBCore = true
elseif GetResourceState('es_extended') == 'started' then
    Framework = exports['es_extended']:getSharedObject()
end

RegisterNetEvent('scoreboard:getPlayers', function()
    local src = source
    local playerData = {}

    if isQBCore then
        local players = Framework.Functions.GetPlayers()
        for _, playerId in pairs(players) do
            local Player = Framework.Functions.GetPlayer(playerId)
            if Player then
                table.insert(playerData, {
                    id = playerId,
                    name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                    job = Player.PlayerData.job.name
                })
            end
        end
    else
        for _, playerId in ipairs(GetPlayers()) do
            local xPlayer = Framework.GetPlayerFromId(tonumber(playerId))
            if xPlayer then
                local name = GetPlayerName(playerId)
                local job = xPlayer.job and xPlayer.job.name or "unknown"
                table.insert(playerData, {
                    id = tonumber(playerId),
                    name = name,
                    job = job
                })
            end
        end
    end

    TriggerClientEvent('scoreboard:updatePlayers', src, playerData)
end)
