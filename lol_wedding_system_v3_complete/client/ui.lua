local QBCore = exports['qb-core']:GetCoreObject()

-- Auto-popup fix: UI is hidden when the resource/player loads.
CreateThread(function()
    Wait(1500)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'hide' })
end)

RegisterCommand(Config.Commands.WeddingPlanner, function()
    TriggerServerEvent('lol-weddings:server:getPlannerData')
end, false)

RegisterNetEvent('lol-weddings:client:openPlanner', function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        payload = data or {}
    })
end)

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'hide' })
    cb({})
end)

RegisterNUICallback('createPlan', function(data, cb)
    TriggerServerEvent('lol-weddings:server:createWeddingPlan', data)
    cb({ ok = true })
end)

RegisterNUICallback('bookVenue', function(data, cb)
    TriggerServerEvent('lol-weddings:server:bookVenue', data.venueId)
    cb({ ok = true })
end)

RegisterNUICallback('inviteGuest', function(data, cb)
    TriggerServerEvent('lol-weddings:server:inviteGuest', tonumber(data.playerId))
    cb({ ok = true })
end)

RegisterNUICallback('openSharedAccount', function(_, cb)
    TriggerServerEvent('lol-weddings:server:openSharedAccount')
    cb({ ok = true })
end)

RegisterNUICallback('depositShared', function(data, cb)
    TriggerServerEvent('lol-weddings:server:depositShared', tonumber(data.amount))
    cb({ ok = true })
end)

RegisterNUICallback('withdrawShared', function(data, cb)
    TriggerServerEvent('lol-weddings:server:withdrawShared', tonumber(data.amount))
    cb({ ok = true })
end)
