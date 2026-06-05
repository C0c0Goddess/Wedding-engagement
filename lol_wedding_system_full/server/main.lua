local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('lol-weddings:server:createMarriageLicense', function(partnerId)
    local src = source
    print(('Marriage license requested by %s for %s'):format(src, partnerId))
end)

RegisterNetEvent('lol-weddings:server:updateLastName', function(newName)
    local src = source
    print(('Player %s changed last name to %s'):format(src, newName))
end)

RegisterNetEvent('lol-weddings:server:createWeddingPlan', function(data)
    local src = source
    print(('Wedding plan created by %s'):format(src))
end)
