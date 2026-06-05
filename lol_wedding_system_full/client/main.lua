local Framework = exports['qb-core']:GetCoreObject()

RegisterCommand('weddingplanner', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openPlanner'
    })
end)

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNetEvent('lol-weddings:client:openVenueMenu', function()
    print('Opening wedding venue selection')
end)

RegisterNetEvent('lol-weddings:client:startCeremony', function(data)
    print('Ceremony started for', data.couple)
end)
