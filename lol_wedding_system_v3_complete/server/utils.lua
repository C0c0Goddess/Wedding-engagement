QBCore = exports['qb-core']:GetCoreObject()

function GetPlayerBySource(src)
    return QBCore.Functions.GetPlayer(src)
end

function AddItem(src, item, amount)
    local Player = GetPlayerBySource(src)
    if not Player then return false end

    if Config.Inventory == 'ox' then
        return exports.ox_inventory:AddItem(src, item, amount or 1)
    end

    Player.Functions.AddItem(item, amount or 1)
    return true
end

function RemoveItem(src, item, amount)
    local Player = GetPlayerBySource(src)
    if not Player then return false end

    if Config.Inventory == 'ox' then
        return exports.ox_inventory:RemoveItem(src, item, amount or 1)
    end

    return Player.Functions.RemoveItem(item, amount or 1)
end

function HasItem(src, item)
    local Player = GetPlayerBySource(src)
    if not Player then return false end

    if Config.Inventory == 'ox' then
        local count = exports.ox_inventory:Search(src, 'count', item)
        return count and count > 0
    end

    return Player.Functions.GetItemByName(item) ~= nil
end

function GetMoney(src, account)
    local Player = GetPlayerBySource(src)
    if not Player then return 0 end
    return Player.PlayerData.money[account or 'bank'] or 0
end

function RemoveMoney(src, account, amount, reason)
    local Player = GetPlayerBySource(src)
    if not Player then return false end
    return Player.Functions.RemoveMoney(account or 'bank', amount, reason or 'wedding-system')
end
