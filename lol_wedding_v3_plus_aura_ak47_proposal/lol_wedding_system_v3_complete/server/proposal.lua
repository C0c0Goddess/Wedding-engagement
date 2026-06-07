local PendingProposals = {}

RegisterNetEvent('lol-weddings:server:proposeToPlayer', function(targetId)
    local src = source
    local Proposer = GetPlayerBySource(src)
    local Target = GetPlayerBySource(targetId)
    if not Proposer or not Target then TriggerClientEvent('QBCore:Notify', src, 'That player is not online.', 'error') return end
    if src == targetId then TriggerClientEvent('QBCore:Notify', src, 'You cannot propose to yourself.', 'error') return end

    local proposerCoords = GetEntityCoords(GetPlayerPed(src))
    local targetCoords = GetEntityCoords(GetPlayerPed(targetId))
    if #(proposerCoords - targetCoords) > Config.Proposal.AcceptDistance then TriggerClientEvent('QBCore:Notify', src, 'You are too far away from that person.', 'error') return end
    if not HasItem(src, Config.Proposal.RequiredRing) then TriggerClientEvent('QBCore:Notify', src, 'You need a diamond engagement ring to propose.', 'error') return end

    PendingProposals[targetId] = src
    local proposerName = Proposer.PlayerData.charinfo.firstname .. ' ' .. Proposer.PlayerData.charinfo.lastname

    -- Force GTA-style proposal emote scene.
    TriggerClientEvent('lol-weddings:client:playProposalEmote', src, targetId, 'proposer')
    TriggerClientEvent('lol-weddings:client:playProposalEmote', targetId, src, 'partner')

    -- Delay the accept/decline prompt until the kneeling proposal animation has started.
    SetTimeout(Config.ProposalEmote and Config.ProposalEmote.Duration or 6500, function()
        TriggerClientEvent('lol-weddings:client:receiveProposal', targetId, src, proposerName)
    end)

    TriggerClientEvent('QBCore:Notify', src, 'Proposal sent. Waiting for their answer...', 'primary')
end)

RegisterNetEvent('lol-weddings:server:proposalAnswer', function(proposerId, accepted)
    local src = source
    if PendingProposals[src] ~= proposerId then TriggerClientEvent('QBCore:Notify', src, 'No active proposal found.', 'error') return end
    PendingProposals[src] = nil

    local Proposer = GetPlayerBySource(proposerId)
    local Target = GetPlayerBySource(src)
    if not Proposer or not Target then return end

    if not accepted then
        TriggerClientEvent('QBCore:Notify', proposerId, 'Your proposal was declined.', 'error')
        TriggerClientEvent('QBCore:Notify', src, 'You declined the proposal.', 'primary')
        return
    end

    if Config.Proposal.RemoveRingOnProposal then RemoveItem(proposerId, Config.Proposal.RequiredRing, 1) end

    MySQL.insert.await([[INSERT INTO marriages (citizenid1, citizenid2, status, shared_lastname, created_at) VALUES (?, ?, ?, ?, NOW())]], {
        Proposer.PlayerData.citizenid, Target.PlayerData.citizenid, Config.Proposal.EngagementStatus, Proposer.PlayerData.charinfo.lastname
    })

    SendWeddingLog('New Engagement', Proposer.PlayerData.charinfo.firstname .. ' proposed to ' .. Target.PlayerData.charinfo.firstname)
    TriggerClientEvent('QBCore:Notify', proposerId, 'They said YES! You are now engaged.', 'success')
    TriggerClientEvent('QBCore:Notify', src, 'You accepted! You are now engaged.', 'success')
end)
