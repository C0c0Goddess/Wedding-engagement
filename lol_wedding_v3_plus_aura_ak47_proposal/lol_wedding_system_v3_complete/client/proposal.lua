local QBCore = exports['qb-core']:GetCoreObject()

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function FaceEntity(ped, targetPed)
    if not DoesEntityExist(ped) or not DoesEntityExist(targetPed) then return end

    local myCoords = GetEntityCoords(ped)
    local targetCoords = GetEntityCoords(targetPed)
    local heading = GetHeadingFromVector_2d(targetCoords.x - myCoords.x, targetCoords.y - myCoords.y)

    SetEntityHeading(ped, heading)
end

RegisterCommand(Config.Commands.Propose, function(_, args)
    local targetId = tonumber(args[1])

    if not targetId then
        QBCore.Functions.Notify('Usage: /propose [player id]', 'error')
        return
    end

    TriggerServerEvent('lol-weddings:server:proposeToPlayer', targetId)
end, false)

RegisterNetEvent('lol-weddings:client:playProposalEmote', function(targetServerId, role)
    if not Config.ProposalEmote or not Config.ProposalEmote.Enabled then return end

    local ped = PlayerPedId()
    local targetPlayer = GetPlayerFromServerId(targetServerId)

    if targetPlayer ~= -1 and Config.ProposalEmote.FacePartner then
        FaceEntity(ped, GetPlayerPed(targetPlayer))
    end

    if Config.ProposalEmote.FreezeDuringProposal then
        FreezeEntityPosition(ped, true)
    end

    if role == 'proposer' then
        LoadAnimDict(Config.ProposalEmote.ProposerAnimDict)
        TaskPlayAnim(
            ped,
            Config.ProposalEmote.ProposerAnimDict,
            Config.ProposalEmote.ProposerAnim,
            8.0,
            -8.0,
            Config.ProposalEmote.Duration,
            1,
            0,
            false,
            false,
            false
        )
    else
        LoadAnimDict(Config.ProposalEmote.PartnerAnimDict)
        TaskPlayAnim(
            ped,
            Config.ProposalEmote.PartnerAnimDict,
            Config.ProposalEmote.PartnerAnim,
            8.0,
            -8.0,
            Config.ProposalEmote.Duration,
            1,
            0,
            false,
            false,
            false
        )
    end

    Wait(Config.ProposalEmote.Duration)

    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
end)

RegisterNetEvent('lol-weddings:client:receiveProposal', function(proposerId, proposerName)
    local result = lib.alertDialog({
        header = '💍 Marriage Proposal',
        content = proposerName .. ' got down on one knee and is asking you to marry them. Do you accept?',
        centered = true,
        cancel = true,
        labels = {
            confirm = 'Accept',
            cancel = 'Decline'
        }
    })

    TriggerServerEvent('lol-weddings:server:proposalAnswer', proposerId, result == 'confirm')
end)
