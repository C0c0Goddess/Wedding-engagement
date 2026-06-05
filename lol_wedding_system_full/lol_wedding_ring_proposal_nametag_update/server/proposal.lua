local QBCore = exports['qb-core']:GetCoreObject()
local PendingProposals = {}

local function HasRing(Player)
    if Config.Inventory == 'ox' then
        local count = exports.ox_inventory:Search(Player.PlayerData.source, 'count', Config.Proposal.RequiredRing)
        return count and count > 0
    end

    return Player.Functions.GetItemByName(Config.Proposal.RequiredRing) ~= nil
end

local function RemoveRing(Player)
    if not Config.Proposal.RemoveRingOnProposal then return end

    if Config.Inventory == 'ox' then
        exports.ox_inventory:RemoveItem(Player.PlayerData.source, Config.Proposal.RequiredRing, 1)
    else
        Player.Functions.RemoveItem(Config.Proposal.RequiredRing, 1)
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[Config.Proposal.RequiredRing], 'remove')
    end
end

RegisterNetEvent('lol-weddings:server:proposeToPlayer', function(targetId)
    local src = source
    local Proposer = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(targetId)

    if not Proposer or not Target then
        TriggerClientEvent('QBCore:Notify', src, 'That player is not online.', 'error')
        return
    end

    if src == targetId then
        TriggerClientEvent('QBCore:Notify', src, 'You cannot propose to yourself.', 'error')
        return
    end

    local proposerCoords = GetEntityCoords(GetPlayerPed(src))
    local targetCoords = GetEntityCoords(GetPlayerPed(targetId))

    if #(proposerCoords - targetCoords) > Config.Proposal.AcceptDistance then
        TriggerClientEvent('QBCore:Notify', src, 'You are too far away from that person.', 'error')
        return
    end

    if not HasRing(Proposer) then
        TriggerClientEvent('QBCore:Notify', src, 'You need a diamond engagement ring to propose.', 'error')
        return
    end

    PendingProposals[targetId] = src

    local proposerName = Proposer.PlayerData.charinfo.firstname .. ' ' .. Proposer.PlayerData.charinfo.lastname

    TriggerClientEvent('lol-weddings:client:receiveProposal', targetId, src, proposerName)
    TriggerClientEvent('QBCore:Notify', src, 'Proposal sent. Waiting for their answer...', 'primary')
end)

RegisterNetEvent('lol-weddings:server:proposalAnswer', function(proposerId, accepted)
    local src = source

    if PendingProposals[src] ~= proposerId then
        TriggerClientEvent('QBCore:Notify', src, 'No active proposal found.', 'error')
        return
    end

    PendingProposals[src] = nil

    local Proposer = QBCore.Functions.GetPlayer(proposerId)
    local Target = QBCore.Functions.GetPlayer(src)

    if not Proposer or not Target then return end

    if not accepted then
        TriggerClientEvent('QBCore:Notify', proposerId, 'Your proposal was declined.', 'error')
        TriggerClientEvent('QBCore:Notify', src, 'You declined the proposal.', 'primary')
        return
    end

    RemoveRing(Proposer)

    MySQL.insert.await([[
        INSERT INTO marriages
        (citizenid1, citizenid2, status, shared_lastname, created_at)
        VALUES (?, ?, ?, ?, NOW())
    ]], {
        Proposer.PlayerData.citizenid,
        Target.PlayerData.citizenid,
        Config.Proposal.EngagementStatus,
        Proposer.PlayerData.charinfo.lastname
    })

    TriggerClientEvent('QBCore:Notify', proposerId, 'They said YES! You are now engaged.', 'success')
    TriggerClientEvent('QBCore:Notify', src, 'You accepted! You are now engaged.', 'success')
end)
