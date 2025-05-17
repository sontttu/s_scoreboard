local display = false
local players = {}

function SetDisplay(bool)
    display = bool
    SetNuiFocus(false, false) 
    SendNUIMessage({
        type = "ui",
        display = bool
    })
    if bool then
        TriggerServerEvent('scoreboard:getPlayers')
    end
end

RegisterNetEvent('scoreboard:updatePlayers')
AddEventHandler('scoreboard:updatePlayers', function(playerList)
    players = playerList
    SendNUIMessage({
        type = "players",
        players = players
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 178) then 
            SetDisplay(not display)
        end
    end
end)
