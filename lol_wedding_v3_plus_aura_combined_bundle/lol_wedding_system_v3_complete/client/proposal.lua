local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand(Config.Commands.Propose, function(_, args)
    local targetId = tonumber(args[1])
    if not targetId then
        QBCore.Functions.Notify('Usage: /propose [player id]', 'error')
        return
    end
    TriggerServerEvent('lol-weddings:server:proposeToPlayer', targetId)
end, false)

RegisterNetEvent('lol-weddings:client:receiveProposal', function(proposerId, proposerName)
    local result = lib.alertDialog({
        header = '💍 Marriage Proposal',
        content = proposerName .. ' is asking you to marry them. Do you accept?',
        centered = true,
        cancel = true,
        labels = { confirm = 'Accept', cancel = 'Decline' }
    })

    TriggerServerEvent('lol-weddings:server:proposalAnswer', proposerId, result == 'confirm')
end)
