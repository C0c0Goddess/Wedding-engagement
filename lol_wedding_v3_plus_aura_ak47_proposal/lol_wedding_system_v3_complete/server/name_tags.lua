local function GetPrefix(charinfo)
    if charinfo.gender == 1 or charinfo.gender == 'female' then return 'Mrs.' end
    return 'Mr.'
end

RegisterNetEvent('lol-weddings:server:requestMarriageTags', function(serverIds)
    local src = source
    local response = {}
    if type(serverIds) ~= 'table' then return end
    for _, id in pairs(serverIds) do
        local targetId = tonumber(id)
        local Player = GetPlayerBySource(targetId)
        if Player then
            local citizenid = Player.PlayerData.citizenid
            local charinfo = Player.PlayerData.charinfo
            local marriage = MySQL.single.await([[SELECT shared_lastname, status FROM marriages WHERE (citizenid1 = ? OR citizenid2 = ?) AND status = 'married' LIMIT 1]], { citizenid, citizenid })
            if marriage then
                local lastName = marriage.shared_lastname
                if not lastName or lastName == '' then lastName = charinfo.lastname end
                response[tostring(targetId)] = GetPrefix(charinfo) .. ' ' .. lastName
            end
        end
    end
    TriggerClientEvent('lol-weddings:client:receiveMarriageTags', src, response)
end)
