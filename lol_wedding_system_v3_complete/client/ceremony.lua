local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand(Config.Commands.StartCeremony, function(_, args)
    local targetId = tonumber(args[1])

    if not targetId then
        QBCore.Functions.Notify('Usage: /startceremony [player id]', 'error')
        return
    end

    TriggerServerEvent('lol-weddings:server:startCeremony', targetId)
end, false)

RegisterNetEvent('lol-weddings:client:playCeremony', function(partnerName)
    local ped = PlayerPedId()

    QBCore.Functions.Notify('Wedding ceremony started with ' .. partnerName .. '.', 'primary')

    RequestAnimDict('anim@mp_player_intcelebrationfemale@blow_kiss')
    while not HasAnimDictLoaded('anim@mp_player_intcelebrationfemale@blow_kiss') do Wait(10) end

    TaskPlayAnim(ped, 'anim@mp_player_intcelebrationfemale@blow_kiss', 'blow_kiss', 8.0, -8.0, Config.Ceremony.Duration, 49, 0, false, false, false)

    Wait(Config.Ceremony.Duration)
    ClearPedTasks(ped)
end)
