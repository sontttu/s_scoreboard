local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('scoreboard:getPlayers', function()
    local src = source
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

    TriggerClientEvent('scoreboard:updatePlayers', src, playerData)
end)
