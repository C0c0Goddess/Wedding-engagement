local function FindShopItem(item)
    for _, entry in pairs(Config.RingShop.items) do
        if entry.item == item then return entry end
    end
    return nil
end

RegisterNetEvent('lol-weddings:server:buyRing', function(item)
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end

    local entry = FindShopItem(item)

    if not entry then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid shop item.', 'error')
        return
    end

    if GetMoney(src, 'bank') < entry.price then
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money in bank.', 'error')
        return
    end

    RemoveMoney(src, 'bank', entry.price, 'wedding-shop-purchase')
    AddItem(src, entry.item, 1)

    TriggerClientEvent('QBCore:Notify', src, 'Purchased ' .. entry.label .. '.', 'success')
end)
