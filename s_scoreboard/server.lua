local QBCore = exports['qb-core']:GetCoreObject()

function BroadcastPlayerList()
    local players = QBCore.Functions.GetPlayers()
    local playerData = {}

    for _, playerId in pairs(players) do
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            table.insert(playerData, {
                id = playerId,
                name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                job = Player.PlayerData.job.name
            })
        end
    end

    for _, playerId in pairs(players) do
        TriggerClientEvent('scoreboard:updatePlayers', playerId, playerData)
    end
end

CreateThread(function()
    while true do
        Wait(1000)
        BroadcastPlayerList()
    end
end)
